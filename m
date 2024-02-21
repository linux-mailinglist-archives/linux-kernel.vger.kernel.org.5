Return-Path: <linux-kernel+bounces-74548-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B1C785D5C8
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 11:39:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D12D1C20CE7
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 10:39:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6118A208C1;
	Wed, 21 Feb 2024 10:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b="NVUrtqwk"
Received: from mout-p-102.mailbox.org (mout-p-102.mailbox.org [80.241.56.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81C533EA89;
	Wed, 21 Feb 2024 10:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708511944; cv=none; b=btukBm1I69ugESYaI8ulyj+rYYohEc0baGJxy5LuyoME8GpRqbtkuiVczmGrgxmWEs6GhotO/zmK6Rg2jZlIJoG+wD2gFCFYz/VTbCXvZ1KXCyHOAJO0HKRAPiE0Jcp8i9qtcATBNECd1ue+jaem29pUB8aACh1LO/Exlv0+pbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708511944; c=relaxed/simple;
	bh=3T2LRJtiW3mZfk/PunFIogOMmmkLZ7ysF+8gTpzPau4=;
	h=References:From:To:Cc:Subject:In-reply-to:Date:Message-ID:
	 MIME-Version:Content-Type; b=MX3HsSVlcOCgZIdiWlVw02fCfHwRFcQS7USH4BbbFzXwzq9xLmNtpBI4AHS824CMdH44eOQEG2bakBfL9AlD1NeBaTZ408pe2AqFNlxphuaU5Ygm3J9v/yHnRIxJ4h6JWcbXX4yoWCviyrdW2CRqB6/zI9N56GV2uHObueNU1uY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev; spf=pass smtp.mailfrom=oltmanns.dev; dkim=pass (2048-bit key) header.d=oltmanns.dev header.i=@oltmanns.dev header.b=NVUrtqwk; arc=none smtp.client-ip=80.241.56.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=oltmanns.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oltmanns.dev
Received: from smtp202.mailbox.org (smtp202.mailbox.org [IPv6:2001:67c:2050:b231:465::202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-102.mailbox.org (Postfix) with ESMTPS id 4Tft6g64Lkz9tln;
	Wed, 21 Feb 2024 11:38:51 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oltmanns.dev;
	s=MBO0001; t=1708511931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VOqX0GOQZZOiGD9BoiPl4P99i5/2V8G3vmiVhpwmjpo=;
	b=NVUrtqwknw/O3TZyiGfvfpG0IBx7JJpeIshlUGI/ALrW+famIowinN8F9Ti3bU4Kb+DskP
	y775xaFPKAqf07Z9jufvCZ/AuUTAM4pXCgmXlgUugQZxZI4mmfx/4UJIb3CWj7JIytAhQg
	l3cMMRBSKwmkaUjCkZVPwc9QSZ0W96DsujRbPvrZTUclXWsJ2NVejTPx9Ud7DDCgLM69Gb
	4oAYCyVx0a/ZfDI7wBynT1H/fvIHe24aB5hJFSRro6uKd6bhUTPnwEiiZrZqz68LsxqWry
	p64VobbPssd93ohFph+mesCr7BNyXCE5h4LrsNcuswhXvQdIQyv57qnfdnQpWw==
References: <20240205-pinephone-pll-fixes-v2-0-96a46a2d8c9b@oltmanns.dev>
 <20240205-pinephone-pll-fixes-v2-3-96a46a2d8c9b@oltmanns.dev>
From: Frank Oltmanns <frank@oltmanns.dev>
To: Jernej Skrabec <jernej.skrabec@gmail.com>, Maxime Ripard
 <mripard@kernel.org>, Diego Roversi <diegor@tiscali.it>
Cc: Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Chen-Yu Tsai <wens@csie.org>, Samuel Holland
 <samuel@sholland.org>, Guido =?utf-8?Q?G=C3=BCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team
 <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>, Neil Armstrong
 <neil.armstrong@linaro.org>, Jessica Zhang <quic_jesszhan@quicinc.com>,
 Sam Ravnborg <sam@ravnborg.org>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Thomas Zimmermann
 <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, Daniel Vetter
 <daniel@ffwll.ch>, Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org
Subject: Re: [PATCH v2 3/6] clk: sunxi-ng: nkm: Support minimum and maximum
 rate
In-reply-to: <20240205-pinephone-pll-fixes-v2-3-96a46a2d8c9b@oltmanns.dev>
Date: Wed, 21 Feb 2024 11:38:39 +0100
Message-ID: <8734tmhzkg.fsf@oltmanns.dev>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: 4Tft6g64Lkz9tln

Hi Jernej,
hi Maxime,

On 2024-02-05 at 16:22:26 +0100, Frank Oltmanns <frank@oltmanns.dev> wrote:
> According to the Allwinner User Manual, the Allwinner A64 requires
> PLL-MIPI to run at 500MHz-1.4GHz. Add support for that to ccu_nkm.

I should point out that limiting PLL-MIPI also fixes a regression
that was introduced in 6.5, specifically
ca1170b69968233b34d26432245eddf7d265186b "clk: sunxi-ng: a64: force
select PLL_MIPI in TCON0 mux". This has been bisected and reported by
Diego [1].

I don't know the procedure (yet), but probably the fix (if and when
accepted) should be backported at least to 6.6 (first broken LTS), 6.7
(stable), and 6.8 (next stable).

My suggestion:
 - In V3 of this series, I will reorder the patches, so that what is now
   PATCH 3 and 4 becomes 1 and 2 respectively, so that they can be
   applied to 6.6 more easily.
 - Maxime, IIUC you requested some refactoring for handling the rate
   limits [2]. I propose, we use my current proposal as-is, and I will
   do a follow-up series for the refactoring.

Please let me know how you would like me to proceed.

Thanks,
  Frank

[1]: https://groups.google.com/g/linux-sunxi/c/Rh-Uqqa66bw
[2]: https://lore.kernel.org/all/exb2lvjcozak5fayrgyenrd3ntii4jfxgvqork4klyz5pky2aq@dj2zyw5su6pv/

>
> Signed-off-by: Frank Oltmanns <frank@oltmanns.dev>
> ---
>  drivers/clk/sunxi-ng/ccu_nkm.c | 13 +++++++++++++
>  drivers/clk/sunxi-ng/ccu_nkm.h |  2 ++
>  2 files changed, 15 insertions(+)
>
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.c b/drivers/clk/sunxi-ng/ccu_nkm.c
> index 1168d894d636..7d135908d6e0 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.c
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.c
> @@ -181,6 +181,12 @@ static unsigned long ccu_nkm_round_rate(struct ccu_mux_internal *mux,
>  	if (nkm->common.features & CCU_FEATURE_FIXED_POSTDIV)
>  		rate *= nkm->fixed_post_div;
>
> +	if (nkm->min_rate && rate < nkm->min_rate)
> +		rate = nkm->min_rate;
> +
> +	if (nkm->max_rate && rate > nkm->max_rate)
> +		rate = nkm->max_rate;
> +
>  	if (!clk_hw_can_set_rate_parent(&nkm->common.hw))
>  		rate = ccu_nkm_find_best(*parent_rate, rate, &_nkm, &nkm->common);
>  	else
> @@ -220,6 +226,13 @@ static int ccu_nkm_set_rate(struct clk_hw *hw, unsigned long rate,
>  	_nkm.min_m = 1;
>  	_nkm.max_m = nkm->m.max ?: 1 << nkm->m.width;
>
> +
> +	if (nkm->min_rate && rate < nkm->min_rate)
> +		rate = nkm->min_rate;
> +
> +	if (nkm->max_rate && rate > nkm->max_rate)
> +		rate = nkm->max_rate;
> +
>  	ccu_nkm_find_best(parent_rate, rate, &_nkm, &nkm->common);
>
>  	spin_lock_irqsave(nkm->common.lock, flags);
> diff --git a/drivers/clk/sunxi-ng/ccu_nkm.h b/drivers/clk/sunxi-ng/ccu_nkm.h
> index c409212ee40e..358a9df6b6a0 100644
> --- a/drivers/clk/sunxi-ng/ccu_nkm.h
> +++ b/drivers/clk/sunxi-ng/ccu_nkm.h
> @@ -27,6 +27,8 @@ struct ccu_nkm {
>  	struct ccu_mux_internal	mux;
>
>  	unsigned int		fixed_post_div;
> +	unsigned long		min_rate;
> +	unsigned long		max_rate;
>  	unsigned long		max_m_n_ratio;
>  	unsigned long		min_parent_m_ratio;

