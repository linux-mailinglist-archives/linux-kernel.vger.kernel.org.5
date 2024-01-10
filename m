Return-Path: <linux-kernel+bounces-22735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A59282A251
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:32:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F157E2811E3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2360F4F21F;
	Wed, 10 Jan 2024 20:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="bcCeQTBW"
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05E814F1E0
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:32:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40e4d515c9aso33634135e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:32:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704918751; x=1705523551; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEdTJOXkqBku2qR0TKwyio+JuDhgwS/A5uq4+eCSKZQ=;
        b=bcCeQTBWfoKOlwG0FkwOzeULj1ZofP2hzqB7URHPeBIIsqPM5GO5XT37K125t9WWZl
         FCReJEQzF2BKe4bSGiZfXfq7dW2mU/q3SfCD2zGXDvs9VlzJraJG4Ft2DuilwEDnwzn/
         j9g7NlzP2VDiCwT4tVl1NFgrvm7rHYJVsnMey0gJavvWgLt3yCcHEn4rPFU0i0FVYI3k
         rKcSmJrCZSrhS+TBER8HMpSMjDwz3TQuvln4IJee/sTmn71r4Vz5ZpGwkKt+Dc8+l2kY
         hysjRa0BH1KxRz9Vr6fbv0yWzbExCbYc0aodi1PugV1B6NvzVOw/tPNBxBs6USpSS2HI
         dcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704918751; x=1705523551;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEdTJOXkqBku2qR0TKwyio+JuDhgwS/A5uq4+eCSKZQ=;
        b=sZ2B1JrQiWjULZBZPijGzLGNdgtJgKPAleEMGSRin6/BjKtxVa1dKCQptRfMHya4eE
         gj9Ar6vKeInKrEEwF4hWhtZcfdpTpQ6fWo4UHS7czivZZtbmSsodm9uFFuna/1nh+Etm
         jvmNoB1z7AfZ9+3Pa7hYkJJAA3BRuOSNnEYNac8k5e82EAUT0k1eO9akbR3ylPGWnm6i
         kq+Tz93CIOTtTbFCG632xdYx/45VzsqO8+BGb/1pt6ncb0zJ2t813taUbKGS5PCruFDk
         /AqaKb03a0vMWvyY3hE7+xKycGLDoXgXDdA+NtH/Bsf3xkZxZk+N286myTdydJ7dWVcs
         DjhQ==
X-Gm-Message-State: AOJu0YyxIihmCDwW0604SbAeH+fYmFm5scntR9KYIqHIrsGr7eCTKRrx
	PbRwC9c2bybaChWA6UUYxnJ/5gpuq+V1Fie0qqI8zjaUE58=
X-Google-Smtp-Source: AGHT+IGOWnDjmizlbioxwpOowdqUvcfTZHld35bp2LkmBUxDT+Htv/cWEoB1XeBN+FcoMgHgbEqcWg==
X-Received: by 2002:a05:600c:6c7:b0:40d:9369:697f with SMTP id b7-20020a05600c06c700b0040d9369697fmr904262wmn.144.1704918751227;
        Wed, 10 Jan 2024 12:32:31 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:3342:1411:3dd8:cb70])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d44d1000000b003377e22ffdcsm2072172wrr.85.2024.01.10.12.32.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 12:32:30 -0800 (PST)
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
Subject: [PATCH 2/3] locking/rwsem: provide a lock guard for down_read_nested()
Date: Wed, 10 Jan 2024 21:32:14 +0100
Message-Id: <20240110203215.36396-3-brgl@bgdev.pl>
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

This adds a lock guard for taking an RW semaphore for reading in nested
context. It takes the nesting depth as a second argument.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/rwsem.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/rwsem.h b/include/linux/rwsem.h
index 9c29689ff505..298f5e60d30c 100644
--- a/include/linux/rwsem.h
+++ b/include/linux/rwsem.h
@@ -258,4 +258,10 @@ extern void up_read_non_owner(struct rw_semaphore *sem);
 # define up_read_non_owner(sem)			up_read(sem)
 #endif
 
+DEFINE_LOCK_GUARD_ARGS(rwsem_read_nested,
+		       struct rw_semaphore *,
+		       down_read_nested(_T, subclass),
+		       up_read(_T),
+		       int subclass);
+
 #endif /* _LINUX_RWSEM_H */
-- 
2.40.1


