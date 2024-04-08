Return-Path: <linux-kernel+bounces-134798-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D97889B713
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE72BB219E4
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFB179F0;
	Mon,  8 Apr 2024 05:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YHWA9sh8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B92D16FB9;
	Mon,  8 Apr 2024 05:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712553026; cv=none; b=HMluDdIXoph5B7jkacHkv6z1L0+Q9IHJbfCNS7uD6KznS+XgiMZPqn/ZxPCSaAhlcsxMowhaXBuOthVrx2RZCH4ZM1Aajcjd7At9DQuFxBczoBgt7wyDtmIzz4adXT7d31008Ox+XHTrmm3Suu/t5Cjr4tozlFjZfP3NPOMlkhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712553026; c=relaxed/simple;
	bh=jJxoNyvfc0B15/6PXUf+qqfQN3TZK/hFvq7v7R3dbPE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=u+3zj10+qmaDFc+Y/TogKbolEeOAiGWjQsSbm08ymHpMxYDykmhgMcy+cUlyJRb3I/7MDoxYA6lbxuVegImo9a0tRYR7law7MMhB/N6EBtHTr5WKbumR7izFN2TILicSwGHUbt8M19MbeeJeNgVwvKoE2hNie+HHHe4alze/VX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YHWA9sh8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B3EEC433C7;
	Mon,  8 Apr 2024 05:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712553026;
	bh=jJxoNyvfc0B15/6PXUf+qqfQN3TZK/hFvq7v7R3dbPE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YHWA9sh8jNWSaEws5H41QH3nCyW4hYlgCJOw6v9FJMaZzfCo4fUQ5gUEyzPBcf1/R
	 IU9iQJydn30kCtYku6a+zCvnWpyZAZccKa+TfKxzuDk1QUS+uqA8AXfYFpq+NFZoSO
	 33Z14JjuLOTF75JiB9sfEQ80fpQX/KHAIGl3YdI1R0U3b6oZsVLA/a49XPQlDeMClh
	 TYhFVaXIlzdiV76qnCesEV52BA7BKM1Om1qH7pfo4cePSOPK2sNkxvaNEZF4MtGHRJ
	 J68ejrGYUCUthE4XVC7C8T007x3XUc2WHh/dZBmmzt4jJdcjcgvWOWF0DIpnUaT/VV
	 QXO1Y2YjlCF4g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4CDE9D2D0FD;
	Mon,  8 Apr 2024 05:10:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 1/1] platform/chrome: cros_hps_i2c: Replace deprecated
 UNIVERSAL_DEV_PM_OPS()
From: patchwork-bot+chrome-platform@kernel.org
Message-Id: 
 <171255302631.29950.3498240383277651347.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 05:10:26 +0000
References: <20240403105502.558351-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240403105502.558351-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 dcallagh@chromium.org, skyostil@chromium.org, bleung@chromium.org,
 tzungbi@kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-next)
by Tzung-Bi Shih <tzungbi@kernel.org>:

On Wed,  3 Apr 2024 13:55:02 +0300 you wrote:
> The UNIVERSAL_DEV_PM_OPS() macro is deprecated. Replace it.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/platform/chrome/cros_hps_i2c.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Here is the summary with links:
  - [v1,1/1] platform/chrome: cros_hps_i2c: Replace deprecated UNIVERSAL_DEV_PM_OPS()
    https://git.kernel.org/chrome-platform/c/1af853cb6e4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



