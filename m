Return-Path: <linux-kernel+bounces-87409-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDB286D40D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 21:19:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E3E071F25144
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 20:19:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF6231428EA;
	Thu, 29 Feb 2024 20:19:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NqP4zofa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE4B13F450;
	Thu, 29 Feb 2024 20:19:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709237967; cv=none; b=g8H98RrDVXGnC+q6UTNdcRzniKUNGC3b+Dj13Rr5pbB0bV6XcIgYPiDREjrxaVB31qygsGDbLjUN3kC/EbUUG3WPpJxm53iZx1/s+3NMW3jsVqEQaqgBYkoJmDzogOGju/eh2BuX813gWo+di72y/EuxoNdhoS98geOBA378Uoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709237967; c=relaxed/simple;
	bh=9zBP5txl3AY66w3vZ+AxPi39rTR3wOuo8SROxVv8IwU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Arki2HtXacAMglrwGpqFIWrflQ9yF2lJECKTnChclPyBa5Ovaa581XKXRFaV4q7ltNN2A+ovhdrJhcq8VWpxgwj5HrhJjhf1n+EY+P15leTtYkneD2QcsRAMYzRT2LSk4mxHDfIHcVsb7DZ2NVp65Sn0xdfIw9wacubkYy01ZSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NqP4zofa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D571C433F1;
	Thu, 29 Feb 2024 20:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709237966;
	bh=9zBP5txl3AY66w3vZ+AxPi39rTR3wOuo8SROxVv8IwU=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=NqP4zofaSs01VHe5+6/c50OhBWqXmqE+RMnB4VzuvHS5EpOJkmbZg7jlc3oyIXaef
	 jk7vK91t2UeB3TXEUi2QwZyanxTLOt0y2CHHMYrtUfEhveWaMZ5pYta9BBwDEjRO5w
	 tnS9PD4Dt1svD7aWmT8+fxG8aeNhqU/o75VNZyR/fF7Ay9U6j6GXOzOiDQt7N0fG9K
	 vcteoSZEejwuqA/cLXrrGMjPqqrsQLuBfhedN6h+o1T/yzhcSt2g2buttNkQlVB3L3
	 XnyWSbdsNUpjXquxTGCuKHLQBQrY7vJ98AFug5+7SjCirKF/vYNAwMpw2DbvAcsSs/
	 GKbgRg+Js7NnQ==
From: Mark Brown <broonie@kernel.org>
To: tiwai@suse.com, Stuart Henderson <stuarth@opensource.cirrus.com>
Cc: linux-sound@vger.kernel.org, linux-kernel@vger.kernel.org, 
 patches@opensource.cirrus.com, alsa-devel@alsa-project.org
In-Reply-To: <20240229114637.352098-1-stuarth@opensource.cirrus.com>
References: <20240229114637.352098-1-stuarth@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: madera: Fix typo in madera_set_fll_clks shift
 value
Message-Id: <170923796512.228603.8077233543350826441.b4-ty@kernel.org>
Date: Thu, 29 Feb 2024 20:19:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Thu, 29 Feb 2024 11:46:37 +0000, Stuart Henderson wrote:
> Fix a typo in the shift value used in madera_set_fll_clks.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: madera: Fix typo in madera_set_fll_clks shift value
      commit: 231bf30c107aaf935cdd02b308757d0823ff1414

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


