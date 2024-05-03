Return-Path: <linux-kernel+bounces-167560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE1948BAB52
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 13:03:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1D0091C215AD
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 11:03:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C39CC7E766;
	Fri,  3 May 2024 11:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b="cXzNY9OP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QPMoH4cp"
Received: from fhigh1-smtp.messagingengine.com (fhigh1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C155433DD;
	Fri,  3 May 2024 11:02:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714734178; cv=none; b=MK9mHg3pJiLYcVZQ2LFEyXgK3LG9WrsFARYBTSHZxXxSYUpvORp+8r+cMnJ8OcdaxxuRapCPCxppAilto61Ppjku4Iw357IzRSI1I0reSWEuh9cMObq5sCyc7Scvs0DowO8JJl8L9U1MuXWfTKKNT0sM8g18mMD9c0oMevpEH1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714734178; c=relaxed/simple;
	bh=TsCFM63eKP42FnJYo/uWySHDpmwB7xakh15jSMvBbwg=;
	h=MIME-Version:Message-Id:In-Reply-To:References:Date:From:To:Cc:
	 Subject:Content-Type; b=Lk3ScCTMOz6d2oQqF/ec6ym3u7nEyrMKFaaQwJW9/0frYkLHC/KP7CSOXHwm1pNvaYT8VO+8APPnxe65wDE+iaFhwu4biIMm2m+dVQdZW4LCe9jdSdal5OBvvW1XP1ZVBbUqDIjpP8uWWmgo1R1iQHz4YZWmbzyP/xDPjSDqhL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com; spf=pass smtp.mailfrom=testtoast.com; dkim=pass (2048-bit key) header.d=testtoast.com header.i=@testtoast.com header.b=cXzNY9OP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QPMoH4cp; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=testtoast.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=testtoast.com
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailfhigh.nyi.internal (Postfix) with ESMTP id 998251140083;
	Fri,  3 May 2024 07:02:55 -0400 (EDT)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Fri, 03 May 2024 07:02:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=testtoast.com;
	 h=cc:cc:content-type:content-type:date:date:from:from
	:in-reply-to:in-reply-to:message-id:mime-version:references
	:reply-to:subject:subject:to:to; s=fm3; t=1714734175; x=
	1714820575; bh=gsI9WknztWe0nMLhlyAgKSwHPdRaeFquYlqHeApfjKg=; b=c
	XzNY9OPH4GZ08nNTofj+WQHBq8XZf/vidh9Lcyjv6Moklj2VUD956rwtTyVwT2QM
	43LUM0o5n8dMH+0OGTC1M1iR72sw6VcCcqsfkPB1CdE3OCOQ13OCI56QKAX7VRwW
	J5MUEm6RXqQZjt/u/JzKE9CWO5BgX6GtEc3z4BZC6nAuKGUNDGho1SfnO79uvkBu
	1C4eiD3S1eQizWjpTj0J+V9/X6idNZ2PCL9UVzifF6Jvi3+gntJS8LqgD1HD8mH9
	FEGL/CeqgqRnsH/CaVBWaXw0N3Gji4Yhdc5kzEWngVgfmb/hXCAO66q46rb5vchD
	l0CVGc0WvyKetHXQfPiFA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm3; t=1714734175; x=1714820575; bh=gsI9WknztWe0nMLhlyAgKSwHPdRa
	eFquYlqHeApfjKg=; b=QPMoH4cpoE06V4hyx7atf5DkCoR4r2UaomQ3G7W08i1j
	RJxM0lC+ULy1LuBHfuNmuzf/o45xyH8aKyhytKbX1wTZM49CDt5nmdiJCf7Nrsri
	0XaNjSPZ7uTvXKAepAjhyaZOnw5GaPeA4XDTdRFa12qS470fYrdl5gpve/FyWQmy
	qbTjOqgEYFNGeSegx9SxPLygMzWBYrEFtNeuzoYtZZcLhirRKD0DOsQVZtc/aAkr
	TyNpDB3um65kRy8g0be/Og4hMvbh1BBcUzDOds0+uaSMR+V2Qn1ra38zFKDrOzV0
	E+TTpbg8ykWRTDHIu/qtsP9yFaA+UIdoJ0OrMpowew==
X-ME-Sender: <xms:XsQ0ZuZLnJBcqY6B2CULfdE-G65RgmjBvX95gXs93c1PGQNLOdDxCQ>
    <xme:XsQ0ZhYRu7KE9rZw2hbZnHQao6d-oseE3nTWCXIWZOnDjreKcW38I8yXpUHZ8zJj7
    Rr4LXPl-FZnb4S1mA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvledrvddvtddgfeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftfih
    rghnucghrghlkhhlihhnfdcuoehrhigrnhesthgvshhtthhorghsthdrtghomheqnecugg
    ftrfgrthhtvghrnhephedvveeigedujeeufeegffehhfffveduhfeijefgtdffteelgfet
    ueevieduieejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homheprhihrghnsehtvghsthhtohgrshhtrdgtohhm
X-ME-Proxy: <xmx:XsQ0Zo9iqPZYKlTVS_9ljU5U9Oi84L971tms_SZQYEHrnOZcXr9g6g>
    <xmx:XsQ0Zgrd9XC4CeLrivabeZ90YIBnhU-dq5RrAasPQZmlBFtoMNKqHA>
    <xmx:XsQ0ZprdwaoFi0MP5DwQq5ZBZtFkOhj5n5JE6ZaiIHgd7QT3K87EwQ>
    <xmx:XsQ0ZuRSgjgmvEt9o-FG-b6L_jjmucGCl1MtbfycD8HCg92EMupM6g>
    <xmx:X8Q0ZtcMAXJsLLvI-4Pbk-LQ63UnSRpzZx35A9I__qkBjSz_1mw35tR3>
Feedback-ID: idc0145fc:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
	id C13CBA60078; Fri,  3 May 2024 07:02:54 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.11.0-alpha0-417-gddc99d37d-fm-hotfix-20240424.001-g2c179674
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-Id: <fde9c98a-e14d-4c03-91ab-0cdc209a1763@app.fastmail.com>
In-Reply-To: <20240502180736.7330-1-a.fertl@t-online.de>
References: <20240502180736.7330-1-a.fertl@t-online.de>
Date: Fri, 03 May 2024 23:02:13 +1200
From: "Ryan Walklin" <ryan@testtoast.com>
To: "Alois Fertl" <a.fertl@t-online.de>, a.zummo@towertech.it
Cc: alexandre.belloni@bootlin.com, "Chen-Yu Tsai" <wens@csie.org>,
 "Jernej Skrabec" <jernej.skrabec@gmail.com>,
 "Samuel Holland" <samuel@sholland.org>, linux-rtc@vger.kernel.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/1] drivers/rtc: rtc-sun6i: AutoCal Internal OSC Clock
