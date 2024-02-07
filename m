Return-Path: <linux-kernel+bounces-56894-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 944BB84D0F2
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 19:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22A09281E49
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Feb 2024 18:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1D2212EBF2;
	Wed,  7 Feb 2024 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DPbfB17t"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C9D12BF02;
	Wed,  7 Feb 2024 18:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707329357; cv=none; b=PlmKJSHdV+7oLfH1KqvUw/EoEYYJk6gd6WY/lrv7TFpLA+OyDa9mw6fyQhISNFSa0i82Z7Jr9YmbEQOry6jlUyv8nkGxKYpnU371uF6nxoqyJTIyum0dCYbx/P8In5e5cZ/PTfwBkvSQCqnJN9Ylydq6sO4G1GF2J3UT6nYyM1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707329357; c=relaxed/simple;
	bh=Iw2OhQ4vRHvcS/H+wxcRu+ckAc5Xk3cTSuO2GCfdZWg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=Z01vVO5U9a0IrdGDHwkbnbrsYt992LeuBim2pYZhWock9I1+LdsWA2p6Db+The5nesAECTBljAYGwtCgwtag7f4ZkukCgV4bThq/t1/7Vvvzjq6dbid8zDJgyvUtwFg6Wz0DTHraKYpl2+oYVPp79/1QNdsnReTa/ZseMDHKHpE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DPbfB17t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95800C433C7;
	Wed,  7 Feb 2024 18:09:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707329356;
	bh=Iw2OhQ4vRHvcS/H+wxcRu+ckAc5Xk3cTSuO2GCfdZWg=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=DPbfB17t7tMrqCOZ/LA3JzUSyjBvuCWHEgm1GoG6ueWeX/R/M/OP9/DOyEN8sUyLu
	 B/UimGa2VdwUiCWX01e3jtyn2sHU0SPHM8ZkdkCES2IOClKb6ww84+ZUX6G9l8ClkQ
	 VXAzFKfAAJye0kzAJ4vlKu9WQUPKmv2uZDUGC25dVlufbqWkOuZ43adojlOWpnirQe
	 Q8PdLCLnNaIzeTlTyOCODFk4Byp9hKLI1iMmOn3PEaCNOqCwOdkkwUJmceo6I48TeK
	 LQtO4716Rg7Ybk3Q7nn2Mi5xj/JZHsme22VoakEineyDAwRK3qQMcg9ScJZ8NO/5u7
	 jc63jc9rimLkw==
From: Mark Brown <broonie@kernel.org>
To: claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, 
 nicolas.ferre@microchip.com, alexandre.belloni@bootlin.com, 
 alsa-devel@alsa-project.org, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Dharma Balasubiramani <dharma.b@microchip.com>
Cc: hari.prasathge@microchip.com
In-Reply-To: <20240207094144.195397-1-dharma.b@microchip.com>
References: <20240207094144.195397-1-dharma.b@microchip.com>
Subject: Re: [PATCH] ASoC: dt-bindings: atmel,asoc-wm8904: Convert to
 json-schema
Message-Id: <170732935198.1089483.14612569471427120930.b4-ty@kernel.org>
Date: Wed, 07 Feb 2024 18:09:11 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-0438c

On Wed, 07 Feb 2024 15:11:44 +0530, Dharma Balasubiramani wrote:
> Convert atmel,asoc-wm8904 devicetree binding to json-schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: atmel,asoc-wm8904: Convert to json-schema
      commit: 565abf586f3554c94c81027b1f0af1f6a6beea1b

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


