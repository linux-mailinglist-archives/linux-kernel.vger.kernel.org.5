Return-Path: <linux-kernel+bounces-165339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3495C8B8B6B
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 15:43:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E339D283826
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 13:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBD0212F390;
	Wed,  1 May 2024 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qh8W1fcN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F83412DDBC
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 13:43:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714571003; cv=none; b=UWNFodll6ya5Pyk8p5yk1z4+27l7f/a9yb6iCdgpvJgKzw1zdXgWsfVvTHdUE75LH4cPv9DQmQwRBYrmL2GT7DSQFN6bav/7VG10OUvxNJFzfWkNWt17/YqEj4GfvguHSxfwATj4S2KLPdtb3C0RSPIOdXSvADxBWjOBZJOty4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714571003; c=relaxed/simple;
	bh=O6VvEOG1FYYxiSATtFdjPAV7d0igftAeyhbDcL2/oH0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=r+pl7hJTR9kzbHgD6zJ287m+E223oGPYoJCqoXFm+SobMNxzhgO4A+BG1RLMHB1KQjgXHAYZ18/mVFSDnotB/v254MaSXKjw4b6iFf4gzPgelHM4wAWvGmNdqBb/5+dyEZ/mBDAiGIDHOSGi+U0Kfy7UzhAB8Y1AcMnoYX5DZiU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qh8W1fcN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60D4C113CC;
	Wed,  1 May 2024 13:43:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714571002;
	bh=O6VvEOG1FYYxiSATtFdjPAV7d0igftAeyhbDcL2/oH0=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=qh8W1fcNhbalI3y+nG4MQoEDqYZzv56KKCouGMwdNtQQ6ImtLhumgFcinolCuOUJ3
	 dcwtvnQW4NvKJ0UwzADP0Z+EjWW0JZG1qkdgE8wsDY4ZxesO6g5ilAgOaCXBLjRCx7
	 x8XY6qza8LaQndjO8KrQVKvVMaYWi+StgB6Lwb/HZoM4UNDclvuOoM8f3SJM3Yryhe
	 i6FWm4V1uYMTgTsn9jgg8JkZuZg8qcf7Y9NwtUaUAvlDbAiUC60Bxx0xPRad7Wy4gn
	 MLEk2n+A5XwxvsRgivZVy4OMGldX2CCvQ7usaj0zPkPRDBal6g1ZLWgVSp6yV7sG6/
	 S1byDemKE4IKw==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Jerome Brunet <jbrunet@baylibre.com>
Cc: alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org, 
 linux-amlogic@lists.infradead.org
In-Reply-To: <20240426152946.3078805-1-jbrunet@baylibre.com>
References: <20240426152946.3078805-1-jbrunet@baylibre.com>
Subject: Re: [PATCH 0/4] ASoC: meson: tdm fixes
Message-Id: <171457100123.1888704.3713341677013104535.b4-ty@kernel.org>
Date: Wed, 01 May 2024 22:43:21 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Fri, 26 Apr 2024 17:29:37 +0200, Jerome Brunet wrote:
> This patchset fixes 2 problems on TDM which both find a solution
> by properly implementing the .trigger() callback for the TDM backend.
> 
> ATM, enabling the TDM formatters is done by the .prepare() callback
> because handling the formatter is slow due to necessary calls to CCF.
> 
> The first problem affects the TDMIN. Because .prepare() is called on DPCM
> backend first, the formatter are started before the FIFOs and this may
> cause a random channel shifts if the TDMIN use multiple lanes with more
> than 2 slots per lanes. Using trigger() allows to set the FE/BE order,
> solving the problem.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: meson: axg-fifo: use threaded irq to check periods
      commit: b11d26660dff8d7430892008616452dc8e5fb0f3
[2/4] ASoC: meson: axg-card: make links nonatomic
      commit: dcba52ace7d4c12e2c8c273eff55ea03a84c8baf
[3/4] ASoC: meson: axg-tdm-interface: manage formatters in trigger
      commit: f949ed458ad15a00d41b37c745ebadaef171aaae
[4/4] ASoC: meson: axg-tdm: add continuous clock support
      commit: a5a89037d080e0870d7517c61f8b2123d58ab33b

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


