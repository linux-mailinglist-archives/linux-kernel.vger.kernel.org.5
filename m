Return-Path: <linux-kernel+bounces-6601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CF835819AD9
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85FFE289085
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F471C6B7;
	Wed, 20 Dec 2023 08:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wpoyvS3N"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C867920B21
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:47:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-67a338dfca7so45277866d6.2
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:47:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703062053; x=1703666853; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9fpfISSmgMB3y/bVNFGA51V1qdYGXV4hc5kvcWbG5fk=;
        b=wpoyvS3NEh7Nfldt9N4nEc9hLuYanyI7Dq8f4xCg8Q0qtxH3kwdB+HjuN2sxgqGL9n
         hG+GaROOOWnJBXHRWhho2CTWYyn+KkOv9Kto2XjoNXP8wAdt4wMwYXmAbFdCNhEuL5Kl
         NGWYv31N2iX0blWUU4ATVWYE9LkmVLgZFxhX8Y5VHY4ctwycxv1WyMLlUzbrQ14nW7rn
         cQJ5jC49jI1TGbFsJoigMRKkdJGVUDhfR4VY19mIPJhdOt4zpOdoBVbHMYF/lCJyDk6J
         hP7lubDls9eG53quE8Emvv/Nq8EKG3dYSkeHKvf5dULmBPaixk8Yt1VDO8HU+HA8nkdy
         HAVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703062053; x=1703666853;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9fpfISSmgMB3y/bVNFGA51V1qdYGXV4hc5kvcWbG5fk=;
        b=PNd60bETMfLxQSWMeFN6y7VBFw9YoOWWKE5tfrqZOx2CAZcTZUVsfgeN9qlvG0jOVL
         QKAdvc6YYZcfr25rbTTSTHD4AJCTjg+JvGhBkx5NIElhzz94p5hoQmKEbunIkBgn+faK
         yK4bdIpfolQ23UgqFviwWxdpyWIDfJ+zAyx0XUrvIzOAdI6KcQ/oxLYwerIcxLwJcaYR
         DaR6O0B7hpF3ZAd+rrckcqP+lWYfRVC4SwmfDuJy6/ssAtoJOeXD28jPMoAHYRM8N3IY
         pa0NWMBiFWrTZ13bV1a8lVOHt7x0BcFW/O8FVV8+k6Og2EViJkg+AuE3wThroJ1dPV42
         rCMQ==
X-Gm-Message-State: AOJu0Yw/ANMjsWgiilMntmU5kkIHZdnJX67zfHQTeA+/h+8Ij/nNBkqo
	Hg7Hu2O5PGq86SngOeK/3s7G4g==
X-Google-Smtp-Source: AGHT+IGNSM6e3xFUqMvBQR9R3t5Cir3zM71HhCbB7/QfhmBw0kWQ/gx8kCtf/CvGDbAqdCivvEvQMQ==
X-Received: by 2002:a05:6214:20e7:b0:67f:26f3:ca56 with SMTP id 7-20020a05621420e700b0067f26f3ca56mr10139820qvk.102.1703062052777;
        Wed, 20 Dec 2023 00:47:32 -0800 (PST)
Received: from krzk-bin.. ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id g18-20020a0ce752000000b0067abfe5709dsm11168847qvn.139.2023.12.20.00.47.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Dec 2023 00:47:31 -0800 (PST)
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
Subject: [GIT PULL 2/2] arm64: dts: samsung: DTS for v6.8, part two
Date: Wed, 20 Dec 2023 09:47:22 +0100
Message-Id: <20231220084722.22149-2-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20231220084722.22149-1-krzysztof.kozlowski@linaro.org>
References: <20231220084722.22149-1-krzysztof.kozlowski@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This is second pull request for arm64 Samsung DTS. Previous (part one):
https://lore.kernel.org/all/20231212093105.13938-1-krzysztof.kozlowski@linaro.org/

I did not receive any notification that you pulled in previous (part one) pull,
thus I attach below two diffs:
A. Against previous pull, tags/samsung-dt64-6.8
B. Against master, v6.7-rc1

This includes topic branch, see explanation in pull-request/tag. Most of the
bindings patches affect DTS, because they include compatible-refactoring.  This
refactoring affects new device support - ExynosAutov920 and Google GS101 -
thus everything comes together.

Best regards,
Krzysztof


The following changes since commit 40af852a7ca59d23ab4afd02af2623121da2f116:

  Merge branch 'for-v6.8/samsung-bindings-compatibles' into next/dt64 (2023-12-11 08:41:24 +0100)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-6.8-2

