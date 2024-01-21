Return-Path: <linux-kernel+bounces-31973-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A165B8354A6
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 06:32:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 127ADB23296
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 05:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD2AB3613B;
	Sun, 21 Jan 2024 05:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VX9WYU23"
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9534A2EB0C;
	Sun, 21 Jan 2024 05:32:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705815159; cv=none; b=fE4hmn0e/9eD2he64i0OOp9h27oHXrMlOX5sPHqG52Mz4ko8vnpwaAWZrrnw9Da4QhieimoLCxs91v5w0kVscGXtddyPFAa7A0HuFGDA4DPWlTaGtQsMQL5MEezJNuxMb3KSoXPhmuSl547mtg31V0rZCBPnwhnskYAQWF7QrIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705815159; c=relaxed/simple;
	bh=kDs/gHMG46M1CA5pRp7+yWHyLg9b6bCwP0OjJBW+ZRU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rXjfHnaSWKyghYq5wGJkwPOB3wubyYF1q1/fzPz+bngXt/k6AM311REufbcsvI6ZfPBx3dPagc+EmN/694KkiG5/7sJJ3C42mBePf5a7IrbFEtbFxiQGrTrmFEK2oojOTeQ334TvOv/QD42CIlymkAhdMUbrByPwUXvd2cz3TiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VX9WYU23; arc=none smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-5ffb07bdce2so7406597b3.2;
        Sat, 20 Jan 2024 21:32:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705815156; x=1706419956; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OHkj/zEKHXm2Shyb5HJF8APWEjoB9yOi3ptmZt3zAB4=;
        b=VX9WYU23+TKy7SALPG2+b+/C6TT4srvq3z5SbzJ96j0Y1YNfLR5YxkhBuBh3ufmeDB
         lYed/phW7uzhwxvIO9grQOGFkb7tmngZGiIiDxun5eqTiNBu/ACAI4+qabYzHiodcHs7
         sU8EEPHehxCja6oumFqf7AGJD56HF3i9gJiC2B+H6OTSlsXwf/aNB6px/x8OgkLBe4ZZ
         jS6mm/f8bCEpjjcHittGCtLmdF1Dh/bCcwlmJ8Nh4iFQgZK2rwBs1l5vIxR5bdcOwHCX
         71J6ohMBkJ32GLa9whXS997TQ+ukBslH6uI52XgwO3pa8Q52fPgybrctdMSnsBgkmbUh
         nPvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705815156; x=1706419956;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OHkj/zEKHXm2Shyb5HJF8APWEjoB9yOi3ptmZt3zAB4=;
        b=Z87HqiiUWVxgwnoKV3QAFdNEIJfv8xDdM/jsGXC6mFNrfb6+fUw0ZeOIORaE7w+Sfd
         7ri3dKuSShO+j71qrO6LCNvIrSB60aNe9Ezx4n4623E9Smvh3rjWdATTzNVC3CpR3tck
         Km7j2snS2QnKQHl2CZ5kAMKpzUamFkRwiwV8oLvS4TMjWuqsjQly+Sk1oacKG/UUcatr
         ALkte0d49Qf6lcR5SdAzIxQI92CMHf2J4kup1qB8CBENTChZgrU/LXkrS0g1mu0+sFh1
         FOtA8//qYCbYDTTbgOBYdXtam23fpSxMs0MBr2f04w/9l0Ws6JJuTyjcghPdLVb8ubg4
         lT1w==
X-Gm-Message-State: AOJu0Yy75h3JHIa89DTMsRCC+iQAOWTmj7MGxfO+KU1MR/CHfh6GDEux
	ebFvONG20/r4ehmTh1Nqr+IYwGr4Xl5afyTqlXb6KP7H9OMT9YdtTcDjgagi
X-Google-Smtp-Source: AGHT+IFkpUlmfnQ2TzdRcfycNerdMBgBU/2Bf0f+1KtRCpBlOTwZvxsLfbfpWs7sDDx3TNsnDlcMPA==
X-Received: by 2002:a81:7746:0:b0:5ff:95a8:945 with SMTP id s67-20020a817746000000b005ff95a80945mr2253046ywc.88.1705815156224;
        Sat, 20 Jan 2024 21:32:36 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:b227:ab83:6b35:c967])
        by smtp.gmail.com with ESMTPSA id mg7-20020a170903348700b001d69badff91sm5323978plb.148.2024.01.20.21.32.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 21:32:35 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] Input: matrix_keypad - avoid repeatedly converting GPIO to IRQ
