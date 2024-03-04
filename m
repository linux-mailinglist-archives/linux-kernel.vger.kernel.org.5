Return-Path: <linux-kernel+bounces-90468-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC4486FFA9
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 12:00:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29B8E1C22C81
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 11:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E770E3838B;
	Mon,  4 Mar 2024 11:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="opdsGvKx"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A6E1B814;
	Mon,  4 Mar 2024 11:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709550029; cv=none; b=AbJYiXrIcZ3vmDQBEufneRWDdlU9QsPVamys6vrNooNc3PLUCHU8wlS7yOMSx3PFvBHZnFJcx4Ddc78s5AYRAbWmR+QQYbx2/IZdoeyZBbZN5E1M0ssGKHFljm8LX1S6HeJCITqts/wPkJOpX+D+5WMJE3UKeFiQiLDTkmn1gRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709550029; c=relaxed/simple;
	bh=pIgEUVGtG1rVM4ZB5OE3Ns7LozVTw2LBn5mYhplujzw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qKhgmVuWQAYNGHcNmkaMuipxvYwtkWhGEYvzyrzIj7L3pOOvzJxqPjs+w5FXG5RNG7l1Ud5cLmmVhCIfW772xQvNAGky93tSEqIhB2HCNjUeK0c+0Wj/7gJ4pXXYl9G7CgQG92NyDiGNCt3vce45slQlB7w2MPT4lhQwQC0BY5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=opdsGvKx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A6100C43390;
	Mon,  4 Mar 2024 11:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709550028;
	bh=pIgEUVGtG1rVM4ZB5OE3Ns7LozVTw2LBn5mYhplujzw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=opdsGvKxBYYON/IyysrGR2t4nWKu1a8CJgR/jV5gG1Ue+4LrDowsw0muhNO9iC3c+
	 ZjBiq9/bYW8KR+NzP5Fr7xFEs7FR7z5qcs82sWKE5R//176SGVd6lKIBS5PDhj9+QE
	 RPEVrpySnbz7SgHZGyMod9xFGeAu+6ppgZn/HQ7HZT3Yp0R19mFabhngOIyVTDKZv1
	 qJ6thtmDfh/l2jGpBZQo3uaiJ2ArTNy7ROWhdqm8JdlVz5Dq5/w7Dobaj0qtAwFWty
	 RLXkI9ZmBtkcuIZGaWb9cN4aCNW+RTgFGijJN2eWfkrp60gSWMmicI1J4DAHUvqfKW
	 rB4fIgVNsPpug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 89529D88F87;
	Mon,  4 Mar 2024 11:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/4] mptcp: add TCP_NOTSENT_LOWAT sockopt support
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170955002855.28316.4147541223134809817.git-patchwork-notify@kernel.org>
Date: Mon, 04 Mar 2024 11:00:28 +0000
References: <20240301-upstream-net-next-20240301-mptcp-tcp_notsent_lowat-v1-0-415f0e8ed0e1@kernel.org>
In-Reply-To: <20240301-upstream-net-next-20240301-mptcp-tcp_notsent_lowat-v1-0-415f0e8ed0e1@kernel.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: mptcp@lists.linux.dev, martineau@kernel.org, geliang@kernel.org,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Fri, 01 Mar 2024 18:43:43 +0100 you wrote:
> Patch 3 does the magic of adding TCP_NOTSENT_LOWAT support, all the
> other ones are minor cleanup seen along when working on the new feature.
> 
> Note that this feature relies on the existing accounting for snd_nxt.
> Such accounting is not 110% accurate as it tracks the most recent
> sequence number queued to any subflow, and not the actual sequence
> number sent on the wire. Paolo experimented a lot, trying to implement
> the latter, and in the end it proved to be both "too complex" and "not
> necessary".
> 
> [...]

Here is the summary with links:
  - [net-next,1/4] mptcp: cleanup writer wake-up
    https://git.kernel.org/netdev/net-next/c/037db6ea57da
  - [net-next,2/4] mptcp: avoid some duplicate code in socket option handling
    https://git.kernel.org/netdev/net-next/c/a74762675f70
  - [net-next,3/4] mptcp: implement TCP_NOTSENT_LOWAT support
    https://git.kernel.org/netdev/net-next/c/29b5e5ef8739
  - [net-next,4/4] mptcp: cleanup SOL_TCP handling
    https://git.kernel.org/netdev/net-next/c/7f71a337b515

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



