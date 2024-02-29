Return-Path: <linux-kernel+bounces-87209-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C62986D11E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2816B28213A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F28B3757ED;
	Thu, 29 Feb 2024 17:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tyokibzF"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3941B6CC14;
	Thu, 29 Feb 2024 17:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228999; cv=none; b=Z6BW3LMQUyUr6r7pjPJMeWXNnycFPP6rxgxd+5EK7DtEUdkjD/Zs6SQsat50ju5wutbvYMLs5odQnKzr1ZsRCY5SqevwDdPfVRI1lItlVvlE2C2yTtyQ7eKtlKyP3g3oHkASo+zIr1jZ56BtWn1X06l/3hQ2TNUEecseFO8FFnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228999; c=relaxed/simple;
	bh=JONg6HvGOojSoSRJPEKuGTsiCE0zDoykG6uAHJ/ihnc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=awi2trA0FDTvuogq55ye+i92CwUVc/BtqmQyADhdRWejw+I27GK/Xue22MNT+7/3SelfRpNZUOqnAigbwOXxWpsA2I6a/G2vQrqKw6tXx6ueTEnrlQkz2YvxV9T8CrQLq6frAkfvHb9eONFZ+IcdejMwUa/tIj/uQMmz79sswOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tyokibzF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 260AFC433F1;
	Thu, 29 Feb 2024 17:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709228998;
	bh=JONg6HvGOojSoSRJPEKuGTsiCE0zDoykG6uAHJ/ihnc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tyokibzFYDSIyPqU5nT/wdhPqG6vLhyOT0kDecmI7MbMWEMLmeO4fBQGLtP+IPQDl
	 x6N2kI4/9prhKOSlrrhZrEl4Wb3eSmWsjt3an2nz3tGqeURQTpMfj4LbloSSMDnPne
	 n4BPQ4lV+qH/lcDgxQwFpcafMMAC/0uM6viVXPOZGVv6+/ijF+KpvhLtw8R11qVDbb
	 dkQ8r+RAZraVNlkGGVo69CLC9GLeYOKY9cnC1VvFYJKREOhQPnqd5f8uXRkDMuuisb
	 1CU2NY4TQR/lpS57O+TBQoAnQSHEkhYnHP5ylEEJnq3Ih1pMSCNFB2BunecgUkXObe
	 UMD4IAy/htCuQ==
Date: Thu, 29 Feb 2024 17:49:52 +0000
From: Lee Jones <lee@kernel.org>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com,
	robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
	conor+dt@kernel.org, jpanis@baylibre.com,
	devicetree@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org,
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com,
	kristo@kernel.org
Subject: Re: [PATCH v2 00/14]  Add support for TI TPS65224 PMIC
Message-ID: <20240229174952.GC1209090@google.com>
References: <20240223093701.66034-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240223093701.66034-1-bhargav.r@ltts.com>

On Fri, 23 Feb 2024, Bhargav Raviprakash wrote:

> This series modifies the existing TPS6594 drivers to add support for the
> TPS65224 PMIC device that is a derivative of TPS6594. TPS65224 has a
> similar register map to TPS6594 with a few differences. SPI, I2C, ESM,
> PFSM, Regulators and GPIO features overlap between the two devices.
> 
> TPS65224 is a Power Management IC (PMIC) which provides regulators and
> other features like GPIOs, Watchdog, Error Signal Monitor (ESM) and
> Pre-configurable Finite State Machine (PFSM). The SoC and the PMIC can
> communicate through the I2C or SPI interfaces. The PMIC TPS65224
> additionally has a 12-bit ADC.
> Data Sheet for TPS65224: https://www.ti.com/product/TPS65224-Q1
> 
> Driver re-use is applied following the advice of the following series:
> https://lore.kernel.org/lkml/2f467b0a-1d11-4ec7-8ca6-6c4ba66e5887@baylibre.com/
> 
> The features implemented in this series are:
> - TPS65224 Register definitions
> - Core (MFD I2C and SPI entry points)
> - PFSM	
> - ESM
> - Regulators
> - Pinctrl
> 
> TPS65224 Register definitions:
> This patch adds macros for register field definitions of TPS65224
> to the existing TPS6594 driver.  
> 
> Core description:
> I2C and SPI interface protocols are implemented, with and without
> the bit-integrity error detection feature (CRC mode).
> 
> PFSM description:
> Strictly speaking, PFSM is not hardware. It is a piece of code.
> PMIC integrates a state machine which manages operational modes.
> Depending on the current operational mode, some voltage domains
> remain energized while others can be off.
> PFSM driver can be used to trigger transitions between configured
> states.
> 
> ESM description:
> This device monitors the SoC error output signal at its nERR_MCU
> input pin. On error detection, ESM driver toggles the PMIC nRSTOUT pin
> to reset the SoC.
> 
> Regulators description:
> 4 BUCKs and 3 LDOs.
> BUCK12 can be used in dual-phase mode.
> 
> Pinctrl description:
> TPS65224 family has 6 GPIOs. Those GPIOs can also serve different
> functions such as I2C or SPI interface or watchdog disable functions.
> The driver provides both pinmuxing for the functions and GPIO capability.
> 
> This series was tested on linux-next tag: next-20240118
> 
> Test logs can be found here:
> https://gist.github.com/LeonardMH/58ec135921fb1062ffd4a8b384831eb0
> 
> Changelog v1 -> v2:
> - Changes to patch sign-off
> - Commit message change in dt-bindings patch
> - regmap config included in the of_match_table data field
> 
> Bhargav Raviprakash (11):
>   mfd: tps6594: use volatile_table instead of volatile_reg
>   mfd: tps6594: add regmap config in match data
>   dt-bindings: mfd: ti,tps6594: Add TI TPS65224 PMIC
>   mfd: tps6594-i2c: Add TI TPS65224 PMIC I2C
>   mfd: tps6594-spi: Add TI TPS65224 PMIC SPI
>   mfd: tps6594-core: Add TI TPS65224 PMIC core
>   misc: tps6594-pfsm: Add TI TPS65224 PMIC PFSM
>   misc: tps6594-esm: reversion check limited to TPS6594 family
>   misc: tps6594-esm: use regmap_field
>   misc: tps6594-esm: Add TI TPS65224 PMIC ESM
>   arch: arm64: dts: ti: k3-am62p5-sk: Add TPS65224 PMIC support in AM62P
>     dts
> 
> Nirmala Devi Mal Nadar (3):
>   mfd: tps6594: Add register definitions for TI TPS65224 PMIC
>   regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators
>   pinctrl: pinctrl-tps6594: Add TPS65224 PMIC pinctrl and GPIO
> 
>  .../devicetree/bindings/mfd/ti,tps6594.yaml   |   1 +
>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  95 +++++
>  drivers/mfd/tps6594-core.c                    | 266 +++++++++++--
>  drivers/mfd/tps6594-i2c.c                     |  41 +-
>  drivers/mfd/tps6594-spi.c                     |  41 +-
>  drivers/misc/tps6594-esm.c                    |  89 +++--
>  drivers/misc/tps6594-pfsm.c                   |  55 ++-
>  drivers/pinctrl/pinctrl-tps6594.c             | 287 ++++++++++++--
>  drivers/regulator/Kconfig                     |   4 +-
>  drivers/regulator/tps6594-regulator.c         | 244 ++++++++++--
>  include/linux/mfd/tps6594.h                   | 369 +++++++++++++++++-
>  11 files changed, 1325 insertions(+), 167 deletions(-)

Does this set have to be taken in wholesale?

-- 
Lee Jones [李琼斯]

