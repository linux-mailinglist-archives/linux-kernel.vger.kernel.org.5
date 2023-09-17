Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E032C7A3661
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237256AbjIQP2Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:28:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234821AbjIQP1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:27:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103D2188;
        Sun, 17 Sep 2023 08:27:44 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-404573e6c8fso36715645e9.1;
        Sun, 17 Sep 2023 08:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694964462; x=1695569262; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cxpfJhVV2ocOjrZiYJqyl63jEXCWOHPBdFU1UNBK2Hg=;
        b=gRNBpb9HOtqxDzQhi4tad8dwDUm3yEPAnN2kMYMEeY0eDvamf27XQET8oInvCY85yR
         RL1B1/F0LyavWkcbVLTtVbzZDIBnSXNQUi17OR2p5e6BSQJCPZxQDmu4VKejfOQud3CQ
         ng6G8N5QDJNR8sB5dpIKhOqOk2LOncO+18Gc7Fbu4Iqm6PWaMU5vCWyexkv/PROjNCW3
         mXo4T8jq28DAe4YEUc/S4fPht9yg6JnkpEBm2utYBMxJpb0Y6rm3rdzep+0uuVytqdEs
         HiCpw6ZLHgQwMBf3StqNQCldf1t51bqhAQdkP2ccSQBwVATaIulAM5yPeKKQbLL9rsSd
         D2Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694964462; x=1695569262;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cxpfJhVV2ocOjrZiYJqyl63jEXCWOHPBdFU1UNBK2Hg=;
        b=ewPDrh5p6E3rOKVLvK6zMd2KvCbYKe7EufRivWWZ1ZJY7Z9OeNFus9ExkqyU1lVu8E
         DxXvvXXAUpf/sG6okYlL9JUit4RF5F4/jvFvR5hkjv2BPcxXVVU7Amuf1LYlU/5CYhJO
         POVyna0KSpRu+YA0LR1cXQUhbC93cIAi9tEwi89VV5uepfLP37XGASR+qjpaKcjV4IdZ
         0nWbTWnxQcvnHTJsHIVkkqZLeopKpkUudfKeitCThnlXeI3sHOhjGWjWzjMyirj8Wfqg
         i34W/o4SjXAcaTMnxFDeagMTci6RTptzv708cfICjYp6ADuLPoN/WMf6oz/gCISVIala
         8rmQ==
X-Gm-Message-State: AOJu0Yzniukqyza9UMLyQOiPlP6rpUDxZXdvpuSo41nNBGWIhRj5hfP9
        aE4qC42+PTWeGZRunrtcJxU=
X-Google-Smtp-Source: AGHT+IE2whKvpl5VAri2AnH12htURwwKvEYwF8MPrJNUKJ1cuni1fK0gHc0sI7GYpuTgXWiceWtWpw==
X-Received: by 2002:a1c:7419:0:b0:402:feff:90d5 with SMTP id p25-20020a1c7419000000b00402feff90d5mr5647361wmc.5.1694964462453;
        Sun, 17 Sep 2023 08:27:42 -0700 (PDT)
Received: from localhost.localdomain ([5.45.134.53])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c489700b003fe15ac0934sm7388865wmp.1.2023.09.17.08.27.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 08:27:42 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: [PATCH v5 10/15] USB: typec: Add port registration for tps25750
Date:   Sun, 17 Sep 2023 11:26:34 -0400
Message-Id: <20230917152639.21443-11-alkuor@gmail.com>
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

TPS25750 doesn't have system configuration register to get dr/pr of the
current applied binary configuration.

Get data role from the device node and power role from PD status register.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
 drivers/usb/typec/tipd/core.c     | 61 ++++++++++++++++++++++++++++++-
 drivers/usb/typec/tipd/tps6598x.h | 10 +++++
 2 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index 8218d88a4a06..a97fda68cb54 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -39,6 +39,7 @@
 #define TPS_REG_CTRL_CONF		0x29
 #define TPS_REG_BOOT_STATUS		0x2D
 #define TPS_REG_POWER_STATUS		0x3f
+#define TPS_REG_PD_STATUS		0x40
 #define TPS_REG_RX_IDENTITY_SOP		0x48
 #define TPS_REG_DATA_STATUS		0x5f
 
@@ -1028,6 +1029,60 @@ tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
 	return 0;
 }
 
+static int
+tps25750_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
+{
+	struct typec_capability typec_cap = { };
+	const char *data_role;
+	u8 pd_status;
+	int ret;
+
+	ret = tps6598x_read8(tps, TPS_REG_PD_STATUS, &pd_status);
+	if (ret)
+		return ret;
+
+	ret = fwnode_property_read_string(fwnode, "data-role", &data_role);
+	if (ret) {
+		dev_err(tps->dev, "data-role not found: %d\n", ret);
+		return ret;
+	}
+
+	ret = typec_find_port_data_role(data_role);
+	if (ret < 0) {
+		dev_err(tps->dev, "unknown data-role: %s\n", data_role);
+		return ret;
+	}
+
+	typec_cap.data = ret;
+	typec_cap.revision = USB_TYPEC_REV_1_3;
+	typec_cap.pd_revision = 0x300;
+	typec_cap.driver_data = tps;
+	typec_cap.ops = &tps6598x_ops;
+	typec_cap.fwnode = fwnode;
+	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
+
+	switch (TPS_PD_STATUS_PORT_TYPE(pd_status)) {
+	case TPS_PD_STATUS_PORT_TYPE_SINK_SOURCE:
+	case TPS_PD_STATUS_PORT_TYPE_SOURCE_SINK:
+		typec_cap.type = TYPEC_PORT_DRP;
+		break;
+	case TPS_PD_STATUS_PORT_TYPE_SINK:
+		typec_cap.type = TYPEC_PORT_SNK;
+		break;
+	case TPS_PD_STATUS_PORT_TYPE_SOURCE:
+		typec_cap.type = TYPEC_PORT_SRC;
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
@@ -1124,7 +1179,11 @@ static int tps6598x_probe(struct i2c_client *client)
 	if (ret)
 		goto err_role_put;
 
-	ret = tps6598x_register_port(tps, fwnode);
+	if (np && of_device_is_compatible(np, "ti,tps25750"))
+		ret = tps25750_register_port(tps, fwnode);
+	else
+		ret = tps6598x_register_port(tps, fwnode);
+
 	if (ret)
 		goto err_role_put;
 
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index 362e1eca53ad..d2c65387994f 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -203,4 +203,14 @@
 #define TPS_BOOT_STATUS_DEAD_BATTERY_FLAG	BIT(2)
 #define TPS25750_BOOT_STATUS_I2C_EEPROM_PRESENT	BIT(3)
 
+/* PD STATUS REG */
+#define TPS_REG_PD_STATUS_PORT_TYPE_MASK	GENMASK(5, 4)
+#define TPS_PD_STATUS_PORT_TYPE(x) \
+	TPS_FIELD_GET(TPS_REG_PD_STATUS_PORT_TYPE_MASK, x)
+
+#define TPS_PD_STATUS_PORT_TYPE_SINK_SOURCE	0
+#define TPS_PD_STATUS_PORT_TYPE_SINK		1
+#define TPS_PD_STATUS_PORT_TYPE_SOURCE		2
+#define TPS_PD_STATUS_PORT_TYPE_SOURCE_SINK	3
+
 #endif /* __TPS6598X_H__ */
-- 
2.34.1

