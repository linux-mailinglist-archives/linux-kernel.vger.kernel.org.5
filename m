Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A28A7B0B76
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 19:57:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbjI0R5y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 13:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjI0R5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 13:57:45 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F48C12A;
        Wed, 27 Sep 2023 10:57:40 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2c124adf469so197985711fa.0;
        Wed, 27 Sep 2023 10:57:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1695837458; x=1696442258; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=08TTJK6jIdlF3YGQZqg/ueMGQffH5CXs2rT/Yy540NE=;
        b=Fo4aXa5bduEsfH0X1GG2XnvD/W23eQHGKXCgWHjFzeXd7R+FDite+0yC2qRE7dsh3M
         j3Gt5EzAie5+cJAiaE/BStwMQ7kg4RCH/MCyg3EXJP+xkPgLMJypTDDJ9H4hugp3697J
         QyVvVGDa5oxwa2w/XcZhVVw/RnB986hedkEuk6g5OwQxyOgTR6fxZEHLsU61HMbjpDrZ
         VFOx6GJUbES3yNe0vR2GyRXtPTBmZlwgmdbdeSZn1xDG9bW/hhez/qeNSl7nRvl9/klX
         FJpjfKaIYpvOE3R2fKf+wdIRupyVWmPYXeb1y7z1rkn2qO0fvTehMjMvIXM6+KDEITso
         yNTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1695837458; x=1696442258;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=08TTJK6jIdlF3YGQZqg/ueMGQffH5CXs2rT/Yy540NE=;
        b=moISAK70dRA6o6RzErHPK+rcjByX6wfaMPurDDM/aGH0KDaTQHnwu9HEQfuTpuSdOR
         xzmvZSjkSIXQ37TqFekHpW/dz0nDtrEhcNyD7wV8mNWoO4CIq1q+Ff8DnE0cB/wG1O8Y
         ZNhvEV/dAvqkdqL93FREz8SlGDWDdjm3LpX3n8H38X31oPtWm9OfvF/VmPDijg8mg8sS
         tRYueQrmAAA1ZCy4miMNEhmh9Z/CPjjzYFBKz9lVYPgwaLxGlDygCBBRGdIjxZ6ggn3Z
         uahUO8dCME1eFFypUirI956544PdQA3p3d8bA/+rCNfG0OlrqOnH4l4fV3vnNYem15/C
         AUpQ==
X-Gm-Message-State: AOJu0YwrnGkzU+gs9cAGFfHpefUek6iMWTAD+yD1a2aYx62yJivEOjfW
        Lna/iif5t38WB5fJ4bJHjkM=
X-Google-Smtp-Source: AGHT+IEyz3wuba9KzvLZVtTeMjdqegWWFZuYn6c0/tWcUr1gjEMr4JLFbSZrGFtELLYtczMFW9thAg==
X-Received: by 2002:a2e:93cf:0:b0:2bd:1bca:ebee with SMTP id p15-20020a2e93cf000000b002bd1bcaebeemr2559253ljh.19.1695837458077;
        Wed, 27 Sep 2023 10:57:38 -0700 (PDT)
Received: from primary.. ([212.34.12.50])
        by smtp.gmail.com with ESMTPSA id d4-20020a170906370400b0099bd8c1f67esm9654593ejc.109.2023.09.27.10.57.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Sep 2023 10:57:37 -0700 (PDT)
From:   Abdel Alkuor <alkuor@gmail.com>
To:     heikki.krogerus@linux.intel.com, krzysztof.kozlowski+dt@linaro.org,
        bryan.odonoghue@linaro.org
Cc:     gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: [PATCH v7 05/14] USB: typec: tps6598x: Check for EEPROM present
Date:   Wed, 27 Sep 2023 13:53:39 -0400
Message-Id: <20230927175348.18041-6-alkuor@gmail.com>
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

When an EEPROM is present, tps25750 loads the binary configuration from
EEPROM. Hence, all we need to do is wait for the device to switch to APP
mode

Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
---
Changes in v7:
  - Add driver name to commit subject
Changes in v6: 
  - Update eeprom macro to use TPS instead
Changes in v5:
  - Incorporating tps25750 into tps6598x driver

 drivers/usb/typec/tipd/core.c     | 13 +++++++++++++
 drivers/usb/typec/tipd/tps6598x.h |  3 +++
 2 files changed, 16 insertions(+)

diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
index f96a9ff07fba..cd22635460d3 100644
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
@@ -910,6 +911,17 @@ static int tps25750_apply_patch(struct tps6598x *tps)
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
@@ -921,6 +933,7 @@ static int tps25750_apply_patch(struct tps6598x *tps)
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

