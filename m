Return-Path: <linux-kernel+bounces-367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BAE5814018
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:43:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 80DD2287682
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:43:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12D91C8FF;
	Fri, 15 Dec 2023 02:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ieCk6gG9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f174.google.com (mail-oi1-f174.google.com [209.85.167.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CBC7D271;
	Fri, 15 Dec 2023 02:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f174.google.com with SMTP id 5614622812f47-3b9ef61b6b8so194947b6e.3;
        Thu, 14 Dec 2023 18:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702607964; x=1703212764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CtO2jY+EJP8Yvc8VKZdfYbcqASBoJOxP1iWf7Ww080E=;
        b=ieCk6gG9OZ3zhBPcrphnGM4Zy31QEtol5Znhd8nXoBvILsf7aenHXe2gmoJX8B52Ha
         mlU9bLeeU499mQbATPYQtHDbtX0uyizU5J67KwAvOgOmSIQ4D8JeQLPxgiyDcgNKYHTn
         ichXppg1/BCx7dKJNrLTCsJK1YpEB9k4l3BDQnovo9OCKwlvBQuYeSmLKpLEBzSTNhQb
         y2ZKDbztadPCHk9W+bw5Dd5ivz3+OvfvMkhhOH4Qv8IaX1rhFYWMiqBi1D6JtJdI+58i
         Y/ijsgfqwByBRSBFmXfu8y+4dMqLLAN1SnG1cOf0RWE/NnZtOaA7XmPlu0kRBT8gSaai
         +GfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607964; x=1703212764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CtO2jY+EJP8Yvc8VKZdfYbcqASBoJOxP1iWf7Ww080E=;
        b=UuEnNACyOSfVsBN/oBcFiLz1FXOeZ/MM0J0v0/wIV4o3nqEbGd91ts0UDUF9DCXACa
         C5j/w+TA0oE3RNgPa+HJ1s2qCoJQvXXFPYflOMxrz1tZlmVl3v+Q19THtifap5oLsT5/
         7ETw0+obwpMnFVNNlgNbv/4NUoE+GKFNI4z76GP9f7HBKopwdv62haD8dM2xPdApckiv
         Wm3VgZH7MJOOAM5Bq3FaEO0fCcEXISJ+7yJNX4gzIu64tcwLju4en4oNDxnjajbDa8Hb
         UskjtRVrGMy8V8oPtbdr1dDA3PJGeQ46TV6IZ2MqJUG6HXTUNfwBXeBv2blamMGbCzQx
         4FKA==
X-Gm-Message-State: AOJu0YzndLHzrsSrj1Ew0Okia/OFACXTB8GXV7G4ab1qScDQxtO+M2rr
	O6DBRTst9z5iXMmQ/YjnohfhZq6lf3o=
X-Google-Smtp-Source: AGHT+IGlWzYrWM676OibeACK5orQ7R+AmQhDbYKx4mELUlDz4VX1TgfrhcqgtIS/bYb8y4f2jQUxJw==
X-Received: by 2002:a05:6808:ecb:b0:3b9:d903:9fa9 with SMTP id q11-20020a0568080ecb00b003b9d9039fa9mr13502871oiv.105.1702607964084;
        Thu, 14 Dec 2023 18:39:24 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id fk16-20020a056a003a9000b006d26920a11dsm1437987pfb.0.2023.12.14.18.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:39:23 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v3 3/5] gpiolib: cdev: reduce locking in gpio_desc_to_lineinfo()
Date: Fri, 15 Dec 2023 10:38:03 +0800
Message-Id: <20231215023805.63289-4-warthog618@gmail.com>
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

Reduce the time holding the gpio_lock by snapshotting the desc flags,
rather than testing them individually while holding the lock.

Accept that the calculation of the used field is inherently racy, and
only check the availability of the line from pinctrl if other checks
pass, so avoiding the check for lines that are otherwise in use.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 74 ++++++++++++++++++-------------------
 1 file changed, 36 insertions(+), 38 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 5ba900e5461a..c140bcd63361 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2388,74 +2388,72 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
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


