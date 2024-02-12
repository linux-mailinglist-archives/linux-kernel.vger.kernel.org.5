Return-Path: <linux-kernel+bounces-62405-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245B5851FC0
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 22:39:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 18F5D1C22567
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 21:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 136D74CE12;
	Mon, 12 Feb 2024 21:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="DmUYmnow"
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2664CDE1
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 21:39:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707773968; cv=none; b=ps01eyNNln9IcRW1bfB1lGfVKf6TcW7MGShEEQDIo2QueLhGmeUKu9noQWWZjR1kGpAk/oR+B+3t9SzvB0WYYdeso6u9IsgwxHocLaFVnnhyQuyVkHTALqTFC/BShIjCYJJz94STCHLvjWrKWeyG/wVW/eqghodCDmuueMIoAMY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707773968; c=relaxed/simple;
	bh=N3/kikCT/ViKRnsMui+U9/gXaw82x3G8rndyMWY3axE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PeaaYPnNU6CnN3gipEwCQt8XL6SgU0eUD6P7BN928SYA8Oy9IpLsJ9RWdXbkQwV80how7nSRffwtoY1wQ4wiUa57Tzuv+CmmPx1SCCW+6sYf2/pvQHpsG2sCYMrVInzJRg44sIBPqKCuuNwZFRru73DrBJ4AG9A1M5PC984zFTQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=DmUYmnow; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33b728b6981so1290647f8f.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:39:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707773964; x=1708378764; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ex+oKN9tSPmg7cHAF6KW1k5mHWCdEfz2WwiKUWwTXNo=;
        b=DmUYmnowvlmWQTK16hezBbQJYk90+mR8g4nVecNqMak2BbTmKKktbBmqTV/U1wAuaR
         nVPK+Kt1dRuK5AcKD1uMe97cPeLgFnX9DC21k1XmMf7xOUH9uSr4exqePjN1y7UfEgaN
         9ldJie6dIsepUlApNHf2VcSLWHeM/MVfLGUE4qsDzn1UwubBWXd5I5w2vtlJw9RBHqe8
         ipd6NpiHKlmdvgAf1oCfH5/UjZIKzUAsTdZJWQYU/fCPZsmPhtrdzkeYAG3sTPLVgrEy
         6rSakmyPWkaWc94TuEysGCPfZ9ZfGdKxWyxkcB93R5ROJjsmgXzCySIp4pnlo9zxfVsP
         ij1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707773964; x=1708378764;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ex+oKN9tSPmg7cHAF6KW1k5mHWCdEfz2WwiKUWwTXNo=;
        b=UxvlhsDQy1NGtruUmoIMneJ1Dh7OecL2+nExNWM7MQezGkkzf7ZXGoWlnv1jBe9V68
         Cr7JzT+/twoZ/VBdEI6DaXE6U4Uubju1Q4DxlqNy9htEU4BoADUsEjsQNITrKPpAm8Ql
         2R+PT4vlvabqAZ4UNYP4TrP2mlVFqPAR9TjRq26uPaAqw/ixHCXRkgHjS7eKDnpG5Mvz
         08mxAsB6jTYIOMZRPd4uHM+sxnYrnes0EEx7BlkLTfMjjOmTHte3MrWYOGsiTLH3hu9e
         qKGlHduOJ6VnvwBKAgG2O3XG1aXJoKleZ9LcVCFQ82VlgDHfifzbKn+QvRuxXnwUSTyH
         ZR1w==
X-Forwarded-Encrypted: i=1; AJvYcCVd5alCEbkindM4VxaBSdbtMJnLWc8ZTT9jtkX7bBnc0HEotQBSiBfuCNsQRiQmsScIQqViPum3oS4QacFZPFXeYRAE1WlJoyNq2r6Y
X-Gm-Message-State: AOJu0YydLvv5SgruDnIkGXE4qmTvhjh6A2NqF++1SLHmaKyxebN1ecUR
	tykrzCSCVfxNTOb3/bqXTW9K/JOcJMDorYwvKpR8mAYYU/HiJwJ0uQRf0Od+OPw=
