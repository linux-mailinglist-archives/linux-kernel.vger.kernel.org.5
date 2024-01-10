Return-Path: <linux-kernel+bounces-22734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E765F82A24F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 21:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 657FB28150D
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 20:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79DD94F202;
	Wed, 10 Jan 2024 20:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="x5lqeK78"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C80D74F1FC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 20:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3367a304091so4153923f8f.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 12:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1704918749; x=1705523549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kAR7sQe+9uIUlc3/sGosHcCLBOUynvhpMFaU2ttSVZw=;
        b=x5lqeK78fk5wdZIToWldz//7rt3m8VJDkYgYfQ/8BKqgYRiWv7PDzxxExs2VskhEkr
         bGMEzOHjf2RYREVlINjdDbENbmzhorEfUxi6AYR4SG6Twg0tSNj1To91L1OnHM+9/D2o
         5oqRXxlJiBfxaz1R10O6pt/S5cdmc392xmRuunZrmcZ9OE9Vfv3RrnOyc9rjKOeLUALf
         p8KUJCEEcv3IwDtpA2oDS4HP2+vzkU6IgSxEPutcNBv2XSXU/MkejVikNONuWzp8sp5P
         nmFqGSjPOZLI4d8gNMQA/xchhp6e5GQtlSLqP7CVLfezqfE2OA+xG0Eat8GprkKRaZlx
         9g0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704918749; x=1705523549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kAR7sQe+9uIUlc3/sGosHcCLBOUynvhpMFaU2ttSVZw=;
        b=HkX8AmwnBHrHjmfPcAhD5ZMEbI4cY/+TM23M0jwLoRTNMdJM6NI8whqNc6qBw7Ltag
         aa2wu2rV051K9lXygAcVigGIDIYGKfrLNpsd8ZkABaI76uA5LI9xVhVfE6Dh4dqbfw04
         Sttb7uFgCQbo9shvwQcercScIY1ss9/s99mJrmPU7QOjyhtN/qjTYFDCk+katl9p/LNI
         nS1KLwLVaTw2gI+DQ/UHaZIRITcSWjH4Cd+1oUNuiG4mOcpE8FqBjNLOyIPb8iBP6mKb
         CbRy/xzkVy058O0MDQewR/q9YcfFuNvKQaNYqNi/VVDgZ6nuErdZngOYmdVYBMnbGXhY
         8+xw==
X-Gm-Message-State: AOJu0YwnaYfNw9RUVKMMKu9R3FowzYZX5Hz8V0b5t15GFhF1C/hthSv6
	potHaSpVH2Vy7wQ7/hw/oyAbLEg6J2VqLg==
X-Google-Smtp-Source: AGHT+IGwv+IraV+RU+JS8ht4ZNNO+LXohJmmgWlIrFeCq4zJhnXW1QyZkOEU7FBHeQrSq4EJCphGNw==
X-Received: by 2002:a5d:5a1b:0:b0:337:4e98:79d6 with SMTP id bq27-20020a5d5a1b000000b003374e9879d6mr28018wrb.112.1704918749148;
        Wed, 10 Jan 2024 12:32:29 -0800 (PST)
Received: from brgl-uxlite.home ([2a01:cb1d:334:ac00:3342:1411:3dd8:cb70])
        by smtp.gmail.com with ESMTPSA id z17-20020a5d44d1000000b003377e22ffdcsm2072172wrr.85.2024.01.10.12.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 12:32:28 -0800 (PST)
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
Subject: [PATCH 0/3] cleanup: provide and use a locking guard for nested read semaphores
Date: Wed, 10 Jan 2024 21:32:12 +0100
Message-Id: <20240110203215.36396-1-brgl@bgdev.pl>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

This series adds cleanup infrastructure for defining locking guards with
additional arguments, then uses it to provide a guard for
down_read_nested() with RW semaphores and finally uses the new guard in
GPIOLIB.

Patch 3/3 of this series is a second attempt, this time with
lockdep-correct nesting.

The first two patches can either be picked up into the relevant
maintainer trees and I can pull an immutable tag or can be acked and go
directly through the GPIO tree.

Bartosz Golaszewski (3):
  cleanup: provide DEFINE_LOCK_GUARD_ARGS()
  locking/rwsem: provide a lock guard for down_read_nested()
  gpiolib: pin GPIO devices in place during descriptor lookup

 drivers/gpio/gpiolib.c  | 42 +++++++++++++++++++++++------------------
 include/linux/cleanup.h |  6 ++++++
 include/linux/rwsem.h   |  6 ++++++
 3 files changed, 36 insertions(+), 18 deletions(-)

-- 
2.40.1


