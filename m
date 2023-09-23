Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4185E7ABE6A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbjIWHk4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230211AbjIWHks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:40:48 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DBE419E;
        Sat, 23 Sep 2023 00:40:40 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id ffacd0b85a97d-323168869daso727110f8f.2;
        Sat, 23 Sep 2023 00:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695454839; x=1696059639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=a5WaQghfdBPPUPM6BGBEffjVf/GTvuPkbvL3qgXS12Q=;
        b=jle+5t/6LOQmDrv2I7O//erp3l225mtdhWseTgfo/I0obBfZtRRRiMdRhUFUIifN1V
         Dnc3Yo9X8MSLckYjppF3X88Q7JADdz4RuJJYQG0efQQB5aLXVPkO3ojOdXlFbAGfMTU0
         0nuFxDiPrzYgjGliDiTUb6j0G2tM/zPtYgPoM0OSKQhoGlV/LFrN2qi1GPxmxKYTXYIl
         OUqmwEupkY+X/lB8w3v+4K2EkNNRH+yfevBoO6ugRLmCC7aEwA8jYi2kyB1qhWTpcVBv
         mBnbQmrOFX+PgjcHuD35f7QcmpHYl2L1sB7AK9oUzxbcOJvrnIb92BIvMVcujdS0l2bj
         9Snw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695454839; x=1696059639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=a5WaQghfdBPPUPM6BGBEffjVf/GTvuPkbvL3qgXS12Q=;
        b=sauF0ALJaPCjsj1CzdW81ZjQ0dzWBH2nMA4H2Uiz/+J0NQQkuVd1VRRavrFqgTA3dK
         2q13GpjNS7dZd+fg48XRxhH2K6HQFXN5ivWNquJJKnrNVE/ku2sFfAphtJM53QStxsKH
         puiIH3AjNZ43RtfzlVAkMApAglbAKet07Nj62ewpv6ZkFx9+39TZQA2KpfMexBXJmZuE
         ADlT99S7t+RlwC25P26TOrQJO/A8wOuYSqyMCfe02hfynjSbd0O6oKlJxMpZghpLLFCJ
         kcmnRS6cIP6fm1+yHBc0BUmh4nEa1HbOyx87085nAA9080TODmSTOBauegASlyM0K6Ig
         ExVg==
X-Gm-Message-State: AOJu0YxdfANImwPUF1xBn4opwffE0g/880if+EhN7/p72SYn+1UVq3IJ
        ocJgx/aWbP5AWrguv2rgDZ0=
X-Google-Smtp-Source: AGHT+IGqGD+OvqGjXb+4VjPi/pTWPjPRqbhaqoqz/0MXokUq4RUzJM94duUXzCRb4A6ht57AoqWNPg==
X-Received: by 2002:a05:6000:51:b0:319:77dd:61f9 with SMTP id k17-20020a056000005100b0031977dd61f9mr1437890wrx.35.1695454839065;
        Sat, 23 Sep 2023 00:40:39 -0700 (PDT)
Received: from primary.. ([213.139.62.222])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe3c6000000b003196e992567sm6236955wrm.115.2023.09.23.00.40.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 00:40:38 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        ryan.eleceng@gmail.com, Abdel Alkuor <alkuor@gmail.com>
Subject: [PATCH v6 03/14] USB: typec: Add patch mode to tps6598x
Date:   Sat, 23 Sep 2023 03:39:48 -0400
Message-Id: <20230923073959.86660-4-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923073959.86660-1-alkuor@gmail.com>
References: <20230923073959.86660-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

TPS25750 has a patch mode indicating the device requires
a configuration to get the device into operational mode

Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
---
Changes in v6:
  - Return current mode and check it directly
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 32420c61660d..58679b1c0cfe 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -68,6 +68,7 @@ enum {
 	TPS_MODE_BOOT,
 	TPS_MODE_BIST,
 	TPS_MODE_DISC,
+	TPS_MODE_PTCH,
 };
 
 static const char *const modes[] = {
@@ -75,6 +76,7 @@ static const char *const modes[] = {
 	[TPS_MODE_BOOT]	= "BOOT",
 	[TPS_MODE_BIST]	= "BIST",
 	[TPS_MODE_DISC]	= "DISC",
+	[TPS_MODE_PTCH] = "PTCH",
 };
 
 /* Unrecognized commands will be replaced with "!CMD" */
@@ -593,12 +595,15 @@ static int tps6598x_check_mode(struct tps6598x *tps)
 	if (ret)
 		return ret;
 
-	switch (match_string(modes, ARRAY_SIZE(modes), mode)) {
+	ret = match_string(modes, ARRAY_SIZE(modes), mode);
+
+	switch (ret) {
 	case TPS_MODE_APP:
-		return 0;
+	case TPS_MODE_PTCH:
+		return ret;
 	case TPS_MODE_BOOT:
 		dev_warn(tps->dev, "dead-battery condition\n");
-		return 0;
+		return ret;
 	case TPS_MODE_BIST:
 	case TPS_MODE_DISC:
 	default:
@@ -765,7 +770,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	tps->irq_handler = irq_handler;
 	/* Make sure the controller has application firmware running */
 	ret = tps6598x_check_mode(tps);
-	if (ret)
+	if (ret < 0)
 		return ret;
 
 	ret = tps6598x_write64(tps, TPS_REG_INT_MASK1, mask1);
-- 
2.34.1

