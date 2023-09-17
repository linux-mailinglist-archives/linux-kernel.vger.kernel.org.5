Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA46D7A3673
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Sep 2023 17:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236719AbjIQP2H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Sep 2023 11:28:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234517AbjIQP1g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Sep 2023 11:27:36 -0400
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37DA185;
        Sun, 17 Sep 2023 08:27:30 -0700 (PDT)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-4018af103bcso23912895e9.1;
        Sun, 17 Sep 2023 08:27:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1694964449; x=1695569249; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KkNrm9xtXH99tqSrPhCbYDtc/M1xV92D12c2YjQETGI=;
        b=aogjEkaBR8yLMPdyt4g8752HEughiOQ6K89G+PPV7D8jZfzNtXps1jGAuq8dAE4TZm
         u6wcbwaKV+icKf2Osy9D2qyPa3uAD+U7Q9eUSUreWcCV+Zc4Qa64K64TTG5AoFXBdLSX
         0gz9zt/qp5b8fqLrXqfJgt/A4CbJjYEhBEjB2rq+OMKCXmpNZ8XpsCez63jWYGTBG6mW
         BFQyTYXBpLyuVmsFx+/QrK4dpC9ZAX7MekOVrO2qdNOZqnVB/DX4x2o6x1/IX1j9GyTz
         JlAGvJ8jweh/lQ0T6VJbI7cKQBjDVFGuUhO9240bp8nFGxM2TsGr0KCYmYerZ5PNiKc8
         H0yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694964449; x=1695569249;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KkNrm9xtXH99tqSrPhCbYDtc/M1xV92D12c2YjQETGI=;
        b=lSKNEPnJlgDaqn7uPDZeb6kK5Y3rJob6h09h/IQPBv5IJqWK90Ymes5bcP8tWfhOQ7
         u5/VoA1xXhGkHOztZnVYfcZNCjbfmke3/VXGtmzsax3qHRr+9bqCim2prTXRm8SjgwNr
         9bv5Km+tatCw9c3UrczFH+LAx/fJuI0Z73CI95iWDAvPKJpmtqMWo1VgiYLiBk0vzDvR
         63/hh6+MKqoURzOPdh/qWmpeSToC62ZbPIu6ygANVxjaKIbkcYjdctDlFHnxTTmhsDaT
         omEld1qstTOFPE91R3K47GtOUYrRgXtVvPNnx9pBi0dS7eyUudtyVqY0tLWUUTO3uKXQ
         H60g==
X-Gm-Message-State: AOJu0Yz1P9tUqtesNdRcfp/9zDkz5XpOR9w2a2TPAAkgxY89ykPxkMpg
        pCE+pf2xuNfyTkl21VnXtx4=
X-Google-Smtp-Source: AGHT+IE3hqlV60mQRZuntGz1aiQ3pEziwdFwgKsPg/H+OdE8LfUvrphwYVpAsnVYm8bFDXva1LHbaA==
X-Received: by 2002:a05:600c:b4b:b0:401:c7ec:b930 with SMTP id k11-20020a05600c0b4b00b00401c7ecb930mr7025504wmr.10.1694964449178;
        Sun, 17 Sep 2023 08:27:29 -0700 (PDT)
Received: from localhost.localdomain ([5.45.134.53])
        by smtp.gmail.com with ESMTPSA id j23-20020a05600c489700b003fe15ac0934sm7388865wmp.1.2023.09.17.08.27.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Sep 2023 08:27:28 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        conor+dt@kernel.org, linux-kernel@vger.kernel.org,
        abdelalkuor@geotab.com
Subject: [PATCH v5 05/15] USB: typec: Check for EEPROM present
Date:   Sun, 17 Sep 2023 11:26:29 -0400
Message-Id: <20230917152639.21443-6-alkuor@gmail.com>
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

When an EEPROM is present, tps25750 loads the binary configuration from
EEPROM. Hence, all we need to do is wait for the device to switch to APP
mode

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
 drivers/usb/typec/tipd/core.c     | 13 +++++++++++++
 drivers/usb/typec/tipd/tps6598x.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index fea139c72d6d..b3d4b2b5bf5f 100644
--- a/drivers/usb/typec/tipd/core.c
+++ b/drivers/usb/typec/tipd/core.c
@@ -37,6 +37,7 @@
 #define TPS_REG_STATUS			0x1a
 #define TPS_REG_SYSTEM_CONF		0x28
 #define TPS_REG_CTRL_CONF		0x29
+#define TPS_REG_BOOT_STATUS		0x2D
 #define TPS_REG_POWER_STATUS		0x3f
 #define TPS_REG_RX_IDENTITY_SOP		0x48
 #define TPS_REG_DATA_STATUS		0x5f
@@ -897,6 +898,17 @@ static int tps25750_apply_patch(struct tps6598x *tps)
 	int ret;
 	unsigned long timeout;
 	u8 mode;
+	u64 status = 0;
+
+	ret = tps6598x_block_read(tps, TPS_REG_BOOT_STATUS, &status, 5);
+	if (ret)
+		return ret;
+	/*
+	 * Nothing to be done if the configuration
+	 * is being loaded from EERPOM
+	 */
+	if (status & TPS25750_BOOT_STATUS_I2C_EEPROM_PRESENT)
+		goto wait_for_app;
 
 	ret = tps25750_start_patch_burst_mode(tps);
 	if (ret) {
@@ -908,6 +920,7 @@ static int tps25750_apply_patch(struct tps6598x *tps)
 	if (ret)
 		return ret;
 
+wait_for_app:
 	timeout = jiffies + msecs_to_jiffies(1000);
 
 	do {
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index 527857549d69..5e942c089c27 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -199,4 +199,7 @@
 #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_A    BIT(2)
 #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_B    (BIT(2) | BIT(1))
 
+/* BOOT STATUS REG*/
+#define TPS25750_BOOT_STATUS_I2C_EEPROM_PRESENT	BIT(3)
+
 #endif /* __TPS6598X_H__ */
-- 
2.34.1

