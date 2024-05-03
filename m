Return-Path: <linux-kernel+bounces-167745-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D238BAE81
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:09:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AF831F217D6
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B1D5154BFE;
	Fri,  3 May 2024 14:08:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="mAarC0LY"
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F44152184;
	Fri,  3 May 2024 14:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714745335; cv=none; b=kwYjWZfsb1Qr8tNkPaLn+5Ce/dVIp0oPZRiaHUtHTkF7lXQJ66oy4jUHJ2bS58FnCtE/uP9ZRImCddpmsViIzlUAmq5qW4NhnaN8fwQpK70ZNkdfrWR4x4Krr8JJEutd/YCTaZ3LsDND6AqupxsYCxbXsNvY3Hl9EdYsJdyC5b0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714745335; c=relaxed/simple;
	bh=+kPnKcYBQEaIz35grdcmnn1EGJxQ/kAtMsbVmsDrItw=;
	h=MIME-Version:Date:From:To:Cc:Subject:In-Reply-To:References:
	 Message-ID:Content-Type; b=j04s6tX3jVPT+YUacflG2Z+XvmrazAijJQc+Rgt/wq/YuXrB9sdfyzHgqv1nTYLufHgrkjhOt5imlYzQu/HmHN+QIteEMmPDp9OMcCx4uSxG1XZ3dDtuWLjPcKrhpdq8PQLbzf1Ev+ZEYZdVSvmXeLfMlpFsME5QIsTaNQmDaF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=mAarC0LY; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1714745331;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3C+MgtjD5FFzr1H8ErTkKFFC7gX/7QwO2uuYNs38Akc=;
	b=mAarC0LY0zCqC2ZrO6f/B0kd24XVsuHukHHUkTxv8x6uP89ukwITU0O3Ynvicd1D1E9pAe
	IO3tmU10O6igCP8QZy19eeUc6Ld3IxJqvuNP1A5HBT6M5ThYS4BpN1w2gd1THv6O1jAK7/
	ezGJ5lRjzzWduiC7DpEa6et6y5QamPHTjx/cHxFoa92YbVL3l6ufWF1RIr8LLxjgxMNHq8
	xLmLl+oEm7sIthlsxDBs1Nx//ZO6J02vTNuOw0f8VgzJgXGDL/8MklHPqBILGlrXprDE9w
	hibkEuHJ/OUQOHG1dbrTz8I/N/GLzP9y5rNue5qKcnd9Fy1V2tSamIAR/DWm+g==
Date: Fri, 03 May 2024 16:08:48 +0200
From: Dragan Simic <dsimic@manjaro.org>
To: Ricardo Ribalda <ribalda@chromium.org>
Cc: Dan Carpenter <dan.carpenter@linaro.org>, Mauro Carvalho Chehab
 <mchehab@kernel.org>, Martin Tuma <martin.tuma@digiteqautomotive.com>,
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, Hugues Fruchet
 <hugues.fruchet@foss.st.com>, Alain Volmat <alain.volmat@foss.st.com>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, Alexandre Torgue
 <alexandre.torgue@foss.st.com>, Paul Kocialkowski
 <paul.kocialkowski@bootlin.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec
 <jernej.skrabec@gmail.com>, Samuel Holland <samuel@sholland.org>, Sakari
 Ailus <sakari.ailus@linux.intel.com>, Thierry Reding
 <thierry.reding@gmail.com>, Jonathan Hunter <jonathanh@nvidia.com>, Sowjanya
 Komatineni <skomatineni@nvidia.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Hans
 Verkuil <hverkuil@xs4all.nl>, Sergey Kozlov <serjk@netup.ru>, Abylay Ospan
 <aospan@netup.ru>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Dmitry
 Osipenko <digetx@gmail.com>, Benjamin Mugnier
 <benjamin.mugnier@foss.st.com>, Sylvain Petinot
 <sylvain.petinot@foss.st.com>, Stanimir Varbanov
 <stanimir.k.varbanov@gmail.com>, Vikash Garodia <quic_vgarodia@quicinc.com>,
 Bryan O'Donoghue <bryan.odonoghue@linaro.org>, Bjorn Andersson
 <andersson@kernel.org>, Konrad Dybcio <konrad.dybcio@linaro.org>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev,
 linux-sunxi@lists.linux.dev, linux-tegra@vger.kernel.org,
 linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org
