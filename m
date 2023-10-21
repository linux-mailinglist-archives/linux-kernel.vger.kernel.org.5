Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5112C7D1D9A
	for <lists+linux-kernel@lfdr.de>; Sat, 21 Oct 2023 16:51:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjJUOvk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 Oct 2023 10:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjJUOvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 Oct 2023 10:51:38 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1nam02on2058.outbound.protection.outlook.com [40.107.96.58])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA985D7
        for <linux-kernel@vger.kernel.org>; Sat, 21 Oct 2023 07:51:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TYHZtXNd1FMcVgTOT3o+YnSdV0hmIVFlEpPoPDM2dMrhLKkrPt6TeNPQsF0tjt1OpCtjVl8jQMFpK8zmh6fJ0r2aB7ZwkCt44I/kaEyOVxlcNK2Ail1yweRMuM4P1N28qPFaibxpiFi+Znp9rZXhEw9JBhy5jn08tf7A1r/oUa/2Mmkq42IuAkZlhyk/NWv8tQY8VGHyChkFMo5d6WCgrjLmi4bfGHwm+mkArg7LOLAkI0G+zcgT8tcaKim5fmzje3LIyDJ9ivHKlnJiCyWOwqXVTLtJNKEpsO7Ql3mItKhu9OacfPFzabCSAmBVcuefn/R9O0uGcscrbiUqF+rGKQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=UUnWxhcW9fsKAipB7r/6RJXMLdyxK+qyIEVB8dgzAZY=;
 b=klpKNq0Bqm1wSWUf44Z75nxY3ROf4tcPwy6jJUTQXwZSJRhNudTMbbDs9kZZF9V4uZV5M5FrdFF1uJYaB2FgXw9o+kz2MZp3eIxXEdJ2/RAQJXMCrCaBkYkWAdWqun5x14hpsuOLfvDdzoYb5W0q/ri0Xm4F3iW1IuGynGVDEpydgz6HPIgH8Eis2heEAmVsKtf3TzKZNBAk9uR+D3c80wgBFARM5CLG8Jth+ak+bZP5HjBFRA9EyFjmn3g6ioni19EQh8BmCumkhuqs80PEXOSMHYu1ZJ5w+3hGhqkq09FTxbI7noF3H+U4B7fixtnNoBr3DotYJMY3NONRg7+hDg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=UUnWxhcW9fsKAipB7r/6RJXMLdyxK+qyIEVB8dgzAZY=;
 b=vaHD8GF8j6Mmg/p08J0BJpztpczEgcUw3Of1FR9deRFZXkmzr/ePxySX8qbEwbHxITTFDQMSIKds81m5GX/s6lOfwqkGSj3PGtYCJSxewcqDmInEm4AhGgM6wPdU4Uf+a1qORMUZ3ntPPKLxxXMDwIcvrFg01udFnMGHMNGtgFk=
