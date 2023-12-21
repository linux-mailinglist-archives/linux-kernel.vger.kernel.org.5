Return-Path: <linux-kernel+bounces-7719-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A85EF81AC19
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:21:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CDA4D1C23297
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:21:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11F6B1843;
	Thu, 21 Dec 2023 01:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsAZ+dax"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142A63C1E;
	Thu, 21 Dec 2023 01:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-6d741fb7c8eso295543b3a.2;
        Wed, 20 Dec 2023 17:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703121673; x=1703726473; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dLcenJ/GoxU7aCIQv2oBr9pxlEYNKaNvVPdm4SRt55Y=;
        b=GsAZ+daxbBZTZMEMcH66YqMkzeelDrlYtZ0dd0+jcDh+X5cuXMzvb8oypy7IyBzrG5
         MJV0O1tML/Snl8EytCfYb2NnyWZI2SWEXjGKhzxGCDIpC78kmuZkZJZ7pebFPx3BzR7N
         EPSzSET7cYNTN5nMDYkChZWyaBWt9ukIosCSTPktXqsEqXgv+Cckizjl34z5KkLYA1ka
         WOrzVaXZwTYZg+bdlSXN8e/vEzwjn2iDe7YsB8ZemWlbOHDrgJafAalkJfBCSq4ChdLd
         H//GKNFRaDMm432hUkzPYSo7EeTyvoJAurOQA9WsdHSOu9POKBANwpK+qKCvQcSIInZE
         QvIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703121673; x=1703726473;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dLcenJ/GoxU7aCIQv2oBr9pxlEYNKaNvVPdm4SRt55Y=;
        b=cl4C2nZA90GuF3ALYlN9ZFPiKUTzw6Yp5dztFp4oQ/iiD0f5G7Bv4GqVlotcFoFlRi
         tYNYbPpUD/UxG4wVH9mVYswg2z3Wd48GYXlC9j28yZ93lFCG2e3cUDF7DNy0Ya6HoFCt
         VyCH83znfbc/3sL5DuEryM1W5IS5Mi4nynopvGraT7GJo/fnVfBtJ8MGeC2kBI0Fai0L
         hMnJ34aPFA3EVNTraDPmj/xagFcWNDGMOP5OPPiOiZWv6nVhXL8uiXiAfticA4qzX3c+
         sccFXz43c6uyPP8l0d3uFV+c9courSO+MFeZU4V30zNPrULBo2gxPVxxGn/oSaoEzgDQ
         TzvQ==
X-Gm-Message-State: AOJu0Yw6n6jdSduVPg/NPr7zu0F2u/+1J5/OBHfjwdntX4LS5sotL5Ed
	Jp6LN7s72CpyujUEhuag672SP+D53kQ=
X-Google-Smtp-Source: AGHT+IEqkmG2Ao53YtUpYcDvMLRUEX90Wrk8sVbrTuf+S00szNsTkGtOh0Nvv1On8JL9lsJri+oJiw==
X-Received: by 2002:a05:6a00:f8e:b0:6d8:cf8e:e627 with SMTP id ct14-20020a056a000f8e00b006d8cf8ee627mr5338333pfb.37.1703121673191;
        Wed, 20 Dec 2023 17:21:13 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id x1-20020a056a00270100b006d088356541sm375959pfv.104.2023.12.20.17.21.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 17:21:12 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 1/5] gpiolib: cdev: add gpio_device locking wrapper around gpio_ioctl()
Date: Thu, 21 Dec 2023 09:20:36 +0800
Message-Id: <20231221012040.17763-2-warthog618@gmail.com>
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

While the GPIO cdev gpio_ioctl() call is in progress, the kernel can
call gpiochip_remove() which will set gdev->chip to NULL, after which
any subsequent access will cause a crash.

gpio_ioctl() was overlooked by the previous fix to protect syscalls
(bdbbae241a04), so add protection for that.

Fixes: bdbbae241a04 ("gpiolib: protect the GPIO device against being dropped while in use by user-space")
Fixes: d7c51b47ac11 ("gpio: userspace ABI for reading/writing GPIO lines")
Fixes: 3c0d9c635ae2 ("gpiolib: cdev: support GPIO_V2_GET_LINE_IOCTL and GPIO_V2_LINE_GET_VALUES_IOCTL")
Fixes: aad955842d1c ("gpiolib: cdev: support GPIO_V2_GET_LINEINFO_IOCTL and GPIO_V2_GET_LINEINFO_WATCH_IOCTL")
Signed-off-by: Kent Gibson <warthog618@gmail.com>
---
 drivers/gpio/gpiolib-cdev.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 744734405912..9155c54acc1e 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2598,10 +2598,7 @@ static int lineinfo_unwatch(struct gpio_chardev_data *cdev, void __user *ip)
 	return 0;
 }
 
-/*
- * gpio_ioctl() - ioctl handler for the GPIO chardev
- */
-static long gpio_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+static long gpio_ioctl_unlocked(struct file *file, unsigned int cmd, unsigned long arg)
 {
 	struct gpio_chardev_data *cdev = file->private_data;
 	struct gpio_device *gdev = cdev->gdev;
@@ -2638,6 +2635,17 @@ static long gpio_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	}
 }
 
+/*
+ * gpio_ioctl() - ioctl handler for the GPIO chardev
+ */
+static long gpio_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
+{
+	struct gpio_chardev_data *cdev = file->private_data;
+
+	return call_ioctl_locked(file, cmd, arg, cdev->gdev,
+				 gpio_ioctl_unlocked);
+}
+
 #ifdef CONFIG_COMPAT
 static long gpio_ioctl_compat(struct file *file, unsigned int cmd,
 			      unsigned long arg)
-- 
2.39.2


