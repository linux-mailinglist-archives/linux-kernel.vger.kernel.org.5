Return-Path: <linux-kernel+bounces-103429-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F86987BF3A
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0AC81F22296
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:45:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC7CB6FE1E;
	Thu, 14 Mar 2024 14:45:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ESTLBBcf"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007A85D75A
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:45:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427528; cv=none; b=tFIjMU3/c0UO0hOhrONuFP8SCXB0ZCwG+x/vZrOsFjxebHv+Kyky8BniOOYOPptuQsRt9C6kTCfqTRBjp8wfJMx4xO4OzBRqzkLZskwYg/5310AN1Nl96YmO3gMBZAWUdcgcPD1sNgL5boW8/Sokxa7v6ivW2aLBkjtkJtlElIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427528; c=relaxed/simple;
	bh=jQBit6dGUGPRkGxYS3X4arSuwPg6sJP8CFGPWKBlQ18=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=e0ZYsIfeRPepN8B+/EPu5xZaei7yZELs3elETf7HQpj8nClkqTiZ7ixdqH4C19O5xykzyIvcSth8+Fkeuavuy3sato0XrdtD0+QPgdzE2wUYV5gBRfCCeLpfuP+TCpNw1JBEO54QQiL4CyljlOzlvHmC1Mo0hcb8ybFmG9EgxCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ESTLBBcf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C47CC433C7;
	Thu, 14 Mar 2024 14:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710427527;
	bh=jQBit6dGUGPRkGxYS3X4arSuwPg6sJP8CFGPWKBlQ18=;
	h=Date:From:To:Cc:Subject:From;
	b=ESTLBBcfY1xPdEB5upO45T5ShJ3RCp5u4ILga34kD6UH0PXIMsWZBHBv5x+9u7wa6
	 JT5DwQxllcONaa0R/vJS3bIVT2Ac0/pjTS5W8pdq8pfDvPEd20tYCVrBr+eywvdGX5
	 0cdSPEekrOzgu1DPjiEAvrtOHwizhnjqjsp7OcvSbUDjiif7MkdQbA32vQikG3HLFc
	 vunSQP3Al7KLc10Xu62qFplMnJQaj5EIVMAOHM3QFd5pqnirb5wzinurUxToNLeeP1
	 17ogNaag+4lNG7M1Q75XWIauFRHv/oIqsyC16LupjugtqJMkYJGgpPDHUXLQ+Bzrxq
	 i0daaoVPATcPQ==
Date: Thu, 14 Mar 2024 14:45:23 +0000
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lee Jones <lee@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Pavel Machek <pavel@ucw.cz>
Subject: [GIT PULL] LEDs for v6.9
Message-ID: <20240314144523.GQ1522089@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Good afternoon Linus,

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/leds tags/leds-next-6.9

for you to fetch changes up to 45066c4bbe8ca25f9f282245b84568116c783f1d:

  leds: ncp5623: Add MS suffix to time defines (2024-03-07 08:48:20 +0000)

----------------------------------------------------------------
 - Core Frameworks
   - Introduce ExpressWire library

 - New Drivers
   - Add support for ON Semiconductor NCP5623 RGB LED Driver

 - New Device Support
   - Add support for PM660L to Qualcomm's LPG driver

 - New Functionality
   - Dynamically load modules required for the default-trigger
   - Add some support for suspend and resume
   - Allow LEDs to remain lit during suspend

 - Fix-ups
   - Device Tree binding adaptions/conversions/creation
   - Fix include lists; alphabetise, remove unused, explicitly add used
   - Add new led_match_default_trigger to avoid duplication
   - Add module alias' to aid auto-loading
   - Default to hw_control if no others are specified
   - De-bloat the supported link speed attribute lists
   - Remove superfluous code and simplify overall
   - Constify some variables

 - Bug Fixes
   - Prevent kernel panic when renaming the net interface
   - Fix Kconfig related build errors
   - Ensure mutexes are unlocked prior to destroying them
   - Provide clean-up between state changes to avoid invalid state
   - Fix some broken kernel-doc headers

