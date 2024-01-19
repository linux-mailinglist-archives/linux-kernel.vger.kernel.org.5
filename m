Return-Path: <linux-kernel+bounces-30873-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 107BD832557
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:00:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB6D028723B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E54DDA1;
	Fri, 19 Jan 2024 08:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cs09mdNN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9A061D684;
	Fri, 19 Jan 2024 08:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705651207; cv=none; b=aoSFDCq+JvCS0D08CxrJcwqh57e9r1ft8IR0vFWjzgs5IyVKtUfaS+Gx4qJjpPnGFRY6PS9Xju9FqVpjygskwrf30GF8s7zV3ZHlFV77RUKrNnyCi47zyqbeONfJwR/YgQRz5OBPc9E+XXy6O1iHhFaJSEm11+pZL2KrR3f2wr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705651207; c=relaxed/simple;
	bh=RvV+1/JImv/LsRuTBtSvKboMDVj2C5IRu1Y90h46cMw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jVL/fFlrzkS3GBxB+M3z9eK/37KajDbeF6a8GRAyEFdBllOGybbX4CBcj93ho4CmO5GAuIwaVHU5vwWUz7cmDrBNv8FclNSEqhNUNUd4TxT7ky0fWMEa3OZ7rXwFvyQhpsjAdPdskDZSEC1fvpp2UyDSZUcAMkc1/YociurkBvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cs09mdNN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 322C1C43390;
	Fri, 19 Jan 2024 08:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705651207;
	bh=RvV+1/JImv/LsRuTBtSvKboMDVj2C5IRu1Y90h46cMw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cs09mdNNXn/aACNvQqz5ULreJfjwPVRxn8+H6D39eaWB57CeeCyQAf3qFkJ0r0Co4
	 gm/i6ZljCOGciBqfUaZas4CEgLSUgKNaBhTdX4h5xAAaWsWA2rmDjmQNCFdhr8iMwf
	 aWklHr9uTSG/2DrbxsCHkqH38+bFyLHicrWVU/wIrSGqMKQSCSdB2WvlEqmFl9Hrk3
	 o+tN/PTFdsXeV4PLrVtGf23hli2nVfpjAbvNHrlUgYS3J5OmxmlKnMXP2A15fwAQHc
	 GCYzEIpv+Ol/iexkRvigJCVTZSKBBo32ifJM3DmayVuccwcQONNO+YODHiDCeKGzvF
	 5aiJb63saaCqg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rQjnT-0004Yp-2Z;
	Fri, 19 Jan 2024 09:00:15 +0100
Date: Fri, 19 Jan 2024 09:00:15 +0100
From: Johan Hovold <johan@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Mark Brown <broonie@kernel.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 2/5] ASoC: codecs: wsa883x: lower default PA gain
Message-ID: <ZaosD3N0MpYg9Fpo@hovoldconsulting.com>
References: <20240118165811.13672-1-johan+linaro@kernel.org>
 <20240118165811.13672-3-johan+linaro@kernel.org>
 <63e000c7-deae-44df-8d82-a74ffe303e9a@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e000c7-deae-44df-8d82-a74ffe303e9a@linaro.org>

On Fri, Jan 19, 2024 at 07:15:33AM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 18/01/2024 16:58, Johan Hovold wrote:
> > The default PA gain is set to a pretty high level of 15 dB. Initialise
> > the register to the minimum -3 dB level instead.
> > 
> > This is specifically needed to allow machine drivers to use the lowest
> > level as a volume limit.
> > 
> > Cc: stable@vger.kernel.org      # 6.5
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   sound/soc/codecs/wsa883x.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/sound/soc/codecs/wsa883x.c b/sound/soc/codecs/wsa883x.c
> > index 32983ca9afba..8942c88dee09 100644
> > --- a/sound/soc/codecs/wsa883x.c
> > +++ b/sound/soc/codecs/wsa883x.c
> > @@ -722,7 +722,7 @@ static struct reg_default wsa883x_defaults[] = {
> >   	{ WSA883X_WAVG_PER_6_7, 0x88 },
> >   	{ WSA883X_WAVG_STA, 0x00 },
> >   	{ WSA883X_DRE_CTL_0, 0x70 },
> > -	{ WSA883X_DRE_CTL_1, 0x08 },
> 
> this is hw default value.

Indeed. This was a last minute change when I noticed I could actually
set the lowest limit in the machine driver after I offset it, but then
the reset value was never updated. Didn't think this through.

> > +	{ WSA883X_DRE_CTL_1, 0x1e },
> >   	{ WSA883X_DRE_IDLE_DET_CTL, 0x1F },
> >   	{ WSA883X_CLSH_CTL_0, 0x37 },
> >   	{ WSA883X_CLSH_CTL_1, 0x81 },

Johan

