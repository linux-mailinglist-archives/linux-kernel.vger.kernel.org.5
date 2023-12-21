Return-Path: <linux-kernel+bounces-7949-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 61F0E81AF97
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 08:39:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 874081C2339D
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 07:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1183417745;
	Thu, 21 Dec 2023 07:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="K+8wJO1O"
X-Original-To: linux-kernel@vger.kernel.org
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2086.outbound.protection.outlook.com [40.107.237.86])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E4325552;
	Thu, 21 Dec 2023 07:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=idGDYvN6OGOKgNwecAwd3YURusAQB5arKr41X4M33yWvXAh9815RzahL/6rPGuk90cRXKpHNbXL7P/9is1vJq9Sd+GVt4PR6n7NIBcnE0YBZgymtpzTgFmjeeBvZkYq8srz7gpnQciN6fCxHjV/+qQ7UFmpWA1jTw8Gxrp8Fg6SShLqitqZlJzsY6kmWM8xRURIMsZFzMazviOoFGOQq/+9d/qVSFdqqiLWXsvWjBq+MRsha3W9Q6m+K6FhMIr4hHhMjUKaZmrHx1ex29gmN/JE+T3v3Y94tSS5oEgn1TgcRjtVu+BmnUsY59Vd3k+W5j3WkE2xC0Hzj0VPszloF2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WmSvbdZheoMbrfrMOra1kGeyoKcwdWWrtw+v++Bk0J8=;
 b=T7NqL3SJ5SRE6KTcC39eXGslEJvClsp171bxlkw1pQMxDvY01wC5km6KrvfsSrfxSiEtb9LRTf7d3mXfYh3auDtYRhsk5dYEvB41szAFJVDmYQiGLBlyNEoZfAspNi5I+65dXjY0GOaeSV8D8CvWwUFO7YuMY5mKRe88dgJyIGXD07edC7m4N+5NC4xCWokBzMIWnd5gDnVUymZmqt+GygwluvkYWpWF4wkgdPWJnsoZQEfdIxyJxA8eSYnXh3EdGtJj+YPGCKxEKRKgtuShRC7+TGo17KY79yXQ+XV22vRa6Lg9X7zxb8pwrcNi82n/YiOy3/15OlmuYGBpuBRT5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WmSvbdZheoMbrfrMOra1kGeyoKcwdWWrtw+v++Bk0J8=;
 b=K+8wJO1OoQ/qPeQo4cFFZLO/naJcWEc6Zz4r+6Ye/Q7KTahYmpCqAJCnRtfQp2vCDa82SAOpdioDrEeHikT78sdzHFFE4Xclb3R+roU/7FFNx1AgUwSmZtwM7mnjTlaia59SonxT/BeXvAVJZ0zgWpzDG5At3CWq/382t7P+nl0=
