Return-Path: <linux-kernel+bounces-4533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F873817EEB
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:43:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EB79FB23BC5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:43:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D73A23A2;
	Tue, 19 Dec 2023 00:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zg4vVFby"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C687FB;
	Tue, 19 Dec 2023 00:42:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-28b436f6cb9so2797660a91.3;
        Mon, 18 Dec 2023 16:42:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702946570; x=1703551370; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gxWO2hbVv9alsWKTdmxcyrDlMx14qIvG0C1ZL2goQvw=;
        b=Zg4vVFby+fww05lAbD1kBX2lPsNah5FdKOnuWZacdKH9QM5j7PDNVzYIK1up6q2APh
         CmaaEgudaXsLfrvIn74FxinGwwqzVJrBVhFi5gpcWUZFpoMZE+HXk/4JPlzZWQyd4N5R
         KKOEiVs70TN6hehdG8f/C4PyfGC8J4DvQD77N20R7xcveD5CFKIsP0bxCP4EEJJ+F4JO
         hqdCfVXf8fqq5PaZqvCmY8F9J72tmZbsQguaFoz8pTU0kKG3DqW7ZWt1eUmm1DeOBK54
         O1WHjrhfp/NayinIUuNXaDbJIDHijfa5gJpNP+NBSuDpnGORgOuc6VqTY4kh8O/MuBgr
         Dwtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702946570; x=1703551370;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gxWO2hbVv9alsWKTdmxcyrDlMx14qIvG0C1ZL2goQvw=;
        b=kwNzGT6yw4AqrjROWkBtOSG05uR7KX31+EMKBdZUzyhXqEga+ATE8+2DSxiLkxWQcY
         P+1OFdWCAxMrYcijGALnDurjYwriaxuoLBA4bxWmTU853Ll5JsKS2AGe9HBu9RArAqk+
         jG4vIiCqlRzcQq82n09i48U+xKW9FkdbMNIZCFoV1ZrzJwioHVtJXDIDq0JX/SPrBPzm
         B0P7ufA3P1pq0+p40xdiq/CAMDqp33oD9B4kx2nxiGXY0b5JshjjwkpxKFyOVgLtlU9a
         A/TvXfxwtaf7p+hGr38DZgRvKb5mjYYxIqjdmz/EWZBXDaU0I5ukZWEfEVWa7r+bFK0/
         9kQA==
X-Gm-Message-State: AOJu0Ywazem37sLM5mnmmFkoKY+d+AuYUBj5vXFQHfbNpem10l73EmIP
	toi8C95ywLdjE7pIs+zOapNOWpr+Uwo=
X-Google-Smtp-Source: AGHT+IH1WR8+4IFRabMi3k+2hybUb9z0e/NA9nIUPaMYSUwkvzEPmgTyh6RG4odpbXzyZAnrRl02Nw==
X-Received: by 2002:a17:90a:6c03:b0:28b:5a88:45d9 with SMTP id x3-20020a17090a6c0300b0028b5a8845d9mr2088997pjj.9.1702946570211;
        Mon, 18 Dec 2023 16:42:50 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a3f0900b0028ae3b5dde9sm173484pjc.12.2023.12.18.16.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:42:49 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v5 3/5] gpiolib: cdev: reduce locking in gpio_desc_to_lineinfo()
Date: Tue, 19 Dec 2023 08:41:56 +0800
Message-Id: <20231219004158.12405-4-warthog618@gmail.com>
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
index aecc4241b6c8..9f5104d7532f 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2399,74 +2399,72 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
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


