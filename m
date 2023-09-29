Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68647B356B
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbjI2Ocu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:32:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbjI2OcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:32:24 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB80710D7;
        Fri, 29 Sep 2023 07:32:17 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id a640c23a62f3a-9a9cd066db5so1980664066b.0;
        Fri, 29 Sep 2023 07:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695997936; x=1696602736; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RAp+55201wmFdbMkBq6EDZPiYVA++xP36p4l1BsD1I0=;
        b=j0D3gFJMwrx3TBoOdUeWS3AzBxoxCMVb3Gc4ous9WQXmeQfBqSsXl7/8j2mnLguO/v
         ZM28DvVCKQ2ecEju/6k/IZGiy13jqD9Qq1eo+KnBWKC5hrnyC+A4olYCdeS5VCut33DM
         J1SSfKjgWQ13ptcNI+xnoHIyLK9FeRgsK3Z1ZfQSKwmTszYj8axZ7OjGOXYZIa98QAPz
         UpaAX8eS5ePzAAHL6rcKXKAYCU1gDz1hwvnkMMcdZvdWagG8bpxrD2LBOolUAizPslyN
         /pZPxypzHoyUVR/P48AQ44pOIUGLYlOavjiphdO5rWLnMcgFWVEvpoXKOdAp3KLyKoYH
         Rzuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695997936; x=1696602736;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RAp+55201wmFdbMkBq6EDZPiYVA++xP36p4l1BsD1I0=;
        b=kiTb2TZ4NQ6XNq9j0gvMLL87tNaMt1/5FWkLoLzsVn6HmxHx0NratbX1wFiilwVI3T
         wH8BZN+5infi9CTH+YF/gkHk74usSQLFw/QcLEERPVDU6OhUvYDUoM/tQTA7PyjgGWKt
         1zVGqd82DvQ+HG05FTaryQBGyvHvwD+pC8BqMsWdWVkIrVkM/EHuWMiRXxnYnMbyEmUM
         w1rtYKVmNXEl6SDEBIEh5F5iivR31fCWAFNljB2jHgyF/LKhhRbYMxS3KDKBTGqgJCN1
         gRlYlchOIsZrhG0JtZDBCaIgUiYK/GNfsMsZ/9l9ZWYk/FhSOGRs3Gp9xQjUzPV28WIW
         yjmQ==
X-Gm-Message-State: AOJu0YwfM2yrKJ/ReCJNLSH29fHxUIMEGRwbhXoIufCZVOsL2Z6MkKkq
        4EJZtD8gChbktHGJf2nBnQU=
X-Google-Smtp-Source: AGHT+IFBs+BUCowowRueys6pTpDxKOBF2uVMinIqLEqXzkLlS35nhH4MBL9rNw3A5St2dD7M76T+Gg==
X-Received: by 2002:a17:906:32cb:b0:9aa:e07:d421 with SMTP id k11-20020a17090632cb00b009aa0e07d421mr3750670ejk.43.1695997936147;
        Fri, 29 Sep 2023 07:32:16 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id a7-20020a170906670700b0099293cdbc98sm12660105ejp.145.2023.09.29.07.32.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Sep 2023 07:32:15 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v8 11/14] USB: typec: tps6598x: Enable sleep mode for tps25750
Date:   Fri, 29 Sep 2023 10:30:52 -0400
Message-Id: <20230929143055.31360-12-alkuor@gmail.com>
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

Allow controller to enter sleep mode after the device
is idle for sleep time.

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
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
index dd2ecbea8031..0955ee214eb0 100644
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
@@ -1237,7 +1256,7 @@ static int tps6598x_probe(struct i2c_client *client)
 		return ret;
 
 	if (is_tps25750 && ret == TPS_MODE_PTCH) {
-		ret = tps25750_apply_patch(tps);
+		ret = tps25750_init(tps);
 		if (ret)
 			return ret;
 	}
@@ -1374,7 +1393,7 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
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

