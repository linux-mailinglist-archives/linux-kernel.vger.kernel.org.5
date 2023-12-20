Return-Path: <linux-kernel+bounces-6600-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1786B819AD8
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D6D21C22041
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:48:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7F4208B9;
	Wed, 20 Dec 2023 08:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZxmMoY3s"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f48.google.com (mail-qv1-f48.google.com [209.85.219.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EEF31DA4C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:47:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f48.google.com with SMTP id 6a1803df08f44-67ee17ab697so42250496d6.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:47:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703062049; x=1703666849; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=AkUnotLHiwUHunRMJ74rg2n/XXNGCcUjwtUyRu/WLvI=;
        b=ZxmMoY3srabQN0piL72YR13AYRU+/OE2lth68ODEe5z8knmzqHdydud2OWyTCYBwUj
         cuN4BoIjN0ivJ/BIgDLlrGc5v2hlsm2pQzBCeSTnDCBZ3CdROuITMqCAkiUUQr3rOjLD
         ariS3SKTAXN5GRZretajq7/NnQcL3hqiQe8HN50Pj2IxPt6hqQDmR0gJo2lDlgGC48Jf
         iWCdT1lslY41GQS3qlcjBjQ+e/Ua/6BrxVHENSmGdIkru+9TZyeT5q8OWo+pTjI/QbvF
         oO2iktz5w8xBEFcKu9dXRimDgY/oZ+5QKBnXoE9ZWkowIWvuQ7pYyMYFXAL+JcStR+Do
         JG4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703062049; x=1703666849;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AkUnotLHiwUHunRMJ74rg2n/XXNGCcUjwtUyRu/WLvI=;
        b=NvrSe2KD3Gu09Gvncj/GpDRmaD7z0Mikag6DICAo/vVImGbdwGCrlEFUWq3yDAZlZm
         9IjFA/VUrG0lQEAW1bb1zelz2Lgo/xN15/gh5/tmHTVPn3YgwY+tRf4qgo2BXi08LY9D
         k1HHhHim1TqY2IXmUQr1Q730GU4NCAU14GdHcolLqOv37tb+fm+sNXt0E9uzNEOd+rqs
         2B462evyohL4r6GyNhvpZf5xFyWth2kXjp69x199LyxYkRV+Iiw/kJ2q30n5IRWzY+Nz
         FJv/P0S5q4xhb9r5cDxIezzL3GBuH3xXVhbBN01ddEkZURdH89gM55U9X/8w0E2IkBgB
         4lCw==
X-Gm-Message-State: AOJu0YyVH5iGAPrHjBSsehbXQIqgq23ECpVHH6Ypj3BfR27EpUsBXFIc
	+GjhaWC+5cOdYPz98oU8FgHTqA==
X-Google-Smtp-Source: AGHT+IEdfszLOaIesNW+7ESBIjUWCUZ2vKw4gM2QUlrYD4MHAlBGCggMU5JjWuGySGOTJMs9kxjrng==
X-Received: by 2002:ad4:5c6a:0:b0:67f:43f4:d058 with SMTP id i10-20020ad45c6a000000b0067f43f4d058mr5857968qvh.105.1703062048881;
        Wed, 20 Dec 2023 00:47:28 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id g18-20020a0ce752000000b0067abfe5709dsm11168847qvn.139.2023.12.20.00.47.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 00:47:28 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Olof Johansson <olof@lixom.net>,
	Arnd Bergmann <arnd@arndb.de>,
	arm@kernel.org,
	soc@kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Alim Akhtar <alim.akhtar@samsung.com>,
	Peter Griffin <peter.griffin@linaro.org>,
	linux-arm-kernel@lists.infradead.org,
	linux-samsung-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL 1/2] samsung: drivers for v6.8
Date: Wed, 20 Dec 2023 09:47:21 +0100
Message-Id: <20231220084722.22149-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

Driver changes needed for Google GS101 SoC, plus usual Samsung SoC driver
updates.

This includes topic branch, see explanation in pull-request/tag.

Best regards,
Krzysztof


The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-drivers-6.8

for you to fetch changes up to 35f32e39b4d9b436354c2a37623c393a2ac7cf87:

  dt-bindings: clock: google,gs101: rename CMU_TOP gate defines (2023-12-18 09:59:20 +0100)

----------------------------------------------------------------
Samsung SoC driver changes for v6.8

1. Add support for Google GS101 SoC to different drivers: clock
   controller, serial and watchdog.

   The clock driver changes depend on few bindings headers, which I put
   in a topic branch with the bindings refactoring and GS101 support,
   therefore this this pull request includes that bindings topic branch.

   The rest of the bindings topic branch is not necessary here, however
   keeping everything together makes it easier to share between
   branches.  The bindings topic branch is mostly refactoring all the
   compatibles to add SoC-specific compatible followed by fallback.

2. Exynos ChipID: recognize ExynosAutov920.

----------------------------------------------------------------
Jaewon Kim (8):
      soc: samsung: exynos-chipid: add exynosautov920 SoC support
      dt-bindings: samsung: exynos-sysreg: add exynosautov920 sysreg
      dt-bindings: samsung: exynos-pmu: add exynosautov920 compatible
      dt-bindings: samsung: usi: add exynosautov920-usi compatible
      dt-bindings: serial: samsung: add exynosautov920-uart compatible
      dt-bindings: pwm: samsung: add exynosautov920 compatible
      dt-bindings: arm: samsung: Document exynosautov920 SADK board binding
      dt-bindings: hwinfo: samsung,exynos-chipid: add exynosautov920 compatible

