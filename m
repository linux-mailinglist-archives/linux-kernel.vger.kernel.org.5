Return-Path: <linux-kernel+bounces-63198-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A4AF0852C3D
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 10:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4BDAC1F23909
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Feb 2024 09:31:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18658224D5;
	Tue, 13 Feb 2024 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="2ux5irU2"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 077CB2230C
	for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 09:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707816675; cv=none; b=L/pS5GEVNeDq4p+AK+8K0kgMWDyEd4duLuIaaDhDmy6agdcZzC1i2Dlh+N0Dv8jbFThm/5JnIO7A7/H6vssGWNApzKGyMy5ajVUDiGEIO/mW+eoxn0hHsOwhjBBNH8hMObhwx3SwW4tUzo0YNsDMmqqaNpe/LZGcbVsTDuNEHWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707816675; c=relaxed/simple;
	bh=34ghv65tX01VnUZyJ9HjaQTEN9as/t/Pt7zLckOf0g8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oShkyJ+IDLvQ0y0UzRJuk82z2bzRG3/5gxw5ibjzATcw9x59UlNXoeZWSgNhQSkUrKCRAxCOjzEB2QaMbEAIhoAwhBSrzjQ+7I6GRIdm/2hJlxXsMnW4h4lYDvyLJIHOd5+9VhDx12loH/EsJbKV2osVFWsfwZelboNZCbstqs0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=2ux5irU2; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-410ca9e851bso13993395e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Feb 2024 01:31:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1707816671; x=1708421471; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XO2K1jFKhfKBm39xDO4kMzNEQW0DrH5Tam/IhQbNI0g=;
        b=2ux5irU2OzIGmy6A+4QdgV6NL5nC1ntPufxOQog2qx41Xpsh/AnD+CwEqizSD1Tu1B
         cJLO7ackFqKqDAG6Xxt7KJ/eE4wuQ/yg0qaqqUFP18fGnCbfR7r5HNY/2KJueHCZDCWV
         V8mSeogS1JQJ+IXKpaAFvDzUMCVSiCt9Lmi1bCprQQenagU9zVZyZjY0gSJ7DgTwhfZY
         5Z6HvCUezekwlbAYWeGerFX6hkgOkp+Wt9EZG8uTrqsNBDKNKr+S7fDCKjqyii8OXTD8
         3kk2Sg3WPw+yB4dMt0lE4sSR1DDXJ/HHBruQ8neuliQgmX0/SRfQd+3RjjR9UquN2VxU
         +HRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707816671; x=1708421471;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XO2K1jFKhfKBm39xDO4kMzNEQW0DrH5Tam/IhQbNI0g=;
        b=Yk4JZoQyeVzfzFTGuu3WooF1w5Njx6UaENJ4vrGHPAlC/NK8Bwte5w0aq3N2QzBaL3
         ESVCLHzyEbLRuMIjQ93dH5FLCJ7cVM69BJF78UE1ny5F1Ib+XgL7iyUPSLTSJq6/JUGl
         m1Or0xw04m76hxnqTSGHvjmqr5B3tpswtkoXqeyDMg+WJrfQDDFCouG0tA4wcjj3PyOP
         U57Pe0bpNlbuTW73DqavvKUjKk+VNlXFzZ2d/3Y10sBAWLhpFqD9X3HAjqXGgNAEp3TT
         ATiH2EamDkPmf4C2lLe8V3o017XMHFFqe6K9FXHV65pG8kAfLjl5SRoCmmBDlXXfGB1J
         lCJQ==
X-Forwarded-Encrypted: i=1; AJvYcCVPbTOTAKmGPXGUtocUtlh+9TjNK/HapjNIoUx/31yUucOlhGOnyyPGPXYb36H8HApVf6hKHXiPAvjWTuNzVRYaxBN/Q3aDUQZJOhiB
X-Gm-Message-State: AOJu0YylGUi1an++ETdANlFPVDOkEnA9LN6vFbVtxX06IncCIXQE606W
	6YdPW2XgaZX+3WzjT5EeMu0CbMYkRZyv/5ohFpTL/j8ZcGfJz+zyj5naU3Mo1CvJaGo5Hp+4AFV
	B
X-Google-Smtp-Source: AGHT+IGa8HG0pjhyJFF0NNhKEiWnY7s09LgDrEFjD9McGCysp+GPat0YeIIq5taZ0wqc8AS2LPdoQw==
X-Received: by 2002:adf:ef4c:0:b0:33b:4aeb:82f0 with SMTP id c12-20020adfef4c000000b0033b4aeb82f0mr6678179wrp.49.1707816671160;
        Tue, 13 Feb 2024 01:31:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW9YFy+pSQkDsUJRsKwWplxwHNE6vtS9EZMiQtxiKDwYCLt2+Rij8l2aCNWY0MuonMv1nguXi8LyS/9uz1FVmDOcOsZMeStpOulk6DP+aUeqUMCdHWi7Ko6nfYBT/2QMJqGGExOxd8cLJNhlt7UMp1ERBTnBzUxMctnJpYSI22KpehFJ/wZJiWzRh1mJrQWNConmKDE9nBseZGD6w9O5F2g7WCBgsidLTd6VrzDPvj9F6lZS1XZbXzbYeh5wzVdRWCCn5wBjpUMdUxrbA3zZiq5+PPaZLkhGB6Cvw9yGcrIaNgdu9l3Lwq2lJG7MHFHDy3vxo5NfM5r
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:f634:2e37:58a9:242a])
        by smtp.gmail.com with ESMTPSA id p16-20020adfcc90000000b0033b2497fdaesm8980897wrj.95.2024.02.13.01.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:31:10 -0800 (PST)
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
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH 0/3] gpio: fix SRCU bugs
Date: Tue, 13 Feb 2024 10:31:05 +0100
Message-Id: <20240213093108.13922-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

Here are three fixes to some bugs in recent SRCU changes. The first one fixes
an actual race condition. The other two just make lockdep happy.

Bartosz Golaszewski (3):
  gpio: take the SRCU read lock in gpiod_hog()
  gpio: cdev: use correct pointer accessors with SRCU
  gpio: use rcu_dereference_protected() to make lockdep happy

 drivers/gpio/gpiolib-cdev.c | 25 ++++++++++++-------------
 drivers/gpio/gpiolib.c      | 23 +++++++++++++++--------
 drivers/gpio/gpiolib.h      |  4 +++-
 3 files changed, 30 insertions(+), 22 deletions(-)

-- 
2.40.1


