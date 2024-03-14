Return-Path: <linux-kernel+bounces-103427-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CB2487BF36
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 15:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95AF31F22ECB
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:44:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5A870CBD;
	Thu, 14 Mar 2024 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a6eMuTFe"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6243870CBC
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 14:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710427434; cv=none; b=YHNXhF1z3HG2PjdCaV2lAyyJH0+2e+CZvkJ4+NIhTBNKTVtDcgcT27Bo1gUEKjTluwkao34rWb284T3Cb/T5nzIYFhSOoOYvAqpMSdWWIfTo3aX4wRR01b3LzkMUa6jfCMbG1Po6KxNeXcxuIxo/l3kPwI3Xa1DeHxQVB4ki7mU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710427434; c=relaxed/simple;
	bh=G8gkI8ogHOLf8UKfRzUmXw+0mUIBA5o9ALc0D/L89mA=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=p2f0Lzipe4X/WTLeVNCRQ82eVrt31nMI7vhOOCVxoeQgMvNZ9PIAzQ5aJZERfB+m7q+PaHZihOPIXb+P5nEU9+sN4xIxL7zQYyZzp2XFFHvwTPw+oGgEskYyBAEK+HVLEADLDcrBsHknreQ6NNIlWcNStFPzmUuLf1oPjnL0tLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a6eMuTFe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC2E6C433C7;
	Thu, 14 Mar 2024 14:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710427434;
	bh=G8gkI8ogHOLf8UKfRzUmXw+0mUIBA5o9ALc0D/L89mA=;
	h=Date:From:To:Cc:Subject:From;
	b=a6eMuTFemmiVp5BHLVTAbT3pNT5EF4UmUIxqoRl67nw6oy7PoWwlx0i/JNoeFSyVI
	 e3Hht8Mshv+l0X9RtDJRn/LHOf/mVKVN9xySfMMeSU9lV1oWLTve9dzgMyQlaBAwn9
	 HteorsPmL8/m20CUemWMSLvogDmx3n17r577hhNFIiUJPRAUKZhk0zbbysm28xiP32
	 n3YjijqJU9rvGUcvoGnkzGhA1fsHcpIegtXo7IcYI3U9YZIx9vvmVKcJF6rEqhVdFO
	 Fam1jWDPvF6FeL7qoeWqdZ1J/8/u0O+1fWCk8aQrOOWUB6Ii2JWntJZ8uprRQKxAsj
	 Bkydi55sMvDRg==
Date: Thu, 14 Mar 2024 14:43:50 +0000
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lee Jones <lee@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>
Subject: [GIT PULL] Backlight for v6.9
Message-ID: <20240314144350.GP1522089@google.com>
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

  git@gitolite.kernel.org:pub/scm/linux/kernel/git/lee/backlight tags/backlight-next-6.9

for you to fetch changes up to b49c1caca529c28712ef62bfaabdb9441162a935:

  backlight: pandora_bl: Drop unneeded ENOMEM error message (2024-03-07 09:03:29 +0000)

----------------------------------------------------------------
 - New Drivers
   - Add support for Kinetic KTD2801 Backlight

 - Fix-ups
   - Fix include lists; alphabetise, remove unused, explicitly add used
   - Device Tree binding adaptions/conversions/creation
   - Use dev_err_probe() to clean-up error paths
   - Use/convert to new/better APIs/helpers/MACROs instead of hand-rolling implementations

 - Bug Fixes
   - Fix changes of NULL pointer dereference
   - Remedy a bunch of logic errors
   - Initialise (zero) Backlight properties data structures

----------------------------------------------------------------
Andy Shevchenko (9):
      leds: expresswire: Don't use "proxy" headers
      backlight: hx8357: Fix potential NULL pointer dereference
      backlight: hx8357: Make use of device properties
      backlight: hx8357: Move OF table closer to its consumer
      backlight: hx8357: Make use of dev_err_probe()
      backlight: hx8357: Utilise temporary variable for struct device
      backlight: mp3309c: Make use of device properties
      backlight: mp3309c: Use dev_err_probe() instead of dev_err()
      backlight: mp3309c: Utilise temporary variable for struct device

