Return-Path: <linux-kernel+bounces-25696-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A3682D4B2
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 08:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DE80D2818EA
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Jan 2024 07:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93DB95233;
	Mon, 15 Jan 2024 07:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="m9717ycY"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C35773D62
	for <linux-kernel@vger.kernel.org>; Mon, 15 Jan 2024 07:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-5f2d4aaa2fdso84635787b3.1
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jan 2024 23:51:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705305094; x=1705909894; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GxBBKtNr4j1Zw6G8/XAnP1W1r1q5f1ABR8/aKWNqEn4=;
        b=m9717ycYsNJZut1fIGd4TtrUtOuw94lvWUD6bClvWbeGMxeiYGxw538yfdIveslMaM
         rfwSIdo5M4a2g65TlcPtOhjZMV4XRzRWlKWj6Knck9HN+baVZCZURBssV9zp8cvFuYxC
         8CO4Xw1vRGGRY6ZZ+6xrIh2kuNt2or/ljaorA4h5U+YhF2fXPucCua9lbFYlJPZMmbqU
         g8tNsk9oneUm9o6QwAjILvq61Cuym0Wg519N0OgZ+RNKcmpHtZ4ElXPPpM/t+MbzDmQW
         OKMHQQgigav/wqWJ39EOENdueCe2XcXcAd6K8CTZbTBh1RT3ixqTSEDiXdp8nIJ3K5CD
         1jPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705305094; x=1705909894;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GxBBKtNr4j1Zw6G8/XAnP1W1r1q5f1ABR8/aKWNqEn4=;
        b=igzT6i0YrfHCeu9ksPxicoX+G7XHpqNHdzyAIaFM/eYZn1Hb4L+d23Yarz+jHl59x/
         1GNfrLuU0Rjsr8CK3o2bDHq1VQmmVFs0wLqZ4S1JOtxUNwbMPQLJ0Cl7yYzXmjw+urLo
         XD7qYP44P34Vykac2SHS3+fWReoZ5tb13nBDjXXBtn+GOAQQNHVSkOb8dSDLAzD1sE+b
         ZkqH/qlJT61nio62TZ74Y3G2Gzi1Hkcdfy9TeO53AqCxSR9C75KDdvue/HkdlXIRxKO0
         GkIkfMDmTZhJr6rPAksXS9hq8MIfrFpskHzOo5tI7eoeDsFw03cXoBwI2ZbVNAb51LM9
         DL7A==
X-Gm-Message-State: AOJu0YzHE0BzXI1s6KpEv7jcXE/FKiMtPbm7/uPRJnTUaic51LFumfhP
	PzaHE8KnCOwTo1jYI6wcSqZWIBTYQ1KCzMLWmyXv0YNJ+NRoUQ==
X-Google-Smtp-Source: AGHT+IFvxrn4OEvwdwSds3UsvWVHYgcJJaD3c3eUU8NEzeivqpXEI3ZMhZeaCcmDCPYR7d1Tqo4YGzO0adNxUtu6J3E=
X-Received: by 2002:a81:de4d:0:b0:5d7:1940:f3e0 with SMTP id
 o13-20020a81de4d000000b005d71940f3e0mr3846288ywl.72.1705305093641; Sun, 14
 Jan 2024 23:51:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Linus Walleij <linus.walleij@linaro.org>
Date: Mon, 15 Jan 2024 08:51:22 +0100
Message-ID: <CACRpkdaSdLQ7_ekbAPBqyEJSN37w5dmwA0PA--GEpSqEFXDuXw@mail.gmail.com>
Subject: [GIT PULL] pin control changes for v6.8
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>, 
	"open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Linus,

this is the bulk of the pin control changes for the v6.8 kernel cycle.

For this kernel cycle I managed an immutable branch for the PEF2256
WAN framer that has some pin control portions. It should already have
landed in your tree through the net pull request but here it is again.

The most interesting is perhaps the Samsung Exynos subdrivers for
the Tensor SoC used in Google Pixel 6 and the ExynosAuto subdriver
for automotive. Along with the earlier merged Tesla FSD subdriver it
shows some of the versatile uses of the Samsung Exynos silicon. It is
also used in the latest version of Axis Communications ARTPEC
chips so it is a very widely deployed SoC family.

