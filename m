Return-Path: <linux-kernel+bounces-78297-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56312861186
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 13:32:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C07F1F2270E
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 12:32:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6DD7A725;
	Fri, 23 Feb 2024 12:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="KEuiOcIt"
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030FE6FBF
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708691560; cv=none; b=PCNH+4lgcHRXTqUfujJe79/PP1OHhCJQJSFWjBKMh6iq0g8ueB5sWN8Cu74Z6ZmQekDyyLSpAs1vl8T7ca6DBXcABuyf+2QQFtt8iGvdMfRdiJPyQ9xIDkaonhtzbKFdfJgWe88rRbojmKo3DMnoL523WPNpmw34SGWeaEMflYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708691560; c=relaxed/simple;
	bh=MUlSFtWbj0V62A8/4308SD7hLIx+thz5BLA3ogEOGls=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bhFjVum3zDwxKoFnXQbr/BC5YzMWM7sw541GJfh2aKMvoovxFIH9T6ofjLBTQKJdtcC8HileOmvtScYnxRtcsBYjUE8wRjsAwNa20YP6D0ldDBcVe7VN+Ls35TigRD/LR1F3HQHhtg2z2+Xx9Ni1J6vIOeAgaLh8NL4QvTNSXnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=KEuiOcIt; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-3394ca0c874so513973f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 04:32:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1708691557; x=1709296357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O3XBcXMSN0Mpihz8EQIn8kaWsCSFp4YWsDMhO0GDawI=;
        b=KEuiOcItNoK9NuIBppunRA/2DJ9+lRsjrcvqVIY35QSm8cD5Oy1IRhh7N5kFDiPMtD
         Ko5V5Vq4+pukMLtLhgGibfyDrqD0TgNM9VFA20/NNeL2L5g/xUpWKEd4PCiHFnQBxRjX
         EQ/7nwadee7VJKBxpnPQiqSuaE5P45ySoaVss1A1peMoJcVhR9FkTcAGyW0v3zB7t2N7
         bzWHdG5pMsJjm0jU7XKV/MYxK+HrhZTuVo2TyAa2ybDxf8hzXeHYIqGjH9+JcFlFhKqz
         zJKlgHNfwGp5bHUtzo2qURR7JTuQlJFmQPa72DeMr+Xoam7W8dMBFvkpGPfbSs92gyWr
         +hFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708691557; x=1709296357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=O3XBcXMSN0Mpihz8EQIn8kaWsCSFp4YWsDMhO0GDawI=;
        b=ZlJJ9B1dSPnh/2moGDWZZ9TewO2rWtfkhqC28zpqAoPuaE/+KHNiU14wjmEyG+k868
         pzXLIESolPZlZTaXd54hYDVukOFmf0G+Hxl1LxePy2JDFzpKm5TjGc+zoVUOs5xfC8QP
         Fg6E0DmtRysIV5jkstUc+ktuNcBgeLYLk8YeITxk60GaZu5UnevHmlcTODgrgZEnZsnV
         bJqSwJSzE+3mKTGxufU9j2rFQGuNFZcJanv+TaXRA5ZXZVq11audU2COoUVUc6DY+PK1
         vRc9F2f7/1H7InFflMVq3EZO+sl+u5DmojyMfMLABO1UkJbWSpxQVB7eBzoyRjYQMfO/
         v68A==
X-Forwarded-Encrypted: i=1; AJvYcCUcmfruz+j4NxuGT45lhwc9ZaaSd5zSSBdG4V2N/M9rbY6fMqnvWeJ3KqUwZ2KmvpELI4raEezeq2t0I5/v2wyUWju/ec5kz5+hCpBO
X-Gm-Message-State: AOJu0Yw4Vby3MJZocXP/KJ6YPbvuU1bVJBCkMK8ZPX+ClFsovDeBAdFC
	YkMgutO8XWECmuRlYNynFKbFmF1EeSEV9r+KvNxGtEM2cDgXB52yhpIATojH/Do=
X-Google-Smtp-Source: AGHT+IGRVMSzWXEwjmqzAHgBdVhX9n1oq/zJVahYOAHFXD6G2g0fq3+l/s9ieNqyASGlYY2rOq6msg==
X-Received: by 2002:adf:fc8f:0:b0:33d:5f6a:60e3 with SMTP id g15-20020adffc8f000000b0033d5f6a60e3mr1338445wrr.43.1708691557311;
        Fri, 23 Feb 2024 04:32:37 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:d13b:cd88:628f:8c6e])
        by smtp.gmail.com with ESMTPSA id by4-20020a056000098400b0033daa63807fsm2124943wrb.24.2024.02.23.04.32.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 04:32:31 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	David Arcari <darcari@redhat.com>
Subject: [PATCH] pinctrl: don't put the reference to GPIO device in pinctrl_pins_show()
Date: Fri, 23 Feb 2024 13:32:14 +0100
Message-Id: <20240223123214.288181-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

The call to gpiod_to_gpio_device() does not increase the reference count
of the GPIO device struct so it must not be decreased. Remove the buggy
__free() decorator.

Fixes: 524fc108b895 ("pinctrl: stop using gpiod_to_chip()")
Reported-by: David Arcari <darcari@redhat.com>
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/pinctrl/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pinctrl/core.c b/drivers/pinctrl/core.c
index ee56856cb80c..bbcdece83bf4 100644
--- a/drivers/pinctrl/core.c
+++ b/drivers/pinctrl/core.c
@@ -1644,7 +1644,7 @@ static int pinctrl_pins_show(struct seq_file *s, void *what)
 	const struct pinctrl_ops *ops = pctldev->desc->pctlops;
 	unsigned int i, pin;
 #ifdef CONFIG_GPIOLIB
-	struct gpio_device *gdev __free(gpio_device_put) = NULL;
+	struct gpio_device *gdev = NULL;
 	struct pinctrl_gpio_range *range;
 	int gpio_num;
 #endif
-- 
2.40.1


