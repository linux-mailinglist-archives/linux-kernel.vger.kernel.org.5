Return-Path: <linux-kernel+bounces-10931-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6251581DED4
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 08:30:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B0191C20A7D
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 07:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE986185A;
	Mon, 25 Dec 2023 07:30:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1XSnVMt"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13431139F;
	Mon, 25 Dec 2023 07:30:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 681FBC433C8;
	Mon, 25 Dec 2023 07:30:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703489424;
	bh=GvA9qbJILPFLOehK3vco8BG7r0efz8s9KxsshK/NtSs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=h1XSnVMtH8bTNVlCG0Zf6UmEafpc0byR7V4AIlW+YwsFSVSxgxSZBMuYIEKkZp3G7
	 gxLEjBvdCzYLGq8DYCfOOpbNhmfWlrkzWWUdNGym7OBDK/Xyo/KiT6Qz0/aLHHrjPx
	 v4zkYO2MVGoYeODWEYcazO9nRC7VFGcLfyGLbR+Rext+btUENpVzLorRPqA66Pe0Fn
	 JIPEi2lVwguEz5lgKamKqYkWAwa/AP/wnsbVz1EZ8SyAG7X8ldaljoX7zZY333Xg82
	 1JS3HcwkOJpl3FhFR+VP//pvGiDC8GvqC9Gdm4mEaBzWoTNgjFw5K8m81Wy0IJDY9O
	 7JEaXATADFNbg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4C7ACC41620;
	Mon, 25 Dec 2023 07:30:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v7 0/2] nfc: Fix UAF during datagram sending caused
 by missing refcounting
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170348942430.19111.12016191837350222788.git-patchwork-notify@kernel.org>
Date: Mon, 25 Dec 2023 07:30:24 +0000
References: <cover.1702925869.git.code@siddh.me>
In-Reply-To: <cover.1702925869.git.code@siddh.me>
To: Siddh Raman Pant <code@siddh.me>
Cc: krzysztof.kozlowski@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 23:19:42 +0530 you wrote:
> Changes in v7:
> - Stupidly reverted ordering in recv() too, fix that.
> - Remove redundant call to nfc_llcp_sock_free().
> 
> Changes in v6:
> - Revert label introduction from v4, and thus also v5 entirely.
> 
> [...]

Here is the summary with links:
  - [net-next,v7,1/2] nfc: llcp_core: Hold a ref to llcp_local->dev when holding a ref to llcp_local
    https://git.kernel.org/netdev/net/c/c95f919567d6
  - [net-next,v7,2/2] nfc: Do not send datagram if socket state isn't LLCP_BOUND
    https://git.kernel.org/netdev/net/c/6ec0d7527c42

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



