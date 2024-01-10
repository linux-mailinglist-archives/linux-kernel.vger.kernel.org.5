Return-Path: <linux-kernel+bounces-21919-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C861082968F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 10:49:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E09671C25191
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 09:49:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F34F3FB08;
	Wed, 10 Jan 2024 09:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T9RVbqeA"
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12on2071.outbound.protection.outlook.com [40.107.237.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B140640BE3;
	Wed, 10 Jan 2024 09:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=j8DdPWKNpQbZDWz9ok11Gx7v0PAnK1gOK368wia5pHnak9WUU8VepHUAu2UsEeExx+AdxcJcNHlV7rGBFh+NAM/scOSN11pNyCusIq6vb6To1BiCgNUBsKbOTZtfKwtxnFJreLgWHPWqGg/gH+eVh5JXu61jmKvhWJLviLeGW6mlskTBM17M+afuCyZaPUtYlkb7TDomXcWPeYdw023ls0Ckco4bIh3NpLik4kQNvWILZ5cR3KyIGXy57VmRf99xjZ+rUxw7iG+aSssVcvaaxlX0RgU9nCp0iFP+B4OshJP7kmMDg46x9T/nPYYIKAek+ciwWEVzLRnOwvzk/+aKAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UhoVkhy8GN1PdZmnmv/uRV5zVwbIdlO+MnLOz/NKjrs=;
 b=J3JtI0WA85xT8cM63HzEAVEIHrzeicrfjf/WiF95caRTfFOEUuf0TtE5yNuR8gcc7Xh4Eb1Q4M4bSW6U33rFCLc5OjnU7sFXVUDFVvhZ+DV9utTsLzrVY3Gj2Y0x+7OGmK8Au2zp6+4RRnZr043ZGFQIf/6YokEu8IM5dEkseWCWF3avm2uS+Je2fMphswpHAghsXf1WV++R7LDZKcQC457vbrJdzemSqRYPn2CDkl54ehXwJXTWMA/077KxEo72cVWfrRFBAr0zUMIqdwB6+M453nhNI3vgRj5OToBa9ocCqudK8CGf/wfH4tpMF4Na1NMXA3P5m8y2xosPQbOWww==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UhoVkhy8GN1PdZmnmv/uRV5zVwbIdlO+MnLOz/NKjrs=;
 b=T9RVbqeAl+GPCLLEojfmm8l9IHdBV8sXzHAtkY29+1nJqQq5BWI55w1CLxwVCyXUfyLfeTpO0RvSekCG2PBmNS0QPce7uNhwYv6Xx+N9R78V6Cq4LYt3AhGtR1TOZVIaPXmTD0naL2MlFgW5YZVcd553q7jTJQ5bVahiI0lJkLs=
Received: from SN7PR04CA0231.namprd04.prod.outlook.com (2603:10b6:806:127::26)
 by PH7PR12MB5618.namprd12.prod.outlook.com (2603:10b6:510:134::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23; Wed, 10 Jan
 2024 09:47:23 +0000
Received: from SA2PEPF00001509.namprd04.prod.outlook.com
 (2603:10b6:806:127:cafe::3a) by SN7PR04CA0231.outlook.office365.com
 (2603:10b6:806:127::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.7159.23 via Frontend
 Transport; Wed, 10 Jan 2024 09:47:23 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 SA2PEPF00001509.mail.protection.outlook.com (10.167.242.41) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.7181.14 via Frontend Transport; Wed, 10 Jan 2024 09:47:23 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 03:47:14 -0600
Received: from SATLEXMB04.amd.com (10.181.40.145) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.34; Wed, 10 Jan
 2024 03:47:13 -0600
Received: from vijendar-X570-GAMING-X.amd.com (10.180.168.240) by
 SATLEXMB04.amd.com (10.181.40.145) with Microsoft SMTP Server id 15.1.2507.34
 via Frontend Transport; Wed, 10 Jan 2024 03:47:08 -0600
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
	<perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, Mastan Katragadda
	<Mastan.Katragadda@amd.com>, V sujith kumar Reddy
	<Vsujithkumar.Reddy@amd.com>, "moderated list:SOUND - SOUND OPEN FIRMWARE
 (SOF) DRIVERS" <sound-open-firmware@alsa-project.org>, "open list:SOUND - SOC
 LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, "open
 list" <linux-kernel@vger.kernel.org>
Subject: [PATCH V2 13/13] ASoC: SOF: amd: refactor acp driver pm ops
Date: Wed, 10 Jan 2024 15:14:16 +0530
Message-ID: <20240110094416.853610-14-Vijendar.Mukunda@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF00001509:EE_|PH7PR12MB5618:EE_
X-MS-Office365-Filtering-Correlation-Id: 6f288196-6247-4171-cbc0-08dc11c12544
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info:
	e/yw6X41z/diZRifrGad3/rjEfB2PC/kRUsYT58skXqyqKHykRn4JdSldugHz0WIoed6jwcjAi0by84GB4ggRRU4eMRGf77+Fi+ChOuGF6vPVHdqBd5fUpM/enF2/g9s3mwcXxDUdsMgo6hhplODGiubn0dk9yGibsi/jJ53OSl56BpEPKPFbrMqE0lzV9C0eAjeK8z0fOXkO77u1MOGSobJeYdTfQJ6DcqPLGIvU+jTskoOUwUtdM/eL7yS6/DvA7BK62ivBdrVLC5ZLnHH3EvcsJ2XLmZOo+Pa1zsONrTE/Trhuc9gLG6A52GQDTHIuN+oCmoIWST5M/yZCi60Z1z6gyEcq9JjXMY3hIK+QnKY+rkeAxmUTrZ76wFqstsH6nGv0uxQXu+BAV1yFImyMS0IkC+iPHwn8b3TYrHJek9+cNX6Jf7Dq67LM+KTrpCHT9eMCn3vrKWGo+HIwdvpuOL/Y2GZyyTWmvBY2dHWFNbLZ2XQNaCgm9VDf/43+r+JEm3bPM0sE0pjlciIluH5AV9OvQg9M3XJ9xi51aSAQ8t6OBsOFw1wjf6aMab7bMF0nDDkoreBlC5SkkIm4UaQGfGYiQHr4tM8WRKWPTarCR4B0pMmks9xJdkaYEdBQ8x9DBIsE54429Y9URGyP3jmmNfofZsNjYvX56pYnd7vlJU4kM5ZEgvTbcqhpPC8pjPdVEZ47/IDCpngs1xh/Aa4YR4S3bd33panvXwFt+FRfAkNMZuq9bsqvwHWGpMNWamvn3lKGy/+sqFcIVtAlyH1AA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(346002)(376002)(39860400002)(136003)(396003)(230922051799003)(1800799012)(451199024)(186009)(64100799003)(82310400011)(40470700004)(46966006)(36840700001)(40480700001)(40460700003)(83380400001)(70206006)(70586007)(86362001)(41300700001)(36756003)(356005)(81166007)(54906003)(82740400003)(36860700001)(47076005)(1076003)(426003)(336012)(2616005)(26005)(5660300002)(2906002)(110136005)(316002)(7696005)(478600001)(6666004)(8936002)(4326008)(8676002)(7416002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Jan 2024 09:47:23.0612
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6f288196-6247-4171-cbc0-08dc11c12544
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF00001509.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5618

Refactor acp driver pm ops to support SoundWire interface.

When SoundWire configuration is enabled, In case of ClockStopMode,
DSP soft reset should be applied and for rest of the scenarios
acp init/deinit sequence should be invoked.

Signed-off-by: Vijendar Mukunda <Vijendar.Mukunda@amd.com>
---
 sound/soc/sof/amd/acp-dsp-offset.h |  3 ++
 sound/soc/sof/amd/acp.c            | 65 +++++++++++++++++++++++++++---
 sound/soc/sof/amd/acp.h            |  4 ++
 3 files changed, 67 insertions(+), 5 deletions(-)

diff --git a/sound/soc/sof/amd/acp-dsp-offset.h b/sound/soc/sof/amd/acp-dsp-offset.h
index c1bdc028a61a..59afbe2e0f42 100644
--- a/sound/soc/sof/amd/acp-dsp-offset.h
+++ b/sound/soc/sof/amd/acp-dsp-offset.h
@@ -103,4 +103,7 @@
 /* Cache window registers */
 #define ACP_DSP0_CACHE_OFFSET0			0x0420
 #define ACP_DSP0_CACHE_SIZE0			0x0424
+
+#define ACP_SW0_EN				0x3000
+#define ACP_SW1_EN				0x3C00
 #endif
diff --git a/sound/soc/sof/amd/acp.c b/sound/soc/sof/amd/acp.c
index 7a34faae9889..920fead2d93d 100644
--- a/sound/soc/sof/amd/acp.c
+++ b/sound/soc/sof/amd/acp.c
@@ -482,6 +482,31 @@ static int acp_reset(struct snd_sof_dev *sdev)
 	return ret;
 }
 
+static int acp_dsp_reset(struct snd_sof_dev *sdev)
+{
+	unsigned int val;
+	int ret;
+
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SOFT_RESET, ACP_DSP_ASSERT_RESET);
+
+	ret = snd_sof_dsp_read_poll_timeout(sdev, ACP_DSP_BAR, ACP_SOFT_RESET, val,
+					    val & ACP_DSP_SOFT_RESET_DONE_MASK,
+					    ACP_REG_POLL_INTERVAL, ACP_REG_POLL_TIMEOUT_US);
+	if (ret < 0) {
+		dev_err(sdev->dev, "timeout asserting reset\n");
+		return ret;
+	}
+
+	snd_sof_dsp_write(sdev, ACP_DSP_BAR, ACP_SOFT_RESET, ACP_DSP_RELEASE_RESET);
+
+	ret = snd_sof_dsp_read_poll_timeout(sdev, ACP_DSP_BAR, ACP_SOFT_RESET, val, !val,
+					    ACP_REG_POLL_INTERVAL, ACP_REG_POLL_TIMEOUT_US);
+	if (ret < 0)
+		dev_err(sdev->dev, "timeout in releasing reset\n");
+
+	return ret;
+}
+
 static int acp_init(struct snd_sof_dev *sdev)
 {
 	int ret;
@@ -498,10 +523,34 @@ static int acp_init(struct snd_sof_dev *sdev)
 	return acp_reset(sdev);
 }
 
+static bool check_acp_sdw_enable_status(struct snd_sof_dev *sdev)
+{
+	struct acp_dev_data *acp_data;
+	u32 sdw0_en, sdw1_en;
+
+	acp_data = sdev->pdata->hw_pdata;
+	if (!acp_data->sdw)
+		return false;
+
+	sdw0_en = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_SW0_EN);
+	sdw1_en = snd_sof_dsp_read(sdev, ACP_DSP_BAR, ACP_SW1_EN);
+	acp_data->sdw_en_stat = sdw0_en || sdw1_en;
+	return acp_data->sdw_en_stat;
+}
+
 int amd_sof_acp_suspend(struct snd_sof_dev *sdev, u32 target_state)
 {
 	int ret;
 
+	/* When acp_reset() function is invoked, it will apply ACP SOFT reset and
+	 * DSP reset. ACP Soft reset sequence will cause all ACP IP registers will
+	 * be reset to default values which will break the ClockStop Mode functionality.
+	 * Add a condition check to apply DSP reset when SoundWire ClockStop mode
+	 * is selected. For the rest of the scenarios, apply acp reset sequence.
+	 */
+	if (check_acp_sdw_enable_status(sdev))
+		return acp_dsp_reset(sdev);
+
 	ret = acp_reset(sdev);
 	if (ret) {
 		dev_err(sdev->dev, "ACP Reset failed\n");
@@ -517,13 +566,19 @@ EXPORT_SYMBOL_NS(amd_sof_acp_suspend, SND_SOC_SOF_AMD_COMMON);
 int amd_sof_acp_resume(struct snd_sof_dev *sdev)
 {
 	int ret;
+	struct acp_dev_data *acp_data;
 
-	ret = acp_init(sdev);
-	if (ret) {
-		dev_err(sdev->dev, "ACP Init failed\n");
-		return ret;
+	acp_data = sdev->pdata->hw_pdata;
+	if (!acp_data->sdw_en_stat) {
+		ret = acp_init(sdev);
+		if (ret) {
+			dev_err(sdev->dev, "ACP Init failed\n");
+			return ret;
+		}
+		return acp_memory_init(sdev);
+	} else {
+		return acp_dsp_reset(sdev);
 	}
-	return acp_memory_init(sdev);
 }
 EXPORT_SYMBOL_NS(amd_sof_acp_resume, SND_SOC_SOF_AMD_COMMON);
 
diff --git a/sound/soc/sof/amd/acp.h b/sound/soc/sof/amd/acp.h
index e94713d7ff1d..947068da39b5 100644
--- a/sound/soc/sof/amd/acp.h
+++ b/sound/soc/sof/amd/acp.h
@@ -31,6 +31,9 @@
 #define ACP_ASSERT_RESET			0x01
 #define ACP_RELEASE_RESET			0x00
 #define ACP_SOFT_RESET_DONE_MASK		0x00010001
+#define ACP_DSP_ASSERT_RESET			0x04
+#define ACP_DSP_RELEASE_RESET			0x00
+#define ACP_DSP_SOFT_RESET_DONE_MASK		0x00050004
 
 #define ACP_DSP_INTR_EN_MASK			0x00000001
 #define ACP3X_SRAM_PTE_OFFSET			0x02050000
@@ -242,6 +245,7 @@ struct acp_dev_data {
 	bool enable_fw_debug;
 	bool is_dram_in_use;
 	bool is_sram_in_use;
+	bool sdw_en_stat;
 };
 
 void memcpy_to_scratch(struct snd_sof_dev *sdev, u32 offset, unsigned int *src, size_t bytes);
-- 
2.34.1


