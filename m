Return-Path: <linux-kernel+bounces-94978-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6408A87477B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 05:50:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0ADA5287A38
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 04:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47EEE1BF2F;
	Thu,  7 Mar 2024 04:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lNDPk3CN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E809125D5;
	Thu,  7 Mar 2024 04:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709787028; cv=none; b=G5by6/2F05LUo9nPW6ECZNTQJA9wGcGDb0OYyM57SzYWoHpv0ndLAeo5cruAZQ5Yvii5wueeku6gPttnL+rofnIair2UxwdaY8l6DHt6qiz/bYazvu6AUWf/zzDLLCJmRImyxEVivgmTBC8VJBVUTHzzgSeclXtOlvOLovFSdq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709787028; c=relaxed/simple;
	bh=728qXOa0GYyTnUAIWAElvi6CSw0RIuoe8mh+TMh/UCY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qvKjs3/Qk0NjK27wY9C+nDbE3YMrUJ9JN5El8VQwOxUHSJZjHO6iVe24Vv+zuZTs6XgIZ7RWrHAjqbh5R8h58RTszLyZIWCIP5Zy7frq0jFIiyHqCPvq04GbEvU7THzTqOQM/tqkmj99MlAHJ4ta+y87oWvs3GXOZccjXBO9ldA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lNDPk3CN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F22E2C43394;
	Thu,  7 Mar 2024 04:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709787028;
	bh=728qXOa0GYyTnUAIWAElvi6CSw0RIuoe8mh+TMh/UCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lNDPk3CN8ykpil4lCxbnCkeYZGmkpL3zNads34pSOAmSDCJZWATS+itZ5m6f3Qtij
	 dhX6oRBQORW/moFW9eXldoZFhPB3t/I+j3dsa4h0vPbNkIq7etATkD1AVuB81Xvh9H
	 VP9Ypy/a82gi/Fdfwkn4+u2d/jfpEv+LH2J/F6DMz+eCKvfRWvhT/y2KAUu4XGO1cT
	 euRlSRGh+TbaLWwdWuqPC+APXV2tSYJcksOc9AKCS0Aq4Yhn/JjqyNqwXKmUTFs3u6
	 B0rCJ9u/iqQzuVrrBZcf29t9HWnvFZltMftLU6is/3Sm/bg0+ROMoEN5ACXAeFu/ab
	 lLVdzRHc9tXWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D352DD9A4B5;
	Thu,  7 Mar 2024 04:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v3] net: phy: qca807x: fix compilation when
 CONFIG_GPIOLIB is not set
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170978702785.12804.17752027810406406175.git-patchwork-notify@kernel.org>
Date: Thu, 07 Mar 2024 04:50:27 +0000
References: <20240305142113.795005-1-robimarko@gmail.com>
In-Reply-To: <20240305142113.795005-1-robimarko@gmail.com>
To: Robert Marko <robimarko@gmail.com>
Cc: andersson@kernel.org, konrad.dybcio@linaro.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 ansuelsmth@gmail.com, linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, lkp@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  5 Mar 2024 15:20:33 +0100 you wrote:
> Kernel bot has discovered that if CONFIG_GPIOLIB is not set compilation
> will fail.
> 
> Upon investigation the issue is that qca807x_gpio() is guarded by a
> preprocessor check but then it is called under
> if (IS_ENABLED(CONFIG_GPIOLIB)) in the probe call so the compiler will
> error out since qca807x_gpio() has not been declared if CONFIG_GPIOLIB has
> not been set.
> 
> [...]

Here is the summary with links:
  - [net-next,v3] net: phy: qca807x: fix compilation when CONFIG_GPIOLIB is not set
    https://git.kernel.org/netdev/net-next/c/1677293ed891

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