Received: from CYZPR14CA0020.namprd14.prod.outlook.com (2603:10b6:930:8f::25)
 by SJ2PR12MB9210.namprd12.prod.outlook.com (2603:10b6:a03:561::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.18; Thu, 21 Dec
 2023 07:37:23 +0000
Received: from CY4PEPF0000EE3E.namprd03.prod.outlook.com
 (2603:10b6:930:8f:cafe::9f) by CYZPR14CA0020.outlook.office365.com
 (2603:10b6:930:8f::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7113.20 via Frontend
 Transport; Thu, 21 Dec 2023 07:37:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 CY4PEPF0000EE3E.mail.protection.outlook.com (10.167.242.18) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7113.14 via Frontend Transport; Thu, 21 Dec 2023 07:37:22 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 01:37:22 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Thu, 21 Dec
 2023 01:37:21 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Thu, 21 Dec 2023 01:37:16 -0600
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
Subject: [PATCH 07/12] ASoC: SOF: amd: add interrupt handling for SoundWire manager devices
Date: Thu, 21 Dec 2023 13:05:53 +0530
Message-ID: <20231221073558.3181911-8-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: CY4PEPF0000EE3E:EE_|SJ2PR12MB9210:EE_
X-MS-Office365-Filtering-Correlation-Id: c6e70158-ac61-4326-ad05-08dc01f7abb8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	TkAvHtYrVg4CMoGUe4gEz1kdzBfAI7Tz99qjoDP8AN/aOcwofVw7oyvwGuP/vlQricW+FnYBROh6F8LEFtSzrD6S0CW5q8qr/LDEfuIXaUWnWsboh8j3ZXlKO3KsyJeEnA4koA8laQjot6INjWrPESx0XB1Sm8MX5SiKTelSteN0HwSKZo3nall+xxnjVD9aK7mw2Da/6kyDvXTnx5ReUELYzu5jeIAmSKltfjDa6PBexEyw9bnsIBqOQoYbUSWQcc6YfQ0zTTzyMjrtR6g/1ZxAKg86eDqjDUiCbFxDMEX5pc8k6e9ekvLW88iosz6fgnqAbcZ5eeYxGxxH8d7zWDg722928EHqpHU4itQPKhqXtuCelL2/O6AjsMZQa+rq+v1AFAGmUDze0bMDsFE9LSH0KsB0dHpFK1cRTKozbMRzVdH/4rxa9ddb89ae2+SuWJ3hilvRmQgXCnv/2bGllmekZ/RH0JGnQUdTpngO4Et7ExT27UjDcwN6a8aOAukBaai0Ml9s0HPcGGhoBMD3Ni2PXPzYt2KQBeOuuVAG2wylitHy4NurRPa9p2lIK4xl2s7X2AIGY2aHd+zoKVMWqbeUNuohx9aN3P2lDAm4xEzz9FFf5bkC6JsUfXn4t3B8H4WsTorU+BKOositpXtbeW1ROivdsQUP8Bbj1/B69l9I4pcEAknPwuywz02yh2pRs5W/IR6Q/IX/ci8V0iKC8TBkMQxWNFAvki+ggcSUn9C9ZvTXhBDTNB/xvL3z0GFHRU0u/+OPiiD+PdQ6DfHM9w==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(1800799012)(64100799003)(82310400011)(451199024)(186009)(36840700001)(46966006)(40470700004)(40480700001)(36756003)(40460700003)(1076003)(26005)(7416002)(8676002)(8936002)(2616005)(7696005)(478600001)(54906003)(70206006)(6666004)(2906002)(110136005)(316002)(47076005)(336012)(36860700001)(4326008)(41300700001)(5660300002)(83380400001)(426003)(81166007)(86362001)(70586007)(356005)(82740400003)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Dec 2023 07:37:22.8230
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: c6e70158-ac61-4326-ad05-08dc01f7abb8
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CY4PEPF0000EE3E.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9210

Add support for interrupt handling for soundwire manager platform
devices.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp-dsp-offset.h |  4 ++++
 sound/soc/sof/amd/acp.c            | 38 +++++++++++++++++++++++++++++-
 sound/soc/sof/amd/acp.h            |  5 ++++
 3 files changed, 46 insertions(+), 1 deletion(-)

diff --git a/sound/soc/sof/amd/acp-dsp-offset.h b/sound/soc/sof/amd/acp-dsp-offset.h
index a913f1cc4c80..7ba6492b8e99 100644
--- a/sound/soc/sof/amd/acp-dsp-offset.h
+++ b/sound/soc/sof/amd/acp-dsp-offset.h
@@ -78,6 +78,10 @@
 #define ACP5X_AXI2DAGB_SEM_0			0x1884
 #define ACP6X_AXI2DAGB_SEM_0			0x1874
 
+/* ACP common registers to report errors related to I2S & SoundWire interfaces */
+#define ACP_SW0_I2S_ERROR_REASON		0x18B4
+#define ACP_SW1_I2S_ERROR_REASON		0x1A50
+
 /* Registers from ACP_SHA block */
 #define ACP_SHA_DSP_FW_QUALIFIER		0x1C70
 #define ACP_SHA_DMA_CMD				0x1CB0
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index f24cd6b7490f..7a34faae9889 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -375,10 +375,13 @@ static irqreturn_t acp_irq_thread(int irq, void *context)
 
 static irqreturn_t acp_irq_handler(int irq, void *dev_id)
 {
+	struct amd_sdw_manager *amd_manager;
 	struct snd_sof_dev *sdev = dev_id;
 	const struct sof_amd_acp_desc *desc = get_chip_info(sdev->pdata);
+	struct acp_dev_data *adata = sdev->pdata->hw_pdata;
 	unsigned int base = desc->dsp_intr_base;
 	unsigned int val;
+	int irq_flag = 0;
 
 	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, base + DSP_SW_INTR_STAT_OFFSET);
 	if (val & ACP_DSP_TO_HOST_IRQ) {
@@ -387,7 +390,38 @@ static irqreturn_t acp_irq_handler(int irq, void *dev_id)
 		return IRQ_WAKE_THREAD;
 	}
 
-	return IRQ_NONE;
+	val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->ext_intr_stat);
+	if (val & ACP_SDW0_IRQ_MASK) {
+		amd_manager = dev_get_drvdata(&adata->sdw->pdev[0]->dev);
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, ACP_SDW0_IRQ_MASK);
+		if (amd_manager)
+			schedule_work(&amd_manager->amd_sdw_irq_thread);
+		irq_flag = 1;
+	}
+
+	if (val & ACP_ERROR_IRQ_MASK) {
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat, ACP_ERROR_IRQ_MASK);
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + ACP_SW0_I2S_ERROR_REASON, 0);
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + ACP_SW1_I2S_ERROR_REASON, 0);
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, base + ACP_ERROR_STATUS, 0);
+		irq_flag = 1;
+	}
+
+	if (desc->ext_intr_stat1) {
+		val = snd_sof_dsp_read(sdev, ACP_DSP_BAR, desc->ext_intr_stat1);
+		if (val & ACP_SDW1_IRQ_MASK) {
+			amd_manager = dev_get_drvdata(&adata->sdw->pdev[1]->dev);
+			snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_stat1,
+					  ACP_SDW1_IRQ_MASK);
+			if (amd_manager)
+				schedule_work(&amd_manager->amd_sdw_irq_thread);
+			irq_flag = 1;
+		}
+	}
+	if (irq_flag)
+		return IRQ_HANDLED;
+	else
+		return IRQ_NONE;
 }
 
 static int acp_power_on(struct snd_sof_dev *sdev)