Arnd Bergmann (1):
      leds: ktd2692: Add GPIOLIB dependency

Daniel Thompson (4):
      backlight: mp3309c: Fully initialize backlight_properties during probe
      backlight: da9052: Fully initialize backlight_properties during probe
      backlight: lm3639: Fully initialize backlight_properties during probe
      backlight: lp8788: Fully initialize backlight_properties during probe

Duje Mihanović (5):
      leds: Introduce ExpressWire library
      leds: ktd2692: Convert to use ExpressWire library
      dt-bindings: backlight: Add Kinetic KTD2801 binding
      backlight: Add Kinetic KTD2801 Backlight support
      backlight: ktd2801: Make timing struct static

Jeffrey Hugo (1):
      dt-bindings: backlight: qcom-wled: Fix bouncing email addresses

Jianhua Lu (1):
      backlight: ktz8866: Correct the check for of_property_read_u32

Krzysztof Kozlowski (7):
      backlight: gpio: Simplify with dev_err_probe()
      backlight: l4f00242t03: Simplify with dev_err_probe()
      backlight: bd6107: Handle deferred probe
      backlight: as3711_bl: Handle deferred probe
      backlight: lm3630a_bl: Handle deferred probe
      backlight: lm3630a_bl: Simplify probe return on gpio request error
      backlight: pandora_bl: Drop unneeded ENOMEM error message

Luca Weiss (3):
      backlight: lm3630a: Initialize backlight_properties on init
      backlight: lm3630a: Don't set bl->props.brightness in get_brightness
      backlight: lm3630a: Use backlight_get_brightness helper in update_status

Sean Young (1):
      backlight: mp3309c: Use pwm_apply_might_sleep()

 .../bindings/leds/backlight/kinetic,ktd2801.yaml   |  46 ++++++++
 .../bindings/leds/backlight/qcom-wled.yaml         |   4 +-
 MAINTAINERS                                        |  13 +++
 drivers/leds/Kconfig                               |   4 +
 drivers/leds/Makefile                              |   3 +
 drivers/leds/flash/Kconfig                         |   3 +-
 drivers/leds/flash/leds-ktd2692.c                  | 116 +++++--------------
 drivers/leds/leds-expresswire.c                    |  72 ++++++++++++
 drivers/video/backlight/Kconfig                    |   7 ++
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/as3711_bl.c                |   6 +-
 drivers/video/backlight/bd6107.c                   |   9 +-
 drivers/video/backlight/da9052_bl.c                |   1 +
 drivers/video/backlight/gpio_backlight.c           |  10 +-
 drivers/video/backlight/hx8357.c                   |  67 ++++++-----
 drivers/video/backlight/ktd2801-backlight.c        | 128 +++++++++++++++++++++
 drivers/video/backlight/ktz8866.c                  |   6 +-
 drivers/video/backlight/l4f00242t03.c              |  34 +++---
 drivers/video/backlight/lm3630a_bl.c               |  42 +++----
 drivers/video/backlight/lm3639_bl.c                |   1 +
 drivers/video/backlight/lp8788_bl.c                |   1 +
 drivers/video/backlight/mp3309c.c                  |  93 ++++++---------
 drivers/video/backlight/pandora_bl.c               |   4 +-
 include/linux/leds-expresswire.h                   |  38 ++++++
 24 files changed, 461 insertions(+), 248 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/kinetic,ktd2801.yaml
 create mode 100644 drivers/leds/leds-expresswire.c
 create mode 100644 drivers/video/backlight/ktd2801-backlight.c
 create mode 100644 include/linux/leds-expresswire.h

-- 
Lee Jones [李琼斯]

