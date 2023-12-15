Return-Path: <linux-kernel+bounces-369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B5981401C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:44:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB804287DD7
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8304DDD3;
	Fri, 15 Dec 2023 02:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YKJomVo0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B64EBC;
	Fri, 15 Dec 2023 02:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-5c66988c2eeso104494a12.1;
        Thu, 14 Dec 2023 18:39:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702607989; x=1703212789; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cJew1Ut9h95zC9IuFrB6MxorQq1lAg1fBre3mDpboVk=;
        b=YKJomVo0MbYyn+/pvpivd+zDy4KFTQ4wbSymKOjd2VcG4uYVYVMEnsuIxgniKWF7FH
         vMwKBRPnhClh69dqHGrR2L/qTcNBRTDSzLhpNQCDAZ1aZ5oNWwroqr8cDotC7X839Kdr
         54AIqQBIlvJYoHLTVsl5STp2AR5nIbuY1XElP5Qu6vRE7LrY0UmDhMgV4s2ojYSrpO6R
         fw1rxGYS8unlPZKZsjuqsDtb9UEEz30yo6c9SA7UR2v5Out1bD6p/FbWpK78Xiur/BUP
         VZsBdVFnWTuDcGg+oYsbo+avedFBbA6YWNY0n1xHHxhKWlC73/SY8eeNdCDSKdvgzczY
         rR/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607989; x=1703212789;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cJew1Ut9h95zC9IuFrB6MxorQq1lAg1fBre3mDpboVk=;
        b=oJ+VU1Ru2Ow1SadVwrjXl8hvq7m/elIJHji84y2HNhHUHCpaq9Ojg/J6WYcgWMlpJW
         bWwRS2bPQ3ncZ2vpdnvsJ6CTmjL5501XNOHbF/R0YWDiukqqbCaVhAHAWeIS5PnRjr3z
         jhg27ZxGPNS9qyyBiAk5NkH1LI10ZeabuxRp372iHMnhjxoxeQwLIAgzBeDYpSAmCKnR
         tNo9KJxTP1yX3Nd9xuq7fdsOxP6iJSho5z+Dh6HRWSVQ5ZnGHUMVQ3UTVm7Y7I1XVFZ8
         eG/3IYM7G+LWGSxK4uMoLqpVMjETihjJrQfELH4x2ILfHdXW6Jvj6VQeHlxxh9aMqNW0
         EyLQ==
X-Gm-Message-State: AOJu0Yz8YBlda+4NExuet3IwxIO/Qopnw3451IRkNd85Q3OJCp4ZVR/5
	Ef8ag54aH7RT9RxKw5U1Phl1KvfA1tw=
X-Google-Smtp-Source: AGHT+IHfWb3wL97Ns3I3ixu/6Q6yRWaGN1PcI1hxQgrd8A1/ldvCSZ4yZZYksRY9zq0Ge9ImqnhR2Q==
X-Received: by 2002:a05:6a21:998e:b0:190:24f9:d579 with SMTP id ve14-20020a056a21998e00b0019024f9d579mr15682414pzb.1.1702607988870;
        Thu, 14 Dec 2023 18:39:48 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id fk16-20020a056a003a9000b006d26920a11dsm1437987pfb.0.2023.12.14.18.39.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:39:48 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v3 5/5] gpiolib: cdev: improve documentation of get/set values
Date: Fri, 15 Dec 2023 10:38:05 +0800
Message-Id: <20231215023805.63289-6-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231215023805.63289-1-warthog618@gmail.com>
References: <20231215023805.63289-1-warthog618@gmail.com>
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
---
 drivers/gpio/gpiolib-cdev.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index b956664f8649..37794de691f3 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -1383,9 +1383,18 @@ static long linereq_get_values(struct linereq *lr, void __user *ip)
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
@@ -1394,6 +1403,7 @@ static long linereq_get_values(struct linereq *lr, void __user *ip)
 		return -EINVAL;
 
 	if (num_get != 1) {
+		/* build compacted desc array */
 		descs = kmalloc_array(num_get, sizeof(*descs), GFP_KERNEL);
 		if (!descs)
 			return -ENOMEM;
@@ -1414,6 +1424,7 @@ static long linereq_get_values(struct linereq *lr, void __user *ip)
 
 	lv.bits = 0;
 	for (didx = 0, i = 0; i < lr->num_lines; i++) {
+		/* unpack compacted vals for the response */
 		if (lv.mask & BIT_ULL(i)) {
 			if (lr->lines[i].sw_debounced)
 				val = debounced_value(&lr->lines[i]);
@@ -1439,14 +1450,25 @@ static long linereq_set_values_unlocked(struct linereq *lr,
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
@@ -1454,7 +1476,7 @@ static long linereq_set_values_unlocked(struct linereq *lr,
 		return -EINVAL;
 
 	if (num_set != 1) {
-		/* build compacted desc array and values */
+		/* build compacted desc array */
 		descs = kmalloc_array(num_set, sizeof(*descs), GFP_KERNEL);
 		if (!descs)
 			return -ENOMEM;
-- 
2.39.2


