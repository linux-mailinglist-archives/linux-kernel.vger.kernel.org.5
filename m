Return-Path: <linux-kernel+bounces-150553-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9948AA0DC
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 19:13:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 014BD1F215DE
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:13:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A1EE172BBA;
	Thu, 18 Apr 2024 17:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="Fb5EQ6Iz"
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E12516191A
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460414; cv=none; b=tdC1T0e1NI8vnjKGu/YvZlTNlT4Vt+dMWhtwk7qocYlhKQM9gzDfEXDwtGxBswuaRZJ5vnk19nnGKTZS0yA7+w3gbHtHRUEupElJKBRh9xM1ZAa4Un1nQBI+4BahvzXqI2wI+UBUGFP6CAGHtPBUwPONAgPxhTCbzSI9zjFoxXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460414; c=relaxed/simple;
	bh=33bp98M8vYpK0Mw4ItmO5JzHKSDRByKo5z3fyvO13u0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Qh21k+Iou02fHy4UAnvJzhOOw8DESeK9F9nR6ao4DArOMOik80qH4+XOZJJNBUqv7o++rHsGHXW4Fy3oAsV8+rThsdxQXu1JLnoyiTBceKCJiZYdCqURx2E82hvzl5sF7XPhrb0FLSdjhtexYUN5v3bJVHs00rN7fsQPthqpCxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=Fb5EQ6Iz; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-6ecf05fd12fso1109652b3a.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 10:13:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1713460412; x=1714065212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=A9Nrs6OMVDjvu+Fg3bPZe+Mh7T8v2MnPaN+nf5ROhho=;
        b=Fb5EQ6IzXjFVlbjNgxruQEAjMqMxnmnT1A94TiKo0NjzFdYyjfIvvpLzGE8KBPqCkJ
         B9JF+GZhRVD1YrM+V/GSp1+nQw9voXGskKj8C41IThciPF31HrvgFJ/7A48v6XVk9pAM
         pV7zIFcXrBlILXOn7Rru8xJK486djO1FjNXmfbQb9gdBt4+q6m1NO2eo2KXtlLwLFB5I
         vuLP5w8wfC3mDrf5Xj85tal1qwyrhl5i0e3Cf6qWWmdtApb6cTSZOZtQMMwNseN7Gs7j
         La3k0LNWjoRv1ChHYutly5itMD4sg/pz3kIPium8+g5fAKhE4h1oxxpqerwGqFiQ+Irv
         clrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713460412; x=1714065212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=A9Nrs6OMVDjvu+Fg3bPZe+Mh7T8v2MnPaN+nf5ROhho=;
        b=RxdFuDHyRYCiMPWR3/oYOWCir78UUmeAhszBjC6wZnthTRq60N77goc6jcVXdUdXhm
         5jGfDEets/bIKBnqg0y+/PxqkHBCYPqV3UKmns9kGVAYkjpCWhAfeyv+tWkL2V7M9sX+
         Dp5NaiD4JgAAN8eocYetBskhrp0isqtW3dktJHvr39TeyuqEMhKXZVGzKF5FqnJioaeL
         Y4DU8bN5/9UjTyQEWwuclM78iBxmlgWPLEgJwruRRCJdeoKbBRk16TGEi4UH4nSkl8l7
         +tuMjY2TaG2UblE7JK81oBwTEcfQmUd9onScC+fM+u8nDjoGd7yKnSQBn8r2U+dpoW1R
         X5iw==
X-Forwarded-Encrypted: i=1; AJvYcCUp9+dH5nCJeETP+t+U1wQU4yRnX4lCxPfckiOt41cLtDt6wxcrn2AS+B+Kw1iyQhIpp+yTbw/9UtQIsZtfsviZ0X2UGMaJa/9kneBZ
X-Gm-Message-State: AOJu0YzEvrUEahgpWaENH4UlsbwYCjI4LGIxs7mXW3G+V+75yfoFfI6J
	O4j991vTKAALtNhts+8GJiPG+Fd3r8gilCDpv9PH5fwoIULoCXPKTYs1ufrUonc=
X-Google-Smtp-Source: AGHT+IE3tG2/trGJpFefH2yxN5NkujHeRNR5NE563/ig+Y12P+8UXQ55A73e4tXVMSj4aoosn7e2Og==
X-Received: by 2002:a05:6a00:2351:b0:6ed:d68d:948b with SMTP id j17-20020a056a00235100b006edd68d948bmr4688338pfj.2.1713460412286;
        Thu, 18 Apr 2024 10:13:32 -0700 (PDT)
Received: from brgl-uxlite.. ([24.75.208.145])
        by smtp.gmail.com with ESMTPSA id f4-20020a056a0022c400b006ed066ebed4sm1775858pfj.93.2024.04.18.10.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 10:13:31 -0700 (PDT)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.9-rc5
Date: Thu, 18 Apr 2024 19:13:29 +0200
Message-Id: <20240418171329.6542-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Linus,

Please pull the following set of minor fixes for the next RC. Details are
in the signed tag as usual.

Thanks,
Bartosz

The following changes since commit fec50db7033ea478773b159e0e2efb135270e3b7:

  Linux 6.9-rc3 (2024-04-07 13:22:46 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.9-rc5

for you to fetch changes up to 69ffed4b62523bbc85511f150500329d28aba356:

  gpiolib: swnode: Remove wrong header inclusion (2024-04-17 22:48:14 +0200)

----------------------------------------------------------------
gpio fixes for v6.9-rc5

- use -ENOTSUPP consistently in Intel GPIO drivers
- don't include dt-bindings headers in gpio-swnode code
- add missing of device table to gpio-lpc32xx and fix autoloading

----------------------------------------------------------------
Andy Shevchenko (3):
      gpio: wcove: Use -ENOTSUPP consistently
      gpio: crystalcove: Use -ENOTSUPP consistently
      gpiolib: swnode: Remove wrong header inclusion

Bartosz Golaszewski (1):
      Merge tag 'intel-gpio-v6.9-1' of git://git.kernel.org/pub/scm/linux/kernel/git/andy/linux-gpio-intel into gpio/for-current

Krzysztof Kozlowski (1):
      gpio: lpc32xx: fix module autoloading

 drivers/gpio/gpio-crystalcove.c | 2 +-
 drivers/gpio/gpio-lpc32xx.c     | 1 +
 drivers/gpio/gpio-wcove.c       | 2 +-
 include/linux/gpio/property.h   | 1 -
 4 files changed, 3 insertions(+), 3 deletions(-)

