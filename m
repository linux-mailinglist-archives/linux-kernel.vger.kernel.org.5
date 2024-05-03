Return-Path: <linux-kernel+bounces-167518-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C7298BAAB9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 12:28:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 37AC91C21890
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 10:28:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494771509A7;
	Fri,  3 May 2024 10:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CVexwY3l"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671FD14BF85;
	Fri,  3 May 2024 10:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714732094; cv=none; b=g6U9v2B13qKiqDKuezJb2bopsScZ8qqaKdumrSMi7kbD4Dc68W2Pe66F7tB8Az8rUuPrQcGRx3JvBXQgt2BETE7BGxYhooXViwVzokMhYfv7gghwbOUicw1W94OPk6RkdubS/H74+0jrBbOoi1KkexmFlfYy61LUsun/R+eWw8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714732094; c=relaxed/simple;
	bh=OntdBaerXi3AJ/zLXyZcNtMvP/PzL6ZafwOb4BeMmI8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PffkdFOFJaZ9ggqMuDg6SwkKmpcyCvwNIkTX4kWEmGCoPj3jkzFfSbfFrOG1S+bf1g6I8T8sU+BE1SCMv/q4kAShqhK2uhHRzxbyUQcs9dT9jSUDRAS2F6EbKLtffiBfU/DpnM4ruK3YvokqISH7QZREkCVYpKOA5XA0h4c6Fe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CVexwY3l; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C52C116B1;
	Fri,  3 May 2024 10:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714732094;
	bh=OntdBaerXi3AJ/zLXyZcNtMvP/PzL6ZafwOb4BeMmI8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=CVexwY3lU9pEyrjVDtImt5My3VLqjq0O6pu4tXHAYXra+R/yyivA0NvhfTLZ09e0A
	 cxbBIdKBwsREn30DGoNQVdBGNnjfuk75/VpipXdN/6ZvWZCfIKVtqVsOxiXD66T88L
	 3sCcvCfpeYvNOoP9K2/otFr5CSejsUV24l3x7xiLmlJ2OYwtrX4t6Z6ZRbVrQ+yG7x
	 8TpvvQD0STMgj41jXX4MiXNiccAK0MNa6GSxqKlDQTZ05zw2Bzltst6RLpU6SK1jGx
	 3MalcpgYNan36bYB7hjf438rPRn0mK7fZRYgacV4KlzCbym7pY6M6KQ7QdGTsVih8M
	 SjyAg0MIerKAg==
Date: Fri, 3 May 2024 11:27:58 +0100
From: Mauro Carvalho Chehab <mchehab@kernel.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Martin Tuma <martin.tuma@digiteqautomotive.com>, Laurent Pinchart
 <laurent.pinchart@ideasonboard.com>, Hugues Fruchet
 <hugues.fruchet@foss.st.com>, Alain Volmat <alain.volmat@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Paul Kocialkowski
 <paul.kocialkowski@bootlin.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Sakari
 Ailus <sakari.ailus@linux.intel.com>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>,
 Sowjanya Komatineni <skomatineni@nvidia.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Hans
 Verkuil <hverkuil@xs4all.nl>, Sergey Kozlov <serjk@netup.ru>, Abylay Ospan
 <aospan@netup.ru>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Dmitry
 Osipenko <digetx@gmail.com>, Benjamin Mugnier
 <benjamin.mugnier@foss.st.com>, Sylvain Petinot
 <sylvain.petinot@foss.st.com>, Stanimir Varbanov
 <stanimir.k.varbanov@gmail.com>, Vikash Garodia
 <quic_vgarodia@quicinc.com>, Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio
 <konrad.dybcio@linaro.org>, linux-media@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 26/26] media: dvb-frontends: tda10048: Make the range
 of z explicit.
Message-ID: <20240503112758.763d8d31@sal.lan>
In-Reply-To: <20240429-fix-cocci-v3-26-3c4865f5a4b0@chromium.org>
References: <20240429-fix-cocci-v3-0-3c4865f5a4b0@chromium.org>
	<20240429-fix-cocci-v3-26-3c4865f5a4b0@chromium.org>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Em Mon, 29 Apr 2024 15:05:05 +0000
Ricardo Ribalda <ribalda@chromium.org> escreveu:

> We do not expect the sample_freq to be over 613MHz.
> 
> Found by cocci:
> drivers/media/dvb-frontends/tda10048.c:345:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.
> 
> Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
> ---
>  drivers/media/dvb-frontends/tda10048.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/dvb-frontends/tda10048.c b/drivers/media/dvb-frontends/tda10048.c
> index 3e725cdcc66b..1886f733dbbf 100644
> --- a/drivers/media/dvb-frontends/tda10048.c
> +++ b/drivers/media/dvb-frontends/tda10048.c
> @@ -328,7 +328,8 @@ static int tda10048_set_wref(struct dvb_frontend *fe, u32 sample_freq_hz,
>  			     u32 bw)
>  {
>  	struct tda10048_state *state = fe->demodulator_priv;
> -	u64 t, z;
> +	u32 z;
> +	u64 t;
>  
>  	dprintk(1, "%s()\n", __func__);
>  
> @@ -341,6 +342,7 @@ static int tda10048_set_wref(struct dvb_frontend *fe, u32 sample_freq_hz,
>  	/* t *= 2147483648 on 32bit platforms */
>  	t *= (2048 * 1024);
>  	t *= 1024;
> +	/* Sample frequency is under 613MHz */

Are you sure about that? Some DVB devices have very high frequency 
clocks, specially if they're also used for satellite, so I can't
be sure by just looking at the driver's code.

Also, we had already a bunch of regressions with "fixes" like this
that actually broke frontend drivers.

If you're sure, please add a note at the description mentioning 
on what part of the datasheet you got it.

Otherwise, let's stick with the current code and address cocci
warning on a different way.

Regards,
Mauro

PS.: I partially applied this patch series. I left a few
patches out of the merge to let other people review/comment
(and/or for me to take a deeper look later on).

Regards,
Mauro

