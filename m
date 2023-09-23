Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8F6E7ABE8A
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:41:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230497AbjIWHlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjIWHl3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:41:29 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2604CE42;
        Sat, 23 Sep 2023 00:40:57 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id 5b1f17b1804b1-4053c6f0e50so23034945e9.1;
        Sat, 23 Sep 2023 00:40:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695454853; x=1696059653; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noFhlnSd6o1/1TxRFdFKBDdlkIB3CreiY2GwmDe4rvo=;
        b=Pl5z7UDyZypwao/laWpnWaJghFj2Ibnzua7Xqba4gBQez8nSwvrU7TfqAgjmlhG3OU
         UnrcW/B47a3mAjk4IyR0rEYhyy4E/XUw2db4TZ2ZXv/XRMxHbzkODY/Rl46U5M20mOMi
         W5adgFCJqtG1lIrGsLaHSUEXbDYarUed5rLnk9cKbCRlfxjWx1O2H1lHv0SxRXVST+6F
         tUkPxcTf0nxfbKJI2GMiwXt9sNyPyReDExLpU4B2gzhHcZdeQQIq6qBrzOfFnBWXQjuy
         2GR2843Zp0ZuRerRxq5iJMWiesdxphzQOA7x+F99MGzOOpYVha24hYegqm8oEbC1HZjY
         /K1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695454853; x=1696059653;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=noFhlnSd6o1/1TxRFdFKBDdlkIB3CreiY2GwmDe4rvo=;
        b=DpGFEe9a47Dd1hIQlfxc61gNa2WUfdjmxW7Bn8Wo4d3QZQPunnaKAMGm7YjgVkny/j
         w4sWCHYfXLpLQQbEBUuMqYO7+ORJgYY7xAE72Olq1zpJn/exf090fFRPXCK+5vkLw7bC
         64GCmNX0+uRGYwXab7pIKd9UchaiXCrFx1XDQDzzhlL1Sa0GwwkBz631hrScW7MpBU06
         IlQtAydRpaPYcGcj+24nV/AFHpigKwqWXK/jfec7CD2bxLBY9U/R86uP0xDeLv4fV8RV
         0cVAamdM58fO7MFUvc8R24uNkCJxVIXi8ualLvrZKhlYJPym+Kb/L+eZiTTUd9omjWmU
         V2eA==
X-Gm-Message-State: AOJu0YwP5cPWwRvA+x6OxhSsgiebhVU1di0DLSF/zrZE4ASYUYiEkFHi
        MOczwoPN8KHuJ1vLV+O5Wyk=
X-Google-Smtp-Source: AGHT+IHvvIHQOn7GB/pE7gzMAldfLB2toKaFn7s8QWRrxUbQYV6s7V8YXGw8UTgo33J1Mgsgy9sraw==
X-Received: by 2002:a5d:408c:0:b0:31f:f753:5897 with SMTP id o12-20020a5d408c000000b0031ff7535897mr1560089wrp.59.1695454853647;
        Sat, 23 Sep 2023 00:40:53 -0700 (PDT)
Received: from primary.. ([213.139.62.222])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe3c6000000b003196e992567sm6236955wrm.115.2023.09.23.00.40.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 00:40:53 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        ryan.eleceng@gmail.com, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v6 11/14] USB: typec: Enable sleep mode for tps25750
Date:   Sat, 23 Sep 2023 03:39:56 -0400
Message-Id: <20230923073959.86660-12-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923073959.86660-1-alkuor@gmail.com>
References: <20230923073959.86660-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
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
Changes in v6:
  - Use tps25750_init instead of tps25750_apply_patch in resume
    as it initializes sleep mode
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c     | 23 +++++++++++++++++++++--
 drivers/usb/typec/tipd/tps6598x.h |  3 +++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index cfaad9a917a2..b9bb3d462742 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -42,6 +42,7 @@
 #define TPS_REG_PD_STATUS		0x40
 #define TPS_REG_RX_IDENTITY_SOP		0x48
 #define TPS_REG_DATA_STATUS		0x5f
+#define TPS_REG_SLEEP_CONF		0x70
 
 /* TPS_REG_SYSTEM_CONF bits */
 #define TPS_SYSCONF_PORTINFO(c)		((c) & 7)
@@ -1006,6 +1007,24 @@ static int tps25750_apply_patch(struct tps6598x *tps)
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
@@ -1196,7 +1215,7 @@ static int tps6598x_probe(struct i2c_client *client)
 		return ret;
 
 	if (is_tps25750 && ret == TPS_MODE_PTCH) {
-		ret = tps25750_apply_patch(tps);
+		ret = tps25750_init(tps);
 		if (ret)
 			return ret;
 	}
@@ -1335,7 +1354,7 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
 		return ret;
 
 	if (of_device_is_compatible(np, "ti,tps25750") && ret == TPS_MODE_PTCH) {
-		ret = tps25750_apply_patch(tps);
+		ret = tps25750_init(tps);
 		if (ret)
 			return ret;
 	}
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index 3a9a43394134..f86b5e96efba 100644
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

