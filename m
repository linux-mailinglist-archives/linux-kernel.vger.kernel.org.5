Return-Path: <linux-kernel+bounces-13661-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C284820AAA
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 10:17:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ABCB92826F6
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Dec 2023 09:17:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92F06186C;
	Sun, 31 Dec 2023 09:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="r1cTud9M"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30290320C;
	Sun, 31 Dec 2023 09:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4T2td25K4fz9sc6;
	Sun, 31 Dec 2023 10:10:46 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1704013846;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hlVujKA1PeQa8EJSC4InM714qJCCxj/rjMUfrSS3bfw=;
	b=r1cTud9M3wVC9jFHCOg36Lt+//kfqLq90rmJ/bB54sN/mMd80lSOW/e5APEc8e/w0SQHOA
	W0XVmqtTOgXzFhNW+LB6KpSTy7ap6356EBmoXrVWGux9v5vjEG2RoJ/hu2YGK3E77g6u5H
	hDWGnAi69NcrqulMRrynDdB8jYN/OI8FBxgoIIGHHxGdY7hGIaLihyJjlBxqhHIaHpKmXd
	9pRylo1kYGLy8et8nYpNN99xwKMpnaBllrmeZPUtQ3MDwi4dgrAzoIxCzTBSqia78qTUUM
	pPZSq2e2oYF0XhqMZAXNx60BHaU7OXdUljURCJUxhSHtGQM0Y4zjXUR+E3tNrw==
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
In-reply-to: <13411739.uLZWGnKmhe@jernej-laptop>
Date: Sun, 31 Dec 2023 10:10:40 +0100
Message-ID: <87jzoug2jz.fsf@oltmanns.dev>
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

I just realized that adding the whole ratio limits for ccu_nm is
superfluous as you could just as well express them in for of a minimum
and maximum range:
Since 8 <=3D N/M <=3D 25 and parent_rate =3D 24 MHz, therefore
  192 MHz <=3D rate <=3D 600 MHz.

These absolute limits are also listed in Allwinner's A64 manual.

BUT, here the upper limit was raised to 1008 MHz:
5de39acaf34604bd04834f092479cf4dcc946dd "clk: sunxi-ng: a64: Add max.
rate constraint to video PLL"

With this upper limit the ratio limitation is effectively:
8 <=3D N/M <=3D 42

Icenowy Zheng (added to CC) had the reasonable explanation that this was
used in the BSP kernel, so we should probably stick to that and ditch
the two PLL-VIDEO0 related patches. What are your thoughts on that?

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

