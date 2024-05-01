Return-Path: <linux-kernel+bounces-165340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 739E08B8B6D
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29E891F23C63
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:44:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4C512F599;
	Wed,  1 May 2024 13:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="t4yMwhv4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2903112DDBC;
	Wed,  1 May 2024 13:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714571007; cv=none; b=ufGCfTmVpEyy0mWLo8QdGtkBrLJ9fJyk1bkg9YrKqyh265I50nFBdlEkZo58cIaeHi2pQ9WNHOFv565GZrFzzYH4ZB0U5duO7haQj1SzAeUdYjxiRMNmuDOI7wgQzNC3JIV+vKs7bQWHQbQ7u6EhaKSqSXY7Kb4SiNg0CDqB2P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714571007; c=relaxed/simple;
	bh=T3xXGNja0aLmlP+yhOtmezggporaiAuZ867fVt1ccOQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FGFWM0mel5kg1ya+zuIb7T4I68uMzfl37mmqSjkMxZSUg8VX1ZGW131wun3ZizSYspWqJehNw8KzYWQji/HWzMOpkwcQn5577m8NhnKWqqTOI2GbmApeK9OkUq9gmvd5mwHuqYjXbTgVO5FB6jMvc4g6WZY273eKTtq//rs0CoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=t4yMwhv4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5715C113CC;
	Wed,  1 May 2024 13:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714571006;
	bh=T3xXGNja0aLmlP+yhOtmezggporaiAuZ867fVt1ccOQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=t4yMwhv4ynlUnwArcfoOt27yM6QoX0mMnbw9+3YcPGams2ObPiIrjnLiiLgnPiFQG
	 BAecQ3al97jvjN5ZcVYk7AAR2NTzUZ2FeueHExJnH3l88FFPrKzmAfAlF9GQ4J+3sj
	 9EMy+JlHuqx4F24Q2mk5jGOX1Lr+XV97nGtawc0tH5WSOU7bs3XRuaoF7hDriVgYwD
	 m1OR+p/3x/BMnWLSJV8BVOFUaTqgGe76/GsCMl7blpbJkLKrD7FIDl1YtzYZPtvGp8
	 QU/F1IxBYjj3WVLN2yQjBriDBzPjdF8IebsQT/GF7ke/vsd4leDEbtkZ8uraLNsoVF
	 p7RGjuhzxu70Q==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Jonathan Corbet <corbet@lwn.net>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>, 
 Bagas Sanjaya <bagasdotme@gmail.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 linux-sound@vger.kernel.org, linux-doc@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240426-dapm-docs-v2-0-87b07547eb5b@bootlin.com>
References: <20240426-dapm-docs-v2-0-87b07547eb5b@bootlin.com>
Subject: Re: (subset) [PATCH v2 00/12] ASoC: doc: dapm: various
 improvements
Message-Id: <171457100410.1888704.9831804306512477494.b4-ty@kernel.org>
Date: Wed, 01 May 2024 22:43:24 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 26 Apr 2024 18:56:33 +0200, Luca Ceresoli wrote:
> This series applies various improvements to the DAPM documentation: a
> rewrite of a few sections for clarity, style improvements and typo fixes.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[01/12] ASoC: doc: dapm: fix typos
        commit: 534e0cd89baf74c22ca55b442fb4add8d844e272
[02/12] ASoC: doc: dapm: fix struct name
        commit: eaf84bda623e0a034fe03b871addf7dc4f70dfff
[03/12] ASoC: doc: dapm: minor rewording
        commit: 610277caa77f07997857ab2e31a073d8ad7ed090
[04/12] ASoC: doc: dapm: remove dash after colon
        commit: 3233a68fcb216a2d8615862841c1fca7a940fc5c
[06/12] ASoC: doc: dapm: replace "map" with "graph"
        commit: 7d0e76107894377a14f211c85a821a53416d5ab2
[07/12] ASoC: doc: dapm: extend initial descrption
        commit: dd5f36e59134654f9fd7b39d4d66327a1a2db82d
[08/12] ASoC: doc: dapm: describe how widgets and routes are registered
        commit: 36de8c0e26793beeda1d6a7592f44b4551271469
[09/12] ASoC: doc: dapm: fix and improve section "Registering DAPM controls"
        commit: d40e82194423c9d058bdeff863373b7da9f7045b
[10/12] ASoC: doc: dapm: improve section "Codec/DSP Widget Interconnections"
        commit: 057acfb460d6792c7d3ec088f57c411fb0e4d395
[11/12] ASoC: doc: dapm: update section "DAPM Widget Events"
        commit: ce5a4f101cd0dfbda391d4f1815222d82a9d8a5a
[12/12] ASoC: doc: dapm: update event types
        commit: 4155a82f6af8068473cd66b55da56fd379835fb0

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent to Linus during
the next merge window (or sooner if it is a bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

Thanks,
Mark