We also have the Intel Meteor Lake SoC which I think is for laptops.
It's a pretty interesting chip with Xe graphics and integrated PCH.
https://en.wikipedia.org/wiki/Meteor_Lake

More details in the signed tag as always.

Please pull it in!

Yours,
Linus Walleij

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/linusw/linux-pinctrl.git
tags/pinctrl-v6.8-1

for you to fetch changes up to 1b09c2b8f849079220a9a9ddf961582f00bdc2c4:

  pinctrl: samsung: constify iomem pointers (2023-12-28 22:13:17 +0100)

----------------------------------------------------------------
This is the main pin control pull request for the v6.8 kernel series.

Core changes:

- A new PINCTRL_GROUP_DESC() infrastructure macro is added and
  used in different drivers, generic group description struct
  group_desc is now used all over the place.

New drivers:

- New driver for the Texas Instruments TPS6494 Power Management IC.

- New driver for the Lantic PEF2256 framer pin multiplexer.
  This IC has some pins that can be reconfigured in different
  ways. The actual driver comes on an immutable branch with the
  net WAN parts, the IC is some latest-and-greatest serial line
  funnel for e.g. wireless access points.

- New subdriver for the Samsung Exynos Auto V920 pin controller,
  used for automotive applications.

- New subdriver for the Samsung "GS101" SoC pin controller, this
  is the Google "Tensor" SoC used in the Google Pixel 6.

- New subdriver for the Intel Meteor Point SoC pin controller.

- New subdriver for the Qualcomm SM8650 top level (TLMM) and LPASS pin
  controllers.

- New subdriver for the Qualcomm X1E80100 top level (TLMM) pin
  controller.

- New subdriver for the Qualcomm SM4450 top level (TLMM) pin
  controller.

- The "single" pin controller now supports the Texas Instruments
  J7200 SoC.

Improvements:

- Intel has created a new (Intel-)generic pin controller driver that
  is now used by all contemporary Intel platforms.

- Intel is now also making use of some cleanup helpers.

- Enble 910 Ohm bias in the Intel Tangier driver.

- The Samsung driver now suppors irq_set_affinity() in it's IRQ chip
  giving support for non wake up external gpio interrupts.

----------------------------------------------------------------
Andrew Davis (1):
      pinctrl: as3722: Use devm_gpiochip_add_data() to simplify remove path

