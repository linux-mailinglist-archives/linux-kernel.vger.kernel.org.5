Return-Path: <linux-kernel+bounces-167369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE98C8BA885
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DFEB01C22270
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:17:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E7B148FE7;
	Fri,  3 May 2024 08:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Kuf0QMbL"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59BD0148832;
	Fri,  3 May 2024 08:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724262; cv=none; b=P2nqEGeZjcYgf8twntgoGL1w+qz7QtF1gxoc39zmyXAxSndu589HOGxEutNJiv2Ec+qXfGpscJSzd/KOQHpqyOMy9qqN9SaJiQBkADPHmGeUfVgv2VejHN9llXU2w8zI/K8+XroVgElVU7jx+jCkSuOBHiDeDgFoNfmDDftA+HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724262; c=relaxed/simple;
	bh=L4fcBnx7rVE5jkyMNRG7+h4TM5NQvUoFZYQ/z4TVVko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=XzuMfkxpn9et6gYAvfSVuEnqt6IxYgE9c0XmS91+Ad/YqHXVi8jEyiz+pAwTlvRJPI4Afxx5fwjhH7FwTEHVo+iCNv3/jEB/I+6Oj4ogmoRNgDP7jz/JF26ZbeSzdgpT2l6K/EsPjAUGVavIaihC0pS4i5yQ252ulf19cKQo2sU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Kuf0QMbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 748EDC116B1;
	Fri,  3 May 2024 08:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714724261;
	bh=L4fcBnx7rVE5jkyMNRG7+h4TM5NQvUoFZYQ/z4TVVko=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Kuf0QMbLFG5D40e/CrQeZTzoKyX1NQ9mRD2fYcp+lKKv6QfVSd39D72RRGvDY0ngc
	 OesvviXJX5AQHmBJlLj9md7UP8iyoO3QuY3nun3Y2EfWjZUqW5uteD6HIy8FkBic7W
	 NEWZd155Cl7isw05T3NA/N5TNcUVHP3+zMAfaPjAgKyVlXz2JriPC5ipuZ58Hws99W
	 5VMDet3GTb1+oT8ZfGBHLCp+qr0UxZihgvremiJh+e+KP2T0Mx66ROMnUXeKfi82mN
	 QGFT2UYueiNvJr2XXxBkComRuutBI1o0/rUn9E6YaL1yJmVJIoDE+IhbMrCJtlRYLH
	 B/TavgDQseNqw==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, 
 Linus Walleij <linus.walleij@linaro.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Alex Bee <knaerzche@gmail.com>
Cc: Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-gpio@vger.kernel.org
In-Reply-To: <20240416161237.2500037-1-knaerzche@gmail.com>
References: <20240416161237.2500037-1-knaerzche@gmail.com>
Subject: Re: [PATCH v4 0/5] Add RK816 PMIC support
Message-Id: <171472425816.1279735.1509285489643125462.b4-ty@kernel.org>
Date: Fri, 03 May 2024 09:17:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.12.4

On Tue, 16 Apr 2024 18:12:32 +0200, Alex Bee wrote:
> This series aims to add support for Rockchip RK816 PMIC series. As per
> datasheet it's targeted for RK3126/RK3128 (RK816-1), RK1108 (RK816-2) and
> PX3-SE (RK816-3) but might be used for other SoCs as well. The MFD consists
> of an integrated RTC, a GPIO controller, two 32k clock outputs, a power
> key, 3 buck- and 6 ldo regulators, 3 regulator-switches, and charger with
> integrated fuel gauge. Charger and fuel gauge are not part of this series.
> Two of the switches (otg/boost) are part of the binding, but not of
> the driver. They must only ever be enabled if no battery charging is
> happening, but it will be enabled automatically if a battery is attached
> and an external power source is connected. Thus that needs some
> incorporation of a yet to be added charger driver.
> Integration in the existing rk8xx-infrastructure was pretty straightforward
> and only needed very little tweaking. In order to not further bloat the
> driver(s) too much with additional `#define`s I tried to re-use existing
> ones wherever possible.
> 
> [...]

Applied, thanks!

[1/5] dt-bindings: mfd: Add rk816 binding
      commit: 06dfb41b1cf8d64327e5c4391e165f466506c4f0
[2/5] mfd: rk8xx: Add RK816 support
      commit: e9006f81faf8e438ea83626db578610e49f31576
[3/5] pinctrl: rk805: Add rk816 pinctrl support
      commit: 1bd97d64b5f0c01d03ecc9473ccfcf180dbbf54a
[4/5] regulator: rk808: Support apply_bit for rk808_set_suspend_voltage_range
      commit: 9f4e899c286b5127e2443d50e37ee2112efbfa2c
[5/5] regulator: rk808: Add RK816 support
      commit: 5eb068da74a0b443fb99a89d9e5062691649c470

--
Lee Jones [李琼斯]


