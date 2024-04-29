Return-Path: <linux-kernel+bounces-162494-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 748CA8B5BFF
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 16:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 165B51F22217
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 14:54:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 017607FBD3;
	Mon, 29 Apr 2024 14:54:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XXPPQqCn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AF907F484
	for <linux-kernel@vger.kernel.org>; Mon, 29 Apr 2024 14:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714402451; cv=none; b=BUdD8W2SrwZUXjD09JaRaDoqaiTspowIXd0C5sdKepW681avHcK/YRHU38gdtEogjm0UKbOeKUldDr09J63uThTQnEWcxp2JWJWtFNAbJbCUJlD0ZcEX58LeOc+ieMPfWfCZ2YzYjOlLwmuwJHTSQ6tneCOlCF9cd2SxJwJkGJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714402451; c=relaxed/simple;
	bh=XREl17CHloVH9LS2iww9neF4mNAICGbwb3N+eWBXfvk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WMRIHz6z59Tyycixfs2v2UWj3wLGczTZfPiJD1XDIa9EtB81nefzkEesP0ahc5HX6YFZJFlFzn8Eq8flGLXFMg2eSxlCOZWwIM3TIgDqBSPtPkH2CYNfoYPRa1OoUZfATgFAX2gZVtltGvq8Pwkcs7g6v629CKJzvCzIMugGqbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XXPPQqCn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD231C113CD;
	Mon, 29 Apr 2024 14:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714402449;
	bh=XREl17CHloVH9LS2iww9neF4mNAICGbwb3N+eWBXfvk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XXPPQqCntLwoiOXb9YO5bMX4zMDr/YgPfkLPH/CeWkd4WQp19+6iP9ASUkdN+fcbl
	 ONk91QPa68V0YBAdAAX5GsV4fxcm1coYso4AP2MFTfthCIn9/V7jsuVdKnIheTDICp
	 duOJVahxniXuCzTa1CXXC1pV1kx69bsrQ9cPTOK8pC2/Xj7hepPyF0ksF6kcaRkw3O
	 G1ilwJOwpKRwIsCGuSJAVpsRmXikTIM1i2k4k7TnSIRjuPs+aeUlgRUiqORS6gyx7A
	 FmcZmvAnukW03FMqKCYdktLntOiIVndXDEpbU+XpXHbDp0wG4ByQtWwoRAdcz0ONrb
	 zV1/GjDNwyCMA==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1s1SOP-000000005GI-05vD;
	Mon, 29 Apr 2024 16:54:09 +0200
Date: Mon, 29 Apr 2024 16:54:09 +0200
From: Johan Hovold <johan@kernel.org>
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: broonie@kernel.org, perex@perex.cz, tiwai@suse.com, lgirdwood@gmail.com,
	alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/4] ASoC: qcom: common: add Display port Jack function
Message-ID: <Zi-0kSU6TMcev05r@hovoldconsulting.com>
References: <20240422134354.89291-1-srinivas.kandagatla@linaro.org>
 <20240422134354.89291-3-srinivas.kandagatla@linaro.org>
 <ZiejT5yddioQ8upR@hovoldconsulting.com>
 <b9d0e2fd-069c-439c-a85f-1e99bf9018c3@linaro.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b9d0e2fd-069c-439c-a85f-1e99bf9018c3@linaro.org>

On Tue, Apr 23, 2024 at 04:55:32PM +0100, Srinivas Kandagatla wrote:
> On 23/04/2024 13:02, Johan Hovold wrote:
> > On Mon, Apr 22, 2024 at 02:43:52PM +0100, Srinivas Kandagatla wrote:
> >   
> >>   static const struct snd_soc_dapm_widget qcom_jack_snd_widgets[] = {
> >>   	SND_SOC_DAPM_HP("Headphone Jack", NULL),
> >>   	SND_SOC_DAPM_MIC("Mic Jack", NULL),
> >> +	SND_SOC_DAPM_SPK("HDMI/DP0 Jack", NULL),
> >> +	SND_SOC_DAPM_SPK("HDMI/DP1 Jack", NULL),
> >> +	SND_SOC_DAPM_SPK("HDMI/DP2 Jack", NULL),
> > 
> > Shouldn't these be split in dedicated HDMI and DP jacks too? What if you
> > have a machine with HDMI and DP jacks which would otherwise both claim
> > "HDMI/DP0"?
> 
> These map to the Jack's added as part of qcom_snd_dp_jack_setup and 
> belong to DISPLAY_PORT_RX_0, DISPLAY_PORT_RX_1, DISPLAY_PORT_RX_2.
> 
> If its going via USB-C DP controller it will be either DP or an HDMI ?

It will always be DP out of the machine even if an adapter can convert
to HDMI internally.

The DRM ports are called "DP-1" and "DP-2" so it seems we should match
that.

> This is the most common naming for the USB-C DP/HDMI jack events.

It looks like some Intel machines use names like "HDMI/DP, pcm=%d Jack"
(with a pcm device number), but we also have "DP Jack". Not sure which
are are used with USB-C, though. (Or if the former actually support HDMI
altmode.)

> Qualcomm LPASS in some older SoCs had a dedicated HDMI interface which 
> is different to this one.
> 
> Usual Other ways to connect HDMI is via external HDMI Bridge using I2S 
> interface which totally different to this DP interface.

Sure, but if there's ever a design with such a port then it will be
called "HDMI Jack" and then the "HDMI in "HDMI/DP0 Jack" is unnecessary
and confusing when it is always DP out.

Johan

