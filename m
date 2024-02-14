Return-Path: <linux-kernel+bounces-64879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 259E285442F
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 09:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 74FEEB260E8
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 08:45:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 430C712B93;
	Wed, 14 Feb 2024 08:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="tphwpPST"
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D0E79DC
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 08:44:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707900269; cv=none; b=jcFK1hX61y6wfsaD0Y4xmioYlCfB4VvOD0vhcTDsGFH7DrlEo/dxG1txVszLrvnoNwa/EZrQlOV0/lf1Q6pE4SpIWFog6uVXf3RSkHXt2w6IObeR9XIZcDRvc4bCb42rCWsNRIZiTLRdru6Bb0EuQ2QSTUvCAwIPKIdRpCThZj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707900269; c=relaxed/simple;
	bh=p11uFDAy9kr8AJil/h/KV/gIH0eHT2jZGPO4Cr//nBI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=hz7lLNwm/5rTuV997MuwVwIdrR95xlf3w+v3grUwrN9Ds/b7kgyCedkeByTnQnTHmnoYcUpU9i59QYpSFFLkxynwnd01z2l5yst6Qx55Asn2C3gMJkhHsS8W5XuvkQ6fmVhh/Oo74+C/z4/7/d5KHgVZaMQKDY9OLWsv/Y4kmQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=tphwpPST; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-411e5f21c0bso3267305e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 00:44:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707900266; x=1708505066; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X3eth2TSBr+10lk6fCyMvSDVfbmqhMKDjUVfag1zzhw=;
        b=tphwpPSTePp5K4zCZETxL+jPaSxMOXPV7akSvCft+mcqRoqp76Y4MaXCfuYsnSZHTO
         p1Lfu36BMdkh7pmiR/WALoSwSjEGE8ZNseIFo7IIcrHKg2DyBPjI9X3zse8XYrLXa9nA
         WNWeRMc3W4XL8J2kF83chG3d3mG8zEwjvAK6oRznFkhZ4mlX7ogPJEiTfJXHlAX0d7MA
         4RC4rhTztO7f8doUcI8YkBQiAu0mb/QuxCW9Lfxew8l4tqq0RC1+4PRtbE0IQ2g1X4AF
         mde4zAGGqfAtLRGi2dP3r3yR1bWVaqch5W7kjRswUUhJ08wSsAq37BByuMU+v9eIS8hN
         9A9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707900266; x=1708505066;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X3eth2TSBr+10lk6fCyMvSDVfbmqhMKDjUVfag1zzhw=;
        b=gBnNszRnl53TZGHTgfHolWOf/i78AWpLsescFH0VuclGibLk6q37nWvs97r6cYsMvH
         DVEbPYfikrNAFSfurtogUAlBnP74aWBUrTKxcZB959ucFZXp1cFWyjd4n4jvP3ffzNOQ
         lx7dkwEYJbiuwY6ETuETkPs11RlLW4EOkOcg9rzO/DWejvHG76bWoZ0lxL8/xtldJ3D1
         JZlTU0QLorG1tPUn/1s5m/DjEmkq7cz9lQNI2ZfaO/0L88d1I7EKv3cayH+Xgq1an7e1
         rVkZJ+f6dhgz7gV8pG5bQhiIUKsxl/iYA7LF9JadoYfDymc526z7aGpRSiO3DmcT6Vff
         KjeA==
X-Forwarded-Encrypted: i=1; AJvYcCUYzbs3uG6Ll/ujTOJRf52w0ZsWbFVFWy0ljaE633aSPoALon/e9J+qSbbVkzbsJdkwL8XQdtcISxbYnU2Isk0DM7kYPNYVJP7e4QUS
X-Gm-Message-State: AOJu0YzNi30xuUREHoFu3myp9QQV1IUAwWeoNNNOVYG7GY6zNluAlq+c
	zLwnmR6RZfxyaTEyJseLfYZyayiHxEiu69FHvhuLBRci66xaWSxHmPZqBpXO3lU=
