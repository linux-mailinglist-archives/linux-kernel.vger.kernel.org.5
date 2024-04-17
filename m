Return-Path: <linux-kernel+bounces-148424-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CFFF8A8260
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 13:50:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B81D81F22B9C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 11:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1C4613D2BF;
	Wed, 17 Apr 2024 11:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b="M9D7V4Nc";
	dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b="BSF0n8QH"
Received: from c180-39.smtp-out.ap-south-1.amazonses.com (c180-39.smtp-out.ap-south-1.amazonses.com [76.223.180.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED0713D26C;
	Wed, 17 Apr 2024 11:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=76.223.180.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713354595; cv=none; b=fFqkQm4wFnVHHRbEVQGzwnAsWeWu2DnOC8HyiMVU59spXhPGWQDzsm6ZMmfdK3CEbyf+nYj2NGDEzoGr5ki/7zydsSIJkkK6J230sR104qyJVeFMuHVeIf9VWAyHSDXecBAR21j+4y1U7AyX75xxylrZobOVqZ00esLezhVAZQc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713354595; c=relaxed/simple;
	bh=oVUEuuI42bWsaxNke/YXHgwDq1nx6otvSpOTGbkwhds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=a6l8fgt8Crxzd7aoPSApLDREhlDP4rGTZuAmXCXPVdAUwHsQkHxS1/hFKLkHPAoQhKriMFu7htZeCvt81O1QDf9KzUpLcLf4os2ltzD8GFuvaKwc8eSLaQseVK0qZ0kRWod1VPOrfoAOJRh9074FBc/MrKyyA/O6mPIbxW9XAgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com; spf=pass smtp.mailfrom=ap-south-1.amazonses.com; dkim=pass (2048-bit key) header.d=ltts.com header.i=@ltts.com header.b=M9D7V4Nc; dkim=pass (1024-bit key) header.d=amazonses.com header.i=@amazonses.com header.b=BSF0n8QH; arc=none smtp.client-ip=76.223.180.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=ltts.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ap-south-1.amazonses.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=i3fe3efcd4pbz7ipgssfqjhzqx347xbc; d=ltts.com; t=1713354591;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding;
	bh=oVUEuuI42bWsaxNke/YXHgwDq1nx6otvSpOTGbkwhds=;
	b=M9D7V4NcXJoBiQmfQRjA3oeYN1Hudpb8Vm8j0xpRiyDZsew2rUNBvC8Esxpmx7/F
	wwzVri8NdoixmfiBCowfxMb0ivOAAKiIVKuDQMt32O9uVfp+zbCqkQGCzWKPfLD52vX
	rodjKF0+du/qoBOiNh5MOexnNa/4HTiuLC6Hc9IjvM0ZIAP17IoJMbipu+c4ImEauxf
	vPsLnohpjbQYoD3PewCbeKsjRPq0c3dZmXeoBHtCTWPlQTuM/dn/XNuMxNVD+HtR6lA
	edNsYxYsFVFDg4meH8n0xgb80ooCDfqbvGGLT+opT7bK1k2qxhWK+RdgRV1nNdhVo5b
	SmgyZByNYA==
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/simple;
	s=rlntogby6xsxlfnvyxwnvvhttakdsqto; d=amazonses.com; t=1713354591;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Transfer-Encoding:Feedback-ID;
	bh=oVUEuuI42bWsaxNke/YXHgwDq1nx6otvSpOTGbkwhds=;
	b=BSF0n8QHHC0TuLLD6LWAbWjJj1fydn9gP0Az80XBzaxuROM8dVI4S8mZ0k2CnAVI
	abCaUN6eVUNTz+7PSFqI4eJU+NqQm9SK6vQq5TGi082zRQRhppYYerNC6Q51q+YHM9g
	cLsRPanlGLiK6ns6oglLSHu3YOhq7BrnAWwuLsrE=
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
Subject: [PATCH v7 00/10]  Add support for TI TPS65224 PMIC
Date: Wed, 17 Apr 2024 11:49:50 +0000
Message-ID: <0109018eebe44ad2-cb18c65f-25e5-4b3b-a85c-038286600d34-000000@ap-south-1.amazonses.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Feedback-ID: 1.ap-south-1./RC/PI2M8xOxQmTMPi0M1Q8h2FX69egpT62QKSaMPIA=:AmazonSES
X-SES-Outgoing: 2024.04.17-76.223.180.39

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

Changelog v6 -> v7:
- of_match_table data field now contains only chip_id
- Refactoring pinctrl driver: combining two switch cases into one in
  probe function. 

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
 drivers/regulator/tps6594-regulator.c         | 243 ++++++++++--
 include/linux/mfd/tps6594.h                   | 351 +++++++++++++++++-
 10 files changed, 1169 insertions(+), 143 deletions(-)


base-commit: 2863b714f3ad0a9686f2de1b779228ad8c7a8052
-- 
2.25.1