Date: Sat, 20 Jan 2024 21:32:28 -0800
Message-ID: <20240121053232.276968-1-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gpio_to_irq() is getting more expensive and may require sleeping.
Convert row GPIOs to interrupt numbers once in probe() and use
this information when the driver needs to enable or disable given
interrupt line.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/matrix_keypad.c | 48 ++++++++++++++------------
 1 file changed, 25 insertions(+), 23 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 50fa764c82d2..1cd1ffb80401 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -27,6 +27,7 @@ struct matrix_keypad {
 	const struct matrix_keypad_platform_data *pdata;
 	struct input_dev *input_dev;
 	unsigned int row_shift;
+	unsigned int row_irqs[MATRIX_MAX_ROWS];
 
 	DECLARE_BITMAP(disabled_gpios, MATRIX_MAX_ROWS);
 
@@ -92,7 +93,7 @@ static void enable_row_irqs(struct matrix_keypad *keypad)
 		enable_irq(pdata->clustered_irq);
 	else {
 		for (i = 0; i < pdata->num_row_gpios; i++)
-			enable_irq(gpio_to_irq(pdata->row_gpios[i]));
+			enable_irq(keypad->row_irqs[i]);
 	}
 }
 
@@ -105,7 +106,7 @@ static void disable_row_irqs(struct matrix_keypad *keypad)
 		disable_irq_nosync(pdata->clustered_irq);
 	else {
 		for (i = 0; i < pdata->num_row_gpios; i++)
-			disable_irq_nosync(gpio_to_irq(pdata->row_gpios[i]));
+			disable_irq_nosync(keypad->row_irqs[i]);
 	}
 }
 
@@ -233,7 +234,6 @@ static void matrix_keypad_stop(struct input_dev *dev)
 static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
 {
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
-	unsigned int gpio;
 	int i;
 
 	if (pdata->clustered_irq > 0) {
@@ -241,21 +241,16 @@ static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
 			keypad->gpio_all_disabled = true;
 	} else {
 
-		for (i = 0; i < pdata->num_row_gpios; i++) {
-			if (!test_bit(i, keypad->disabled_gpios)) {
-				gpio = pdata->row_gpios[i];
-
-				if (enable_irq_wake(gpio_to_irq(gpio)) == 0)
+		for (i = 0; i < pdata->num_row_gpios; i++)
+			if (!test_bit(i, keypad->disabled_gpios))
+				if (enable_irq_wake(keypad->row_irqs[i]) == 0)
 					__set_bit(i, keypad->disabled_gpios);
-			}
-		}
 	}
 }
 
 static void matrix_keypad_disable_wakeup(struct matrix_keypad *keypad)
 {
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
-	unsigned int gpio;
 	int i;
 
 	if (pdata->clustered_irq > 0) {
@@ -264,12 +259,9 @@ static void matrix_keypad_disable_wakeup(struct matrix_keypad *keypad)
 			keypad->gpio_all_disabled = false;
 		}
 	} else {
-		for (i = 0; i < pdata->num_row_gpios; i++) {
-			if (test_and_clear_bit(i, keypad->disabled_gpios)) {
-				gpio = pdata->row_gpios[i];
-				disable_irq_wake(gpio_to_irq(gpio));
-			}
-		}
+		for (i = 0; i < pdata->num_row_gpios; i++)
+			if (test_and_clear_bit(i, keypad->disabled_gpios))
+				disable_irq_wake(keypad->row_irqs[i]);
 	}
 }
 
@@ -306,7 +298,7 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 				   struct matrix_keypad *keypad)
 {
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
-	int i, err;
+	int i, irq, err;
 
 	/* initialized strobe lines as outputs, activated */
 	for (i = 0; i < pdata->num_col_gpios; i++) {
@@ -345,11 +337,19 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 		}
 	} else {
 		for (i = 0; i < pdata->num_row_gpios; i++) {
-			err = request_any_context_irq(
-					gpio_to_irq(pdata->row_gpios[i]),
+			irq = gpio_to_irq(pdata->row_gpios[i]);
+			if (irq < 0) {
+				err = irq;
+				dev_err(&pdev->dev,
+					"Unable to convert GPIO line %i to irq: %d\n",
+					pdata->row_gpios[i], err);
+				goto err_free_irqs;
+			}
+
+			err = request_any_context_irq(irq,
 					matrix_keypad_interrupt,
 					IRQF_TRIGGER_RISING |
-					IRQF_TRIGGER_FALLING,
+						IRQF_TRIGGER_FALLING,
 					"matrix-keypad", keypad);
 			if (err < 0) {
 				dev_err(&pdev->dev,
@@ -357,6 +357,8 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 					pdata->row_gpios[i]);
 				goto err_free_irqs;
 			}
+
+			keypad->row_irqs[i] = irq;
 		}
 	}
 
@@ -366,7 +368,7 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 
 err_free_irqs:
 	while (--i >= 0)
-		free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
+		free_irq(keypad->row_irqs[i], keypad);
 	i = pdata->num_row_gpios;
 err_free_rows:
 	while (--i >= 0)
@@ -388,7 +390,7 @@ static void matrix_keypad_free_gpio(struct matrix_keypad *keypad)
 		free_irq(pdata->clustered_irq, keypad);
 	} else {
 		for (i = 0; i < pdata->num_row_gpios; i++)
-			free_irq(gpio_to_irq(pdata->row_gpios[i]), keypad);
+			free_irq(keypad->row_irqs[i], keypad);
 	}
 
 	for (i = 0; i < pdata->num_row_gpios; i++)
-- 
2.43.0.429.g432eaa2c6b-goog


