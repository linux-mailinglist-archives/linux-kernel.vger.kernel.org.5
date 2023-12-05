Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BF98053A5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Dec 2023 12:57:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347030AbjLEL5h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Dec 2023 06:57:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345120AbjLEL5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Dec 2023 06:57:36 -0500
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9935298;
        Tue,  5 Dec 2023 03:57:42 -0800 (PST)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 3B56Q8Dw003885;
        Tue, 5 Dec 2023 05:57:32 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=
        from:to:cc:subject:date:message-id:mime-version
        :content-transfer-encoding:content-type; s=PODMain02222019; bh=z
        DLALbyZh6I9uDhyNX6OYJI2uOcXDuFhbmIPNGNpiVI=; b=ncowCnTrliqfTm/9b
        lYMjhAOJCxU9R2sAkT61P+SWCM48oFKkDKnfFrMmUeuK1UKGsU30yqAv03+XpfCQ
        rnv+JPzbCEer5y9/J2upe77KBTywcm5+4McXM0k3Kx9BVolpCeqeqWMpwIfX5xUi
        +xrEdu520dLnPf60EIOvzrvelMNzLvwhFxUkKfb09ZvbaaLVLqYn6nE3OCyuNhbY
        3ocUuc7Lbb1P6ZE7rTao6x3HciCytye1ipbMry9XU0Bxli2nU5k2pkMg927fiD0P
        EMR83jVVpXJKKg5GjhIgDzhT6EE7vMcs/+rgM8ZPCEZiE5RbNhTW4fqxCB3kc98R
        w9b6Q==
Received: from ediex01.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3ur1vnk6cu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 05 Dec 2023 05:57:32 -0600 (CST)
Received: from ediex02.ad.cirrus.com (198.61.84.81) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Tue, 5 Dec
 2023 11:57:16 +0000
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by
 anon-ediex02.ad.cirrus.com (198.61.84.81) with Microsoft SMTP Server id
 15.2.1118.40 via Frontend Transport; Tue, 5 Dec 2023 11:57:15 +0000
Received: from edi-sw-dsktp-006.ad.cirrus.com (edi-sw-dsktp-006.ad.cirrus.com [198.90.251.82])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id CD6CC474;
        Tue,  5 Dec 2023 11:57:15 +0000 (UTC)
From:   Richard Fitzgerald <rf@opensource.cirrus.com>
To:     <broonie@kernel.org>, <pierre-louis.bossart@linux.intel.com>
CC:     <peter.ujfalusi@linux.intel.com>,
        <yung-chuan.liao@linux.intel.com>, <kai.vehmanen@linux.intel.com>,
        <cezary.rojewski@intel.com>, <ranjani.sridharan@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <patches@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>
Subject: [PATCH] ASoC: Intel: soc-acpi-intel-mtl-match: Change CS35L56 prefixes to AMPn
Date:   Tue, 5 Dec 2023 11:57:15 +0000
Message-ID: <20231205115715.2460386-1-rf@opensource.cirrus.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: u_Z-suDzWBBvV_Jjv4TSiVPNc79YICfc
X-Proofpoint-ORIG-GUID: u_Z-suDzWBBvV_Jjv4TSiVPNc79YICfc
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the ALSA prefix for the CS35L56 to "AMPn".

This keeps them consistent with the CS35L56 HDA driver. It also
avoids coding the chip ID into the control name, so that other
Cirrus amps with the same controls can have the same control
names.

Signed-off-by: Richard Fitzgerald <rf@opensource.cirrus.com>
Fixes: 05fe62842804 ("ASoC: Intel: soc-acpi-intel-mtl-match: add acpi match table for cdb35l56-eight-c")
---
 sound/soc/intel/common/soc-acpi-intel-mtl-match.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
index f2c17cee1a5d..feb12c6c85d1 100644
--- a/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
+++ b/sound/soc/intel/common/soc-acpi-intel-mtl-match.c
@@ -352,13 +352,13 @@ static const struct snd_soc_acpi_adr_device cs35l56_1_adr[] = {
 		.adr = 0x00013701FA355601ull,
 		.num_endpoints = 1,
 		.endpoints = &spk_r_endpoint,
-		.name_prefix = "cs35l56-8"
+		.name_prefix = "AMP8"
 	},
 	{
 		.adr = 0x00013601FA355601ull,
 		.num_endpoints = 1,
 		.endpoints = &spk_3_endpoint,
-		.name_prefix = "cs35l56-7"
+		.name_prefix = "AMP7"
 	}
 };
 
@@ -367,13 +367,13 @@ static const struct snd_soc_acpi_adr_device cs35l56_2_adr[] = {
 		.adr = 0x00023301FA355601ull,
 		.num_endpoints = 1,
 		.endpoints = &spk_l_endpoint,
-		.name_prefix = "cs35l56-1"
+		.name_prefix = "AMP1"
 	},
 	{
 		.adr = 0x00023201FA355601ull,
 		.num_endpoints = 1,
 		.endpoints = &spk_2_endpoint,
-		.name_prefix = "cs35l56-2"
+		.name_prefix = "AMP2"
 	}
 };
 
-- 
2.30.2

