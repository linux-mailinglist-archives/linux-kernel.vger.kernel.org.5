Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0531280E38E
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:12:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229644AbjLLFJi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:09:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbjLLFJg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:09:36 -0500
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1178FCF;
        Mon, 11 Dec 2023 21:09:41 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 3BC58fjn084073;
        Mon, 11 Dec 2023 23:08:41 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1702357721;
        bh=yELq1Mi9FQc6Zi7zKHsjrTGWfdpBsQA4h2JwbNMN7Ak=;
        h=From:To:CC:Subject:Date;
        b=QJ4jwys/ycHYS5UY2u+BPcf4kI/GcrgXUGoRz2X92XFJtG8jZiNDFk4rjStGPdOwg
         FEmKmbRhWQddgyU09fUg+iZ+6Mu8Rhl/RJan7WW4BjDTLdjsAYN+1GrE+xWwA3WYFo
         bYpWtQPrrD+UoG57DrmJhafbI6LMV7RWcvRwDjTg=
Received: from DLEE102.ent.ti.com (dlee102.ent.ti.com [157.170.170.32])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 3BC58fPc023283
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 11 Dec 2023 23:08:41 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Mon, 11
 Dec 2023 23:08:41 -0600
Received: from lelvsmtp5.itg.ti.com (10.180.75.250) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Mon, 11 Dec 2023 23:08:41 -0600
Received: from LT5CG31242FY.dhcp.ti.com (lt5cg31242fy.dhcp.ti.com [10.85.8.120])
        by lelvsmtp5.itg.ti.com (8.15.2/8.15.2) with ESMTP id 3BC58Zhl003698;
        Mon, 11 Dec 2023 23:08:36 -0600
From:   Shenghao Ding <shenghao-ding@ti.com>
To:     <broonie@kernel.org>, <conor+dt@kernel.org>,
        <krzysztof.kozlowski@linaro.org>
CC:     <robh+dt@kernel.org>, <andriy.shevchenko@linux.intel.com>,
        <devicetree@vger.kernel.org>, <lgirdwood@gmail.com>,
        <perex@perex.cz>, <pierre-louis.bossart@linux.intel.com>,
        <13916275206@139.com>, <linux-sound@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <liam.r.girdwood@intel.com>,
        <soyer@irl.hu>, <tiwai@suse.de>, <peeyush@ti.com>, <navada@ti.com>,
        Shenghao Ding <shenghao-ding@ti.com>
Subject: [PATCH v1] ASoC: tas2562: remove tas2563 into driver
Date:   Tue, 12 Dec 2023 13:08:31 +0800
Message-ID: <20231212050831.982-1-shenghao-ding@ti.com>
X-Mailer: git-send-email 2.33.0.windows.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove tas2563 from tas2562, it will be supported in separated driver code.

Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
---
 sound/soc/codecs/tas2562.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/sound/soc/codecs/tas2562.c b/sound/soc/codecs/tas2562.c
index 962c2cdfa017..54561ae598b8 100644
--- a/sound/soc/codecs/tas2562.c
+++ b/sound/soc/codecs/tas2562.c
@@ -59,7 +59,6 @@ struct tas2562_data {
 
 enum tas256x_model {
 	TAS2562,
-	TAS2563,
 	TAS2564,
 	TAS2110,
 };
@@ -721,7 +720,6 @@ static int tas2562_parse_dt(struct tas2562_data *tas2562)
 
 static const struct i2c_device_id tas2562_id[] = {
 	{ "tas2562", TAS2562 },
-	{ "tas2563", TAS2563 },
 	{ "tas2564", TAS2564 },
 	{ "tas2110", TAS2110 },
 	{ }
@@ -770,7 +768,6 @@ static int tas2562_probe(struct i2c_client *client)
 #ifdef CONFIG_OF
 static const struct of_device_id tas2562_of_match[] = {
 	{ .compatible = "ti,tas2562", },
-	{ .compatible = "ti,tas2563", },
 	{ .compatible = "ti,tas2564", },
 	{ .compatible = "ti,tas2110", },
 	{ },
-- 
2.34.1

