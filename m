Return-Path: <linux-kernel+bounces-30571-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6318E8320C9
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 22:16:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9511F1C21CA3
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Jan 2024 21:16:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04C412EB06;
	Thu, 18 Jan 2024 21:16:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Gzz8kzL7"
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36572E645;
	Thu, 18 Jan 2024 21:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705612600; cv=none; b=N5ik+MMzj/Ys8jVsbV04vDX0ZHKvZidFve6TEF0VNiU+gXiBhAgprKfDoup3vRRx1B0FzV3hv+jboqfKCo2Vj9a0fuWfKMJmv2lUf7yqOZyRywxyeHEXx6m0dh0Dq7JaDuZs4diApbXBw6tvDdCAjxMNBTf1hA708yMR1rsUYEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705612600; c=relaxed/simple;
	bh=T74dZRPPy6OV0b+3GJqGxvNmObju8Fh/mIIcJovURh0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=HfDoPY1XB4/EasTbTxqYXKCxEEjLdGSrLKDj6OcwEK6Z9Ue33oYIyHw+Lk4Kd/wOTis4chU1LBgr/6ZhB4o9JiMYjs1Pc+hKIsrkVqJf+xAN2nv119G303xn4fexHmDHdD4MUJJbi+vFDBlKhxWNvnIGMQixqPiIbJbZ3/XLdtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Gzz8kzL7; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8B7D51C0002;
	Thu, 18 Jan 2024 21:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1705612594;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=XrmzizRP+hyelUsyarp0opqT+n67fFaPK201mMqzvTY=;
	b=Gzz8kzL7aoa3/zqJd+jy7+sjSY+xVAyfYdid8RHvD2UyFZG2kvl5GHwjFqsb+SWIIq5mg9
	e8Xjx9agwErznHAjlt4Tm1qNfvvxj0IIwaVADQ1IFYeOOvMH8mfOAAzwgL6qgIzEfE857F
	cbRgYrykATUGlrV1lcoJfRudezgsnMAuAvMJEXip/SCbluJVr3g5dCAEufeeYlO+QDJW4c
	EkVanuHPoCt1WpgZL1duRajQQx6y5RlxueZ9foy1snykMyHDQHAXfX7JPcoYcQjrPTcBrO
	JHaK9SH9exAhfnzn3tQWQCJAuwmWAfWNNswzK2psDu/qdKF12qDxsg8UOpfvpw==
Date: Thu, 18 Jan 2024 22:16:34 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [GIT PULL] RTC for 6.8
Message-ID: <2024011821163467921dbc@mail.local>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-GND-Sasl: alexandre.belloni@bootlin.com

Hello Linus,

Here is the RTC subsystem pull request for 6.8. There are three new
drivers this cycle. Also the cmos driver is getting fixes for long
standing wakeup issues on AMD.

The following changes since commit b85ea95d086471afb4ad062012a4d73cd328fa86:

  Linux 6.7-rc1 (2023-11-12 16:19:07 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux.git tags/rtc-6.8

for you to fetch changes up to 14688f1a91e1f37bc6bf50ff5241e857f24338e0:

  rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R (2024-01-18 01:05:33 +0100)

----------------------------------------------------------------
RTC for 6.8

Subsytem:

New driver:
 - Analog Devices MAX31335
 - Nuvoton ma35d1
 - Texas Instrument TPS6594 PMIC RTC

Drivers:
 - cmos: use ACPI alarm instead of HPET on recent AMD platforms
 - nuvoton: add NCT3015Y-R and NCT3018Y-R support
 - rv8803: proper suspend/resume and wakeup-source support

----------------------------------------------------------------
Akinobu Mita (1):
      rtc: ds3232: avoid unused-const-variable warning

Alexandre Belloni (4):
      rtc: ma35d1: remove hardcoded UIE support
      rtc: rv8803: add wakeup-source support
      rtc: max31335: remove unecessary locking
      rtc: max31335: use regmap_update_bits_check

Antoniu Miclaus (3):
      rtc: lpc24xx: add missing dependency
      dt-bindings: rtc: max31335: add max31335 bindings
      rtc: max31335: add driver support

Biju Das (3):
      rtc: da9063: Make IRQ as optional
      rtc: da9063: Use device_get_match_data()
      rtc: da9063: Use dev_err_probe()

Christophe JAILLET (1):
      rtc: class: Remove usage of the deprecated ida_simple_xx() API

Esteban Blanc (1):
      rtc: tps6594: Add driver for TPS6594 RTC

Jacky Huang (2):
      dt-bindings: rtc: Add Nuvoton ma35d1 rtc
      rtc: Add driver for Nuvoton ma35d1 rtc controller

Johan Hovold (1):
      dt-bindings: rtc: qcom-pm8xxx: fix inconsistent example

Krzysztof Kozlowski (1):
      rtc: MAINTAINERS: drop Alessandro Zummo

Mario Limonciello (5):
      rtc: cmos: Use ACPI alarm for non-Intel x86 systems too
      rtc: mc146818-lib: Adjust failure return code for mc146818_get_time()
      rtc: Adjust failure return code for cmos_set_alarm()
      rtc: Add support for configuring the UIP timeout for RTC reads
      rtc: Extend timeout for waiting for UIP to clear to 1s

Mia Lin (1):
      rtc: nuvoton: Compatible with NCT3015Y-R and NCT3018Y-R

Nathan Chancellor (1):
      rtc: max31335: Fix comparison in max31335_volatile_reg()

Randy Dunlap (1):
      rtc: ac100: remove misuses of kernel-doc

Stefan Eichenberger (1):
      rtc: rv8803: Add power management support

 .../devicetree/bindings/rtc/adi,max31335.yaml      |  70 +++
 .../devicetree/bindings/rtc/epson,rx8900.yaml      |   2 +
 .../bindings/rtc/nuvoton,ma35d1-rtc.yaml           |  48 ++
 .../devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml   |  36 +-
 MAINTAINERS                                        |   9 +-
 arch/alpha/kernel/rtc.c                            |   2 +-
 arch/x86/kernel/hpet.c                             |   2 +-
 arch/x86/kernel/rtc.c                              |   2 +-
 drivers/base/power/trace.c                         |   2 +-
 drivers/rtc/Kconfig                                |  37 ++
 drivers/rtc/Makefile                               |   3 +
 drivers/rtc/class.c                                |   2 +-
 drivers/rtc/rtc-ac100.c                            |   4 +-
 drivers/rtc/rtc-cmos.c                             |  28 +-
 drivers/rtc/rtc-da9063.c                           |  88 ++-
 drivers/rtc/rtc-ds3232.c                           |   4 +-
 drivers/rtc/rtc-ma35d1.c                           | 304 +++++++++
 drivers/rtc/rtc-max31335.c                         | 697 +++++++++++++++++++++
 drivers/rtc/rtc-mc146818-lib.c                     |  39 +-
 drivers/rtc/rtc-nct3018y.c                         |  52 +-
 drivers/rtc/rtc-rv8803.c                           |  36 +-
 drivers/rtc/rtc-tps6594.c                          | 454 ++++++++++++++
 include/linux/mc146818rtc.h                        |   3 +-
 23 files changed, 1819 insertions(+), 105 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/rtc/adi,max31335.yaml
 create mode 100644 Documentation/devicetree/bindings/rtc/nuvoton,ma35d1-rtc.yaml
 create mode 100644 drivers/rtc/rtc-ma35d1.c
 create mode 100644 drivers/rtc/rtc-max31335.c
 create mode 100644 drivers/rtc/rtc-tps6594.c

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

