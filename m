Return-Path: <linux-kernel+bounces-10440-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F7C281D46F
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 15:03:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9354F1C21157
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 14:03:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC37DDDD2;
	Sat, 23 Dec 2023 14:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mecka.net header.i=@mecka.net header.b="C2Uf9Eyr"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mecka.net (mecka.net [159.69.159.214])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B60BD51D;
	Sat, 23 Dec 2023 14:03:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mecka.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mecka.net
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mecka.net; s=2016.11;
	t=1703340218; bh=5OOE51P/fnbC7hmn3p7A0wk68byUx7ej8itJJrIT0xs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C2Uf9EyrzPWACpvRQMmg+3hQATX2cDa/Ke2lo5WPRtI9MORmxmGR4uaY7PJ8MnujY
	 Fcj6oTbCdS1GM8kwY10kD+puJlZ19d2ueZalm1ZauJjHNlB5OILOcKAZlqYHKRIQFJ
	 uow61GOmFMKuTo8eRcs7sSDeuzLFP7YG3M9TOozd2ZBMu/cz0jBbVzeCRtZFdWoDoo
	 D6lADdOlZycixIOjJj6trDoA2C2XjuayAHQI2kLNhQwTkwQQjjUOQ/orwQYQ1j4y0+
	 GFrBRB/JPOTrj9uhgR9/hFwTDnSwc10U+PE/Dk1UjDt4nsnaDHdKdl3UWXYhS5zSQp
	 bgxbcUZ+fTwFg==
Received: from mecka.net (unknown [185.147.11.134])
	by mecka.net (Postfix) with ESMTPSA id 788423718BA;
	Sat, 23 Dec 2023 15:03:37 +0100 (CET)
Date: Sat, 23 Dec 2023 15:03:36 +0100
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
	Danct12 <danct12@disroot.org>, dri-devel@lists.freedesktop.org,
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-rockchip@lists.infradead.org
Subject: Re: [PATCH 4/6] arm64: dts: rockchip: Add devicetree for Pine64
 Pinetab2
Message-ID: <ZYbouFFFmf7PInOk@mecka.net>
References: <20231222-pinetab2-v1-0-e148a7f61bd1@mecka.net>
 <20231222-pinetab2-v1-4-e148a7f61bd1@mecka.net>
 <2250271.fI8GBZLEnK@bagend>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2250271.fI8GBZLEnK@bagend>

On Fri, Dec 22, 2023 at 05:49:35PM +0100, Diederik de Haas wrote:
> On Friday, 22 December 2023 12:05:44 CET Manuel Traut wrote:
> > +       rk817-sound {
> > +               compatible = "simple-audio-card";
> > +               pinctrl-names = "default";
> > +               pinctrl-0 = <&hp_det_l>;
> > +               simple-audio-card,format = "i2s";
> > +               simple-audio-card,name = "PineTab2";
> > +               simple-audio-card,mclk-fs = <256>;
> > +
> > +               simple-audio-card,widgets =
> > +                       "Microphone", "Mic Jack",
> > +                       "Headphone", "Headphones",
> > +                       "Microphone", "Microphone",
> > +                       "Speaker", "Speakers";
> > +
> > +               simple-audio-card,routing =
> > +                       "MICL", "Microphone",
> > +                       "MICR", "Mic Jack",
> > +                       "Headphones", "HPOL",
> > +                       "Headphones", "HPOR",
> > +                       "Speaker Amplifier INL", "HPOL",
> > +                       "Speaker Amplifier INR", "HPOR",
> > +                       "Speakers", "Speaker Amplifier OUTL",
> > +                       "Speakers", "Speaker Amplifier OUTR";
> > +
> > +               simple-audio-card,hp-det-gpio = <&gpio4 RK_PC6
> > GPIO_ACTIVE_HIGH>; +               simple-audio-card,aux-devs =
> > <&speaker_amp>;
> > +               simple-audio-card,pin-switches = "Speakers", "Microphone";
> > +
> > +               simple-audio-card,cpu {
> > +                       sound-dai = <&i2s1_8ch>;
> > +               };
> > +
> > +               simple-audio-card,codec {
> > +                       sound-dai = <&rk817>;
> > +               };
> > +       };
> 
> Not sure if it's right (or allowed) to post a different patch as attachment, 
> but I have been using a different audio configuration (see attachment).
> I haven't yet tried if/how it works via HDMI yet, but the speakers and 
> headphones work fine.
> This patch is based on the following commit:
> https://github.com/TuxThePenguin0/linux/commit/
> 872b829a3511cfa853bd3af3bd4f30be1cb3d1ab

