Return-Path: <linux-kernel+bounces-61837-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C400F85173E
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:45:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E91141C2123C
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D193B780;
	Mon, 12 Feb 2024 14:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RoOMYfZK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08E9D3BB46;
	Mon, 12 Feb 2024 14:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707749119; cv=none; b=tWlnML4GW82QPGFnZx9JORbOorFEFL/Fa+hOE4lCWi//ONGiBIHjeKglhF4iQQ6mOwb9pdRgQtL9/ZNxp4wuGI85FV/jvAhLVVcAqMAEJ2ZLpJdVCsMKNjF9l9+QTnqIG4TrwVEKvnMrbQ19E3QBdFuyVYHRC0ETJBaLqX/Ugc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707749119; c=relaxed/simple;
	bh=Uy1Hm9Mf3DmrZrxeQWTmF971xd/SzhqApTD6KqZ4D6g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zcd88ur30g7+W/KKTwKak/VnpOn7cwqlAHTi+cOTOLDEKvh2eRwfODpOr3dfxWTiSlRzj+NmOGyBTmmXgmkPiM95orrV0v49IT9K6+aKl/si8o2B101UN8nfdwteu9ah0jT1zTa5McBa7Dy5dBltQjTDrMawru0fZT+de//DrSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RoOMYfZK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B27AC433F1;
	Mon, 12 Feb 2024 14:45:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707749118;
	bh=Uy1Hm9Mf3DmrZrxeQWTmF971xd/SzhqApTD6KqZ4D6g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RoOMYfZKgD8COEAhzGgUFwSARdrtr2Vc5dPquEXPszpOgD/5ee88wy6GdU4Sd0BQb
	 +8x1GyckSVT3oJUYR5azNO9cLuStG8b1Jb1SgfQnT3fJXbfnTfmsm7oOKQ1BHJ1XoI
	 v/wP6LARAixstuhtEmq2PHwvN+NUSEEGxAy4pqK59xpwz5YWy2pX9YEU4es5USbDxa
	 AnyTbH6MBUHlBhIDvTY4+9suY42Rj5MQRI72UQYexuB9r1/a42PzfQ0eguEXKienvo
	 scdFV71Hpi8/GRTzpW2pPoJCkwnKzwordFgFVGTYeR1kExWjOIlE5Iozp1ekkRjN1E
	 Pu+OL9u1uiiww==
Date: Mon, 12 Feb 2024 08:45:16 -0600
From: Rob Herring <robh@kernel.org>
To: =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc: Russell King <linux@armlinux.org.uk>,
	Daniel Lezcano <daniel.lezcano@linaro.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	devicetree@vger.kernel.org, linux-clk@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
	=?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH V3 0/3] dt-bindings: arm: mediatek: convert
 MT7622-related bindings to the json-schema
Message-ID: <20240212144516.GA301127-robh@kernel.org>
References: <20240211213925.18348-1-zajec5@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240211213925.18348-1-zajec5@gmail.com>

On Sun, Feb 11, 2024 at 10:39:22PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> There are more MediaTek bindings to convert but for now I focused on
> those used by MT7622.
> 
> V2: Move bindings to /clock/
>     Use clock-controller@ nodenames
>     Drop incorrectly specified "syscon"
> 
> V3: Update titles of all 3 bindings
>     Simplify HIFSYS compatbile (drop "items:")
> 
> Rafał Miłecki (3):
>   dt-bindings: arm: mediatek: convert hifsys to the json-schema clock
>   dt-bindings: arm: mediatek: convert PCIESYS to the json-schema clock
>   dt-bindings: arm: mediatek: convert SSUSBSYS to the json-schema clock

dt-bindings: clock: mediatek: ...

>  .../bindings/arm/mediatek/mediatek,hifsys.txt | 26 ----------
>  .../arm/mediatek/mediatek,pciesys.txt         | 25 ----------
>  .../arm/mediatek/mediatek,ssusbsys.txt        | 25 ----------
>  .../clock/mediatek,mt2701-hifsys.yaml         | 50 +++++++++++++++++++
>  .../clock/mediatek,mt7622-pciesys.yaml        | 45 +++++++++++++++++
>  .../clock/mediatek,mt7622-ssusbsys.yaml       | 45 +++++++++++++++++
>  6 files changed, 140 insertions(+), 76 deletions(-)
>  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,hifsys.txt
>  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,pciesys.txt
>  delete mode 100644 Documentation/devicetree/bindings/arm/mediatek/mediatek,ssusbsys.txt
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt2701-hifsys.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7622-pciesys.yaml
>  create mode 100644 Documentation/devicetree/bindings/clock/mediatek,mt7622-ssusbsys.yaml

Presumably Stephen should take these, but you Cc'ed the timekeeping 
maintainers rather than the clock maintainers. Please use 
get_maintainer.pl.

Rob

