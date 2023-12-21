Return-Path: <linux-kernel+bounces-7718-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8D1F81AC17
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 02:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7F1A82875B0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 01:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6004817E9;
	Thu, 21 Dec 2023 01:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RXUdcbAj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71E054404;
	Thu, 21 Dec 2023 01:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6d9338bc11fso287241b3a.1;
        Wed, 20 Dec 2023 17:20:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1703121657; x=1703726457; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oEv+hdHh4Z2txdpbzpok/LPO5P0UTDSHNAO1ulhD6LQ=;
        b=RXUdcbAjyMLJrIslWnW3NDObskwMFO81FIlnCKMazmjI9OvBZhJDI4LPc9aU6kHD4c
         a8Y/GmxKF/qeBGI4zQxoOZ3aD1nboUVV3zSXV+QUA2acGbeCRD2/kvekWG/njmM9dZCT
         JOGe9pumXuBPaCuM4yHh0Eu5I5zOzElJx8A2MCgtoYMY7FYO8Ok2ZnqBw+hxJm9fl8mW
         tScoY56OMZEQril78nqsX2eaCu7uNeGyo+cPQHwjAhPqg2sYVwb2LOfVm0d+wqLISPAr
         Dmt9eicuey34BXJRGPUNKK6HpAJ+oez4na8t444MABmcZ2VgmrHcqUFILKhRnCnPo2Z+
         V8ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703121657; x=1703726457;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oEv+hdHh4Z2txdpbzpok/LPO5P0UTDSHNAO1ulhD6LQ=;
        b=Xcdjbg9BwW0wnCU5YPYEupVrVpzAeZ+EV7AQCqx3r46FZBV0vewaIhXEModyMFJIvi
         vic3RILpFF+vGcjn07t2jml9YUO5EnbXHG2JddepltgqFOElYrG0VP0sCf/puNnFj0tx
         +PlsiXBunAUxrHu1LqjEyWViHMQWirpHbm5qBkiu1hkPrhwLXBOunEN0LDvfcrBTbu/E
         SGayCAJ5apKyjbe2OzEwpVG9gMGcoInLhBvYWNBeauAhB6k/83zDPxZEMJd/2vGbKDOw
         n3eoTKxsT45LNQrcWR+qmxfvCRfFelmI+CQ0Qnqkdfu/q2dmmy5zGT7k6KdaQbaEH2Gf
         8JQg==
X-Gm-Message-State: AOJu0YzoU/sW5NOOK9MkTjeFmeEud730nZYv//el+kjKQonpOPtlGZtY
	ga3YaukWfb2v1jz+W/L5JKunWYi/pOM=
X-Google-Smtp-Source: AGHT+IEUQPpPOxhc6gUsDu12VItJqcur2P1kZv1vKKKYleFUep88LfiX1NcXB00Apxiwi5m9nRKDsA==
X-Received: by 2002:a05:6a20:12d4:b0:194:dee3:3120 with SMTP id v20-20020a056a2012d400b00194dee33120mr821411pzg.94.1703121657564;
        Wed, 20 Dec 2023 17:20:57 -0800 (PST)
Received: from rigel.home.arpa (60-241-235-125.tpgi.com.au. [60.241.235.125])
        by smtp.gmail.com with ESMTPSA id x1-20020a056a00270100b006d088356541sm375959pfv.104.2023.12.20.17.20.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 17:20:57 -0800 (PST)
From: Kent Gibson <warthog618@gmail.com>
To: linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	brgl@bgdev.pl,
	linus.walleij@linaro.org,
	andy@kernel.org
Cc: Kent Gibson <warthog618@gmail.com>
Subject: [PATCH v2 0/5] gpiolib: cdev: guard tidying
Date: Thu, 21 Dec 2023 09:20:35 +0800
Message-Id: <20231221012040.17763-1-warthog618@gmail.com>
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

The first patch is a fix to protect gpio_ioctl() from having the
gpio chip removed while the ioctl is in progress.

The next couple of patches are minor fixes inspired by recent
submissions and reviews for gpiolib.c.

Patch 2 adds a missing include.

Patch 3 switches allocation of struct linereq from kzalloc() to
kvzalloc() as it can be larger than one page - even more so after the
recent relocation of debounce_period_us.

The final two patches replace wrapper functions with guards.

Patch 4 tidies up the functions that use a guard on the linereq
config_mutex.

Patch 5 tidies up the functions that use a guard on the gpio_device.

Changes v1 -> v2:
 - add patch 1 to protect gpio_ioctl() from chip removal
 - improve commit comment (patch 3)
 - use guard(rwsem_read) rather than rolling our own (patch 5)

Cheers,
Kent.

Kent Gibson (5):
  gpiolib: cdev: add gpio_device locking wrapper around gpio_ioctl()
  gpiolib: cdev: include overflow.h
  gpiolib: cdev: allocate linereq using kvzalloc()
  gpiolib: cdev: replace locking wrappers for config_mutex with guards
  gpiolib: cdev: replace locking wrappers for gpio_device with guards

 drivers/gpio/gpiolib-cdev.c | 257 ++++++++++--------------------------
 1 file changed, 70 insertions(+), 187 deletions(-)

--
2.39.2


