Return-Path: <linux-kernel+bounces-167373-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 19F228BA893
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:18:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C35BE1F228D0
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 08:18:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4709D148855;
	Fri,  3 May 2024 08:18:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cT/UZhzh"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DBD149C5C;
	Fri,  3 May 2024 08:18:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714724311; cv=none; b=frLJ4f9KopfuV1h4vE/nggxTI2X3+pN0Ezm1dBIDedr60c4Y4a14cNnRywCtCgm+Pk3juLhUf7kXcGA2zprD8dF6HFltMUt/+y+j8wd0H4jEZKoY/TlB+8qSujbsx2NY+vGj6uBLFXMGoxQaPHpOLgmDEedTGevUE/DjQwe30+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714724311; c=relaxed/simple;
	bh=Ar7uJX7Y9sXsbDOmIJMUCHFevTN4ih2GP+FjawYHoKU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UAQD4LHwccQUBUPd2e0OerMkzVm9MRNMGvl/jAKo2eZ82D8THYBvuXZ5qliatq+MNpNtWLrr0AsmSNN4+wqykfX3GGBuB72CWnvLF2V7YJhuxmk1BjtdSfKHYqS7UBlGj0vkxw8LvWjPVlUe9Ir+yH0FzYTBk6cq7utGguNeqIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cT/UZhzh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE542C116B1;
	Fri,  3 May 2024 08:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714724310;
	bh=Ar7uJX7Y9sXsbDOmIJMUCHFevTN4ih2GP+FjawYHoKU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cT/UZhzheEo8BNxry12VAnxMma0HNlH+1RB/bHS5QYg5IOSD4mj9+VCZlPjHcsW02
	 OrZ+ZycUrCzOTOvkD8dkC16GR/JbSBgaOd9JDrErk+YAWC2fz+xjWftfCN0N7BghHk
	 xEsJTrz9UZKrT/srpvSTzey8HFeOXP4hkOeA/z+KA0xCFWvNmxJpXEnuCfbD+XG2sv
	 zoVA2H6qKUvNZOdEaShKbDPliat7oTAhGXrnef4/3S3ajxDc0z+gkUC2vEixxsA4Kv
	 G0swc9lUWOKI956K6ZSLvtZuKLh5A6B8bJH4zsZ5LMruxVuMpUr3vhdriOpaX3po+l
	 I0Tog+m54kBCQ==
Date: Fri, 3 May 2024 09:18:24 +0100
From: Lee Jones <lee@kernel.org>
To: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Linus Walleij <linus.walleij@linaro.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Alex Bee <knaerzche@gmail.com>
Cc: Chris Zhong <zyw@rock-chips.com>, Zhang Qing <zhangqing@rock-chips.com>,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
	linux-gpio@vger.kernel.org
Subject: Re: [PATCH v4 0/5] Add RK816 PMIC support
Message-ID: <20240503081824.GI1227636@google.com>
References: <20240416161237.2500037-1-knaerzche@gmail.com>
 <171472425816.1279735.1509285489643125462.b4-ty@kernel.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <171472425816.1279735.1509285489643125462.b4-ty@kernel.org>

On Fri, 03 May 2024, Lee Jones wrote:

> On Tue, 16 Apr 2024 18:12:32 +0200, Alex Bee wrote:
> > This series aims to add support for Rockchip RK816 PMIC series. As per
> > datasheet it's targeted for RK3126/RK3128 (RK816-1), RK1108 (RK816-2) and
> > PX3-SE (RK816-3) but might be used for other SoCs as well. The MFD consists
> > of an integrated RTC, a GPIO controller, two 32k clock outputs, a power
> > key, 3 buck- and 6 ldo regulators, 3 regulator-switches, and charger with
> > integrated fuel gauge. Charger and fuel gauge are not part of this series.
> > Two of the switches (otg/boost) are part of the binding, but not of
> > the driver. They must only ever be enabled if no battery charging is
> > happening, but it will be enabled automatically if a battery is attached
> > and an external power source is connected. Thus that needs some
> > incorporation of a yet to be added charger driver.
> > Integration in the existing rk8xx-infrastructure was pretty straightforward
> > and only needed very little tweaking. In order to not further bloat the
> > driver(s) too much with additional `#define`s I tried to re-use existing
> > ones wherever possible.
> > 
> > [...]
> 
> Applied, thanks!
> 
> [1/5] dt-bindings: mfd: Add rk816 binding
>       commit: 06dfb41b1cf8d64327e5c4391e165f466506c4f0
> [2/5] mfd: rk8xx: Add RK816 support
>       commit: e9006f81faf8e438ea83626db578610e49f31576
> [3/5] pinctrl: rk805: Add rk816 pinctrl support
>       commit: 1bd97d64b5f0c01d03ecc9473ccfcf180dbbf54a
> [4/5] regulator: rk808: Support apply_bit for rk808_set_suspend_voltage_range
>       commit: 9f4e899c286b5127e2443d50e37ee2112efbfa2c
> [5/5] regulator: rk808: Add RK816 support
>       commit: 5eb068da74a0b443fb99a89d9e5062691649c470

Submitted for build testing.

If successful, I'll follow-up with a PR.

-- 
Lee Jones [李琼斯]

