Return-Path: <linux-kernel+bounces-143801-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4B938A3D9E
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 18:12:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46B6D1F219B1
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Apr 2024 16:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 022434CB54;
	Sat, 13 Apr 2024 16:12:28 +0000 (UTC)
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F7193D977;
	Sat, 13 Apr 2024 16:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.27.42.2
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713024747; cv=none; b=HLNFF5W5uuV8RyVfd9wEWHAH7b4yBcyHGFV5TBM7CZCfQ0Bvpm8sgw622vyifwLdqDObtBplrg/eztNLC/gDSig/xTN827m89kMCf0fbjrsT5gaI6Oi2MRN+j2cpunaDupFxmvSPjatupmvoiYdsgX80m8wtNsn/JEwiOubT3rU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713024747; c=relaxed/simple;
	bh=x7hnoxzbJJ8qgfqKZBiZef7nuauvPUSisikz1nzB9DU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Xp8VJ3m2Wkcl8JcBIaN1qNWl6wz7DyPiLTDQFjPayRlV1dExCz077mQ09N2iuLQw8v9+9XGtjeKnngcqSQ9JSCR8keP2s3CVYNP8JDlBllX6h1aGKNKaVVhAoKDbKKZTMHJ1p+0xx2Csw1w9POEJvvpLbCOGvcLQKy3WYv+1d+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr; spf=pass smtp.mailfrom=free.fr; arc=none smtp.client-ip=212.27.42.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=free.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=free.fr
Received: from localhost.localdomain (unknown [82.64.135.138])
	by smtp2-g21.free.fr (Postfix) with ESMTPS id 9046E2003D6;
	Sat, 13 Apr 2024 18:12:04 +0200 (CEST)
Received: by localhost.localdomain (Postfix, from userid 1000)
	id 9349040039; Sat, 13 Apr 2024 18:11:10 +0200 (CEST)
Date: Sat, 13 Apr 2024 18:11:10 +0200
From: Etienne Buira <etienne.buira@free.fr>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Johan Jonker <jbx6244@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	shironeko <shironeko@tesaguri.club>,
	Etienne Buira <etienne.buira@free.fr>,
	Jonas Karlman <jonas@kwiboo.se>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Avoid error message on rk3328 use
Message-ID: <ZhqunpH6WjKEhePN@Z926fQmE5jqhFMgp6>
Mail-Followup-To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>, Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Johan Jonker <jbx6244@gmail.com>,
	Dragan Simic <dsimic@manjaro.org>,
	shironeko <shironeko@tesaguri.club>,
	Etienne Buira <etienne.buira@free.fr>,
	Jonas Karlman <jonas@kwiboo.se>, linux-gpio@vger.kernel.org,
	devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <ZhqO-DEmh-6TeHrt@Z926fQmE5jqhFMgp6>
 <f245966c-267f-4159-a9ca-2561693d24d9@linaro.org>
 <Zhqjhvq38oNH5-sR@Z926fQmE5jqhFMgp6>
 <45eea851-ed28-4066-8bc1-d04acf4021f7@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <45eea851-ed28-4066-8bc1-d04acf4021f7@linaro.org>

On Sat, Apr 13, 2024 at 05:49:13PM +0200, Krzysztof Kozlowski wrote:
> On 13/04/2024 17:23, Etienne Buira wrote:
> >>> presence of gpio,syscon-dev node (or it will call dev_err() when probed).
> >>> Correct rk3328.dtsi and related documentation to follow syscon's
> >>> expectations.
> >>
> >> No, look at gpio-syscon driver. Parent is used.
> > 
> > Parent is used, but the next lines are:
> > ret = of_property_read_u32_index(np, "gpio,syscon-dev", 1, &priv->dreg_offset);
> > if (ret)
> > 	dev_err(...)
> > 
> > So if gpio,syscon-dev does not have at least 2 items (or is missing),
> > dev_err will be called, 3 items for dev_dbg.
> > Current tree displays a spurious "can't read the data register offset"
> > message.
> 
> Hm, indeed, then I think driver, so
> aa1fdda8f7ebf83f678e8d3c2ab4f1638c94195f, should be fixed. Otherwise
> please say why binding is not correct and driver is good.

I tried fixing the driver first, this was discussed here:
https://lore.kernel.org/linux-gpio/ZhptEWb7tD5pummq@Z926fQmE5jqhFMgp6/T/#t
you're welcome to comment.

I have no strong opinion over what should be fixed, i just wished to
shut a spurious error message, that i expected to be straightforward at
first (hence good candidate for first kernel patch).

Regards


