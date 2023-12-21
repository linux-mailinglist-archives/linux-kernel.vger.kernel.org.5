Return-Path: <linux-kernel+bounces-7722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0930E81AC1F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:22:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B6F30287BF8
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003D9184C;
	Thu, 21 Dec 2023 01:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N07OHKQE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDC2D441E;
	Thu, 21 Dec 2023 01:21:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5cd86e3a9afso193163a12.1;
        Wed, 20 Dec 2023 17:21:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703121718; x=1703726518; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yEnEXmwh1Gejk6pPQlc8WucbY92GrZLw8XwSVMxV33c=;
        b=N07OHKQEe61SbHlssDrW4vxmLV2ZY84Ek83lmNtSQpSMkCkNhm3kGU8Ao0M/+ZkMFz
         tp85b1kgcnMnoQsntmr97PhhA6Fdgw4qCy6qW5gLkl4MpqF0HsbQtAg+zU6TS9B1D0D8
         SH/dFD6ghJklPVMc4UPn/7n5Ra1sZW1MBu8r0U1EY2obysjHGRlIZq2iVyui/kY3DzAA
         zl2pP2NGEeJbPVv6cAbC+1pxZ7cAAc0I+7Y8gGTSCoKnCWhe2KgJq7rO9S0AfIg10gpI
         B7pEkYwyFIc6QcjploHcTKf2qv9yAFVOuLFnT7dSy3ehj+wKvduiwAfsCrp/c7HcqEI2
         aeBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703121718; x=1703726518;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEnEXmwh1Gejk6pPQlc8WucbY92GrZLw8XwSVMxV33c=;
        b=NsxbN0FF0V1JH3AQDe1XmbAxWQUexph8rBdgVPV5mCh29nX5Ve/ad0636qn92LuKwa
         0bZT1BVrtyeX5zDM2dBayitjzrU2NxJs/8Nw5SEwlnpDUpCiadD+gAFJsx6fRIw95CFD
         +a/J4ZfKKv6worN24n+Bor5x51TOim/bIkUOGJ9vgEjlYcUgrBNkVkJ+n78pqs3FsUfn
         qeaViLhEFlYz41JJjsy9+A5Ei/vCRKhBeXS6K4JP6uQe8/jHS5u0Be1dpkEWF8NRBXFc
         6jdaq0xMJARmBZ+9nh74tPmuoKYeo/xvMy1FJaNxzeL0H/9NC+UJ1UaINxikMKCY8N6F
         nqKA==
X-Gm-Message-State: AOJu0YwPHdcr40lLmPrgxJq1NhSS5AORhLRZezTNduUlgwlaiFncH1xK
	OSQwCg4JGYTkqp2WJ1dhrOnzX1M0DQw=
X-Google-Smtp-Source: AGHT+IFfTfkGLm95NUUWpKuP+zmUZsVpGtLx41MHnx183BKcRu25hozCR1/YFyspLeDvSuncst2u0A==
X-Received: by 2002:a05:6a21:99a0:b0:195:f2:1fb3 with SMTP id ve32-20020a056a2199a000b0019500f21fb3mr370653pzb.42.1703121717904;
        Wed, 20 Dec 2023 17:21:57 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id x1-20020a056a00270100b006d088356541sm375959pfv.104.2023.12.20.17.21.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 17:21:57 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 4/5] gpiolib: cdev: replace locking wrappers for config_mutex with guards
Date: Thu, 21 Dec 2023 09:20:39 +0800
Message-Id: <20231221012040.17763-5-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231221012040.17763-1-warthog618@gmail.com>
References: <20231221012040.17763-1-warthog618@gmail.com>
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
index 5424c878627e..9ff2b447cc20 100644
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