@@ -443,6 +477,8 @@ static int acp_reset(struct snd_sof_dev *sdev)
 	if (desc->ext_intr_enb)
 		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_enb, 0x01);
 
+	if (desc->ext_intr_cntl)
+		snd_sof_dsp_write(sdev, ACP_DSP_BAR, desc->ext_intr_cntl, ACP_ERROR_IRQ_MASK);
 	return ret;
 }
 
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index e88d01330ec7..2058dae32659 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -93,6 +93,9 @@
 #define PROBE_STATUS_BIT			BIT(31)
 
 #define ACP_FIRMWARE_SIGNATURE			0x100
+#define ACP_ERROR_IRQ_MASK			BIT(29)
+#define ACP_SDW0_IRQ_MASK			BIT(21)
+#define ACP_SDW1_IRQ_MASK			BIT(2)
 #define ACP_DEFAULT_SRAM_LENGTH			0x00080000
 #define ACP_SRAM_PAGE_COUNT			128
 
@@ -184,7 +187,9 @@ struct sof_amd_acp_desc {
 	unsigned int host_bridge_id;
 	u32 pgfsm_base;
 	u32 ext_intr_enb;
+	u32 ext_intr_cntl;
 	u32 ext_intr_stat;
+	u32 ext_intr_stat1;
 	u32 dsp_intr_base;
 	u32 sram_pte_offset;
 	u32 hw_semaphore_offset;
-- 
2.34.1


