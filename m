Return-Path: <linux-kernel+bounces-73881-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3AD7685CCF1
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:49:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE9271F232BB
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 994DD79E2;
	Wed, 21 Feb 2024 00:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GOytaUi+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF8AB748E;
	Wed, 21 Feb 2024 00:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476530; cv=none; b=NcbJZSZqwk99HmY/DINFHrjtLWkeHJMjsPKIvyQ/SkRp+upjOZiR17VX4JVlovBQVypIQNjXmyECdHY4yYGyRwP4eH5jFMJhJd3MjFUC3zCfmgnxZzOc/E+wElezpBKps3EJlNsms7mUvo/9fU7s1Y/HymVvbdNQAFUskKTKuV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476530; c=relaxed/simple;
	bh=uTEI+NTvhDwncqaMwK5syIFAygRacLmwOHW8OEB76gA=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PLyMcFkPddBuMe7XIjtNpzGC1XdB8tIulkt16cneRViV4r4C2265i+lFWAAL7Mxy8F06uEG0qg4f4/cWA/ZdN9NqxeMCKGg9HeC975FnDP5+KyQlZTseEfo9ViK2PY5StWrz3nQFYCpM2drv3DUgfYmtwIsHSBIpKT4i+m6rYj8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GOytaUi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CB59C433F1;
	Wed, 21 Feb 2024 00:48:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708476529;
	bh=uTEI+NTvhDwncqaMwK5syIFAygRacLmwOHW8OEB76gA=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=GOytaUi+F1SsYj0KYSHZwIJWUYkCBDl8jVY0sivR4va2mC3e19S7KqHjlnltlCDV4
	 bnCVjpFJgI++TkIDKO48ze34bK8mRADzsejUaJ8vi9+JXvIO1GmrALOG6x9tcGmebv
	 MEiYOxJN7UMpS1+739PGNUVhhksaVxD+BAl64p7j/pcIxaY0MLUUpUrSC3J8d1iRm3
	 K7p1LOAN8rx2EgzsuGC577OkUaJAfv66WLFScI2EBdpzYnRgh/5uXnp25pk0qXi+ge
	 utCQkiW3qQIvAVXU1I9f8rvMBaL+gSVM22Xwsnv66/a8bJ7vdx1oTd62U9M/oGVuWu
	 YHNYyyDRmwkFQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240216145448.224185-1-krzysztof.kozlowski@linaro.org>
References: <20240216145448.224185-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: Constify pointer to of_phandle_args
Message-Id: <170847652830.70487.585549185790820415.b4-ty@kernel.org>
Date: Wed, 21 Feb 2024 00:48:48 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 16 Feb 2024 15:54:48 +0100, Krzysztof Kozlowski wrote:
> Constify pointer to of_phandle_args in few function arguments, for code
> safety and self-documenting code.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: Constify pointer to of_phandle_args
      commit: cf88ab486ab7f000e612e08c517bcd490c7c6289

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


