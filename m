Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A52CD7B353C
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:32:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233625AbjI2OcS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbjI2OcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:32:08 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 433F5CE7;
        Fri, 29 Sep 2023 07:32:02 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-5335725cf84so16995615a12.2;
        Fri, 29 Sep 2023 07:32:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695997920; x=1696602720; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=En/oFUq/81cLOHvLKqdr065XPAN22won0/p2LOHNjFo=;
        b=IgN4X2H/oA7ny4yJRqfUCAtG7nqAjlAsDHlb9U7oqFDP/DCmaX/1ynjQI1hrAkGQHJ
         yWi4iAO0BNWozzViZo6ZC9Iyue9HRsZWeLIqlEy6SuuZx4ZD5ChiGhdEmGXHArltlf6M
         c7+A9BK+shntL7gHYaVxYP/hFpXTK/ZMe0NtGGs3mIj4A9FcTfaSQq1asGhmfLI8bBYG
         KPyz+WhrV/4/9ic/WXVnBnkQxG0FmyydgwYnM2HQdV1HbUww3lHuzzB2a3l8aLZJ3KEH
         i8dDgBqvsJNhBiwEWWN/UqhiyJojgBwgHuakn//D8DMNZp5qvSI3k/9j9pgOv5/xASpv
         aCgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997920; x=1696602720;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=En/oFUq/81cLOHvLKqdr065XPAN22won0/p2LOHNjFo=;
        b=MKvdDj4ubZ8ZdB453TXsRe4fOMX1Nt6Jfts9IlB3Kfg0awsjB91fD4OwUM5EBfsdPP
         5ZCS+s9jsKtcMRbpvEEk7P5ziqsu8O78EkYVreAlqLxYsCt6dPppcEKFrDvXAec1G2K+
         3eUjxmwW/0xSD0ZIX/bX9c88RFQfkkGZIynTwK6wfz4iMvyIRMrnZq8cN0HTwa8yiZ1w
         FeSxi513GPfxp4t7VQZIBsW0za0iqW2QZaEXgfuCA0k561XTxpafNFvlSRe1QnRVTVVQ
         4EXGtFK9pyDT5a9QYjIkZ9rkZoG9J+h9Ogkcxi3xyePf9CnXCMFHiPV2DpVRXlYpCMXw
         e8Og==
X-Gm-Message-State: AOJu0YxP9kV4Gas3IH3UyNcO9Et3Vk7AfL6ayoNa9TqqEWplbPy+ngdP
        ZipSfymozKb0vV+0PMYU5mk=
X-Google-Smtp-Source: AGHT+IHZ4WyuCzDdcp1H46pZ9Vs947mD0m6YOZdVh/HM1tFrcxtNSIzFIGPXj54I4ensBPu96hWMBw==
X-Received: by 2002:a17:906:1bb2:b0:9ae:7204:3656 with SMTP id r18-20020a1709061bb200b009ae72043656mr4232051ejg.60.1695997920584;
        Fri, 29 Sep 2023 07:32:00 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id a7-20020a170906670700b0099293cdbc98sm12660105ejp.145.2023.09.29.07.31.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:32:00 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v8 03/14] USB: typec: tps6598x: Add patch mode to tps6598x
Date:   Fri, 29 Sep 2023 10:30:44 -0400
Message-Id: <20230929143055.31360-4-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230929143055.31360-1-alkuor@gmail.com>
References: <20230929143055.31360-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Abdel Alkuor <abdelalkuor@geotab.com>

TPS25750 has a patch mode indicating the device requires
a configuration to get the device into operational mode

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v8:
  - Revert mode check return
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
  - Return current mode and check it directly
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 32420c61660d..c5bbf03cb74a 100644
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
@@ -595,6 +597,7 @@ static int tps6598x_check_mode(struct tps6598x *tps)
 
 	switch (match_string(modes, ARRAY_SIZE(modes), mode)) {
 	case TPS_MODE_APP:
+	case TPS_MODE_PTCH:
 		return 0;
 	case TPS_MODE_BOOT:
 		dev_warn(tps->dev, "dead-battery condition\n");
-- 
2.34.1

