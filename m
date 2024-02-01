Return-Path: <linux-kernel+bounces-47606-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64D02845030
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 05:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02D721F21F72
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 04:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 144883BB2F;
	Thu,  1 Feb 2024 04:22:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="lxcCNkqI"
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2F463B793;
	Thu,  1 Feb 2024 04:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706761330; cv=none; b=TKOV1ZDvGX4uaOmOjKIOHS4Uwdcx0DwFYC25RkI2oWe7zjlFJcAvDDuHttw2n02xibCU4FDdlVYKStxXbsM7iAz9sORE6kWEDyjXy7dsU7rTFS0PvXz8CjM0FtTBBIG8Oe31a51ILlXzag0s96O/Fi1Y5xv38dnvdefibAMxapw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706761330; c=relaxed/simple;
	bh=8yi1Yt/wU7R273IZJhQL8dLT0dnEIjg9xM90SHxgQ9E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XwMbneJk4sFQ1NsJ2aTUFG0SoBFCU95SOYDaTnXw5hhTsLWDNuOm9iXejCvqbfySxhc5PkCGSjJJ9WDRhjVJjgwuYkBZNiLW5e42iaHLaSDf0u+Bl2ycp+Nd6G6S8xzZeJSt8wZBw0X3cXuaijvH/DdfBV3SKK/fiTWdq71hgYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=lxcCNkqI; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
Received: from [192.168.68.112] (ppp14-2-76-194.adl-apt-pir-bras31.tpg.internode.on.net [14.2.76.194])
	by mail.codeconstruct.com.au (Postfix) with ESMTPSA id ED385200EF;
	Thu,  1 Feb 2024 12:22:05 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1706761326;
	bh=w6MrQ1SSd4QNFPRqzO93oM6DOsujYyGsnvdyUzbnhrY=;
	h=Subject:From:To:Cc:Date:In-Reply-To:References;
	b=lxcCNkqIgStPU3lyS/g3lYBqUYokDeqaCqGY+yP0HbKBD07V+9BpC7kKGo1RkPfM3
	 4f1YkoEay+zXFsIo8Ne+EUKSLtUR5iGUG6hchfO4Z6SmQYXv1GdZKL3mWAPOgEy4i0
	 ryw0IaHpB8aBGb1uDaVPqA2LRUx32M975Jm8CvrGPRAtsLdgXEtMSyxJCGJI7Wlr9A
	 1AJCDw6vzChz4A4oM7YDkXzZjyaSDM7//e4T9Q//ofzfjmJRyA9wlKJ1Y58/Qq/fxP
	 MQBFV5LqemQdE18YWSFb6+2Stvvc1rm9u7xfDSxvOZ7G6venY+24RIUnDHgGUnQ7Zf
	 x9zK7Jz/B3o1g==
Message-ID: <aebd29d6890e54e93b46a102e7ea7532ad7b32f4.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 05/21] ARM: dts: aspeed: yosemite4: Revise quad mode
 to dual mode
From: Andrew Jeffery <andrew@codeconstruct.com.au>
To: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>, patrick@stwcx.xyz, Rob
 Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Joel Stanley <joel@jms.id.au>
Cc: devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Thu, 01 Feb 2024 14:52:05 +1030
In-Reply-To: <20240131084134.328307-6-Delphine_CC_Chiu@wiwynn.com>
References: <20240131084134.328307-1-Delphine_CC_Chiu@wiwynn.com>
	 <20240131084134.328307-6-Delphine_CC_Chiu@wiwynn.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4-2 
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Wed, 2024-01-31 at 16:41 +0800, Delphine CC Chiu wrote:
> Revise quad mode to dual mode to avoid WP pin influnece the SPI

What do you mean by this? Can you unpack what's going on a little more
in the commit message?

Andrew

>=20
> Signed-off-by: Delphine CC Chiu <Delphine_CC_Chiu@wiwynn.com>
> ---
>  .../arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
>=20
> diff --git a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts b=
/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> index f8bfdefbefc6..23006dca5f26 100644
> --- a/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> +++ b/arch/arm/boot/dts/aspeed/aspeed-bmc-facebook-yosemite4.dts
> @@ -149,15 +149,17 @@ flash@0 {
>  		status =3D "okay";
>  		m25p,fast-read;
>  		label =3D "bmc";
> -		spi-rx-bus-width =3D <4>;
> +		spi-tx-bus-width =3D <2>;
> +		spi-rx-bus-width =3D <2>;
>  		spi-max-frequency =3D <50000000>;
> -#include "openbmc-flash-layout-64.dtsi"
> +#include "openbmc-flash-layout-128.dtsi"
>  	};
>  	flash@1 {
>  		status =3D "okay";
>  		m25p,fast-read;
>  		label =3D "bmc2";
> -		spi-rx-bus-width =3D <4>;
> +		spi-tx-bus-width =3D <2>;
> +		spi-rx-bus-width =3D <2>;
>  		spi-max-frequency =3D <50000000>;
>  	};
>  };


