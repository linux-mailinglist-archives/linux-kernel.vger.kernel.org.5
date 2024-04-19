Return-Path: <linux-kernel+bounces-151281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 789858AAC5D
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 12:04:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2CB931F21D93
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 10:04:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B3A67E567;
	Fri, 19 Apr 2024 10:03:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YOktfFrN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4086B7D416;
	Fri, 19 Apr 2024 10:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713521023; cv=none; b=neeNrGlgsfdYkTna+F8v5AV8FNEwz/inpzZKpCDIrkqudoSA3PJJ0v9wfrXg1zbvMVEknlnuuLokPO6M8YDbEstl/O/pvHAuxGNXz4Y85KxQ6HX0KhX7cBWkwJVuRqqFZlLFQdfJx4g1bjChs6lpYMIEdPrM3zb6WYDn81wxiOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713521023; c=relaxed/simple;
	bh=n7OH67vOnUXT5E0+NaPP78ro9DgTG2qSCSXMWSem9jY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=kqVL63vWsIxFi2C+xV7YZUBHArJGR8em3CSmZmdt/f9VaxcwdMA2Mbs8JBuWkyeTC0X6xHoH2gwe4/P9b3GulwDD2M8vYkNdi29PzfNeonRVkxcLRjT+7pLcwwDKhnvocxI/aOgILhZisfTPagTd7N9X89o7aqwKphCXp0DxBwY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YOktfFrN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47D28C116B1;
	Fri, 19 Apr 2024 10:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713521022;
	bh=n7OH67vOnUXT5E0+NaPP78ro9DgTG2qSCSXMWSem9jY=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=YOktfFrNflfjaUdNMGWq/tg+BH5si9SBuwqCBudQsIk6tMeJFYAyibAjYpFRZbL9v
	 QMQ9rpTYoW/+hQsqvPenWVvfaddwu6UHyjEpumpPOROBv0aBY9Bg9c1LAYQJTOATBu
	 LiayzcykMUo/eMMh+QTCec9QZLXjhXpE9UZ0uCdtV0aujGM01CkKv/PHdlx19r4gGH
	 5iwVowdHMsZraL78IKkSq1a1bXW4QTSJeLCBsfLsdlpQo1hqEAFaEAl4Oe6TcYyR6I
	 ngmV2XhEusPwg30t1ue1FgWwJSH84e/Edqox2CeTGqwKZIQiN7Ogf4046dvJuRki+s
	 3vqkz4QJ0QtvQ==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Mohammad Shehar Yaar Tausif <sheharyaar48@gmail.com>
Cc: Thierry Reding <treding@nvidia.com>, linux-sound@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-tegra@vger.kernel.org, 
 linux-kernel@vger.kernel.org
In-Reply-To: <20240418163326.58365-1-sheharyaar48@gmail.com>
References: <20240418163326.58365-1-sheharyaar48@gmail.com>
Subject: Re: [PATCH] ASoC: dt-bindings: tegra20-das: Convert to schema
Message-Id: <171352101993.1723702.4818534972723783279.b4-ty@kernel.org>
Date: Fri, 19 Apr 2024 19:03:39 +0900
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14-dev

On Thu, 18 Apr 2024 22:03:24 +0530, Mohammad Shehar Yaar Tausif wrote:
> Convert NVIDIA Tegra20 DAS (Digital Audio Switch) binding to schema.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: dt-bindings: tegra20-das: Convert to schema
      commit: ed37d240d03e84d09d4d2a771fda419da4308d17

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


