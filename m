Return-Path: <linux-kernel+bounces-366-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 63B5E814015
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 03:43:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4E9D21C2222A
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 02:43:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0B6A748A;
	Fri, 15 Dec 2023 02:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CZ2f8aLx"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 157778BF1;
	Fri, 15 Dec 2023 02:38:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-5c6839373f8so113365a12.0;
        Thu, 14 Dec 2023 18:38:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702607923; x=1703212723; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/gErARlFKGLkOKnr/eZMaU60+19wTX7Ibdpi8xmN6kM=;
        b=CZ2f8aLxfc2/FeU6dsTWgSzXVdiKjLDVUFmYiPuBiSpEyBJrA8ih1uMhSuniXHlQ8/
         Xh87/sk2R1TVFygwVy5YdH1NNPpmEzAEX4XbRc2JJJYQpfguyC45EEgMB9/ss7iKP3nZ
         BYRh+byLawwL21B6DrJierMCxAtAtXT7vE8/j1SySDiw6y6uj5j1QghzzAcXCNaP/KDa
         5M5kQNUyihPAB9jW2WeIvaiXxO60UtgMdXecteRvpaRPafDDs34dX4llXBMB/RiWchD3
         ZQ65Gu+1JFMrFlklylGEn/DEDUFa76ErlPefpa1aND5ui2suZ4w/zj3ZTZmJSKd/0tg1
         D/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702607923; x=1703212723;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/gErARlFKGLkOKnr/eZMaU60+19wTX7Ibdpi8xmN6kM=;
        b=S5dcCqkbxFcU5Xtup9D7cJT2nqHZ9Z4+6qdC9oSohDR6jlDhRz6DAmkXAVG5ENn8yj
         C9/LmRILuzWTucvxHtrermb1sur4KkQkU8svy2ynyet1h+B0AFzAl3Mmw8nz16n/O0uP
         YkxXFvNz6bhqes/T5pNOpnlpBYMUhSyybNk0GoU/Mkb+dJ5nT7PDx7yqqkafcBVUgyqy
         sU/Ri16y6RcYQejRrjKtYljY4SRHQRVoxqs1ERY290y2tmrgmfJTEv4Bd3HTaJ55sEcp
         JAPbGeN1MPDJ7OT39eGdwi/NHwOu85tPMe8SWIOe3YCNk9S0YNoqRfYAipqo/pVZA5Fq
         3HoQ==
X-Gm-Message-State: AOJu0Yx8s/W2zZ2yYyvkjQBe3OQO0tDcE/+0BDiFoBtWU9YLPozu0zdE
	ZSzaKu8i+Qk3nPWhDDIYZmp/oMF4Xv8=
X-Google-Smtp-Source: AGHT+IGpWMlYV6JMB/ZdN/bvg1YD44Cb++j1qnhUBXFPrAUChu3epn7DnthHCK7PExMtPShmzMnOqA==
X-Received: by 2002:a05:6a20:3d89:b0:190:7b07:b7e4 with SMTP id s9-20020a056a203d8900b001907b07b7e4mr12917150pzi.10.1702607923142;
        Thu, 14 Dec 2023 18:38:43 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id fk16-20020a056a003a9000b006d26920a11dsm1437987pfb.0.2023.12.14.18.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Dec 2023 18:38:42 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v3 2/5] gpiolib: remove debounce_period_us from struct gpio_desc
Date: Fri, 15 Dec 2023 10:38:02 +0800
Message-Id: <20231215023805.63289-3-warthog618@gmail.com>
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

cdev is the only user of the debounce_period_us field in
struct gpio_desc, and it no longer uses it, so remove it.

Signed-off-by: Kent Gibson <warthog618@gmail.com>
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


