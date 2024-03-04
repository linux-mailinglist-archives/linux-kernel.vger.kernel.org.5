Return-Path: <linux-kernel+bounces-90423-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE1186FEEF
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:23:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0904C28270E
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13C33B2AD;
	Mon,  4 Mar 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B2LqmZHE"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23E413A1CE;
	Mon,  4 Mar 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709547645; cv=none; b=IHbjrkhAB5yAhuAWhgsHOBNoWIBn6Zm3HLZYnuCI4K5VKPi8/LbHlkeZbZ4JbthC0NVBPTVoIG0RT2cHwhJYcV+3y96ZjnVvHmI6y4ORlwYjGvKNPyFiS6ZZr6ji1sGSg/YEZta6/JBhxvxRnquhl9JGZ6I6hUs1YJ+dnPmbp1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709547645; c=relaxed/simple;
	bh=6n0YY4ePtKBKdGZBS0v9t0Uk/m2wNeMFCpuf7krZ4Mk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=N1L1pTugKptYKExUA/sqFBxrzHS3VhfGh+7Xqt71JNqB023tw2Mr64Yabd3hBPlDrgicZ76ZB8s2qDvg5ApsTL30xZ/rF9SkRAO/WFOpR++vpAYH5uUNKiVXvWmDKr11o/fnRCpR35foN90vSePh4nsjUEv4u3vEPCR+aLitITM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2LqmZHE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EA775C43390;
	Mon,  4 Mar 2024 10:20:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709547645;
	bh=6n0YY4ePtKBKdGZBS0v9t0Uk/m2wNeMFCpuf7krZ4Mk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=B2LqmZHEErG+5Ea4vdd6cFzHbsVJije1YGYEHDnBX7RM7M4/spJclFmivwrtYNeLH
	 4TkUTjKhmMuZcmA5wSKSf3DKasJrSbhIv0EY3Fq/Ywi5kU+AFYr/BHM3IY0PBRKC5M
	 QP7Be5xTh8EuDA1yLAn2Zvlo8TjqhqzP585MJjgMLekM2miKlSTwkZNFiXnjQNTY4F
	 1hJzisWDrX/WEcOMv9Ou2PNlUs2Sa9Lj/dcvjZ2S25ZsLOhhNI4VApbdlurgNuN2gv
	 NUDY/qL+BI6I/XVgdOiqNHWw7DTfeW8sKndCmd7nxiASLPNsbSzomeRzAql/dbZEpE
	 8BjGGocueL7rA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1C85D88F89;
	Mon,  4 Mar 2024 10:20:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: nlmon: Remove init and uninit functions
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170954764485.3200.9167784305864194205.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 10:20:44 +0000
References: <20240301134215.1264416-1-leitao@debian.org>
In-Reply-To: <20240301134215.1264416-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, daniel@iogearbox.net, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org, dsahern@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri,  1 Mar 2024 05:42:13 -0800 you wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: nlmon: Remove init and uninit functions
    https://git.kernel.org/netdev/net-next/c/4f41ce81a919
  - [net-next,2/2] net: nlmon: Simplify nlmon_get_stats64
    https://git.kernel.org/netdev/net-next/c/26b5df99bf60

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



