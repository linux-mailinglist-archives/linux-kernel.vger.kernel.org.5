Return-Path: <linux-kernel+bounces-24834-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 564A682C32F
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 16:59:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF6291F25237
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 15:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52CDD6EB7C;
	Fri, 12 Jan 2024 15:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ov4wv6Ki"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB85873188;
	Fri, 12 Jan 2024 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40e60e135a7so16053345e9.0;
        Fri, 12 Jan 2024 07:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705075133; x=1705679933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9uk/HOLTFsEakibiIcqN0mTEm8EKT5vwRFwO2a5VYG8=;
        b=Ov4wv6KiJ5IqP/g0lGBIkQPeyyaA5vZyF7pajLCO8Dx+/4E6jFuDkGnJ3W39zBz8ay
         xqzzHzb9utisht+qTm6pvuTfD1bw/zM0/mbxhcCtgG9AMuUQlH14phYm4k6lxt9ihGtj
         He/RSsLNo3eBOn7GvIFdH1PA7jMw+iQN9ZRi6YlC9O3UE3UCZpZ3BMUp6goBUD26LNxl
         Es17O4OSOPUlBVLdElBzQe7cPCwApAKh4KCXYvErQVuJ1REiWpPrsVTvEoRb2fjobLgK
         ZcdJ/c/vbpyM9PYh12Ii9/wwB7IJYlVHe97N2lC80dLZ6l3fS7PJh/2rbrG9sAP2GXPp
         tjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705075133; x=1705679933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9uk/HOLTFsEakibiIcqN0mTEm8EKT5vwRFwO2a5VYG8=;
        b=acu/aJVhDPxlW/3hcfU0gRUSNIxB24QoPgg+otVGWFLBKjHuKex2dk+2XYIyPXswmn
         4ufuH+wOPDnqXNtkzwC+910rEk6vGtT/27XjquIQStDS7FOFgIIh0dGRzPCP5uf4QTQA
         5owsluwNDafP/C375YlXJt5CDo57bgvm7N6q7BLbppNVA0KRdrEdbakTopsftyK7H370
         8Lqm6gkuk99hwcI8wugKGMs5QbUYWqgIZuVPmksFb3aeIgSUTZXd1CGdSAH1P/CpopaU
         2wXBKoAxWluxOMvzqOOh35CXx8txsYidqImG5Y3eV15x/Sc2Rb569b6F3vGEK0LcA2xx
         bTHg==
X-Gm-Message-State: AOJu0YwBtB/mQPSrhnyfNtntsHfxR6e3bauH84utwimSajLA55HulOdK
	/NCyH8MFt6Vv/0cY6zXaSXA=
X-Google-Smtp-Source: AGHT+IGITm9OfctqKoGBZkmgs1NS1dnqK/hyjzh2OrcNVUnZVNz8r6BGb0zcBLRdMY6k4bII5cohlQ==
X-Received: by 2002:a05:600c:1da7:b0:40e:4e09:1fbd with SMTP id p39-20020a05600c1da700b0040e4e091fbdmr894771wms.0.1705075132479;
        Fri, 12 Jan 2024 07:58:52 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id k9-20020a05600c1c8900b0040d772030c2sm6163727wms.44.2024.01.12.07.58.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jan 2024 07:58:52 -0800 (PST)
From: Thierry Reding <thierry.reding@gmail.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	linux-pwm@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v6.8-rc1
Date: Fri, 12 Jan 2024 16:58:48 +0100
Message-ID: <20240112155851.2987763-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Linus,

