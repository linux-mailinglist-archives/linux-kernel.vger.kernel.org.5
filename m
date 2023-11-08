Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE0097E57BC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Nov 2023 14:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344521AbjKHNGU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Nov 2023 08:06:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235217AbjKHNGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Nov 2023 08:06:17 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4B01AE;
        Wed,  8 Nov 2023 05:06:15 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9d224dca585so1057884766b.1;
        Wed, 08 Nov 2023 05:06:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699448774; x=1700053574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=nWAV8M55Kittmu+4ULL3DdwAYWn4eS/wf3YZpZSaDko=;
        b=kepoKz3JkBSFG4DcfXW4txoTIE+opj2fljln0Dst42qUopzEywoxMGe334ALD9G11h
         +NSxB72hd2df3IoFyOuIH9a53X50KCWQ44Sht/g/ISJ4nCa52HMI96NYTCVn7iAEhilI
         2SrmtjERX+5i1cjb33zPSkcIpcwjMVTqGJ0EJCND4hMhpZAHrY6O94Q7I7zdPvM+IUdp
         N0cn4uXIzRdhU7XlXK9155W3WGmBglpDVaG/mAWDzrflfozmiVDTbDAHNISZG2gUzm1u
         mHWWP0a8AbV9Q3OkroQ95mavgGbQOVMJ7BO8NRhLM4rG2J+sKAbmEqWSyVglOjihWF69
         vb0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699448774; x=1700053574;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nWAV8M55Kittmu+4ULL3DdwAYWn4eS/wf3YZpZSaDko=;
        b=O67Wlp6r1hSAk0ZeT/7NwTUcP9xSRPYNkJTvUP9ZDNjYyCQsyPFXdO7Q9b6NWIy2Fe
         DohPfe4mcUtdgH9MPXPoqY91KCyLZyBPPWEwNAtz5UmM7siN3Hkn98SsxnQ2g81+t75C
         wMHFo4EKhYxjPXSl+69G3QQwimYyC+mXgLPzRe3Bg5Wul42LWvxmAJppJWxEqJbmOZQb
         30xBLwsHzDrcrUQtZ2zW12Fa98bHuUJRRfBUGI9oHyGpCbnyPjytiz9AQCnnJLskKqUm
         1lQKBr0Y2AaJgO584bGH6Qn91jvapB0Xy2zxIdAsaI3SgKLKEzM29b5mfKH52DZFrbjr
         Yqew==
X-Gm-Message-State: AOJu0YxVWEQRs4Hl6foA/PQZnffA28BnnxIhZB4krmeaiKcwQJFnNxfT
        WS0l69r6IiZwB9xCaVQjSzo=
X-Google-Smtp-Source: AGHT+IEZx4ikGOsR7/dmiPdHYizVS4JlsQal08HFEcscNPxUFKfDVNdyh7BapejmRXQMHioTmZCX6Q==
X-Received: by 2002:a17:907:72d4:b0:9be:6395:6b0f with SMTP id du20-20020a17090772d400b009be63956b0fmr1488756ejc.29.1699448773450;
        Wed, 08 Nov 2023 05:06:13 -0800 (PST)
Received: from localhost (p200300e41f0fa600f22f74fffe1f3a53.dip0.t-ipconnect.de. [2003:e4:1f0f:a600:f22f:74ff:fe1f:3a53])
        by smtp.gmail.com with ESMTPSA id gf23-20020a170906e21700b009920a690cd9sm1014113ejb.59.2023.11.08.05.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Nov 2023 05:06:13 -0800 (PST)
From:   Thierry Reding <thierry.reding@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] pwm: Changes for v6.7-rc1
Date:   Wed,  8 Nov 2023 14:06:07 +0100
Message-ID: <20231108130608.1321166-1-thierry.reding@gmail.com>
X-Mailer: git-send-email 2.42.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

