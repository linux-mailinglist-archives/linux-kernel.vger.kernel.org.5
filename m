Return-Path: <linux-kernel+bounces-1234-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8893E814C21
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 16:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44B492819BB
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 15:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B647B39FC3;
	Fri, 15 Dec 2023 15:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="yA2GZjEL"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B00AE374C4
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 15:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-40c38de1ee4so7876855e9.0
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 07:53:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1702655585; x=1703260385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9SEVXozYauGChgmPl7/rsMQixOhRmREeWdQCs6iv/QU=;
        b=yA2GZjELHXyNoUXVkdb1EdJeuXUYukm+e+Oe5h7tCIRPSPdLLeDQ++Rv+l7SX0koJI
         PFa5s2E41uC3qZrPazpmGJC/5SXvglVCxpUYSDnBkPjESaMNEs6Doqqz0Lp7LCOxxu44
         emKDLOg0DParHvUjMsg7huwVFtM53cvAZ72BCLpf6CmukdY0ASpw7yK0SCSNJ6ZV15TX
         T/hcLzz7lpXM2Yh2DHucmL8AZv6a9LDDwJ2nEYabVEd2WZm7w2ARbQypbDYvmtLocp4K
         a4BZiYD+5/pCMPbRvqt1cUFHxka14CE6+axH0ALtEAf0bFuYQ8hvsEeUtj6xbzYbf43V
         FpxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702655585; x=1703260385;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9SEVXozYauGChgmPl7/rsMQixOhRmREeWdQCs6iv/QU=;
        b=ma796/3pMsxuUyhn7/PwydG6gmbdmV3EhX9uF4gJFy2lpKRksIdi74AERmOKqtlyQS
         IaITgy0F7swoF/uiYavE972QcwiOZw3xW6kO5t8ltxxVtOv/0mFMjbNxCfe5/36YKiil
         S3rET0kHeyD7bEZyD2ib3KpF9WfoGGgWi5Z2qcjeVDF3EVT5umqXyJUaHtw2nLGt/XL7
         4/5yVIEumkB/c1zKn6h4rAzFVK9pKwY8lah5rKCQCc7W5AVcERDm+64n3HawIVU0dJba
         2336M3eftjpm2JyvUrMTerTzaipeJU6TwzttOZdXJsn0+Zgm+LQAuX7mju7SDh+ZNDnw
         aWiw==
X-Gm-Message-State: AOJu0YwbMBsC0apoG3KLqnAtNbdDU5f+3PxFAA+r98Q4sZjdeTtxFv7r
	e/eXewBBS0k8qCXd5sW1Ys0zjA==
X-Google-Smtp-Source: AGHT+IGT/5FpT7pHlasAIjd1gJ5G7715ZjbK3QgLJydxudckxAC92r+cDSoltGqOTjTbocQ/HwE40A==
X-Received: by 2002:a05:600c:1e23:b0:40c:6c74:2382 with SMTP id ay35-20020a05600c1e2300b0040c6c742382mr527296wmb.105.1702655584835;
        Fri, 15 Dec 2023 07:53:04 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8672:e2c5:37d9:3743])
        by smtp.gmail.com with ESMTPSA id bg22-20020a05600c3c9600b0040c6ab53cd2sm3110484wmb.10.2023.12.15.07.53.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 07:53:04 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Walleij <linus.walleij@linaro.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Kent Gibson <warthog618@gmail.com>
Cc: linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v3 0/2] gpiolib: protect the list of GPIO devices with a mutex
Date: Fri, 15 Dec 2023 16:52:58 +0100
Message-Id: <20231215155300.21186-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

I figured that - since the descriptor locking is going to take some more
time - we should at least start the conversion and protect the GPIO
device list with a mutex.

v2 -> v3:
- move the new sysfs function into gpiolib-sysfs.c

v1 -> v2:
- add a patch renaming two functions
- protect the list in gpio_device_find() too
- coding style tweaks

Bartosz Golaszewski (2):
  gpiolib: rename static functions that are called with the lock taken
  gpiolib: use a mutex to protect the list of GPIO devices

 drivers/gpio/gpiolib-sysfs.c |  45 +++++------
 drivers/gpio/gpiolib-sysfs.h |   6 ++
 drivers/gpio/gpiolib.c       | 143 ++++++++++++++++-------------------
 drivers/gpio/gpiolib.h       |   2 +
 4 files changed, 93 insertions(+), 103 deletions(-)

-- 
2.40.1


