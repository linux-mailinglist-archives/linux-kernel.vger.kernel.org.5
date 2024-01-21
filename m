Return-Path: <linux-kernel+bounces-31975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 38E158354A9
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 06:33:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5DF221C2213C
	for <lists+linux-kernel@lfdr.de>; Sun, 21 Jan 2024 05:33:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17724364CB;
	Sun, 21 Jan 2024 05:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vd0tHpIP"
Received: from mail-pj1-f44.google.com (mail-pj1-f44.google.com [209.85.216.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCE613613A;
	Sun, 21 Jan 2024 05:32:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705815161; cv=none; b=s0CvEDSArPmvbzEGDamNm7PgJKVGOtQGHdPOKvPaM80ySypVPRSKfBhFxtY4BDpC8OOeOFLCFn3pigYEgm76xcpCDheXZ7pN9/PBhBcbiI7ZY2DuJAAywK1y9SNVCsPJtpaSBVdmOfwjOYsWRMBE4XBILjV6QtBF17lMQCaPVbI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705815161; c=relaxed/simple;
	bh=AphfAL3cM0xZOhnH9SIZrKDesJmNNMtj5nIKD9faQ2w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g4ZB26VM3Srf/nQFl4QSTzxICDXMqVfnpJm28P7s7EPdmW3XBPqrk0BBsuSsmA6wOzem3NbCsgJfifcWYrMLc2tKQ74OMDZUQOdg38nXNgpMvMpMVjrJgaPimoz5/dDbNZYlP+x5CdF1jz0ZmnOEq3jVi2s17pTvBFyZ8Ldt7vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vd0tHpIP; arc=none smtp.client-ip=209.85.216.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f44.google.com with SMTP id 98e67ed59e1d1-28be8ebcdc1so1191427a91.0;
        Sat, 20 Jan 2024 21:32:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705815159; x=1706419959; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZEiAmvaeobj6IMpvm26ebe6qCNpZqbeBLm49Jnrvqx4=;
        b=Vd0tHpIPHcZSlwIeK9zVvj5vmvpP4UKWqm+LRjIpJMlwEcvvAKJhoFk/maxELaS+ZX
         cFk9RDiN2WP7RsDlWL9le9omonYUmHfMPGF4JgauQYKHBsjtB7sEljQhQCPeH4IMSYmX
         9vwwkHXClq8BGCIQ66DFpQmghoS8HoQXAnF0ZF01NAzKPkyrabTw6JZE2ynSSA6pSbKs
         KygyHbsdFqHt1XrLKSN5vcH7fsVrnnrRDyeBQvV6cR95LdCdIA/yEap8RLeVvFPfOZBJ
         KyuxqTf7UCbA+bo/IW0XsTQgYS/ymOTNheLNB1KQWc2Gnhs3dhOtdRs7tpwxZEppf+Wr
         3CxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705815159; x=1706419959;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZEiAmvaeobj6IMpvm26ebe6qCNpZqbeBLm49Jnrvqx4=;
        b=UHr5aWexu/RBw08Dhs7PH2q+vQv5d3DFtiMI5gg6g8IBLQ+oBly3CUBKsN+Cfjooak
         BNX81jdXiuGawaM1IB9oSLR8f9xVh9gDaW+KBZ/iyFu2Q30NGUHU/4Pyh80JB2VvAwkr
         CkQ898ljP2dGjfXiqFJDqMbHdQsy21UgXBWaIJwsGmhMwofmAvkGMTK4I2JNJig/TOQh
         ZFPPtTdNs9WRY74aKKjZB6dj+XAXfk9s+Cb+cFIgcNm4tHN7dgo6NpN9o94fDEznyO/U
         0n0LJ80iFS7bCoGN8NXi8f0R0j+zD3eipNj5zoViO5VyAWtGDAI65W6MIKN2gyxDNmgg
         i9UQ==
X-Gm-Message-State: AOJu0YxBh5hpKVsM+lpN/ucnAVYKujJoVgXBzZt/QMGT27QFDUWEECO7
	R2CXBNRov7lTMKf+c/vb/THKet45WEtvUYPEAAxQqyQ9R9qt8jmXT2zNNGNs
X-Google-Smtp-Source: AGHT+IEtwf0VO/jX1V1D1Va5aahAVxhr1+Fz+ATwGT4IZFiGVqWIwqnCzyRuGk9PgwSzQoajiCLRLg==
X-Received: by 2002:a17:90a:d390:b0:290:3e62:92ab with SMTP id q16-20020a17090ad39000b002903e6292abmr683818pju.29.1705815158650;
        Sat, 20 Jan 2024 21:32:38 -0800 (PST)
Received: from dtor-ws.mtv.corp.google.com ([2620:15c:9d:2:b227:ab83:6b35:c967])
        by smtp.gmail.com with ESMTPSA id mg7-20020a170903348700b001d69badff91sm5323978plb.148.2024.01.20.21.32.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Jan 2024 21:32:37 -0800 (PST)
From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
To: linux-input@vger.kernel.org,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 3/3] Input: matrix_keypad - switch to using managed resources
Date: Sat, 20 Jan 2024 21:32:30 -0800
Message-ID: <20240121053232.276968-3-dmitry.torokhov@gmail.com>
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

Switch the drivers to use managed resources (devm) to simplify error
handling and remove the need to have remove() implementation.

Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
---
 drivers/input/keyboard/matrix_keypad.c | 89 +++++++-------------------
 1 file changed, 24 insertions(+), 65 deletions(-)

diff --git a/drivers/input/keyboard/matrix_keypad.c b/drivers/input/keyboard/matrix_keypad.c
index 44ef600b8f19..695c03e075b5 100644
--- a/drivers/input/keyboard/matrix_keypad.c
+++ b/drivers/input/keyboard/matrix_keypad.c
@@ -278,38 +278,41 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 
 	/* initialized strobe lines as outputs, activated */
 	for (i = 0; i < pdata->num_col_gpios; i++) {
-		err = gpio_request(pdata->col_gpios[i], "matrix_kbd_col");
+		err = devm_gpio_request(&pdev->dev,
+					pdata->col_gpios[i], "matrix_kbd_col");
 		if (err) {
 			dev_err(&pdev->dev,
 				"failed to request GPIO%d for COL%d\n",
 				pdata->col_gpios[i], i);
-			goto err_free_cols;
+			return err;
 		}
 
 		gpio_direction_output(pdata->col_gpios[i], !pdata->active_low);
 	}
 
 	for (i = 0; i < pdata->num_row_gpios; i++) {
-		err = gpio_request(pdata->row_gpios[i], "matrix_kbd_row");
+		err = devm_gpio_request(&pdev->dev,
+					pdata->row_gpios[i], "matrix_kbd_row");
 		if (err) {
 			dev_err(&pdev->dev,
 				"failed to request GPIO%d for ROW%d\n",
 				pdata->row_gpios[i], i);
-			goto err_free_rows;
+			return err;
 		}
 
 		gpio_direction_input(pdata->row_gpios[i]);
 	}
 
 	if (pdata->clustered_irq > 0) {
-		err = request_any_context_irq(pdata->clustered_irq,
+		err = devm_request_any_context_irq(&pdev->dev,
+				pdata->clustered_irq,
 				matrix_keypad_interrupt,
 				pdata->clustered_irq_flags,
 				"matrix-keypad", keypad);
 		if (err < 0) {
 			dev_err(&pdev->dev,
 				"Unable to acquire clustered interrupt\n");
-			goto err_free_rows;
+			return err;
 		}
 
 		keypad->row_irqs[0] = pdata->clustered_irq;
@@ -322,10 +325,11 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 				dev_err(&pdev->dev,
 					"Unable to convert GPIO line %i to irq: %d\n",
 					pdata->row_gpios[i], err);
-				goto err_free_irqs;
+				return err;
 			}
 
-			err = request_any_context_irq(irq,
+			err = devm_request_any_context_irq(&pdev->dev,
+					irq,
 					matrix_keypad_interrupt,
 					IRQF_TRIGGER_RISING |
 						IRQF_TRIGGER_FALLING,
@@ -334,7 +338,7 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 				dev_err(&pdev->dev,
 					"Unable to acquire interrupt for GPIO line %i\n",
 					pdata->row_gpios[i]);
-				goto err_free_irqs;
+				return err;
 			}
 
 			keypad->row_irqs[i] = irq;
@@ -345,36 +349,8 @@ static int matrix_keypad_init_gpio(struct platform_device *pdev,
 
 	/* initialized as disabled - enabled by input->open */
 	disable_row_irqs(keypad);
-	return 0;
-
-err_free_irqs:
-	while (--i >= 0)
-		free_irq(keypad->row_irqs[i], keypad);
-	i = pdata->num_row_gpios;
-err_free_rows:
-	while (--i >= 0)
-		gpio_free(pdata->row_gpios[i]);
-	i = pdata->num_col_gpios;
-err_free_cols:
-	while (--i >= 0)
-		gpio_free(pdata->col_gpios[i]);
-
-	return err;
-}
-
-static void matrix_keypad_free_gpio(struct matrix_keypad *keypad)
-{
-	const struct matrix_keypad_platform_data *pdata = keypad->pdata;
-	int i;
-
-	for (i = 0; i < keypad->num_row_irqs; i++)
-		free_irq(keypad->row_irqs[i], keypad);
-
-	for (i = 0; i < pdata->num_row_gpios; i++)
-		gpio_free(pdata->row_gpios[i]);
 
-	for (i = 0; i < pdata->num_col_gpios; i++)
-		gpio_free(pdata->col_gpios[i]);
+	return 0;
 }
 
 #ifdef CONFIG_OF
@@ -473,12 +449,13 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 		return -EINVAL;
 	}
 
-	keypad = kzalloc(sizeof(struct matrix_keypad), GFP_KERNEL);
-	input_dev = input_allocate_device();
-	if (!keypad || !input_dev) {
-		err = -ENOMEM;
-		goto err_free_mem;
-	}
+	keypad = devm_kzalloc(&pdev->dev, sizeof(*keypad), GFP_KERNEL);
+	if (!keypad)
+		return -ENOMEM;
+
+	input_dev = devm_input_allocate_device(&pdev->dev);
+	if (!input_dev)
+		return -ENOMEM;
 
 	keypad->input_dev = input_dev;
 	keypad->pdata = pdata;
@@ -489,7 +466,6 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 
 	input_dev->name		= pdev->name;
 	input_dev->id.bustype	= BUS_HOST;
-	input_dev->dev.parent	= &pdev->dev;
 	input_dev->open		= matrix_keypad_start;
 	input_dev->close	= matrix_keypad_stop;
 
@@ -499,7 +475,7 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 					 NULL, input_dev);
 	if (err) {
 		dev_err(&pdev->dev, "failed to build keymap\n");
-		goto err_free_mem;
+		return -ENOMEM;
 	}
 
 	if (!pdata->no_autorepeat)
@@ -509,32 +485,16 @@ static int matrix_keypad_probe(struct platform_device *pdev)
 
 	err = matrix_keypad_init_gpio(pdev, keypad);
 	if (err)
-		goto err_free_mem;
+		return err;
 
 	err = input_register_device(keypad->input_dev);
 	if (err)
-		goto err_free_gpio;
+		return err;
 
 	device_init_wakeup(&pdev->dev, pdata->wakeup);
 	platform_set_drvdata(pdev, keypad);
 
 	return 0;
-
-err_free_gpio:
-	matrix_keypad_free_gpio(keypad);
-err_free_mem:
-	input_free_device(input_dev);
-	kfree(keypad);
-	return err;
-}
-
-static void matrix_keypad_remove(struct platform_device *pdev)
-{
-	struct matrix_keypad *keypad = platform_get_drvdata(pdev);
-
-	matrix_keypad_free_gpio(keypad);
-	input_unregister_device(keypad->input_dev);
-	kfree(keypad);
 }
 
 #ifdef CONFIG_OF
@@ -547,7 +507,6 @@ MODULE_DEVICE_TABLE(of, matrix_keypad_dt_match);
 
 static struct platform_driver matrix_keypad_driver = {
 	.probe		= matrix_keypad_probe,
-	.remove_new	= matrix_keypad_remove,
 	.driver		= {
 		.name	= "matrix-keypad",
 		.pm	= pm_sleep_ptr(&matrix_keypad_pm_ops),
-- 
2.43.0.429.g432eaa2c6b-goog


