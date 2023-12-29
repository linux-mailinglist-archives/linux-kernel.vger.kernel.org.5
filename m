Return-Path: <linux-kernel+bounces-13214-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 81D12820136
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 20:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7C49BB21B1D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 19:42:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8136912E72;
	Fri, 29 Dec 2023 19:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="x152BwaC"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965B912E57
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-40d3352b525so80137185e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 11:42:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703878943; x=1704483743; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NgntDhYc8DJ9nZgWa+zaEF/5fvlN1hFZrs4j0lTtCX0=;
        b=x152BwaCWjrKdjQqknTosRC/KuGu/4XfknemxDw1n6TGVv6aA26i59Sj6W3ju3bQEk
         H/yKafM8AlsTd9eFMiAOnQRLKLoPy6QYYbMAWnGl65+u8j3O31rIfa0nXTt4KK5BAPY5
         bQDFGLXHh08O8Trco6nGobEcB+mrD8uLojFfzxKQQdjKRGYqJWwp2SxUSKCexEyFpJ+v
         sIUwOdYU2Ae5XMsAPfiYMXJXyHcAiNmatYyy+bldXcIvupnpQ3T1sLpFjW7o2fwsebN/
         RdywfSPV5okaUs6j5sWM9Po4NU2qQ890MMgtMUXDoxg7xv8Jt1ykSb87JTsQoHFOuFu0
         8zsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703878943; x=1704483743;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NgntDhYc8DJ9nZgWa+zaEF/5fvlN1hFZrs4j0lTtCX0=;
        b=n/q/NCYoDkjkeonHlcabIourQfARd4q2NiS+6PmB4vO3/Y6DNbex39vxyQCkTTSPwV
         8LE6v18DqAgmgtwZauzUWeFJFzZgwnIVKUmGzJ78u+6JYgkRfC2uDO6NRKFnXczfFod7
         +jV8mh2mOIfqvyPVNBiaBENyF9JVZyXxb2F7/qX3/jzKqwxI7zcbJKdl3orXpsz4e+Ge
         bB5FGWXVRxeWxzt6LcPHhrC2+ELnLkiG1U6D3alMqrGidZUg6Kr0Tkr4g4nLAIqyy/jg
         LluMarX5MZZtpeVrTsZtyljPqNFkWsrcy0ZU/Gj4SpwB7AV1Be4fg4LAJtE7DMOvBvkl
         1b5Q==
X-Gm-Message-State: AOJu0Yzyr8nYTlO+BTBlc8UaHqrf67RpMIzQuOzTyKOKdNat/dQDCZg6
	dxt7PRoJnpU4hCWX4BFSd6GF6w2GZFkWvQ==
X-Google-Smtp-Source: AGHT+IHF7I910HNtMADesG+78goQVzXaVQF/TyfVSc1zofDnf2jnbSKyluUBwBhEs85INla9jRNc4g==
X-Received: by 2002:a05:600c:45cf:b0:40d:5ccd:4f93 with SMTP id s15-20020a05600c45cf00b0040d5ccd4f93mr2230387wmo.94.1703878942597;
        Fri, 29 Dec 2023 11:42:22 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:b37:e8fb:2482:e47])
        by smtp.gmail.com with ESMTPSA id h9-20020a05600c350900b0040d5aca25f1sm13038779wmq.17.2023.12.29.11.42.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Dec 2023 11:42:22 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.7-rc8
Date: Fri, 29 Dec 2023 20:42:09 +0100
Message-Id: <20231229194209.13630-1-brgl@bgdev.pl>
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

Here is a set of updates to the MAINTAINERS file, please pull for
the upcoming RC.

Thanks,
Bartosz Golaszewski

The following changes since commit 861deac3b092f37b2c5e6871732f3e11486f7082:

  Linux 6.7-rc7 (2023-12-23 16:25:56 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.7-rc8

for you to fetch changes up to ad5575eb6278892aa25a5d249c5009860d6d8bbc:

  MAINTAINERS: Add a missing file to the INTEL GPIO section (2023-12-27 15:55:44 +0100)

----------------------------------------------------------------
gpio fixes for v6.7-rc8

- Andy steps down as GPIO reviewer
- Kent becomes a reviewer for GPIO uAPI
- add missing intel file to the relevant MAINTAINERS section

----------------------------------------------------------------
Andy Shevchenko (2):
      MAINTAINERS: Remove Andy from GPIO maintainers
      MAINTAINERS: Add a missing file to the INTEL GPIO section

Bartosz Golaszewski (1):
      MAINTAINERS: split out the uAPI into a new section

 MAINTAINERS | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

