Return-Path: <linux-kernel+bounces-78731-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A53E78617ED
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 17:30:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 378A8286788
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 16:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 133031643E;
	Fri, 23 Feb 2024 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="frWGOL/5"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BFCD8526C;
	Fri, 23 Feb 2024 16:30:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708705807; cv=none; b=EZ8YBBIQ/Ap55reIlnvWS0RhXm5PaQjWigXiuh0Dq4y86f7YyLOjgKiAscKKlFAYW3ehoGmi6uZvUDJmG/mkiP+ULY3Vq7PPdVw19m5KXKzt6ZhvP4Ip/OaaotMHKM8Z26V1a0qEosDYsJ+m/a3ruv96mp9BhiCwOE0uws+b9Bg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708705807; c=relaxed/simple;
	bh=2gqITLPm+T8DVTKA8perP2UfzFrxKTvGsvyzXlsKDGQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lUXTspJy96az4Fuw5P88MPPYJQFewfmqqy4qT3C32HT2NnOtqwDz+Zpl0Az7RRyJd70glX19T7NO+460uNI/VNRLrMKhsoavGuyDsaCcP2dfFRPUis631IV2S2Kex3Ot1cYVvH71BTczvyWHwWYK0N7M48+vRLDWcEuHq+DE+6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=frWGOL/5; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 21840474E7;
	Fri, 23 Feb 2024 16:30:03 +0000 (UTC)
Date: Fri, 23 Feb 2024 11:30:00 -0500
From: Aren <aren@peacevolution.org>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: linux-kernel@vger.kernel.org, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org, 
	Jean-Jacques Hiblot <jjhiblot@traphandler.com>, Chen-Yu Tsai <wens@csie.org>, Ondrej Jirman <megi@xff.cz>, 
	linux-sunxi@lists.linux.dev, Lee Jones <lee@kernel.org>, Pavel Machek <pavel@ucw.cz>, 
	linux-arm-kernel@lists.infradead.org, linux-leds@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	Miles Alan <m@milesalan.com>, Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2 4/4] arm64: dts: sun50i-a64-pinephone: change led type
 to status
Message-ID: <n5rmhx7ez7xoqainjqxpdk47e3bw2pvtsgswofnhjdxtrk72j2@debhbdxsxz4m>
References: <20240206185400.596979-1-aren@peacevolution.org>
 <20240206185400.596979-4-aren@peacevolution.org>
 <2792937.BEx9A2HvPv@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2792937.BEx9A2HvPv@jernej-laptop>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1708705804;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
	bh=QL3hXVllNtOOAwow+Eh+WDBYhGp8kPau81uRs9JQuQ0=;
	b=frWGOL/5zk7t+eicPItDNp9ruemVvjx5/5RdP57IR6WLy1vXCdnC42bIuDIbFJ5iK2ZJvt
	kSDgEvSNG1wEltNiI8sRmKyePbelj+Fmirhz+35GU34mTmvzNaJ9EfMTwdDcxiIo23I7xf
	ccuTnTWWCs+/j+X85vPL7uEf8W/p7Wo=

On Thu, Feb 22, 2024 at 09:57:00PM +0100, Jernej Škrabec wrote:
> Dne torek, 06. februar 2024 ob 19:13:20 CET je Aren Moynihan napisal(a):
> > The status function is described in the documentation as being a rgb led
> > used for system notifications on phones[1][2]. This is exactly what this
> > led is used for on the PinePhone, so using status is probably more
> > accurate than indicator.
> > 
> > 1: Documentation/leds/well-known-leds.txt
> > 2: include/dt-bindings/leds/common.h
> > 
> > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> 
> Sorry for late review.
> 
> Please update subject in patches 2-3. Instead of "sun50i-a64-pinephone:"
> use "allwinner: pinephone:" (check commit history of sun50i-a64-pinephone.dtsi).
> Also rgb -> RGB, led -> LED. Last, please reword commit message to exclude
> links and just say DT bindings documentation.
> 
> Note that I'll merge patches 2-3 once patch 1 is merged.

Would you like me to reword and resend the patches, or is it quicker
for you to just do it when you apply them?

Thanks for taking a look at this,
 - Aren

> Best regards,
> Jernej
> 
> > ---
> > I can't find any documentation describing the indicator function, so
> > it's definitely less specific than status, but besides that I'm not sure
> > how it compares. Please ignore this patch if it's not useful.
> > 
> > (no changes since v1)
> > 
> >  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > index e53e0d4579a7..6d327266e6cc 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > @@ -61,7 +61,7 @@ led2: led-2 {
> >  	multi-led {
> >  		compatible = "leds-group-multicolor";
> >  		color = <LED_COLOR_ID_RGB>;
> > -		function = LED_FUNCTION_INDICATOR;
> > +		function = LED_FUNCTION_STATUS;
> >  		leds = <&led0>, <&led1>, <&led2>;
> >  	};
> >  
> > 
> 
> 
> 
> 