X-Google-Smtp-Source: AGHT+IGfhwxLT8Vk9nOPKN82YJ7lRjNzIYy/6NFrGqYkUXIjQMu7mfZ3RmqADRi467Voah4oS3AEMg==
X-Received: by 2002:adf:fa89:0:b0:33b:1aa1:4859 with SMTP id h9-20020adffa89000000b0033b1aa14859mr5532501wrr.25.1707773963604;
        Mon, 12 Feb 2024 13:39:23 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVObmwKxPpP3wOlRvgKDIfG7AsKKOS08XKPkQTHLXQz5zYMCfLuHYPfRqnFrOZyPEvq4l+ohKUHWdqxvracpdMWzset61MSOnZAokRmpZDGYODUDhkr87emdvI3IT7mtdptcWRNhp8cJYuDGn0rXvTD3gaG9Lk/zl11arf7IRLDMqI/BIMRnOqDIsRt57QKK/BePfY3HvkcKzmvxG8VB5gIWA3S/LkwuXWfgUqs5f4R5I2ChcfQH9Kt9VogbyrULBtehgBy5o2Pz1687xaqIMDxa6olO2ZcZUqBLJkrw+EeKxuG3AxjTIuw0dmY7crNtRKSTE/gF4UZ2GJYDbNSODt5uR0akb4
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:3ff8:aa1d:f441:5fbd])
        by smtp.gmail.com with ESMTPSA id f14-20020a056000128e00b0033b50e0d493sm7776702wrx.59.2024.02.12.13.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 13:39:23 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Kent Gibson <warthog618@gmail.com>,
	Alex Elder <elder@linaro.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	"Paul E . McKenney" <paulmck@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Wolfram Sang <wsa@the-dreams.de>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH] gpio: initialize descriptor SRCU structure before adding OF-based chips
Date: Mon, 12 Feb 2024 22:39:20 +0100
Message-Id: <20240212213920.49796-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

In certain situations we may end up taking the GPIO descriptor SRCU read
lock in of_gpiochip_add() before the SRCU struct is initialized. Move
the initialization before the call to of_gpiochip_add().

Fixes: be711caa87c5 ("gpio: add SRCU infrastructure to struct gpio_desc")
Fixes: 1f2bcb8c8ccd ("gpio: protect the descriptor label with SRCU")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-lkp/202402122228.e607a080-lkp@intel.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 82811d9a4477..f5434e559382 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -991,10 +991,6 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	if (ret)
 		goto err_cleanup_gdev_srcu;
 
-	ret = of_gpiochip_add(gc);
-	if (ret)
-		goto err_free_gpiochip_mask;
-
 	for (i = 0; i < gc->ngpio; i++) {
 		struct gpio_desc *desc = &gdev->descs[i];
 
@@ -1002,7 +998,7 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		if (ret) {
 			for (j = 0; j < i; j++)
 				cleanup_srcu_struct(&gdev->descs[j].srcu);
-			goto err_remove_of_chip;
+			goto err_free_gpiochip_mask;
 		}
 
 		if (gc->get_direction && gpiochip_line_is_valid(gc, i)) {
@@ -1014,10 +1010,14 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 		}
 	}
 
-	ret = gpiochip_add_pin_ranges(gc);
+	ret = of_gpiochip_add(gc);
 	if (ret)
 		goto err_cleanup_desc_srcu;
 
+	ret = gpiochip_add_pin_ranges(gc);
+	if (ret)
+		goto err_remove_of_chip;
+
 	acpi_gpiochip_add(gc);
 
 	machine_gpiochip_add(gc);
@@ -1055,12 +1055,12 @@ int gpiochip_add_data_with_key(struct gpio_chip *gc, void *data,
 	gpiochip_irqchip_free_valid_mask(gc);
 err_remove_acpi_chip:
 	acpi_gpiochip_remove(gc);
-err_cleanup_desc_srcu:
-	for (i = 0; i < gdev->ngpio; i++)
-		cleanup_srcu_struct(&gdev->descs[i].srcu);
 err_remove_of_chip:
 	gpiochip_free_hogs(gc);
 	of_gpiochip_remove(gc);
+err_cleanup_desc_srcu:
+	for (i = 0; i < gdev->ngpio; i++)
+		cleanup_srcu_struct(&gdev->descs[i].srcu);
 err_free_gpiochip_mask:
 	gpiochip_remove_pin_ranges(gc);
 	gpiochip_free_valid_mask(gc);
-- 
2.40.1