Subject: Re: [PATCH v3 26/26] media: dvb-frontends: tda10048: Make the range
 of z explicit.
In-Reply-To: <CANiDSCsU+jgYkUmHZOC8xPsL2DbgU7_sWrby1bQAXQNnp+g6Bg@mail.gmail.com>
References: <20240429-fix-cocci-v3-0-3c4865f5a4b0@chromium.org>
 <20240429-fix-cocci-v3-26-3c4865f5a4b0@chromium.org>
 <20240503112758.763d8d31@sal.lan>
 <c4287024-8012-458d-9829-15ffbceb25cf@moroto.mountain>
 <CANiDSCsU+jgYkUmHZOC8xPsL2DbgU7_sWrby1bQAXQNnp+g6Bg@mail.gmail.com>
Message-ID: <fe95e3c3a89de4566a4eb53ca8b26c25@manjaro.org>
X-Sender: dsimic@manjaro.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=dsimic@manjaro.org smtp.mailfrom=dsimic@manjaro.org

Hello Ricardo,

On 2024-05-03 13:56, Ricardo Ribalda wrote:
> I am trying to get the DS, but
> https://www.nxp.com/acrobat_download/literature/9397/75015931.pdf is a
> dead links now.
> 
> Anyone have access to the datasheet?

It's kind of available on the link below, but for some strange reason
the download fails after downloading the first 128 KB or so.

https://web.archive.org/web/20080907185532/https://www.nxp.com/acrobat_download/literature/9397/75015931.pdf


> On Fri, 3 May 2024 at 13:55, Dan Carpenter <dan.carpenter@linaro.org> 
> wrote:
>> 
>> On Fri, May 03, 2024 at 11:27:58AM +0100, Mauro Carvalho Chehab wrote:
>> > Em Mon, 29 Apr 2024 15:05:05 +0000
>> > Ricardo Ribalda <ribalda@chromium.org> escreveu:
>> >
>> > > We do not expect the sample_freq to be over 613MHz.
>> > >
>> > > Found by cocci:
>> > > drivers/media/dvb-frontends/tda10048.c:345:1-7: WARNING: do_div() does a 64-by-32 division, please consider using div64_u64 instead.
>> > >
>> > > Signed-off-by: Ricardo Ribalda <ribalda@chromium.org>
>> > > ---
>> > >  drivers/media/dvb-frontends/tda10048.c | 4 +++-
>> > >  1 file changed, 3 insertions(+), 1 deletion(-)
>> > >
>> > > diff --git a/drivers/media/dvb-frontends/tda10048.c b/drivers/media/dvb-frontends/tda10048.c
>> > > index 3e725cdcc66b..1886f733dbbf 100644
>> > > --- a/drivers/media/dvb-frontends/tda10048.c
>> > > +++ b/drivers/media/dvb-frontends/tda10048.c
>> > > @@ -328,7 +328,8 @@ static int tda10048_set_wref(struct dvb_frontend *fe, u32 sample_freq_hz,
>> > >                          u32 bw)
>> > >  {
>> > >     struct tda10048_state *state = fe->demodulator_priv;
>> > > -   u64 t, z;
>> > > +   u32 z;
>> > > +   u64 t;
>> > >
>> > >     dprintk(1, "%s()\n", __func__);
>> > >
>> > > @@ -341,6 +342,7 @@ static int tda10048_set_wref(struct dvb_frontend *fe, u32 sample_freq_hz,
>> > >     /* t *= 2147483648 on 32bit platforms */
>> > >     t *= (2048 * 1024);
>> > >     t *= 1024;
>> > > +   /* Sample frequency is under 613MHz */
>> >
>> > Are you sure about that? Some DVB devices have very high frequency
>> > clocks, specially if they're also used for satellite, so I can't
>> > be sure by just looking at the driver's code.
>> >
>> > Also, we had already a bunch of regressions with "fixes" like this
>> > that actually broke frontend drivers.
>> 
>> This patch preserves the existing behavior. The sample_freq_hz 
>> variable
>> is a u32 so, in the original code, z couldn't have been more than
>> U32_MAX even though it was declared as a u64.
>> 
>> It's possible that the original code was wrong.  We have seen that in
>> other places in this patchset.  Adding a note about the datasheet is
>> also a good idea.
>> 
>> regards,
>> dan carpenter
>> 

