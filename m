Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614917A3659
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236193AbjIQP2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbjIQP1a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:27:30 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56E2418B;
        Sun, 17 Sep 2023 08:27:25 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-402c46c49f4so39994775e9.1;
        Sun, 17 Sep 2023 08:27:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694964444; x=1695569244; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ca93iTqJpSx/plxX75j5Y8vcvCYToSV9JbO7YLCJdoA=;
        b=C9/3hplKd8qlo2ppa8L+ohT4dtw+/PX2o77OEcce0LNqarToW3u4OTgl/N7QHhWpPA
         au5H/ON8jsfQ7H1Od4BCcMHIQn4ELczUAoLhejQjov76N2fUf4gwowcjpy6kAs2Ba8gy
         sxOsFqvutgEfzaeYDZxpOiwgYdKrwv89wNtnuhMSr+Akq5f3yHxkCG1p6ERmGY3dlAV/
         ib95q445tg0zSBRaeBVgpO42zUzqXKZjOq6WXsFLw/TaeT6+V5GcaWwdRSYhzf+K/16q
         /w0Mq+B1Y9SnrQt5Lni5LAKsBwP3g+ay83e4bJm11JMYR8iqK5n9pmKsicBjCa8qnPx1
         BEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694964444; x=1695569244;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ca93iTqJpSx/plxX75j5Y8vcvCYToSV9JbO7YLCJdoA=;
        b=JAyxkcjSr/+kEKIF0sIn8rUFx5DcZn3ItICYDZPwhY/3aP3rRl4105NIcPCOrnbWDQ
         Zt97DocdZvIAPyIPGWyZyD62MgHgcUsaaihjOtTjiMfnCryLPu4jLEkLX437hSR2m/05
         FxjlZcdXI8/K7xOXFCM2C2eLcSDASe4RDfiBiwe2h/mWPdsqiYnJVbRgZ93BBIfOj98b
         IRdAZHIa7b7HRRo92yejdJD/9tDnosaqW3uJ4SCjEfzZQsIT+wQVOrkBfQJAD6m8/xfH
         W24ooRotdtfzp4Nr1ZUUI2LoI/hF1DD9KJ8riuKOrkKY3KNvnbsQWz2Qk8w9+lU36AIJ
         m21g==
X-Gm-Message-State: AOJu0YzlodmFNKaoSD/5BoitusjWkJ9jluOFQyBL5sJGJe1FXHDf+Cu+
        OzMj6a/H1CKFdl4FNDv7j80=
X-Google-Smtp-Source: AGHT+IEhCdOXPEWVKfUzjHWZyi9HFGsZVEbrsH6gbLnrQoi9K5ObS1JXY0QX0vLnLRbav0lv9Qb3sQ==
X-Received: by 2002:a7b:c40d:0:b0:402:cc5c:c98 with SMTP id k13-20020a7bc40d000000b00402cc5c0c98mr5999011wmi.13.1694964443723;
        Sun, 17 Sep 2023 08:27:23 -0700 (PDT)
Received: from localhost.localdomain ([5.45.134.53])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c489700b003fe15ac0934sm7388865wmp.1.2023.09.17.08.27.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 08:27:23 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com, Abdel Alkuor <alkuor@gmail.com>
Subject: [PATCH v5 03/15] USB: typec: Add patch mode to tps6598x
Date:   Sun, 17 Sep 2023 11:26:27 -0400
Message-Id: <20230917152639.21443-4-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230917152639.21443-1-alkuor@gmail.com>
References: <20230917152639.21443-1-alkuor@gmail.com>
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
 drivers/usb/typec/tipd/core.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index a8aee4e1aeba..6d2151325fbb 100644
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
@@ -576,7 +578,7 @@ static void tps6598x_poll_work(struct work_struct *work)
 			   &tps->wq_poll, msecs_to_jiffies(POLL_INTERVAL));
 }
 
-static int tps6598x_check_mode(struct tps6598x *tps)
+static int tps6598x_check_mode(struct tps6598x *tps, u8 *curr_mode)
 {
 	char mode[5] = { };
 	int ret;
@@ -585,8 +587,11 @@ static int tps6598x_check_mode(struct tps6598x *tps)
 	if (ret)
 		return ret;
 
-	switch (match_string(modes, ARRAY_SIZE(modes), mode)) {
+	*curr_mode = match_string(modes, ARRAY_SIZE(modes), mode);
+
+	switch (*curr_mode) {
 	case TPS_MODE_APP:
+	case TPS_MODE_PTCH:
 		return 0;
 	case TPS_MODE_BOOT:
 		dev_warn(tps->dev, "dead-battery condition\n");
@@ -715,6 +720,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	u32 vid;
 	int ret;
 	u64 mask1;
+	u8 mode;
 
 	tps = devm_kzalloc(&client->dev, sizeof(*tps), GFP_KERNEL);
 	if (!tps)
@@ -759,7 +765,7 @@ static int tps6598x_probe(struct i2c_client *client)
 
 	tps->irq_handler = irq_handler;
 	/* Make sure the controller has application firmware running */
-	ret = tps6598x_check_mode(tps);
+	ret = tps6598x_check_mode(tps, &mode);
 	if (ret)
 		return ret;
 
-- 
2.34.1

