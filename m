Return-Path: <linux-kernel+bounces-51206-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D708487BF
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 18:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D037D282E1A
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67B2E5F85B;
	Sat,  3 Feb 2024 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GnqIFj6q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A39285F846;
	Sat,  3 Feb 2024 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706979742; cv=none; b=FCKzzPVHcO6N4XFfmqmmfgElaEO60xStnaeiVv3nuvotofPpK4iIwmd+0Lgtbeo34TrPjOldP+sRxy+YcJAOzhmaYEscF4B5WTVxDcl49KIzd+Ew0bcoZUyVSbnJXA00ny35cTTaAFuYPFi4DIa5Kon67yQXfiw3PwsS1b3u0Dg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706979742; c=relaxed/simple;
	bh=CN7prL1hTwWEH4QYaOs3Ts5GpLJ6XNhC7U20VK3JHBw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ql+PovlPS+eODUwUPXaPYH770G+l3z+YJD9iPujVad1aSb7bUaerhwJJdEwhEwG2XBi77LutROIu4BgUakAGxqWed1gZbifa94CMKJfd0x8aK+YidjIOUeuJZH9CP03jMVDyiOaOXmoGsYyJjpFHeRnjakfYduIvLGRo1IGNF14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GnqIFj6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F446C433C7;
	Sat,  3 Feb 2024 17:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706979742;
	bh=CN7prL1hTwWEH4QYaOs3Ts5GpLJ6XNhC7U20VK3JHBw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GnqIFj6q+449MzHNfDi3e0u94bvAtnkvQVViDTtrThukB8ZZQ9GVGWAfICxbovNwE
	 5TK1/EG20vk4bZ23Qy0kuqn1t1CYQ4ybRL6NmXEcznN4tgLukz0lK5I2WMIhuY6pB2
	 z8hVCaBoFbrAv7qK3IgN8gJeddzktsrPB+45nrHreK41I+PTOC3d81I/4HbWWCBraH
	 27kPgsCySAe2056kxYOsASeo/7vG8RLfzX6dQeDdg0TKg4Wkx9olMEPiGaFVTL5rRC
	 62lQqBfBn5H7COSObBDniVIIrFkEqQAAMRqrzFlp37M9cixotvF2EZwKxnaEE/ojnM
	 L2pMp7yOsAj9w==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1rWJPQ-000000002QZ-1jJs;
	Sat, 03 Feb 2024 18:02:28 +0100
Date: Sat, 3 Feb 2024 18:02:28 +0100
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>, Johan Hovold <johan+linaro@kernel.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
	Banajit Goswami <bgoswami@quicinc.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>, Mark Brown <broonie@kernel.org>,
	Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: Stable backport request (was: [PATCH v5 0/4] ASoC: qcom: volume
 fixes and codec cleanups)
Message-ID: <Zb5xpHhqWJEkr4lB@hovoldconsulting.com>
References: <20240122181819.4038-1-johan+linaro@kernel.org>
 <170596045583.161959.6600754837297158632.b4-ty@kernel.org>
 <ZbjxUF2IV3A5zNw5@hovoldconsulting.com>
 <Zb36_mlapsfSLHEy@hovoldconsulting.com>
 <2024020351-tactics-discover-9091@gregkh>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024020351-tactics-discover-9091@gregkh>

On Sat, Feb 03, 2024 at 08:04:01AM -0800, Greg Kroah-Hartman wrote:
> On Sat, Feb 03, 2024 at 09:36:14AM +0100, Johan Hovold wrote:

> > I saw that the 6.7.4 stable patches were sent out for review over night,
> > but could it be possible to squeeze in also the following four fixes in
> > 6.7.4 (and 6.6.16)?
> > 
> > 	c481016bb4f8 ASoC: qcom: sc8280xp: limit speaker volumes
> > 	4d0e8bdfa4a5 ASoC: codecs: wcd938x: fix headphones volume controls
> > 	46188db080bd ASoC: codecs: lpass-wsa-macro: fix compander volume hack
> > 	b53cc6144a3f ASoC: codecs: wsa883x: fix PA volume control

> All now queued up for this round, thanks.

Thanks, much appreciated!

Johan

