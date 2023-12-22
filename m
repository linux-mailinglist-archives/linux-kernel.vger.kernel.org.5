Return-Path: <linux-kernel+bounces-9534-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7148781C72B
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 10:10:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 94B2B1C2223E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 09:10:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61539FBE2;
	Fri, 22 Dec 2023 09:10:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="DlBuv078"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70B72FBF3;
	Fri, 22 Dec 2023 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4SxM2v34f7z9t0p;
	Fri, 22 Dec 2023 10:10:31 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1703236231;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ALCq2oz1QBxbdllKqhnSviXLc3yIJ0Q6F604tnrSPGU=;
	b=DlBuv078ks+xCfMpS4YGEbAyftvJU5MWD2zYGJdt1rHSSvsseWjGZqyfyxz0qMzIFp7XkN
	7MUU2ro5XMNQ5MAuN0wsL9qKgfenY7+JteMwB1gARN4sL1QcF25u0jNkdTR2rusDYOrx7V
	4DiqEBOgeMLLMjDD1HtfCL8oH630b7js43llHq/bjuPfBZ3bPDtQnX3IYJrTdho3VgMt00
	jm3bD/cBQDxQ535aP2tAa6O+IFRr1yH/0XxcnXriJDRhO9rgok3pP+g4ADBfS+QLXeAaTQ
	M5HPc3RKaCxOwl15RFYLsyJzyP/frT+oRbRYFGVpzW2MvJ+H9DliTCFFbSVf2w==
References: <20231218-pinephone-pll-fixes-v1-0-e238b6ed6dc1@oltmanns.dev>
 <10386431.nUPlyArG6x@jernej-laptop> <87edfh9ud8.fsf@oltmanns.dev>
 <1845418.atdPhlSkOF@jernej-laptop> <875y0sacmz.fsf@oltmanns.dev>
From: Frank Oltmanns <frank@oltmanns.dev>
To: Frank Oltmanns <frank@oltmanns.dev>
Cc: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>, Michael
 Turquette
 <mturquette@baylibre.com>, Stephen Boyd <sboyd@kernel.org>, Chen-Yu Tsai
 <wens@csie.org>, Samuel Holland <samuel@sholland.org>, Guido =?utf-8?Q?G?=
 =?utf-8?Q?=C3=BCnther?=
 <agx@sigxcpu.org>, Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman
 <megi@xff.cz>, Neil Armstrong <neil.armstrong@linaro.org>, Jessica Zhang
 <quic_jesszhan@quicinc.com>, Sam Ravnborg <sam@ravnborg.org>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David
 Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 5/5] drm/panel: st7703: Drive XBD599 panel at higher
 clock rate
In-reply-to: <875y0sacmz.fsf@oltmanns.dev>
Date: Fri, 22 Dec 2023 10:10:25 +0100
Message-ID: <87v88qk3ge.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 2023-12-20 at 19:57:06 +0100, Frank Oltmanns <frank@oltmanns.dev> wrote:
> Ok, I've done more detailed testing, and it seems this patch results in
> lots of dropped frames. I'm sorry for not being more thorough earlier.
> I'll do some more testing without this patch and might have to either
> remove it from V2 of this series.
>
> I need to see if the same stability can be achieved when running
> PLL-MIPI outside its specied range.

I've done some more (load) testing and observing the panel for dropped
frames.

The conclusion I draw from those results is that this patch isn't
necessary for the pinephone. It would be enough to use the correct clock
rate based on the existing values [*]:
-	.clock	     =3D 69000,
+	.clock	     =3D (720 + 40 + 40 + 40) * (1440 + 18 + 10 + 17) * 60 / 1000,

I've asked in the postmarketOS community for a bit more testing. They
already have a merge request that contains these changes [2].

This means that we would continue to drive PLL-MIPI outside it's
specified range. I have, so far, not experienced any downside of doing
so. It seems enough to fix the ratios that are part of the first four
patches in this series without introducing a min and max rate.

