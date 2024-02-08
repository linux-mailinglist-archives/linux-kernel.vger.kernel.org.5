Return-Path: <linux-kernel+bounces-57836-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5144C84DE02
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 11:19:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83C771C272C6
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 10:19:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D326F6EB47;
	Thu,  8 Feb 2024 10:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iWDw9Cgc"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6CA6E2D8
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 10:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707387557; cv=none; b=siqdYjOvr2hyAI2m6cUxji4nZQQYdQ2VU7NcpYaBaIKGhAB13ZwCZY2ieKiU5MPxYH1+hgk/0c1YlQxGxH3CQVXgMDGOz2ei1JclL2Nlpa2eUvHm8IFnFHOQjPUF/2JSUvQsBk0d3FhOYlKQwH6/6Izr6NqzxLcDSLNSlTpO+/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707387557; c=relaxed/simple;
	bh=y8pomLnf1+1TjMjjYHn4mNNbajtTv+HH5+Nzqa1F8i8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dl0CLskaTkgg4uPyhMDZ6q4Q5QOi0D169gK++VVWY4rHfTZmLn97j5Jemeo2qKLHHTaX652ClfsWkKUgmhT/ekAyWQxq0GsMQ3gRtkHnuIx52ajjcPXiUTl0zJIcpRxdvGwTKOqOLclKrbQmuOQtO2/cCLkoAuGrGfaBdjlmNLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iWDw9Cgc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7969C43390;
	Thu,  8 Feb 2024 10:19:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707387556;
	bh=y8pomLnf1+1TjMjjYHn4mNNbajtTv+HH5+Nzqa1F8i8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iWDw9Cgc/dGbMNbpxGMvDXjsBu1m8tdKSSkf5I0QK3uU6ydigkLTwVyFLyjx9UQju
	 Z4WuSHfc/RX2BdOqApRmkk7Gj8+/eh/JHw7r4a3n/+14xKdibxZaD3cnLDBaDiYu/Z
	 vU6Qf2ZQpo4EqtnsCfgufkh85K680aY0XUVUPLN7OfGcbzrkBpy92JdYaRV6TZyISt
	 5UWKYWW/HmstEqVCifdDntRvigy4rAuGyt6KOsHuT9w0yFDLnvQi9vQ5CuiO2gY7wW
	 lPQo8CvERszaqVAk6Q2jvNbfWXzJccc3p9MT+jmaR5z6XYWQPs76UGhPevLYQWbykW
	 IGTfobjGLS+Qw==
Date: Thu, 8 Feb 2024 10:19:12 +0000
From: Lee Jones <lee@kernel.org>
To: Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: linux-kernel@vger.kernel.org, m.nirmaladevi@ltts.com
Subject: Re: [PATCH v1 00/13]  Add support for TI TPS65224 PMIC
Message-ID: <20240208101912.GD689448@google.com>
References: <20240208091922.1206916-1-bhargav.r@ltts.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240208091922.1206916-1-bhargav.r@ltts.com>

On Thu, 08 Feb 2024, Bhargav Raviprakash wrote:

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
> Bhargav Raviprakash (10):
>   mfd: tps6594: use volatile_table instead of volatile_reg
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

How did you send this set?

Any idea how it ended up in 3 separate threads?

Tracking this set is going to cause issues.

Also, please send all patches to all maintainers.

> Nirmala Devi Mal Nadar (3):
>   mfd: tps6594: Add register definitions for TI TPS65224 PMIC
>   regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators
>   pinctrl: pinctrl-tps6594: Add TPS65224 PMIC pinctrl and GPIO
> 
>  .../devicetree/bindings/mfd/ti,tps6594.yaml   |   1 +
>  arch/arm64/boot/dts/ti/k3-am62p5-sk.dts       |  95 +++++
>  drivers/mfd/tps6594-core.c                    | 258 ++++++++++++-
>  drivers/mfd/tps6594-i2c.c                     |  20 +-
>  drivers/mfd/tps6594-spi.c                     |  18 +-
>  drivers/misc/tps6594-esm.c                    |  89 +++--
>  drivers/misc/tps6594-pfsm.c                   |  55 ++-
>  drivers/pinctrl/pinctrl-tps6594.c             | 287 ++++++++++++--
>  drivers/regulator/Kconfig                     |   4 +-
>  drivers/regulator/tps6594-regulator.c         | 244 ++++++++++--
>  include/linux/mfd/tps6594.h                   | 358 +++++++++++++++++-
>  11 files changed, 1272 insertions(+), 157 deletions(-)
> 
> 
> base-commit: 2863b714f3ad0a9686f2de1b779228ad8c7a8052
> -- 
> 2.25.1
> 

-- 
Lee Jones [李琼斯]

