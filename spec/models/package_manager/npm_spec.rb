require 'rails_helper'

describe PackageManager::NPM do
  let(:project) { create(:project, name: 'foo', platform: described_class.name) }

  it 'has formatted name of "npm"' do
    expect(described_class.formatted_name).to eq('npm')
  end

  describe '#package_link' do
    it 'returns a link to project website' do
      expect(described_class.package_link(project)).to eq("https://www.npmjs.com/package/foo")
    end

    it 'ignores version' do
      expect(described_class.package_link(project, '2.0.0')).to eq("https://www.npmjs.com/package/foo")
    end
  end

  describe 'download_url' do
    it 'returns a link to project tarball' do
      expect(described_class.download_url('foo', '1.0.0')).to eq("https://registry.npmjs.org/foo/-/foo-1.0.0.tgz")
    end
  end

  describe '#install_instructions' do
    it 'returns a command to install the project' do
      expect(described_class.install_instructions(project)).to eq("npm install foo")
    end

    it 'handles version' do
      expect(described_class.install_instructions(project, '2.0.0')).to eq("npm install foo@2.0.0")
    end
  end
end
