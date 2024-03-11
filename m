Return-Path: <linux-kernel+bounces-99073-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D956878323
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 16:19:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71B931C21569
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 15:19:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BB7758129;
	Mon, 11 Mar 2024 15:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fMbwnIdI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76DFE5823C
	for <linux-kernel@vger.kernel.org>; Mon, 11 Mar 2024 15:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710169988; cv=none; b=r/95JkSrrq6gV5S2RLm3a241rekznDLzzB3ncU7wnrkogr44tX5GVOAIsWLkOul6Fo/5q3QQgaiufb+90zaZqBHOCFnrOJtKUgrsQ4b+y06QKuICCFiJRQ0ErXv+OgF0N33+lS/T+kL6/2e0KyLMIhHbcWcq6giRXsW2408lMy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710169988; c=relaxed/simple;
	bh=W0zyoiSyQr48TA+xIVHucmNJrAo83ywrOJtChE3k7Dw=;
	h=From:To:Cc:Subject:Date:Message-Id; b=uCRJoFWFFHccm7o8K4WL1mjEDLMcXhW84IS8Zr2LIZgw3+CeKJU92O7RSjUbpTrs8CN7YLGvKwipD0D9/IYy3CK4eI+G+umt8LlyJNX2p2Dk5dbMtaZrqdc/nb6OPG0JsbhN231/hTy2QyrIZtYsC9j1xVMMi49BCCj26V6ftfE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fMbwnIdI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0406CC433C7;
	Mon, 11 Mar 2024 15:13:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710169988;
	bh=W0zyoiSyQr48TA+xIVHucmNJrAo83ywrOJtChE3k7Dw=;
	h=From:To:Cc:Subject:Date:From;
	b=fMbwnIdInZctkz7rsLo9xh+72xW/Fzdn0oW19qlq8PjyXYkZYGzxW4PuXd7ClZnOf
	 ix931GISNQkbPvdza1qHTEPlgoTCNJ5/0FKJmM6Fq9wp7iZ/RetRt2HUexS7qLFQXw
	 NQsKj8Hkc6jo++AhcQSgtMF7BsLVD2/OrQVDZYIxIgH+gQFyrZ5JLK3vdBJxeAY5Gw
	 PvSWItK1Vxx0SyXNE6aG+WPL6Hmwp4hkRGGFcALFF9k6xDQo0Q+d6UJN/vB9TnM91P
	 sO4GKHQBIlKqca/BRfloaMDkSvIGoXJfBTkluJTRwggQ+zQcCOEhuVx2GaiHNBmxiF
	 G/cKJTaxcMZng==