In conclusion, I'll soon (after some more feedback from the fine folks
at postmarketOS) submit a V2 that addresses the fixes requested in the
first four patches of this series. I'll drop the existing PATCH 5 and
replace it with the one I sent in February [1] instead.

After that, just for fun, I'll probably look into min_rate and max_rate
for nkm clocks and which consequences it has on the pinephone. I might
or might not send a follow up series for that. However, if the pinephone
runs stable without it, it's not a high priority for me.

Best regards,
  Frank

[*] I've already submitted a patch in February '23 [1]. It was of little
    use back then because the A64's PLL-MIPI clock was not able to run
    close to that rate. But since kernel 6.6 PLL-MIPI is able to set
    it's parent rate, so that it can come quite close to the required
    rate:
     + Panel requires 74.844 MHz with the current timings.
     +-> tcon-data-clock rate should be 112.266 MHz (panel*24/4/4).
      +-> PLL-MIPI rate should be 449.064 MHz (TCON0 * 4)

    The 6.6 kernel the following rates are possible:
     + PLL-MIPI: ~448.984615 MHz
     +-> tcon-data-clock: ~112.246153
      +-> panel: ~74.830768 MHz

    Which leaves us with a vertical refresh rate of ~59.989 Hz,
    deviating less then 0.2% from the ideal 60Hz. That's probably closer
    than the accumulated accuracy of all involved components can
    reliably achieve. I'd say, let's leave it at that.

