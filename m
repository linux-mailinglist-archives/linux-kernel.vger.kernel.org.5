Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E13280E400
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Dec 2023 06:51:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235068AbjLLFoS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Dec 2023 00:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjLLFnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Dec 2023 00:43:55 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8791DD5;
        Mon, 11 Dec 2023 21:43:49 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id e9e14a558f8ab-35d67599613so34683435ab.3;
        Mon, 11 Dec 2023 21:43:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702359827; x=1702964627; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3KM4jX2NpfEf4zqjQE8TdyIYduegnir9m5FMRtl4TaI=;
        b=fkXbV5BAVJd9RJt8sv+vCSDQo/Kuw91BeEQ0PqKxCgIpXnrbjZ4cIxtSH5zOWSd7Md
         WPn7rWKt9eCc8yNIXRojrlxylCuY6r0+dXz42OfnH777eXbkH3mF6hdOV/P1UJoabyem
         we7BTbfIk7015F0g4FgPqvYxxvYjJKchhJrxYWGUaCfRf+ZQ/GNiaQ9jE4hePbDgFaXZ
         TiBxswI7sy4VmyUlfXkEfn1iAhkMIIi4NdS2dUZa0tY1NNlylmp6NEAjP9l29avBMhjV
         8GsM7ziEEBmYmyIiAM1k1aBBN9wIQxwwIHj9NkoDEM5OOlJURqCwfNsxEmyaO8UMXx3N
         KUEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702359827; x=1702964627;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3KM4jX2NpfEf4zqjQE8TdyIYduegnir9m5FMRtl4TaI=;
        b=P9fjVkpvt3Sl/uw2UScwSYh0XLI2rZjOMttAWFVDKflkARbKlRUGAQncvxkDifgz8s
         MsXu2BnLKRFgq5EIxBkDWUQ2psqpaCFYrYAyaIvc/ClgaflPZ7jA9RBSHZGPD4QYLFSO
         wuWQJZSl4QnVdgg1OOspPleZqA3Swz+JvlCHKiubu9buCpk8g9mt248uPiia+51QEK2l
         o1VHxLTTufTAQrahzOGjNmHXj1PGGbTXaCzPYDIwMKgmEBVl0M9Z3dKw/PL1NoAuUu+B
         HagPRfkY/tsZnKEMfSTn87SPaTEQYwiw/MWStaq8+tk5RhXP7AbIOyCD8KmM8LsHfwIR
         +DRQ==
X-Gm-Message-State: AOJu0YwWJZzhXV+TZf8bPXDF47/pSJe6b3AzfYX6NmqPFetUXgJiNqet
        zIKMdtvQBgLT8xaHhTUWjdfb/xsULns=
X-Google-Smtp-Source: AGHT+IFhG1hd9YXnbwnehqDFFA+7YIzo2fa2zB4zVbAB2Sm2DEYy+Hmz2FnqgGlSRMiSX3JIJp0wzw==
X-Received: by 2002:a92:6907:0:b0:35d:a73b:4d2f with SMTP id e7-20020a926907000000b0035da73b4d2fmr7261182ilc.117.1702359826947;
        Mon, 11 Dec 2023 21:43:46 -0800 (PST)
Received: from rigel.home.arpa (194-223-186-106.tpgi.com.au. [194.223.186.106])
        by smtp.gmail.com with ESMTPSA id u13-20020a170902e5cd00b001d0be32b0basm7591836plf.217.2023.12.11.21.43.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 21:43:46 -0800 (PST)
From:   Kent Gibson <warthog618@gmail.com>
To:     linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        brgl@bgdev.pl, linus.walleij@linaro.org, andy@kernel.org
Cc:     Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 4/4] gpiolib: cdev: improve documentation of get/set values
Date:   Tue, 12 Dec 2023 13:42:53 +0800
Message-Id: <20231212054253.50094-5-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231212054253.50094-1-warthog618@gmail.com>
References: <20231212054253.50094-1-warthog618@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add documentation of the algorithm used to perform scatter/gather
of the requested lines and values in linereq_get_values() and
linereq_set_values_unlocked() to improve maintainability.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 37f2c9acc770..6878da5056f9 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1394,9 +1394,18 @@ static long linereq_get_values(struct linereq *lr, void __user *ip)
 	if (copy_from_user(&lv, ip, sizeof(lv)))
 		return -EFAULT;
 
+	/*
+	 * gpiod_get_array_value_complex() requires compacted desc and val
+	 * arrays, rather than the sparse ones in lv.
+	 * Calculation of num_get and construction of the desc array is
+	 * optimized to avoid allocation for the desc array for the common
+	 * num_get == 1 case.
+	 */
+	/* scan requested lines to calculate the subset to get */
 	for (num_get = 0, i = 0; i < lr->num_lines; i++) {
 		if (lv.mask & BIT_ULL(i)) {
 			num_get++;
+			/* capture desc for the num_get == 1 case */
 			descs = &lr->lines[i].desc;
 		}
 	}
@@ -1405,6 +1414,7 @@ static long linereq_get_values(struct linereq *lr, void __user *ip)
 		return -EINVAL;
 
 	if (num_get != 1) {
+		/* build compacted desc array */
 		descs = kmalloc_array(num_get, sizeof(*descs), GFP_KERNEL);
 		if (!descs)
 			return -ENOMEM;
@@ -1425,6 +1435,7 @@ static long linereq_get_values(struct linereq *lr, void __user *ip)
 
 	lv.bits = 0;
 	for (didx = 0, i = 0; i < lr->num_lines; i++) {
+		/* unpack compacted vals for the response */
 		if (lv.mask & BIT_ULL(i)) {
 			if (lr->lines[i].sw_debounced)
 				val = debounced_value(&lr->lines[i]);
@@ -1450,14 +1461,25 @@ static long linereq_set_values_unlocked(struct linereq *lr,
 	unsigned int i, didx, num_set;
 	int ret;
 
+	/*
+	 * gpiod_set_array_value_complex() requires compacted desc and val
+	 * arrays, rather than the sparse ones in lv.
+	 * Calculation of num_set and construction of the descs and vals arrays
+	 * is optimized to minimize scanning the lv->mask, and to avoid
+	 * allocation for the desc array for the common num_set == 1 case.
+	 */
 	bitmap_zero(vals, GPIO_V2_LINES_MAX);
+	/* scan requested lines to determine the subset to be set */
 	for (num_set = 0, i = 0; i < lr->num_lines; i++) {
 		if (lv->mask & BIT_ULL(i)) {
+			/* setting inputs is not allowed */
 			if (!test_bit(FLAG_IS_OUT, &lr->lines[i].desc->flags))
 				return -EPERM;
+			/* add to compacted values */
 			if (lv->bits & BIT_ULL(i))
 				__set_bit(num_set, vals);
 			num_set++;
+			/* capture desc for the num_set == 1 case */
 			descs = &lr->lines[i].desc;
 		}
 	}
@@ -1465,7 +1487,7 @@ static long linereq_set_values_unlocked(struct linereq *lr,
 		return -EINVAL;
 
 	if (num_set != 1) {
-		/* build compacted desc array and values */
+		/* build compacted desc array */
 		descs = kmalloc_array(num_set, sizeof(*descs), GFP_KERNEL);
 		if (!descs)
 			return -ENOMEM;
-- 
2.39.2

