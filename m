Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB0A7D8C5B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 01:53:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232097AbjJZXxd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 19:53:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjJZXxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 19:53:32 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 992DE1A5
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:53:29 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id 3f1490d57ef6-da03390793fso1308645276.3
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 16:53:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1698364409; x=1698969209; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=HOfMzcxZ/3hjUoq4sBGrBF7S8BsQHvMQlln1OBJHdaA=;
        b=fyS/Fttm+XrcfrCT68CXNNQqIYb2o7xzAIvJeQk9njM+P6ejIC49Nmv0O7meGg08I1
         Ddu5qyPQK9pfyRnmapLaEQULUohDROTCxo9E8Ojp8wkRjTnOYgCKoXSZ7sFiVl7rR2oS
         rXYDeV0IOxiD4YrhfMF4XMNRJotbN7CrMgBwOJU3CGCoIrOAVa0lHCSrk6+ss1tfjLnj
         mqdGOw00D5uQO7n3G+Z1n0+uRAjUFXNNAR3LhDAMu3YbHWRZYgi4nAeZiCoKNX0la2YC
         rhPLaN8+vdfKpA8VrEglUHGSFyQCo8Ki0iNiMdAV4dWIaS/iqmghK4CNbUAJ9vwHyGlR
         ec5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698364409; x=1698969209;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HOfMzcxZ/3hjUoq4sBGrBF7S8BsQHvMQlln1OBJHdaA=;
        b=KEnYz6ZkJ98KQwr85lBqf1m/2SoR/Di2PPvXFO2Hfr8Z6ZGT0uEo1knJwTGBQVpAWO
         ca+rxnDlbbKGNMVCBcVeEcCbCNWdf/EivercANBVT9SD8P3a3FUbkhzIhLJa7N46jYxl
         gHLuXDNLM2KvevGYDjW1bCGiPFxlvbavAi3wI8tRoOS6gPp/T/GJm3lbzRx8wMU5XQYQ
         iS793ktKWoTcPqrAPVQysWPAKzT+hnTUcNa1h2oflpzqPjVh03vdokg4PnVGLyzJglP+
         zA6WwRgoH4o5GtkopnbMx/xOmoboFZGtRTviZ0e9FjTLgJHLxZ/qcmA34ZQzvnQKdEgX
         YpfA==
X-Gm-Message-State: AOJu0YxQvOWhXRL4V30XQYhHqjOSwuBCeJzlGXkK88y3UouFLBdk2ioP
        za7b8NdmUdzy0RGwoxy+fRtPposmpNR1B18NKA==
X-Google-Smtp-Source: AGHT+IG77MFSmT3SaKXGOWzPq3J8+lD5ZSXLYoOUz7kFuM5v0rKA6EBM0yqsRR2XDI8ZtGT38VH0WB9spzsB6e6bzA==
X-Received: from jstitt-linux1.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:23b5])
 (user=justinstitt job=sendgmr) by 2002:a05:6902:4c8:b0:d9a:54e7:e910 with
 SMTP id v8-20020a05690204c800b00d9a54e7e910mr20910ybs.4.1698364408798; Thu,
 26 Oct 2023 16:53:28 -0700 (PDT)
Date:   Thu, 26 Oct 2023 23:53:28 +0000
Mime-Version: 1.0
X-B4-Tracking: v=1; b=H4sIAPf7OmUC/5XNTQqDMBCG4atI1p1iEvGnq96juCjJqAPVyEwIi
 nj3pt6gy/dbfM+hBJlQ1KM4FGMiobDkMLdCuem9jAjkcytTGlt2RoNEXty6g2dKyAJEAVYOG80
 Ud5Cts6YCB62zlW3qpi5tp/LZyjjQdkGvPvdEEgPvl5v0b/2bSBo0VNh60w5eY+OeYwjjB+8uz Ko/z/MLSL34Rd0AAAA=
X-Developer-Key: i=justinstitt@google.com; a=ed25519; pk=tC3hNkJQTpNX/gLKxTNQKDmiQl6QjBNCGKJINqAdJsE=
X-Developer-Signature: v=1; a=ed25519-sha256; t=1698364408; l=3417;
 i=justinstitt@google.com; s=20230717; h=from:subject:message-id;
 bh=n9dHtlIRbaOPoLRJKV7YdDQxGf9+seWRweRY7Pvx3jE=; b=Y+JycQV+Q1UlcGlRHUqdjVh2wdc13xMEMzLG6WGAswtH5UOxvyWopXu5JAh9PTkSHDerAbnnd
 LNZf0R7p+6TBwTdM/nH92qdptJLPoRrpb5I6HO7JG6OP6X4jjrc1jPa