[1]: https://lore.kernel.org/lkml/20230219114553.288057-2-frank@oltmanns.de=
v/
[2]: https://gitlab.com/postmarketOS/pmaports/-/merge_requests/4645
>
> Best regards,
>   Frank
>
> On 2023-12-20 at 16:18:49 +0100, Jernej =C5=A0krabec <jernej.skrabec@gmai=
l.com> wrote:
>> Dne sreda, 20. december 2023 ob 08:14:27 CET je Frank Oltmanns napisal(a=
):
>>>
>>> On 2023-12-19 at 18:04:29 +0100, Jernej =C5=A0krabec <jernej.skrabec@gm=
ail.com> wrote:
>>> > Dne ponedeljek, 18. december 2023 ob 14:35:23 CET je Frank Oltmanns n=
apisal(a):
>>> >> This panel is used in the pinephone that runs on a Allwinner A64 SOC.
>>> >> Acoording to it's datasheet, the SOC requires PLL-MIPI to run at more
>>> >> than 500 MHz.
>>> >>
>>> >> Therefore, change [hv]sync_(start|end) so that we reach a clock rate
>>> >> that is high enough to drive PLL-MIPI within its limits.
>>> >>
>>> >> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>>> >
>>> > I'm not too sure about this patch. I see that PLL_MIPI doesn't have s=
et
>>> > minimum frequency limit in clock driver. If you add it, clock framewo=
rk
>>> > should find rate that is high enough and divisible with target rate.
>>>
>>> This one is really a tough nut. Unfortunately, the PLL_MIPI clock for
>>> this panel has to run exactly at 6 * panel clock. Let me start by
>>> showing the relevant part of the clock tree (this is on the pinephone
>>> after applying the patches):
>>>     pll-video0                 393600000
>>>        pll-mipi                500945454
>>>           tcon0                500945454
>>>              tcon-data-clock   125236363
>>>
>>> To elaborate, tcon-data-clock has to run at 1/4 the DSI per-lane bit
>>> rate [1]. It's a fixed divisor
>>>
>>> The panel I'm proposing to change is defined as this:
>>>
>>>     static const struct st7703_panel_desc xbd599_desc =3D {
>>>     	.mode =3D &xbd599_mode,
>>>     	.lanes =3D 4,
>>>     	.mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PUL=
SE,
>>>     	.format =3D MIPI_DSI_FMT_RGB888,
>>>     	.init_sequence =3D xbd599_init_sequence,
>>>     };
>>>
>>> So, we have 24 bpp and 4 lanes. Therefore, the resulting requested
>>> tcon-data-clock rate is
>>>     crtc_clock * 1000 * (24 / 4) / 4
>>>
>>> tcon-data-clock therefore requests a parent rate of
>>>     4 * (crtc_clock * 1000 * (24 / 4) / 4)
>>>
>>> The initial 4 is the fixed divisor between tcon0 and tcon-data-clock.
>>> Since tcon0 is a ccu_mux, the rate of tcon0 equals the rate of pll-mipi.
>>>
>>> Since PLL-MIPI has to run at at least at 500MHz this forces us to have a
>>> crtc_clock >=3D 83.333 MHz. The mode I'm prorposing results in a rate of
>>> 83.502 MHz.
>>
>> This is much better explanation why this change is needed. Still, I think
>> adding min and max rate to PLL_MIPI would make sense, so proper rates
>> are guaranteed.
>>
>> Anyway, do you know where are all those old values come from? And how did
>> you come up with new ones? I guess you can't just simply change timings,
>> there are probably some HW limitations? Do you know if BSP kernel support
>> this panel and how this situation is solved there?
>>
>>>
>>> If we only changed the constraints on the PLL_MIPI without changing the
>>> panel mode, we end up with a mismatch. This, in turn, would result in
>>> dropped frames, right?
>>
>> From what I read, I think frame rate would be higher than 60 fps. What
>> exactly would happen depends on the panel.
>>
>> Best regards,
>> Jernej
>>
>>>
>>> Best regards,
>>>   Frank
>>>
>>> [1] Source:
>>> https://elixir.bootlin.com/linux/v6.6.7/source/drivers/gpu/drm/sun4i/su=
n4i_tcon.c#L346
>>>
>>> >
>>> > Best regards,
>>> > Jernej
>>> >
>>> >> ---
>>> >>  drivers/gpu/drm/panel/panel-sitronix-st7703.c | 14 +++++++-------
>>> >>  1 file changed, 7 insertions(+), 7 deletions(-)
>>> >>
>>> >> diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers=
/gpu/drm/panel/panel-sitronix-st7703.c
>>> >> index b55bafd1a8be..6886fd7f765e 100644
>>> >> --- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
>>> >> +++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
>>> >> @@ -320,14 +320,14 @@ static int xbd599_init_sequence(struct st7703 =
*ctx)
>>> >>
>>> >>  static const struct drm_display_mode xbd599_mode =3D {
>>> >>  	.hdisplay    =3D 720,
>>> >> -	.hsync_start =3D 720 + 40,
>>> >> -	.hsync_end   =3D 720 + 40 + 40,
>>> >> -	.htotal	     =3D 720 + 40 + 40 + 40,
>>> >> +	.hsync_start =3D 720 + 65,
>>> >> +	.hsync_end   =3D 720 + 65 + 65,
>>> >> +	.htotal      =3D 720 + 65 + 65 + 65,
>>> >>  	.vdisplay    =3D 1440,
>>> >> -	.vsync_start =3D 1440 + 18,
>>> >> -	.vsync_end   =3D 1440 + 18 + 10,
>>> >> -	.vtotal	     =3D 1440 + 18 + 10 + 17,
>>> >> -	.clock	     =3D 69000,
>>> >> +	.vsync_start =3D 1440 + 30,
>>> >> +	.vsync_end   =3D 1440 + 30 + 22,
>>> >> +	.vtotal	     =3D 1440 + 30 + 22 + 29,
>>> >> +	.clock	     =3D (720 + 65 + 65 + 65) * (1440 + 30 + 22 + 29) * 60 =
/ 1000,
>>> >>  	.flags	     =3D DRM_MODE_FLAG_NHSYNC | DRM_MODE_FLAG_NVSYNC,
>>> >>  	.width_mm    =3D 68,
>>> >>  	.height_mm   =3D 136,
>>> >>
>>> >>
>>>

