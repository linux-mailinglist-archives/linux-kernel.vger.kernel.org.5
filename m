Return-Path: <linux-kernel+bounces-84762-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4104B86AB2F
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 10:30:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F9C01C24D1B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Feb 2024 09:30:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64F01339A8;
	Wed, 28 Feb 2024 09:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NWL1LJ/K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0C972D052;
	Wed, 28 Feb 2024 09:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709112632; cv=none; b=rNrH1bDsBqlwy1g8d0VuAExDvFwD+tGVioZf25SsDwvhqh8SmRL2zBZjpPozTWWfuochpQ1BR6UZOVk3Qa6LBAsm8AzpokiKdOjkJaYYbKR3jlOVlTzVIwjono/b01pb+nUaBCJOu6RPf8VRMRSwcD8YR09hXy4o6gb0BGj1y7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709112632; c=relaxed/simple;
	bh=ghkRRLFzNc+IVFkmdNWp0Xo1+eTKBJ80L+Fwfaxc5KA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ElRyqBlfLp7Vh92V5zz8ArafI008ifADt/Pumr4CrlWPd21i5+55sb3S4M4zug6t4zuerUXsN1HIg7X9ByO9C7oMvgM3+w7vQYWgdP5fNT6tEQINNP/jXxooN4hDN9Xem1EW2vSRskTKVZdqOY0kIMyq3cTuoG/IS8BXu7Bv60M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NWL1LJ/K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E896BC43394;
	Wed, 28 Feb 2024 09:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709112631;
	bh=ghkRRLFzNc+IVFkmdNWp0Xo1+eTKBJ80L+Fwfaxc5KA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NWL1LJ/KuKX+qCm81NLQESXCqza3tPemjug2LEDZjOLyx5W+2Dbi1MqArberDscKk
	 RdYUeP5J1lYiK6vd+HzWrMnIDRJzON42wbMQL0Ahz1r3rAwnHzi2dbOPxOTOR5czUW
	 fcIEvxvDiQV90tmwznpEWkifvh7B1QkqZIRKLOC8wDNrgZUKrjOQCRVB5bRzhoPVku
	 16o0Zix6FCELrWpWLIkI1NVqKTwmya5qBev8g8BjDu27pyC9YLzP8ii+V+mBbfa5/Z
	 +S8ZkC34z0/by3ZFfkqP5HQkWXphyqCGfA945aDfA5BTosc432csKbufa8CqU11lMy
	 +Olq7+WLGEAhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C7891D88FAF;
	Wed, 28 Feb 2024 09:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net: make SK_MEMORY_PCPU_RESERV tunable
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170911263080.1645.11640647793580048759.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 09:30:30 +0000
References: <20240226022452.20558-1-adamli@os.amperecomputing.com>
In-Reply-To: <20240226022452.20558-1-adamli@os.amperecomputing.com>
To: Adam Li <adamli@os.amperecomputing.com>
Cc: corbet@lwn.net, davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 pabeni@redhat.com, willemb@google.com, yangtiezhu@loongson.cn,
 atenart@kernel.org, kuniyu@amazon.com, wuyun.abel@bytedance.com,
 leitao@debian.org, alexander@mihalicyn.com, dhowells@redhat.com,
 paulmck@kernel.org, joel.granados@gmail.com, urezki@gmail.com,
 joel@joelfernandes.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 patches@amperecomputing.com, cl@os.amperecomputing.com,
 shijie@os.amperecomputing.com

Hello:

This patch was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Mon, 26 Feb 2024 02:24:52 +0000 you wrote:
> This patch adds /proc/sys/net/core/mem_pcpu_rsv sysctl file,
> to make SK_MEMORY_PCPU_RESERV tunable.
> 
> Commit 3cd3399dd7a8 ("net: implement per-cpu reserves for
> memory_allocated") introduced per-cpu forward alloc cache:
> 
> "Implement a per-cpu cache of +1/-1 MB, to reduce number
> of changes to sk->sk_prot->memory_allocated, which
> would otherwise be cause of false sharing."
> 
> [...]

Here is the summary with links:
  - net: make SK_MEMORY_PCPU_RESERV tunable
    https://git.kernel.org/netdev/net-next/c/12a686c2e761

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



