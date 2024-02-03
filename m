Return-Path: <linux-kernel+bounces-51173-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 03D8484874F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 17:04:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D16F1C22B06
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 16:04:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4328C5F563;
	Sat,  3 Feb 2024 16:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="h6r7y3Xd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7576E5F557;
	Sat,  3 Feb 2024 16:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706976242; cv=none; b=lnrDcKVtaidKvVZ0Us+nxAfJR/N5/mfFYU1UdD97/oPn/2zWzQpHNUG+oeceJAzSl9o/lekr2S3AHu3ypK+r4Vqn7mt0RliWt/C/O6ey3rH4w+cs5P4HRlGYMitGhfCl6FRp1bV7juHv5k9x+2psyLp/Cl4MvWDxY6JoXxVhhFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706976242; c=relaxed/simple;
	bh=5DqaVk+Tled7B7zD5P3CsBhEgwQvizuMR5RGuh99ymo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ogxsSK85kTPuplPiUmorwoLH/6a6mbvpt1EycTT46ByqaFGj7BNx7ZxjJvHxYajxHbrglNu+Bf7D7mN1epxMFcEc8RLwm/gdvQJ7fTJAgK8rHBabl2VJqlFrpmHb/JhhN4e0NTI3okHMyu7DVQjOZ8dSLzsXMuzOMLiSA7Ivxg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=h6r7y3Xd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3558CC433F1;
	Sat,  3 Feb 2024 16:04:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706976242;
	bh=5DqaVk+Tled7B7zD5P3CsBhEgwQvizuMR5RGuh99ymo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=h6r7y3Xd16/amxIFXzdo+EwJqTFcTUs3LSFsQP4O7TDp2PF0LDCHgQL5z+7j9cnT/
	 Rrx5rOYMCJvTYNlvFLYZeac2dRhoAthGNePlGG78qAILMPEHbNh9GqRbUMEdaDQLkJ
	 zVABXrgCxX1WnqF157FNoS12arEM1lifAlvLFgNQ=
Date: Sat, 3 Feb 2024 08:04:01 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Johan Hovold <johan@kernel.org>
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
Message-ID: <2024020351-tactics-discover-9091@gregkh>
References: <20240122181819.4038-1-johan+linaro@kernel.org>
 <170596045583.161959.6600754837297158632.b4-ty@kernel.org>
 <ZbjxUF2IV3A5zNw5@hovoldconsulting.com>
 <Zb36_mlapsfSLHEy@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zb36_mlapsfSLHEy@hovoldconsulting.com>

On Sat, Feb 03, 2024 at 09:36:14AM +0100, Johan Hovold wrote:
> Hi Greg and Sasha,
> 
> On Tue, Jan 30, 2024 at 01:53:37PM +0100, Johan Hovold wrote:
> > On Mon, Jan 22, 2024 at 09:54:15PM +0000, Mark Brown wrote:
> > > On Mon, 22 Jan 2024 19:18:15 +0100, Johan Hovold wrote:
> > > > To reduce the risk of speaker damage the PA gain needs to be limited on
> > > > machines like the Lenovo Thinkpad X13s until we have active speaker
> > > > protection in place.
> > > > 
> > > > Limit the gain to the current default setting provided by the UCM
> > > > configuration which most user have so far been using (due to a bug in
> > > > the configuration files which prevented hardware volume control [1]).
> > > > 
> > > > [...]
> > > 
> > > Applied to
> > > 
> > >    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> > 
> > alsa-ucm-conf 1.2.11 was released yesterday, which means that it is now
> > very urgent to get the speaker volume limitation backported to the
> > stable trees.
> > 
> > Could you please try to make sure that these fixes get to Linus this
> > week?
> 
> This series (and a related headphone codec fix) were merged into Linus's
> tree yesterday.
> 
> I saw that the 6.7.4 stable patches were sent out for review over night,
> but could it be possible to squeeze in also the following four fixes in
> 6.7.4 (and 6.6.16)?
> 
> 	c481016bb4f8 ASoC: qcom: sc8280xp: limit speaker volumes
> 	4d0e8bdfa4a5 ASoC: codecs: wcd938x: fix headphones volume controls
> 	46188db080bd ASoC: codecs: lpass-wsa-macro: fix compander volume hack
> 	b53cc6144a3f ASoC: codecs: wsa883x: fix PA volume control
> 
> These are needed for proper volume control and, importantly, to prevent
> users of the Lenovo ThinkPad X13s from potentially damaging their
> speakers when the distros ship the latest UCM configuration files which
> were released on Monday.

All now queued up for this round, thanks.

greg k-h