----------------------------------------------------------------
Abdel Alkuor (3):
      dt-bindings: leds: Add NCP5623 multi-LED Controller
      leds: Add NCP5623 multi-led driver
      leds: ncp5623: Add MS suffix to time defines

Amitesh Singh (1):
      leds: pca963x: Add support for suspend and resume

Andy Shevchenko (1):
      leds: expresswire: Don't use "proxy" headers

Anjelique Melendez (7):
      dt-bindings: soc: qcom: Add qcom,pbs bindings
      soc: qcom: add QCOM PBS driver
      dt-bindings: leds: leds-qcom-lpg: Add support for LPG PPG
      leds: rgb: leds-qcom-lpg: Add support for PPG through single SDAM
      leds: rgb: leds-qcom-lpg: Update PMI632 lpg_data to support PPG
      leds: rgb: leds-qcom-lpg: Include support for PPG with dedicated LUT SDAM
      leds: rgb: Update PM8350C lpg_data to support two-nvmem PPG Scheme

Aren Moynihan (1):
      leds: rgb: leds-group-multicolor: Allow LEDs to stay on in suspend

Arnd Bergmann (5):
      leds: ktd2692: Add GPIOLIB dependency
      leds: Remove led_init_default_state_get() and devm_led_classdev_register_ext() stubs
      leds: Make flash and multicolor dependencies unconditional
      leds: qcom-lpg: Add QCOM_PBS dependency
      leds: Fix ifdef check for gpio_led_register_device()

Christian Marangi (3):
      leds: trigger: netdev: Display only supported link speed attribute
      docs: ABI: sysfs-class-led-trigger-netdev: Document now hidable link_*
      leds: trigger: netdev: Fix kernel panic on interface rename trig notify

Colin Ian King (1):
      leds: aw200xx: Make read-only array coeff_table static const

Duje Mihanović (7):
      leds: Introduce ExpressWire library
      leds: ktd2692: Convert to use ExpressWire library
      dt-bindings: backlight: Add Kinetic KTD2801 binding
      backlight: Add Kinetic KTD2801 Backlight support
      backlight: ktd2801: Make timing struct static
      Revert "leds: Only descend into leds directory when CONFIG_NEW_LEDS is set"
      leds: expresswire: Don't depend on NEW_LEDS

Florian Eckert (1):
      Documentation: leds: Update led-trigger-tty ABI description

George Stark (1):
      leds: aw2013: Unlock mutex before destroying it

Heiner Kallweit (9):
      leds: trigger: netdev: Skip setting baseline state in activate if hw-controlled
      leds: trigger: Load trigger modules on-demand if used as default trigger
      leds: trigger: netdev: Add module alias ledtrig:netdev
      leds: class: If no default trigger is given, make hw_control trigger the default trigger
      leds: trigger: audio: Set module alias for module auto-loading
      leds: triggers: default-on: Add module alias for module auto-loading
      leds: trigger: panic: Simplify led_trigger_set_panic
      leds: trigger: Stop exporting trigger_list
      leds: triggers: Add helper led_match_default_trigger

Krzysztof Kozlowski (2):
      dt-bindings: leds: qcom-lpg: Drop redundant qcom,pm8550-pwm in if:then:
      dt-bindings: leds: qcom-lpg: Narrow nvmem for other variants

Lee Jones (1):
      Merge branches 'ib-qcom-leds-6.9' and 'ib-leds-backlight-6.9' into ibs-for-leds-merged

Marijn Suijten (1):
      leds: qcom-lpg: Add PM660L configuration and compatible

Ondrej Jirman (1):
      leds: sgm3140: Add missing timer cleanup and flash gpio control

Rafał Miłecki (2):
      dt-bindings: leds: Add FUNCTION defines for per-band WLANs
      dt-bindings: leds: Add LED_FUNCTION_WAN_ONLINE for Internet access

Randy Dunlap (3):
      leds: lm3601x: Fix struct lm3601_led kernel-doc warnings
      leds: leds-mlxcpld: Fix struct mlxcpld_led_priv member name
      leds: mlxreg: Drop an excess struct mlxreg_led_data member