Krzysztof Kozlowski (18):
      dt-bindings: hwinfo: samsung,exynos-chipid: add specific compatibles for existing SoC
      dt-bindings: i2c: exynos5: add specific compatibles for existing SoC
      dt-bindings: i2c: samsung,s3c2410-i2c: add specific compatibles for existing SoC
      dt-bindings: mmc: samsung,exynos-dw-mshc: add specific compatibles for existing SoC
      dt-bindings: rtc: s3c-rtc: add specific compatibles for existing SoC
      dt-bindings: serial: samsung: add specific compatibles for existing SoC
      dt-bindings: samsung: exynos-pmu: add specific compatibles for existing SoC
      dt-bindings: gpu: arm,mali-midgard: add specific compatibles for existing Exynos SoC
      dt-bindings: iio: samsung,exynos-adc: add specific compatibles for existing SoC
      ASoC: dt-bindings: samsung-i2s: add specific compatibles for existing SoC
      dt-bindings: pwm: samsung: add specific compatibles for existing SoC
      dt-bindings: i2c: exynos5: add specific compatible for Tesla FSD
      dt-bindings: pwm: samsung: add specific compatible for Tesla FSD
      dt-bindings: serial: samsung: add specific compatible for Tesla FSD
      dt-bindings: samsung: exynos-pmu: add specific compatible for Tesla FSD
      dt-bindings: watchdog: samsung: add specific compatible for Tesla FSD
      dt-bindings: samsung: exynos-sysreg: combine exynosautov920 with other enum
      Merge tag 'samsung-dt-bindings-refactoring-and-google-gs101-6.8' into next/drivers

Peter Griffin (13):
      dt-bindings: soc: samsung: exynos-pmu: Add gs101 compatible
      dt-bindings: clock: Add Google gs101 clock management unit bindings
      dt-bindings: soc: google: exynos-sysreg: add dedicated SYSREG compatibles to GS101
      dt-bindings: watchdog: Document Google gs101 watchdog bindings
      dt-bindings: serial: samsung: Add google-gs101-uart compatible
      dt-bindings: serial: samsung: Make samsung,uart-fifosize a required property
      dt-bindings: clock: google,gs101: fix incorrect numbering and DGB suffix
      clk: samsung: clk-pll: Add support for pll_{0516,0517,518}
      clk: samsung: clk-gs101: Add cmu_top, cmu_misc and cmu_apm support
      tty: serial: samsung: Add gs101 compatible and common fifoszdt_serial_drv_data
      watchdog: s3c2410_wdt: Add support for WTCON register DBGACK_MASK bit
      watchdog: s3c2410_wdt: Update QUIRK macros to use BIT macro
      watchdog: s3c2410_wdt: Add support for Google gs101 SoC

Tudor Ambarus (2):
      dt-bindings: soc: samsung: usi: add google,gs101-usi compatible
      dt-bindings: clock: google,gs101: rename CMU_TOP gate defines

 .../bindings/arm/samsung/samsung-boards.yaml       |    6 +
 .../bindings/clock/google,gs101-clock.yaml         |  106 +
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  |    5 +
 .../bindings/hwinfo/samsung,exynos-chipid.yaml     |   18 +-
 .../devicetree/bindings/i2c/i2c-exynos5.yaml       |   11 +-
 .../bindings/i2c/samsung,s3c2410-i2c.yaml          |   22 +-
 .../bindings/iio/adc/samsung,exynos-adc.yaml       |   29 +-
 .../bindings/mfd/samsung,exynos5433-lpass.yaml     |    2 +-
 .../bindings/mmc/samsung,exynos-dw-mshc.yaml       |   25 +-
 .../devicetree/bindings/pwm/pwm-samsung.yaml       |    4 +
 Documentation/devicetree/bindings/rtc/s3c-rtc.yaml |    5 +
 .../devicetree/bindings/serial/samsung_uart.yaml   |   28 +-
 .../bindings/soc/samsung/exynos-pmu.yaml           |   10 +
 .../bindings/soc/samsung/exynos-usi.yaml           |    7 +-
 .../soc/samsung/samsung,exynos-sysreg.yaml         |    5 +
 .../devicetree/bindings/sound/samsung-i2s.yaml     |   19 +-
 .../devicetree/bindings/watchdog/samsung-wdt.yaml  |   29 +-
 drivers/clk/samsung/Makefile                       |    1 +
 drivers/clk/samsung/clk-gs101.c                    | 2518 ++++++++++++++++++++
 drivers/clk/samsung/clk-pll.c                      |    6 +
 drivers/clk/samsung/clk-pll.h                      |    3 +
 drivers/soc/samsung/exynos-chipid.c                |    1 +
 drivers/tty/serial/samsung_tty.c                   |   16 +
 drivers/watchdog/s3c2410_wdt.c                     |   85 +-
 include/dt-bindings/clock/google,gs101.h           |  392 +++
 25 files changed, 3285 insertions(+), 68 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
 create mode 100644 drivers/clk/samsung/clk-gs101.c
 create mode 100644 include/dt-bindings/clock/google,gs101.h

