Return-Path: <linux-kernel+bounces-44463-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA2B84225B
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:12:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8EB4B28CCE
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 11:11:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53CC866B3D;
	Tue, 30 Jan 2024 11:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6+qj4Cv"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9441A664D9;
	Tue, 30 Jan 2024 11:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706613032; cv=none; b=QKftqG841fGesiIdiuwPfR/dSGA9z8WDzCVCFPvr9KVkfFU5fokZk9Pl8oxAx1xgCmAw0PFmT9wgwW/STjSnR/06kYh334k/9TaXRfsFtB9bdZ9M43BkF8fBRQcjjg3KKrsDLCCH6cfUqQZ9u98YcZrgvbHVlhidrRy6GdaRakk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706613032; c=relaxed/simple;
	bh=jaw4K6A04pMut7r0Mu9LnNd3WREiAQkRJloYXC3dL08=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=k3OaR5Bkho+0cyTOyp9L8LgEiuzdMH+5x9c3N/4u/2Va0rzi75D4jrY38ag+Su5biQOUBH0VPgvvGlCxXwGeiXbxbUYx0g7P5TCR9Kdi8ZnAbQeo4tXnZU/KqlyZNvLZowK4cQ3Q8lzFAxIxjsKJs5W/a1u3dBFoCIZXpdmNb1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6+qj4Cv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0D2D0C433F1;
	Tue, 30 Jan 2024 11:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706613032;
	bh=jaw4K6A04pMut7r0Mu9LnNd3WREiAQkRJloYXC3dL08=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u6+qj4Cvjks+U/iSA3T9mHO69j6Nf5ISA1so79/Iz6u3jTG9Kfysw8OMFTX3MVu5l
	 RecpZOsvk0aseYB7eBCtHVn/gNqwNqxx3Rpf1Q3HULmPKzO7OhyBGXRpwBF3AoJCLK
	 932Q+F3HcNMiMcNkOU82hl7FUj+2Ksm6c3GG93+2BLdc9A4g6PLZb4nEqpJKp8I8Mz
	 8p9qP7tQ4QoROb3wHfnllHLiZMYu3EMtfQsewz6gNVTq121WKdTrIzXKPB9eoNaRSZ
	 isStjdumkKBxnDhr/IJ7DAZKAb2TN5+f/8UpmSwZzyRfCEBnBc0UoPa2bC6XNrk5Hv
	 zDMgBT5VAJlng==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DF9EFE3237E;
	Tue, 30 Jan 2024 11:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] net/tun: use reciprocal_scale
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170661303191.21939.5608794279879592159.git-patchwork-notify@kernel.org>
Date: Tue, 30 Jan 2024 11:10:31 +0000
References: <20240126002550.169608-1-stephen@networkplumber.org>
In-Reply-To: <20240126002550.169608-1-stephen@networkplumber.org>
To: Stephen Hemminger <stephen@networkplumber.org>
Cc: netdev@vger.kernel.org, willemdebruijn.kernel@gmail.com,
 jasowang@redhat.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 25 Jan 2024 16:25:11 -0800 you wrote:
> Use the inline function reciprocal_scale rather than open coding
> the scale optimization.  Also, remove unnecessary initializations.
> Resulting compiled code is unchanged (according to godbolt).
> 
> Signed-off-by: Stephen Hemminger <stephen@networkplumber.org>
> ---
>  drivers/net/tun.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)

Here is the summary with links:
  - net/tun: use reciprocal_scale
    https://git.kernel.org/netdev/net-next/c/3f3ebe536208

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



