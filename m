Return-Path: <linux-kernel+bounces-4184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CA3D8178EB
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:41:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52C191F24EB5
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 17:41:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853637147E;
	Mon, 18 Dec 2023 17:41:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vme5jySB"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 792D27144F;
	Mon, 18 Dec 2023 17:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cc6a52231cso17845621fa.3;
        Mon, 18 Dec 2023 09:40:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702921256; x=1703526056; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D+9SpyD/fjsy+bPfqtgZB0EVZfRFSaxY+QuQ8+JRb/4=;
        b=Vme5jySB1jn0Q1cr2R5F2UUfqW5WOBwKJ4f1hU8Z5+J4TjWKC8hZekuYJFAudyrsF4
         mwL4HTN9mLJwjmVZLho5wq/k1mHti/ihEHEckWWlOvBhxtxEAyM4LVDvClrnJaffrwiX
         3PEQOMFWd9ar6LivWECQSHOCicDIiuA1PdEFK7tLqW6ZgTIx8IkLXN4AF1yin7tpvc9q
         MSBQC4ghM3IBHF8lJPcxWMuxsOk0EZot0k3ZROjq+RgLricuea5zQE2iMOY7//0H4rse
         G13Hr3MyDLIYZACRATFqIcUd1zSGqXUhqWHA/nRd41FCipPMO1mEPE+vYBZNnrDBbusm
         T0zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702921256; x=1703526056;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D+9SpyD/fjsy+bPfqtgZB0EVZfRFSaxY+QuQ8+JRb/4=;
        b=tP/zytH4Hk2QXDPnMBubKfBi7Jl8TKgiKogjUNJM9H03cZvfnblH3guFzQ6qOLIiDU
         qthCe50UN+TALeDdDufEOtICyN054FGbIAoYImO2SuygETXXB7JtzaRJAsCuZXPKup8Y
         fpGOLrwz663Pbn138pUuMgxx8Giswsl0nd68xzjn/fbZlkdGYM+DoiRehSXVQ3kfruDy
         AC3NvYWw21E5yTvbJL2Zen/6l1rHA7+HgJtaDLSzqsSQTepqYAjZskcOUOT4GiuVfA70
         bkrllMfAwRLhzBVbM6D4gfjE8HvVPP5Cl3zqLwE+bsDePbnTfi5GIs77Yuu0mZlqFHSm
         tjKg==
X-Gm-Message-State: AOJu0YzOajVxZ7d5j0ccuRah3pKCvfYRegNgKBBCuD4a/sGdljbZSrKG
	hPGZ1dgFvpmt7urHdoVeFSjB86fGHzVpyw==
X-Google-Smtp-Source: AGHT+IFY919Ltb7YSUsNq9BC1SMWXVTcbysuOEwVOOOcMXGYigEykttVh03NIOo5t+gye0XHzrYvlQ==
X-Received: by 2002:a2e:9604:0:b0:2cc:5e72:17f4 with SMTP id v4-20020a2e9604000000b002cc5e7217f4mr1571163ljh.47.1702921255975;
        Mon, 18 Dec 2023 09:40:55 -0800 (PST)
Received: from localhost ([83.149.246.185])
        by smtp.gmail.com with ESMTPSA id e15-20020a05651c150f00b002cc6b5ab63asm682172ljf.119.2023.12.18.09.40.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 09:40:55 -0800 (PST)
From: Mikhail Rudenko <mike.rudenko@gmail.com>
To: linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Tommaso Merciai <tomm.merciai@gmail.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Mikhail Rudenko <mike.rudenko@gmail.com>
Subject: [PATCH v2 00/20] Omnivision OV4689 refactoring and improvements
Date: Mon, 18 Dec 2023 20:40:21 +0300
Message-ID: <20231218174042.794012-1-mike.rudenko@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This series contains refactoring and new features implementation for
the Omnivision OV4689 sensor driver. Specifically, patches 1, 2, 3, 5,
6, 10, 15, 16, 18, and 19 are refactorings, and are not supposed to
introduce any functional change. Patches 4 and 7 perform migration to
CCI helpers and subdevice active state respectively, and should not
introduce any hardware- and/or user-visible change either. Patch 8
fixes a possible race condition due to v4l2_async_register_subdev_sensor
being called too early in ov4689_probe, and patch 9 migrates power
management to PM autosuspend.

Patches 11-14 expose more sensor controls to the userspace, such as
(read-write) HBLANK, VFLIP/HFLIP, digital gain, and color
balance. Patch 17 implements configurable analogue crop rectangle via
.set_selection callback. And finally, patch 20 enables 2x2 binning
option. It should be noted that publicly available sensor
documentation is lacking description of many registers and their value
ranges, so a lot of values had to be found by experimentation.

Changes in v2:
- collect Laurent's r-b's
- squash together "CCI conversion" and "Set gain in one 16 bit write"
- use ctrl->val in ov4689_set_ctrl
- rename try_fmt to fmt in ov4689_init_cfg and drop corresponding comment
- rebase on top of media-stage and rename init_cfg->init_state
- sort register definitions by address throughout the whole series
- fix number of controls hint in v4l2_ctrl_handler_init
- make all hexadecimal constants lowercase
- disable runtime pm in probe error path
- implement pm autosuspend

Mikhail Rudenko (20):
  media: i2c: ov4689: Clean up and annotate the register table
  media: i2c: ov4689: Sort register definitions by address
  media: i2c: ov4689: Fix typo in a comment
  media: i2c: ov4689: CCI conversion
  media: i2c: ov4689: Remove i2c_client from ov4689 struct
  media: i2c: ov4689: Refactor ov4689_set_ctrl
  media: i2c: ov4689: Use sub-device active state
  media: i2c: ov4689: Enable runtime PM before registering sub-device
  media: i2c: ov4689: Use runtime PM autosuspend
  media: i2c: ov4689: Remove max_fps field from struct ov4689_mode
  media: i2c: ov4689: Make horizontal blanking configurable
  media: i2c: ov4689: Implement vflip/hflip controls
  media: i2c: ov4689: Implement digital gain control
  media: i2c: ov4689: Implement manual color balance controls
  media: i2c: ov4689: Move pixel array size out of struct ov4689_mode
  media: i2c: ov4689: Set timing registers programmatically
  media: i2c: ov4689: Configurable analogue crop
  media: i2c: ov4689: Eliminate struct ov4689_mode
  media: i2c: ov4689: Refactor ov4689_s_stream
  media: i2c: ov4689: Implement 2x2 binning

 drivers/media/i2c/Kconfig  |   1 +
 drivers/media/i2c/ov4689.c | 964 +++++++++++++++++++++++--------------
 2 files changed, 592 insertions(+), 373 deletions(-)

--
2.43.0

