Return-Path: <linux-kernel+bounces-134797-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97E3689B712
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 07:10:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2C0361F21F34
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Apr 2024 05:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E4479EA;
	Mon,  8 Apr 2024 05:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6IewcKo"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7066469D;
	Mon,  8 Apr 2024 05:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712553026; cv=none; b=ZrC47PTxfjcikelDILj4GwmPnUKgNBWFv125Dx85PgXy6nhVlgO3KUqwZglxXiQAzKiJbK2DuR+GdZwd1JbJTKXaS8K8HYU3yJgNboyghTIg1h1ACFWU6cFqhhqeeqCoc+D3TA3xnMabF437mBes5GVEptB7n7GzuOgWCs8PIoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712553026; c=relaxed/simple;
	bh=1kX66vyCrAByxwUXWQGaZQVW+/pupHdgUPNdbCuCzJY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LlEcB8rS7sWf93jROp2XwMrMeLX2pjLzzcMTltvTDp+o607zqhB+obKL7l1XyiE8gDAnHI4ZhV5pMLrX2GdjBl8wugBF2FyrIbdZ3ZWqhcGdLzvU5dj0G3xwZlmr0std6TP0BJp4tY5WQiSJU9/uAun56Dwn3S8CiNTSHM6Y2qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6IewcKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36132C43390;
	Mon,  8 Apr 2024 05:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712553026;
	bh=1kX66vyCrAByxwUXWQGaZQVW+/pupHdgUPNdbCuCzJY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u6IewcKo+flXSXAQBhQBXrD8N3Hagwh8hNqtACDaQjqR6hr1IG9itvqUP3tJQIKjB
	 hurb1AJSMrzrrsrH6nNdgRfq40PA4rSiS9TmHoQvzghAKNgb6ofk860bqaJ6zdEtI5
	 nuc8YUosMg+E6UJCiupFnlIqJkvS+BjrA29WCMBXy3h04qXF7pxnI3WT77ey5ULKE3
	 1VgO2N+d/RnmLsmI/VfxpuaBAgpG+jnsfQB1BQFfSXaqh314rzRgLoI70R6iiTARty
	 LFklUmq9K0j1x8nYOctNSJye/ltdFC/YahZ9GoF2phpKZH5GrgBqSNmxcyRsDVT67c
	 HCGSxx3V7tTVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2882DD7982D;
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
 <171255302616.29950.2779417612801311494.git-patchwork-notify@kernel.org>
Date: Mon, 08 Apr 2024 05:10:26 +0000
References: <20240403105502.558351-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20240403105502.558351-1-andriy.shevchenko@linux.intel.com>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
 dcallagh@chromium.org, skyostil@chromium.org, bleung@chromium.org,
 tzungbi@kernel.org

Hello:

This patch was applied to chrome-platform/linux.git (for-kernelci)
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



