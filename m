Return-Path: <linux-kernel+bounces-4531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 21AB4817EE8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 01:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C45C0285E32
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Dec 2023 00:43:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0143717CF;
	Tue, 19 Dec 2023 00:42:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gExgulCM"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF0601FAA;
	Tue, 19 Dec 2023 00:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-28abb389323so1655252a91.2;
        Mon, 18 Dec 2023 16:42:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702946557; x=1703551357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82YLVhideuyQljRWJu1rWLIQMnIXOza47pBdqrDT1ns=;
        b=gExgulCMIE2b3OY3uPcIQoZJthPuLs5vh7yPRqFIauTOP1ny4w4Dg0WxkiVNGNA4xI
         tNgmAVjNh9e9lLtaHd/LHKS9Oy3WML836fKf3HOQ2YW+5LQI6ENaeVZ9hXH5Zp1KkChz
         BcdXS06PJnKTEaPEdt/SDdJ0PtTDAKDlqPmHQ6ajA2RX/mdYjfeJgQOTwaxcfpZIJ9i3
         SW++Y8nk98yC2+Ld1AgDPV5gWfFqVDiV4+jALCLZG8DR2q5Y6lNGxOPmU5XUMlka9MOd
         1GBf6SaoCy50S65SRuQJH0UQWDTn1eOJFTTE3y35ga68udIbA3Tvkap5db8brumoSHbs
         2Jxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702946557; x=1703551357;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82YLVhideuyQljRWJu1rWLIQMnIXOza47pBdqrDT1ns=;
        b=VhgL3j4JB/WNiEWFqZlWf2MCjVRdvQH9dlRNQejOVMZpg98iajOhgnzfpyrmMHd3KZ
         NobTQzyuNc07av3IyaNNRQc0ng62z0T1oOo0Ou/ekTBJCF80BAGvU2/TCUfmSrgv+Y9b
         6Tk3EWewugEWZn+/dBSqmpZKkZYfS+uYLHqLuKnjofj8TjLoGMnp9OC/nvBJvwhGu9NS
         Kgv6QVDP/NJ56FESEuPvNafeE/2aRWAZOxmjUMYKGhv9wF/mX2p/LB03Yi/c6CLJRWdI
         zzoAEKLHSOsH6DW5YO/adGXnMnoMLRe0Gx6pVT/tfXQrXe1kmoS9OgWoXsPrE4delFGW
         EbQQ==
X-Gm-Message-State: AOJu0Yxy1h/MRbBDzWTvnS0ALnt326ypAl3x1jDWMUldzf6azE2LIN5w
	GOrNdzloLUgWVUW1slDj20CC5T5gJ5g=
X-Google-Smtp-Source: AGHT+IGlKRDxTmTEUTsptMsSV1VctWiIjGBgXfTfXvVNRXKxTwqCUbTy4nANAcmUFu5Mi0JwCcoT5w==
X-Received: by 2002:a05:6a20:65b0:b0:18f:97c:928b with SMTP id p48-20020a056a2065b000b0018f097c928bmr7288523pzh.112.1702946556970;
        Mon, 18 Dec 2023 16:42:36 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id l9-20020a17090a3f0900b0028ae3b5dde9sm173484pjc.12.2023.12.18.16.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 16:42:36 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v5 2/5] gpiolib: remove debounce_period_us from struct gpio_desc
Date: Tue, 19 Dec 2023 08:41:55 +0800
Message-Id: <20231219004158.12405-3-warthog618@gmail.com>
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

cdev is the only user of the debounce_period_us field in
struct gpio_desc, and it no longer uses it, so remove it.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
---
 drivers/gpio/gpiolib.c | 3 ---
 drivers/gpio/gpiolib.h | 5 -----
 2 files changed, 8 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4e190be75dc2..ca2216621619 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -2344,9 +2344,6 @@ static bool gpiod_free_commit(struct gpio_desc *desc)
 		clear_bit(FLAG_IS_HOGGED, &desc->flags);
 #ifdef CONFIG_OF_DYNAMIC
 		desc->hog = NULL;
-#endif
-#ifdef CONFIG_GPIO_CDEV
-		WRITE_ONCE(desc->debounce_period_us, 0);
 #endif
 		ret = true;
 	}
diff --git a/drivers/gpio/gpiolib.h b/drivers/gpio/gpiolib.h
index 3ccacf3c1288..a4a2520b5f31 100644
--- a/drivers/gpio/gpiolib.h
+++ b/drivers/gpio/gpiolib.h
@@ -147,7 +147,6 @@ void gpiod_line_state_notify(struct gpio_desc *desc, unsigned long action);
  * @label:		Name of the consumer
  * @name:		Line name
  * @hog:		Pointer to the device node that hogs this line (if any)
- * @debounce_period_us:	Debounce period in microseconds
  *
  * These are obtained using gpiod_get() and are preferable to the old
  * integer-based handles.
@@ -185,10 +184,6 @@ struct gpio_desc {
 #ifdef CONFIG_OF_DYNAMIC
 	struct device_node	*hog;
 #endif
-#ifdef CONFIG_GPIO_CDEV
-	/* debounce period in microseconds */
-	unsigned int		debounce_period_us;
-#endif
 };
 
 #define gpiod_not_found(desc)		(IS_ERR(desc) && PTR_ERR(desc) == -ENOENT)
-- 
2.39.2


