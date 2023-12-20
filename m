Return-Path: <linux-kernel+bounces-6266-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D683181968A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 02:51:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9358D288ADB
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 01:51:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 865647495;
	Wed, 20 Dec 2023 01:51:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AFLGyrur"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 944BEEAC9;
	Wed, 20 Dec 2023 01:51:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ba2dd905f9so3448586b6e.2;
        Tue, 19 Dec 2023 17:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703037082; x=1703641882; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=W2rAgpDBZW7ef2pt8PKnHiTbIJVIFNinygdxFgXy9i8=;
        b=AFLGyrurjnkurSm17auE/cuq+J3fik+5bObr4KGxpa7NQ/NaRDvCnpOfrHIBVLK8CS
         lYJCFhRSEWcVswN5DL+0PTfq6ibruU7gKnr9zrf6MeTUhFkFCtDnLRykdpVX4+kJPDEP
         kTRLKZg21uUag6c2rsP4sE0lEOrOh9bc65QqQkOVfPbuLIiKm7VSNtBsplcIhUFYuibC
         Nyrxc9RwuhLHO5KwuU6IZIwxTADr9XVP2smhHGba8IaNc1llMNP2dse/TCvG2ebNchPk
         kSBgfa3lQ6BYGQO0+yCgfQAXwTzM2FKUM7A+62/X8ylz3FbJcGIslrWGnLEM6Xb7KQ1o
         Uz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703037082; x=1703641882;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=W2rAgpDBZW7ef2pt8PKnHiTbIJVIFNinygdxFgXy9i8=;
        b=IcMFSka0SX/tFTflFHV485QqYMwCTOQ7JXqNKjfuD0CZVZHtVju3vdaMUvjOOx6l/w
         l3k6fPfwjLmOQmZr2q1vkh82cNS611khxPP8UoIwnFskApHuGod1zefQIb5SCm1eBoLr
         vVQa4Ivp8VyxhqpoM3R7rITQiaYACvOP4BzYd0gCRc6g5nNH2//e5PYzjKFPvwQF+KrB
         8GHjmM4PSLCPIm5AjV9m4kJ/gvC9HWevYGch2nTfkOG/v2kVvOp7yCsoULx0+VjICI4P
         A8FshWj5NQtHcO/01profXg2nG5l/BtZr9mkuChQdTKkg2DGWl7EBQSFFaYA2Ac8VhsY
         fCxg==
X-Gm-Message-State: AOJu0YwGrrt7JrPRemlAnrHAHrVVLuVmyJg2TatsmkXo9nLTFq50W2L/
	R3FBetdJN49BwkIwNk7kwPsxCrHUL18=
X-Google-Smtp-Source: AGHT+IF5ZTRPhqwHtDhX6KNuK+h5j0f08BUey34XeUSHIx7BF6egxmXI1kUFKWu7mTVPltI/zyeSGA==
X-Received: by 2002:a05:6808:1a16:b0:3bb:634f:66ed with SMTP id bk22-20020a0568081a1600b003bb634f66edmr2139784oib.11.1703037082448;
        Tue, 19 Dec 2023 17:51:22 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id c17-20020a631c51000000b005b92e60cf57sm20133208pgm.56.2023.12.19.17.51.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Dec 2023 17:51:22 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH 0/4] gpiolib: cdev: guard tidying
Date: Wed, 20 Dec 2023 09:51:02 +0800
Message-Id: <20231220015106.16732-1-warthog618@gmail.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains some tidying up of gpiolib-cdev following the
recent adoption of guard().

The first couple of patches are minor fixes inspired by recent
submissions and reviews for gpiolib.c.

Patch 1 adds a missing include.

Patch 2 switches allocation of struct linereq from kzalloc() to
kvzalloc() as it can be larger than one page - even more so after the
recent relocation of debounce_period_us.

Patch 3 tidies up the functions that use a guard on the linereq
config_mutex.

Patch 4 tidies up the functions that use a guard on the gpio_device.
The new guard macro definitions probably should be relocated into
gpiolib.h, and I'll do that for v2 if there is a general consensus.

I also note that gpio_ioctl() is NOT covered by a guard to inhibit
removal of the gpio_device.  This looks like a bug to me, unless there
is some higher level locking at play that I am unaware of?

Cheers,
Kent.

Kent Gibson (4):
  gpiolib: cdev: include overflow.h
  gpiolib: cdev: allocate linereq using kvzalloc()
  gpiolib: cdev: replace locking wrappers for config_mutex with guards
  gpiolib: cdev: replace locking wrappers for gpio_device with guards

 drivers/gpio/gpiolib-cdev.c | 263 +++++++++++-------------------------
 1 file changed, 79 insertions(+), 184 deletions(-)

--
2.39.2


