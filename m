Return-Path: <linux-kernel+bounces-16203-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DF0E823AA7
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 03:30:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CADF4B224D3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 02:30:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04DF24C6F;
	Thu,  4 Jan 2024 02:30:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QIhHvRzm"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C59E61FB3
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 02:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40d5a41143fso505835e9.3
        for <linux-kernel@vger.kernel.org>; Wed, 03 Jan 2024 18:30:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704335407; x=1704940207; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=LBuurdHLnnOev6b2QECRgmq+V/JnKnSW2JNh/0hOGNA=;
        b=QIhHvRzm/IO91CB+opsf+FpiHgk0SKnOtq4baLYgQAidEaSRGEIsAs8RPj8NAxSeMH
         tbTBk5TN7dDdakXg5yizCjQx1dLiSxnIUsyZUqXvLMdtj2FbUj3Qgcn9jW9z/8AngcEd
         GfVAmd6UuB8J6OqMk2kT3CfuDuPs3rB9v/WoxPlFOYBhLASawt/zL/zJVRLqKl6C/O4v
         TYwwb4zO6zUjhK6Tv8tXy4X4/RoEE1QA7ewPQNXFKAJqO4lCFbuv7YPEM0QBbhTvITsw
         /8GrBIfFwD1xrLPnkiciop5QY97rELh5TXjZX4T+O/xXWEBJ8dRva0FSMiNbT/lCbjtx
         xvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704335407; x=1704940207;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LBuurdHLnnOev6b2QECRgmq+V/JnKnSW2JNh/0hOGNA=;
        b=UqqK+3HJVxxqBE3q4yYPGKnalxZH0XehnI0IEYAUAQg7zy+rmqYRx7mAdE+ld6uDQW
         +QtfcQNdr7ytgOm3iDNQgx9AfkT34Jgx3WKUUqp/u704CigmYm9gN0IBgH1sy4X3tD1m
         keagbISkFqVdxta/D4o5JUiZG4WC0wvY4+PF32948QxVflsHsMxAZM7JXobIle0bTKPs
         05fd3RfEpkNBIX6ZVnHeDOD5Ka3Sv1GDNUThcUOQRA8pWLkNLx94ZHKLBfV89dW4ht/K
         xCgP38Q4xwRZ1HLlHJFf8+lG6oQddYWgB8vzxsxtx84FBCvKgZZbvsjum0l81Qru3Q65
         EsNQ==
X-Gm-Message-State: AOJu0YyF/lgR7JRTgJh4sUfkBLwynIiXJUJBgWgb5fl7Z1GXJkXe5fHC
	RgDGM2MeuwXCINHMkzmv+za2fg9dv7ni756bFam05O1jQtQ=
X-Google-Smtp-Source: AGHT+IEDuQOx0vVsPKToJX0YOyPsrm4LD+6C3A71UsalPstE8CC8Fm8BL63NjdWQjVqztD0Ff6vsFUC/iwGT3CiW9lo=
X-Received: by 2002:a05:600c:b41:b0:40d:3ade:9fac with SMTP id
 k1-20020a05600c0b4100b0040d3ade9facmr10766708wmr.75.1704335406772; Wed, 03
 Jan 2024 18:30:06 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Thu, 4 Jan 2024 12:29:55 +1000
Message-ID: <CAPM=9txBXQR8YsaU2fO1frcGBP6HKTF473Rqae_hwT_yY-dRrg@mail.gmail.com>
Subject: [git pull] drm fixes for 6.8
To: Linus Torvalds <torvalds@linux-foundation.org>, Daniel Vetter <daniel.vetter@ffwll.ch>
Cc: dri-devel <dri-devel@lists.freedesktop.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

These were from over the holiday period, mainly i915, a couple of
qaic, bridge and an mgag200.

I have a set of nouveau fixes that I'll send after this, that might be
too rich for you at this point.

I expect there might also be some more regular fixes before 6.8, but
they should be minor.

Dave.

drm-fixes-2024-01-04:
drm fixes for 6.8

qaic:
- fix GEM import
- add quirk for soc version

bridge:
- parade-ps8640, ti-sn65dsi86: fix aux reads bounds

mgag200:
- fix gamma LUT init

i915:
- Fix bogus DPCD rev usage for DP phy test pattern setup
- Fix handling of MMIO triggered reports in the OA buffer
The following changes since commit 610a9b8f49fbcf1100716370d3b5f6f884a2835a:

  Linux 6.7-rc8 (2023-12-31 12:51:25 -0800)

are available in the Git repository at:

  git://anongit.freedesktop.org/drm/drm tags/drm-fixes-2024-01-04

for you to fetch changes up to faa21f4c20960fee268bdb0fe977ed0edb6685fe:

  Merge tag 'drm-misc-fixes-2024-01-03' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes (2024-01-04
11:18:32 +1000)

----------------------------------------------------------------
drm fixes for 6.8

qaic:
- fix GEM import
- add quirk for soc version

bridge:
- parade-ps8640, ti-sn65dsi86: fix aux reads bounds

mgag200:
- fix gamma LUT init

i915:
- Fix bogus DPCD rev usage for DP phy test pattern setup
- Fix handling of MMIO triggered reports in the OA buffer

----------------------------------------------------------------
Dave Airlie (2):
      Merge tag 'drm-intel-fixes-2023-12-28' of
git://anongit.freedesktop.org/drm/drm-intel into drm-fixes
      Merge tag 'drm-misc-fixes-2024-01-03' of
git://anongit.freedesktop.org/drm/drm-misc into drm-fixes

Douglas Anderson (3):
      drm/bridge: parade-ps8640: Never store more than msg->size bytes
in AUX xfer
      drm/bridge: ti-sn65dsi86: Never store more than msg->size bytes
in AUX xfer
      drm/bridge: ps8640: Fix size mismatch warning w/ len

Jeffrey Hugo (1):
      accel/qaic: Implement quirk for SOC_HW_VERSION

Jocelyn Falempe (1):
      drm/mgag200: Fix gamma lut not initialized for G200ER, G200EV, G200SE

Khaled Almahallawy (1):
      drm/i915/dp: Fix passing the correct DPCD_REV for
drm_dp_set_phy_test_pattern

Pranjal Ramajor Asha Kanojiya (1):
      accel/qaic: Fix GEM import path code

Umesh Nerlige Ramappa (1):
      drm/i915/perf: Update handling of MMIO triggered reports

 drivers/accel/qaic/mhi_controller.c      | 15 +++++++++++-
 drivers/accel/qaic/qaic_data.c           |  6 ++---
 drivers/gpu/drm/bridge/parade-ps8640.c   |  7 +++---
 drivers/gpu/drm/bridge/ti-sn65dsi86.c    |  4 +++-
 drivers/gpu/drm/i915/display/intel_dp.c  |  2 +-
 drivers/gpu/drm/i915/i915_perf.c         | 39 ++++++++++++++++++++++++++++----
 drivers/gpu/drm/mgag200/mgag200_drv.h    |  5 ++++
 drivers/gpu/drm/mgag200/mgag200_g200er.c |  5 ++++
 drivers/gpu/drm/mgag200/mgag200_g200ev.c |  5 ++++
 drivers/gpu/drm/mgag200/mgag200_g200se.c |  5 ++++
 drivers/gpu/drm/mgag200/mgag200_mode.c   | 10 ++++----
 11 files changed, 83 insertions(+), 20 deletions(-)

