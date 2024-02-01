Return-Path: <linux-kernel+bounces-47502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6926D844EB8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 02:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 147491F2CCED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 01:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A10304C67;
	Thu,  1 Feb 2024 01:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b="WEZg7y7e"
Received: from a.peacevolution.org (a.peacevolution.org [206.189.193.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71DD64403;
	Thu,  1 Feb 2024 01:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=206.189.193.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706751412; cv=none; b=PYOtAEML6uWjoLvYI5syKGFfSVdpU5nAHDc6Xv1Al2hVk9pN/7FzslAp0CtJwLn2yEfoMFSc+8UGV4QOmsv3lBagmK+RzdHDAwpYuDpEsG6LtTVo21lZtpjaiSm+sSw1EXVXPYj1sYVUtMiBUxkDk7gCMSV8xScmyEUM4tNKvu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706751412; c=relaxed/simple;
	bh=FNd+cBC8I6vC/ro/gYb55xZFXFPkiMNYkcnk7OWZ0Ec=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=A+U9K2KXdxn8UvYk6XgOrbtFOImhu5hlV1r9Ro5Rz9nJ2u3ccUkCX/mUQnV4jC23OxDtYereLfmBo83Relp72HuIB+ZPswjYj+onr7kID/ZvfGEozODMh/JSUGlBfhcyZarXkadoj+p5MpGAe+OJDH1wiBdoFPV0ALqnmBG6UxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org; spf=pass smtp.mailfrom=peacevolution.org; dkim=pass (1024-bit key) header.d=peacevolution.org header.i=@peacevolution.org header.b=WEZg7y7e; arc=none smtp.client-ip=206.189.193.133
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=peacevolution.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=peacevolution.org
Received: from authenticated-user (PRIMARY_HOSTNAME [PUBLIC_IP])
	by a.peacevolution.org (Postfix) with ESMTPA id 7930B4661F;
	Thu,  1 Feb 2024 01:36:48 +0000 (UTC)
Date: Wed, 31 Jan 2024 20:36:46 -0500
From: Aren <aren@peacevolution.org>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: linux-kernel@vger.kernel.org, Miles Alan <m@milesalan.com>, 
	Ondrej Jirman <megi@xff.cz>, Chen-Yu Tsai <wens@csie.org>, Conor Dooley <conor+dt@kernel.org>, 
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, Rob Herring <robh+dt@kernel.org>, 
	Samuel Holland <samuel@sholland.org>, devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 2/4] arm64: dts: sun50i-a64-pinephone: Retain leds state
 in suspend
Message-ID: <sbcg74hktwv5x7hookeb4su27xut7swarl3d5mbs3i5cqxtq4g@4evugu43ctiv>
References: <20240128204740.2355092-1-aren@peacevolution.org>
 <20240128204740.2355092-2-aren@peacevolution.org>
 <4892315.31r3eYUQgx@jernej-laptop>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4892315.31r3eYUQgx@jernej-laptop>
X-Spamd-Bar: /
Authentication-Results: auth=pass smtp.auth=aren@peacevolution.org smtp.mailfrom=aren@peacevolution.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=peacevolution.org;
	s=dkim; t=1706751409;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:content-transfer-encoding:in-reply-to:references;
	bh=YSppDkR8PnytdKdGLPZ10vxgzIiHiNL8+3cRAaam16Q=;
	b=WEZg7y7ewDgh4/WmhTmPmLBuwIm+JJMAW4goBLZJzr4/eyOtc9w3/CDsyBKt8Y4p0Fn9sf
	OnVp10PhOJrthHM65fbrEDxKHQ8PdlQUBDoxSPtlMMD1GU5DNOKMWpi79KKtYuPwZCNKvJ
	fdBy61LU8P7x2X7CPZVKgZn5JS1dptw=

On Tue, Jan 30, 2024 at 08:06:24PM +0100, Jernej Škrabec wrote:
> Dne nedelja, 28. januar 2024 ob 21:45:08 CET je Aren Moynihan napisal(a):
> > From: Miles Alan <m@milesalan.com>
> > 
> > Allows user to set a led before entering suspend to know that
> > the phone is still on (or could be used for notifications etc.)
> > 
> > Signed-off-by: Miles Alan <m@milesalan.com>
> > Signed-off-by: Ondrej Jirman <megi@xff.cz>
> > Signed-off-by: Aren Moynihan <aren@peacevolution.org>
> 
> Where is patch 1 and possibly cover letter? Please resend with all patches.

Oops, sorry about that, I'm still getting used to get_maintainer.pl.
I'll resend this properly when I have time this weekend, until then the
patch you missed is available at
https://lore.kernel.org/lkml/20240128204740.2355092-1-aren@peacevolution.org/

> However, this particular patch is:
> Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Thanks
 - Aren

> Best regards,
> Jernej
> 
> > ---
> > 
> >  arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi | 3 +++
> >  1 file changed, 3 insertions(+)
> > 
> > diff --git a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > index 87847116ab6d..ad2476ee01e4 100644
> > --- a/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > +++ b/arch/arm64/boot/dts/allwinner/sun50i-a64-pinephone.dtsi
> > @@ -43,18 +43,21 @@ led-0 {
> >  			function = LED_FUNCTION_INDICATOR;
> >  			color = <LED_COLOR_ID_BLUE>;
> >  			gpios = <&pio 3 20 GPIO_ACTIVE_HIGH>; /* PD20 */
> > +			retain-state-suspended;
> >  		};
> >  
> >  		led-1 {
> >  			function = LED_FUNCTION_INDICATOR;
> >  			color = <LED_COLOR_ID_GREEN>;
> >  			gpios = <&pio 3 18 GPIO_ACTIVE_HIGH>; /* PD18 */
> > +			retain-state-suspended;
> >  		};
> >  
> >  		led-2 {
> >  			function = LED_FUNCTION_INDICATOR;
> >  			color = <LED_COLOR_ID_RED>;
> >  			gpios = <&pio 3 19 GPIO_ACTIVE_HIGH>; /* PD19 */
> > +			retain-state-suspended;
> >  		};
> >  	};
> >  
> > 
> 
> 
> 
> 

