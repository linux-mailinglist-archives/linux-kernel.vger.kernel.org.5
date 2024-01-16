Return-Path: <linux-kernel+bounces-27586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B72AD82F28A
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 17:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A89E1F2480D
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:43:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EBA51BF28;
	Tue, 16 Jan 2024 16:42:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VjOf62d+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0DD517742
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 16:42:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC08C433F1;
	Tue, 16 Jan 2024 16:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705423372;
	bh=J5+xKSxuDlYEj4+P+5gfDguvFvcL0fbU1q/N4D3iD+g=;
	h=Date:From:To:Cc:Subject:From;
	b=VjOf62d+NGLv1QJHzgH473rm5gskwO2JmL2wUER8RTj3EoXkXN0loP1UyKz7bHX91
	 3auBeV7t4T7L6qDbq1gXtM9g3me4WKBAOIUdrdzPVlCQD/m8eTK7hH+yA6ZY4bhYrg
	 gtTTKAgiznpzDm04JR59g9LZ8kD6CNImFZLMs1fNRgGUrGk0/xvKlEzgqFedIJkToj
	 M7jheGQtN4Oqf11PizVQgMsVQInKxOWaSFKYEFpSbEL2Wmi59HCI5vrRO/kcPDx7kR
	 6uqLtfYafMbRPLM844tWJ0nETemMuy0Sp7YYUpq1oB2u6WHnKcR2Jgpai3BIBrxol5
	 7C/OMbeuk7SiA==
Date: Tue, 16 Jan 2024 16:42:48 +0000
From: Lee Jones <lee@kernel.org>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Lee Jones <lee@kernel.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Daniel Thompson <daniel.thompson@linaro.org>
Subject: [GIT PULL] Backlight for v6.8
Message-ID: <20240116164248.GL1920897@google.com>
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

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/lee/backlight.git backlight-next-6.8

for you to fetch changes up to 7d84a63a39b78443d09f2b4edf7ecb1d586379b4:

  backlight: hx8357: Convert to agnostic GPIO API (2023-12-13 15:41:59 +0000)

----------------------------------------------------------------
 - New Drivers
   - Add support for Monolithic Power Systems MP3309C WLED Step-up Converter

 - Fix-ups
   - Use/convert to new/better APIs/helpers/MACROs instead of hand-rolling implementations
   - Device Tree Binding updates
   - Demote non-kerneldoc header comments
   - Improve error handling; return proper error values, simplify, avoid duplicates, etc
   - Convert over to the new (kinda) GPIOD API

 - Bug Fixes
   - Fix uninitialised local variable

----------------------------------------------------------------
Alexander Stein (1):
      backlight: pwm_bl: Use dev_err_probe

Andy Shevchenko (1):
      backlight: hx8357: Convert to agnostic GPIO API

Flavio Suligoi (3):
      dt-bindings: backlight: mp3309c: Remove two required properties
      backlight: mp3309c: Add support for MPS MP3309C
      backlight: mp3309c: Fix uninitialized local variable

Randy Dunlap (1):
      backlight: ili922x: Drop kernel-doc for local macros

Su Hui (1):
      backlight: ili922x: Add an error code check in ili922x_write()

 .../bindings/leds/backlight/mps,mp3309c.yaml       |  10 +-
 MAINTAINERS                                        |   7 +
 drivers/gpio/gpiolib-of.c                          |   4 +-
 drivers/video/backlight/Kconfig                    |  11 +
 drivers/video/backlight/Makefile                   |   1 +
 drivers/video/backlight/hx8357.c                   |  74 +---
 drivers/video/backlight/ili922x.c                  |   8 +-
 drivers/video/backlight/mp3309c.c                  | 444 +++++++++++++++++++++
 drivers/video/backlight/pwm_bl.c                   |  34 +-
 9 files changed, 515 insertions(+), 78 deletions(-)
 create mode 100644 drivers/video/backlight/mp3309c.c

-- 
Lee Jones [李琼斯]

