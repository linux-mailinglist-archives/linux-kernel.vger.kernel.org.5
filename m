Return-Path: <linux-kernel+bounces-110189-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C7F2885B4F
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 16:01:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B24F21F23A69
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFF2E86244;
	Thu, 21 Mar 2024 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="SiD/LbjN"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1271E522;
	Thu, 21 Mar 2024 15:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711033272; cv=none; b=vA4GGGRc2+gjxD+aLLEsPfYFwikGcJTMfuqjt8K6lkTmRzYxJhnHgNFHeA21Y/dfuTsyfxI9qdeDwwnbPOoapV7Kw/0MM4H14cE17uGKtosMHy1n+86f3nx8V4xjWqtv+xagENmXAClauHm7s5FZ/uU/x0CWN7fuesMPh5lAD4Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711033272; c=relaxed/simple;
	bh=MeHpHFngmGDIRw0t6x3fj84LYp7O6nC0DGzx+CxZmLk=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=BMoW3imUhQOjEQHXshOfk9vlZcv9Xg3pFo5Y+P+mcZ4wZ76rUxrgzJQgc/zSeARzJoo+xZqHVEOv4g0NuJSEeqOmc0mOluupG127/0OsgunKGN2rWQhYBAYZL97FvqZhrh6fIPrj3bYWsx3ag6O4iOf+SApzE9/c0REyEvR0Dls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=SiD/LbjN; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1711033265;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sft1JFZk5skzUoNvqsIk2m0oGI7tbYzzfxLI3ZVhHZo=;
	b=SiD/LbjNKb4AO6tgV6/Tnd6/ux2gXYJ3AEfGypJAFLS34zSNhV4XKCSvE/81nMKXYNQhF7
	ts3F5nJiVETb0Sah0NxVllHxkf0/7k++xFSPaPaC7CisDQOwvahcKSqR+5faVYq+aLzZ3i
	bhNuRVjzJ6AriEpWFupgQFXvoVcfflf7f8IoYBpyFrU3eeLF8F91W0VAw7ajiONOZ+Q1Tw
	+6hFdXCd9duHSvBucRVIIOkJRpiB4fNzECssiiTWd+kd6EntvPe6HtfiB9Eukv/iM0z1p1
	mlpiDY1iM7rkx9N6ildz9N+ILdA31tAOirTTM2GfwPibJYUnLgQ7MU6dw1ai4A==
Date: Thu, 21 Mar 2024 16:01:04 +0100
From: Dragan Simic <dsimic@manjaro.org>
To: Alex Bee <knaerzche@gmail.com>
Cc: Lee Jones <lee@kernel.org>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley
 <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>, Linus Walleij
 <linus.walleij@linaro.org>, Liam Girdwood <lgirdwood@gmail.com>, Mark Brown
 <broonie@kernel.org>, Chris Zhong <zyw@rock-chips.com>, Zhang Qing
 <zhangqing@rock-chips.com>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 0/5] Add RK816 PMIC support
In-Reply-To: <20240321143911.90210-2-knaerzche@gmail.com>
References: <20240321143911.90210-2-knaerzche@gmail.com>
Message-ID: <9a79e319d671b6a257f13ff945ee87e5@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Alex,

On 2024-03-21 15:39, Alex Bee wrote:
> This series aims to add support for Rockchip RK816 PMIC series. As per
> datasheet it's targeted for RK3126/RK3128 (RK816-1), RK1108 (RK816-2) 
> and
> PX3-SE (RK816-3) but might be used for other SoCs as well. The mfd 
> consists
> of an integrated RTC, a GPIO controller, two 32k clock outputs, a power 
> key
> (output), 4 buck- and 5 ldo regulators, 3 regulator-switches, and 
> charger
> with integrated fuel gauge. Charger and fuel gauge are not part of this
> series. Two of the switches (otg/boost) are part of the binding, but 
> not of
> the driver. They must only ever by enabled if no battery charging is
> happening, but it will be enabled automatically if a battery is 
> attached.
> Thus they need some incorporation of a yet to be added charger driver.
> Integration in the existing rk8xx-infrastructure was pretty 
> straightforward
> and only needed very little tweaking. In order to not further bloat the
> driver(s) too much with additional definitions I tried to re-use 
> existing
> ones wherever possible.
> 
> The patches are loosely based on the vendor's implementation, verified
> against the datasheet and tested/measured on RK3126 board. As they are
> touching several subsystems I'm sending them (very) early for the
> 6.10-cycle.

I went quickly through all patches in the series except the one that 
adds
the bindings, and I've spotted no glaring issues.  My main focus was on
ensuring there should be no regressions.

Thus, not worth a Reviewed-by tag, but still counting as a review.

> Alex Bee (5):
>   dt-bindings: mfd: Add rk816 binding
>   mfd: rk8xx: Add RK816 support
>   pinctrl: rk805: Add rk816 pinctrl support
>   regulator: rk808: Support apply_bit for
>     rk808_set_suspend_voltage_range
>   regulator: rk808: Add RK816 support
> 
>  .../bindings/mfd/rockchip,rk816.yaml          | 259 ++++++++++++++++++
>  drivers/mfd/Kconfig                           |   4 +-
>  drivers/mfd/rk8xx-core.c                      | 103 +++++++
>  drivers/mfd/rk8xx-i2c.c                       |  45 ++-
>  drivers/pinctrl/pinctrl-rk805.c               |  68 +++++
>  drivers/regulator/rk808-regulator.c           | 218 ++++++++++++++-
>  include/linux/mfd/rk808.h                     | 141 ++++++++++
>  7 files changed, 831 insertions(+), 7 deletions(-)
>  create mode 100644 
> Documentation/devicetree/bindings/mfd/rockchip,rk816.yaml

