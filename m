Return-Path: <linux-kernel+bounces-6269-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C4A6B81968F
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9C321C2565B
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:52:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEEC8486;
	Wed, 20 Dec 2023 01:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DPeofTou"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AF7911C90;
	Wed, 20 Dec 2023 01:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6db8ae7a0aeso2293634a34.1;
        Tue, 19 Dec 2023 17:51:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703037115; x=1703641915; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nwJrFBOYeQiMptBpaCTPsCwKHHrwP/LYHeLVCN1wLbM=;
        b=DPeofTouxy0yaKZd3CIK5CGPUjxkqmpwlOfF1FDAlOCUXOqdrGh1PP1L6L1vwMt/8m
         YHqDi+HJE7G1JdaJzPS+3NofYBzFFAIVAwp1dp29CvPXJnCnKCrxeCjCn00KI5BfgeNp
         emPTy246D131AaqFBSowF3/Y50MJqY3RzPZgyviNOm4otZguNOJ1WhbyZaki6ULEAPha
         MAoJuw0rdzgc6N/CRK5p+v9l9dz0eGbHKpISyJZAw6OoiBhzsPvpmvZUlF2GjH2ze90K
         nWMEXfBcKT0ljn+SX8UsBcEIdkhLbKosuaizp8ByRgKG8EugYwygLHeo5zj1i98FIuYv
         MqWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703037115; x=1703641915;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nwJrFBOYeQiMptBpaCTPsCwKHHrwP/LYHeLVCN1wLbM=;
        b=RbZebJ0mA5BO2zixE3TKGxCGDeENaSnjNTTidNDMTcBxH1lWlijQlgIGQrC+pzfurt
         rQE+I+Y4I25u2thACRv8M99kP+vLkNQNDLEGtomQ7dTMlcbzb8PSiIRAHt59PiZfT2zG
         VPyQAPHpcjbzvdbbR4F05lh9FCioi2UMKMRpKJ6WhdZxJP65pWau+NPXIzji8xZV14dz
         P4575ajJMUNeexJnQ4s15agpf48sRpiqvWUIEspfn0hfAjqMu77JVLydsDFNrzAcmClp
         6wZznJwR5Ks6RqLVlTA2rHPfze/k8PT2izYKkYn7nFdvVEzJCFX4Y4dss5Qqk75tvZhC
         sOww==
X-Gm-Message-State: AOJu0YwVNwWvqJ3xRk2FZVuVYX94EjVM2ooSUHeedOBZgmGrupE/iui1
	VNvmyoHK5BStJRogjeVbR5//N76EVsg=
X-Google-Smtp-Source: AGHT+IFMIvq/TdjudUn/106VYIaXqgphbuiBHLrqvHsZr1/F3ztwWWNebCtqlqktRz+vq/NvupIH3w==
X-Received: by 2002:a05:6808:1984:b0:3bb:6984:f445 with SMTP id bj4-20020a056808198400b003bb6984f445mr1486236oib.34.1703037115430;
        Tue, 19 Dec 2023 17:51:55 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id c17-20020a631c51000000b005b92e60cf57sm20133208pgm.56.2023.12.19.17.51.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 17:51:55 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 3/4] gpiolib: cdev: replace locking wrappers for config_mutex with guards
Date: Wed, 20 Dec 2023 09:51:05 +0800
Message-Id: <20231220015106.16732-4-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231220015106.16732-1-warthog618@gmail.com>
References: <20231220015106.16732-1-warthog618@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After the adoption of guard(), the locking wrappers that hold the
config_mutex for linereq_set_values() and linereq_set_config() no
longer add value, so combine them into the functions they wrap.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 63 ++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 39 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 6fec793f5513..5b07578e3bfa 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1454,14 +1454,19 @@ static long linereq_get_values(struct linereq *lr, void __user *ip)
 	return 0;
 }
 
