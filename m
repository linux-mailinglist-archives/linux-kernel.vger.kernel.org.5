Return-Path: <linux-kernel+bounces-31974-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A4EA8354A7
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 06:32:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECF43283744
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 05:32:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBC8E364AC;
	Sun, 21 Jan 2024 05:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cyjKsxio"
Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865ED2EB19;
	Sun, 21 Jan 2024 05:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705815160; cv=none; b=ehajHifneJpG0GO4px9bpcRkCsQNoXtl5XcT0/pegLb2fRT9rpp+RpwU7323CPN5HbXyZaIS6lIAKzd2JzsErvvdLlZ6zNHmqvP9Tw0POGa/j0ItoLES3J/qiK4Q8aPTxaFdIbeL3Keyrx73xAux7sVOxdTSAUYy92MemLWnpgU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705815160; c=relaxed/simple;
	bh=LHz06Lyhxlmi9enxiiPXvlRXe6QQ2nBa6+/km1b7dcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZQhLZehuCSo1rUlupa/gRa8nD1ZSLMRwOLNrpbrlQKpcJGo5T3hvXOOa3EPUEUnsGSshuvgW7h+dn604mcOsrITVL7Lb33MV307h3K8uwNpZMLNexjq8/GYSHhAmIfqBmlzQzbvo2U+GfQyeM9pc/XqMFBq+SrGc+4RFbUvozDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cyjKsxio; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-204f50f305cso1404138fac.3;
        Sat, 20 Jan 2024 21:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705815157; x=1706419957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dBrp1Ps9xzLA8SOiLy9P8sSqne7yU34XilTqawEafXQ=;
        b=cyjKsxioQuWiuuMRSf/B+Il04uPIHZKQrOIF1has5+1IpaUJAt5ZHRUHHLj67IwssQ
         GI1XoEhiLdw/EhGskliZ1FVKMCokZtcnq/K2FCc/zbnX3zwv/MvaAsG22L6OkzpjIjRh
         tZFQ2Rs/Z6j9otysz9VwmowdlMlV8NVdrxpVDazA0S9u7iVA7LkmuO5kBZngfCSnE0oE
         SPUeVChh1Cx6KIvpnYYz0BJrpnc3f23srT25bR3bdSeBXNTf8KDdR3qp1YH3qaj8YRsH
         Qvs+c7A8z0XvelVCQPgQvVJ50EbU6XTfOGNIe2umKOuDtmYMTttM43n/EfMuiV1slzrL
         zqcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705815157; x=1706419957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dBrp1Ps9xzLA8SOiLy9P8sSqne7yU34XilTqawEafXQ=;
        b=LwUvnGbHgaYvzmr1r4x8YbLDODaMCHzdoxZW3kYe9GuitaWpMR8kIBf7G5/81/IZM0
         08nHG7lKyibvijmfAgohoZFhuMwbOFPI3G6O1jYfspAMcx6hkQ8NwMYQIHGNPvKKk+ZK
         kFuWG+3WhOp2bBqo0dtiEfHA/ihD8MpsFxexdNOsQJoxIQVZG3airbFqT2uk0WkAQi/u
         R/Xc5FjaIznE5BYud4U2sQGbg8AUwI0E+sPddXSIixMT2g08db/uG8H/JOr2rLBJx/o8
         RhbyQ7RcNN47PnbSONV3SSvB82w2rln6GP0GVTSZGfIJPsy56eLk2UvxNdfIOSRnP/9u
         T/8Q==
X-Gm-Message-State: AOJu0YxLcWj4UsIy8YHkcMZOio/MFW7M3mO5/eXVMRUx7W8cUqg1kwb+
	aRPEWU55HMqKsneFLeXo73cNjaoOsV/ZhMYHrc6FpfTZOswxYLYM3LaJUwzv
X-Google-Smtp-Source: AGHT+IE0RMaZJ7Yi27VLKIXrVx8VSF8t+AZp+vVrzIIL354OByUQiTDitByd0TmI3u0pTWeDRY/6tA==
X-Received: by 2002:a05:6870:63a9:b0:214:2677:8b08 with SMTP id t41-20020a05687063a900b0021426778b08mr2200285oap.90.1705815157140;
        Sat, 20 Jan 2024 21:32:37 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:b227:ab83:6b35:c967])
        by smtp.gmail.com with ESMTPSA id mg7-20020a170903348700b001d69badff91sm5323978plb.148.2024.01.20.21.32.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 21:32:36 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] Input: matrix_keypad - consolidate handling of clustered interrupt
