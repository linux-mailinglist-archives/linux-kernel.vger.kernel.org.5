Return-Path: <linux-kernel+bounces-22736-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7C1882A252
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:33:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 71FBE281169
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20D524F616;
	Wed, 10 Jan 2024 20:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="xbMqzXT6"
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA60F4EB34
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33674f60184so4513333f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:32:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704918752; x=1705523552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xH5jTr5aU0xfloUoZ4e4ojWO1uQm4oQS8ylJSBoL6uQ=;
        b=xbMqzXT6stNQwOSGEF4TKGCpRnQOd6QT1tOh6Ce9t9voyBgxAQbeqB/S8wJXSGRDJS
         RB/em+pZk4qULwl1Fuq6n2XPEo6DeZkIxYedQsL3gitV6Q/e9kdutei0vih14x4YRLyI
         lkVdN3YA55zyo02h/u1LhgswVYQpfStxRXARRys85opSjTU28T7M2aCq/LltUDH4LbGk
         82h42UHGy/8OFOS/IJz3LNwYcda4w15NUaxnsvWAfSiQxZSIQXzLMEoiuwY/uAAcENTg
         n23XxLg7GqiirQ5qARDff/GNkFWT0byJ1N8BxyVhTpc7jr/v6E4Izgf/S7Mw3ktPbcLW
         KmHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704918752; x=1705523552;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xH5jTr5aU0xfloUoZ4e4ojWO1uQm4oQS8ylJSBoL6uQ=;
        b=DUoch9ADfzdXb/5g/OUEwV1m426hk3x+NTJZcpCt5UfOHMFYf10dndpiq1eeSoOJ2s
         HmbMeegCS8GEK1ooGKh1pcluUMezrO5cFJK4S/iMSUvMjiT7dQuD3P44RwJzlddxndVd
         1L/HePeiI0PSvqRQq1+qHwO5zg7ji5aspzQAXoGxbpfwtWgR1uk4qidRtgO00yb2z42W
         ePdgP/rnWbrGqtew4dqyJtBUGhFPptPyyVlydgDz0pS9VENdIXBLCpqsUiCxTZkCO68e
         B9vveZtTyESe5oqfnjj0zzOXz3ydQN6Z98CqocxOPU47pXPhQaSY9tgLPymMQ9GrQuVy
         5MgQ==
X-Gm-Message-State: AOJu0YyJLK684qjueW9v+mpoo+/BVNMqQzXA5+f//DnT9yCIJoYc+chB
	TUHcxPrw/rXWJocf2j1Yj75xoGwBOVNr2g==
X-Google-Smtp-Source: AGHT+IHuqat0eKssBubXT+iurOkhZRe56orJMHJGefWABPD4z8mSZqUu5SuIAslg9U0SLC0yT9YsNg==
X-Received: by 2002:a5d:4f03:0:b0:336:7f45:bc0f with SMTP id c3-20020a5d4f03000000b003367f45bc0fmr29434wru.46.1704918752208;
        Wed, 10 Jan 2024 12:32:32 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:3342:1411:3dd8:cb70])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d44d1000000b003377e22ffdcsm2072172wrr.85.2024.01.10.12.32.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 12:32:31 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Will Deacon <will@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Boqun Feng <boqun.feng@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 3/3] gpiolib: pin GPIO devices in place during descriptor lookup
Date: Wed, 10 Jan 2024 21:32:15 +0100
Message-Id: <20240110203215.36396-4-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20240110203215.36396-1-brgl@bgdev.pl>
References: <20240110203215.36396-1-brgl@bgdev.pl>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

There's time between when we locate the relevant descriptor during
lookup and when we actually take the reference to its parent GPIO
device where - if the GPIO device in question is removed - we'll end up
with a dangling pointer to freed memory. Make sure devices cannot be
removed until we hold a new reference to the device.

In order to not overcomplicate the code with locking and unlocking
variants of the same functions, just use the nesting feature of RW
semaphores in gpio_device_find().

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 drivers/gpio/gpiolib.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

diff --git a/drivers/gpio/gpiolib.c b/drivers/gpio/gpiolib.c
index 4c93cf73a826..972f33bc1a72 100644
--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -1114,7 +1114,7 @@ struct gpio_device *gpio_device_find(void *data,
 	 */
 	might_sleep();
 
-	guard(rwsem_read)(&gpio_devices_sem);
+	guard(rwsem_read_nested)(&gpio_devices_sem, SINGLE_DEPTH_NESTING);
 
 	list_for_each_entry(gdev, &gpio_devices, list) {
 		if (gdev->chip && match(gdev->chip, data))
@@ -4134,27 +4134,33 @@ static struct gpio_desc *gpiod_find_and_request(struct device *consumer,
 	struct gpio_desc *desc;
 	int ret;
 
-	desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx, &flags, &lookupflags);
-	if (gpiod_not_found(desc) && platform_lookup_allowed) {
+	scoped_guard(rwsem_read, &gpio_devices_sem) {
+		desc = gpiod_find_by_fwnode(fwnode, consumer, con_id, idx,
+					    &flags, &lookupflags);
+		if (gpiod_not_found(desc) && platform_lookup_allowed) {
+			/*
+			 * Either we are not using DT or ACPI, or their lookup
+			 * did not return a result. In that case, use platform
+			 * lookup as a fallback.
+			 */
+			dev_dbg(consumer,
+				"using lookup tables for GPIO lookup\n");
+			desc = gpiod_find(consumer, con_id, idx, &lookupflags);
+		}
+
+		if (IS_ERR(desc)) {
+			dev_dbg(consumer, "No GPIO consumer %s found\n",
+				con_id);
+			return desc;
+		}
+
 		/*
-		 * Either we are not using DT or ACPI, or their lookup did not
-		 * return a result. In that case, use platform lookup as a
-		 * fallback.
+		 * If a connection label was passed use that, else attempt to
+		 * use the device name as label
 		 */
-		dev_dbg(consumer, "using lookup tables for GPIO lookup\n");
-		desc = gpiod_find(consumer, con_id, idx, &lookupflags);
+		ret = gpiod_request(desc, label);
 	}
 
-	if (IS_ERR(desc)) {
-		dev_dbg(consumer, "No GPIO consumer %s found\n", con_id);
-		return desc;
-	}
-
-	/*
-	 * If a connection label was passed use that, else attempt to use
-	 * the device name as label
-	 */
-	ret = gpiod_request(desc, label);
 	if (ret) {
 		if (!(ret == -EBUSY && flags & GPIOD_FLAGS_BIT_NONEXCLUSIVE))
 			return ERR_PTR(ret);
-- 
2.40.1


