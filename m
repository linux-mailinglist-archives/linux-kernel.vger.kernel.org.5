Return-Path: <linux-kernel+bounces-21910-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D683282967D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 498881F226E2
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA8B3F8CD;
	Wed, 10 Jan 2024 09:45:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="wW0951aF"
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2086.outbound.protection.outlook.com [40.107.244.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4D5D3EA91;
	Wed, 10 Jan 2024 09:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=PiV68bn7jQihaEi1KDBskL+6psaXPD3rITXqfs0MiLFdS/CcJGiLfBZXSCPLWe/BLGXA7eMieqE2SEZaQeFngojgb+MJhReALDf1twwSl24pFWTWnaeiwZqONAAgXFeZIoTiB+T+zo4YAygn0FOlAGtlOrkAz9g/WJYsjTMFSv3lldW7fTDKoXh8BQMfckKcH+rIb6YI8nTzerpbPT9LCQsJfJB74sVCq44MhKUPVPy6w/TqvnvDx2cGT4VLlUO3ThtZWRktDjeHQWsHQUVjWMHqRcADxRmaMJzybr+6AHn0X+uCTR/hMPbktJz8gqqclh8ZYkSC/zMPFTfhQ5jt1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zC5WRwtu6+qO+9CXnFzJPWrGYlpkczne7vfVG5jg8k=;
 b=GO9e/YI/gmsTigY8JlL7s+79QdeUHfPI5e5LDURr+7bbtKDRBPdVyNYT8QOwGUSeiYvIKNa5ZtI5PzioEBWK1mLIoEU8F0fOourX/QrF+XYjsT/ONGLiObrk9cou4kFK/q9Cv4Jo1lJLNSxZDVIHuvkgR0QWU4Huw/uI0WAeUelTt8kR9JB6yDSGQkOe+P3LHz/9abKfumygj95RKOGuO6DGYs41jWwgyjE+rQRG7v8Bk+pIiY+FzxMb//aNaWuqTW2lwpQIfvf8O1QKBg+znSZBPdi0IJVEAF6u6qBfMkyYDk+VXmjpi/pAFpXSwtbuoJ122iMO3ovy7zd54JcM0A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zC5WRwtu6+qO+9CXnFzJPWrGYlpkczne7vfVG5jg8k=;
 b=wW0951aFk3TgpockNYd7ZRSr0wxwcWQYgB79N7UwMZH+5GuhNgo7+eNaLjc1KPkJWquwd7raN/o3QCH8PBG/CQnwBbuYut+iHEJARIxAtMevnX663ladqqdULoeC8CAfx+3Xw3w//QPfC6pwgNr8HF/Vk/CJiYq2hdEJ5wa0XKs=
Received: from SN6PR05CA0006.namprd05.prod.outlook.com (2603:10b6:805:de::19)
 by DM4PR12MB5796.namprd12.prod.outlook.com (2603:10b6:8:63::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 09:45:46 +0000
Received: from SA2PEPF00001506.namprd04.prod.outlook.com
 (2603:10b6:805:de:cafe::a9) by SN6PR05CA0006.outlook.office365.com
 (2603:10b6:805:de::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7181.18 via Frontend
 Transport; Wed, 10 Jan 2024 09:45:46 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001506.mail.protection.outlook.com (10.167.242.38) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 09:45:46 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 03:45:41 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Wed, 10 Jan 2024 03:45:36 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <yung-chuan.liao@linux.intel.com>,
	<pierre-louis.bossart@linux.intel.com>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <vinod.koul@intel.com>,
	<venkataprasad.potturu@amd.com>, Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
	Liam Girdwood <lgirdwood@gmail.com>, Peter Ujfalusi
	<peter.ujfalusi@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, V sujith kumar Reddy
	<Vsujithkumar.Reddy@amd.com>, Mastan Katragadda <Mastan.Katragadda@amd.com>,
	"moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS"
	<sound-open-firmware@alsa-project.org>, "open list:SOUND - SOC LAYER /
 DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, open list
	<linux-kernel@vger.kernel.org>
Subject: [PATCH V2 07/13] ASoC: SOF: amd: add code for invoking soundwire manager helper functions
Date: Wed, 10 Jan 2024 15:14:10 +0530
Message-ID: <20240110094416.853610-8-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110094416.853610-1-Vijendar.Mukunda@amd.com>
References: <20240110094416.853610-1-Vijendar.Mukunda@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SA2PEPF00001506:EE_|DM4PR12MB5796:EE_
X-MS-Office365-Filtering-Correlation-Id: e8f55c23-fc6f-4a73-8b1d-08dc11c0eb81
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	eCisJIHdX/SUSY29y1xymO+O7sCW0RtODA41wV7WBR9egvwyMkE8IsUZddeyY5kzifIObv3e+hcAT5Nbnjmlyq4yXm6YV1g7LPQOEpYEaTPbdqSvCBumoA7Pos7T5/cSOyxUgetxb/Gv9tec85a+m7YdqJUWxmwmwERNR2CyQr7nGHLmZxoM8pzXuQHx44ijlJB1LHtKKHiOrTXOdk7dtELykAyIs51wzCaxVN3GNatLktYYXugXmXGdcxfGgIgXnUQbI3dZcVwzTRYTLF3hVGK5N4+EypVQQh//RP0axYRjfAEUfeCVEENMWGAU3FfArIFFVRcNl3JsImGKYVBLlY0y9u5brDYg/36d68k+3hcgBa8xMQV3F6eUavaEG41C5x+gsQ7FwGzvwkVcjtwncOz7aL4sYAKlic4sEnn7fXE/y2RmkqSsZP2jAjvE5+WmL0ZUuVABk7Cokbydk59lEGQgIA9AkNeCPigsn5C1NvNsP7m7ToR986lR+ZiQsbwCwSdxltAFUidy3d/t3sIbHbkGdVfpkJ3Fs/E7SvufFioWzbq2eLt95af9Q+KpIQlrFxz4Cm4oRH9HnTVm61Bj2ZAcncD+m6nb9AEtKC9raOTbDoFNoDqqDDQxs7pFtrZOx73DHVE/vRdEp7fabfUrRd/CARuC8w6nCNlOf275xNw97L1pSVAnPdSKCwyxqs8N+GwAPkXslSr5n6JVzxS5tcU7WX/ugUsM03WvlxVrwT2QlwG4vLvaeOb16KrmMdRyfuaqB1iahFcc7mNFShlOjw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(396003)(346002)(39860400002)(136003)(230922051799003)(451199024)(186009)(82310400011)(64100799003)(1800799012)(40470700004)(46966006)(36840700001)(83380400001)(26005)(336012)(426003)(2616005)(82740400003)(47076005)(1076003)(36860700001)(4326008)(8676002)(8936002)(7416002)(5660300002)(2906002)(7696005)(6666004)(478600001)(54906003)(316002)(110136005)(70586007)(41300700001)(70206006)(81166007)(356005)(36756003)(86362001)(40480700001)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:45:46.1671
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e8f55c23-fc6f-4a73-8b1d-08dc11c0eb81
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001506.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5796

Add code for invoking Soundwire manager helper functions
when SoundWire configuration is selected.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/Kconfig | 17 +++++++
 sound/soc/sof/amd/acp.c   | 99 ++++++++++++++++++++++++++++++++++++++-
 sound/soc/sof/amd/acp.h   | 15 +++++-
 3 files changed, 129 insertions(+), 2 deletions(-)

diff --git a/sound/soc/sof/amd/Kconfig b/sound/soc/sof/amd/Kconfig
index 19c5e27a193f..1cea1d75130c 100644
--- a/sound/soc/sof/amd/Kconfig
+++ b/sound/soc/sof/amd/Kconfig
@@ -60,6 +60,23 @@ config SND_SOC_SOF_ACP_PROBES
 	  This option is not user-selectable but automatically handled by
 	  'select' statements at a higher level
 
+config SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE
+	tristate
+	select SOUNDWIRE_AMD if SND_SOC_SOF_AMD_SOUNDWIRE != n
+	select SND_AMD_SOUNDWIRE_ACPI if ACPI
+
+config SND_SOC_SOF_AMD_SOUNDWIRE
+	tristate "SOF support for SoundWire based AMD platforms"
+	default SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE
+	depends on SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE
+	depends on ACPI && SOUNDWIRE
+	depends on !(SOUNDWIRE=m && SND_SOC_SOF_AMD_SOUNDWIRE_LINK_BASELINE=y)
+	help
+	  This adds support for SoundWire with Sound Open Firmware
+	  for AMD platforms.
+	  Say Y if you want to enable SoundWire links with SOF.
+	  If unsure select "N".
+
 config SND_SOC_SOF_AMD_ACP63
 	tristate "SOF support for ACP6.3 platform"
 	depends on SND_SOC_SOF_PCI
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 32a741fcb84f..f24cd6b7490f 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -491,6 +491,81 @@ int amd_sof_acp_resume(struct snd_sof_dev *sdev)
 }
 EXPORT_SYMBOL_NS(amd_sof_acp_resume, SND_SOC_SOF_AMD_COMMON);
 
+#if IS_ENABLED(CONFIG_SND_SOC_SOF_AMD_SOUNDWIRE)
+static int acp_sof_scan_sdw_devices(struct snd_sof_dev *sdev, u64 addr)
+{
+	struct acpi_device *sdw_dev;
+	struct acp_dev_data *acp_data;
+	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
+
+	if (!addr)
+		return -ENODEV;
+
+	acp_data = sdev->pdata->hw_pdata;
+	sdw_dev = acpi_find_child_device(ACPI_COMPANION(sdev->dev), addr, 0);
+	if (!sdw_dev)
+		return -ENODEV;
+
+	acp_data->info.handle = sdw_dev->handle;
+	acp_data->info.count = desc->sdw_max_link_count;
+
+	return amd_sdw_scan_controller(&acp_data->info);
+}
+
+static int amd_sof_sdw_probe(struct snd_sof_dev *sdev)
+{
+	struct acp_dev_data *acp_data;
+	struct sdw_amd_res sdw_res;
+	int ret;
+
+	acp_data = sdev->pdata->hw_pdata;
+
+	memset(&sdw_res, 0, sizeof(sdw_res));
+	sdw_res.addr = acp_data->addr;
+	sdw_res.reg_range = acp_data->reg_range;
+	sdw_res.handle = acp_data->info.handle;
+	sdw_res.parent = sdev->dev;
+	sdw_res.dev = sdev->dev;
+	sdw_res.acp_lock = &acp_data->acp_lock;
+	sdw_res.count = acp_data->info.count;
+	sdw_res.link_mask = acp_data->info.link_mask;
+	sdw_res.mmio_base = sdev->bar[ACP_DSP_BAR];
+
+	ret = sdw_amd_probe(&sdw_res, &acp_data->sdw);
+	if (ret)
+		dev_err(sdev->dev, "SoundWire probe failed\n");
+	return ret;
+}
+
+static int amd_sof_sdw_exit(struct snd_sof_dev *sdev)
+{
+	struct acp_dev_data *acp_data;
+
+	acp_data = sdev->pdata->hw_pdata;
+	if (acp_data->sdw)
+		sdw_amd_exit(acp_data->sdw);
+	acp_data->sdw = NULL;
+
+	return 0;
+}
+
+#else
+static int acp_sof_scan_sdw_devices(struct snd_sof_dev *sdev, u64 addr)
+{
+	return 0;
+}
+
+static int amd_sof_sdw_probe(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+
+static int amd_sof_sdw_exit(struct snd_sof_dev *sdev)
+{
+	return 0;
+}
+#endif
+
 int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 {
 	struct pci_dev *pci = to_pci_dev(sdev->dev);
@@ -527,7 +602,9 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	}
 
 	pci_set_master(pci);
-
+	adata->addr = addr;
+	adata->reg_range = chip->reg_end_addr - chip->reg_start_addr;
+	mutex_init(&adata->acp_lock);
 	sdev->pdata->hw_pdata = adata;
 	adata->smn_dev = pci_get_device(PCI_VENDOR_ID_AMD, chip->host_bridge_id, NULL);
 	if (!adata->smn_dev) {
@@ -549,6 +626,21 @@ int amd_sof_acp_probe(struct snd_sof_dev *sdev)
 	if (ret < 0)
 		goto free_ipc_irq;
 
+	/* scan SoundWire capabilities exposed by DSDT */
+	ret = acp_sof_scan_sdw_devices(sdev, chip->sdw_acpi_dev_addr);
+	if (ret < 0) {
+		dev_dbg(sdev->dev, "skipping SoundWire, not detected with ACPI scan\n");
+		goto skip_soundwire;
+	}
+	ret = amd_sof_sdw_probe(sdev);
+	if (ret < 0) {
+		dev_err(sdev->dev, "error: SoundWire probe error\n");
+		free_irq(sdev->ipc_irq, sdev);
+		pci_dev_put(adata->smn_dev);
+		return ret;
+	}
+
+skip_soundwire:
 	sdev->dsp_box.offset = 0;
 	sdev->dsp_box.size = BOX_SIZE_512;
 
@@ -596,6 +688,9 @@ void amd_sof_acp_remove(struct snd_sof_dev *sdev)
 	if (adata->smn_dev)
 		pci_dev_put(adata->smn_dev);
 
+	if (adata->sdw)
+		amd_sof_sdw_exit(sdev);
+
 	if (sdev->ipc_irq)
 		free_irq(sdev->ipc_irq, sdev);
 
@@ -607,4 +702,6 @@ void amd_sof_acp_remove(struct snd_sof_dev *sdev)
 EXPORT_SYMBOL_NS(amd_sof_acp_remove, SND_SOC_SOF_AMD_COMMON);
 
 MODULE_DESCRIPTION("AMD ACP sof driver");
+MODULE_IMPORT_NS(SOUNDWIRE_AMD_INIT);
+MODULE_IMPORT_NS(SND_AMD_SOUNDWIRE_ACPI);
 MODULE_LICENSE("Dual BSD/GPL");
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index c645aee216fd..e88d01330ec7 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -12,7 +12,7 @@
 #define __SOF_AMD_ACP_H
 
 #include <linux/dmi.h>
-
+#include <linux/soundwire/sdw_amd.h>
 #include "../sof-priv.h"
 #include "../sof-audio.h"
 
@@ -191,6 +191,10 @@ struct sof_amd_acp_desc {
 	u32 acp_clkmux_sel;
 	u32 fusion_dsp_offset;
 	u32 probe_reg_offset;
+	u32 reg_start_addr;
+	u32 reg_end_addr;
+	u32 sdw_max_link_count;
+	u64 sdw_acpi_dev_addr;
 };
 
 /* Common device data struct for ACP devices */
@@ -199,6 +203,12 @@ struct acp_dev_data {
 	const struct firmware *fw_dbin;
 	/* DMIC device */
 	struct platform_device *dmic_dev;
+	/* mutex lock to protect ACP common registers access */
+	struct mutex acp_lock;
+	/* ACPI information stored between scan and probe steps */
+	struct sdw_amd_acpi_info info;
+	/* sdw context allocated by SoundWire driver */
+	struct sdw_amd_ctx *sdw;
 	unsigned int fw_bin_size;
 	unsigned int fw_data_bin_size;
 	unsigned int fw_sram_data_bin_size;
@@ -207,6 +217,9 @@ struct acp_dev_data {
 	const char *fw_sram_data_bin;
 	u32 fw_bin_page_count;
 	u32 fw_data_bin_page_count;
+	u32 addr;
+	u32 reg_range;
+	u32 blk_type;
 	dma_addr_t sha_dma_addr;
 	u8 *bin_buf;
 	dma_addr_t dma_addr;
-- 
2.34.1