The following changes since commit 0bb80ecc33a8fb5a682236443c1e740d5c917d1d:

  Linux 6.6-rc1 (2023-09-10 16:28:41 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/thierry.reding/linux-pwm.git tags/pwm/for-6.7-rc1

for you to fetch changes up to 40592064a1a536adcced4ffea435c392eb9e7192:

  pwm: samsung: Document new member .channel in struct samsung_pwm_chip (2023-11-03 12:00:41 +0100)

Thanks,
Thierry

----------------------------------------------------------------
pwm: Changes for v6.7-rc1

This contains a few fixes and a bunch of cleanups, a lot of which is in
preparation for Uwe's character device support that may be ready in time
for the next merge window.

----------------------------------------------------------------
Ben Dooks (3):
      pwm: dwc: split pci out of core driver
      pwm: dwc: make timer clock configurable
      pwm: dwc: add PWM bit unset in get_state call

Conor Dooley (1):
      pwm: microchip-core: Convert SOC_MICROCHIP_POLARFIRE to ARCH_MICROCHIP_POLARFIRE

Fabio Estevam (2):
      dt-bindings: pwm: mxs: Document fsl,imx28-pwm
      dt-bindings: pwm: mxs: Document the clocks property

Florian Fainelli (3):
      pwm: brcmstb: Utilize appropriate clock APIs in suspend/resume
      pwm: brcmstb: Checked clk_prepare_enable() return value
      pwm: bcm2835: Add support for suspend/resume

Rob Herring (1):
      pwm: pxa: Explicitly include correct DT includes

Ruan Jinjie (2):
      pwm: atmel: Remove redundant of_match_ptr()
      pwm: omap-dmtimer: Remove redundant of_match_ptr()

Uwe Kleine-König (25):
      pwm: jz4740: Consistently name driver data "jz"
      pwm: Manage owner assignment implicitly for drivers
      pwm: crc: Allow compilation as module and with COMPILE_TEST
      pwm: berlin: Put per-channel config into driver data
      pwm: samsung: Put per-channel data into driver data
      pwm: jz4740: Put per-channel clk into driver data
      pwm: lp3943: Drop usage of pwm_[gs]et_chip_data()
      pwm: renesas: Drop usage of pwm_[gs]et_chip_data()
      pwm: sti: Reduce number of allocations and drop usage of chip_data
      pwm: cros-ec: Put per-channel data into driver data
      pwm: Drop pwm_[sg]et_chip_data()
      pwm: berlin: Simplify using devm functions
      pwm: Adapt sysfs API documentation to reality
      pwm: bcm-iproc: Simplify using devm functions
      pwm: bcm2835: Simplify using devm functions
      pwm: brcmstb: Simplify using devm functions
      pwm: imx-tpm: Simplify using devm functions
      pwm: mtk-disp: Simplify using devm_pwmchip_add()
      pwm: spear: Simplify using devm functions
      pwm: sprd: Provide a helper to cast a chip to driver data
      pwm: sprd: Simplify using devm_pwmchip_add() and dev_err_probe()
      pwm: vt8500: Simplify using devm functions
      pwm: samsung: Consistently use the same name for driver data
      pwm: cros-ec: Simplify using devm_pwmchip_add() and dev_err_probe()
      pwm: samsung: Document new member .channel in struct samsung_pwm_chip

 Documentation/devicetree/bindings/pwm/mxs-pwm.yaml |  13 +-
 Documentation/driver-api/pwm.rst                   |   6 +-
 drivers/gpio/gpio-mvebu.c                          |   1 -
 drivers/gpu/drm/bridge/ti-sn65dsi86.c              |   1 -
 drivers/leds/rgb/leds-qcom-lpg.c                   |   1 -
 drivers/pwm/Kconfig                                |  20 ++-
 drivers/pwm/Makefile                               |   1 +
 drivers/pwm/core.c                                 |  55 ++----
 drivers/pwm/pwm-ab8500.c                           |   1 -
 drivers/pwm/pwm-apple.c                            |   1 -
 drivers/pwm/pwm-atmel-hlcdc.c                      |   1 -
 drivers/pwm/pwm-atmel-tcb.c                        |   1 -
 drivers/pwm/pwm-atmel.c                            |   3 +-
 drivers/pwm/pwm-bcm-iproc.c                        |  38 +---
 drivers/pwm/pwm-bcm-kona.c                         |   1 -
 drivers/pwm/pwm-bcm2835.c                          |  36 ++--
 drivers/pwm/pwm-berlin.c                           |  63 ++-----
 drivers/pwm/pwm-brcmstb.c                          |  49 ++---
 drivers/pwm/pwm-clk.c                              |   1 -
 drivers/pwm/pwm-clps711x.c                         |   1 -
 drivers/pwm/pwm-crc.c                              |   5 +-
 drivers/pwm/pwm-cros-ec.c                          |  67 ++-----
 drivers/pwm/pwm-dwc-core.c                         | 184 +++++++++++++++++++
 drivers/pwm/pwm-dwc.c                              | 197 +--------------------
 drivers/pwm/pwm-dwc.h                              |  60 +++++++
 drivers/pwm/pwm-ep93xx.c                           |   1 -
 drivers/pwm/pwm-fsl-ftm.c                          |   1 -
 drivers/pwm/pwm-hibvt.c                            |   1 -
 drivers/pwm/pwm-img.c                              |   1 -
 drivers/pwm/pwm-imx-tpm.c                          |  30 +---
 drivers/pwm/pwm-imx1.c                             |   1 -
 drivers/pwm/pwm-imx27.c                            |   1 -
 drivers/pwm/pwm-intel-lgm.c                        |   1 -
 drivers/pwm/pwm-iqs620a.c                          |   1 -
 drivers/pwm/pwm-jz4740.c                           |  46 ++---
 drivers/pwm/pwm-keembay.c                          |   1 -
 drivers/pwm/pwm-lp3943.c                           |  22 +--
 drivers/pwm/pwm-lpc18xx-sct.c                      |   1 -
 drivers/pwm/pwm-lpc32xx.c                          |   1 -
 drivers/pwm/pwm-lpss.c                             |   1 -
 drivers/pwm/pwm-mediatek.c                         |   1 -
 drivers/pwm/pwm-meson.c                            |   1 -
 drivers/pwm/pwm-microchip-core.c                   |   1 -
 drivers/pwm/pwm-mtk-disp.c                         |  25 +--
 drivers/pwm/pwm-mxs.c                              |   1 -
 drivers/pwm/pwm-ntxec.c                            |   1 -
 drivers/pwm/pwm-omap-dmtimer.c                     |   3 +-
 drivers/pwm/pwm-pca9685.c                          |   1 -
 drivers/pwm/pwm-pxa.c                              |   3 +-
 drivers/pwm/pwm-raspberrypi-poe.c                  |   1 -
 drivers/pwm/pwm-rcar.c                             |   1 -
 drivers/pwm/pwm-renesas-tpu.c                      |  23 ++-
 drivers/pwm/pwm-rockchip.c                         |   1 -
 drivers/pwm/pwm-rz-mtu3.c                          |   1 -
 drivers/pwm/pwm-samsung.c                          | 152 ++++++++--------
 drivers/pwm/pwm-sifive.c                           |   1 -
 drivers/pwm/pwm-sl28cpld.c                         |   1 -
 drivers/pwm/pwm-spear.c                            |  41 ++---
 drivers/pwm/pwm-sprd.c                             |  29 ++-
 drivers/pwm/pwm-sti.c                              |  30 ++--
 drivers/pwm/pwm-stm32-lp.c                         |   1 -
 drivers/pwm/pwm-stm32.c                            |   1 -
 drivers/pwm/pwm-stmpe.c                            |   1 -
 drivers/pwm/pwm-sun4i.c                            |   1 -
 drivers/pwm/pwm-sunplus.c                          |   1 -
 drivers/pwm/pwm-tegra.c                            |   1 -
 drivers/pwm/pwm-tiecap.c                           |   1 -
 drivers/pwm/pwm-tiehrpwm.c                         |   1 -
 drivers/pwm/pwm-twl-led.c                          |   2 -
 drivers/pwm/pwm-twl.c                              |   2 -
 drivers/pwm/pwm-visconti.c                         |   1 -
 drivers/pwm/pwm-vt8500.c                           |  43 +----
 drivers/pwm/pwm-xilinx.c                           |   1 -
 drivers/staging/greybus/pwm.c                      |   1 -
 include/linux/pwm.h                                |  24 +--
 75 files changed, 539 insertions(+), 778 deletions(-)
 create mode 100644 drivers/pwm/pwm-dwc-core.c
 create mode 100644 drivers/pwm/pwm-dwc.h
