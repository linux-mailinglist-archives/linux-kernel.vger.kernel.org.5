Return-Path: <linux-kernel+bounces-117626-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56F4D88AD76
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 19:15:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12F4C364262
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 18:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2A1139CEB;
	Mon, 25 Mar 2024 17:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T8+1bEu+"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06D952F81;
	Mon, 25 Mar 2024 17:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711388673; cv=none; b=USWUI3rhnGZ39jSkFCz8c4IjtIVQgsi+SDgUvcfurOtQCm91ip1RqpF58jpy5Pr+D4dYK1hJTPzWFbpWbyP8iCgTq+ck4wSiBGhZ+h5T0LIo1+a4wKzzff1mdzydrwHziIFYbMnFeTq+3Tl8HPLdasj1jU5bXojHGXC+JJY2MsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711388673; c=relaxed/simple;
	bh=n/QJSI13BDNfp/32Gd7OEuyh7zzvsg1Bl0xLdfK9qgI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=JvfFhG0yZsuojcA00M6A01NyUNCwBr98a6w+BFxFnW0BKwvC55JtUVnLIsS68JsSvnApOPUl3tC0A7OU3cvj89/AGDoLMcB5F9+X4pIKakmjomc/c6kupv2vcNzcAHpwV2s1sR0U7JAA1hRCnQK1Ky1k1auafiqFrGAWgf3y49s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T8+1bEu+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 029A7C433C7;
	Mon, 25 Mar 2024 17:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711388673;
	bh=n/QJSI13BDNfp/32Gd7OEuyh7zzvsg1Bl0xLdfK9qgI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=T8+1bEu+06XWJe9QTfaiQBmIiSxysmgSF5d+Pzqb/K6AkfsKHn/flrV4/Nd9qNe47
	 d9efNeTFf6QKUDmWU15xhIBvkmxJizQiS9ukdk3bCSAS5uzN1C+VGScHcrpXSYjUk+
	 0ZgZQhbDkwNXLQyOPLc7kdXjix+YSzvVJD3JhTPS2W+W5Fb0cquH/kmO76Xa8hj06g
	 shDJ7tJ1lNNhDb/1oVlYCP3fdGc7C9y5mxse6AmZfe9vm14rgRlUAfIiX1P86hbYdv
	 lyxhONk9l88syKfNW3QY7NpNsp+mU98LS1oE5mJhkg5d8Pea7BxMZVXEHDiki/cJWr
	 +8oitCqjbCr4Q==
From: Mark Brown <broonie@kernel.org>
To: ping.bai@nxp.com, lgirdwood@gmail.com, robh+dt@kernel.org, 
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, shawnguo@kernel.org, 
 s.hauer@pengutronix.de, Joy Zou <joy.zou@nxp.com>
Cc: kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com, 
 devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20230531065724.3671795-1-joy.zou@nxp.com>
References: <20230531065724.3671795-1-joy.zou@nxp.com>
Subject: Re: (subset) [PATCH v1 0/3] add pmic pca9451a support
Message-Id: <171138867074.327260.17135552699637079146.b4-ty@kernel.org>
Date: Mon, 25 Mar 2024 17:44:30 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Wed, 31 May 2023 14:57:21 +0800, Joy Zou wrote:
> The patchset supports pmic pca9451a.
> For the details, please check the patch commit log.
> 
> Joy Zou (3):
>   dt-bindings: regulator: pca9450: add pca9451a support
>   regulator: pca9450: add pca9451a support
>   arm64: dts: imx93-11x11-evk: add pca9451a support
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/3] dt-bindings: regulator: pca9450: add pca9451a support
      (no commit info)
[2/3] regulator: pca9450: add pca9451a support
      commit: 5edeb7d312628961046eec9b26a7e72f44baf846

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


