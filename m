Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 449BC7A3652
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237132AbjIQP2N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:28:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234782AbjIQP1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:27:47 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8940211F;
        Sun, 17 Sep 2023 08:27:41 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-32003aae100so564774f8f.0;
        Sun, 17 Sep 2023 08:27:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694964460; x=1695569260; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DBK+EuhlZqztM+Alma3nr5nA9Qm2t1d0t11jSRG7m0Q=;
        b=cc1gvsdwENHqJp29Yvy07Smcane7fTY7Hu3q0f2pkmamlPuceshYhxFMCnrXodWFM+
         pDNxuHdRu/Q0iaC2hBbgnN56hwMEZ9NtUgdnZc6l+crZ8SaFMCedxYkHOjqv+Em68ybU
         UXHG8TIkhU/su077BkjTi9nyMblAJrI1rz5e/gwJVLcq/FqdIYjLbvJx1NE+fEXy2c3n
         Fo21Q3JPl0xFCjJ90v597ZaYi96ZX8SNjUYxymwGMngDqBiKiul76ofMZ8eT8L9sAMXE
         qjeA+pGQiADzJuG92pee48Iq4HtLgh82RqZbnoMiPg53a0RHoJjbDzOo8TBZSkvFEbkG
         Jn8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694964460; x=1695569260;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DBK+EuhlZqztM+Alma3nr5nA9Qm2t1d0t11jSRG7m0Q=;
        b=JABQ70HbXajOFmBWEH2xJEcjT6AZHOlD8c5bW/VAxWiGfRFfKc8sm+sWutjZtTRVg3
         /BXMho1yTo/Ty5HNH7xRsXSYuRIK5rq6fFpTEabRUwFdJ54rbOjFvPl8GJEtwF6Xg/2i
         0YmrXacskhwC38I2QHS6UsWQuslm7cow4SKb21lQacSf0LOvJIb3uF/1lXYvi6vd1BGn
         4xoPUKmHBuPKMr4smN4VK05xaFXzYHo20/rEV3Otg+71q8SDPOEG2H7k8etZA0/pBOdf
         3HOlmblil76euD3tClP/I/GUg2x5k4fe9NUFZbEbpzYSRSA8hNxEYHa2WZZxcBIhMxRx
         hH+A==
X-Gm-Message-State: AOJu0YxtBmHiek4Z4qW1i0jEI0OD5cjW6X0geePRZDrrR3Pv6Wutwlwh
        gS4bUywIaZvm/yT3cGe1MZI=
X-Google-Smtp-Source: AGHT+IHhkqw+OHSOmFSTdEoq5773mUgp2STJiAqBe8b13HYPxJ4M4UUXZ8onuJKTHZGa1ibtNCLIcw==
X-Received: by 2002:adf:ea02:0:b0:317:dadc:4a63 with SMTP id q2-20020adfea02000000b00317dadc4a63mr7509736wrm.8.1694964459904;
        Sun, 17 Sep 2023 08:27:39 -0700 (PDT)
Received: from localhost.localdomain ([5.45.134.53])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c489700b003fe15ac0934sm7388865wmp.1.2023.09.17.08.27.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 08:27:39 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: [PATCH v5 09/15] USB: typec: Refactor tps6598x port registration
Date:   Sun, 17 Sep 2023 11:26:33 -0400
Message-Id: <20230917152639.21443-10-alkuor@gmail.com>
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

From: Abdel Alkuor <abdelalkuor@geotab.com>

tps6598x and cd321x use TPS_REG_SYSTEM_CONF to get dr/pr roles
where other similar devices don't have this register such as tps25750.

Move tps6598x port registration to its own function

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
 drivers/usb/typec/tipd/core.c | 99 +++++++++++++++++++----------------
 1 file changed, 54 insertions(+), 45 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 17b3bc480f97..8218d88a4a06 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -976,15 +976,65 @@ static int tps25750_apply_patch(struct tps6598x *tps)
 	return 0;
 };
 
