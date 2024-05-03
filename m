Return-Path: <linux-kernel+bounces-167455-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 289D08BA9CF
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5AD711C20B8D
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 423F6150987;
	Fri,  3 May 2024 09:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mdvq/YrO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E40D14F114;
	Fri,  3 May 2024 09:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714727966; cv=none; b=b1xvWyGGqoZZWjkq+ZU/j0LCSGgJc+2BMDezpDwSzJpL8zKNfhx2fvKfGugL1QvM3hp2AchtiNtGUllAawv27pOWSQIxOLqCHOKgGnp7tEJplJk+dR38mafIv2Njkhd18MRyeOlLJdws6muguDTxUb3hDX1V2LrzCfoZi0UqOXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714727966; c=relaxed/simple;
	bh=YFoaA2afiGryqt098GWkvq1dcjMWzSgISiyLhoAW5Bk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=moGalLDkMib8OR1lO1M4nTPUWwVRqHEAv9O8E4ptVow/SWUIwTdTQhiNBEZL7EbtVr3GToI1Pc87bpWQzLz/h0uQIYpEV/Xswi/vEp4QmOOqYV1WPUhziw4zAsfwbejKhnUc6l2L9GrHTdJgMyzLwkkO/AC+wQwXD+zjVLtl0XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mdvq/YrO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19A78C116B1;
	Fri,  3 May 2024 09:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714727966;
	bh=YFoaA2afiGryqt098GWkvq1dcjMWzSgISiyLhoAW5Bk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Mdvq/YrOIbZmbljuxTHM5LkOTYH582IFf7I5al1Wgo6piaDRc+7pw+2wYV35VAFN5
	 GWYn2UoxoiaMPQ5Or5wFyPj+Qerbxe86wZzHRz4nI5O6JY0PibJdfbsVo+PXhx5JPP
	 wfWiQYDEEPZbK9tw2bd7eLctOIiC1U/JWrGIBMnkVqpAL9oIV0qKDEzLdw73Z2y+/O
	 EetXu3Z82EoBkcwQJPFXvRO1rSdOWUxj0JbCKzXhFBQpQcA3Iw9SyE/HEJfXrX/uZQ
	 dbsGn8lc++fsGfB8nSgtNUpWluo6WE19aE3uUbaMStyiY0iIj7im92GV++ZvLKVje6
	 +Q1nH2bp/cR5g==
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: m.nirmaladevi@ltts.com, lee@kernel.org, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, jpanis@baylibre.com, 
 devicetree@vger.kernel.org, arnd@arndb.de, gregkh@linuxfoundation.org, 
 lgirdwood@gmail.com, broonie@kernel.org, linus.walleij@linaro.org, 
 linux-gpio@vger.kernel.org, linux-arm-kernel@lists.infradead.org, nm@ti.com, 
 vigneshr@ti.com, kristo@kernel.org, eblanc@baylibre.com
In-Reply-To: <0109018f2f24c15e-c50bfc29-5f1d-4368-a4b8-2c9f1d398abb-000000@ap-south-1.amazonses.com>
References: <0109018f2f24c15e-c50bfc29-5f1d-4368-a4b8-2c9f1d398abb-000000@ap-south-1.amazonses.com>
Subject: Re: (subset) [PATCH v8 00/10] Add support for TI TPS65224 PMIC
Message-Id: <171472796178.1311350.4406575677999610125.b4-ty@kernel.org>
Date: Fri, 03 May 2024 10:19:21 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 30 Apr 2024 13:14:49 +0000, Bhargav Raviprakash wrote:
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
> [...]

Applied, thanks!

[01/10] mfd: tps6594: Add register definitions for TI TPS65224 PMIC
        commit: 84ccfaee29fe46e305244a69c4471e83629ad5d1
[02/10] mfd: tps6594: use volatile_table instead of volatile_reg
        commit: 436250638b6d8e6cf8dceed82cdbbfc90ce3a775
[03/10] dt-bindings: mfd: ti,tps6594: Add TI TPS65224 PMIC
        commit: 91fbd800649f62bcc6a002ae9e0c0b6b5bb3f0d0
[04/10] mfd: tps6594-i2c: Add TI TPS65224 PMIC I2C
        commit: f8e5fc60e6666b46ce113b6b6de221ebba88668f
[05/10] mfd: tps6594-spi: Add TI TPS65224 PMIC SPI
        commit: 02716864fd5a53e057dcecdb36c807be6494120c
[06/10] mfd: tps6594-core: Add TI TPS65224 PMIC core
        commit: 9d855b8144e6016357eecdd9b3fe7cf8c61a1de3
[07/10] misc: tps6594-pfsm: Add TI TPS65224 PMIC PFSM
        commit: 91020aecc8136174429d41a6dae3de7cf39f8000
[08/10] regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators
        commit: 00c826525fbae0230f6c3e9879e56d50267deb42
[09/10] pinctrl: pinctrl-tps6594: Add TPS65224 PMIC pinctrl and GPIO
        commit: 2088297159178ffc7c695fa34a7a88707371927d

--
Lee Jones [李琼斯]


