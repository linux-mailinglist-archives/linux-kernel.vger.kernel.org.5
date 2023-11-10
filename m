Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3BC97E7E76
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Nov 2023 18:45:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345226AbjKJRpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Nov 2023 12:45:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345926AbjKJRoH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Nov 2023 12:44:07 -0500
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0398835784
        for <linux-kernel@vger.kernel.org>; Fri, 10 Nov 2023 04:52:36 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TVqjCRRTQ/aZE/AE7sEZgkXV5EYaLOowDaGNgqNmgwBjQh8SbDwrqeutE0l8HMrRY33cieP0RSA3hCtz/CYeZGZcwDzamKLBxhlBqS54yJQNLst9CdOTAQed5tX00RthlCw8IxXGVGZj3ofIr6LUARkxQBtAs/ykwmcKU2soGfTRIY/SzZeUGxWK2RZyiBrIWfWaN9PdQBWVnHJ2PuIH2FoFsRF9c852ltH1Y1dU2mWmMr7j3t4gSPUvEfVKStbX6vUX15yh3bu3daOFuPtDVTZHUmlZbMz/tgfTcLem0/exZZKpoWh/0u4Z4Ope41ljkQJOrI8cOl2y2snmjJGlhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BJgBWxd8ddbsK/2qDi3AKF6y9TrH1VH4mGi8xJbb0I8=;
 b=etGdqammGWJzK/G9VcMWejFShsF1g6z8FlXvpN0unBulP4ayC9SOF5V4wdHjVGzDzE5gnnyeLQj0yePPkhSAhl44OFaTIwdcLzKQL834HaGGwkL8dUSo/EDj33cp+ybYrAtQtS9MhA35JC7OortSGmZRc8ku9mOnuPgpkC3/CEAI8fc7+nScYeUQLDz2R2EjumZL6nl42McatXvQ0b4tOUpsayXhEkSiHRyJZcWRKCHXIBpCJ9gg2M13RhtYU68CprL23L4wv/9pM7aouNChlGjYkHS5jn/0RGq8czVno/N7wB67HCbzOO8oz6lEHKX3Ily6AsJgpVlWqG9Pp7tmYw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BJgBWxd8ddbsK/2qDi3AKF6y9TrH1VH4mGi8xJbb0I8=;
 b=092XfZu0Y7HXcSXHqQVNfSZe8KUatsriIrGbKlWfYCCcza0QC9/1/qXbeKQ74vKLrpSNdYJ+7D03gjn6sS+ZUrmmy/Mw82TZYdu5VVwGyIopCFEEbDqeKjFcvHZF/PvciDLfwXsOcEIrz9l4nTy64pwK5NpRBFfjAs6bj+IwoUY=
