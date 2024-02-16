Return-Path: <linux-kernel+bounces-68477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1939857ACF
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 11:59:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DC7FB22C25
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 10:59:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C51A755E55;
	Fri, 16 Feb 2024 10:59:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xnk0vA7X"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8890456777
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 10:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708081183; cv=none; b=ZQRerCsxRf9bHbEA2b59U2ecOe/KJOtaZUQ7cm9Akb8qwwnR7+hpVI3iiA5PlP9dHa1BCCUNHILxU9rs6sO++9fkiFHvoQ2nGgpDZZKHmFjlHgY98jRTlwwHaQHBnPpf8RZ/j6zPR2Y8GznMDyP7hKOiGsc3HQ7BfMVk0T7+V+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708081183; c=relaxed/simple;
	bh=0+W7YvnXsbigDW20wUUhl3v3SbWmF/ZQM4L9pAdvkn8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kQc7xxRVtbBNlj7t1vs53APX7vFKvsXMaKCzcAsaOzldiPCaN447RrT8EnWOwNoBZ33FzkPQJh72/j/1CNLCEYgQVkdXdVsH6uyeT1k0LmU8DzDytFsCg7qkmwL+xF9UrYq2J9XgEattgNSbzur4kjCbey9Xn2wuS4B+xMXma1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=xnk0vA7X; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-33adec41b55so976411f8f.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 02:59:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708081180; x=1708685980; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0chfNNhs8bBmYgWUUEe6ZqXEIPXfXJhTDLop2ZkZRQE=;
        b=xnk0vA7XDmXDTbOkY77VFVUdFbzqZ1rAD2btF2V5YJBf5eP8gpEO8/GwjCQL7NRSgG
         fLPNouOBmdlSLgWQQ20TLGDz8Ekjs73O/uw/5+NQnUYY0+4Hui+MR+4fnKZmxUzpLZAn
         pGl0DAwwObr3pfTGGedhTQhm2HJiFyBM4NwgW0TUZCo7pIsdfLYG+jdoPqoeu/F7qW6K
         n3FTwg7Riy1H3cPICkrejcB6Ycb9+YIGAXvXlRHIraMzXRuj1PcYVB9Kv33Sa5PDZ7v7
         xXSr5fHYGm7vSYq46s/PEFR3xGUlR+1DJ+pH1mmHyKKiCWDo8l7uVq98r9/LVeBFtLR5
         O9mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708081180; x=1708685980;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0chfNNhs8bBmYgWUUEe6ZqXEIPXfXJhTDLop2ZkZRQE=;
        b=DDvqTxCp26ZCFwX+hX9vqa6YV2epz4+yB+s2xhDsWgbxyn6nY1kUlGzan4txvwNeYC
         lRra2zAdx+DxvdNBc9uR7Ewy9UqWmVpISwl5qSTrU8Bpo4Y+1GtafasreH8VeYzGMgw9
         xZIAzMrIkzjq+b9wdkRlixQ5oY3ztEvAsEC4ExDPVhneQh7Zmly8oIL8rqz+OP9WALc0
         I0MaMpX7sucRsms84/AbXgBfEzHAxw8rZHZEhDVU1ywwhe0Spjok2WoB4D921AGlcn5s
         BVc2Yl+pGxCwc5/qNDcwDsvRvYPRppXUmVfzf3tTJByWU8JROtRl/Ewk0jKLUqqbMxpr
         hN2A==
X-Forwarded-Encrypted: i=1; AJvYcCUXaolcKSQdJzRwPNF6U1twKbCAncKiXbFCqtOe2W61gZDW0HDXLwr/MAvWtZUDQTM+zdRy9XAGRuF10t16Zc35DnXrbTk6NiyUjJBU
X-Gm-Message-State: AOJu0YzglzqxX/4h2F+82Lh5YrKMpNCCy8rBfCw9lCKO5hQqlLrIs0xP
	vQR/f4wnkSSx+u8ooaYaF6vlRTVBP5saDka6ATsPA5TKTLQ2+M0wwXTP2GQ5nng=
X-Google-Smtp-Source: AGHT+IEbZWK8/FIIiShmTZucyyUKH6SVCkbFOFG6fztKHXZBfziSGGMFocQi+qchbIAutXv/2TbwXA==
X-Received: by 2002:a5d:644b:0:b0:33c:e2ff:6c81 with SMTP id d11-20020a5d644b000000b0033ce2ff6c81mr3223015wrw.48.1708081179462;
        Fri, 16 Feb 2024 02:59:39 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:7758:12d:16:5f19])
        by smtp.gmail.com with ESMTPSA id k3-20020a056000004300b0033b79d385f6sm1874079wrx.47.2024.02.16.02.59.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 02:59:39 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
	Kent Gibson <warthog618@gmail.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	"Paul E . McKenney" <paulmck@kernel.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH] gpio: cdev: fix a NULL-pointer dereference with DEBUG enabled
Date: Fri, 16 Feb 2024 11:59:30 +0100
Message-Id: <20240216105930.16265-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

We are actually passing the gc pointer to chip_dbg() so we have to
srcu_dereference() it.

Fixes: 8574b5b47610 ("gpio: cdev: use correct pointer accessors with SRCU")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Closes: https://lore.kernel.org/lkml/179caa10-5f86-4707-8bb0-fe1b316326d6@samsung.com/
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib-cdev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 85037fa4925e..f384fa278764 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2795,8 +2795,8 @@ int gpiolib_cdev_register(struct gpio_device *gdev, dev_t devt)
 		return ret;
 
 	guard(srcu)(&gdev->srcu);
-
-	if (!rcu_access_pointer(gdev->chip))
+	gc = srcu_dereference(gdev->chip, &gdev->srcu);
+	if (!gc)
 		return -ENODEV;
 
 	chip_dbg(gc, "added GPIO chardev (%d:%d)\n", MAJOR(devt), gdev->id);
-- 
2.40.1


