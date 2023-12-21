Return-Path: <linux-kernel+bounces-7945-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE5181AF89
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:38:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F2041C23308
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:38:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E8E11802F;
	Thu, 21 Dec 2023 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="qbDmbI1P"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B49D4156F4;
	Thu, 21 Dec 2023 07:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=D4ZynnNxe3S5IW0N+2X4YAkw0qJ5AOA9HFMIgPErfEzxmpHudjkDk/V9SR87thhsAzyfzKc1PpiviHOIgjcHvCe85ttoTv0SRdcmweghjFb+GsWahK0ELdX8FIFR2UtDIvtmLqaCQjiEtLh0LJtu6wka4upsHg6cG2lS8DU+nKbOtqg1CNA+/VQcYE3pKUpkwbzmxS9svKvMlCjbkR1tcleOZBeGb9TllwY1RL4dOIBO6UYDoNUl1vHkG8B2blBeuuHhu8FHPZxzS4kkS6NoWCFyAiqCY0rnxi2j+6JsQl77jPxSMhkEQ7+LhvRLk9lTS+LZuyVM7U8VzTd0C4aykw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1zC5WRwtu6+qO+9CXnFzJPWrGYlpkczne7vfVG5jg8k=;
 b=QyU0OT3n1NI2ljX24auyS0cIE4UtY9zSBhs7oJWmCgDTHtKjxm4EV75exYCc0PYifXwWMaXL8NsPFrQX6Cg97y3bEAxtK88smXPryn6inR3XrTB7tLgTsCn8rf8xDGY7wL0QX11AVsd9MjrPPLbUfRRAQDyQ8bBoQ45cHRtJElSIVBLcSk87NO+vp4eSJGAZdxGt1FsnvBOICVXmgzzSngg7GD++zC+Djw298mddS62HSiNFZLg1VoFvwhjdbXuFePQnlmLFhk/j/CNwf7x+au0gAwxl5TrVsJ9f2po20nbagHE3rfpZmX22RmejMvdYLefGr0EOkEQ39Uyg9+dv6Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1zC5WRwtu6+qO+9CXnFzJPWrGYlpkczne7vfVG5jg8k=;
 b=qbDmbI1PcKJn+0wEM0tjVs9bUF2d17Y6d2QZGx+4Zp1RVJ2kaCqeWPn1JbHCaEraxYjvdB8dr+uh6JLn7Q67OvHblLHnskEA1WSNbtBTf6YzbgJtZoSCJjCprfYwrjFuojQk+SVU3Ms7GZVCDZw+kYcTxkWKT8bpo2T8kkl48X0=
Received: from MW4P221CA0011.NAMP221.PROD.OUTLOOK.COM (2603:10b6:303:8b::16)
 by CYXPR12MB9441.namprd12.prod.outlook.com (2603:10b6:930:dc::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.21; Thu, 21 Dec
 2023 07:37:10 +0000
Received: from CO1PEPF000044F9.namprd21.prod.outlook.com
 (2603:10b6:303:8b:cafe::af) by MW4P221CA0011.outlook.office365.com
 (2603:10b6:303:8b::16) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18 via Frontend
 Transport; Thu, 21 Dec 2023 07:37:09 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CO1PEPF000044F9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.18 via Frontend Transport; Thu, 21 Dec 2023 07:37:09 +0000
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 01:37:06 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Thu, 21 Dec 2023 01:37:00 -0600
From: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To: <broonie@kernel.org>, <vkoul@kernel.org>
CC: <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
	<Sunil-kumar.Dommati@amd.com>, <pierre-louis.bossart@linux.intel.com>,
	<vinod.koul@intel.com>, <venkataprasad.potturu@amd.com>, Vijendar Mukunda
	<Vijendar.Mukunda@amd.com>, Liam Girdwood <lgirdwood@gmail.com>, "Peter
 Ujfalusi" <peter.ujfalusi@linux.intel.com>, Bard Liao
	<yung-chuan.liao@linux.intel.com>, Ranjani Sridharan
	<ranjani.sridharan@linux.intel.com>, Daniel Baluta <daniel.baluta@nxp.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>, Jaroslav Kysela
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, V sujith kumar Reddy
	<Vsujithkumar.Reddy@amd.com>, Mastan Katragadda <Mastan.Katragadda@amd.com>,
	Rander Wang <rander.wang@intel.com>, "moderated list:SOUND - SOUND OPEN
 FIRMWARE (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>, "open
 list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..."
	<linux-sound@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 06/12] ASoC: SOF: amd: add code for invoking soundwire manager helper functions
Date: Thu, 21 Dec 2023 13:05:52 +0530
Message-ID: <20231221073558.3181911-7-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
References: <20231221073558.3181911-1-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CO1PEPF000044F9:EE_|CYXPR12MB9441:EE_
X-MS-Office365-Filtering-Correlation-Id: be8c48d1-3219-47e4-2744-08dc01f7a3fe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	XXhC2YtbLZzv4semc72s98UUNH9rwA10zDLk2S1VZLKopXlU3T8iSM4vQFyf4Q3kTExowrHkP4FLMzJ2JAjO+y+3CS1rhIJbG0NDAm7cTEFkapkvJ71JLemlj4/6lDE9WwmwFpoBZvVhYAKNTnsiC4GNeAk9OrVUxSJpgjjOGLRVoMb51ADO3Dz0LSu9WjUIwGW6zCdFCvMcqHi0dEeb7I0YQCAzE4QLBuCRASDxU6h/vKaDZIS8rtQsPfAFlN9br+accJBqgey5qiHB3ggzS6an7E0EQq324TBq09eak+Cc6sR9O5IK6WLhaItS/6XIQS6bl8m9BqN+j3CGssd7WB+pF0QOCfUOWl+au7/t6ZuGY8E3Z8lhj8X6PEUS2KI45QS2ckYFHb3dWFqudGWw44MeqoAEmaKsScE1P9LbS4qgaYgBlMyrgOq7AxpZjM6mDXpj/1G4R0zAXLM3NL5QJt0UH1dmC25UuL0mM2nMrnNKDlkNFa6nKg83P3jgXhFpnTN3b4+cMQyz895fvKbyMRoW6fyH2oQ0Q1lkFD47ku8ZfXGfkvoOdFjB15l9Vqw+wWj53ttILqQCm6DpgBIC2mi3pMAXVdRSha5eopwgv3jkf28c1UneCvhmvV7OAhIgy/I5F8qw1eiXLA+/3g5IQimAcU3jEW5ll97sW5EBVw6qL3nEtLSLSDz2tSez9tzo2r4d6WT9nSQw9Rho0pPTmNdXSWK2wlC0yATpkyegAuK7MbCEHlUUD3XgfNweCz8iXru9zFcwF1FsWe2oY7Rkfw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(376002)(136003)(39860400002)(396003)(346002)(230922051799003)(186009)(451199024)(1800799012)(82310400011)(64100799003)(46966006)(40470700004)(36840700001)(1076003)(2616005)(7696005)(426003)(336012)(83380400001)(26005)(86362001)(4326008)(8676002)(8936002)(41300700001)(2906002)(5660300002)(36756003)(7416002)(110136005)(70586007)(316002)(54906003)(70206006)(6666004)(478600001)(47076005)(81166007)(36860700001)(40480700001)(82740400003)(356005)(40460700003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 07:37:09.8097
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: be8c48d1-3219-47e4-2744-08dc01f7a3fe
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CO1PEPF000044F9.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9441

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