Received: from DM6PR03CA0073.namprd03.prod.outlook.com (2603:10b6:5:333::6) by
 BL1PR12MB5031.namprd12.prod.outlook.com (2603:10b6:208:31a::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.6907.26; Sat, 21 Oct 2023 14:51:30 +0000
Received: from DS2PEPF00003443.namprd04.prod.outlook.com
 (2603:10b6:5:333:cafe::a) by DM6PR03CA0073.outlook.office365.com
 (2603:10b6:5:333::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.26 via Frontend
 Transport; Sat, 21 Oct 2023 14:51:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS2PEPF00003443.mail.protection.outlook.com (10.167.17.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6907.20 via Frontend Transport; Sat, 21 Oct 2023 14:51:30 +0000
Received: from SATLEXMB05.amd.com (10.181.40.146) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 21 Oct
 2023 09:51:30 -0500
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB05.amd.com
 (10.181.40.146) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.27; Sat, 21 Oct
 2023 09:51:30 -0500
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.27 via Frontend
 Transport; Sat, 21 Oct 2023 09:51:25 -0500
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <venkataprasad.potturu@amd.com>, <arungopal.kondaveeti@amd.com>,
        <mastan.katragadda@amd.com>, <juan.martinez@amd.com>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        V Sujith Kumar Reddy <vsujithkumar.reddy@amd.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 02/13] ASoC: amd: acp: refactor acp i2s clock generation code
Date:   Sat, 21 Oct 2023 20:20:43 +0530
Message-ID: <20231021145110.478744-2-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
References: <20231021145110.478744-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF00003443:EE_|BL1PR12MB5031:EE_
X-MS-Office365-Filtering-Correlation-Id: d773b436-e494-4a72-24f3-08dbd2453646
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C7JQNv2LoWF60lNlnwGM0EBUI9fTFXKMSHpP9NJizSYpHaFTDg0ONf0a2W4Quw96dNkHIwaqo4/sND9lRkfScIDQCPqoC+MvbMVbovV2iJOzG1BGSzIJRpcXjZo7CqXPMuiVKLKBQQu9O7XQF/xEUtLhJDCTSJ49n6WuTy8z65HKsdPe8Owkn/weqW3F3ZrIoxQM80hSsg+jU0RdmI2y7Ya/fOFtZKFosrN9S1fwIqLuB7nTFMHMWqSlaSJk+FZ2I9oPciQyMN+yT5ZrRBH3Ww22zTDGIaNp2CsE8/TL7wUFpSNU+thWaKdZSVEzNOGQZ6YwsjsY3P3gA6SHRgOhq4bA9mYKOPs9uIiT47mqYVNqaPWC5zTQTvYGSt29hZRf/slmnJHOJnY2UF7svoCrRQynZp/UlnCbLFAzZs8+K5NofzASKBgFPdkXAQgnsuMNUAHXzz6LtmO4m41GJtiG7t9C47ffs3miGyddyMvU3AwVRu3R9M1ehHn54O+IRHghJOZFT7yc490NGqEf7/gAr3Pgl7VlXQX7z1xU1J4gzfPeO+FNZ8sA7tOH4USPsVUROmgpY75ZY8ZYFlz4yl5aG7id+v3TJahcEethT62h70bN7PIKas5TDwPO8S5X9ZC9mFnbgsYTjzUSGWNkqwUrN5zcqV26tXwp8UO6XippUAAfGcKoxzyueQrADhBTb1GAj6uVKI/6MelLNwy/7n2eCtYk3X3YpSa6P+WA75WvvZCJnXZnGYVBwi09ldNTnpTtFrUU9gH0x0/+GnOjQe04Fg==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(396003)(346002)(376002)(136003)(39860400002)(230922051799003)(64100799003)(1800799009)(186009)(451199024)(82310400011)(36840700001)(46966006)(40470700004)(26005)(1076003)(81166007)(2616005)(356005)(82740400003)(336012)(426003)(478600001)(6666004)(47076005)(83380400001)(54906003)(110136005)(70206006)(70586007)(316002)(7696005)(41300700001)(36860700001)(4326008)(8936002)(8676002)(5660300002)(2906002)(40480700001)(36756003)(40460700003)(86362001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Oct 2023 14:51:30.7418
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d773b436-e494-4a72-24f3-08dbd2453646
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: DS2PEPF00003443.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5031
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor acp i2s LRCLK,BCLK generation code and move to commnon file.

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-i2s.c | 32 ++++++++++++++++++++++++++++++
 sound/soc/amd/acp/amd.h     | 39 -------------------------------------
 2 files changed, 32 insertions(+), 39 deletions(-)

diff --git a/sound/soc/amd/acp/acp-i2s.c b/sound/soc/amd/acp/acp-i2s.c
index df350014966a..59d3a499771a 100644
--- a/sound/soc/amd/acp/acp-i2s.c
+++ b/sound/soc/amd/acp/acp-i2s.c
@@ -20,10 +20,42 @@
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
 #include <linux/dma-mapping.h>
+#include <linux/bitfield.h>
 
 #include "amd.h"
 
 #define DRV_NAME "acp_i2s_playcap"
+#define	I2S_MASTER_MODE_ENABLE		1
+#define	I2S_MODE_ENABLE			0
+#define	I2S_FORMAT_MODE			GENMASK(1, 1)
+#define	LRCLK_DIV_FIELD			GENMASK(10, 2)
+#define	BCLK_DIV_FIELD			GENMASK(23, 11)
+
+static inline void acp_set_i2s_clk(struct acp_dev_data *adata, int dai_id)
+{
+	u32 i2s_clk_reg, val;
+
+	switch (dai_id) {
+	case I2S_SP_INSTANCE:
+		i2s_clk_reg = ACP_I2STDM0_MSTRCLKGEN;
+		break;
+	case I2S_BT_INSTANCE:
+		i2s_clk_reg = ACP_I2STDM1_MSTRCLKGEN;
+		break;
+	case I2S_HS_INSTANCE:
+		i2s_clk_reg = ACP_I2STDM2_MSTRCLKGEN;
+		break;
+	default:
+		i2s_clk_reg = ACP_I2STDM0_MSTRCLKGEN;
+		break;
+	}
+
+	val  = I2S_MASTER_MODE_ENABLE;
+	val |= I2S_MODE_ENABLE & BIT(1);
+	val |= FIELD_PREP(LRCLK_DIV_FIELD, adata->lrclk_div);
+	val |= FIELD_PREP(BCLK_DIV_FIELD, adata->bclk_div);
+	writel(val, adata->acp_base + i2s_clk_reg);
+}
 
 static int acp_i2s_set_fmt(struct snd_soc_dai *cpu_dai,
 			   unsigned int fmt)
diff --git a/sound/soc/amd/acp/amd.h b/sound/soc/amd/acp/amd.h
index 487eefa5985f..87d1e1f7d6b6 100644
--- a/sound/soc/amd/acp/amd.h
+++ b/sound/soc/amd/acp/amd.h
@@ -188,17 +188,6 @@ struct acp_dev_data {
 	u32 xfer_rx_resolution[3];
 };
 
-union acp_i2stdm_mstrclkgen {
-	struct {
-		u32 i2stdm_master_mode : 1;
-		u32 i2stdm_format_mode : 1;
-		u32 i2stdm_lrclk_div_val : 9;
-		u32 i2stdm_bclk_div_val : 11;
-		u32:10;
-	} bitfields, bits;
-	u32  u32_all;
-};
-
 extern const struct snd_soc_dai_ops asoc_acp_cpu_dai_ops;
 extern const struct snd_soc_dai_ops acp_dmic_dai_ops;
 
@@ -276,32 +265,4 @@ static inline u64 acp_get_byte_count(struct acp_dev_data *adata, int dai_id, int
 POINTER_RETURN_BYTES:
 	return byte_count;
 }
-
-static inline void acp_set_i2s_clk(struct acp_dev_data *adata, int dai_id)
-{
-	union acp_i2stdm_mstrclkgen mclkgen;
-	u32 master_reg;
-
-	switch (dai_id) {
-	case I2S_SP_INSTANCE:
-		master_reg = ACP_I2STDM0_MSTRCLKGEN;
-		break;
-	case I2S_BT_INSTANCE:
-		master_reg = ACP_I2STDM1_MSTRCLKGEN;
-		break;
-	case I2S_HS_INSTANCE:
-		master_reg = ACP_I2STDM2_MSTRCLKGEN;
-		break;
-	default:
-		master_reg = ACP_I2STDM0_MSTRCLKGEN;
-		break;
-	}
-
-	mclkgen.bits.i2stdm_master_mode = 0x1;
-	mclkgen.bits.i2stdm_format_mode = 0x00;
-
-	mclkgen.bits.i2stdm_bclk_div_val = adata->bclk_div;
-	mclkgen.bits.i2stdm_lrclk_div_val = adata->lrclk_div;
-	writel(mclkgen.u32_all, adata->acp_base + master_reg);
-}
 #endif
-- 
2.25.1