Yes, this fixes the headphone detection. I cannot test HDMI because of a missing
cable.

I will pick the change in v2.

> I've added 'Danct12' to the To list as they are the maintainer of the primary 
> PT2 image and we worked together to get to this audio config.
> I don't if they still use it.
> (I've been using my own kernel/image for a while now).

Thanks. I just crossed this repo:
https://github.com/dreemurrs-embedded/linux-pinetab2/tree/v6.6.7-danctnix1

It includes some more improvements I will pick for v2.

Regards
Manuel

> From 17efeb0ae766886345ff0574c534079742539b56 Mon Sep 17 00:00:00 2001
> From: Scott Santucci <ScottFreeCode@users.noreply.github.com>
> Date: Mon, 17 Jul 2023 13:06:20 +0200
> Subject: [PATCH 3/8] arm64: dts: rk3566-pinetab2: Fix audio configuration
> 
> The audio configuration of the PineTab2 matches the `rk817_ext` alsa
> ucm2 profile, so switch the configuration to that. Use `rk817_ext` and
> not `rk817_int` as the PineTab2 uses an external amplifier.
> 
> Also the headphones plugged/unplugged detection is backwards, so apply
> the fix provided by Danct12 <danct12@disroot.org>.
> 
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> Link: https://github.com/dreemurrs-embedded/Pine64-Arch/pull/555
> ---
>  arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi b/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
> index a766f21bd6f8..59e4bf2f77c7 100644
> --- a/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
> +++ b/arch/arm64/boot/dts/rockchip/rk3566-pinetab2.dtsi
> @@ -116,14 +116,14 @@ rk817-sound {
>  		pinctrl-names = "default";
>  		pinctrl-0 = <&hp_det_l>;
>  		simple-audio-card,format = "i2s";
> -		simple-audio-card,name = "PineTab2";
> +		simple-audio-card,name = "rk817_ext";
>  		simple-audio-card,mclk-fs = <256>;
>  
>  		simple-audio-card,widgets =
>  			"Microphone", "Mic Jack",
>  			"Headphone", "Headphones",
>  			"Microphone", "Microphone",
> -			"Speaker", "Speakers";
> +			"Speaker", "Internal Speakers";
>  
>  		simple-audio-card,routing =
>  			"MICL", "Microphone",
> @@ -132,12 +132,12 @@ rk817-sound {
>  			"Headphones", "HPOR",
>  			"Speaker Amplifier INL", "HPOL",
>  			"Speaker Amplifier INR", "HPOR",
> -			"Speakers", "Speaker Amplifier OUTL",
> -			"Speakers", "Speaker Amplifier OUTR";
> +			"Internal Speakers", "Speaker Amplifier OUTL",
> +			"Internal Speakers", "Speaker Amplifier OUTR";
>  
> -		simple-audio-card,hp-det-gpio = <&gpio4 RK_PC6 GPIO_ACTIVE_HIGH>;
> +		simple-audio-card,hp-det-gpio = <&gpio4 RK_PC6 GPIO_ACTIVE_LOW>;
>  		simple-audio-card,aux-devs = <&speaker_amp>;
> -		simple-audio-card,pin-switches = "Speakers", "Microphone";
> +		simple-audio-card,pin-switches = "Internal Speakers", "Microphone";
>  
>  		simple-audio-card,cpu {
>  			sound-dai = <&i2s1_8ch>;
> -- 
> 2.42.0
> 