The following changes since commit 4e7a8dbd2bc0aec4605a5069df7a779bd9e64db1:

  pwm: bcm2835: Fix NPD in suspend/resume (2023-11-21 11:09:32 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.8-rc1

for you to fetch changes up to 7afc0e7f681e6efd6b826f003fc14c17b5093643:

  MAINTAINERS: pwm: Thierry steps down, Uwe takes over (2024-01-12 16:40:34 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v6.8-rc1

This contains a bunch of cleanups and simplifications across the board,
as well as a number of small fixes.

Perhaps the most notable change here is the addition of an API that
allows PWMs to be used in atomic contexts, which is useful when time-
critical operations are involved, such as using a PWM to generate IR
signals.

Finally, I have decided to step down as PWM subsystem maintainer. Due to
other responsibilities I have lately not been able to find the time that
the subsystem deserves and Uwe, who has been helping out a lot for the
past few years and has many things planned for the future, has kindly
volunteered to take over. I have no doubt that he will be a suitable
replacement.

----------------------------------------------------------------
Michael Walle (1):
      dt-bindings: pwm: remove Xinlei's mail

Philipp Zabel (5):
      pwm: stm32: Replace write_ccrx with regmap_write
      pwm: stm32: Make ch parameter unsigned
      pwm: stm32: Use hweight32 in stm32_pwm_detect_channels
      pwm: stm32: Implement .get_state()
      pwm: stm32: Fix enable count for clk in .probe()

Randy Dunlap (1):
      pwm: linux/pwm.h: fix Excess kernel-doc description warning

Rob Herring (1):
      pwm: Use device_get_match_data()

Sean Young (6):
      pwm: Rename pwm_apply_state() to pwm_apply_might_sleep()
      pwm: Replace ENOTSUPP with EOPNOTSUPP
      pwm: renesas: Remove unused include
      pwm: Make it possible to apply PWM changes in atomic context
      pwm: bcm2835: Allow PWM driver to be used in atomic context
      media: pwm-ir-tx: Trigger edges from hrtimer interrupt context

Thierry Reding (2):
      pwm: Stop referencing pwm->chip
      pwm: Add pwm_apply_state() compatibility stub

Tony Lindgren (1):
      dt-bindings: pwm: ti,pwm-omap-dmtimer: Update binding for yaml

Uwe Kleine-König (27):
      pwm: Drop unused member "pwm" from struct pwm_device
      pwm: Replace PWM chip unique base by unique ID
      pwm: Mention PWM chip ID in /sys/kernel/debug/pwm
      pwm: cros-ec: Drop unused member from driver private data
      pwm: atmel-hlcdc: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: atmel-tcb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: berlin: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: brcmstb: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: dwc: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: imx-tpm: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: samsung: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: stm32-lp: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: stm32: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: tiecap: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: tiehrpwm: Use DEFINE_SIMPLE_DEV_PM_OPS for PM functions
      pwm: jz4740: Add trailing \n to error messages
      pwm: Narrow scope of struct pwm_device pointer
      pwm: Update kernel doc for struct pwm_chip
      pwm: omap-dmtimer: Drop locking
      pwm: crc: Use consistent variable naming for driver data
      pwm: Reduce number of pointer dereferences in pwm_device_request()
      pwm: stmpe: Silence duplicate error messages
      pwm: meson: Simplify using dev_err_probe()
      pwm: lpc18xx-sct: Don't modify the cached period of other PWM outputs
      pwm: Drop two unused API functions
      pwm: cros-ec: Drop documentation for dropped struct member
      MAINTAINERS: pwm: Thierry steps down, Uwe takes over

 .../devicetree/bindings/pwm/mediatek,pwm-disp.yaml |   1 -
 .../devicetree/bindings/pwm/pwm-omap-dmtimer.txt   |  22 ---
 .../bindings/pwm/ti,omap-dmtimer-pwm.yaml          |  59 ++++++++
 Documentation/driver-api/pwm.rst                   |  17 ++-
 MAINTAINERS                                        |   7 +-
 drivers/gpu/drm/i915/display/intel_backlight.c     |   6 +-
 drivers/gpu/drm/solomon/ssd130x.c                  |   2 +-
 drivers/hwmon/pwm-fan.c                            |   8 +-
 drivers/input/misc/da7280.c                        |   4 +-
 drivers/input/misc/pwm-beeper.c                    |   4 +-
 drivers/input/misc/pwm-vibra.c                     |   8 +-
 drivers/leds/leds-pwm.c                            |   2 +-
 drivers/leds/rgb/leds-pwm-multicolor.c             |   4 +-
 drivers/media/rc/pwm-ir-tx.c                       |  87 ++++++++++-
 drivers/platform/x86/lenovo-yogabook.c             |   2 +-
 drivers/pwm/core.c                                 | 164 ++++++++++++---------
 drivers/pwm/pwm-atmel-hlcdc.c                      |   8 +-
 drivers/pwm/pwm-atmel-tcb.c                        |   8 +-
 drivers/pwm/pwm-bcm-kona.c                         |   2 +-
 drivers/pwm/pwm-bcm2835.c                          |  38 +++--
 drivers/pwm/pwm-berlin.c                           |   8 +-
 drivers/pwm/pwm-brcmstb.c                          |   8 +-
 drivers/pwm/pwm-crc.c                              |  16 +-
 drivers/pwm/pwm-cros-ec.c                          |   2 -
 drivers/pwm/pwm-dwc.c                              |   6 +-
 drivers/pwm/pwm-img.c                              |  10 +-
 drivers/pwm/pwm-imx-tpm.c                          |  10 +-
 drivers/pwm/pwm-jz4740.c                           |   6 +-
 drivers/pwm/pwm-lpc18xx-sct.c                      |   6 +-
 drivers/pwm/pwm-lpc32xx.c                          |   2 +-
 drivers/pwm/pwm-mediatek.c                         |   2 +-
 drivers/pwm/pwm-meson.c                            |  35 ++---
 drivers/pwm/pwm-omap-dmtimer.c                     |  20 +--
 drivers/pwm/pwm-renesas-tpu.c                      |   3 +-
 drivers/pwm/pwm-rockchip.c                         |   9 +-
 drivers/pwm/pwm-samsung.c                          |   6 +-
 drivers/pwm/pwm-sti.c                              |   2 +-
 drivers/pwm/pwm-stm32-lp.c                         |  10 +-
 drivers/pwm/pwm-stm32.c                            | 106 +++++++------
 drivers/pwm/pwm-stmpe.c                            |  14 +-
 drivers/pwm/pwm-tegra.c                            |   2 +-
 drivers/pwm/pwm-tiecap.c                           |   6 +-
 drivers/pwm/pwm-tiehrpwm.c                         |   8 +-
 drivers/pwm/pwm-twl-led.c                          |   6 +-
 drivers/pwm/pwm-twl.c                              |   4 +-
 drivers/pwm/pwm-vt8500.c                           |   4 +-
 drivers/pwm/sysfs.c                                |  12 +-
 drivers/regulator/pwm-regulator.c                  |   4 +-
 drivers/video/backlight/lm3630a_bl.c               |   2 +-
 drivers/video/backlight/lp855x_bl.c                |   2 +-
 drivers/video/backlight/pwm_bl.c                   |  12 +-
 drivers/video/fbdev/ssd1307fb.c                    |   2 +-
 include/linux/pwm.h                                |  84 ++++++-----
 53 files changed, 517 insertions(+), 365 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pwm/pwm-omap-dmtimer.txt
 create mode 100644 Documentation/devicetree/bindings/pwm/ti,omap-dmtimer-pwm.yaml

