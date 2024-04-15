Return-Path: <linux-kernel+bounces-144927-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 350F28A4CB7
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 12:43:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C98EC1F22381
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 10:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F4D45C8FE;
	Mon, 15 Apr 2024 10:42:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="okXv9B/j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB47D5B691;
	Mon, 15 Apr 2024 10:42:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713177777; cv=none; b=OS3F6XzviVOpEsmp8QFE5Kb+qGQYTPhLyW6+vseomi+M4b8+1K0nGrbTh9DVjfoUmFFsTtdSRc6h03p2I+4u/iFnokOZ/QYrv6UF12O6iJMUmg4h1QEfM9w0HHMVi/KJeLJfcNef0acmnaHZXJX6JWXp+s0fiBtNcemu02b/iXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713177777; c=relaxed/simple;
	bh=dWMKuaFSiILKDz5Sa10p9m3YCRvJM7aMbFXP//bgmyQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=LcFMt3vKCjXbhD1NqVchUxO/iXn/YjCFYUAOXtAcjP49c6VcAkNvSJMn3gcp13v0KGwJBg2awPBEefp3mcBkYcSrMkCOu+Y5BFnO8k/y3OJgnRPvIZFuhTGNsc0OV8nsq5wCtIQCUvQcLLSPqHO2qUh9ZAJXiXABpMUnpaYDqrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=okXv9B/j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A035C113CC;
	Mon, 15 Apr 2024 10:42:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713177777;
	bh=dWMKuaFSiILKDz5Sa10p9m3YCRvJM7aMbFXP//bgmyQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=okXv9B/jGedH+UAiCsoiEw7cWHYU41IZBJD8Y4B/P20VdaCFEUyzWOBAFbYNSe9Uj
	 4qVlPGqwNdSYi3VkmtbeFCuzXrjQScQpigl/DiKD2ZG1b1EhLltHoHnhU6mVTauOda
	 iT9Hx56VujVYeHA7SYQAj5RiCbV9Wcc4cijR6fAghQMiyxejG+eWWlCHEKH2vb9xMb
	 +DiQW1/iutmOVgO92y6F/QgChg6iDbe9aixvyqvPFwHYBWRi9B8aYhUAeNSadA0MNC
	 ylMPRmaIdqUKkfLE2XuL81Zm9M75K94LB7gz4iIC63/DpZ7mdAZDpoXGmzLxVPK3WU
	 nCtNDMbrqPmag==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2E7A8C43140;
	Mon, 15 Apr 2024 10:42:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: ipv6_gre: Do not use custom stat allocator
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171317777718.12124.14535417943492990270.git-patchwork-notify@kernel.org>
Date: Mon, 15 Apr 2024 10:42:57 +0000
References: <20240412151928.2895993-1-leitao@debian.org>
In-Reply-To: <20240412151928.2895993-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: davem@davemloft.net, dsahern@kernel.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, horms@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 12 Apr 2024 08:19:25 -0700 you wrote:
> With commit 34d21de99cea9 ("net: Move {l,t,d}stats allocation to core and
> convert veth & vrf"), stats allocation could be done on net core
> instead of in this driver.
> 
> With this new approach, the driver doesn't have to bother with error
> handling (allocation failure checking, making sure free happens in the
> right spot, etc). This is core responsibility now.
> 
> [...]

Here is the summary with links:
  - [net-next,1/2] net: ipv6_gre: Do not use custom stat allocator
    https://git.kernel.org/netdev/net-next/c/8622f90a371b
  - [net-next,2/2] net: ip6_gre: Remove generic .ndo_get_stats64
    https://git.kernel.org/netdev/net-next/c/05d604a57773

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