-static long linereq_set_values_unlocked(struct linereq *lr,
-					struct gpio_v2_line_values *lv)
+static long linereq_set_values(struct linereq *lr, void __user *ip)
 {
 	DECLARE_BITMAP(vals, GPIO_V2_LINES_MAX);
+	struct gpio_v2_line_values lv;
 	struct gpio_desc **descs;
 	unsigned int i, didx, num_set;
 	int ret;
 
+	if (copy_from_user(&lv, ip, sizeof(lv)))
+		return -EFAULT;
+
+	guard(mutex)(&lr->config_mutex);
+
 	/*
 	 * gpiod_set_array_value_complex() requires compacted desc and val
 	 * arrays, rather than the sparse ones in lv.
@@ -1472,12 +1477,12 @@ static long linereq_set_values_unlocked(struct linereq *lr,
 	bitmap_zero(vals, GPIO_V2_LINES_MAX);
 	/* scan requested lines to determine the subset to be set */
 	for (num_set = 0, i = 0; i < lr->num_lines; i++) {
-		if (lv->mask & BIT_ULL(i)) {
+		if (lv.mask & BIT_ULL(i)) {
 			/* setting inputs is not allowed */
 			if (!test_bit(FLAG_IS_OUT, &lr->lines[i].desc->flags))
 				return -EPERM;
 			/* add to compacted values */
-			if (lv->bits & BIT_ULL(i))
+			if (lv.bits & BIT_ULL(i))
 				__set_bit(num_set, vals);
 			num_set++;
 			/* capture desc for the num_set == 1 case */
@@ -1493,7 +1498,7 @@ static long linereq_set_values_unlocked(struct linereq *lr,
 		if (!descs)
 			return -ENOMEM;
 		for (didx = 0, i = 0; i < lr->num_lines; i++) {
-			if (lv->mask & BIT_ULL(i)) {
+			if (lv.mask & BIT_ULL(i)) {
 				descs[didx] = lr->lines[i].desc;
 				didx++;
 			}
@@ -1507,31 +1512,28 @@ static long linereq_set_values_unlocked(struct linereq *lr,
 	return ret;
 }
 
-static long linereq_set_values(struct linereq *lr, void __user *ip)
-{
-	struct gpio_v2_line_values lv;
-
-	if (copy_from_user(&lv, ip, sizeof(lv)))
-		return -EFAULT;
-
-	guard(mutex)(&lr->config_mutex);
-
-	return linereq_set_values_unlocked(lr, &lv);
-}
-
-static long linereq_set_config_unlocked(struct linereq *lr,
-					struct gpio_v2_line_config *lc)
+static long linereq_set_config(struct linereq *lr, void __user *ip)
 {
+	struct gpio_v2_line_config lc;
 	struct gpio_desc *desc;
 	struct line *line;
 	unsigned int i;
 	u64 flags, edflags;
 	int ret;
 
+	if (copy_from_user(&lc, ip, sizeof(lc)))
+		return -EFAULT;
+
+	ret = gpio_v2_line_config_validate(&lc, lr->num_lines);
+	if (ret)
+		return ret;
+
+	guard(mutex)(&lr->config_mutex);
+
 	for (i = 0; i < lr->num_lines; i++) {
 		line = &lr->lines[i];
 		desc = lr->lines[i].desc;
-		flags = gpio_v2_line_config_flags(lc, i);
+		flags = gpio_v2_line_config_flags(&lc, i);
 		gpio_v2_line_config_flags_to_desc_flags(flags, &desc->flags);
 		edflags = flags & GPIO_V2_LINE_EDGE_DETECTOR_FLAGS;
 		/*
@@ -1539,7 +1541,7 @@ static long linereq_set_config_unlocked(struct linereq *lr,
 		 * or output, else the line will be treated "as is".
 		 */
 		if (flags & GPIO_V2_LINE_FLAG_OUTPUT) {
-			int val = gpio_v2_line_config_output_value(lc, i);
+			int val = gpio_v2_line_config_output_value(&lc, i);
 
 			edge_detector_stop(line);
 			ret = gpiod_direction_output(desc, val);
@@ -1550,7 +1552,7 @@ static long linereq_set_config_unlocked(struct linereq *lr,
 			if (ret)
 				return ret;
 
-			ret = edge_detector_update(line, lc, i, edflags);
+			ret = edge_detector_update(line, &lc, i, edflags);
 			if (ret)
 				return ret;
 		}
@@ -1562,23 +1564,6 @@ static long linereq_set_config_unlocked(struct linereq *lr,
 	return 0;
 }
 
-static long linereq_set_config(struct linereq *lr, void __user *ip)
-{
-	struct gpio_v2_line_config lc;
-	int ret;
-
-	if (copy_from_user(&lc, ip, sizeof(lc)))
-		return -EFAULT;
-
-	ret = gpio_v2_line_config_validate(&lc, lr->num_lines);
-	if (ret)
-		return ret;
-
-	guard(mutex)(&lr->config_mutex);
-
-	return linereq_set_config_unlocked(lr, &lc);
-}
-
 static long linereq_ioctl_unlocked(struct file *file, unsigned int cmd,
 				   unsigned long arg)
 {
-- 
2.39.2


