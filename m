Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 500C57B0B87
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjI0R6U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:58:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229825AbjI0R6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:58:04 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29F3610D3;
        Wed, 27 Sep 2023 10:57:50 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e28cac164so28000549a12.1;
        Wed, 27 Sep 2023 10:57:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695837469; x=1696442269; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sf41GpttTXH9NGnzfB9RP8nxYb55p65KkNUeRtKNh+Y=;
        b=f96bWUp1nZ2mO97Ipql9NWSRIT8cFalcBDCVO2P/aDjQqW+8dNnqu8wMCiZukWXbvf
         4ML9EjvFtsiA6ClhZsMSabgAkCpcCFiJbeZIqp45oMACwyLwIBrop/1+rZZWWTnIfG5b
         X/XG2w8ZDr+BkapFLYwrT9UBvZ7e6V6QqwRwb3ZXuoiWMIHWSaaaXeO0bB1jm74prO4N
         +C+/LhaiQMxXtEvIHIx+/+AarMfYY4du10OilEmfaxu9ikMyDr98ejJn6g92rjpM4LdM
         QrHezpu9EYbvwfewfxMOfK6+P0xsnTalZJdWkVYdXI+/pwvap9VVkbSowI1BEOIKBxcn
         cs8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695837469; x=1696442269;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Sf41GpttTXH9NGnzfB9RP8nxYb55p65KkNUeRtKNh+Y=;
        b=iNhnA+hsA4Q2zim3KkuyhhoteIf2PwN7VAVUM2+yCT8511tBic8gVQNE8oSVO2AqtD
         aPWKwvYXfwSj/UvPO373kAjlM1VxOicund3PRMfwzMvfq7VOmynsZ5jPFrt58NHXKfpp
         wWLyF/b3ESdbrna7wXmonc4jyHLU7QAm4fv9bGXT8Asm9DLDntgB6VLPIuWAtvKxP0xu
         Fv0jGun1CeETOs77wmcxIZlhKWPBONK0ZFfg8kNXtbO9oIp62qAtzSm46hJam1mUYPJP
         lbF6h4JIxVpv8mqA8knE7K5QD5MZ1HpeGvb0mAvYzgAxMLxJNzicMPlIi8Q+PfXXQHFx
         ytPw==
X-Gm-Message-State: AOJu0YxKsHjyDevPCNwurXT9pRvEnywCOhlkUZQsQu3pjk7HXoizs8Si
        nZS9zndzfAM5PhgePTlFIRE=
X-Google-Smtp-Source: AGHT+IF1z+E/tX9+OE8N+e3m465FBZrG3IcOsR5RiyKEcJBCUV2BCXitgk7UqFfApjWRsa2pyKx/Ew==
X-Received: by 2002:a17:906:2a50:b0:9a1:8993:9532 with SMTP id k16-20020a1709062a5000b009a189939532mr7184555eje.30.1695837469366;
        Wed, 27 Sep 2023 10:57:49 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id d4-20020a170906370400b0099bd8c1f67esm9654593ejc.109.2023.09.27.10.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:57:49 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v7 11/14] USB: typec: tps6598x: Enable sleep mode for tps25750
Date:   Wed, 27 Sep 2023 13:53:45 -0400
Message-Id: <20230927175348.18041-12-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230927175348.18041-1-alkuor@gmail.com>
References: <20230927175348.18041-1-alkuor@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
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
index e775c3c9bf64..19bb2105b5b2 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -42,6 +42,7 @@
 #define TPS_REG_PD_STATUS		0x40
 #define TPS_REG_RX_IDENTITY_SOP		0x48
 #define TPS_REG_DATA_STATUS		0x5f
+#define TPS_REG_SLEEP_CONF		0x70
 
 /* TPS_REG_SYSTEM_CONF bits */
 #define TPS_SYSCONF_PORTINFO(c)		((c) & 7)
@@ -1040,6 +1041,24 @@ static int tps25750_apply_patch(struct tps6598x *tps)
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
@@ -1226,7 +1245,7 @@ static int tps6598x_probe(struct i2c_client *client)
 		return ret;
 
 	if (is_tps25750 && ret == TPS_MODE_PTCH) {
-		ret = tps25750_apply_patch(tps);
+		ret = tps25750_init(tps);
 		if (ret)
 			return ret;
 	}
@@ -1365,7 +1384,7 @@ static int __maybe_unused tps6598x_resume(struct device *dev)
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

