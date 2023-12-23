Return-Path: <linux-kernel+bounces-10438-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5039C81D462
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:59:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 098F7283258
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 13:59:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69C9EDDBE;
	Sat, 23 Dec 2023 13:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="e84tp7Gj"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F4B12E47;
	Sat, 23 Dec 2023 13:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1703339976; bh=6Xv3jIezLLrGsPqesJGGEmcdDlVoYdKAL1CcLWN2x+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e84tp7Gj3gga8cNmaXGRKwtVXr6tILWml91YIF4LTDDeiRWLFo+wFeJFiuAPwSnGC
	 NG0U0VAbnPGRG9qgB7ZNhXW/+QKvpAbRXhvNHZqW2Fh3RsWlpUhboeJYezwOJ60tBO
	 JFJQFuEztp+0a/cCK9auofz755xb17UQwc4+aWr4KdGpZ/dA49F/eE+XsnN8guLX6h
	 33H++c/MqcUubrBvpZQw4VaQyb5Pa+pr2yC0Xv/Wmfwtxu8dGvxLY3vRRT7k7s/2u8
	 HVHOeqrD1LA4iYCqaCbeBvncELNpnzRB0wb8Yj2ROv5BzH6sDSmh/Y5JxzHEH7aiwI
	 Yf8et5MQEJ/rw==
Received: from mecka.net (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id B748E3718AE;
	Sat, 23 Dec 2023 14:59:35 +0100 (CET)
Date: Sat, 23 Dec 2023 14:59:34 +0100
From: Manuel Traut <manut@mecka.net>
To: Diederik de Haas <didi.debian@cknow.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
	Jessica Zhang <quic_jesszhan@quicinc.com>,
	Sam Ravnborg <sam@ravnborg.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
	Rob Herring <robh+dt@kernel.org>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>, Sandy Huang <hjc@rock-chips.com>,
	Mark Yao <markyao0591@gmail.com>,
	Segfault <awarnecke002@hotmail.com>,
	Arnaud Ferraris <aferraris@debian.org>,
	dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 4/6] arm64: dts: rockchip: Add devicetree for Pine64
 Pinetab2
Message-ID: <ZYbnxkkCIJtzqa0h@mecka.net>
References: <20231222-pinetab2-v1-0-e148a7f61bd1@mecka.net>
 <20231222-pinetab2-v1-4-e148a7f61bd1@mecka.net>
 <2121710.IWpXjAX0fk@bagend>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2121710.IWpXjAX0fk@bagend>

Hi Diederik,

On Fri, Dec 22, 2023 at 06:01:54PM +0100, Diederik de Haas wrote:
> On Friday, 22 December 2023 12:05:44 CET Manuel Traut wrote:
> > +
> > +&cru {
> > +       assigned-clocks = <&cru PLL_GPLL>, <&pmucru PLL_PPLL>, <&cru
> > PLL_VPLL>; +       assigned-clock-rates = <1200000000>, <200000000>,
> > <500000000>; +};
> 
> Attachment seem to work and for this I also have the attached patch in my 
> patch set.
> IIRC without it you get an error in dmesg immediately at boot up which is 
> visible on the PT2 *if* you have immediate visual output (which is not (yet?) 
> the case in my image/kernel).

you can see the message also by calling "dmesg --level err".
I could verify that your patch removes the error message.
I will pick the change for v2.

> Cheers,
>   Diederik

> From d782a64f3b51ffb2f33d3ba3e11e2ebc416542e3 Mon Sep 17 00:00:00 2001
> From: Jonas Karlman <jonas@kwiboo.se>
> Date: Thu, 17 Aug 2023 17:52:47 +0200
> Subject: [PATCH 6/8] arm64: dts: rk3566-pinetab2: Fix cru assigned clocks
> 
> Jonas Karlman provided/linked to the patch on IRC.
> Seems related to upstream commit 64b69474edf3b885c19a89bb165f978ba1b4be00.
> 
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> Link: https://github.com/Kwiboo/u-boot-rockchip/blob/rk3568-2023.10/arch/arm/dts/rk3566-pinetab2-u-boot.dtsi#L11-L15
> Link: https://lore.kernel.org/all/20230110225547.1563119-2-jonas@kwiboo.se/
> ---
>  arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
> index bbd7ed53602a..4a5bee5a28a7 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
> @@ -288,8 +288,9 @@ &cpu3 {
>  };
>  
>  &cru {
> -	assigned-clocks = <&cru PLL_GPLL>, <&pmucru PLL_PPLL>, <&cru PLL_VPLL>;
> -	assigned-clock-rates = <1200000000>, <200000000>, <500000000>;
> +	assigned-clocks = <&pmucru CLK_RTC_32K>, <&cru PLL_GPLL>, <&pmucru PLL_PPLL>, <&cru PLL_VPLL>;
> +	assigned-clock-rates = <32768>, <1200000000>, <200000000>, <500000000>;
> +	assigned-clock-parents = <&pmucru CLK_RTC32K_FRAC>;
>  };
>  
>  &csi_dphy {
> -- 
> 2.42.0
> 