Date: Sat, 20 Jan 2024 21:32:29 -0800
Message-ID: <20240121053232.276968-2-dmitry.torokhov@gmail.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240121053232.276968-1-dmitry.torokhov@gmail.com>
References: <20240121053232.276968-1-dmitry.torokhov@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Now that the driver stores interrupt numbers corresponding to individual
GPIOs in non-clustered mode, it is possible to unify handling of both
modes by storing clustered interrupt at position 0 and setting the
number of interrupts in this case to 1.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/matrix_keypad.c | 63 ++++++++------------------
 1 file changed, 20 insertions(+), 43 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 1cd1ffb80401..44ef600b8f19 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -27,9 +27,10 @@ struct matrix_keypad {
 	const struct matrix_keypad_platform_data *pdata;
 	struct input_dev *input_dev;
 	unsigned int row_shift;
-	unsigned int row_irqs[MATRIX_MAX_ROWS];
 
-	DECLARE_BITMAP(disabled_gpios, MATRIX_MAX_ROWS);
+	unsigned int row_irqs[MATRIX_MAX_ROWS];
+	unsigned int num_row_irqs;
+	DECLARE_BITMAP(wakeup_enabled_irqs, MATRIX_MAX_ROWS);
 
 	uint32_t last_key_state[MATRIX_MAX_COLS];
 	struct delayed_work work;
@@ -86,28 +87,18 @@ static bool row_asserted(const struct matrix_keypad_platform_data *pdata,
 
 static void enable_row_irqs(struct matrix_keypad *keypad)
 {
-	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
 
-	if (pdata->clustered_irq > 0)
-		enable_irq(pdata->clustered_irq);
-	else {
-		for (i = 0; i < pdata->num_row_gpios; i++)
-			enable_irq(keypad->row_irqs[i]);
-	}
+	for (i = 0; i < keypad->num_row_irqs; i++)
+		enable_irq(keypad->row_irqs[i]);
 }
 
 static void disable_row_irqs(struct matrix_keypad *keypad)
 {
-	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
 
-	if (pdata->clustered_irq > 0)
-		disable_irq_nosync(pdata->clustered_irq);
-	else {
-		for (i = 0; i < pdata->num_row_gpios; i++)
-			disable_irq_nosync(keypad->row_irqs[i]);
-	}
+	for (i = 0; i < keypad->num_row_irqs; i++)
+		disable_irq_nosync(keypad->row_irqs[i]);
 }
 
 /*
@@ -233,35 +224,20 @@ static void matrix_keypad_stop(struct input_dev *dev)
 
 static void matrix_keypad_enable_wakeup(struct matrix_keypad *keypad)
 {
-	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
 
-	if (pdata->clustered_irq > 0) {
-		if (enable_irq_wake(pdata->clustered_irq) == 0)
-			keypad->gpio_all_disabled = true;
-	} else {
-
-		for (i = 0; i < pdata->num_row_gpios; i++)
-			if (!test_bit(i, keypad->disabled_gpios))
-				if (enable_irq_wake(keypad->row_irqs[i]) == 0)
-					__set_bit(i, keypad->disabled_gpios);
-	}
+	for_each_clear_bit(i, keypad->wakeup_enabled_irqs, keypad->num_row_irqs)
+		if (enable_irq_wake(keypad->row_irqs[i]) == 0)
+			__set_bit(i, keypad->wakeup_enabled_irqs);
 }
 
 static void matrix_keypad_disable_wakeup(struct matrix_keypad *keypad)
 {
-	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
 
-	if (pdata->clustered_irq > 0) {
-		if (keypad->gpio_all_disabled) {
-			disable_irq_wake(pdata->clustered_irq);
-			keypad->gpio_all_disabled = false;
-		}
-	} else {
-		for (i = 0; i < pdata->num_row_gpios; i++)
-			if (test_and_clear_bit(i, keypad->disabled_gpios))
-				disable_irq_wake(keypad->row_irqs[i]);
+	for_each_set_bit(i, keypad->wakeup_enabled_irqs, keypad->num_row_irqs) {
+		disable_irq_wake(keypad->row_irqs[i]);
+		__clear_bit(i, keypad->wakeup_enabled_irqs);
 	}
 }
 
@@ -335,6 +311,9 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 				"Unable to acquire clustered interrupt\n");
 			goto err_free_rows;
 		}
+
+		keypad->row_irqs[0] = pdata->clustered_irq;
+		keypad->num_row_irqs = 1;
 	} else {
 		for (i = 0; i < pdata->num_row_gpios; i++) {
 			irq = gpio_to_irq(pdata->row_gpios[i]);
@@ -360,6 +339,8 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 
 			keypad->row_irqs[i] = irq;
 		}
+
+		keypad->num_row_irqs = pdata->num_row_gpios;
 	}
 
 	/* initialized as disabled - enabled by input->open */
@@ -386,12 +367,8 @@ static void matrix_keypad_free_gpio(struct matrix_keypad *keypad)
 	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
 	int i;
 
-	if (pdata->clustered_irq > 0) {
-		free_irq(pdata->clustered_irq, keypad);
-	} else {
-		for (i = 0; i < pdata->num_row_gpios; i++)
-			free_irq(keypad->row_irqs[i], keypad);
-	}
+	for (i = 0; i < keypad->num_row_irqs; i++)
+		free_irq(keypad->row_irqs[i], keypad);
 
 	for (i = 0; i < pdata->num_row_gpios; i++)
 		gpio_free(pdata->row_gpios[i]);
-- 
2.43.0.429.g432eaa2c6b-goog


