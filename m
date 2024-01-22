Return-Path: <linux-kernel+bounces-34141-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 832BF837448
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F391F29206
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:45:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0ABC47A6C;
	Mon, 22 Jan 2024 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dRNP+FyK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22DCD487A0;
	Mon, 22 Jan 2024 20:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956270; cv=none; b=DejQSvA0MIAOwMTFHKuQekpnKfGh1nFapg9dpNh43WOnocD5gKxcfFbH5V/1WhOxTs6ksHD2bHKYBTxGSt2EzQwIhl+G/xAzdxy5ehKG/0gRkxpywL4FTRjP53XyO/0eXUFtFJ6QI64Broor5G82KJAglAzzaMD81iMMSHHqhAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956270; c=relaxed/simple;
	bh=pcmQCWSJ7Hn4aUv4ouaZQqEO5FRMjYPHna+YeTWwauw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kgxm1935dpnefnLTCeqeUnpA6g8/5T13W1l/xFBM803dP4A9qv57UjgR1+3iTIZ0KCQp9j9KQSdpzqSLi6+7RtXEToXWqgQgSkqoYkzdZlzUtNJH+q5ZtJ2BqUBLsuoLVbcBQQe2kuEX7bVDGcI9z9bODxZ4yPxqe2BljVs+4ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dRNP+FyK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 291FFC43394;
	Mon, 22 Jan 2024 20:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956270;
	bh=pcmQCWSJ7Hn4aUv4ouaZQqEO5FRMjYPHna+YeTWwauw=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=dRNP+FyKx5WE1dzaEAME0NJ501LGgyxqatdBMof/xz6qz0Bv93Y4X7rpyIoPpunhx
	 PlghgOit+OxQk1yHyVA4JCHBHXeLsbw7AM/sz+IastQRnLNCBZtyX0JUeeFRiVyG6l
	 K2vL6ykE7/V1W86ODRQolCf03EhzMceejNC6NkcqxgsV8udHkdeWGzYrRKvHx2owXm
	 vsXV/HUCcpmAMMkh4O3hRs3l8R2ZScEkz+eNbNmLE3+IQTHbYJTDoyPAjO9kwco5w3
	 zMTC0XnpUQV1CKMT6wVeByfexCiFNlqJgrRO3BL1sje3qHAy1zix+uJS0kZ31Ouqgl
	 JdmVyEONL6PNA==
From: Mark Brown <broonie@kernel.org>
To: alsa-devel@alsa-project.org, 
 Venkata Prasad Potturu <venkataprasad.potturu@amd.com>
Cc: Vijendar.Mukunda@amd.com, Basavaraj.Hiregoudar@amd.com, 
 Sunil-kumar.Dommati@amd.com, syed.sabakareem@amd.com, 
 Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, Syed Saba Kareem <Syed.SabaKareem@amd.com>, 
 Alper Nebi Yasak <alpernebiyasak@gmail.com>, 
 Marian Postevca <posteuca@mutex.one>, 
 Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>, 
 "open list:SOUND - SOC LAYER / DYNAMIC AUDIO POWER MANAGEM..." <linux-sound@vger.kernel.org>, 
 open list <linux-kernel@vger.kernel.org>
In-Reply-To: <20240118143023.1903984-1-venkataprasad.potturu@amd.com>
References: <20240118143023.1903984-1-venkataprasad.potturu@amd.com>
Subject: Re: [PATCH 1/3] ASoC: amd: acp: Enable rt5682s clocks in acp slave
 mode
Message-Id: <170595626688.145475.10620006643082770477.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 20:44:26 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Thu, 18 Jan 2024 20:00:19 +0530, Venkata Prasad Potturu wrote:
> Set and enable rt5682s codec bclk and lrclk rates when
> acp is in slave mode.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/3] ASoC: amd: acp: Enable rt5682s clocks in acp slave mode
      commit: 1d565de8d53cfa823576abac84e82ab1561f04eb
[2/3] ASoC: amd: acp: Update platform name for different boards
      commit: 4bae2029ffcccfbefb8f31563556494464e7bf2d
[3/3] ASoC: amd: acp: Add check for cpu dai link initialization
      commit: 6cc2aa9a75f2397d42b78d4c159bc06722183c78

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


