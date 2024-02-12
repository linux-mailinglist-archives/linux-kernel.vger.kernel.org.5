Return-Path: <linux-kernel+bounces-61694-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF61851572
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:39:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D6491F21937
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A0143C068;
	Mon, 12 Feb 2024 13:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="vw0PaWBD"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB7473C063;
	Mon, 12 Feb 2024 13:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744574; cv=none; b=jjpY6GU5msKho7tRDv4/a7vhDLKGJvjsuB65Zh90BnCSmXQ2S2SxPOuHNuDj04G7GghWy0c9FruY1f4xpGAjDjhTHh77xCT9UD+gc29H1DngFB97CvnDDy3Y/l1cjfV20P1sPxYfLT3UUPEdYpmbjFp2nk6aMb0bKJXzHdA7+Z8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744574; c=relaxed/simple;
	bh=U2euNzWu3qoY7qsLi74++0YSoMrQP1238IGSIcTeH/M=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 MIME-Version:Content-Type; b=CY8r02xrSL/dQla7HWMTT8g0N8A2r0C0C7rbPtuuZ+dZqbv5fQoDUeoGI1kinJ+XNKF7wFXOzoZoqcueNw14nkrwtS1iLhgYaNOkogtei6/yDXbC/8pjUsoTGp6YT1YF6rvdsYREjUP0vOYTmFXSMRDPZ0CXUzBHPEnv/Jwn9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=vw0PaWBD; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4TYQKY3z40z9sbq;
	Mon, 12 Feb 2024 14:29:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1707744561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=6hQXyKsjxlQOVZTDodnZAiw/5mwBoEpdiKUN3Omtj/4=;
	b=vw0PaWBD/K1z9/h6KAOxQ33Wa+sXzXwyrc5m8vXDM0DDGmCre4J5jA4GBLZR7mbU47XTIw
	xmU4VNFK7vajv6HhNe0qeV/VYW0cU6ZN1A9ESzAdmrAYpNG+HsG2hJjuexkJHndxTiZ8dv
	mzAX4NgZ6Ii525xOHXFDG/DruyFc95+VHeP7H0dzGEwf9wouGAdcNWnWH0dGaQiYojmmdq
	fmObgubotgbVFOmnNChdzKiMWeCKQXiysg18nifA0/OUb4SJavwo6yv4uruXLn+nA6LQ86
	k0yfiWnHsdTs68XseNapwFnFCIHwAQc1oBBpyQjNVV+/n7yWOqFwVvR1nOmbOQ==
References: <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
 <20240205-pinephone-pll-fixes-v2-5-96a46a2d8c9b@oltmanns.dev>
 <poua4bzyciiwt65sqjf2whqfdumvoe4h3bkjpf64px2vwgumrf@sai73byg2iju>
 <87sf1zxb0s.fsf@oltmanns.dev>
From: Frank Oltmanns <frank@oltmanns.dev>
To: Maxime Ripard <mripard@kernel.org>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Guido
  =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>, Purism Kernel Team
 <kernel@puri.sm>, Ondrej
  Jirman <megi@xff.cz>, Neil Armstrong <neil.armstrong@linaro.org>, Jessica
  Zhang <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 5/6] drm/panel: st7703: Drive XBD599 panel at higher
 clock rate
In-reply-to: <87sf1zxb0s.fsf@oltmanns.dev>
Date: Mon, 12 Feb 2024 14:29:14 +0100
Message-ID: <87o7clyfo5.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain


