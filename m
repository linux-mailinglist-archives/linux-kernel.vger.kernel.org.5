Return-Path: <linux-kernel+bounces-70290-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D918E8595A4
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 09:29:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17E161C214C8
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Feb 2024 08:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7051078D;
	Sun, 18 Feb 2024 08:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="g9lcu2oS"
Received: from mout-p-101.mailbox.org (mout-p-101.mailbox.org [80.241.56.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F65E12E7A;
	Sun, 18 Feb 2024 08:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708244981; cv=none; b=L/iYxBbyAvW0MA5HFhIR9d0koAEhsPDaXbyx2j6A34fUzOMUZhz6w+SlzfoflpnlyZrs0Vkzihofsms2epcGGgHPx9cECNxgg3LaBFhxxjxQkLjKLIt5C/c91Jt3aD1jOA/Ht/GYGKzyKpMfB7gToPkGMfWIXb1AIt/zXGsLBeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708244981; c=relaxed/simple;
	bh=jZcTtCZH0obhcvEN8pLDKD99bxA5SkFp4NpD0xiDXhk=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 MIME-Version:Content-Type; b=Fwmn4vptDcQd7QYbqk5tIz8BXCukahjzSJhb1mAYSM4o97UVWQO2s3Oo/OhGa0eYmdFqW9OBzF/SzJcPcfZFgzqfgTNFkrgfg2xageSWiL2WzjYRkR8ziQFZ45ClhqD9JDfL5OA98qCeRy8e7Wv8zBkwulx4OwhJbh3pq7nZAkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=g9lcu2oS; arc=none smtp.client-ip=80.241.56.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-101.mailbox.org (Postfix) with ESMTPS id 4TczNn46Snz9sTN;
	Sun, 18 Feb 2024 09:29:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1708244969;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xpPRlAGo3UCIb/pniYUufEMkCBvpDmyH0z7zQJYnmCE=;
	b=g9lcu2oSUYVaqvRC7RSidQDG9k6eVMXMgQM/7PR0OOg/MKXB924LWdAQtLX/XzWfz4cBeR
	qs/7vQOhsueqHlu37Mi2duYMpNIvf0V5Hhl93idD1WVskzdbjNxGPtRrBCgciwMpdWxFUL
	RZqsvJAlxS3C0tceHtmvP8MgSx1EdQnmFHb2t/EQvIJd6Kc/irWNmYaTLnzP5zm3t6c6Kb
	HMKdzQ6Bg/9IYXfGWVUcdduK3+PQ2Q3gtHOmNjtaWLVR23sxX2bMBtzKGgs21QqHQ9sSFQ
	tA3GtSzFfZCOC+vw1lwScAneLRvH/L7Cib0kWbLj/blALD5YdXuIymbhi7KYlA==
References: <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
 <20240205-pinephone-pll-fixes-v2-3-96a46a2d8c9b@oltmanns.dev>
 <exb2lvjcozak5fayrgyenrd3ntii4jfxgvqork4klyz5pky2aq@dj2zyw5su6pv>
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
Subject: Re: [PATCH v2 3/6] clk: sunxi-ng: nkm: Support minimum and maximum
 rate
In-reply-to: <exb2lvjcozak5fayrgyenrd3ntii4jfxgvqork4klyz5pky2aq@dj2zyw5su6pv>
Date: Sun, 18 Feb 2024 09:29:15 +0100
Message-ID: <874je6b2g4.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4TczNn46Snz9sTN

Hi Maxime,

On 2024-02-08 at 13:16:27 +0100, Maxime Ripard <mripard@kernel.org> wrote:
> [[PGP Signed Part:Undecided]]
> On Mon, Feb 05, 2024 at 04:22:26PM +0100, Frank Oltmanns wrote:
>> According to the Allwinner User Manual, the Allwinner A64 requires
>> PLL-MIPI to run at 500MHz-1.4GHz. Add support for that to ccu_nkm.
>>
>> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
>> ---
>>  drivers/clk/sunxi-ng/ccu_nkm.c | 13 +++++++++++++
>>  drivers/clk/sunxi-ng/ccu_nkm.h |  2 ++
>>  2 files changed, 15 insertions(+)
>>
>> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
>> index 1168d894d636..7d135908d6e0 100644
>> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
>> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
>> @@ -181,6 +181,12 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
>>  	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>>  		rate *= nkm->fixed_post_div;
>>
>> +	if (nkm->min_rate && rate < nkm->min_rate)
>> +		rate = nkm->min_rate;
>> +
>> +	if (nkm->max_rate && rate > nkm->max_rate)
>> +		rate = nkm->max_rate;
>> +
>
> This is provided by the clock range already. If you call
> clk_hw_set_rate_range, it should work just fine.

I have to admit, that I don't know that much about sunxi-ng or the CCF
and therefore humbly request some guidance.

I've looked at other examples of clk_hw_set_rate_range() usage and it
seems there is not a lot of adoption for this functionality even though
it was already introduced mid-2015. This makes me wonder, why that is.

Anyhow, it seems in all examples I found, clk_hw_set_rate_range() is
called immediately after registering the clk_hw. So, in the case of
sunxi-ng, we'd need to do that in sunxi_ccu_probe, which is a common
function for all sunxi-ng clock types. Correct?

If so, surely, you don't want me to introduce clock type specific code
to a common function, so I assume you want min_rate and max_rate to
become members of struct ccu_common. Correct?

If so, since there already are some clock types in sunxi-ng that support
having a minimum and maximum rate, these clocks should be refactored
eventually. Correct?

Finally, in sunxi-ng there is a feature of having a fixed_post_div (see,
e.g., the first to lines of the diff above). It seems to me that CCF
cannot know about these post_divs, so we'd also need to transfer the
fixed_post_div to ccu_common and use that when calling
clk_hw_set_rate_range. Correct?

The fact that you casually dropped the two sentences above and me
deducing you want a somewhat large refactoring of the functionality for
sunxi-ng, makes me wonder if I completely misunderstood your request.

Best regards,
  Frank

>
> Maxime
>
> [[End of PGP Signed Part]]

