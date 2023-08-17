Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1605877F53F
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 13:29:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350320AbjHQL3H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 07:29:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350412AbjHQL26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 07:28:58 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 231B735A2
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 04:28:32 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.22/8.17.1.22) with ESMTP id 37HBMpDm018403;
        Thu, 17 Aug 2023 06:27:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:in-reply-to:references
        :mime-version:content-transfer-encoding:content-type; s=
        PODMain02222019; bh=cJhm+19aqjGyHFplA6rx/pJkqmR6MgcxkXDRw5sXF6s=; b=
        pqn0Gz21TSI4bhAxzanvx9RQO+GsfPoAj0GhXy+wMWx2+65oL1mhrx0m1wepdVJQ
        zawTCzsdIQHdfllxEM1jQZcobUdM+BB0eDDkkrXkcU+/WwzB3MCCOVsyQfyOqAd3
        hnKAP0IZ5MgRv6PchfJYIqSfLdEQ1ss4XLa1PcIEMoejjZJusbpe9UOSWiNnbCtT
        eTez8S6kKrr9io8svLpwBUtgeUUsDP5sI6cuUm6iIINJOxE94IKlyyPcmYM0gzvQ
        tUb48WFyuyMkE1OAwr2SuuXSz/uhJieggYUbRv2kXUF2j/gfbk/x9QnGLacmOptI
        3a+PD9P/G01c9ptidRJTUw==
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3se6uhn8td-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 17 Aug 2023 06:27:17 -0500 (CDT)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.30; Thu, 17 Aug
 2023 12:27:15 +0100
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.30 via Frontend Transport; Thu, 17 Aug 2023 12:27:15 +0100
Received: from EDIN4L06LR3.ad.cirrus.com (EDIN4L06LR3.ad.cirrus.com [198.61.65.68])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 9CAB13575;
        Thu, 17 Aug 2023 11:27:15 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>
CC:     <alsa-devel@alsa-project.org>, <linux-kernel@vger.kernel.org>,
        <patches@opensource.cirrus.com>,
        Simon Trimmer <simont@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH v2 2/2] ASoC: cs35l56: Add an ACPI match table
Date:   Thu, 17 Aug 2023 12:27:12 +0100
Message-ID: <20230817112712.16637-3-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230817112712.16637-1-rf@opensource.cirrus.com>
References: <20230817112712.16637-1-rf@opensource.cirrus.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: _I51-rMG48qDk6ZUrRr_szd0HuuMmdmb
X-Proofpoint-ORIG-GUID: _I51-rMG48qDk6ZUrRr_szd0HuuMmdmb
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
index ed2a41943d97..40666e6698ba 100644
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
index 996aab10500e..302f9c47407a 100644
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

