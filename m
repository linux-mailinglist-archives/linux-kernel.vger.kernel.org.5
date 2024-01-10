Return-Path: <linux-kernel+bounces-22733-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1F0B82A24E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:32:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F4101F229AF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B754EB32;
	Wed, 10 Jan 2024 20:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Vs9z/HE+"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80A84F1F8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-33678156e27so4083817f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:32:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704918750; x=1705523550; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S4/ezTEXd/AGBE5ik3GQsGbwKaC7ixzvP0QmPnIVxHs=;
        b=Vs9z/HE+Iml7oygN16KpVcLUD5nh3xPNOH4zCK/oqxz+gbqVU9g1d2F/JZLszjYYet
         xiPC99nhFAcUDyq5M0+3zmH3LbTUDGkaZZPukzeWY+vcLskJxvC5b/YfX+3NXqOKLFBS
         JHk3jvW/XGam28Fz6YY0V9GCah8zB4QDBgCI/gqaBvwtlqVtgCAU3i8LinYCIBtdP3Gy
         L22NFuyW6CPCi/0mOwH92amTrcjiqQUq2IBzFxVQVpfn1yVrRJ9SsDPIcGThMI13qZZN
         +3ZWz6xNuz7N3ctV8xbOeAGJiL2nMLXBQbUpvjOLFxjYwvy08qt8BcYIwwWkqmOl5o4U
         zxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704918750; x=1705523550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=S4/ezTEXd/AGBE5ik3GQsGbwKaC7ixzvP0QmPnIVxHs=;
        b=XOGbmdega2BizlWoqLi9R9FuwDNS8U1ZD2KU8+LsKj+lx6NWksIGOuEtlS3s1FNg/b
         kChsHQPx/duL4ngjA5SxJU+avpl279cV1oKupJPAUFAi/PmUfc2t0A/odxzac7dZ88Vo
         XJwQwmtvjZHVbwJAewc03b3jBSheXAahoEprCS96qLRRMGApy+6tYSTCEjSE+HUSs5Z0
         8bgJCx/fgU0B0N1fPezZCMndjFZPDJuEFMFYY995uY/wV/Q7BQc5yCe+m+5/HiZ/2ULq
         vW602tGfDGHbtM64ZUBfVSI1sNgintl+O10Kw914yt8Fxbp8rfqezce1g0R6ehhvDgnO
         UN0A==
X-Gm-Message-State: AOJu0YwWnVgxDr7Zqi4PoMlwOsLZ/5UZbXtfdwzVZXzYh3zVpRRXGWaO
	NwQgGHR0suR3OCoAVHZBlQrsbvlfDk0QWw==
X-Google-Smtp-Source: AGHT+IG+Jh12VyGYmoVwBM+LMkw8YhuNMET4WndcS7w4Xu8ew7js3y1dau1a7gKopoa/qzRbjPgQ4w==
X-Received: by 2002:a05:6000:372:b0:337:4758:43ef with SMTP id f18-20020a056000037200b00337475843efmr29206wrf.66.1704918750199;
        Wed, 10 Jan 2024 12:32:30 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:3342:1411:3dd8:cb70])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d44d1000000b003377e22ffdcsm2072172wrr.85.2024.01.10.12.32.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 12:32:29 -0800 (PST)
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
Subject: [PATCH 1/3] cleanup: provide DEFINE_LOCK_GUARD_ARGS()
Date: Wed, 10 Jan 2024 21:32:13 +0100
Message-Id: <20240110203215.36396-2-brgl@bgdev.pl>
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

This macro allows defining lock guard with additional arguments that
can be passed to the locking function. This is useful for implementing
guards for nested locking.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
---
 include/linux/cleanup.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/cleanup.h b/include/linux/cleanup.h
index c2d09bc4f976..921db45023bb 100644
--- a/include/linux/cleanup.h
+++ b/include/linux/cleanup.h
@@ -246,5 +246,11 @@ __DEFINE_LOCK_GUARD_0(_name, _lock)
 	static inline void * class_##_name##_ext##_lock_ptr(class_##_name##_t *_T) \
 	{ return class_##_name##_lock_ptr(_T); }
 
+/*
+ * Helper for implementing guard locks with additional arguments passed to
+ * the locking function.
+ */
+#define DEFINE_LOCK_GUARD_ARGS(_name, _type, _lock, _unlock, _args...)	\
+DEFINE_CLASS(_name, _type, _unlock, ({ _lock; _T; }), _type _T, _args)
 
 #endif /* __LINUX_GUARDS_H */
-- 
2.40.1