Stefan Kalscheuer (1):
      leds: spi-byte: Use devm_led_classdev_register_ext()

 .../ABI/testing/sysfs-class-led-trigger-netdev     |  12 +
 .../ABI/testing/sysfs-class-led-trigger-tty        |  14 +-
 .../bindings/leds/backlight/kinetic,ktd2801.yaml   |  46 +++
 .../devicetree/bindings/leds/leds-qcom-lpg.yaml    | 102 +++++-
 .../devicetree/bindings/leds/onnn,ncp5623.yaml     |  96 ++++++
 .../devicetree/bindings/soc/qcom/qcom,pbs.yaml     |  46 +++
 MAINTAINERS                                        |  13 +
 drivers/Makefile                                   |   2 +-
 drivers/leds/Kconfig                               |  14 +-
 drivers/leds/Makefile                              |   3 +
 drivers/leds/flash/Kconfig                         |   7 +-
 drivers/leds/flash/leds-ktd2692.c                  | 116 ++-----
 drivers/leds/flash/leds-lm3601x.c                  |   3 +-
 drivers/leds/flash/leds-sgm3140.c                  |   3 +
 drivers/leds/led-class.c                           |   6 +
 drivers/leds/led-triggers.c                        |  38 ++-
 drivers/leds/leds-aw200xx.c                        |   2 +-
 drivers/leds/leds-aw2013.c                         |   1 +
 drivers/leds/leds-expresswire.c                    |  72 ++++
 drivers/leds/leds-mlxcpld.c                        |   2 +-
 drivers/leds/leds-mlxreg.c                         |   1 -
 drivers/leds/leds-pca963x.c                        |  28 ++
 drivers/leds/leds-spi-byte.c                       |  11 +-
 drivers/leds/leds.h                                |   1 -
 drivers/leds/rgb/Kconfig                           |  12 +
 drivers/leds/rgb/Makefile                          |   1 +
 drivers/leds/rgb/leds-group-multicolor.c           |   8 +-
 drivers/leds/rgb/leds-ncp5623.c                    | 271 +++++++++++++++
 drivers/leds/rgb/leds-qcom-lpg.c                   | 366 +++++++++++++++++++--
 drivers/leds/trigger/ledtrig-audio.c               |   2 +
 drivers/leds/trigger/ledtrig-default-on.c          |   1 +
 drivers/leds/trigger/ledtrig-netdev.c              | 102 +++++-
 drivers/leds/trigger/ledtrig-panic.c               |  23 +-
 drivers/soc/qcom/Kconfig                           |   9 +
 drivers/soc/qcom/Makefile                          |   1 +
 drivers/soc/qcom/qcom-pbs.c                        | 236 +++++++++++++
 drivers/staging/greybus/Kconfig                    |   2 +-
 drivers/staging/greybus/light.c                    |  21 --
 drivers/video/backlight/Kconfig                    |   7 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/ktd2801-backlight.c        | 128 +++++++
 include/dt-bindings/leds/common.h                  |   4 +
 include/linux/led-class-flash.h                    |  24 --
 include/linux/led-class-multicolor.h               |  29 --
 include/linux/leds-expresswire.h                   |  38 +++
 include/linux/leds.h                               |  21 +-
 include/linux/soc/qcom/qcom-pbs.h                  |  30 ++
 47 files changed, 1697 insertions(+), 279 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktd2801.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/onnn,ncp5623.yaml
 create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom,pbs.yaml
 create mode 100644 drivers/leds/leds-expresswire.c
 create mode 100644 drivers/leds/rgb/leds-ncp5623.c
 create mode 100644 drivers/soc/qcom/qcom-pbs.c
 create mode 100644 drivers/video/backlight/ktd2801-backlight.c
 create mode 100644 include/linux/leds-expresswire.h
 create mode 100644 include/linux/soc/qcom/qcom-pbs.h

-- 
Lee Jones [李琼斯]