Received: from BL1P223CA0015.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:2c4::20)
 by DM6PR12MB4580.namprd12.prod.outlook.com (2603:10b6:5:2a8::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21; Fri, 10 Nov
 2023 12:52:30 +0000
Received: from MN1PEPF0000ECD8.namprd02.prod.outlook.com
 (2603:10b6:208:2c4:cafe::ef) by BL1P223CA0015.outlook.office365.com
 (2603:10b6:208:2c4::20) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6977.21 via Frontend
 Transport; Fri, 10 Nov 2023 12:52:30 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 MN1PEPF0000ECD8.mail.protection.outlook.com (10.167.242.137) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6977.16 via Frontend Transport; Fri, 10 Nov 2023 12:52:30 +0000
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.32; Fri, 10 Nov
 2023 06:52:29 -0600
Received: from amd-B450M-DS3H.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2507.32 via Frontend
 Transport; Fri, 10 Nov 2023 06:52:25 -0600
From:   Syed Saba Kareem <Syed.SabaKareem@amd.com>
To:     <broonie@kernel.org>, <alsa-devel@alsa-project.org>
CC:     <Vijendar.Mukunda@amd.com>, <Basavaraj.Hiregoudar@amd.com>,
        <Sunil-kumar.Dommati@amd.com>, <mario.limonciello@amd.com>,
        <Richard.Gong@amd.com>, <posteuca@mutex.one>,
        Syed Saba Kareem <Syed.SabaKareem@amd.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Jaroslav Kysela" <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        open list <linux-kernel@vger.kernel.org>
Subject: [PATCH 2/2] ASoC: amd: acp: add pm ops support for renoir platform Add pm ops for renoir platform.
Date:   Fri, 10 Nov 2023 18:22:10 +0530
Message-ID: <20231110125214.2127139-2-Syed.SabaKareem@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231110125214.2127139-1-Syed.SabaKareem@amd.com>
References: <20231110125214.2127139-1-Syed.SabaKareem@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MN1PEPF0000ECD8:EE_|DM6PR12MB4580:EE_
X-MS-Office365-Filtering-Correlation-Id: d77caecf-9be5-49c5-7a45-08dbe1ebe667
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +oEzr1/KJ66Mk0LvHaNeZuK85OP5Q6Q3tnLOkmttjmEH3kmg6sRXI/Qq6dJmcLVRWG4+8aUvThAZ9B9JLlUDAFY1Irjo3hA+/dgnD268Y1vz1DisaI8rxOqTeHPCjxpResZqp2dvQZyFuFqrZ2Z45bUDO4Lv+MvToYDrTrsWOCyA8nV+0d6Myf9g3EdySv+2Oz+GFoaXSFfya4dIkhgVcqsq/54YaMqrfjJe/HNTqZgKg7oBuikeDxg34UR4epTfNDBPpaUaFa4A1OwSjDZeZls5VksMU/l/fSJYBiKg6t49NEwq29q0gtm2dW1OXlsRCuc12YFRvjBSxxPrWfoUuFrSflxSr1bcZxoV3sjwWtbDbZRqQWM4mb1PebKDHUpnDrtO0kgRMV2Ee2eixuWySxGULfxQH7+ZkwMYuo5q7B1Vdb1DV1CJI2O5EgsdAqntC9z/OE7HX2io2/AZHs2asx3O0kz7gnWjWp8S5UoUDydzzNFJ7YWq+Z/780TF0yry86qXEqsADzwV9/uwFISfqVM6PsNvmPXzEKtGT3ZVw0VFzVac6gTwDvDcqHuGR3P+hzB6fYnRAKtSBDKfQs82+/Bhz3OprbZkr7/ygnnXTou4LJCeM+pcIfp85nuEeEgOGXcdGbWFKF01vdA2Eqdp09RiWRmHdJosUPNoyDSksEq7yBcSonSLEZiPaMjzk895/HgwCxPFVI7f3ZVOYmZeDnDpr4CPA85vj/q8/5wpim2bB/30rXQY4jOrEENImP6XfjzoZPU+yjTn52I3yv1YzQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230031)(4636009)(136003)(346002)(396003)(39860400002)(376002)(230922051799003)(186009)(1800799009)(451199024)(82310400011)(64100799003)(46966006)(36840700001)(40470700004)(70586007)(70206006)(110136005)(1076003)(2616005)(316002)(54906003)(40460700003)(86362001)(36860700001)(6666004)(36756003)(478600001)(7696005)(47076005)(41300700001)(7416002)(5660300002)(426003)(336012)(81166007)(356005)(82740400003)(8936002)(8676002)(4326008)(2906002)(83380400001)(26005)(40480700001)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Nov 2023 12:52:30.1849
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d77caecf-9be5-49c5-7a45-08dbe1ebe667
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: MN1PEPF0000ECD8.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4580
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Syed Saba Kareem <Syed.SabaKareem@amd.com>
---
 sound/soc/amd/acp/acp-renoir.c | 38 +++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

diff --git a/sound/soc/amd/acp/acp-renoir.c b/sound/soc/amd/acp/acp-renoir.c
index a591482a0726..8539fbacdf4c 100644
--- a/sound/soc/amd/acp/acp-renoir.c
+++ b/sound/soc/amd/acp/acp-renoir.c
@@ -20,6 +20,7 @@
 #include <sound/soc.h>
 #include <sound/soc-dai.h>
 #include <linux/dma-mapping.h>
+#include <linux/pm_runtime.h>
 
 #include "amd.h"
 #include "acp-mach.h"
@@ -195,7 +196,11 @@ static int renoir_audio_probe(struct platform_device *pdev)
 	dev_set_drvdata(dev, adata);
 	acp_enable_interrupts(adata);
 	acp_platform_register(dev);
-
+	pm_runtime_set_autosuspend_delay(&pdev->dev, ACP_SUSPEND_DELAY_MS);
+	pm_runtime_use_autosuspend(&pdev->dev);
+	pm_runtime_mark_last_busy(&pdev->dev);
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
 	return 0;
 }
 
@@ -208,11 +213,42 @@ static void renoir_audio_remove(struct platform_device *pdev)
 	acp_platform_unregister(dev);
 }
 
+static int __maybe_unused rn_pcm_resume(struct device *dev)
+{
+	struct acp_dev_data *adata = dev_get_drvdata(dev);
+	struct acp_stream *stream;
+	struct snd_pcm_substream *substream;
+	snd_pcm_uframes_t buf_in_frames;
+	u64 buf_size;
+
+	spin_lock(&adata->acp_lock);
+	list_for_each_entry(stream, &adata->stream_list, list) {
+		substream = stream->substream;
+		if (substream && substream->runtime) {
+			buf_in_frames = (substream->runtime->buffer_size);
+			buf_size = frames_to_bytes(substream->runtime, buf_in_frames);
+			config_pte_for_stream(adata, stream);
+			config_acp_dma(adata, stream, buf_size);
+			if (stream->dai_id)
+				restore_acp_i2s_params(substream, adata, stream);
+			else
+				restore_acp_pdm_params(substream, adata);
+		}
+	}
+	spin_unlock(&adata->acp_lock);
+	return 0;
+}
+
+static const struct dev_pm_ops rn_dma_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(NULL, rn_pcm_resume)
+};
+
 static struct platform_driver renoir_driver = {
 	.probe = renoir_audio_probe,
 	.remove_new = renoir_audio_remove,
 	.driver = {
 		.name = "acp_asoc_renoir",
+		.pm = &rn_dma_pm_ops,
 	},
 };
 
-- 
2.25.1

