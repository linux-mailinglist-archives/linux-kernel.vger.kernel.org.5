Return-Path: <linux-kernel+bounces-77944-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E634860D22
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 09:46:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A6F11F29504
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4E719474;
	Fri, 23 Feb 2024 08:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b="tYDKGXyT"
Received: from vps.xff.cz (vps.xff.cz [195.181.215.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BF618E1E;
	Fri, 23 Feb 2024 08:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.181.215.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708677990; cv=none; b=FaISb6QcpKcFTTwF6ZX5w6M6DOkWKKdeUo6zC0XpxEBqq6arBhD3OZW0sWOuZh1RO15G1cHCmg8YZMkcnMFdSmJLZEc8lAUVdbswY4tHA3oOWq24ckXBrJ0mHujWgmwfkLwbTEYq2nSxxWYdp9/9pxKceU3qt/K8EL7/SezcHGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708677990; c=relaxed/simple;
	bh=EZZPQchlQbMRgMLdaZSVRfWs5DMx2XOakjV6Hz3uCjc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u6OUgxfN3J5gF/LyvAacZ4JoQLif2LdTxzPzKVVvgDXFbDG9mYHyT2LHItRGOtHtcVV5FC0IpsdazK9ilHuR5BmDai+pPGfIiOhINZ2ADJzZkHZpAnWhGN3mqdisTSkw6anfSbEO5pDELO8HBV5qHP8sUJ+RAEBlHrtbN4jleqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz; spf=pass smtp.mailfrom=xff.cz; dkim=pass (1024-bit key) header.d=xff.cz header.i=@xff.cz header.b=tYDKGXyT; arc=none smtp.client-ip=195.181.215.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xff.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xff.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xff.cz; s=mail;
	t=1708677986; bh=EZZPQchlQbMRgMLdaZSVRfWs5DMx2XOakjV6Hz3uCjc=;
	h=Date:From:To:Cc:Subject:X-My-GPG-KeyId:References:From;
	b=tYDKGXyTUFx45Cfn4MxTIQ4wjmFHD/P+5LQ8Tv8lWgD9lkdtT3FOkBhEEyWWts15p
	 NdK0gVmh6eiX1XcL39WrYugf7CrmeaVPEU3mcpfmHMTbimF+jrF2xM5GtbVsDSDBHq
	 a3IKS0Xu+eifTUatSjo6DXYkh12/fb+JEgtO842c=
Date: Fri, 23 Feb 2024 09:46:25 +0100
From: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>
To: Aren Moynihan <aren@peacevolution.org>
Cc: linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	linux-arm-kernel@lists.infradead.org, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	linux-leds@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Miles Alan <m@milesalan.com>, 
	Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 3/4] arm64: dts: sun50i-a64-pinephone: add multicolor
 led node
Message-ID: <sixgkkllo7medcjwjnmbkpqkgfvnmrtlhlwarwuxid5oqwrht5@gl65b6fetq2b>
Mail-Followup-To: =?utf-8?Q?Ond=C5=99ej?= Jirman <megi@xff.cz>, 
	Aren Moynihan <aren@peacevolution.org>, linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Chen-Yu Tsai <wens@csie.org>, linux-sunxi@lists.linux.dev, 
	Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	linux-arm-kernel@lists.infradead.org, Jernej Skrabec <jernej.skrabec@gmail.com>, 
	linux-leds@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, Miles Alan <m@milesalan.com>, 
	Samuel Holland <samuel@sholland.org>
X-My-GPG-KeyId: EBFBDDE11FB918D44D1F56C1F9F0A873BE9777ED
 <https://xff.cz/key.txt>
References: <20240206185400.596979-1-aren@peacevolution.org>
 <20240206185400.596979-3-aren@peacevolution.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240206185400.596979-3-aren@peacevolution.org>

Hello Aren,

On Tue, Feb 06, 2024 at 01:13:19PM -0500, Aren Moynihan wrote:
> The red, green, and blue leds currently in the device tree represent a
> single rgb led on the front of the PinePhone.
> 
> Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> ---
> 
> Changes in v2:
>  - remove function property from individual led nodes
> 
>  .../boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 16 ++++++++++------
>  1 file changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> index ad2476ee01e4..e53e0d4579a7 100644
> --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> @@ -39,28 +39,32 @@ chosen {
>  	leds {
>  		compatible = "gpio-leds";
>  
> -		led-0 {
> -			function = LED_FUNCTION_INDICATOR;

This looks like a needless change that will just break people's current scripts
and setup. It does mine, and there sure are others that will be surprised, too.

This leads to a change in sysfs path from:

  /sys/class/leds/blue:indicator

to

  /sys/class/leds/blue:

which is 1) a weird name and 2) a backwards compatibility break for seemingly
no apparent reason. Any reaons for the change?

People normally hardcode these paths in eg. /etc/tmpfiles.d to apply LED triggers
to particular LEDs.

Kind regards,
	o.

> +		led0: led-0 {
>  			color = <LED_COLOR_ID_BLUE>;
>  			gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
>  			retain-state-suspended;
>  		};
>  
> -		led-1 {
> -			function = LED_FUNCTION_INDICATOR;
> +		led1: led-1 {
>  			color = <LED_COLOR_ID_GREEN>;
>  			gpios = <&pio 3 18 GPIO_ACTIVE_HIGH>; /* PD18 */
>  			retain-state-suspended;
>  		};
>  
> -		led-2 {
> -			function = LED_FUNCTION_INDICATOR;
> +		led2: led-2 {
>  			color = <LED_COLOR_ID_RED>;
>  			gpios = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
>  			retain-state-suspended;
>  		};
>  	};
>  
> +	multi-led {
> +		compatible = "leds-group-multicolor";
> +		color = <LED_COLOR_ID_RGB>;
> +		function = LED_FUNCTION_INDICATOR;
> +		leds = <&led0>, <&led1>, <&led2>;
> +	};
> +
>  	reg_ps: ps-regulator {
>  		compatible = "regulator-fixed";
>  		regulator-name = "ps";
> -- 
> 2.43.0
> 

