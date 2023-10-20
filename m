Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D5C7D0878
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 08:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346966AbjJTG3d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 02:29:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376341AbjJTG3a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 02:29:30 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2045.outbound.protection.outlook.com [40.107.243.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CD662D5F
        for <linux-kernel@vger.kernel.org>; Thu, 19 Oct 2023 23:29:26 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TPM/luenBvayCvjd3obJJgza5ZvY91H6GxwKqC9RH+zfp0INAIbT4SKUFyZy1yGnj+wdD2ZIURaROCV5pG5VQm2LmPuikopt5v/6XdTaskwIUJucMvHVpeeU1ZgpS12YfE3tDrwsraDU7ZLCbjx5vSE6XdfXEDjoKHDL3Eddbc9oKCKvsAG5AOc4iBuoM+gTiZIqO+X1PoGgJaBY6AeFVBbrJjkWfbE1/CAy6aEbyDJ34xM5x/ht7mXlIn7xnntOZocCWBeWBYIex3bnWC3PIExPccEPlKK7GoByLcSfa2BeU7F2hfcjEpwgAX5tIPcOpfKE07gqO4epIRCVhxEGOg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=64IlTLk9U7H3EHFVzimSbXahkhzsdMO0mNXW/M+XRUw=;
 b=CcbIHpcEDJP+j2DoJKiOPIQKHSwq+efy/HScVlHF9P8o5EgCZyOo6DiaCEW12cTweQlmIUeRx6pMAUBTjgjyNpoSc/LM+Ktm22snbbMPlYClMhfoadpineq0GNEl9DJkCILMuXlW5mty/3jReR3ru/hGMEU9wM1ZuRn7vfRGweaIYYNeet+DtwIJLU4BhA8udJjLVaHdvn8YaH9hJCkvqyHSSK/PwG/et7Y53dfpRDsMVNyI8VeL/kQk5w2+FITonteL/nrMSoEFuxgbSLL/S6X6bbOvM4p5YgILtdp7xMPb6W2Fvd89cT+cnqNa5vkrzFNLCEkt7CxS7zO0kxlizg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=64IlTLk9U7H3EHFVzimSbXahkhzsdMO0mNXW/M+XRUw=;
 b=xZMqOro9paMP3xfOOQxLh1NDSQgSpd0C6iGmkz0I3itZovuU3jH/+QMuE2tS6G5JCJIm00UEA27zG44mxOd3H6Dj9dVAf2MFQ3yGATaeaAC31sNhJvlrSsO8flb5OTEx6rTkehW1ttZ0AdWR/84haqn6Vh8JTnpgP5iAcRB2Vn0=
Received: from CY5PR22CA0042.namprd22.prod.outlook.com (2603:10b6:930:1d::35)
 by CH3PR12MB7740.namprd12.prod.outlook.com (2603:10b6:610:145::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26; Fri, 20 Oct
 2023 06:29:23 +0000
Received: from CY4PEPF0000EDD4.namprd03.prod.outlook.com
 (2603:10b6:930:1d:cafe::88) by CY5PR22CA0042.outlook.office365.com
 (2603:10b6:930:1d::35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Fri, 20 Oct 2023 06:29:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB03.amd.com; pr=C
Received: from SATLEXMB03.amd.com (165.204.84.17) by
 CY4PEPF0000EDD4.mail.protection.outlook.com (10.167.241.208) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6838.22 via Frontend Transport; Fri, 20 Oct 2023 06:29:22 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Fri, 20 Oct
 2023 01:29:21 -0500
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB03.amd.com (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27
 via Frontend Transport; Fri, 20 Oct 2023 01:29:16 -0500
From:   Vijendar Mukunda <Vijendar.Mukunda@amd.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>,
        Vijendar Mukunda <Vijendar.Mukunda@amd.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        "Bard Liao" <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Daniel Baluta <daniel.baluta@nxp.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Venkata Prasad Potturu <venkataprasad.potturu@amd.com>,
        V sujith kumar Reddy <Vsujithkumar.Reddy@amd.com>,
        Mastan Katragadda <Mastan.Katragadda@amd.com>,
        "moderated list:SOUND - SOUND OPEN FIRMWARE (SOF) DRIVERS" 
        <sound-open-firmware@alsa-project.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 4/5] ASoC: SOF: amd: refactor acp dram usage for data bin loading
Date:   Fri, 20 Oct 2023 11:58:14 +0530
Message-ID: <20231020062822.3913760-4-Vijendar.Mukunda@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231020062822.3913760-1-Vijendar.Mukunda@amd.com>
References: <20231020062822.3913760-1-Vijendar.Mukunda@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EDD4:EE_|CH3PR12MB7740:EE_
X-MS-Office365-Filtering-Correlation-Id: 12ab3fc7-90ba-47ce-6cf3-08dbd135e632
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: TTe5kgBgsy/W91aPQgUNq+m0kKmdsZs717LzBFyVuIrHIGSTvn95sLTxXIWbACsykPZ/gaoXMrehgkoqgOtQdErvsXYaBwC9quuluXATK3wi1LSfTcmfBPKkxTxT53CRqJiLi/GFIC0NU1uXgA0NaKFb3f5KxY5LmvC01DhkDmVPCJberETmv5wRznJzWLr07ra9+4sveXrsQgCOZosDGulu/GuSWITwqWgacI1Nsz7lBB7+TpvL6Zq6+ajZUNw0Hl1SKkz+WaJW/CGTEczMzzJxy+lniez/5YnUYV2I2gKC/+iMBXdJt4HWa3kav0X/9xo/O+l7D0dxvLWRjmALvQA84+8Gq5QDHUJXfK3brWidbnjjDGTxv0tMXZYnhiMv+QdN7PlE+lrLn6RYxAvwHtCqs73+8A2vU79MKTx2NQgHpg/VIz7bYcPNBAmX5COnWtav4dhJfrL53TukwRm/Hz48Ov1ZUayzRhFUjVan2L8Sp+u2+ctebcJyQK4dBn3RMGCFJyjYUnaXQHMnsTIoD9eeO9Zl3lTH50jXN21BPnnOV+fv9hTRIrDo7iXRz3cVIKKT08y81692Ya3MWhTpswwFVTuTCUsom3e9tUJ9Ve7koMoo4fxRDHoDMt7UxKEkPAbaD/KvmyWUrJDMz1p1sFEw8LLXVO8ksBMBjIxnKjqUl2dDbyPZ2uhH4E40rit8Ns92dm4hHr0SS1ohR5UPUArymkMyMcmsF0w8KW9DUgRjHNlWdJXOp6d9/6AFqUdnT9p0ktpNX0JTvIh+iegHQw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB03.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(39860400002)(376002)(396003)(346002)(230922051799003)(82310400011)(186009)(64100799003)(1800799009)(451199024)(46966006)(36840700001)(40470700004)(40460700003)(1076003)(2616005)(426003)(336012)(26005)(7696005)(36860700001)(83380400001)(47076005)(41300700001)(4326008)(8676002)(8936002)(7416002)(5660300002)(2906002)(478600001)(70206006)(70586007)(54906003)(6916009)(316002)(356005)(81166007)(82740400003)(86362001)(40480700001)(36756003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Oct 2023 06:29:22.5937
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 12ab3fc7-90ba-47ce-6cf3-08dbd135e632
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB03.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: CY4PEPF0000EDD4.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH3PR12MB7740
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DSP data bin can be loaded in to ACP DRAM or ACP SRAM.
Add conditional check for ACP DRAM usage for data bin loading.
Rename DRAM base address macro to have symmetry.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp-loader.c | 36 +++++++++++++++++++---------------
 sound/soc/sof/amd/acp.h        |  3 ++-
 2 files changed, 22 insertions(+), 17 deletions(-)

diff --git a/sound/soc/sof/amd/acp-loader.c b/sound/soc/sof/amd/acp-loader.c
index a427673cfb03..d35d47d7e311 100644
--- a/sound/soc/sof/amd/acp-loader.c
+++ b/sound/soc/sof/amd/acp-loader.c
@@ -83,6 +83,7 @@ int acp_dsp_block_write(struct snd_sof_dev *sdev, enum snd_sof_fw_blk_type blk_t
 		}
 		dest = adata->data_buf + offset;
 		adata->fw_data_bin_size = size + offset;
+		adata->is_dram_in_use = true;
 		break;
 	case SOF_FW_BLK_TYPE_SRAM:
 		offset = offset - desc->sram_pte_offset;
@@ -153,7 +154,7 @@ int acp_dsp_pre_fw_run(struct snd_sof_dev *sdev)
 	struct pci_dev *pci = to_pci_dev(sdev->dev);
 	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
 	struct acp_dev_data *adata;
-	unsigned int src_addr, size_fw;
+	unsigned int src_addr, size_fw, dest_addr;
 	u32 page_count, dma_size;
 	int ret;
 
@@ -174,20 +175,21 @@ int acp_dsp_pre_fw_run(struct snd_sof_dev *sdev)
 		dev_err(sdev->dev, "SHA DMA transfer failed status: %d\n", ret);
 		return ret;
 	}
-	configure_pte_for_fw_loading(FW_DATA_BIN, ACP_DRAM_PAGE_COUNT, adata);
-
-	src_addr = ACP_SYSTEM_MEMORY_WINDOW + page_count * ACP_PAGE_SIZE;
-	ret = configure_and_run_dma(adata, src_addr, ACP_DATA_RAM_BASE_ADDRESS,
-				    adata->fw_data_bin_size);
-	if (ret < 0) {
-		dev_err(sdev->dev, "acp dma configuration failed: %d\n", ret);
-		return ret;
+	if (adata->is_dram_in_use) {
+		configure_pte_for_fw_loading(FW_DATA_BIN, ACP_DRAM_PAGE_COUNT, adata);
+		src_addr = ACP_SYSTEM_MEMORY_WINDOW + (page_count * ACP_PAGE_SIZE);
+		dest_addr = ACP_DRAM_BASE_ADDRESS;
+
+		ret = configure_and_run_dma(adata, src_addr, dest_addr, adata->fw_data_bin_size);
+		if (ret < 0) {
+			dev_err(sdev->dev, "acp dma configuration failed: %d\n", ret);
+			return ret;
+		}
+		ret = acp_dma_status(adata, 0);
+		if (ret < 0)
+			dev_err(sdev->dev, "acp dma transfer status: %d\n", ret);
 	}
 
-	ret = acp_dma_status(adata, 0);
-	if (ret < 0)
-		dev_err(sdev->dev, "acp dma transfer status: %d\n", ret);
-
 	if (desc->rev > 3) {
 		/* Cache Window enable */
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_DSP0_CACHE_OFFSET0, desc->sram_pte_offset);
@@ -197,10 +199,12 @@ int acp_dsp_pre_fw_run(struct snd_sof_dev *sdev)
 	/* Free memory once DMA is complete */
 	dma_size =  (PAGE_ALIGN(sdev->basefw.fw->size) >> PAGE_SHIFT) * ACP_PAGE_SIZE;
 	dma_free_coherent(&pci->dev, dma_size, adata->bin_buf, adata->sha_dma_addr);
-	dma_free_coherent(&pci->dev, ACP_DEFAULT_DRAM_LENGTH, adata->data_buf, adata->dma_addr);
 	adata->bin_buf = NULL;
-	adata->data_buf = NULL;
-
+	if (adata->is_dram_in_use) {
+		dma_free_coherent(&pci->dev, ACP_DEFAULT_DRAM_LENGTH, adata->data_buf,
+				  adata->dma_addr);
+		adata->data_buf = NULL;
+	}
 	return ret;
 }
 EXPORT_SYMBOL_NS(acp_dsp_pre_fw_run, SND_SOC_SOF_AMD_COMMON);
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index 205b434f0872..2d1f57e1365a 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -54,7 +54,7 @@
 #define ACP3X_SCRATCH_MEMORY_ADDRESS		0x02050000
 #define ACP_SYSTEM_MEMORY_WINDOW		0x4000000
 #define ACP_IRAM_BASE_ADDRESS			0x000000
-#define ACP_DATA_RAM_BASE_ADDRESS		0x01000000
+#define ACP_DRAM_BASE_ADDRESS			0x01000000
 #define ACP_DRAM_PAGE_COUNT			128
 
 #define ACP_DSP_TO_HOST_IRQ			0x04
@@ -208,6 +208,7 @@ struct acp_dev_data {
 	struct pci_dev *smn_dev;
 	struct acp_dsp_stream *probe_stream;
 	bool enable_fw_debug;
+	bool is_dram_in_use;
 };
 
 void memcpy_to_scratch(struct snd_sof_dev *sdev, u32 offset, unsigned int *src, size_t bytes);
-- 
2.34.1

