Return-Path: <linux-kernel+bounces-123036-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADA01890154
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 15:10:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEBDE1C2B7BF
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Mar 2024 14:10:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 215BD82880;
	Thu, 28 Mar 2024 14:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KgXmDPnb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61A09199BC;
	Thu, 28 Mar 2024 14:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711635009; cv=none; b=qIJjp0eZ2eCTg5kNsgmnOSBbeXKRfhoKb358kznHmVI11k75ZWB56zM6LDUCNPLqXQXNSj8cjrZxLaqifS1ewgHafetZ2A7puweD8ahupFIiP1EM7iVA3yrkuDV1IEjWMk8XzuvlQ9egZMiY79BQaWzrXZr83jQ20pgk+fiMs28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711635009; c=relaxed/simple;
	bh=s5KJtmAmWKUosEo3Ebm8orTCkw0ur7mQwalXQJkwqws=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=SE/8J0Oi98xYOM2OXl6aObUiMpiZHWaEZh+hTubRnhqinwFmnWm0N1wnwMSvNwqSt7phOoNgIXq7sBEfkXsm4fUVapWV4rapu3sSu7R8Sc5YfGWWNAU2JOutQiR8HjzdUIS+tvO+vebjqHC+bXzAlW/ozYi9gg2dunBRXS+4AgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KgXmDPnb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FC5C433C7;
	Thu, 28 Mar 2024 14:10:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711635009;
	bh=s5KJtmAmWKUosEo3Ebm8orTCkw0ur7mQwalXQJkwqws=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=KgXmDPnbYhsBFqt4CZWTIT4k5SobP9sTISmixgcGLymR7fSKn9rEi6yyfiRCh/bl8
	 7swApddljJ/rXxVCxbcjmH88Tq1ejmsG1Y+wxhIkv2hUTeqdDmrR5jlwCR47/C90O9
	 BxUB/JkOP9VINoJ6LMi5EgRvxw5+GeYQDIhyAiMwdXiqftFqqa9FSOTlgCNMO1IxCa
	 GhYDzA+wv17eS6F+kct8z/RsKuxp0DVwlwC0f64BHICe/yK8hT2w3PWG8SX7rtwdxA
	 Iam3ZGYhxzaH1klj2DqZXoiyvfDZPWrg3G8ZRbc4k7DZT1LGk/fvLJ4PoLFUhVRDME
	 fPHchHdgyjsjw==
From: Mark Brown <broonie@kernel.org>
To: linux-kernel@vger.kernel.org, 
 =?utf-8?q?Ond=C5=99ej_Jirman?= <megi@xff.cz>
Cc: kernel test robot <lkp@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 Chen-Yu Tsai <wens@csie.org>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Samuel Holland <samuel@sholland.org>, Rob Herring <robh@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, 
 Arnaud Ferraris <arnaud.ferraris@collabora.com>, 
 linux-sound@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-sunxi@lists.linux.dev
In-Reply-To: <20240327080542.3649840-1-megi@xff.cz>
References: <20240327080542.3649840-1-megi@xff.cz>
Subject: Re: [PATCH] ASoC: sun8i-codec: Fix build with
 CONFIG_SND_JACK_INPUT_DEV disabled
Message-Id: <171163500582.32973.4934931714654538308.b4-ty@kernel.org>
Date: Thu, 28 Mar 2024 14:10:05 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.14-dev

On Wed, 27 Mar 2024 09:05:34 +0100, Ondřej Jirman wrote:
> When CONFIG_SND_JACK_INPUT_DEV is disabled, struct snd_jack doesn't
> have 'type' field. We can't rely on this field being always present,
> so store the jack_type in the codec driver itself.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: sun8i-codec: Fix build with CONFIG_SND_JACK_INPUT_DEV disabled
      commit: 559aebe45a054a479fdbd2a3dfba999ffd73cc9d

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


