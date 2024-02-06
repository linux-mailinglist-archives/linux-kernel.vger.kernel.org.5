Return-Path: <linux-kernel+bounces-54954-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A766A84B55A
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 13:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CFA41F266F9
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 12:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C15130AD5;
	Tue,  6 Feb 2024 12:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="equofCpE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A051012E1D9;
	Tue,  6 Feb 2024 12:30:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707222628; cv=none; b=r4NTdGWf8DaP6RXgT6j1PsUjRKArw+wOUiujYmwPSxxLecsqMBtSNGkjdPHhcM14a4jYpsU9wvtvErR/3o8R/VRPoh9ULAbQGtmu3WA2dlCOi/RU0/f0pp9lmUKg2c/qSe4sJ3BRKTV9LHwTMdlgQtAMN51d4LpgKVqX6M35Jr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707222628; c=relaxed/simple;
	bh=W1RbxcbJIO5Vcnrc/LNdjNQ6jCjFYklzx5UjpRAgW5s=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LXxFR//NHGTYP58cMxa3jYRrOrJe2HOTpSYASCAWu0PBoGQlNv+Vl7ltYxHtvUOw6lwePPt90LvEaPRRPlfiqWea1+kfn7T8WHwljWBiMtt2U7sLEScyi/eEbP4Zanp3NsoYoGpMw3T9TYhg70fqzgcSt0E69vnPxhVtFg/xfYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=equofCpE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30ABBC43399;
	Tue,  6 Feb 2024 12:30:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707222628;
	bh=W1RbxcbJIO5Vcnrc/LNdjNQ6jCjFYklzx5UjpRAgW5s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=equofCpEHHT0kXeJDFKFTj2fieU91ZQm/HLEzKW0zFZIIoSMLGtMrs+xLvIfR52V5
	 /U6LjIL9wsLxziuawmwPlwJVxjgWGZmog7Kk4nAXhQYmj3hCDtyz6xwUuwzypzm7cR
	 tcO2pogCNoDtvmBvRl+RBnevnsjBtSLvWCHmpmvABnyAXw8bhKMvzuW+WAI7uuoMWq
	 4CZzo3x2p4w1GYVVWIkPE4lRLPziBFqL9JmjqTT7ea9hr4qWzP+5nMGSXPqI32MUkt
	 LkgkM59djE7b7vc03OoYi0U+grWSJQsylA3Xwf1FDzfr+HkhqBkKFVZKSejDElsvC/
	 gbdNCr7hwGUJw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1B25EE2F2F9;
	Tue,  6 Feb 2024 12:30:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] pds_core: Various improvements/cleanups
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170722262810.15492.5820938953818805527.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 12:30:28 +0000
References: <20240202195911.65338-1-brett.creeley@amd.com>
In-Reply-To: <20240202195911.65338-1-brett.creeley@amd.com>
To: Brett Creeley <brett.creeley@amd.com>
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 shannon.nelson@amd.com

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Fri, 2 Feb 2024 11:59:07 -0800 you wrote:
> This series contains various improvements and cleanups for the
> pds_core driver. These patches were originally part of the following
> net-next series:
> 
> https://lore.kernel.org/netdev/20240126174255.17052-1-brett.creeley@amd.com/
> 
> However, some of the patches from the above series were actually fixes,
> so they were pushed and accepted to net. That series can be found here:
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] pds_core: Don't assign interrupt index/bound_intr to notifyq
    https://git.kernel.org/netdev/net-next/c/02daffa903e6
  - [net-next,2/4] pds_core: Unmask adminq interrupt in work thread
    https://git.kernel.org/netdev/net-next/c/bca10f2c2518
  - [net-next,3/4] pds_core: Fix up some minor issues
    https://git.kernel.org/netdev/net-next/c/247c4ed03321
  - [net-next,4/4] pds_core: Clean up init/uninit flows to be more readable
    https://git.kernel.org/netdev/net-next/c/792d36ccc163

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



