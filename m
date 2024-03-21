Return-Path: <linux-kernel+bounces-110773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0845988637B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 23:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B1CA8282B7C
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 22:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C31F44A1D;
	Thu, 21 Mar 2024 22:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="E7Y7mpg4"
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C0A917CD;
	Thu, 21 Mar 2024 22:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711061612; cv=none; b=oQIa71AJ31EBkh7smZnOOhlb4xIIe2KCqhsgPmDC4Qe+FH2IkBrt/SaPUSf/mVVyQsthopbxJ2LQb/wvYpnzdsW7+JpcMlaberMEseEX2Supo4lJnHhbF8iINa3czFD9xYByFhvgt8xgz1D6E3Bj/+GNmOujmWQwTVGBL9pU3OM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711061612; c=relaxed/simple;
	bh=UswdUlkM45QMsASxwpLigdlov1dXkmGOe38fpNQg0KE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=RuA9wLJyf9M+xtEZbjnnK2pi5a5NhO8XkBYNIisw89dZAOejUJelmNQmMmTH4xwstUR4Q49IoK7ES6ddkCfYoE5NrnLGJtMh9g9CCvSzEbS47uEJ5j2U5yZqd56+jsNzochZE7EoOC5mYA93z0iTznEWWX5kG3I8sKOjolTk+Fs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=E7Y7mpg4; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 6795AE0003;
	Thu, 21 Mar 2024 22:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1711061607;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HdXzZItXUejLg9qHdtKtPsejDDLt8Rm+Xt+0+aVfbds=;
	b=E7Y7mpg4SIpOuBm6oW6ipVJoFXmnVIw8IAY9Bpx17ojAnMG+8nm9CIDhZkusQkVU3khLnq
	6YGKik/WWfFE4rUpQaHzIdiuYZ9Ur/jJGfQ4/9c/0/r/cVJDQk3Pk2VMLdX6ahFn65tvxz
	+hDhKER07jrRIRC5P1RypGWAPh+iF478hvjHZpPvC7U2KhE+z2n/CE1N7ZlWpw/Mduz240
	SWWVTLFgqJT+cIkzvmyWQvbsbDNOla0b9MXN8WBMpmqGckFqiVmuJY21YZOFCIr0dcZNSO
	OJGAUlIVTpMeJe5OAEEdklPlehqjMKvsWuio+YTc/MuKWX2+tJ97wMPBRRUjSQ==
Date: Thu, 21 Mar 2024 23:53:27 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 6.9
Message-ID: <202403212253279f152664@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello Linus,

Here is the RTC subsystem pull request for 6.9. This cycle has seen
multiple device tree bindings conversion to yaml, a few fixes and then a
rework of the ds1511 driver.

The following changes since commit 6613476e225e090cc9aad49be7fa504e290dd33d:

  Linux 6.8-rc1 (2024-01-21 14:11:32 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.9

for you to fetch changes up to f7cee094fb3b370e56b3c8aac89038de818d7aec:

  MAINTAINER: Include linux-arm-msm for Qualcomm RTC patches (2024-03-20 23:33:58 +0100)

----------------------------------------------------------------
RTC for 6.9

Subsytem:
 - rtc_class is now const

Drivers:
 - ds1511: driver cleanup, set date and time range and alarm offset limit
 - max31335: fix interrupt handler
 - pcf8523: improve suspend support

----------------------------------------------------------------
Alexandre Belloni (16):
      rtc: ds1511: drop useless checks
      rtc: ds1511: drop useless computation
      rtc: ds1511: drop dead code
      rtc: ds1511: drop useless enum
      rtc: ds1511: fix function definition
      rtc: ds1511: remove incomplete UIE support
      rtc: ds1511: remove ds1511_rtc_update_alarm
      rtc: ds1511: let the core know when alarm are not supported
      rtc: ds1511: remove partial alarm support
      rtc: ds1511: implement ds1511_rtc_read_alarm properly
      rtc: ds1511: rename pdata
      rtc: ds1511: drop inline/noinline hints
      rtc: ds1511: set range
      rtc: ds1511: set alarm offset limit
      rtc: pcf8523: add suspend handlers for alarm IRQ
      rtc: nct3018y: fix possible NULL dereference

Antoniu Miclaus (1):
      rtc: max31335: fix interrupt status reg

Bjorn Andersson (1):
      MAINTAINER: Include linux-arm-msm for Qualcomm RTC patches

Curtis Klein (1):
      rtc: m41t80: Use the unified property API get the wakeup-source property

Josua Mayer (1):
      dt-bindings: rtc: abx80x: convert to yaml

Laurent Pinchart (1):
      dt-bindings: rtc: abx80x: Improve checks on trickle charger constraints

Lukas Bulwahn (1):
      MAINTAINERS: adjust file entry in ARM/Mediatek RTC DRIVER

Michal Simek (1):
      dt-bindings: rtc: zynqmp: Add support for Versal/Versal NET SoCs

Rafał Miłecki (2):
      dt-bindings: rtc: convert MT2717 RTC to the json-schema
      dt-bindings: rtc: convert MT7622 RTC to the json-schema

Randy Dunlap (1):
      rtc: mt6397: select IRQ_DOMAIN instead of depending on it

Ricardo B. Marliere (1):
      rtc: class: make rtc_class constant

Varshini Rajendran (1):
      dt-bindings: at91rm9260-rtt: add sam9x7 compatible

 .../devicetree/bindings/rtc/abracon,abx80x.txt     |  31 --
 .../devicetree/bindings/rtc/abracon,abx80x.yaml    |  98 ++++++
 .../bindings/rtc/atmel,at91sam9260-rtt.yaml        |   4 +-
 .../bindings/rtc/mediatek,mt2712-rtc.yaml          |  39 +++
 .../bindings/rtc/mediatek,mt7622-rtc.yaml          |  52 ++++
 .../devicetree/bindings/rtc/rtc-mt2712.txt         |  14 -
 .../devicetree/bindings/rtc/rtc-mt7622.txt         |  21 --
 .../devicetree/bindings/rtc/xlnx,zynqmp-rtc.yaml   |  11 +-
 MAINTAINERS                                        |   5 +-
 drivers/rtc/Kconfig                                |   3 +-
 drivers/rtc/class.c                                |  21 +-
 drivers/rtc/interface.c                            |   2 +-
 drivers/rtc/rtc-ds1511.c                           | 342 +++++++--------------
 drivers/rtc/rtc-m41t80.c                           |   5 +-
 drivers/rtc/rtc-max31335.c                         |   2 +-
 drivers/rtc/rtc-nct3018y.c                         |   6 +-
 drivers/rtc/rtc-pcf8523.c                          |  25 ++
 include/linux/rtc.h                                |   2 +-
 kernel/power/suspend_test.c                        |   2 +-
 kernel/time/alarmtimer.c                           |   2 +-
 20 files changed, 359 insertions(+), 328 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/rtc/abracon,abx80x.txt
 create mode 100644 Documentation/devicetree/bindings/rtc/abracon,abx80x.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/mediatek,mt2712-rtc.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/mediatek,mt7622-rtc.yaml
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt2712.txt
 delete mode 100644 Documentation/devicetree/bindings/rtc/rtc-mt7622.txt

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

