Return-Path: <linux-kernel+bounces-163970-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 422788B76B1
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 15:15:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79FCFB22688
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 13:15:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95E3417166A;
	Tue, 30 Apr 2024 13:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="GtVMv3ax";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="MFLydRQo"
Received: from c180-43.smtp-out.ap-south-1.amazonses.com (c180-43.smtp-out.ap-south-1.amazonses.com [76.223.180.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D541171650;
	Tue, 30 Apr 2024 13:14:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714482893; cv=none; b=i40QJ+OEeiuqGlU9t+SrP/s9VJYhm0VIZuPRCOYACXOoYO9tUq9dI+J0xJ0TeSvuIJP1lGc/fEiT+6j9j8R1MTxMhv+VtgYOpNUAdhNpG4ZWdAy8HLRQnT5gJSzX9c6yeLug3BRgim82G42W8Mf5O6ViqZHgjOd/DWmwv1P75oY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714482893; c=relaxed/simple;
	bh=hRAzHyDk1qTLIrlooGx0M57K3X+4fNqF8Q2oyy7l7+4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aPziAy6AMQAZi++trzDlVNxaxF4es4N7c8D3cYCXYdyg6qD/BWWMH24xLJskD4dQ7VUt73X5CYSwMUdsF1XNc7s5Crk4JVxU1L6ORmfeJhXy0d/SbkQocRR1m1K7QuaY4KMtczvBzm2OxJBD2fGq3X5Qs5eG2y7AUrVEXLr9mRA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=GtVMv3ax; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=MFLydRQo; arc=none smtp.client-ip=76.223.180.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1714482889;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
	bh=hRAzHyDk1qTLIrlooGx0M57K3X+4fNqF8Q2oyy7l7+4=;
	b=GtVMv3axxNwIcx0FE90iAp6cvXjFhzHhLHvBypp0xN0aiHf/AOsgkCDPJavOVcKo
	4YtkTv0Yj2Qht2ipft+9ZVeOl2kpSG6yxcOFG6HB4Wyb6dwa9wNzQxWUYR4k8Oz3s9A
	SfAoxLQHGyLzWXaqNhBWBNl4kSxyzU+F83JA6F6FVyiAV7mMwNCcp0+5Zcr/sMy/Dmu
	mOYqTDKpsR/DyBCAx8ZvMniWgDC9EfWJEx9DgX/3P11s02OFtZXVuQKOgqqQuEmYdLb
	zsx+m7zS1AZJSU0p1QCZg2UzDSC8513zlpDRNdqxTroLnP/DUUD6pm2gl9mDq8BfMwt
	LAr3F+770g==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=zpkik46mrueu52d3326ufxxchortqmoc; d=amazonses.com; t=1714482889;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=hRAzHyDk1qTLIrlooGx0M57K3X+4fNqF8Q2oyy7l7+4=;
	b=MFLydRQoIt1VbFSbNQyQmwW/GUU0ZmCPGgTw29NpyXa82FSMLXly0UcYv8XSUjBb
	HuY5AL2fz9ADTBRSJoiVRFB2m0XCaCua0rb2VZmgtujPculcE5JR5iBy1lfocjasJC6
	J+ykzfAGt8BDzHZhjuEBloRHyNgp4RXfdvyf0088=
From: Bhargav Raviprakash <bhargav.r@ltts.com>
To: linux-kernel@vger.kernel.org
Cc: m.nirmaladevi@ltts.com, lee@kernel.org, robh+dt@kernel.org, 
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
	jpanis@baylibre.com, devicetree@vger.kernel.org, arnd@arndb.de, 
	gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org, 
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com, 
	kristo@kernel.org, eblanc@baylibre.com, 
	Bhargav Raviprakash <bhargav.r@ltts.com>
Subject: [PATCH v8 00/10] Add support for TI TPS65224 PMIC
Date: Tue, 30 Apr 2024 13:14:49 +0000
Message-ID: <0109018f2f24c15e-c50bfc29-5f1d-4368-a4b8-2c9f1d398abb-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.30-76.223.180.43

This series modifies the existing TPS6594 drivers to add support for the
TPS65224 PMIC device that is a derivative of TPS6594. TPS65224 has a
similar register map to TPS6594 with a few differences. SPI, I2C, ESM,
PFSM, Regulators and GPIO features overlap between the two devices.

TPS65224 is a Power Management IC (PMIC) which provides regulators and
other features like GPIOs, Watchdog, Error Signal Monitor (ESM) and
Pre-configurable Finite State Machine (PFSM). The SoC and the PMIC can
communicate through the I2C or SPI interfaces. The PMIC TPS65224
additionally has a 12-bit ADC.
Data Sheet for TPS65224: https://www.ti.com/product/TPS65224-Q1

Driver re-use is applied following the advice of the following series:
https://lore.kernel.org/lkml/2f467b0a-1d11-4ec7-8ca6-6c4ba66e5887@baylibre.com/

The features implemented in this series are:
- TPS65224 Register definitions
- Core (MFD I2C and SPI entry points)
- PFSM	
- Regulators
- Pinctrl

TPS65224 Register definitions:
This patch adds macros for register field definitions of TPS65224
to the existing TPS6594 driver.  

Core description:
I2C and SPI interface protocols are implemented, with and without
the bit-integrity error detection feature (CRC mode).

PFSM description:
Strictly speaking, PFSM is not hardware. It is a piece of code.
PMIC integrates a state machine which manages operational modes.
Depending on the current operational mode, some voltage domains
remain energized while others can be off.
PFSM driver can be used to trigger transitions between configured
states.

Regulators description:
4 BUCKs and 3 LDOs.
BUCK12 can be used in dual-phase mode.

Pinctrl description:
TPS65224 family has 6 GPIOs. Those GPIOs can also serve different
functions such as I2C or SPI interface or watchdog disable functions.
The driver provides both pinmuxing for the functions and GPIO capability.

This series was tested on linux-next tag: next-20240118

Test logs can be found here:
https://gist.github.com/LeonardMH/58ec135921fb1062ffd4a8b384831eb0

Changelog v7 -> v8:
- Refactoring regulator driver

Bhargav Raviprakash (7):
  mfd: tps6594: use volatile_table instead of volatile_reg
  dt-bindings: mfd: ti,tps6594: Add TI TPS65224 PMIC
  mfd: tps6594-i2c: Add TI TPS65224 PMIC I2C
  mfd: tps6594-spi: Add TI TPS65224 PMIC SPI
  mfd: tps6594-core: Add TI TPS65224 PMIC core
  misc: tps6594-pfsm: Add TI TPS65224 PMIC PFSM
  arch: arm64: dts: ti: k3-am62p5-sk: Add TPS65224 PMIC support in AM62P
    dts

Nirmala Devi Mal Nadar (3):
  mfd: tps6594: Add register definitions for TI TPS65224 PMIC
  regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators
  pinctrl: pinctrl-tps6594: Add TPS65224 PMIC pinctrl and GPIO

 .../devicetree/bindings/mfd/ti,tps6594.yaml   |   1 +
 arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  95 +++++
 drivers/mfd/tps6594-core.c                    | 253 +++++++++++--
 drivers/mfd/tps6594-i2c.c                     |  20 +-
 drivers/mfd/tps6594-spi.c                     |  20 +-
 drivers/misc/tps6594-pfsm.c                   |  48 ++-
 drivers/pinctrl/pinctrl-tps6594.c             | 277 +++++++++++---
 drivers/regulator/Kconfig                     |   4 +-
 drivers/regulator/tps6594-regulator.c         | 334 +++++++++++++----
 include/linux/mfd/tps6594.h                   | 351 +++++++++++++++++-
 10 files changed, 1215 insertions(+), 188 deletions(-)


base-commit: 2863b714f3ad0a9686f2de1b779228ad8c7a8052
-- 
2.25.1


