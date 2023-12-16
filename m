Return-Path: <linux-kernel+bounces-1862-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 060208154EA
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:18:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id ECA381C243C6
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32A3864B;
	Sat, 16 Dec 2023 00:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HJookHIp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EFE7E;
	Sat, 16 Dec 2023 00:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6d9e756cf32so1021686a34.2;
        Fri, 15 Dec 2023 16:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702685856; x=1703290656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mKZEEfrVGHEaINRgT5nXSBcR8L7v728av3t9LqLhAJc=;
        b=HJookHIpxHJe8Hli+S3jDbiegenzYpZChTNYpn2aSP4A/XQ4GA3IDxt29FabCy8HdX
         HF5orFOo4Aq8Ob18BbgkA48woMWb9vriTr4DQibdqDctRx4xJXVIhLlDvBd0UJo3j0Zh
         RADbgP6JouQmKjZVaXUwBNurySYwj5Zs+Ik5jDYmeSp1V267BcBn+TBGcUAdxjL5BrCn
         wDUdzLoVBdRD12f8D2WrKlsOHF245sUbvp78QnKtWp8z22vUB1b0ydLztULcK2Uagtcs
         qcPy1W4Amc9epgUX1F07a0iIQWEEluTp7uj96DTkojTTWDvYmYufhjVNLVchV7PhIreh
         BLaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702685856; x=1703290656;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mKZEEfrVGHEaINRgT5nXSBcR8L7v728av3t9LqLhAJc=;
        b=cjFCNPhpRQd9xaV/yr0+DjBR6xZuKihHo+hYWkE5I28RVQd+9sNqFJups9LyAU+yMW
         q7LuBZOjo17nrDsIrAr6h7/l60usXXbVlU8vGWs8wjpx02vf8Uuy1XMrIUlDhgNwxBDa
         5gz0vin9vfn1OrTNRE83Ld27QLYEJHuWsPfKdpSv/IUXSCylIcSuV4vbLOLyDaNJwW8p
         kHDWx3IrYYeUKkEvUHi98V7odVZUsVrsJUouxxArCbAATGlnb7KWiymswM6NrhyAhUzt
         dU1BZctsRehbPinwMJHk+fyOGCOOTbM7tU/UetefN9UtFifgUA/K800+vCZ/6l5D7SD6
         h+Yg==
X-Gm-Message-State: AOJu0Yyo7maq4oyuF/31WpFvFjwgJp+Thnj2UqMAapDsKdrRMY/5fU1+
	5LljpuLl0BpOjjEUhA3o7zeophGs3Lg=
X-Google-Smtp-Source: AGHT+IE9S/f4JdRtSHw6xSuIiPfAao3z+M4Uof0IpR7Rhx/YfeC91InXjnWqkSkMVvCNGHcMgLeeIw==
X-Received: by 2002:a05:6830:33d3:b0:6d9:e0c8:3e04 with SMTP id q19-20020a05683033d300b006d9e0c83e04mr11316425ott.11.1702685855984;
        Fri, 15 Dec 2023 16:17:35 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id ei39-20020a056a0080e700b006cbef269712sm14176124pfb.9.2023.12.15.16.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 16:17:35 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v4 3/5] gpiolib: cdev: reduce locking in gpio_desc_to_lineinfo()
Date: Sat, 16 Dec 2023 08:16:50 +0800
Message-Id: <20231216001652.56276-4-warthog618@gmail.com>
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

Reduce the time holding the gpio_lock by snapshotting the desc flags,
rather than testing them individually while holding the lock.