Andy Shevchenko (55):
      pinctrl: intel: Provide Intel pin control wide PM ops structure
      pinctrl: alderlake: Switch to use Intel pin control PM ops
      pinctrl: broxton: Switch to use Intel pin control PM ops
      pinctrl: cannonlake: Switch to use Intel pin control PM ops
      pinctrl: cedarfork: Switch to use Intel pin control PM ops
      pinctrl: denverton: Switch to use Intel pin control PM ops
      pinctrl: elkhartlake: Switch to use Intel pin control PM ops
      pinctrl: emmitsburg: Switch to use Intel pin control PM ops
      pinctrl: geminilake: Switch to use Intel pin control PM ops
      pinctrl: icelake: Switch to use Intel pin control PM ops
      pinctrl: jasperlake: Switch to use Intel pin control PM ops
      pinctrl: lakefield: Switch to use Intel pin control PM ops
      pinctrl: lewisburg: Switch to use Intel pin control PM ops
      pinctrl: meteorlake: Switch to use Intel pin control PM ops
      pinctrl: sunrisepoint: Switch to use Intel pin control PM ops
      pinctrl: tigerlake: Switch to use Intel pin control PM ops
      pinctrl: intel: Make PM ops functions static
      Merge patch series "pinctrl: intel: Use NOIRQ PM helper"
      pinctrl: tangier: Enable 910 Ohm bias
      pinctrl: tangier: Move default strength assignment to a switch-case
      pinctrl: intel: Move default strength assignment to a switch-case
      pinctrl: intel: Refactor intel_pinctrl_get_soc_data()
      pinctrl: intel: Revert "Unexport intel_pinctrl_probe()"
      pinctrl: intel: Add a generic Intel pin control platform driver
      pinctrl: lynxpoint: Simplify code with cleanup helpers
      pinctrl: baytrail: Fix types of config value in byt_pin_config_set()
      pinctrl: baytrail: Factor out byt_gpio_force_input_mode()
      pinctrl: baytrail: Move default strength assignment to a switch-case
      pinctrl: baytrail: Simplify code with cleanup helpers
      pinctrl: qcom: lpass-lpi: Replace kernel.h with what is being used
      pinctrl: qcom: lpass-lpi: Remove unused member in struct lpi_pingroup
      pinctrl: equilibrium: Unshadow error code of of_property_count_u32_elems()
      pinctrl: equilibrium: Use temporary variable to hold pins
      pinctrl: imx: Use temporary variable to hold pins
      pinctrl: Convert unsigned to unsigned int
      pinctrl: mediatek: Switch to use no-IRQ PM helpers
      pinctrl: renesas: Mark local variable with const in ->set_mux()
      pinctrl: core: Make pins const unsigned int pointer in struct group_desc
      pinctrl: equilibrium: Convert to use struct pingroup
      pinctrl: keembay: Convert to use struct pingroup
      pinctrl: nuvoton: Convert to use struct pingroup and PINCTRL_PINGROUP()
      pinctrl: core: Add a convenient define PINCTRL_GROUP_DESC()
      pinctrl: mediatek: Use C99 initializers in PINCTRL_PIN_GROUP()
      pinctrl: ingenic: Use C99 initializers in PINCTRL_PIN_GROUP()
      pinctrl: core: Embed struct pingroup into struct group_desc
      pinctrl: bcm: Convert to use grp member
      pinctrl: equilibrium: Convert to use grp member
      pinctrl: imx: Convert to use grp member
      pinctrl: ingenic: Convert to use grp member
      pinctrl: keembay: Convert to use grp member
      pinctrl: mediatek: Convert to use grp member
      pinctrl: renesas: Convert to use grp member
      pinctrl: starfive: Convert to use grp member
      pinctrl: core: Remove unused members from struct group_desc
      pinctrl: intel: Add Intel Meteor Point pin controller and GPIO support

Bartosz Golaszewski (13):
      gpiolib: provide gpio_device_get_label()
      pinctrl: stop using gpiod_to_chip()
      pinctrl: don't include GPIOLIB private header
      gpiolib: provide gpiochip_dup_line_label()
      gpio: wm831x: use gpiochip_dup_line_label()
      gpio: wm8994: use gpiochip_dup_line_label()
      gpio: stmpe: use gpiochip_dup_line_label()
      pinctrl: abx500: use gpiochip_dup_line_label()
      pinctrl: nomadik: use gpiochip_dup_line_label()
      pinctrl: baytrail: use gpiochip_dup_line_label()
      pinctrl: sppctl: use gpiochip_dup_line_label()
      gpiolib: use gpiochip_dup_line_label() in for_each helpers
      gpiolib: remove gpiochip_is_requested()

Claudiu Beznea (5):
      pinctrl: renesas: rzg2l: Move arg and index in the main function block
      pinctrl: renesas: rzg2l: Add pin configuration support for pinmux groups
      pinctrl: renesas: rzg2l: Add support to select power source for
Ethernet pins
      pinctrl: renesas: rzg2l: Add output enable support
      pinctrl: renesas: rzg2l: Add input enable to the Ethernet pins

Esteban Blanc (1):
      pinctrl: tps6594: Add driver for TPS6594 pinctrl and GPIOs

Herve Codina (5):
      net: wan: Add framer framework support
      dt-bindings: net: Add the Lantiq PEF2256 E1/T1/J1 framer
      net: wan: framer: Add support for the Lantiq PEF2256 framer
      pinctrl: Add support for the Lantic PEF2256 pinmux
      MAINTAINERS: Add the Lantiq PEF2256 driver entry

Jaewon Kim (3):
      dt-bindings: pinctrl: samsung: add exynosautov920
      pinctrl: samsung: support ExynosAuto GPIO structure
      pinctrl: samsung: add exynosautov920 pinctrl

Johan Hovold (1):
      dt-bindings: pinctrl: qcom,pmic-mpp: clean up example

