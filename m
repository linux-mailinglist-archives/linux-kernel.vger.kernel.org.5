Return-Path: <linux-kernel+bounces-82140-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F285C867FD7
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 19:30:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E4F81F2468E
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 18:30:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E96212F5A2;
	Mon, 26 Feb 2024 18:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BkZX6H9C"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2E941DFCD;
	Mon, 26 Feb 2024 18:30:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708972218; cv=none; b=oIq++adW3BhwAp0m1f6UAGS8//dluWF0dKLFbUTwxgfoc38hdDkGRnD6Seo0qkrFiTVje5McekqzDTU54CezuqcSIUPbwwfblXnjYIxfuGyjevntfVTdSnNWyfVLA80TP5BdaPSyhy6/UwCCZF4emMNy5OfWOM4q7HZQBrvH+HU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708972218; c=relaxed/simple;
	bh=RTq/X7hmBPr7XVhCcE4AXU8PreuCVmB4I7EXfiacCEk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=NNFCC2Z0NtmjhZSeN6IxlnXP6VQ71wEkR85IcVkPledZx8sTpSUbrkWmmc3Te/S/Ca/ys3VFR99HytJdihV/Mw9tC6PpF2K1DSnX/8Q448grO2qU5BmCvxYRPqcQnm3+oN31h+TveYOkbH/2BiY/Ky+rQaGyW5JNDwCq9o+NaQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BkZX6H9C; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 160C9C433C7;
	Mon, 26 Feb 2024 18:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708972218;
	bh=RTq/X7hmBPr7XVhCcE4AXU8PreuCVmB4I7EXfiacCEk=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=BkZX6H9COAdUyzqNU7wq+09GE89JOraBwyZUmf6ElzQZhErePOc9qxUGdHsMbu+Uq
	 SC5VEEbdcuxBWz+wdPVma0k8+C4fHcOagf8SU2GRg+IdcCFbsM2jE+AoRvFayvtZBA
	 SbzluVDFG/n8dLl698KaskYP5Qlbln7xZGRqpXXQuNqxpNnC8IaGCnkfAjASTGBn6M
	 R2//Umu+4BWQ+hG/uLbL5aoGKPm4LW0kY23pFxBvB6aI/Gy3fBbPy1sUnAoXumiqgb
	 x22wbCBWmTRNaeV9SH96T2k2wpj6rWFJlDCEb85mUePPnkRI40BuNBL4ePCdoTK0+f
	 685FFiAUib6mA==
From: Mark Brown <broonie@kernel.org>
To: Liam Girdwood <lgirdwood@gmail.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>, Rob Herring <robh@kernel.org>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20240224000752.3830665-1-robh@kernel.org>
References: <20240224000752.3830665-1-robh@kernel.org>
Subject: Re: [PATCH] regulators: dt-bindings: gpio-regulator: Fix
 "gpios-states" and "states" array bounds
Message-Id: <170897221675.89041.15993993935283518276.b4-ty@kernel.org>
Date: Mon, 26 Feb 2024 18:30:16 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 23 Feb 2024 17:07:51 -0700, Rob Herring wrote:
> The minimum number of array entries for "gpios-states" was not not
> specified, so the the default is the same as the max (8).
> 
> The minimum is also missing from "states", and the maximum is also wrong
> as it should be 2^(# of GPIO lines). Since there can be 1 to 8 GPIOs,
> the "states" range should be 2 to 256.
> 
> [...]

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git for-next

Thanks!

[1/1] regulators: dt-bindings: gpio-regulator: Fix "gpios-states" and "states" array bounds
      commit: efe9a6da2292e68d45cd9e0eb1c31b85841d0c2a

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