for you to fetch changes up to d0da0de31e1d50ff905eb8f095628eea666f8c67:

  MAINTAINERS: adjust file entry in GOOGLE TENSOR SoC SUPPORT (2023-12-18 11:15:51 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v6.8, part two

1. Tesla FSD: Add Multi Format Codec (MFC) device nodes, for accelerated
   video de/encoding.

2. Add initial Google Tensor GS101 SoC support. The GS101 SoC can be
   found on Google Pixel 6 phones.  Currently the DTS brings only basic
   support: core clock controllers, pin controllers, serial, watchdog
   and ARM core blocks.

----------------------------------------------------------------
Aakarsh Jain (1):
      arm64: dts: fsd: Add MFC related DT enteries

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry in GOOGLE TENSOR SoC SUPPORT

Peter Griffin (4):
      dt-bindings: arm: google: Add bindings for Google ARM platforms
      arm64: dts: exynos: google: Add initial Google gs101 SoC support
      arm64: dts: exynos: google: Add initial Oriole/pixel 6 board support
      MAINTAINERS: add entry for Google Tensor SoC

 Documentation/devicetree/bindings/arm/google.yaml  |   53 +
 MAINTAINERS                                        |   10 +
 arch/arm64/boot/dts/exynos/Makefile                |    2 +
 arch/arm64/boot/dts/exynos/google/Makefile         |    4 +
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts |  105 ++
 .../boot/dts/exynos/google/gs101-pinctrl.dtsi      | 1249 ++++++++++++++++++++
 arch/arm64/boot/dts/exynos/google/gs101-pinctrl.h  |   33 +
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |  473 ++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi                 |   21 +
 9 files changed, 1950 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/arm/google.yaml
 create mode 100644 arch/arm64/boot/dts/exynos/google/Makefile
 create mode 100644 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
 create mode 100644 arch/arm64/boot/dts/exynos/google/gs101-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/google/gs101-pinctrl.h
 create mode 100644 arch/arm64/boot/dts/exynos/google/gs101.dtsi



----------------------------------------------------------------
----------------------------------------------------------------

DIFF against master/v6.7-rc1
----------------------------------------------------------------
The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux.git tags/samsung-dt64-6.8-2

for you to fetch changes up to d0da0de31e1d50ff905eb8f095628eea666f8c67:

  MAINTAINERS: adjust file entry in GOOGLE TENSOR SoC SUPPORT (2023-12-18 11:15:51 +0100)

----------------------------------------------------------------
Samsung DTS ARM64 changes for v6.8, part two

1. Tesla FSD: Add Multi Format Codec (MFC) device nodes, for accelerated
   video de/encoding.

2. Add initial Google Tensor GS101 SoC support. The GS101 SoC can be
   found on Google Pixel 6 phones.  Currently the DTS brings only basic
   support: core clock controllers, pin controllers, serial, watchdog
   and ARM core blocks.

----------------------------------------------------------------
Aakarsh Jain (1):
      arm64: dts: fsd: Add MFC related DT enteries

Jaewon Kim (10):
      arm64: dts: exynos: add gpio-key node for exynosautov9-sadk
      dt-bindings: samsung: exynos-sysreg: add exynosautov920 sysreg
      dt-bindings: samsung: exynos-pmu: add exynosautov920 compatible
      dt-bindings: samsung: usi: add exynosautov920-usi compatible
      dt-bindings: serial: samsung: add exynosautov920-uart compatible
      dt-bindings: pwm: samsung: add exynosautov920 compatible
      dt-bindings: arm: samsung: Document exynosautov920 SADK board binding
      dt-bindings: hwinfo: samsung,exynos-chipid: add exynosautov920 compatible
      arm64: dts: exynos: add initial support for exynosautov920 SoC
      arm64: dts: exynos: add minimal support for exynosautov920 sadk board

Krzysztof Kozlowski (28):
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
      arm64: dts: exynos5433: add specific compatibles to several blocks
      arm64: dts: exynos7: add specific compatibles to several blocks
      arm64: dts: exynos7885: add specific compatibles to several blocks
      arm64: dts: exynos850: add specific compatibles to several blocks
      arm64: dts: exynosautov9: add specific compatibles to several blocks
      Merge branch 'for-v6.8/samsung-bindings-compatibles' into next/dt64
      arm64: dts: exynos850: use Exynos7 fallbacks for pin wake-up controllers
      arm64: dts: exynosautov9: use Exynos7 fallbacks for pin wake-up controller
      dt-bindings: i2c: exynos5: add specific compatible for Tesla FSD
      dt-bindings: pwm: samsung: add specific compatible for Tesla FSD
      dt-bindings: serial: samsung: add specific compatible for Tesla FSD
      dt-bindings: samsung: exynos-pmu: add specific compatible for Tesla FSD
      dt-bindings: watchdog: samsung: add specific compatible for Tesla FSD
      Merge branch 'for-v6.8/samsung-bindings-compatibles' into next/dt64
      arm64: dts: fsd: add specific compatibles for Tesla FSD
      dt-bindings: samsung: exynos-sysreg: combine exynosautov920 with other enum
      Merge branch 'for-v6.8/samsung-bindings-compatibles' into next/dt64

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry in GOOGLE TENSOR SoC SUPPORT

Peter Griffin (7):
      dt-bindings: soc: samsung: exynos-pmu: Add gs101 compatible
      dt-bindings: clock: Add Google gs101 clock management unit bindings
      dt-bindings: soc: google: exynos-sysreg: add dedicated SYSREG compatibles to GS101
      dt-bindings: arm: google: Add bindings for Google ARM platforms
      arm64: dts: exynos: google: Add initial Google gs101 SoC support
      arm64: dts: exynos: google: Add initial Oriole/pixel 6 board support
      MAINTAINERS: add entry for Google Tensor SoC

 Documentation/devicetree/bindings/arm/google.yaml  |   53 +
 .../bindings/arm/samsung/samsung-boards.yaml       |    6 +
 .../bindings/clock/google,gs101-clock.yaml         |  106 ++
 .../devicetree/bindings/gpu/arm,mali-midgard.yaml  |    5 +
 .../bindings/hwinfo/samsung,exynos-chipid.yaml     |   18 +-
 .../devicetree/bindings/i2c/i2c-exynos5.yaml       |   11 +-
 .../bindings/i2c/samsung,s3c2410-i2c.yaml          |   22 +-
 .../bindings/iio/adc/samsung,exynos-adc.yaml       |   29 +-
 .../bindings/mfd/samsung,exynos5433-lpass.yaml     |    2 +-
 .../bindings/mmc/samsung,exynos-dw-mshc.yaml       |   25 +-
 .../devicetree/bindings/pwm/pwm-samsung.yaml       |    4 +
 Documentation/devicetree/bindings/rtc/s3c-rtc.yaml |    5 +
 .../devicetree/bindings/serial/samsung_uart.yaml   |   17 +-
 .../bindings/soc/samsung/exynos-pmu.yaml           |   10 +
 .../bindings/soc/samsung/exynos-usi.yaml           |    6 +-
 .../soc/samsung/samsung,exynos-sysreg.yaml         |    5 +
 .../devicetree/bindings/sound/samsung-i2s.yaml     |   19 +-
 .../devicetree/bindings/watchdog/samsung-wdt.yaml  |   21 +-
 MAINTAINERS                                        |   10 +
 arch/arm64/boot/dts/exynos/Makefile                |    5 +-
 arch/arm64/boot/dts/exynos/exynos5433.dtsi         |   60 +-
 arch/arm64/boot/dts/exynos/exynos7.dtsi            |   18 +-
 arch/arm64/boot/dts/exynos/exynos7885.dtsi         |   45 +-
 arch/arm64/boot/dts/exynos/exynos850.dtsi          |   40 +-
 arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts   |   51 +
 arch/arm64/boot/dts/exynos/exynosautov9.dtsi       |   10 +-
 .../boot/dts/exynos/exynosautov920-pinctrl.dtsi    | 1266 ++++++++++++++++++++
 arch/arm64/boot/dts/exynos/exynosautov920-sadk.dts |   88 ++
 arch/arm64/boot/dts/exynos/exynosautov920.dtsi     |  312 +++++
 arch/arm64/boot/dts/exynos/google/Makefile         |    4 +
 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts |  105 ++
 .../boot/dts/exynos/google/gs101-pinctrl.dtsi      | 1249 +++++++++++++++++++
 arch/arm64/boot/dts/exynos/google/gs101-pinctrl.h  |   33 +
 arch/arm64/boot/dts/exynos/google/gs101.dtsi       |  473 ++++++++
 arch/arm64/boot/dts/tesla/fsd.dtsi                 |   53 +-
 include/dt-bindings/clock/google,gs101.h           |  392 ++++++
 36 files changed, 4444 insertions(+), 134 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/arm/google.yaml
 create mode 100644 Documentation/devicetree/bindings/clock/google,gs101-clock.yaml
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920-sadk.dts
 create mode 100644 arch/arm64/boot/dts/exynos/exynosautov920.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/google/Makefile
 create mode 100644 arch/arm64/boot/dts/exynos/google/gs101-oriole.dts
 create mode 100644 arch/arm64/boot/dts/exynos/google/gs101-pinctrl.dtsi
 create mode 100644 arch/arm64/boot/dts/exynos/google/gs101-pinctrl.h
 create mode 100644 arch/arm64/boot/dts/exynos/google/gs101.dtsi
 create mode 100644 include/dt-bindings/clock/google,gs101.h

