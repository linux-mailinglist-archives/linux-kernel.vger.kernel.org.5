Return-Path: <linux-kernel+bounces-73879-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EF6DF85CCEE
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 01:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A77E9285E57
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 00:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94345232;
	Wed, 21 Feb 2024 00:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VpzPSUsp"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C73F46A4
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 00:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708476526; cv=none; b=BgSFt+bpiqu/wEuS+U8L3m12PyL5Fd4D2S3AtP50ffQHNicC9OmomVP1zmhTYQ+U1aCFfR/JQk1FkVGCEYxzjgtghve+kHPhD992Iy4U4gcS6fxvdcXFF9R0pqUNiHBwOn1hchJwGUDoKRXHinemu0OVbs8OLRvd5oGVDDIH5nU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708476526; c=relaxed/simple;
	bh=oM+KCx3nQTgWbrIql5fYXL5IEUhqztgZwF6GnB3LzlQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=PBQ5MMmh3fC2bv0XiW8JtRHKRw9JgZVHpiYSTd9BAlcvA3GvyeibBxc7HTiXRzy7wHwDbhU/NaEoXqaBAVZMbhrxluO23gfq+i6vGsPKveeWpVCVHxnQJMGMoV3aYkx5yPRYwtf4WMuZENu33XaWzk1bXMC4H0Y01/XvSYtRWug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VpzPSUsp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7CA6C43390;
	Wed, 21 Feb 2024 00:48:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708476525;
	bh=oM+KCx3nQTgWbrIql5fYXL5IEUhqztgZwF6GnB3LzlQ=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=VpzPSUspBXQF+y/drt5tsedNFHJHbiuam7DRPZ5IpGByGPxU0CTkDqAIX1q/gg9rp
	 41c/yOm0OSGXMOOTqe9pPkItKnnp8aeY9pvbndXJqjZq6N4SPfE2J1wPPxnHx9aeQD
	 SBMWkKQ69Z3llsBMle/6YDh3lDKUbpL/KuX1lwy6W5QCW/LBOt4FlrgeWZCwiwZZon
	 60+Yq58DnmrV5qtcu2d2QTmwpyuc1I+Mtt4zoar8gvjGL5dUHpFkXkl8lfK6oCgE7L
	 FsNBCR4oMlblSdU9rxtWcTxGPpBBYot1EfceI786XcwRljsdejVeeaa20vIRNat8Dd
	 UG8JiaI1jlkIA==
From: Mark Brown <broonie@kernel.org>
To: Vitaly Rodionov <vitalyr@opensource.cirrus.com>
Cc: Jaroslav Kysela <perex@perex.cz>, alsa-devel@alsa-project.org, 
 patches@opensource.cirrus.com, linux-kernel@vger.kernel.org
In-Reply-To: <20240216101157.23176-1-vitalyr@opensource.cirrus.com>
References: <20240216101157.23176-1-vitalyr@opensource.cirrus.com>
Subject: Re: [PATCH] ASoC: cs42l42: Remove redundant delays in suspend().
Message-Id: <170847652448.70487.17999741329629264318.b4-ty@kernel.org>
Date: Wed, 21 Feb 2024 00:48:44 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13-dev-a684c

On Fri, 16 Feb 2024 10:11:57 +0000, Vitaly Rodionov wrote:
> This patch will remove redundant delay and minimise
> total suspend() function call time.
> 
> 

Applied to

   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next

Thanks!

[1/1] ASoC: cs42l42: Remove redundant delays in suspend().
      commit: 3b4ec34602c562fa8fa59dd8545ac7f3cdfc235e

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


