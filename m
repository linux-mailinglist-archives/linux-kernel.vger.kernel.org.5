Return-Path: <linux-kernel+bounces-1861-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 862C28154E8
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 01:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 09D54B23E82
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 00:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 187D87F1;
	Sat, 16 Dec 2023 00:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SMLShOQ0"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 291711846;
	Sat, 16 Dec 2023 00:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6d26eef7438so1372363b3a.0;
        Fri, 15 Dec 2023 16:17:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702685843; x=1703290643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=82YLVhideuyQljRWJu1rWLIQMnIXOza47pBdqrDT1ns=;
        b=SMLShOQ0wCpRNJz76PuJMREn0HG8WGo/3AAA1NQYMSLbIZWPQtTFrwanv+jhMfda7r
         e0B1lndR40h1qHRSChyAX5RRwcDrC4ZbVDK8DZZ6N4OMzYVPIw1qfixUCAwLXv6Wostd
         4t9ywI1df5nKFwGJjo8woqYcFldnuXSMRfJHmmA7BXjqYY32CezXw6lvgOMMNv0d31mo
         yUC5525SuX+TbJlH3N3eEl/9km576v2FL4l+egSKPhJuumrBmiIk1GhfAbUZGmdqcQbv
         CFzF913HXxRVmnpPBSqSHb5+2NU58tT4WV3fGYspwaA9Jg3Bfw4bUifmOSS6JkaPRR0I
         7REw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702685843; x=1703290643;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=82YLVhideuyQljRWJu1rWLIQMnIXOza47pBdqrDT1ns=;
        b=qX4VvxpX2BuMA3WdVjk/yqjmWBFiALhJvLi0mUxTeM5bWc50WsWvczwZUZEnV2zeVa
         mpmWFFOufSlGDGf/y1dILy1Ew0TlFFxJC6up7ji1kTmkybBwBsi8xwW5FCsiRkJyXTk4
         RT3j0HGocHY31BmCN1kILP/i+NEyxV5PDgHi5dQfAKRpwvQz0h4/nWFam7hkRsuXd4ku
         C8zObi7YojZK9+YAdJbAkue12kSb0o/xXMQUSujKwetMNUbrjJTdG6UULplLj9jGJC0K
         Xx9CebgPibw4fbVyAG3YKZA+8zjYlSfUaQ6ry6fIqpEeK3TNt1LYrv85suSxvAsR5Mp6
         FQ3A==
X-Gm-Message-State: AOJu0YxQcHpZOwsV5/AoLIqeRVmkr68xZhtaZgcuCpCwkAr5tGeWTC1P
	QZI9u0UekLKMmYdmSJ2I5n406bEF/j8=
X-Google-Smtp-Source: AGHT+IERK85bB3U/DXt/+OtJeOPr7ccOnDYSF8H2KZnTW0ignVhiDP/rD34UFnzmGhfLOfPrbGS+Gg==
X-Received: by 2002:a05:6a21:998a:b0:190:cab:b3d4 with SMTP id ve10-20020a056a21998a00b001900cabb3d4mr14893959pzb.30.1702685843154;
        Fri, 15 Dec 2023 16:17:23 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id ei39-20020a056a0080e700b006cbef269712sm14176124pfb.9.2023.12.15.16.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 16:17:22 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v4 2/5] gpiolib: remove debounce_period_us from struct gpio_desc
Date: Sat, 16 Dec 2023 08:16:49 +0800
Message-Id: <20231216001652.56276-3-warthog618@gmail.com>
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