Krzysztof Kozlowski (19):
      dt-bindings: pinctrl: qcom,sm8650-lpass-lpi-pinctrl: add SM8650 LPASS
      pinctrl: qcom: sm8650-lpass-lpi: add SM8650 LPASS
      pinctrl: qcom: lpass-lpi: split slew rate set to separate function
      pinctrl: qcom: lpass-lpi: allow slew rate bit in main pin config register
      dt-bindings: pinctrl: samsung: add specific compatibles for existing SoC
      dt-bindings: pinctrl: samsung: use Exynos7 fallbacks for newer
wake-up controllers
      dt-bindings: pinctrl: qcom,sm8550-lpass-lpi: add X1E80100 LPASS LPI
      dt-bindings: pinctrl: samsung: correct ExynosAutov920 wake-up compatibles
      dt-bindings: pinctrl: qcom: create common LPASS LPI schema
      dt-bindings: pinctrl: qcom,qdu1000-tlmm: restrict number of interrupts
      dt-bindings: pinctrl: qcom,sa8775p-tlmm: restrict number of interrupts
      dt-bindings: pinctrl: qcom,sdx75-tlmm: restrict number of interrupts
      dt-bindings: pinctrl: qcom,sm8550-tlmm: restrict number of interrupts
      dt-bindings: pinctrl: qcom,sm8650-tlmm: restrict number of interrupts
      dt-bindings: pinctrl: qcom,x1e80100-tlmm: restrict number of interrupts
      dt-bindings: pinctrl: qcom,ipq5018-tlmm: use common TLMM bindings
      dt-bindings: pinctrl: qcom: drop common properties
      dt-bindings: pinctrl: qcom: drop common properties and allow wakeup-parent
      pinctrl: samsung: constify iomem pointers

Lad Prabhakar (1):
      pinctrl: renesas: rzg2l: Enhance driver to support interrupt
affinity setting

Linus Walleij (7):
      Merge tag 'gpio-device-get-label-for-v6.8-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into devel
      Merge tag 'renesas-pinctrl-for-v6.8-tag1' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into devel
      Merge tag 'gpio-remove-gpiochip_is_requested-for-v6.8-rc1' of
git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux into devel
      Merge tag 'pef2256-framer' into devel
      Merge tag 'renesas-pinctrl-for-v6.8-tag2' of
git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers
into devel
      Merge tag 'samsung-pinctrl-6.8' of
https://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/samsung into
devel
      Merge tag 'intel-pinctrl-v6.8-1' of
git://git.kernel.org/pub/scm/linux/kernel/git/pinctrl/intel into devel

Michal Simek (1):
      dt-bindings: pinctrl: xilinx: Rename *gpio to *gpio-grp

Neil Armstrong (3):
      dt-bindings: pinctrl: document the SM8650 Top Level Mode Multiplexer
      pinctrl: qcom: handle intr_target_reg wakeup_present/enable bits
      pinctrl: qcom: Introduce the SM8650 Top Level Mode Multiplexer driver

Patrick Rudolph (1):
      pinctrl: cy8c95x0: Cache muxed registers

Peter Griffin (3):
      dt-bindings: pinctrl: samsung: add google,gs101-pinctrl compatible
      dt-bindings: pinctrl: samsung: add gs101-wakeup-eint compatible
      pinctrl: samsung: Add gs101 SoC pinctrl configuration

Petr Vorel (1):
      MAINTAINERS: Remove snawrocki's git tree

Raag Jadav (3):
      pinctrl: intel: allow independent COMPILE_TEST
      pinctrl: intel: use the correct _PM_OPS() export macro
      pinctrl: tangier: simplify locking using cleanup helpers

Rajendra Nayak (2):
      dt-bindings: pinctrl: qcom: Add X1E80100 pinctrl
      pinctrl: qcom: Add X1E80100 pinctrl driver

Richard Acayan (1):
      pinctrl: qcom: fail to retrieve configuration from invalid pin groups

Rob Herring (1):
      dt-bindings: pinctrl: renesas: Drop unneeded quotes

Sergey Shtylyov (1):
      pinctrl: stm32: return errors from stm32_gpio_direction_output()

Tengfei Fan (2):
      dt-bindings: pinctrl: qcom: Add SM4450 pinctrl
      pinctrl: qcom: sm4450: dd SM4450 pinctrl driver