From: Mark Brown <broonie@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>, linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [GIT PULL] regulator updates for v6.9
Date: Mon, 11 Mar 2024 15:12:58 +0000
Message-Id: <20240311151308.0406CC433C7@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The following changes since commit b401b621758e46812da61fa58a67c3fd8d91de0d:

  Linux 6.8-rc5 (2024-02-18 12:56:25 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git tags/regulator-v6.9

for you to fetch changes up to e6f0b08a036734552628ab788ecb528ca53814ab:

  regulator: lp8788-buck: fix copy and paste bug in lp8788_dvs_gpio_request() (2024-03-06 14:03:32 +0000)

----------------------------------------------------------------
regulator: Updates for v6.9

This has been a very quiet release, mostly cleanups, API updates and
simple device additions.  I messed up slightly and there are a couple of
duplicated commits resulting from me leaving things in my inbox which
didn't seem worth removing by the time I noticed them.

 - Conversion of several drivers to GPIO descriptors.
 - Build out the features of of the MP8859 driver.
 - Support for Qualcomm PM4125 and PM6150.

----------------------------------------------------------------
Andrei Simion (1):
      regulator: dt-bindings: microchip,mcp16502: convert to YAML

André Apitzsch (1):
      dt-bindings: regulator: Convert ti,tps65132 to YAML

Andy Shevchenko (1):
      regulator: da9121: Remove unused of_gpio.h

Christophe JAILLET (1):
      regulator: fixed-helper: Save a few bytes of memory when registering a 'nfc_llc' engine

Colin Ian King (2):
      regulator: core: Remove redundant assignment to variable possible_uV
      regulator: core: Remove redundant assignment to variable possible_uV

Dan Carpenter (1):
      regulator: lp8788-buck: fix copy and paste bug in lp8788_dvs_gpio_request()

Danila Tikhonov (1):
      dt-bindings: regulator: qcom,usb-vbus-regulator: Add PM6150 compatible

Dmitry Baryshkov (2):
      regulator: dt-bindings: qcom,usb-vbus-regulator: add support for PM4125
      regulator: dt-bindings: qcom,usb-vbus-regulator: add support for PM4125

Geert Uytterhoeven (2):
      regulator: lp87565: Use bitfield helpers
      regulator: lp873x: Use bitfield helpers

John Keeping (1):
      regulator: userspace-consumer: add module device table

Konrad Dybcio (1):
      regulator: qcom_smd: Keep one rpm handle for all vregs

Linus Walleij (5):
      regulator: max8973: Finalize switch to GPIO descriptors
      regulator: da9055: Fully convert to GPIO descriptors
      regulator: lp8788-buck: Fully convert to GPIO descriptors
      regulator: max8997: Convert to GPIO descriptors
      regulator: max8998: Convert to GPIO descriptors

Mark Brown (11):
      regulator: Merge up v6.8-rc5
      regulator: mp8859: Specify register accessibility and enable caching
      regulator: mp8859: Validate and log device identifier information
      regulator: mp8859: Support enable control
      regulator: mp8859: Support mode operations
      regulator: mp8859: Support active discharge control
      regulator: mp8859: Support status and error readback
      regulator: mp8859: Report slew rate
      regulator: mp8859: Implement set_current_limit()
      Convert some regulator drivers to GPIO descriptors
      regulator: mp8859: Cleanups and enhancements

Ricardo B. Marliere (1):
      regulator: core: make regulator_class constant

Rob Herring (1):
      regulator: dt-bindings: gpio-regulator: Fix "gpios-states" and "states" array bounds

Uwe Kleine-König (2):
      regulator: pwm-regulator: Use dev_err_probe() for error paths in .probe()
      regulator: pwm-regulator: Use dev_err_probe() for error paths in .probe()

 .../bindings/regulator/gpio-regulator.yaml         |   4 +-
 .../bindings/regulator/mcp16502-regulator.txt      | 144 ------------
 .../bindings/regulator/microchip,mcp16502.yaml     | 180 +++++++++++++++
 .../regulator/qcom,usb-vbus-regulator.yaml         |  10 +-
 .../devicetree/bindings/regulator/ti,tps65132.yaml |  84 +++++++
 .../bindings/regulator/tps65132-regulator.txt      |  46 ----
 drivers/regulator/core.c                           |   3 +-
 drivers/regulator/da9055-regulator.c               |  48 ++--
 drivers/regulator/da9121-regulator.c               |   1 -
 drivers/regulator/fixed-helper.c                   |   4 +-
 drivers/regulator/internal.h                       |   2 +-
 drivers/regulator/lp873x-regulator.c               |   3 +-
 drivers/regulator/lp87565-regulator.c              |   3 +-
 drivers/regulator/lp8788-buck.c                    |  64 +++---
 drivers/regulator/max8973-regulator.c              |  36 +--
 drivers/regulator/max8997-regulator.c              |  85 ++-----
 drivers/regulator/max8998.c                        | 150 +++++-------
 drivers/regulator/mp8859.c                         | 252 ++++++++++++++++++++-
 drivers/regulator/pwm-regulator.c                  |  40 ++--
 drivers/regulator/qcom_smd-regulator.c             |  19 +-
 drivers/regulator/userspace-consumer.c             |   1 +
 include/linux/mfd/da9055/pdata.h                   |  13 --
 include/linux/mfd/lp8788.h                         |   9 +-
 include/linux/mfd/max8997.h                        |   1 -
 include/linux/mfd/max8998.h                        |   6 -
 include/linux/regulator/max8973-regulator.h        |   6 -
 26 files changed, 705 insertions(+), 509 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/regulator/mcp16502-regulator.txt
 create mode 100644 Documentation/devicetree/bindings/regulator/microchip,mcp16502.yaml
 create mode 100644 Documentation/devicetree/bindings/regulator/ti,tps65132.yaml
 delete mode 100644 Documentation/devicetree/bindings/regulator/tps65132-regulator.txt

