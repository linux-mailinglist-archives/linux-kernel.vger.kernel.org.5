Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03B507B4616
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Oct 2023 10:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234528AbjJAIQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Oct 2023 04:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234572AbjJAIPt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Oct 2023 04:15:49 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C197710CB;
        Sun,  1 Oct 2023 01:15:39 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id a640c23a62f3a-9a64619d8fbso2167144966b.0;
        Sun, 01 Oct 2023 01:15:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1696148137; x=1696752937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IkM85K7qerliqFzrskzHsY1jjDj4Egep2EeBXa3H9HE=;
        b=gch1OradbR+fiZ9SlpdYWH8ZKubY2lPJfhX4zq4U/LLwqrKJUlLEH0dgjzBlK09sZY
         gcJYpQX2p7SBnw/7NPxkaxTVuSZh5twNRe6NfBFVSp2WtfuoCOFoA3iwKr6smA7n4w4u
         qnk5JA7n+blxgjgnDpDQDW5jbj/8pMJH2diivSRYSBvtFB/AQKbQiiCptg0rLM/hWStW
         idtGnbwuVXIg3gZ8R6DTegytdrCxNjqkSnzUOXfVT/sVYka5jJ/Bfwp9Q1FpOPxqWsHo
         1l9K+Sym32nqNPf2U070qNxQnqRGSRcbx1miCeM9klqdWWuTwuEsYOQC0HGx3r/CUcyv
         RPnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696148137; x=1696752937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IkM85K7qerliqFzrskzHsY1jjDj4Egep2EeBXa3H9HE=;
        b=XXF53XGGuHknnoNZeT4GNW1Via2gdY5UqG6SSKrFpFVFrqGM5drgceqW5ZYpkohgA5
         VJ5jWMpwwhAyRVuoI1UaZ0UhFrgcO8JywIrBRWNF8WQDXeG6J0Uhf5d+4okowEViUGeJ
         cb3OMKmleBCLTPnf31yCQddFbo2OFb1jOe5Xsw4X2CvaLjnT8ngRWeHOc2o1MOME4dyJ
         gTT+2hIQQfct1Ortr7u6BjfofDLRfkc//fcdc5mEbhlB4xUXTIEzvWrwbyFpIt24MDnt
         84lUd0xCTnwMQ4ml+EIoGcmFfxleENifRLfY5X+x46MWDq5jHWKZYkmP6790leHYXLMB
         1icQ==
X-Gm-Message-State: AOJu0YwRua+ahpJMI2mmsaGQT4SCtd8d9/qZmeHh969KPf1RMSgFwHgw
        APoMYoJ8sor3eLQp/1uC4Vo=
X-Google-Smtp-Source: AGHT+IFZmC3T+GeKC3raZwF0/26lL7wGXB0KrDbYdpLHZTyosIMefeTiPuApoZ5LQ1tisyOpOu59ig==
X-Received: by 2002:a17:907:75d9:b0:9b2:7148:dd5e with SMTP id jl25-20020a17090775d900b009b27148dd5emr7884787ejc.16.1696148137458;
        Sun, 01 Oct 2023 01:15:37 -0700 (PDT)
Received: from primary.. ([213.139.52.198])
        by smtp.gmail.com with ESMTPSA id e8-20020a170906374800b0099cf840527csm15121841ejc.153.2023.10.01.01.15.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Oct 2023 01:15:37 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v9 11/14] USB: typec: tps6598x: Enable sleep mode for tps25750
Date:   Sun,  1 Oct 2023 04:11:31 -0400
Message-Id: <20231001081134.37101-12-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231001081134.37101-1-alkuor@gmail.com>
References: <20231001081134.37101-1-alkuor@gmail.com>
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
Changes in v9:
  - No changes
Changes in v8:
  - No changes
Changes in v7:
  - Add driver name to commit subject
Changes in v6:
  - Use tps25750_init instead of tps25750_apply_patch in resume
    as it initializes sleep mode
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c     | 23 +++++++++++++++++++++--
 drivers/usb/typec/tipd/tps6598x.h |  3 +++
 2 files changed, 24 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index ae08c5306707..ddb5db7d5855 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -43,6 +43,7 @@
 #define TPS_REG_PD_STATUS		0x40
 #define TPS_REG_RX_IDENTITY_SOP		0x48
 #define TPS_REG_DATA_STATUS		0x5f
+#define TPS_REG_SLEEP_CONF		0x70
 
 /* TPS_REG_SYSTEM_CONF bits */
 #define TPS_SYSCONF_PORTINFO(c)		((c) & 7)
@@ -1041,6 +1042,24 @@ static int tps25750_apply_patch(struct tps6598x *tps)
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
@@ -1211,7 +1230,7 @@ static int tps6598x_probe(struct i2c_client *client)
 		return ret;
 
 	if (is_tps25750 && ret == TPS_MODE_PTCH) {
-		ret = tps25750_apply_patch(tps);
+		ret = tps25750_init(tps);
 		if (ret)
 			return ret;
 	}
@@ -1348,7 +1367,7 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
 		return ret;
 
 	if (device_is_compatible(tps->dev, "ti,tps25750") && ret == TPS_MODE_PTCH) {
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