Content-Type: text/plain

Hi Alois,

On Fri, 3 May 2024, at 6:07 AM, Alois Fertl wrote:
> I have a M98-8K PLUS Magcubic TV-Box based on the Allwinner H618 SOC.
> On board is a Sp6330 wifi/bt module that requires a 32kHz clock to
> operate correctly. Without this change the clock from the SOC is
> ~29kHz and BT module does not start up. The patch enables the Internal
> OSC Clock Auto Calibration of the H616/H618 which than provides the
> necessary 32kHz and the BT module initializes successfully.
> Add a flag and set it for H6 AND H616. The H618 is the same as H616
> regarding rtc.
>
> Signed-off-by: Alois Fertl <a.fertl@t-online.de>
> ---
>
> v1->v2
> - add flag and activate for H6 AND H616
>
> v2->v3
> - correct findings from review
>
> I was hoping to get some feedback regarding the situation on H6,
> where an external 32k crystal can be present.
> From what I understand from the H6 manual there should be no
> conflict as one can select which souce will drive the output.
> Should certainly be tested but I don`t have H6 hardware.
>
>  drivers/rtc/rtc-sun6i.c | 17 ++++++++++++++++-
>
>  1 file changed, 16 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
> index e0b85a0d5645..20e81ccdef29 100644
> --- a/drivers/rtc/rtc-sun6i.c
> +++ b/drivers/rtc/rtc-sun6i.c
> @@ -42,6 +42,11 @@
> 
>  #define SUN6I_LOSC_CLK_PRESCAL			0x0008
> 
> +#define SUN6I_LOSC_CLK_AUTO_CAL			0x000c
> +#define SUN6I_LOSC_CLK_AUTO_CAL_16MS		BIT(2)
> +#define SUN6I_LOSC_CLK_AUTO_CAL_ENABLE		BIT(1)
> +#define SUN6I_LOSC_CLK_AUTO_CAL_SEL_CAL		BIT(0)
> +
>  /* RTC */
>  #define SUN6I_RTC_YMD				0x0010
>  #define SUN6I_RTC_HMS				0x0014
> @@ -126,7 +131,6 @@
>   *     registers (R40, H6)
>   *   - SYS power domain controls (R40)
>   *   - DCXO controls (H6)
> - *   - RC oscillator calibration (H6)
>   *
>   * These functions are not covered by this driver.
>   */
> @@ -138,6 +142,7 @@ struct sun6i_rtc_clk_data {
>  	unsigned int has_losc_en : 1;
>  	unsigned int has_auto_swt : 1;
>  	unsigned int no_ext_losc : 1;
> +	unsigned int has_auto_cal : 1;
>  };
> 
>  #define RTC_LINEAR_DAY	BIT(0)
> @@ -268,6 +273,14 @@ static void __init sun6i_rtc_clk_init(struct 
> device_node *node,
>  	}
>  	writel(reg, rtc->base + SUN6I_LOSC_CTRL);
> 
> +	if (rtc->data->has_auto_cal) {
> +		/* Enable internal OSC clock auto calibration */
> +		reg = SUN6I_LOSC_CLK_AUTO_CAL_16MS |
> +			SUN6I_LOSC_CLK_AUTO_CAL_ENABLE |
> +			SUN6I_LOSC_CLK_AUTO_CAL_SEL_CAL;
> +		writel(reg, rtc->base + SUN6I_LOSC_CLK_AUTO_CAL);
> +	}
> +
>  	/* Yes, I know, this is ugly. */
>  	sun6i_rtc = rtc;
> 
> @@ -380,6 +393,7 @@ static const struct sun6i_rtc_clk_data 
> sun50i_h6_rtc_data = {
>  	.has_out_clk = 1,
>  	.has_losc_en = 1,
>  	.has_auto_swt = 1,
> +	.has_auto_cal = 1,
>  };
> 
>  static void __init sun50i_h6_rtc_clk_init(struct device_node *node)

I tried to test this with my H700 board but this struct is not actually in any mainline kernel and looks like it is from an earlier version of the H616 RTC changes which was never actually merged? Talked to Andre on IRC and he thinks the H6 and H616 RTC clocks *should* be equivalent.

> @@ -395,6 +409,7 @@ static const struct sun6i_rtc_clk_data 
> sun50i_h616_rtc_data = {
>  	.has_prescaler = 1,
>  	.has_out_clk = 1,
>  	.no_ext_losc = 1,
> +	.has_auto_cal = 1,
>  };
> 
>  static void __init sun50i_h616_rtc_clk_init(struct device_node *node)
> -- 
> 2.39.2

Regards,

Ryan

