Return-Path: <linux-kernel+bounces-30879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B24C832569
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 09:06:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB7481F2254D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 08:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4697BDDAB;
	Fri, 19 Jan 2024 08:06:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iLqIgOTb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FB61D53E;
	Fri, 19 Jan 2024 08:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705651566; cv=none; b=m/qnemyX0G2TFXauRZ4mtWBxUYp4pwqHO1Y9VBMAlhUJenfW2bIJHKvmShXnS8yCGcs2C2+knv7GJmFkz8ddvTZtp7EFHMCICXQ4iiW+cEEj23ZkCOFVXtZiZevoWOyM5RNVroUuPToAWYFfuE5L3wlpy3bvEfj/+erP4la/ZOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705651566; c=relaxed/simple;
	bh=WPQT+tS6NSneAp94KCLXM+GXH9VM9CTH1xf/mPDf+Lo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sZhHl40aREC6CCdWoVn7avRW7ydrTNZJgCu6oUwNDkyIQyNko2BG9sbiXIVjpXbZi7Gv726jderhWsQgJoiLr4ji5By3Wx0CZdltIu5EIa/hOMeyshQ8FO4Dtui254u7jOWoKUROFxp0zR4vKfoCtO8MnHPnouNWnjVV2gb/4EE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iLqIgOTb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC7EFC433C7;
	Fri, 19 Jan 2024 08:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705651566;
	bh=WPQT+tS6NSneAp94KCLXM+GXH9VM9CTH1xf/mPDf+Lo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=iLqIgOTbpKObnRHe8jUnzJO4m+SsNJiE3A1ihbhfIGWonvm+wVIQRsxR2AhBKYE1P
	 phOTnPN3oVklYuHkuUP/zNTpo0+39gUqLF9/x+Md8NW7JKBJM3aEgKbihpDm0jrydt
	 I2wbVIJu0S8VA05wF5mX3fep8pJCCsHRSqOZjLS2rMhzmtFwyCPjmVLtiKI1xcAOK2
	 gznz2bVWsbpFg5/PwcP3W3ncSiFx/yGLVAy9MSEGaxj03+CDQFOoeRZaCU2svbYBsO
	 nQC2TbmJsXbsZFRh0q4ENTIaf1KdUJHL/qrQ+l8vcb7/RWwRdftF52RPsVl/7Bvmnr
	 i/O/OsMpH8slg==
Received: from johan by xi.lan with local (Exim 4.96.2)
	(envelope-from <johan@kernel.org>)
	id 1rQjtG-0004aL-2O;
	Fri, 19 Jan 2024 09:06:14 +0100
Date: Fri, 19 Jan 2024 09:06:14 +0100
From: Johan Hovold <johan@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Mark Brown <broonie@kernel.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v3 3/5] ASoC: qcom: sc8280xp: limit speaker volumes
Message-ID: <ZaotdsEutSLfbD3x@hovoldconsulting.com>
References: <20240118165811.13672-1-johan+linaro@kernel.org>
 <20240118165811.13672-4-johan+linaro@kernel.org>
 <ac6eb9f9-9a5c-472d-9a57-ee509d9589f9@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ac6eb9f9-9a5c-472d-9a57-ee509d9589f9@linaro.org>

On Fri, Jan 19, 2024 at 07:37:14AM +0000, Srinivas Kandagatla wrote:
> 
> 
> On 18/01/2024 16:58, Johan Hovold wrote:
> > The UCM configuration for the Lenovo ThinkPad X13s has up until now
> > been setting the speaker PA volume to -3 dB when enabling the speakers,
> > but this does not prevent the user from increasing the volume further.
> > 
> > Limit the PA volume to -3 dB in the machine driver to reduce the risk of
> > speaker damage until we have active speaker protection in place.
> > 
> > Note that this will probably need to be generalised using
> > machine-specific limits, but a common limit should do for now.
> > 
> > Cc: stable@vger.kernel.org	# 6.5
> > Reviewed-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >   sound/soc/qcom/sc8280xp.c | 8 +++++---
> >   1 file changed, 5 insertions(+), 3 deletions(-)
> > 
> > diff --git a/sound/soc/qcom/sc8280xp.c b/sound/soc/qcom/sc8280xp.c
> > index ed4bb551bfbb..a19bfa354af8 100644
> > --- a/sound/soc/qcom/sc8280xp.c
> > +++ b/sound/soc/qcom/sc8280xp.c
> > @@ -32,12 +32,14 @@ static int sc8280xp_snd_init(struct snd_soc_pcm_runtime *rtd)
> >   	case WSA_CODEC_DMA_RX_0:
> >   	case WSA_CODEC_DMA_RX_1:
> >   		/*
> > -		 * set limit of 0dB on Digital Volume for Speakers,
> > -		 * this can prevent damage of speakers to some extent without
> > -		 * active speaker protection
> > +		 * Set limit of 0 dB on Digital Volume and -3 dB on PA Volume
> > +		 * to reduce the risk of speaker damage until we have active
> > +		 * speaker protection in place.
> 
> I would prefer a 0dB here instead of -3dB, this could become issue if we 
> are testing speakers without any pluseaudio or any software 
> amplification. ex: console

I know you want that, but I'm not willing to be the one raising the
default volume that people have been using so far and that you have
(unknowingly) used in your tests to verify that you did not break your
speakers.

Once you've run some more tests we can easily raise this limit.

I just want to make sure we have something safe in place ASAP now that
people will soon be able to change the hardware volume control more
easily (i.e. with the fixed UCM files).

> >   		 */
> >   		snd_soc_limit_volume(card, "WSA_RX0 Digital Volume", 84);
> >   		snd_soc_limit_volume(card, "WSA_RX1 Digital Volume", 84);
> > +		snd_soc_limit_volume(card, "SpkrLeft PA Volume", 1);
> > +		snd_soc_limit_volume(card, "SpkrRight PA Volume", 1)
> 
> It would be nice to consider using component->name_prefix here.

That can possibly be done later.

Johan