X-Mailer: b4 0.12.3
Message-ID: <20231026-strncpy-drivers-iio-proximity-sx9324-c-v2-1-cee6e5db700c@google.com>
Subject: [PATCH v2] iio: sx9324: avoid copying property strings
From:   Justin Stitt <justinstitt@google.com>
To:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org,
        Justin Stitt <justinstitt@google.com>
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

We're doing some needless string copies when trying to assign the proper
`prop` string. We can make `prop` a const char* and simply assign to
string literals.

For the case where a format string is used, let's allocate some memory
via kasprintf() and point prop to it.

This also cleans up some deprecated strncpy() uses [1].

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://github.com/KSPP/linux/issues/90
Cc: linux-hardening@vger.kernel.org
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
Changes in v2:
- make prop a const char* and do simple assignments (thanks Jonathan)
- rebase onto 3a568e3a961ba330
- Link to v1: https://lore.kernel.org/r/20230921-strncpy-drivers-iio-proximity-sx9324-c-v1-1-4e8d28fd1e7c@google.com
---
Note: build-tested
---
 drivers/iio/proximity/sx9324.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/proximity/sx9324.c b/drivers/iio/proximity/sx9324.c
index 438f9c9aba6e..c8547035cb47 100644
--- a/drivers/iio/proximity/sx9324.c
+++ b/drivers/iio/proximity/sx9324.c
@@ -885,7 +885,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
 #define SX9324_RESOLUTION_DEF "semtech,ph01-resolution"
 #define SX9324_PROXRAW_DEF "semtech,ph01-proxraw-strength"
 	unsigned int pin_defs[SX9324_NUM_PINS];
-	char prop[] = SX9324_PROXRAW_DEF;
+	const char *prop = SX9324_PROXRAW_DEF;
 	u32 start = 0, raw = 0, pos = 0;
 	int ret, count, ph, pin;
 	const char *res;
@@ -899,7 +899,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
 	case SX9324_REG_AFE_PH2:
 	case SX9324_REG_AFE_PH3:
 		ph = reg_def->reg - SX9324_REG_AFE_PH0;
-		snprintf(prop, ARRAY_SIZE(prop), "semtech,ph%d-pin", ph);
+		prop = kasprintf(GFP_KERNEL, "semtech,ph%d-pin", ph);
 
 		count = device_property_count_u32(dev, prop);
 		if (count != ARRAY_SIZE(pin_defs))
@@ -913,6 +913,7 @@ sx9324_get_default_reg(struct device *dev, int idx,
 			raw |= (pin_defs[pin] << (2 * pin)) &
 			       SX9324_REG_AFE_PH0_PIN_MASK(pin);
 		reg_def->def = raw;
+		kfree(prop);
 		break;
 	case SX9324_REG_AFE_CTRL0:
 		ret = device_property_read_string(dev,
@@ -937,11 +938,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
 	case SX9324_REG_AFE_CTRL4:
 	case SX9324_REG_AFE_CTRL7:
 		if (reg_def->reg == SX9324_REG_AFE_CTRL4)
-			strncpy(prop, "semtech,ph01-resolution",
-				ARRAY_SIZE(prop));
+			prop = "semtech,ph01-resolution";
 		else
-			strncpy(prop, "semtech,ph23-resolution",
-				ARRAY_SIZE(prop));
+			prop = "semtech,ph23-resolution";
 
 		ret = device_property_read_u32(dev, prop, &raw);
 		if (ret)
@@ -1012,11 +1011,9 @@ sx9324_get_default_reg(struct device *dev, int idx,
 	case SX9324_REG_PROX_CTRL0:
 	case SX9324_REG_PROX_CTRL1:
 		if (reg_def->reg == SX9324_REG_PROX_CTRL0)
-			strncpy(prop, "semtech,ph01-proxraw-strength",
-				ARRAY_SIZE(prop));
+			prop = "semtech,ph01-proxraw-strength";
 		else
-			strncpy(prop, "semtech,ph23-proxraw-strength",
-				ARRAY_SIZE(prop));
+			prop = "semtech,ph23-proxraw-strength";
 		ret = device_property_read_u32(dev, prop, &raw);
 		if (ret)
 			break;

---
base-commit: 3a568e3a961ba330091cd031647e4c303fa0badb
change-id: 20230921-strncpy-drivers-iio-proximity-sx9324-c-8c3437676039

Best regards,
--
Justin Stitt <justinstitt@google.com>

