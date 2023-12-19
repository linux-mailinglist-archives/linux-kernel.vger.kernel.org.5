Return-Path: <linux-kernel+bounces-4535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7F55817EEF
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:44:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3B11C28327B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 575567FB;
	Tue, 19 Dec 2023 00:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CGkwgZf/"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F4848465;
	Tue, 19 Dec 2023 00:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-1d3ce28ace2so8423215ad.3;
        Mon, 18 Dec 2023 16:43:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702946588; x=1703551388; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fRDFFJ6x6asfslgb8GBnfyuPvTBkPeET/1jjHxtjNho=;
        b=CGkwgZf/+mbDTLYrufcbOkQany8clPK55qxjJoYLlzjBQ1a2FPGLpNVqzEfmsRD+7f
         VfCMgyEmfmmvshyebyAUL00aJN3K5wmHUqtgQPGqaOAmL8aWk96EV3mWnQO+8paNsrG9
         JnZOD1oE7aZp7QMJNF6KB3ndk2GoHD7ub+dmphDjzr9OyL9MLV7lSlzFwTbqm4I4gbUo
         esenQNYZqfwc/9BSJ2Sl3f3O7TCiLGZReZYBu9RC+gIHP2+tyY1dYryz9BlCRGqJY5wG
         WyIpUUF3js83efH1J6FrKypbcC27m/UbQpbmTlHYtuxcMaAJnvch5mcJ06hAPbt5OTpU
         7YOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702946588; x=1703551388;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fRDFFJ6x6asfslgb8GBnfyuPvTBkPeET/1jjHxtjNho=;
        b=fsyrKI248u37T1/Hs/xGhEyScxT5BZ3xDv4JnU5FamHAsvNNtb59kGhB1i/NjHpf68
         fMFaBem9QpGhYRz8rD4twenGtDQYXwpWglJup4v++wnZeRDrCdHwI++r+41kI2p3RkXO
         qhA35K6RVbudl6mZGdhMxlfcoW9SqvyRDFv8oc3TyRAp3wEY3S6X+bQTogMl2P3TGe0X
         m8Hq1Q1qP++JRQ4Zw8Djo6KQ/mkRGDGb6bGREsPN7fx2NuS/rxJJs/sI4E77aPNSfmqB
         E92+B5LSHhBs7TarwVJdc59jdZEjTF2USJ4RFytuS5GLp7VuTgiJJT2W8AmwrCXThfPv
         M9Zg==
X-Gm-Message-State: AOJu0YwemxrjtM+8RnJ26tG4OgqXCYhneVMGmtx4wfmCYaW3EsuoJt1L
	9MAFSEW3zWSlNMIqZYFtSgf1MTBIy88=
X-Google-Smtp-Source: AGHT+IEbRFwGnUezwGGXTfgu2s0VBUhDwHVBBKqPFSB3V3dCWJkPc9G2C3+2Zn+pFQice2W8e27apQ==
X-Received: by 2002:a17:903:11c5:b0:1d0:6ffd:9e21 with SMTP id q5-20020a17090311c500b001d06ffd9e21mr19661225plh.115.1702946588524;
        Mon, 18 Dec 2023 16:43:08 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a3f0900b0028ae3b5dde9sm173484pjc.12.2023.12.18.16.43.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:43:08 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v5 5/5] gpiolib: cdev: improve documentation of get/set values
Date: Tue, 19 Dec 2023 08:41:58 +0800
Message-Id: <20231219004158.12405-6-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231219004158.12405-1-warthog618@gmail.com>
References: <20231219004158.12405-1-warthog618@gmail.com>
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
index 307d629a8889..744734405912 100644
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