+static int
+tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
+{
+	int ret;
+	u32 conf;
+	struct typec_capability typec_cap = { };
+
+	ret = tps6598x_read32(tps, TPS_REG_SYSTEM_CONF, &conf);
+	if (ret)
+		return ret;
+
+	typec_cap.revision = USB_TYPEC_REV_1_2;
+	typec_cap.pd_revision = 0x200;
+	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
+	typec_cap.driver_data = tps;
+	typec_cap.ops = &tps6598x_ops;
+	typec_cap.fwnode = fwnode;
+
+	switch (TPS_SYSCONF_PORTINFO(conf)) {
+	case TPS_PORTINFO_SINK_ACCESSORY:
+	case TPS_PORTINFO_SINK:
+		typec_cap.type = TYPEC_PORT_SNK;
+		typec_cap.data = TYPEC_PORT_UFP;
+		break;
+	case TPS_PORTINFO_DRP_UFP_DRD:
+	case TPS_PORTINFO_DRP_DFP_DRD:
+		typec_cap.type = TYPEC_PORT_DRP;
+		typec_cap.data = TYPEC_PORT_DRD;
+		break;
+	case TPS_PORTINFO_DRP_UFP:
+		typec_cap.type = TYPEC_PORT_DRP;
+		typec_cap.data = TYPEC_PORT_UFP;
+		break;
+	case TPS_PORTINFO_DRP_DFP:
+		typec_cap.type = TYPEC_PORT_DRP;
+		typec_cap.data = TYPEC_PORT_DFP;
+		break;
+	case TPS_PORTINFO_SOURCE:
+		typec_cap.type = TYPEC_PORT_SRC;
+		typec_cap.data = TYPEC_PORT_DFP;
+		break;
+	default:
+		return -ENODEV;
+	}
+
+	tps->port = typec_register_port(tps->dev, &typec_cap);
+	if (IS_ERR(tps->port))
+		return PTR_ERR(tps->port);
+
+	return 0;
+}
+
 static int tps6598x_probe(struct i2c_client *client)
 {
 	irq_handler_t irq_handler = tps6598x_interrupt;
 	struct device_node *np = client->dev.of_node;
-	struct typec_capability typec_cap = { };
 	struct tps6598x *tps;
 	struct fwnode_handle *fwnode;
 	u32 status;
-	u32 conf;
 	u32 vid;
 	int ret;
 	u64 mask1;
@@ -1053,10 +1103,6 @@ static int tps6598x_probe(struct i2c_client *client)
 		goto err_clear_mask;
 	trace_tps6598x_status(status);
 
-	ret = tps6598x_read32(tps, TPS_REG_SYSTEM_CONF, &conf);
-	if (ret < 0)
-		goto err_clear_mask;
-
 	/*
 	 * This fwnode has a "compatible" property, but is never populated as a
 	 * struct device. Instead we simply parse it to read the properties.
@@ -1074,50 +1120,13 @@ static int tps6598x_probe(struct i2c_client *client)
 		goto err_fwnode_put;
 	}
 
-	typec_cap.revision = USB_TYPEC_REV_1_2;
-	typec_cap.pd_revision = 0x200;
-	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
-	typec_cap.driver_data = tps;
-	typec_cap.ops = &tps6598x_ops;
-	typec_cap.fwnode = fwnode;
-
-	switch (TPS_SYSCONF_PORTINFO(conf)) {
-	case TPS_PORTINFO_SINK_ACCESSORY:
-	case TPS_PORTINFO_SINK:
-		typec_cap.type = TYPEC_PORT_SNK;
-		typec_cap.data = TYPEC_PORT_UFP;
-		break;
-	case TPS_PORTINFO_DRP_UFP_DRD:
-	case TPS_PORTINFO_DRP_DFP_DRD:
-		typec_cap.type = TYPEC_PORT_DRP;
-		typec_cap.data = TYPEC_PORT_DRD;
-		break;
-	case TPS_PORTINFO_DRP_UFP:
-		typec_cap.type = TYPEC_PORT_DRP;
-		typec_cap.data = TYPEC_PORT_UFP;
-		break;
-	case TPS_PORTINFO_DRP_DFP:
-		typec_cap.type = TYPEC_PORT_DRP;
-		typec_cap.data = TYPEC_PORT_DFP;
-		break;
-	case TPS_PORTINFO_SOURCE:
-		typec_cap.type = TYPEC_PORT_SRC;
-		typec_cap.data = TYPEC_PORT_DFP;
-		break;
-	default:
-		ret = -ENODEV;
-		goto err_role_put;
-	}
-
 	ret = devm_tps6598_psy_register(tps);
 	if (ret)
 		goto err_role_put;
 
-	tps->port = typec_register_port(&client->dev, &typec_cap);
-	if (IS_ERR(tps->port)) {
-		ret = PTR_ERR(tps->port);
+	ret = tps6598x_register_port(tps, fwnode);
+	if (ret)
 		goto err_role_put;
-	}
 
 	if (status & TPS_STATUS_PLUG_PRESENT) {
 		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &tps->pwr_status);
-- 
2.34.1

