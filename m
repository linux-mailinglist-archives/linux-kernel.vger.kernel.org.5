Return-Path: <linux-kernel+bounces-9577-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C111481C7D1
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 11:07:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B1551F2548F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:07:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDB3612E6A;
	Fri, 22 Dec 2023 10:07:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="WmfCGPet"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500D512E67
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 10:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33680da01d6so1456677f8f.2
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 02:07:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1703239654; x=1703844454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R3Ni6JDHfkUKX85I2WqvXDeMrdLSOpMWqWxRpZZhE5M=;
        b=WmfCGPetNigN7dytELQHBCHXEBx5/gjQpP12b4YOydlNOJkw7Q4PF0hjPGXYJr767S
         KpVKa3HSmFXanGK2beXtSzu9CjJ0qu3MXK/4Ekn9cR+3WXK6U+3wxkEI/VpS9jQ2aJOP
         g6WbqQMLopsdKd9j2SK6bVr+uL9db3W86rbjwUxQZAUPC7BUN4k264k34xjFIOVodvZW
         yWlKNR8SGqwf1rtQaqgCdbTv4zxRl6s1Zi08o8fAYSy7b42Ang8SW3lvhVNcFMbrs/bJ
         Jz9uApW/Bi7lgZKZcH4T6Mq8fHE8fDVuSOWkwbMHwsIIIHAro60u5gBjDM0tDm2+0ip7
         FtBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703239654; x=1703844454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R3Ni6JDHfkUKX85I2WqvXDeMrdLSOpMWqWxRpZZhE5M=;
        b=wAAQdGFRUdAWPXN8xWJ4+/VtWt7AClB9Gu5sP9TnkDSYJtKKTs7v2Uv3aqi65rS0xj
         vSTuvAkNwJIBWyGRhhyv6NhSC2vKV4G8y9iFyxUQi4cWT+mqz0GflQLnha7PkHdwoA8s
         Jh0In0iS0JIr90pNSJOH0dRuD+i0A7N/8FHO/iCH8zUsVUmzwLNjocW7UDo+4MhkhZ9g
         F9KCWj34/q5ARBwMNOIfGwrShLUpnI1XN2zmlmvp7Xqhs6G2Lya8KQ/HsY3yI5supCQ0
         Njak+sB88jOk2ef1kTVN1Y0SKgbr6i/WQvdFcktoVd5kjQHhYIHxRoznOozimgQ9PEub
         jWZg==
X-Gm-Message-State: AOJu0Yz1rR+r/ho36JQ+cCV78HHFzhU752cOMOXLsdPW7cRRpr5QViR/
	8dgoTTvBVMWOy/4GC6XGOqu4oHpI7uj3rA==
X-Google-Smtp-Source: AGHT+IHg4DhpWsvkR0NQTP523SPeDz3h85vAMuW6nKpNq6t0WwXlhdQoLoY6kRPilwKp37KqAEa5Qw==
X-Received: by 2002:a5d:5092:0:b0:336:618b:5d2c with SMTP id a18-20020a5d5092000000b00336618b5d2cmr663690wrt.66.1703239654408;
        Fri, 22 Dec 2023 02:07:34 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:8792:dee:938e:1ecc])
        by smtp.gmail.com with ESMTPSA id q17-20020adfcd91000000b003362d0eefd3sm3903969wrj.20.2023.12.22.02.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 02:07:34 -0800 (PST)
From: Bartosz Golaszewski <brgl@bgdev.pl>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	linux-gpio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [GIT PULL] gpio: fixes for v6.7-rc7
Date: Fri, 22 Dec 2023 11:07:31 +0100
Message-Id: <20231222100731.10294-1-brgl@bgdev.pl>
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

Here's another round of fixes from the GPIO subsystem for this release cycle.

There's one commit adding synchronization to an ioctl() we overlooked
previously and another synchronization changeset for one of the drivers.
Details are in the signed tag.

Please pull,
Bartosz Golaszewski

The following changes since commit ceb6a6f023fd3e8b07761ed900352ef574010bcb:

  Linux 6.7-rc6 (2023-12-17 15:19:28 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git tags/gpio-fixes-for-v6.7-rc7

for you to fetch changes up to 1cc3542c76acb5f59001e3e562eba672f1983355:

  gpio: dwapb: mask/unmask IRQ when disable/enale it (2023-12-21 11:19:01 +0100)

----------------------------------------------------------------
gpio fixes for v6.7-rc7

- add protection against GPIO device removal to an overlooked ioctl()
- synchronize the interrupt mask register manually in gpio-dwapb

----------------------------------------------------------------
Kent Gibson (1):
      gpiolib: cdev: add gpio_device locking wrapper around gpio_ioctl()

xiongxin (1):
      gpio: dwapb: mask/unmask IRQ when disable/enale it

 drivers/gpio/gpio-dwapb.c   | 12 ++++++++----
 drivers/gpio/gpiolib-cdev.c | 16 ++++++++++++----
 2 files changed, 20 insertions(+), 8 deletions(-)