Accept that the calculation of the used field is inherently racy, and
only check the availability of the line from pinctrl if other checks
pass, so avoiding the check for lines that are otherwise in use.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 74 ++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 47197f6339c4..8c174dda622d 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2390,74 +2390,72 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 				  struct gpio_v2_line_info *info)
 {
 	struct gpio_chip *gc = desc->gdev->chip;
-	bool ok_for_pinctrl;
-	unsigned long flags;
+	unsigned long dflags;
 
 	memset(info, 0, sizeof(*info));
 	info->offset = gpio_chip_hwgpio(desc);
 
-	/*
-	 * This function takes a mutex so we must check this before taking
-	 * the spinlock.
-	 *
-	 * FIXME: find a non-racy way to retrieve this information. Maybe a
-	 * lock common to both frameworks?
-	 */
-	ok_for_pinctrl = pinctrl_gpio_can_use_line(gc, info->offset);
+	scoped_guard(spinlock_irqsave, &gpio_lock) {
+		if (desc->name)
+			strscpy(info->name, desc->name, sizeof(info->name));
 
-	spin_lock_irqsave(&gpio_lock, flags);
+		if (desc->label)
+			strscpy(info->consumer, desc->label,
+				sizeof(info->consumer));
 
-	if (desc->name)
-		strscpy(info->name, desc->name, sizeof(info->name));
-
-	if (desc->label)
-		strscpy(info->consumer, desc->label, sizeof(info->consumer));
+		dflags = READ_ONCE(desc->flags);
+	}
 
 	/*
-	 * Userspace only need to know that the kernel is using this GPIO so
-	 * it can't use it.
+	 * Userspace only need know that the kernel is using this GPIO so it
+	 * can't use it.
+	 * The calculation of the used flag is slightly racy, as it may read
+	 * desc, gc and pinctrl state without a lock covering all three at
+	 * once.  Worst case if the line is in transition and the calculation
+	 * is inconsistent then it looks to the user like they performed the
+	 * read on the other side of the transition - but that can always
+	 * happen.
+	 * The definitive test that a line is available to userspace is to
+	 * request it.
 	 */
-	info->flags = 0;
-	if (test_bit(FLAG_REQUESTED, &desc->flags) ||
-	    test_bit(FLAG_IS_HOGGED, &desc->flags) ||
-	    test_bit(FLAG_USED_AS_IRQ, &desc->flags) ||
-	    test_bit(FLAG_EXPORT, &desc->flags) ||
-	    test_bit(FLAG_SYSFS, &desc->flags) ||
+	if (test_bit(FLAG_REQUESTED, &dflags) ||
+	    test_bit(FLAG_IS_HOGGED, &dflags) ||
+	    test_bit(FLAG_USED_AS_IRQ, &dflags) ||
+	    test_bit(FLAG_EXPORT, &dflags) ||
+	    test_bit(FLAG_SYSFS, &dflags) ||
 	    !gpiochip_line_is_valid(gc, info->offset) ||
-	    !ok_for_pinctrl)
+	    !pinctrl_gpio_can_use_line(gc, info->offset))
 		info->flags |= GPIO_V2_LINE_FLAG_USED;
 
-	if (test_bit(FLAG_IS_OUT, &desc->flags))
+	if (test_bit(FLAG_IS_OUT, &dflags))
 		info->flags |= GPIO_V2_LINE_FLAG_OUTPUT;
 	else
 		info->flags |= GPIO_V2_LINE_FLAG_INPUT;
 
-	if (test_bit(FLAG_ACTIVE_LOW, &desc->flags))
+	if (test_bit(FLAG_ACTIVE_LOW, &dflags))
 		info->flags |= GPIO_V2_LINE_FLAG_ACTIVE_LOW;
 
-	if (test_bit(FLAG_OPEN_DRAIN, &desc->flags))
+	if (test_bit(FLAG_OPEN_DRAIN, &dflags))
 		info->flags |= GPIO_V2_LINE_FLAG_OPEN_DRAIN;
-	if (test_bit(FLAG_OPEN_SOURCE, &desc->flags))
+	if (test_bit(FLAG_OPEN_SOURCE, &dflags))
 		info->flags |= GPIO_V2_LINE_FLAG_OPEN_SOURCE;
 
-	if (test_bit(FLAG_BIAS_DISABLE, &desc->flags))
+	if (test_bit(FLAG_BIAS_DISABLE, &dflags))
 		info->flags |= GPIO_V2_LINE_FLAG_BIAS_DISABLED;
-	if (test_bit(FLAG_PULL_DOWN, &desc->flags))
+	if (test_bit(FLAG_PULL_DOWN, &dflags))
 		info->flags |= GPIO_V2_LINE_FLAG_BIAS_PULL_DOWN;
-	if (test_bit(FLAG_PULL_UP, &desc->flags))
+	if (test_bit(FLAG_PULL_UP, &dflags))
 		info->flags |= GPIO_V2_LINE_FLAG_BIAS_PULL_UP;
 
-	if (test_bit(FLAG_EDGE_RISING, &desc->flags))
+	if (test_bit(FLAG_EDGE_RISING, &dflags))
 		info->flags |= GPIO_V2_LINE_FLAG_EDGE_RISING;
-	if (test_bit(FLAG_EDGE_FALLING, &desc->flags))
+	if (test_bit(FLAG_EDGE_FALLING, &dflags))
 		info->flags |= GPIO_V2_LINE_FLAG_EDGE_FALLING;
 
-	if (test_bit(FLAG_EVENT_CLOCK_REALTIME, &desc->flags))
+	if (test_bit(FLAG_EVENT_CLOCK_REALTIME, &dflags))
 		info->flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME;
-	else if (test_bit(FLAG_EVENT_CLOCK_HTE, &desc->flags))
+	else if (test_bit(FLAG_EVENT_CLOCK_HTE, &dflags))
 		info->flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE;
-
-	spin_unlock_irqrestore(&gpio_lock, flags);
 }
 
 struct gpio_chardev_data {
-- 
2.39.2


