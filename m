Return-Path: <linux-kernel+bounces-6458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF40481992C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:14:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4D7881F278F0
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 07:14:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE40F14F98;
	Wed, 20 Dec 2023 07:14:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="aqewHPPW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E22DF168D5;
	Wed, 20 Dec 2023 07:14:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [10.196.197.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4Sw4YS2tHnz9sp6;
	Wed, 20 Dec 2023 08:14:04 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1703056444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5JWAYPuW2w1S4QldNPnKh0l/fjpe1uHU+1lOR2wMdU0=;
	b=aqewHPPWceld/vN8dMOtuujW1lrzIuiuwJzKUDlrCm/5bgQUqYB3yB3wupaAbprIDdvT3S
	E0Z4gggq86mbLA9q8ui0llGLXNLQ47UXkdP9lx3NOVL0/k/J9PPq2Q5d+p58OsnUZoADD1
	s5FlKWcrSAR0b6vJMSPqWd/Ne/RLgf/FdJyB9G+h9CrsLz1FwWTIGxt+x7kQnTQekWAVBw
	z5+ACiE/uFS20YhQPE2IsU6qq1kBInaD5p1wvFr+QVkbU5K0FIqhlPAK88oVeTaakhkHaZ
	bKquYn0TEz46x3Kf3Dwt0d/v03zuyUVCqkL4QucIBwA+dpgdra82zMhkl7P4tg==
References: <20231218-pinephone-pll-fixes-v1-0-e238b6ed6dc1@oltmanns.dev>
 <20231218-pinephone-pll-fixes-v1-4-e238b6ed6dc1@oltmanns.dev>
 <13411739.uLZWGnKmhe@jernej-laptop>
From: Frank Oltmanns <frank@oltmanns.dev>
To: Jernej =?utf-8?Q?=C5=A0krabec?= <jernej.skrabec@gmail.com>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Samuel Holland
 <samuel@sholland.org>, Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team
 <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Daniel Vetter <daniel@ffwll.ch>, linux-clk@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH 4/5] clk: sunxi-ng: a64: Add constraints on PLL-VIDEO0's
 n/m ratio
Date: Wed, 20 Dec 2023 08:09:28 +0100
In-reply-to: <13411739.uLZWGnKmhe@jernej-laptop>
Message-ID: <87il4t9wi1.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 2023-12-19 at 17:54:19 +0100, Jernej =C5=A0krabec <jernej.skrabec@gmail.=
com> wrote:
> Dne ponedeljek, 18. december 2023 ob 14:35:22 CET je Frank Oltmanns napis=
al(a):
>> The Allwinner A64 manual lists the following constraint for the
>> PLL-VIDEO0 clock: 8 <=3D N/M <=3D 25
>>
>> Use this constraint.
>>
>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>> ---
>>  drivers/clk/sunxi-ng/ccu-sun50i-a64.c | 8 ++++++--
>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c b/drivers/clk/sunxi-n=
g/ccu-sun50i-a64.c
>> index c034ac027d1c..75d839da446c 100644
>> --- a/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
>> +++ b/drivers/clk/sunxi-ng/ccu-sun50i-a64.c
>> @@ -68,7 +68,8 @@ static SUNXI_CCU_NM_WITH_SDM_GATE_LOCK(pll_audio_base_=
clk, "pll-audio-base",
>>  				       BIT(28),	/* lock */
>>  				       CLK_SET_RATE_UNGATE);
>>
>> -static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST(pll_video0_clk,=
 "pll-video0",
>> +static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT_NM_RATIO(pll_video=
0_clk,
>> +						"pll-video0",
>>  						"osc24M", 0x010,
>>  						192000000,	/* Minimum rate */
>>  						1008000000,	/* Maximum rate */
>> @@ -80,7 +81,10 @@ static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSE=
ST(pll_video0_clk, "pll-vid
>>  						297000000,	/* frac rate 1 */
>>  						BIT(31),	/* gate */
>>  						BIT(28),	/* lock */
>> -						CLK_SET_RATE_UNGATE);
>> +						CLK_SET_RATE_UNGATE,
>> +						CCU_FEATURE_FRACTIONAL |
>> +						CCU_FEATURE_CLOSEST_RATE,
>
> Above flags are unrelated change, put them in new patch if needed.

You might notice that I am using a new macro for initializing the
pll_video0_clk struct:
New: SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_FEAT_NM_RATIO
Old: SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_CLOSEST

Setting the two CCU_FEATURE flags is part of the old initialization
macro.

I'll add SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK_MIN_MAX_NM_RATIO_CLOSEST which
hopefully resolves the confusion.

Thanks,
  Frank

>
> Best regards,
> Jernej
>
>> +						8, 25);		/* min/max nm ratio */
>>
>>  static SUNXI_CCU_NM_WITH_FRAC_GATE_LOCK(pll_ve_clk, "pll-ve",
>>  					"osc24M", 0x018,
>>
>>

