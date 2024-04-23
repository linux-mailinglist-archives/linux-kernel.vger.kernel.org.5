Return-Path: <linux-kernel+bounces-154770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96CAF8AE0C2
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 11:12:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 439A11F22379
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 09:12:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B76B55812B;
	Tue, 23 Apr 2024 09:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A9W7i5X9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FBC1C2BD;
	Tue, 23 Apr 2024 09:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863520; cv=none; b=XFByoA8rTSk2XmhlVi5VBg/6OX1FeyFzPMHKjmjn0JsHpRwfMQ2hR18rFtSIOWgc8oo/iYAIKs1DWre1vqsuo8nZCw9WNE0jSCHR2F4pf9ucOU4YuP+MW+uLO9WjXNbQrqGiKTCCwIosIsnKG2yXLjAgJfb4GIEcjD4kwoW1Oi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863520; c=relaxed/simple;
	bh=DbSe3xJTG/wsJlhVHw+X4gsBLue00y+X3lq4gNx/WHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=FjmGK4x8VVswNXS/jvz4Z1HVNZiAFRxs+g3wRYcpEJiGLNxqggWlYB1hFNoNdnfAsU4D9eL9vZ3wPQgVi9F727o1Cy/2hO6LY9tsN/PnqqvUZY8CyTsKOrd1snOEsmmpk1ru5cmSvWaiox+8mepK/47S2GGGgf5ffVS3Tq25+Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A9W7i5X9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D928FC116B1;
	Tue, 23 Apr 2024 09:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713863519;
	bh=DbSe3xJTG/wsJlhVHw+X4gsBLue00y+X3lq4gNx/WHw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=A9W7i5X9gGu1js6nvhetxsI4lWSZAwqYGnb5vvIH+zJNaY7Oj/6rfGTv2QAMYfRuI
	 sha9hXhYyLE3uQEUzPD6tIfxGhh67d5lvUd1UbqdH6s+BVA9rjbsJPCPuIO0aPGLAI
	 IzglsUZNfFzEXExHr/r1VttHxaPvO2ovvB46n0QVk0yMk1Hcqw1TgJ8t2ghtGR/05a
	 oMUHZB6NZNxwauuCJnnpv5rh3EJBArNqJzkWxeU1b7TYgjvOeSGYIHbk05FFbXVGg0
	 NEkPXcE3IcMUm7YPaPTAm5YFPrZvM7YVh2CeWsfXVZBhASHDsTImU9J9rRwMEB1l2p
	 oiw+QFtL4bF4w==
From: Mark Brown <broonie@kernel.org>
To: David Rhodes <drhodes@opensource.cirrus.com>, 
 Dan Carpenter <dan.carpenter@linaro.org>
Cc: James Schulman <james.schulman@cirrus.com>, 
 Richard Fitzgerald <rf@opensource.cirrus.com>, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org, 
 patches@opensource.cirrus.com, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
In-Reply-To: <1ee32bfb-6f6c-4b61-887b-6f655abbfc47@moroto.mountain>
References: <1ee32bfb-6f6c-4b61-887b-6f655abbfc47@moroto.mountain>
Subject: Re: [PATCH] ASoC: cs35l41: Delete unnecessary condition in
 cs35l41_pcm_hw_params()
Message-Id: <171386351644.1781735.13200288316295785566.b4-ty@kernel.org>
Date: Tue, 23 Apr 2024 18:11:56 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 17 Apr 2024 12:52:34 +0300, Dan Carpenter wrote:
> This code returns -EINVAL if "i" is out of bounds a few lines earlier.
> Delete this unnecessary check and pull the code in a tab.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs35l41: Delete unnecessary condition in cs35l41_pcm_hw_params()
      commit: 181d58cfe90f6a2ad53f6811d318fbc7149df8c1

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


