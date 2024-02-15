Return-Path: <linux-kernel+bounces-67291-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 75B6A856945
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 17:15:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 33366287CCF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 16:15:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0288F13A879;
	Thu, 15 Feb 2024 16:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J0gDK9ls"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4170513398D;
	Thu, 15 Feb 2024 16:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708013431; cv=none; b=pfXpgL7iVl9CP+lmO90A8hsh5ozesIldbWXHQB7+bZxrvIHdCXtX0XkokuN9E7tmT3UOU2YeUXGMSwQsH7Z5Egyy0wWcmvXGW4IONRR1q62n1xtF/QL7xSZEITgqC3VIRNHnl0JOvjp/lEep3hTRA6fTxcuSOWI9uE8H011bUyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708013431; c=relaxed/simple;
	bh=Uc/tIN/lL3SQeSL0/Fg8lL22F0u/93cYcAgxns50fdw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Il7hMlfooEzo4vY5u+qvTcC6nMk9JkzCRhal0nNmJi5qagWT5UaVKyzKsphqlwOewK5lSJw/JP8NkWsG2iSG95jLi8TjQRc2dk4BELB4s/4fvl2yuIUC0qvEc17QPylBY3j5Q38qCFZA7O3KXIqjUhWxxdCHfgHZJc2uC5aBMwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J0gDK9ls; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id CFC94C43390;
	Thu, 15 Feb 2024 16:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708013430;
	bh=Uc/tIN/lL3SQeSL0/Fg8lL22F0u/93cYcAgxns50fdw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=J0gDK9lsN/1iZdJHbelsagQObXzr/xXxi4eWtgxWLvzbkit9wJAdQnBtgF61fDzPa
	 YtO6aMb6Jup9EWzD2W9MVFAN65XeByA/ZcmtZV83D3zPkZXvydU8Po7yUZ2n79cqTb
	 DLcAvj6rvlKsh191wX1so0EslDLHQFCz72b2DS7UVUVRy1j10BN3pYloeju1YXhI/p
	 mYpvrBt2mchLOXoGaukpGHO+fveqsh4UgSenJt3+Y8OK2IPgWbjQK9fP7Cjb+Z4/UD
	 D9by5EA2A0PZQWkC5VB8BgWHA6CnXt4JiJDSA/Kkwtv3kdlYSutvkq7jC6zT37Tm44
	 OIO+hTAq4RIzg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B604AD8C97E;
	Thu, 15 Feb 2024 16:10:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net v2 0/7] Fix MODULE_DESCRIPTION() for net (p6)
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170801343074.17977.1395882905085483212.git-patchwork-notify@kernel.org>
Date: Thu, 15 Feb 2024 16:10:30 +0000
References: <20240214152741.670178-1-leitao@debian.org>
In-Reply-To: <20240214152741.670178-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org

Hello:

This series was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 14 Feb 2024 07:27:34 -0800 you wrote:
> There are a few network modules left that misses MODULE_DESCRIPTION(),
> causing a warnning when compiling with W=1. Example:
> 
>         WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/net/arcnet/....
> 
> This last patchset solves the problem for all the missing driver. It is
> not expect to see any warning for the driver/net and net/ directory once
> all these patches have landed.
> 
> [...]

Here is the summary with links:
  - [net,v2,1/7] net: fill in MODULE_DESCRIPTION()s for xen-netback
    https://git.kernel.org/netdev/net/c/5b8e3464071a
  - [net,v2,2/7] net: fill in MODULE_DESCRIPTION()s for ieee802154/fakelb
    https://git.kernel.org/netdev/net/c/c0872309ac84
  - [net,v2,3/7] net: fill in MODULE_DESCRIPTION()s for plip
    https://git.kernel.org/netdev/net/c/44c1197bcef4
  - [net,v2,4/7] net: fill in MODULE_DESCRIPTION()s for fddik/skfp
    https://git.kernel.org/netdev/net/c/4ad9e8587439
  - [net,v2,5/7] net: fill in MODULE_DESCRIPTION()s for ppp
    https://git.kernel.org/netdev/net/c/e1e5ef2aefc2
  - [net,v2,6/7] net: fill in MODULE_DESCRIPTION()s for mdio_devres
    https://git.kernel.org/netdev/net/c/9de69f0e9958
  - [net,v2,7/7] net: fill in MODULE_DESCRIPTION()s for missing arcnet
    https://git.kernel.org/netdev/net/c/538b22e74287

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



