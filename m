Return-Path: <linux-kernel+bounces-1864-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BF0E98154EE
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:18:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 29856B245B6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:18:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61F66EA4;
	Sat, 16 Dec 2023 00:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Sdgzobg+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720134A13;
	Sat, 16 Dec 2023 00:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d2350636d6so1169466b3a.2;
        Fri, 15 Dec 2023 16:17:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702685877; x=1703290677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=arlg1YXcHM8i0YCMKhN2VPucJk96xE9TSorG5ozqY0w=;
        b=Sdgzobg+2DjohfekdmISv6HffMYqMl+d/ZVN7JOvrf4pCy8vqQQPNeaBN4xyftTW0Q
         e9SZc9WMAxfMC8AMDtyYTUbKLkq4NzU1Y1SeDyazdYL4ZvQlSpdZfDV9x53mlVveMVd/
         JK3PYP9JxQlBZ55yhcqbbO493/uBDGN3UhjMPJjXIPTfjgnYRYCfgB8odxjQ6I9WJEqd
         gl1imEOMP7nP7BXiZfjL1XIfkULodH1IU3tjO09yfudF3Cl3aHw22EmUwwFrnXlSB+Qg
         qNpQ9BplkgnbSoo/YP62ZaL753sq3rlo2zgvTudymDnZTK5HrvULxLlzTpSjhodecju6
         qyQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702685877; x=1703290677;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=arlg1YXcHM8i0YCMKhN2VPucJk96xE9TSorG5ozqY0w=;
        b=WxdWpf5f9XZ2s0R6UfRHCelgzFIg/spQ8KgyIXN/6AU6i4PwCnxeM+E4ATlHyjmYNm
         Q3f2YPu3m34NrDFpX/P0rS9/6jngd2oCxBCuXB8vAq0P+DO9/f/lhrNGqH3ZeB69EFF9
         9sAeMG1by/5kZUzM8W3PTje4fj3rJDczwB9XwKU1JQxxiG/XGjsy4NilQKwsb50o7pYB
         4O/O7FARJYtFDb75E0WYAgvfNZtprZqi7TViinp+3O5hCwCjlssnbvNg4Mo5eMx7JGih
         VlAth9pyCn1CsjKP2V4DBcbVcdc5oe6T3aMfIPaX82+qTvgYfiMTUTSDxXiBhyy7GXHK
         3+gA==
X-Gm-Message-State: AOJu0Yxzo4k3H+ntIO23kTtgFlYgrKSTMCyu/c75jBJxOQhOPTxjZ+I3
	Wl31VZdTIjNZjBKoibIkgoqibc+me2I=
X-Google-Smtp-Source: AGHT+IHKy674ZILkp6H5Vj33/9bMKBqwD5yv4RkEDkfO6DW2WyydELW0Uzvl25IM0CjVNQ2ULeIVSQ==
X-Received: by 2002:a05:6a00:1148:b0:6cd:fcef:5d94 with SMTP id b8-20020a056a00114800b006cdfcef5d94mr13769217pfm.16.1702685877459;
        Fri, 15 Dec 2023 16:17:57 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id ei39-20020a056a0080e700b006cbef269712sm14176124pfb.9.2023.12.15.16.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 16:17:57 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v4 5/5] gpiolib: cdev: improve documentation of get/set values
Date: Sat, 16 Dec 2023 08:16:52 +0800
Message-Id: <20231216001652.56276-6-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231216001652.56276-1-warthog618@gmail.com>
References: <20231216001652.56276-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add documentation of the algorithm used to perform scatter/gather
of the requested lines and values in linereq_get_values() and
linereq_set_values_unlocked() to improve maintainability.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 68fa9714e643..d4953787f361 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1385,9 +1385,18 @@ static long linereq_get_values(struct linereq *lr, void __user *ip)
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
@@ -1396,6 +1405,7 @@ static long linereq_get_values(struct linereq *lr, void __user *ip)
 		return -EINVAL;
 
 	if (num_get != 1) {
+		/* build compacted desc array */
 		descs = kmalloc_array(num_get, sizeof(*descs), GFP_KERNEL);
 		if (!descs)
 			return -ENOMEM;
@@ -1416,6 +1426,7 @@ static long linereq_get_values(struct linereq *lr, void __user *ip)
 
 	lv.bits = 0;
 	for (didx = 0, i = 0; i < lr->num_lines; i++) {
+		/* unpack compacted vals for the response */
 		if (lv.mask & BIT_ULL(i)) {
 			if (lr->lines[i].sw_debounced)
 				val = debounced_value(&lr->lines[i]);
@@ -1441,14 +1452,25 @@ static long linereq_set_values_unlocked(struct linereq *lr,
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
@@ -1456,7 +1478,7 @@ static long linereq_set_values_unlocked(struct linereq *lr,
 		return -EINVAL;
 
 	if (num_set != 1) {
-		/* build compacted desc array and values */
+		/* build compacted desc array */
 		descs = kmalloc_array(num_set, sizeof(*descs), GFP_KERNEL);
 		if (!descs)
 			return -ENOMEM;
-- 
2.39.2


