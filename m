Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332C77ABE7B
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Sep 2023 09:41:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbjIWHlE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Sep 2023 03:41:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230222AbjIWHku (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Sep 2023 03:40:50 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59A6619A;
        Sat, 23 Sep 2023 00:40:44 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-4050bd2e33aso35089625e9.2;
        Sat, 23 Sep 2023 00:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695454843; x=1696059643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6c+gwnNdzl5uN5aJfSdaIcvttTZrO7JY31gLZWX+9v8=;
        b=KgOTMiPnWKiL43uOrsZdz43ooVnwwlw3KIl28L8dLDcVbKBJQvfQ7QOuQpURab/SJX
         9WKNo5MtGPs4VMYZfUMvkgKqPORxXuHoYdPAEiRRKPqxI4Wjh8+YXjmuBj3LnX+/6v1Q
         iqd3O8twSo4UKs94iC3tPg5rEKjNMS3A4oZyShydOyGs4Jt4fZY1/zoPE8VSnW8ChsAM
         Dn42HnsGdPqTRsim7U4H0ts4cXIBkjJP7Xb6scoLYU1Wlc9BH69pSTJXZQ3N9NEtfts5
         KC1hmReylrK8TWl1LdH/ALQagtt479KBtA0hjghUcq1ZE/E128qCBr+QQNBA6mIFl4qX
         e/6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695454843; x=1696059643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6c+gwnNdzl5uN5aJfSdaIcvttTZrO7JY31gLZWX+9v8=;
        b=FYe0sXCPxtv6xnq5PRPb2wMdWgfUfe19ym4Ly1kZXNlumRccIt3z4qH3BvCmkvrn4E
         HP3P32y1keBcEvOzIL6tF9YkAkkb8qAKaY/MFdAniouMoW37xx04AGUHUTuoii4LKiaR
         uCxP41zPSGqc22ppLEBRyx7u8PEFDP16uvkFiCAns4k7V8TGNLqB9iUziXpPJ97FOL6g
         17BdIyfjJwyjn9C9WhRIkqGJTZKi8A968oX+E5UEya9N40Tpxq6O4eHFwqqYs2rslCi6
         1aau0rq/H6iPvDbVQ3mkMf8F89ajmjmTXgRLFHwzJ0OmYKJKk9QjwxJffxfw22ykqMn4
         VqkA==
X-Gm-Message-State: AOJu0YxoT26euH5bArBxwFbjwS8P+LMi7yKFpRJKeQm1FIBlWwa9zBd5
        qd068AkhH3c7ZzKk52F+nfY=
X-Google-Smtp-Source: AGHT+IFPoOWaORXsDHtXS0kDLTJcdJcbHUnAMkSmRzuMMgp/hBkexP+mJhKSgxbLcZb34wDNvcQ4vQ==
X-Received: by 2002:adf:cd02:0:b0:31f:87f2:2155 with SMTP id w2-20020adfcd02000000b0031f87f22155mr1398800wrm.26.1695454842775;
        Sat, 23 Sep 2023 00:40:42 -0700 (PDT)
Received: from primary.. ([213.139.62.222])
        by smtp.gmail.com with ESMTPSA id k6-20020adfe3c6000000b003196e992567sm6236955wrm.115.2023.09.23.00.40.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Sep 2023 00:40:42 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        ryan.eleceng@gmail.com, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v6 05/14] USB: typec: Check for EEPROM present
Date:   Sat, 23 Sep 2023 03:39:50 -0400
Message-Id: <20230923073959.86660-6-alkuor@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230923073959.86660-1-alkuor@gmail.com>
References: <20230923073959.86660-1-alkuor@gmail.com>
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
Changes in v6: 
  - Update eeprom macro to use TPS instead
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c     | 13 +++++++++++++
 drivers/usb/typec/tipd/tps6598x.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index d2f82f191e4a..7c08669400a8 100644
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
@@ -898,6 +899,17 @@ static int tps25750_apply_patch(struct tps6598x *tps)
 {
 	int ret;
 	unsigned long timeout;
+	u64 status = 0;
+
+	ret = tps6598x_block_read(tps, TPS_REG_BOOT_STATUS, &status, 5);
+	if (ret)
+		return ret;
+	/*
+	 * Nothing to be done if the configuration
+	 * is being loaded from EERPOM
+	 */
+	if (status & TPS_BOOT_STATUS_I2C_EEPROM_PRESENT)
+		goto wait_for_app;
 
 	ret = tps25750_start_patch_burst_mode(tps);
 	if (ret) {
@@ -909,6 +921,7 @@ static int tps25750_apply_patch(struct tps6598x *tps)
 	if (ret)
 		return ret;
 
+wait_for_app:
 	timeout = jiffies + msecs_to_jiffies(1000);
 
 	do {
diff --git a/drivers/usb/typec/tipd/tps6598x.h b/drivers/usb/typec/tipd/tps6598x.h
index 527857549d69..a80d0929f3ee 100644
--- a/drivers/usb/typec/tipd/tps6598x.h
+++ b/drivers/usb/typec/tipd/tps6598x.h
@@ -199,4 +199,7 @@
 #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_A    BIT(2)
 #define TPS_DATA_STATUS_DP_SPEC_PIN_ASSIGNMENT_B    (BIT(2) | BIT(1))
 
+/* BOOT STATUS REG*/
+#define TPS_BOOT_STATUS_I2C_EEPROM_PRESENT	BIT(3)
+
 #endif /* __TPS6598X_H__ */
-- 
2.34.1

