Return-Path: <linux-kernel+bounces-90261-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E533D86FC96
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 10:00:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 231931C21A18
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 09:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5860E20B02;
	Mon,  4 Mar 2024 09:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HuKfR/WV"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90606199B9;
	Mon,  4 Mar 2024 09:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709542828; cv=none; b=BR5t0m83jRoFDPD1Gdj0jwu98fvUm8uAHvPiplSTWyXJmQofo6EfkJxmSAzA97te+WbdaGCgWoOkmFuoHeAo4ZWEh9K7T/pZ0Y24mZuTYdqP34npJqIb8g0q2SWSOq2ESMf4sRdMft/zrV88NPLMrVL1J4zKLY/bu3aIYR9FoSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709542828; c=relaxed/simple;
	bh=Byxhbbn6lqgF9Cm6h5nv2gFW+UHSCp5xb/FH22m8dcI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BY5OfsHNOGapWRMlt/e4o/3TszX/rh3wcf74+tm+DnE6Pur1uEqwbnHAsAwx63W7dIc0N6lgg0/E3kOOBaLVE3eGWAh1cuY2x3CfPsEWvNB5jWjqDxMBbAVRvq7/SZHAorWC/t0sTKcBJDbPPs+rIm3xz6da8QIVZ3VAzb8CWcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HuKfR/WV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5B346C43390;
	Mon,  4 Mar 2024 09:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709542828;
	bh=Byxhbbn6lqgF9Cm6h5nv2gFW+UHSCp5xb/FH22m8dcI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HuKfR/WVwb16yFUJzs9NFkUwIVv+0zYL0/fXbP9eJoFSGY+p5ZkHsXQbzHbbBLrtV
	 RA55+KTVi/6hkH2l0j8DJ135f/hOOAdN69kCC4Rcx0u9sraEz7wlerGK8OiPF3/CBt
	 KAfYfi0f9Bt05O6CQLIE5Xhlsye8W47Ej1OdtTUcnFgy6INX7rKCkCEkDNKOeo0ydA
	 YZl/cUD6U9GgV31PzO1DsDfpXQ7JXow3ycwXZr/qPK9f2sgTiVIOVd3l4JVxhvc6OP
	 sp22Xh7Z44CavnsDxGiawNRXL+HptK0Om6wPP6CBds2tTOfV1WmZNFtNMZdVEsDMZZ
	 jGz3/E/rieDjg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 42038D88F87;
	Mon,  4 Mar 2024 09:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 1/2] net: bareudp: Do not allocate stats in the
 driver
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170954282826.2135.12128004383163847470.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 09:00:28 +0000
References: <20240229170425.3895238-1-leitao@debian.org>
In-Reply-To: <20240229170425.3895238-1-leitao@debian.org>
To: Breno Leitao <leitao@debian.org>
Cc: kuba@kernel.org, davem@davemloft.net, pabeni@redhat.com,
 edumazet@google.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 horms@kernel.org, dsahern@kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Thu, 29 Feb 2024 09:04:23 -0800 you wrote:
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
  - [net-next,1/2] net: bareudp: Do not allocate stats in the driver
    https://git.kernel.org/netdev/net-next/c/6f355bbb5ca3
  - [net-next,2/2] net: bareudp: Remove generic .ndo_get_stats64
    https://git.kernel.org/netdev/net-next/c/4ab597d29621

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



