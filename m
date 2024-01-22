Return-Path: <linux-kernel+bounces-34210-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D5FC28375A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 22:54:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D1B2882A0
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1325E482E9;
	Mon, 22 Jan 2024 21:54:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mFMxYfJE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57E3E3EA88;
	Mon, 22 Jan 2024 21:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705960453; cv=none; b=P/dnGyfL/xUzYANApJL/6KHSd/cRw31U1b/aUPGh+PF29VoqviYVubowvEezqqvDucbtVwxybaeoM6LZq5i17hFL5ib/MXRVp+urxsPB0bAPgMAb5ypeD2UlyNTq2p7Ba5qSr6j/nTdjuM16z80u11KrpcZ3ZsaeBai1s2j/8Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705960453; c=relaxed/simple;
	bh=BRieAgJwMkt/iTyWFI9nEq4QZqxLiCR6cBex9CyHfOQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=aZ668aeozLJC3Ci//xDgEgSJ5lSX8P2L4YkH12TcLQhZZLl9rIOpfCwEAUM8MewaVeSY0Rf6Q7Zt8b+BzCIqdFN4HZ+2iXXacN5oE1Dgfsu0Llv9irOTZPFIZFshftr/5FdFv2ozE8cc+FzR7eYb0ARpiW3Km6j3y88i7cCO+dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mFMxYfJE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B2FAC433C7;
	Mon, 22 Jan 2024 21:54:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705960452;
	bh=BRieAgJwMkt/iTyWFI9nEq4QZqxLiCR6cBex9CyHfOQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=mFMxYfJELjYH5Dlj+tft8baT0xvFrRJVwfz0ukzOX3pvbKCTV28CI3Ol5niEYon+A
	 gKyGCuhxwmoHa/Jtmb9+Bns5pfwI4YHmHwSy6K0IeeQaGDqAXo2Mv7oLdgBl7hGYjH
	 fqfeWZxyk0Tg9H4kPNFc3NOiP9rUww4f1R2zURmeEmR98yufIF+/nB6bHIhrwZfYuo
	 0yQ9N4FwpENh0C3wQ51rm2/aE2bCcpd8Pv1flgmhz3RPtenVJ1Gl2Yo5aNVYYlECIo
	 12nhCRM+cpkGCVnFaRIALO3DJsenrFTM6SrSK1/GRNncxXbD3p4FTLR3VkHP73eAiW
	 cau/apoTscqUw==
From: Mark Brown <broonie@kernel.org>
To: Johan Hovold <johan+linaro@kernel.org>
Cc: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>, 
 Banajit Goswami <bgoswami@quicinc.com>, Liam Girdwood <lgirdwood@gmail.com>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240119112420.7446-1-johan+linaro@kernel.org>
References: <20240119112420.7446-1-johan+linaro@kernel.org>
Subject: Re: [PATCH v4 0/4] ASoC: qcom: volume fixes and codec cleanups
Message-Id: <170596045016.161959.16318695944363636291.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 21:54:10 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Fri, 19 Jan 2024 12:24:16 +0100, Johan Hovold wrote:
> To reduce the risk of speaker damage the PA gain needs to be limited on
> machines like the Lenovo Thinkpad X13s until we have active speaker
> protection in place.
> 
> Limit the gain to the current default setting provided by the UCM
> configuration which most user have so far been using (due to a bug in
> the configuration files which prevented hardware volume control [1]).
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/4] ASoC: codecs: wsa883x: fix PA volume control
      (no commit info)
[2/4] ASoC: qcom: sc8280xp: limit speaker volumes
      commit: c481016bb4f8a9c059c39ac06e7b65e233a61f6a
[3/4] ASoC: codecs: lpass-wsa-macro: fix compander volume hack
      (no commit info)
[4/4] ASoC: codecs: wcd9335: drop unused gain hack remnant
      (no commit info)

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