Thierry Reding (1):
      pinctrl: tegra: Display pin function in pinconf-groups

Thomas Richard (2):
      dt-bindings: pinctrl: pinctrl-single: add ti,j7200-padconf compatible
      pinctrl: pinctrl-single: add ti,j7200-padconf compatible

Tomer Maimon (1):
      pinctrl: npcm7xx: prevent glitch when setting the GPIO to output high

Wang Jinchao (1):
      pinctrl: qcom: lpass-lpi: remove duplicated include

Youngmin Nam (1):
      pinctrl: samsung: add irq_set_affinity() for non wake up
external gpio interrupt

 .../devicetree/bindings/net/lantiq,pef2256.yaml    |  213 +++
 .../bindings/pinctrl/pinctrl-single.yaml           |    1 +
 .../bindings/pinctrl/qcom,ipq5018-tlmm.yaml        |   12 +-
 .../bindings/pinctrl/qcom,ipq5332-tlmm.yaml        |    9 +-
 .../bindings/pinctrl/qcom,ipq6018-pinctrl.yaml     |    8 +-
 .../bindings/pinctrl/qcom,ipq8074-pinctrl.yaml     |    9 +-
 .../bindings/pinctrl/qcom,ipq9574-tlmm.yaml        |    9 +-
 .../bindings/pinctrl/qcom,lpass-lpi-common.yaml    |   75 +
 .../bindings/pinctrl/qcom,mdm9607-tlmm.yaml        |   18 +-
 .../bindings/pinctrl/qcom,mdm9615-pinctrl.yaml     |   18 +-
 .../bindings/pinctrl/qcom,msm8226-pinctrl.yaml     |    8 +-
 .../bindings/pinctrl/qcom,msm8660-pinctrl.yaml     |    9 +-
 .../bindings/pinctrl/qcom,msm8909-tlmm.yaml        |   18 +-
 .../bindings/pinctrl/qcom,msm8916-pinctrl.yaml     |    9 +-
 .../bindings/pinctrl/qcom,msm8953-pinctrl.yaml     |    7 +-
 .../bindings/pinctrl/qcom,msm8960-pinctrl.yaml     |    9 +-
 .../bindings/pinctrl/qcom,msm8974-pinctrl.yaml     |    9 +-
 .../bindings/pinctrl/qcom,msm8976-pinctrl.yaml     |    9 +-
 .../bindings/pinctrl/qcom,msm8994-pinctrl.yaml     |    9 +-
 .../bindings/pinctrl/qcom,msm8996-pinctrl.yaml     |    9 +-
 .../bindings/pinctrl/qcom,msm8998-pinctrl.yaml     |    9 +-
 .../devicetree/bindings/pinctrl/qcom,pmic-mpp.yaml |   62 +-
 .../bindings/pinctrl/qcom,qcm2290-tlmm.yaml        |    9 +-
 .../bindings/pinctrl/qcom,qcs404-pinctrl.yaml      |    9 +-
 .../bindings/pinctrl/qcom,qdu1000-tlmm.yaml        |   12 +-
 .../bindings/pinctrl/qcom,sa8775p-tlmm.yaml        |   21 +-
 .../bindings/pinctrl/qcom,sc7180-pinctrl.yaml      |    9 +-
 .../pinctrl/qcom,sc7280-lpass-lpi-pinctrl.yaml     |   49 +-
 .../bindings/pinctrl/qcom,sc7280-pinctrl.yaml      |   30 +-
 .../bindings/pinctrl/qcom,sc8180x-tlmm.yaml        |   20 +-
 .../pinctrl/qcom,sc8280xp-lpass-lpi-pinctrl.yaml   |   49 +-
 .../bindings/pinctrl/qcom,sc8280xp-tlmm.yaml       |   18 +-
 .../bindings/pinctrl/qcom,sdm630-pinctrl.yaml      |   10 +-
 .../bindings/pinctrl/qcom,sdm670-tlmm.yaml         |   19 +-
 .../bindings/pinctrl/qcom,sdm845-pinctrl.yaml      |   10 +-
 .../bindings/pinctrl/qcom,sdx55-pinctrl.yaml       |    8 +-
 .../bindings/pinctrl/qcom,sdx65-tlmm.yaml          |    8 +-
 .../bindings/pinctrl/qcom,sdx75-tlmm.yaml          |   12 +-
 .../bindings/pinctrl/qcom,sm4450-tlmm.yaml         |  151 ++
 .../pinctrl/qcom,sm6115-lpass-lpi-pinctrl.yaml     |   48 +-
 .../bindings/pinctrl/qcom,sm6115-tlmm.yaml         |    8 +-
 .../bindings/pinctrl/qcom,sm6125-tlmm.yaml         |   20 +-
 .../bindings/pinctrl/qcom,sm6350-tlmm.yaml         |   20 +-
 .../bindings/pinctrl/qcom,sm6375-tlmm.yaml         |   18 +-
 .../bindings/pinctrl/qcom,sm7150-tlmm.yaml         |    9 +-
 .../bindings/pinctrl/qcom,sm8150-pinctrl.yaml      |    9 +-
 .../pinctrl/qcom,sm8250-lpass-lpi-pinctrl.yaml     |   49 +-
 .../bindings/pinctrl/qcom,sm8250-pinctrl.yaml      |    9 +-
 .../pinctrl/qcom,sm8350-lpass-lpi-pinctrl.yaml     |   49 +-
 .../bindings/pinctrl/qcom,sm8350-tlmm.yaml         |   20 +-
 .../pinctrl/qcom,sm8450-lpass-lpi-pinctrl.yaml     |   49 +-
 .../bindings/pinctrl/qcom,sm8450-tlmm.yaml         |   20 +-
 .../pinctrl/qcom,sm8550-lpass-lpi-pinctrl.yaml     |   55 +-
 .../bindings/pinctrl/qcom,sm8550-tlmm.yaml         |   12 +-
 .../pinctrl/qcom,sm8650-lpass-lpi-pinctrl.yaml     |  107 ++
 .../bindings/pinctrl/qcom,sm8650-tlmm.yaml         |  141 ++
 .../bindings/pinctrl/qcom,x1e80100-tlmm.yaml       |  137 ++
 .../bindings/pinctrl/renesas,rza2-pinctrl.yaml     |    2 +-
 .../pinctrl/samsung,pinctrl-wakeup-interrupt.yaml  |   45 +-
 .../bindings/pinctrl/samsung,pinctrl.yaml          |    5 +-
 .../bindings/pinctrl/xlnx,zynq-pinctrl.yaml        |    2 +-
 .../bindings/pinctrl/xlnx,zynqmp-pinctrl.yaml      |    2 +-
 MAINTAINERS                                        |    9 +-
 drivers/gpio/gpio-stmpe.c                          |    6 +-
 drivers/gpio/gpio-wm831x.c                         |   14 +-
 drivers/gpio/gpio-wm8994.c                         |   13 +-
 drivers/gpio/gpiolib.c                             |   49 +-
 drivers/net/wan/Kconfig                            |    2 +
 drivers/net/wan/Makefile                           |    2 +
 drivers/net/wan/framer/Kconfig                     |   42 +
 drivers/net/wan/framer/Makefile                    |    7 +
 drivers/net/wan/framer/framer-core.c               |  882 +++++++++
 drivers/net/wan/framer/pef2256/Makefile            |    8 +
 drivers/net/wan/framer/pef2256/pef2256-regs.h      |  250 +++
 drivers/net/wan/framer/pef2256/pef2256.c           |  880 +++++++++
 drivers/pinctrl/Kconfig                            |   31 +
 drivers/pinctrl/Makefile                           |    2 +
 drivers/pinctrl/bcm/pinctrl-ns.c                   |    4 +-
 drivers/pinctrl/core.c                             |   59 +-
 drivers/pinctrl/core.h                             |   33 +-
 drivers/pinctrl/devicetree.c                       |    8 +-
 drivers/pinctrl/freescale/pinctrl-imx.c            |   44 +-
 drivers/pinctrl/intel/Kconfig                      |   21 +-
 drivers/pinctrl/intel/Makefile                     |    2 +
 drivers/pinctrl/intel/pinctrl-alderlake.c          |    5 +-
 drivers/pinctrl/intel/pinctrl-baytrail.c           |  240 +--
 drivers/pinctrl/intel/pinctrl-broxton.c            |    5 +-
 drivers/pinctrl/intel/pinctrl-cannonlake.c         |    5 +-
 drivers/pinctrl/intel/pinctrl-cedarfork.c          |    5 +-
 drivers/pinctrl/intel/pinctrl-denverton.c          |    5 +-
 drivers/pinctrl/intel/pinctrl-elkhartlake.c        |    5 +-
 drivers/pinctrl/intel/pinctrl-emmitsburg.c         |    5 +-
 drivers/pinctrl/intel/pinctrl-geminilake.c         |    5 +-
 drivers/pinctrl/intel/pinctrl-icelake.c            |    5 +-
 drivers/pinctrl/intel/pinctrl-intel-platform.c     |  225 +++
 drivers/pinctrl/intel/pinctrl-intel.c              |   32 +-
 drivers/pinctrl/intel/pinctrl-intel.h              |   14 +-
 drivers/pinctrl/intel/pinctrl-jasperlake.c         |    5 +-
 drivers/pinctrl/intel/pinctrl-lakefield.c          |    5 +-
 drivers/pinctrl/intel/pinctrl-lewisburg.c          |    5 +-
 drivers/pinctrl/intel/pinctrl-lynxpoint.c          |   72 +-
 drivers/pinctrl/intel/pinctrl-meteorlake.c         |    5 +-
 drivers/pinctrl/intel/pinctrl-meteorpoint.c        |  465 +++++
 drivers/pinctrl/intel/pinctrl-sunrisepoint.c       |    5 +-
 drivers/pinctrl/intel/pinctrl-tangier.c            |   32 +-
 drivers/pinctrl/intel/pinctrl-tigerlake.c          |    5 +-
 drivers/pinctrl/mediatek/pinctrl-moore.c           |   13 +-
 drivers/pinctrl/mediatek/pinctrl-moore.h           |   10 +-
 drivers/pinctrl/mediatek/pinctrl-mt2701.c          |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mt2712.c          |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mt6795.c          |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8167.c          |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8173.c          |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8183.c          |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8186.c          |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8188.c          |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8192.c          |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8195.c          |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8365.c          |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mt8516.c          |    2 +-
 drivers/pinctrl/mediatek/pinctrl-mtk-common.c      |    5 +-
 drivers/pinctrl/mediatek/pinctrl-paris.c           |    5 +-
 drivers/pinctrl/mediatek/pinctrl-paris.h           |   10 +-
 drivers/pinctrl/nomadik/pinctrl-abx500.c           |    9 +-
 drivers/pinctrl/nomadik/pinctrl-nomadik.c          |    6 +-
 drivers/pinctrl/nuvoton/pinctrl-npcm7xx.c          |    2 +-
 drivers/pinctrl/nuvoton/pinctrl-wpcm450.c          |    9 +-
 drivers/pinctrl/pinconf-generic.c                  |   16 +-
 drivers/pinctrl/pinconf.c                          |   14 +-
 drivers/pinctrl/pinconf.h                          |   10 +-
 drivers/pinctrl/pinctrl-as3722.c                   |   17 +-
 drivers/pinctrl/pinctrl-cy8c95x0.c                 |  458 +++--
 drivers/pinctrl/pinctrl-equilibrium.c              |   42 +-
 drivers/pinctrl/pinctrl-ingenic.c                  |   35 +-
 drivers/pinctrl/pinctrl-keembay.c                  |    6 +-
 drivers/pinctrl/pinctrl-pef2256.c                  |  358 ++++
 drivers/pinctrl/pinctrl-single.c                   |    5 +
 drivers/pinctrl/pinctrl-tps6594.c                  |  373 ++++
 drivers/pinctrl/pinctrl-utils.c                    |   26 +-
 drivers/pinctrl/pinctrl-utils.h                    |   18 +-
 drivers/pinctrl/pinmux.c                           |   36 +-
 drivers/pinctrl/pinmux.h                           |   20 +-
 drivers/pinctrl/qcom/Kconfig                       |   10 +
 drivers/pinctrl/qcom/Kconfig.msm                   |   26 +
 drivers/pinctrl/qcom/Makefile                      |    4 +
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c           |   70 +-
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h           |   13 +-
 drivers/pinctrl/qcom/pinctrl-msm.c                 |   46 +
 drivers/pinctrl/qcom/pinctrl-msm.h                 |    5 +
 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c    |   16 -
 drivers/pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c  |   20 -
 drivers/pinctrl/qcom/pinctrl-sm4450.c              | 1014 +++++++++++
 drivers/pinctrl/qcom/pinctrl-sm6115-lpass-lpi.c    |   20 -
 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c    |   15 -
 drivers/pinctrl/qcom/pinctrl-sm8350-lpass-lpi.c    |   16 -
 drivers/pinctrl/qcom/pinctrl-sm8450-lpass-lpi.c    |   24 -
 drivers/pinctrl/qcom/pinctrl-sm8550-lpass-lpi.c    |   24 -
 drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c    |  231 +++
 drivers/pinctrl/qcom/pinctrl-sm8650.c              | 1762 ++++++++++++++++++
 drivers/pinctrl/qcom/pinctrl-x1e80100.c            | 1876 ++++++++++++++++++++
 drivers/pinctrl/renesas/pinctrl-rza1.c             |    2 +-
 drivers/pinctrl/renesas/pinctrl-rza2.c             |   10 +-
 drivers/pinctrl/renesas/pinctrl-rzg2l.c            |  171 +-
 drivers/pinctrl/renesas/pinctrl-rzv2m.c            |    6 +-
 drivers/pinctrl/samsung/pinctrl-exynos-arm64.c     |  280 +++
 drivers/pinctrl/samsung/pinctrl-exynos.c           |  111 +-
 drivers/pinctrl/samsung/pinctrl-exynos.h           |   25 +
 drivers/pinctrl/samsung/pinctrl-samsung.c          |   11 +-
 drivers/pinctrl/samsung/pinctrl-samsung.h          |   14 +
 drivers/pinctrl/starfive/pinctrl-starfive-jh7100.c |    8 +-
 drivers/pinctrl/starfive/pinctrl-starfive-jh7110.c |    8 +-
 drivers/pinctrl/stm32/pinctrl-stm32.c              |    3 +-
 drivers/pinctrl/sunplus/sppctl.c                   |   10 +-
 drivers/pinctrl/tegra/pinctrl-tegra.c              |    8 +
 include/linux/framer/framer-provider.h             |  194 ++
 include/linux/framer/framer.h                      |  205 +++
 include/linux/framer/pef2256.h                     |   31 +
 include/linux/gpio/driver.h                        |   40 +-
 include/linux/pinctrl/machine.h                    |    6 +-
 include/linux/pinctrl/pinconf-generic.h            |   10 +-
 include/linux/pinctrl/pinconf.h                    |   16 +-
 include/linux/pinctrl/pinctrl.h                    |   24 +-
 include/linux/pinctrl/pinmux.h                     |   22 +-
 183 files changed, 11533 insertions(+), 1743 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/net/lantiq,pef2256.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,lpass-lpi-common.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sm8650-lpass-lpi-pinctrl.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,sm8650-tlmm.yaml
 create mode 100644
Documentation/devicetree/bindings/pinctrl/qcom,x1e80100-tlmm.yaml
 create mode 100644 drivers/net/wan/framer/Kconfig
 create mode 100644 drivers/net/wan/framer/Makefile
 create mode 100644 drivers/net/wan/framer/framer-core.c
 create mode 100644 drivers/net/wan/framer/pef2256/Makefile
 create mode 100644 drivers/net/wan/framer/pef2256/pef2256-regs.h
 create mode 100644 drivers/net/wan/framer/pef2256/pef2256.c
 create mode 100644 drivers/pinctrl/intel/pinctrl-intel-platform.c
 create mode 100644 drivers/pinctrl/intel/pinctrl-meteorpoint.c
 create mode 100644 drivers/pinctrl/pinctrl-pef2256.c
 create mode 100644 drivers/pinctrl/pinctrl-tps6594.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm4450.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8650-lpass-lpi.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8650.c
 create mode 100644 drivers/pinctrl/qcom/pinctrl-x1e80100.c
 create mode 100644 include/linux/framer/framer-provider.h
 create mode 100644 include/linux/framer/framer.h
 create mode 100644 include/linux/framer/pef2256.h

