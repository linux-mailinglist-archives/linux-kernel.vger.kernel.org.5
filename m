Return-Path: <linux-kernel+bounces-34140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 13C1F837441
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 21:45:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3991F1C28BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 20:45:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00D6A47A5C;
	Mon, 22 Jan 2024 20:44:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="o+x75yHj"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450C9482D8;
	Mon, 22 Jan 2024 20:44:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705956267; cv=none; b=DaIXiyvH+v/Ms63Z2koJdF03yelcoMKcbr+nk6cuelEdqG/XZqZmAOhvU9FlP+dUefG8HofwFOy+BR1p/XGTdtMuHJ7zDabRePeIB3af4pekgQY7ACFrLepiZkyMO3G54T4t/nfKx+PjKhGJzl2U11jN0ptxU7oAOH3wADkOoAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705956267; c=relaxed/simple;
	bh=sOJcyfOm6rvDelLgbGyKsvv4g+uQMAxj3f4722CTJoM=;
	h=From:To:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=u3hXJiK9Vu5NQzAitMppmF5rnlVt0fPdTMl8J4u+w9azvrX0A3pWf8/IBhgop9Pgb900y2NCpvzW1YWCV/H6GrvUfo9cIJlcNjfeXtCeU6YoS+3wy28Cr+aZ/pV3049GgOviq88W025NBGTvgSbFBn/gD4kktaYMoeWrJN15Gxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=o+x75yHj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C42C43390;
	Mon, 22 Jan 2024 20:44:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705956266;
	bh=sOJcyfOm6rvDelLgbGyKsvv4g+uQMAxj3f4722CTJoM=;
	h=From:To:In-Reply-To:References:Subject:Date:From;
	b=o+x75yHjhYoZYA6elBvkde4MD0PRCdNvnq/SwI4JnjG72QPCOgLvUE7AdnFM4/m1e
	 JPnz6NxMtzBGp7rxp7TeqkJGfP4dlPFFQEvA4/bOK6VpUk8wCrSVciirq1mTMxoxhx
	 B+IvVCE8lSioryBf2ZV2N4YwTNg6QAvVNZXIsOk+OCj+sJGN1bqN7gagNyg5MhKlGd
	 ApqfXIaOsNsxBSa0Ts9HBIRGV9lSjO/QaLcMGQ79wYZGTC9nv9+Yp6Mr0cp0HXxneE
	 FXyhACymnFqHDmLpcQ/sQA7y61Z68VqC6W5gSbc+Edxf/Bd97CDcmfWicA1ONn0LkW
	 n3POBV4+bMslg==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Jaroslav Kysela <perex@perex.cz>, 
 Takashi Iwai <tiwai@suse.com>, linux-sound@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20240117160144.1305127-1-krzysztof.kozlowski@linaro.org>
References: <20240117160144.1305127-1-krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH] ASoC: allow up to eight CPU/codec DAIs
Message-Id: <170595626519.145475.15163514397565186066.b4-ty@kernel.org>
Date: Mon, 22 Jan 2024 20:44:25 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-5c066

On Wed, 17 Jan 2024 17:01:44 +0100, Krzysztof Kozlowski wrote:
> Sound card on Qualcomm X1E80100 CRD board will use eight DAIs in one DAI
> link, so increase the limit.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: allow up to eight CPU/codec DAIs
      commit: 70b4769956651e986591dd94b3ff9649122b1513

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