On 2024-02-11 at 16:42:43 +0100, Frank Oltmanns <frank@oltmanns.dev> wrote:
> On 2024-02-08 at 20:05:08 +0100, Maxime Ripard <mripard@kernel.org> wrote:
>> [[PGP Signed Part:Undecided]]
>> Hi Frank,
>>
>> On Mon, Feb 05, 2024 at 04:22:28PM +0100, Frank Oltmanns wrote:
>>> This panel is used in the pinephone that runs on a Allwinner A64 SOC.
>>> The SOC requires pll-mipi to run at more than 500 MHz.
>>>
>>> This is the relevant clock tree:
>>>  pll-mipi
>>>     tcon0
>>>        tcon-data-clock
>>>
>>> tcon-data-clock has to run at 1/4 the DSI per-lane bit rate. The XBD599
>>> has 24 bpp and 4 lanes. Therefore, the resulting requested
>>> tcon-data-clock rate is:
>>>     crtc_clock * 1000 * (24 / 4) / 4
>>>
>>> tcon-data-clock runs at tcon0 / 4 (fixed divisor), so it requests a
>>> parent rate of
>>>     4 * (crtc_clock * 1000 * (24 / 4) / 4)
>>>
>>> Since tcon0 is a ccu_mux, the rate of tcon0 equals the rate of pll-mipi.
>>>
>>> pll-mipi's constraint to run at 500MHz or higher forces us to have a
>>> crtc_clock >= 83333 kHz if we want a 60 Hz vertical refresh rate.
>>>
>>> Change [hv]sync_(start|end) so that we reach a clock rate of 83502 kHz
>>> so that it is high enough to align with pll-pipi limits.
>>>
>>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>>
>> That commit log is great, but it's kind of off-topic. It's a panel
>> driver, it can be used on any MIPI-DSI controller, the only relevant
>> information there should be the panel timings required in the datasheet.
>>
>> The PLL setup is something for the MIPI-DSI driver to adjust, not for
>> the panel to care for.
>>
>
> I absolutely agree. It even was the reason for my submission of a
> sunxi-ng patch series last year that was accepted, to make pll-mipi more
> flexible. :)
>
> The only remaining option I currently see for adjusting the sunxi-ng
> driver to further accomodate the panel, is trying to use a higher
> divisor than 4 for calculating tcon-data-clock from tcon0. I remember
> reading a discussion about this, but as far as I remember that proposal
> was rejected (by you, IIRC).
>
> While I appreciate other suggestion as well, I'll look into options for
> using a different divisor than 4.

I tried the following:
--- a/drivers/gpu/drm/sun4i/sun4i_tcon.c
+++ b/drivers/gpu/drm/sun4i/sun4i_tcon.c
@@ -391,7 +391,7 @@ static void sun4i_tcon0_mode_set_cpu(struct sun4i_tcon *tcon,
         * dclk is required to run at 1/4 the DSI per-lane bit rate.
         */
        tcon->dclk_min_div = SUN6I_DSI_TCON_DIV;
-       tcon->dclk_max_div = SUN6I_DSI_TCON_DIV;
+       tcon->dclk_max_div = 127;
        clk_set_rate(tcon->dclk, mode->crtc_clock * 1000 * (bpp / lanes)
                                                  / SUN6I_DSI_TCON_DIV);

On the pinephone, this selects a divisor of 6 resulting in a 25% frame
drop. I.e., unless I'm missing something using a divisor other than 4 is
not an option. This also matches your report from 2019: "Well, it's also
breaking another panel." [1]

I can currently see the following options:

a. Drive PLL-MIPI outside spec and panel within spec (current situation,
   but missing a small patch [2] that fixes the crtc_clock and nothing
   else) and live with the fact that some pinephones will run
   unreliably.

b. Drive PLL-MIPI and panel within spec and shove data into the panel at
   a too high rate (i.e., apply the rest of this series but not this
   specific patch). This seems to mostly work, but hasn't seen any long
   term testing. Short term testing showed that this approach results in
   a slight but noticable unsmooth scrolling behavior.

c. Drive PLL-MIPI within spec and panel outside spec (i.e., apply a
   future version of the whole series). This has been tested for over a
   month on three devices that I know of. There are no reports of panels
   not working with the suggested parameters.

All options require additional work on the GPU rate which is currently
being discussed in a parallel thread of this series. Unless somebody
comes up with a better idea, I will pause working on fixing PLL-MIPI and
focus on the GPU instead. While I doubt it, maybe fixing the GPU is
sufficient and continuing to drive PLL-MIPI outside spec proves to be
ok.

[1]: https://lore.kernel.org/all/20190828130341.s5z76wejulwdgxlc@flea/
[2]: https://lore.kernel.org/all/20230219114553.288057-2-frank@oltmanns.dev/

Best regards,
  Frank

>
> Best regards,
>   Frank
>
>>
>> Maxime
>>
>> [[End of PGP Signed Part]]

