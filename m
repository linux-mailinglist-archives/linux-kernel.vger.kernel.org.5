Return-Path: <linux-kernel+bounces-167457-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 58C2E8BA9D3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:23:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1291028627B
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 09:23:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66DC414F9C2;
	Fri,  3 May 2024 09:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NxjknMmh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4FF14F13D;
	Fri,  3 May 2024 09:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714728028; cv=none; b=VJUujmS6MEkfhsD2udSs5NEnCRSXMQv+RJlJWZHgm9LAeMTd6LK9ZyBcLI5nvYFozq1xWFZ23vR4YyTBoBYofwHCdrf7nEKKuY2lETAnW8T+5sZIYil5MHtbXuEXJWIPXCSVjwvk86jdcy2L9VRYO/w84x2EXj91Zw6gq1WJCZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714728028; c=relaxed/simple;
	bh=fy6FxSu0cqTQvWDYYzdNQibPVZfADLl8MbYVCyUvbWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QeNMAyHPXG+A7B1O5Rax5QdvE8O61vjEhcXOvpLENECZOpy1vfrKiM8ABK1aeA9AEIsKC6LhZ/55FW7NCmKaD8t6urkZBt/yP72YJYj33ds6dEItqvd/w2eMYjv5gnCknKRymsOCx22l8SpYlVuOPlj7wuirwLrfQYmJyVHiiiQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NxjknMmh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44B3EC116B1;
	Fri,  3 May 2024 09:20:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714728028;
	bh=fy6FxSu0cqTQvWDYYzdNQibPVZfADLl8MbYVCyUvbWc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NxjknMmh5vUI+1ocScunvSswB4eol9lkhUhyulij3YNu0byBPWZp339PixNbydQ9q
	 V7Ujm4OI7JX+OfXQAvRR+nlevC1H/h/Z+YwVeeAo9V+zx85kVmIKt3sQNt5rO5Pzfs
	 E44nEsjU37MEETJ5W8AFIY5t/oa8Hk0eG+Z0rDowi50ZlOkTpgmGuPfSALc9R+bKMh
	 24VKquRSjNNj3j4tzCmvVSWFg1T0NhsMVjig3rksNuXTUvEwS0VukELyFx2nv9JHc4
	 NqbiwlDQsIgkY4bqZFhZmu9R1c+8lg6H3JhxQQZLtsutJ2NO/qJxBYjPJmX4nRP5ve
	 lrnETyKMq2CKw==
Date: Fri, 3 May 2024 10:20:21 +0100
From: Lee Jones <lee@kernel.org>
To: linux-kernel@vger.kernel.org, Bhargav Raviprakash <bhargav.r@ltts.com>
Cc: m.nirmaladevi@ltts.com, robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
	jpanis@baylibre.com, devicetree@vger.kernel.org, arnd@arndb.de,
	gregkh@linuxfoundation.org, lgirdwood@gmail.com, broonie@kernel.org,
	linus.walleij@linaro.org, linux-gpio@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, nm@ti.com, vigneshr@ti.com,
	kristo@kernel.org, eblanc@baylibre.com
Subject: Re: (subset) [PATCH v8 00/10] Add support for TI TPS65224 PMIC
Message-ID: <20240503092021.GM1227636@google.com>
References: <0109018f2f24c15e-c50bfc29-5f1d-4368-a4b8-2c9f1d398abb-000000@ap-south-1.amazonses.com>
 <171472796178.1311350.4406575677999610125.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171472796178.1311350.4406575677999610125.b4-ty@kernel.org>

On Fri, 03 May 2024, Lee Jones wrote:

> On Tue, 30 Apr 2024 13:14:49 +0000, Bhargav Raviprakash wrote:
> > This series modifies the existing TPS6594 drivers to add support for the
> > TPS65224 PMIC device that is a derivative of TPS6594. TPS65224 has a
> > similar register map to TPS6594 with a few differences. SPI, I2C, ESM,
> > PFSM, Regulators and GPIO features overlap between the two devices.
> > 
> > TPS65224 is a Power Management IC (PMIC) which provides regulators and
> > other features like GPIOs, Watchdog, Error Signal Monitor (ESM) and
> > Pre-configurable Finite State Machine (PFSM). The SoC and the PMIC can
> > communicate through the I2C or SPI interfaces. The PMIC TPS65224
> > additionally has a 12-bit ADC.
> > Data Sheet for TPS65224: https://www.ti.com/product/TPS65224-Q1
> > 
> > [...]
> 
> Applied, thanks!
> 
> [01/10] mfd: tps6594: Add register definitions for TI TPS65224 PMIC
>         commit: 84ccfaee29fe46e305244a69c4471e83629ad5d1
> [02/10] mfd: tps6594: use volatile_table instead of volatile_reg
>         commit: 436250638b6d8e6cf8dceed82cdbbfc90ce3a775
> [03/10] dt-bindings: mfd: ti,tps6594: Add TI TPS65224 PMIC
>         commit: 91fbd800649f62bcc6a002ae9e0c0b6b5bb3f0d0
> [04/10] mfd: tps6594-i2c: Add TI TPS65224 PMIC I2C
>         commit: f8e5fc60e6666b46ce113b6b6de221ebba88668f
> [05/10] mfd: tps6594-spi: Add TI TPS65224 PMIC SPI
>         commit: 02716864fd5a53e057dcecdb36c807be6494120c
> [06/10] mfd: tps6594-core: Add TI TPS65224 PMIC core
>         commit: 9d855b8144e6016357eecdd9b3fe7cf8c61a1de3
> [07/10] misc: tps6594-pfsm: Add TI TPS65224 PMIC PFSM
>         commit: 91020aecc8136174429d41a6dae3de7cf39f8000
> [08/10] regulator: tps6594-regulator: Add TI TPS65224 PMIC regulators
>         commit: 00c826525fbae0230f6c3e9879e56d50267deb42
> [09/10] pinctrl: pinctrl-tps6594: Add TPS65224 PMIC pinctrl and GPIO
>         commit: 2088297159178ffc7c695fa34a7a88707371927d

Submitted for build testing.

If it passes, I'll send out a PR for other maintainers to pull from.

-- 
Lee Jones [李琼斯]