X-Google-Smtp-Source: AGHT+IGRBXN2kxQwLtZCvWWyvloxumofGlzfk7C9aKvbB+3YAsKfrBDO9B0MVoxtX5oL8wX8BRX19g==
X-Received: by 2002:a5d:55d2:0:b0:33c:eca2:c59d with SMTP id i18-20020a5d55d2000000b0033ceca2c59dmr724048wrw.45.1707900265928;
        Wed, 14 Feb 2024 00:44:25 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUt5BDLK4r1+Y4riz/yiaqEuNCX19R2dR5JZJDkaNpw+qEGfPIiEOf3LYWZLQyeDhYUr9orz0WrswVOSjzMmZGGED8u3oiBwjQXxKCwRS5iE6liZyS7h78Brq3ANzvP43T1N5uhD8vUbgJy3aFcjiQHUb+q8NcLk1RlU3vdErHE4Nm11gh9fP5+Etl3/1HprRbbWPkHXDGkKDI8fbT3qC6wzkAoqzlfP3GS8MKJb8MbLYAS5HTKbzXhiWpdsvXTJvzl/CKMNZMwkId9ulnzpKk8L/O/v3wC9yBDWQFr0G//v0Py3pw4UenCEHtYE1xSOuUXImaLUqYKGXlJL+pHfmFyNr+Z+0gLa4TLKEOKHDD5dzn5Y4SaQ5dGkjFl6dBgPFglfqAirdAQOXejWx6Ite/imxcNAGvxfgTs+wHp
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:cfee:a5b6:1f9b:9c9b])
        by smtp.gmail.com with ESMTPSA id fa1-20020a056000258100b0033b79d385f6sm9494731wrb.47.2024.02.14.00.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 00:44:25 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>,
	Mark Brown <broonie@kernel.org>,
	Dan Carpenter <dan.carpenter@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel test robot <oliver.sang@intel.com>
Subject: [PATCH v2 3/4] gpio: use srcu_dereference() with SRCU-protected pointers
Date: Wed, 14 Feb 2024 09:44:18 +0100
Message-Id: <20240214084419.6194-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240214084419.6194-1-brgl@bgdev.pl>
References: <20240214084419.6194-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Lockdep with CONFIG_PROVE_RCU enabled reports false positives about
suspicious rcu_dereference() usage. Let's silence it by using
srcu_dereference() which is the correct helper with SRCU.

Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
Reported-by: kernel test robot <oliver.sang@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202402122234.d85cca9b-lkp@intel.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-sysfs.c |  5 +++--
 drivers/gpio/gpiolib.c       | 16 ++++++++--------
 drivers/gpio/gpiolib.h       |  3 ++-
 3 files changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/gpio/gpiolib-sysfs.c b/drivers/gpio/gpiolib-sysfs.c
index 6285fa5afbb1..71ba2a774197 100644
--- a/drivers/gpio/gpiolib-sysfs.c
+++ b/drivers/gpio/gpiolib-sysfs.c
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/string.h>
+#include <linux/srcu.h>
 #include <linux/sysfs.h>
 #include <linux/types.h>
 
@@ -756,7 +757,7 @@ int gpiochip_sysfs_register(struct gpio_device *gdev)
 
 	guard(srcu)(&gdev->srcu);
 
-	chip = rcu_dereference(gdev->chip);
+	chip = srcu_dereference(gdev->chip, &gdev->srcu);
 	if (!chip)
 		return -ENODEV;
 
@@ -800,7 +801,7 @@ void gpiochip_sysfs_unregister(struct gpio_device *gdev)
 
 	guard(srcu)(&gdev->srcu);
 
-	chip = rcu_dereference(gdev->chip);
+	chip = srcu_dereference(gdev->chip, &gdev->srcu);
 	if (chip)
 		return;
 
diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 439d32d5aa38..b095f475805f 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -109,7 +109,7 @@ const char *gpiod_get_label(struct gpio_desc *desc)
 		return "interrupt";
 
 	return test_bit(FLAG_REQUESTED, &flags) ?
-			rcu_dereference(desc->label) : NULL;
+			srcu_dereference(desc->label, &desc->srcu) : NULL;
 }
 
 static int desc_set_label(struct gpio_desc *desc, const char *label)
@@ -447,7 +447,7 @@ static struct gpio_desc *gpio_name_to_desc(const char * const name)
 				 srcu_read_lock_held(&gpio_devices_srcu)) {
 		guard(srcu)(&gdev->srcu);
 
-		gc = rcu_dereference(gdev->chip);
+		gc = srcu_dereference(gdev->chip, &gdev->srcu);
 		if (!gc)
 			continue;
 
@@ -1190,7 +1190,7 @@ struct gpio_device *gpio_device_find(void *data,
 				 srcu_read_lock_held(&gpio_devices_srcu)) {
 		guard(srcu)(&gdev->srcu);
 
-		gc = rcu_dereference(gdev->chip);
+		gc = srcu_dereference(gdev->chip, &gdev->srcu);
 
 		if (gc && match(gc, data))
 			return gpio_device_get(gdev);
@@ -2978,7 +2978,7 @@ static int gpiod_get_raw_value_commit(const struct gpio_desc *desc)
 
 	guard(srcu)(&gdev->srcu);
 
-	gc = rcu_dereference(gdev->chip);
+	gc = srcu_dereference(gdev->chip, &gdev->srcu);
 	if (!gc)
 		return -ENODEV;
 
@@ -3012,7 +3012,7 @@ static bool gpio_device_chip_cmp(struct gpio_device *gdev, struct gpio_chip *gc)
 {
 	guard(srcu)(&gdev->srcu);
 
-	return gc == rcu_dereference(gdev->chip);
+	return gc == srcu_dereference(gdev->chip, &gdev->srcu);
 }
 
 int gpiod_get_array_value_complex(bool raw, bool can_sleep,
@@ -3593,7 +3593,7 @@ int gpiod_to_irq(const struct gpio_desc *desc)
 	gdev = desc->gdev;
 	/* FIXME Cannot use gpio_chip_guard due to const desc. */
 	guard(srcu)(&gdev->srcu);
-	gc = rcu_dereference(gdev->chip);
+	gc = srcu_dereference(gdev->chip, &gdev->srcu);
 	if (!gc)
 		return -ENODEV;
 
@@ -4787,7 +4787,7 @@ static void gpiolib_dbg_show(struct seq_file *s, struct gpio_device *gdev)
 
 	guard(srcu)(&gdev->srcu);
 
-	gc = rcu_dereference(gdev->chip);
+	gc = srcu_dereference(gdev->chip, &gdev->srcu);
 	if (!gc) {
 		seq_puts(s, "Underlying GPIO chip is gone\n");
 		return;
@@ -4872,7 +4872,7 @@ static int gpiolib_seq_show(struct seq_file *s, void *v)
 
 	guard(srcu)(&gdev->srcu);
 
-	gc = rcu_dereference(gdev->chip);
+	gc = srcu_dereference(gdev->chip, &gdev->srcu);
 	if (!gc) {
 		seq_printf(s, "%s%s: (dangling chip)",
 			   priv->newline ? "\n" : "",
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 07443d26cbca..ada36aa0f81a 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -202,7 +202,8 @@ DEFINE_CLASS(gpio_chip_guard,
 
 		_guard.gdev = desc->gdev;
 		_guard.idx = srcu_read_lock(&_guard.gdev->srcu);
-		_guard.gc = rcu_dereference(_guard.gdev->chip);
+		_guard.gc = srcu_dereference(_guard.gdev->chip,
+					     &_guard.gdev->srcu);
 
 		_guard;
 	     }),
-- 
2.40.1


