Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4756477E6F0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Aug 2023 18:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344947AbjHPQtn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Aug 2023 12:49:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344989AbjHPQtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Aug 2023 12:49:33 -0400
Received: from mx0b-001ae601.pphosted.com (mx0a-001ae601.pphosted.com [67.231.149.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22913272C
        for <linux-kernel@vger.kernel.org>; Wed, 16 Aug 2023 09:49:23 -0700 (PDT)
Received: from pps.filterd (m0077473.ppops.net [127.0.0.1])
        by mx0a-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37G5L6Uk023417;
        Wed, 16 Aug 2023 11:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=UUPGKPIvg91WsHyFvxHJWoMkr53Ll949FGnSoWu7Ngs=; b=
        GCt+VPzRQ1Fd7IpBJkb/gZ52PqMIr3WLoJ98064D0f7Mtr3uvOSuDJcSPMwiFTSS
        ZZYaQz4Gdf7YQi4OVEe73kMYkWSbBkrDy462IAHuf6Xsf0tN3h/xF/uMUQ8G7I5+
        N5jMsBQ8cbIxPAj1O3TFsnsMS5V15xOSrk24fAdFgoLI5k1HgEN2ZZghdLAGsvHj
        cNLnhUP+Zp23wiTDWo5SUnq9XXniieXX4y/qYLlRa/VnGlTw4GY3YwiujusblmwM
        SeDPIAGZ4sWx9JrOhLvs9cz8XYgGsNsJx7USwkm2IcGDYAa40n1tJeJbylJXWocO
        4+JDTSGuXsNETgXlflR/lA==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0a-001ae601.pphosted.com (PPS) with ESMTPS id 3se8kqw8gb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 16 Aug 2023 11:49:11 -0500 (CDT)
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Wed, 16 Aug
 2023 17:49:09 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.30 via Frontend
 Transport; Wed, 16 Aug 2023 17:49:09 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id E1086357C;
        Wed, 16 Aug 2023 16:49:08 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH 1/2] ASoC: cs35l56: Add an ACPI match table
Date:   Wed, 16 Aug 2023 17:49:05 +0100
Message-ID: <20230816164906.42-2-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230816164906.42-1-rf@opensource.cirrus.com>
References: <20230816164906.42-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: pFMkl0uwKaYpL1etsocYnaH0oALP3Lat
X-Proofpoint-GUID: pFMkl0uwKaYpL1etsocYnaH0oALP3Lat
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Simon Trimmer <simont@opensource.cirrus.com>

An ACPI ID has been allocated for CS35L56 ASoC devices so that they can
be instantiated from ACPI Device entries.

Signed-off-by: Simon Trimmer <simont@opensource.cirrus.com>
Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
---
 sound/soc/codecs/cs35l56-i2c.c | 9 +++++++++
 sound/soc/codecs/cs35l56-spi.c | 9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/sound/soc/codecs/cs35l56-i2c.c b/sound/soc/codecs/cs35l56-i2c.c
index 888fdfa5f5db..9f4f2f4f23f5 100644
--- a/sound/soc/codecs/cs35l56-i2c.c
+++ b/sound/soc/codecs/cs35l56-i2c.c
@@ -62,10 +62,19 @@ static const struct i2c_device_id cs35l56_id_i2c[] = {
 };
 MODULE_DEVICE_TABLE(i2c, cs35l56_id_i2c);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cs35l56_asoc_acpi_match[] = {
+	{ "CSC355C", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, cs35l56_asoc_acpi_match);
+#endif
+
 static struct i2c_driver cs35l56_i2c_driver = {
 	.driver = {
 		.name		= "cs35l56",
 		.pm = &cs35l56_pm_ops_i2c_spi,
+		.acpi_match_table = ACPI_PTR(cs35l56_asoc_acpi_match),
 	},
 	.id_table	= cs35l56_id_i2c,
 	.probe		= cs35l56_i2c_probe,
diff --git a/sound/soc/codecs/cs35l56-spi.c b/sound/soc/codecs/cs35l56-spi.c
index 2057fce435be..9962703915e1 100644
--- a/sound/soc/codecs/cs35l56-spi.c
+++ b/sound/soc/codecs/cs35l56-spi.c
@@ -59,10 +59,19 @@ static const struct spi_device_id cs35l56_id_spi[] = {
 };
 MODULE_DEVICE_TABLE(spi, cs35l56_id_spi);
 
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id cs35l56_asoc_acpi_match[] = {
+	{ "CSC355C", 0 },
+	{},
+};
+MODULE_DEVICE_TABLE(acpi, cs35l56_asoc_acpi_match);
+#endif
+
 static struct spi_driver cs35l56_spi_driver = {
 	.driver = {
 		.name		= "cs35l56",
 		.pm = &cs35l56_pm_ops_i2c_spi,
+		.acpi_match_table = ACPI_PTR(cs35l56_asoc_acpi_match),
 	},
 	.id_table	= cs35l56_id_spi,
 	.probe		= cs35l56_spi_probe,
-- 
2.30.2

