Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E5A7A364A
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237352AbjIQP2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234809AbjIQP1x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:27:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C04D18B;
        Sun, 17 Sep 2023 08:27:46 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-400a087b0bfso39937065e9.2;
        Sun, 17 Sep 2023 08:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694964465; x=1695569265; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0n50wlN15P0stenDju6p9cw+JcF6FZEojTnqcJ2Z8gE=;
        b=W8KEsmdhEB40oiznYrEJUK9vC6qo3/+yRo1nGuhgYhqifIw2euID4lAVgDue1/SeWw
         MWCUcwGJ/7LFoKrLdFF7+YigHj6rT/l1QUorc7z3wevj4/RxzhIhzWdlT/j1myANbPDb
         aahTNietBw2Jr/l7aJm3aWwKylEX3IcS9O6CAprGCtBZjdVbjAs4RJF9EAaE8J8QHHOU
         0+T9f1nTjvMMV+WdzHbJXPaeCerei79x6OcIQSqUU3XM/c7T+zWvAtzjFp0YwQarNMpI
         CNBKKq4/tzCpCoUOay9/uTHudJ+aM1IBQbwY1cyOiiIiRLcnw88KAmEAG2VWIvMIMoAy
         /CIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694964465; x=1695569265;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0n50wlN15P0stenDju6p9cw+JcF6FZEojTnqcJ2Z8gE=;
        b=OCK83qDAYVFnbl3jEl7TbsxLaOa35f4PCmpQ2ZI7AfwsKM+ejvnuDVUGir24ouXek7
         Ix6gLzyjAwxm/WGbJZX+4H/jdtyTcTfg/TQ26dg7+9DNjDD2TpG+ObcQt5O9uBrwdqby
         1FIk5aCtvtd7L1PwJcF3E1VCAhAUUzPVUK5pPRwrMI9biEdHdyYQG5Yag1JSoY3BkWsT
         H0GbCC43w54mRMK9hNpa4rDovrRxXhyv7Fvujzyb9V73Xf+W1ylqZ3LndVmjZiDbELu+
         gP/C7Ejnk9KUYyuIGBoYMiSUvIOaf6C6Cd+qeEVeqE9MdYV0mYv6mRs9J2WEIBpv3gJI
         vslA==
X-Gm-Message-State: AOJu0YxqT4OmVQmKPsjgXOLVU6j1ilrVf7WcHiHpH6Qej69193KvReTd
        2hqPcFOt6QQnBKnBmaZFY9U=
X-Google-Smtp-Source: AGHT+IHuQ5GHCtgPrcqNGuZhnt2rN0nTJVYlNyOV4spivVTJO8b0FW1At9WsNKfWdsKfdMUrtQoKzw==
X-Received: by 2002:a05:600c:2194:b0:3fe:ef11:d79f with SMTP id e20-20020a05600c219400b003feef11d79fmr6173540wme.36.1694964464977;
        Sun, 17 Sep 2023 08:27:44 -0700 (PDT)
Received: from localhost.localdomain ([5.45.134.53])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c489700b003fe15ac0934sm7388865wmp.1.2023.09.17.08.27.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 08:27:44 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: [PATCH v5 11/15] USB: typec: Enable sleep mode for tps25750
Date:   Sun, 17 Sep 2023 11:26:35 -0400
Message-Id: <20230917152639.21443-12-alkuor@gmail.com>
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

Allow controller to enter sleep mode after the device
is idle for sleep time.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
 drivers/usb/typec/tipd/core.c     | 29 ++++++++++++++++++++++++++++-
 drivers/usb/typec/tipd/tps6598x.h |  3 +++
 2 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index a97fda68cb54..3d9877551160 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -42,6 +42,7 @@
 #define TPS_REG_PD_STATUS		0x40
 #define TPS_REG_RX_IDENTITY_SOP		0x48
 #define TPS_REG_DATA_STATUS		0x5f
+#define TPS_REG_SLEEP_CONF		0x70
 
 /* TPS_REG_SYSTEM_CONF bits */
 #define TPS_SYSCONF_PORTINFO(c)		((c) & 7)
@@ -205,6 +206,11 @@ static inline int tps6598x_read64(struct tps6598x *tps, u8 reg, u64 *val)
 	return tps6598x_block_read(tps, reg, val, sizeof(u64));
 }
 
+static inline int tps6598x_write8(struct tps6598x *tps, u8 reg, u8 val)
+{
+	return tps6598x_block_write(tps, reg, &val, sizeof(u8));
+}
+
 static inline int tps6598x_write64(struct tps6598x *tps, u8 reg, u64 val)
 {
 	return tps6598x_block_write(tps, reg, &val, sizeof(u64));
@@ -977,6 +983,24 @@ static int tps25750_apply_patch(struct tps6598x *tps)
 	return 0;
 };
 
+static int tps25750_init(struct tps6598x *tps)
+{
+	int ret;
+
+	ret = tps25750_apply_patch(tps);
+	if (ret)
+		return ret;
+
+	ret = tps6598x_write8(tps, TPS_REG_SLEEP_CONF,
+			      TPS_SLEEP_CONF_SLEEP_MODE_ALLOWED);
+	if (ret)
+		dev_warn(tps->dev,
+			 "%s: failed to enable sleep mode: %d\n",
+			 __func__, ret);
+
+	return 0;
+}
+
 static int
 tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
 {
@@ -1131,6 +1155,7 @@ static int tps6598x_probe(struct i2c_client *client)
 		irq_handler = cd321x_interrupt;
 	} else {
 		tps->is_tps25750 = of_device_is_compatible(np, "ti,tps25750");
+
 		/* Enable power status, data status and plug event interrupts */
 		mask1 = TPS_REG_INT_POWER_STATUS_UPDATE |
 			TPS_REG_INT_DATA_STATUS_UPDATE |
@@ -1138,6 +1163,7 @@ static int tps6598x_probe(struct i2c_client *client)
 	}
 
 	tps->irq_handler = irq_handler;
+
 	/* Make sure the controller has application firmware running */
 	ret = tps6598x_check_mode(tps, &mode);
 	if (ret)
@@ -1149,6 +1175,7 @@ static int tps6598x_probe(struct i2c_client *client)
 			return ret;
 	}
 
+
 	ret = tps6598x_write64(tps, TPS_REG_INT_MASK1, mask1);
 	if (ret)
 		goto err_reset_controller;
@@ -1286,7 +1313,7 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
 		return ret;
 
 	if (mode == TPS_MODE_PTCH) {
-		ret = tps25750_apply_patch(tps);
+		ret = tps25750_init(tps);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index d2c65387994f..0344b65cd55a 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -213,4 +213,7 @@
 #define TPS_PD_STATUS_PORT_TYPE_SOURCE		2
 #define TPS_PD_STATUS_PORT_TYPE_SOURCE_SINK	3
 
+/* SLEEP CONF REG */
+#define TPS_SLEEP_CONF_SLEEP_MODE_ALLOWED	BIT(0)
+
 #endif /* __TPS6598X_H__ */
-- 
2.34.1

