Return-Path: <linux-kernel+bounces-55132-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBFB84B81D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 15:40:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21F3C1F25633
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Feb 2024 14:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E4A5131E44;
	Tue,  6 Feb 2024 14:40:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sbJyShs6"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD88638DFE;
	Tue,  6 Feb 2024 14:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707230426; cv=none; b=Xlrza9a/y1spctjk2iwqBKSjEx7XHVjfa5XhkXI5rstFM9zDobfXhzp/frCT+RMYg/pJm1Ek2TNmkd3cBlXRTS49tV0AFitCgJWqJr9UpLK5KOkKoWm/T0u3AupPe5HuCwCsQ5WLpjmzsvVQHyCl5cxov7TT30QQq/xZFKzrbiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707230426; c=relaxed/simple;
	bh=bHseTnLnWIH2LxdTdqbctGEv05OIuqUtFNnWZkhSZkQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YpgkHnbNFX2vFn0sK4cR1TF3Ii1C3rTRqj/w8WAaHgpn5SQvEPpY2fJBXwrYMk+mfnjOmS7WIESwPLo47wYuHxt0thGGD+iUCGV9q+zbUKb8RKP2UieqyDKiaVoQ1yH54EsrZXsn/u3gsQpmBd51gOfhlsjq4FpXlsnRP6/OUvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sbJyShs6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 409F6C433C7;
	Tue,  6 Feb 2024 14:40:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707230426;
	bh=bHseTnLnWIH2LxdTdqbctGEv05OIuqUtFNnWZkhSZkQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sbJyShs63FJK/CNw6MczVlisezULuA0sQ7Z2AixQPuHxiVZcqSjqrCNaql/E+L3rl
	 w7re0vYtEPLCDOfRimOUcXOIxusmI6mdi2HUJaAggW13tRnSGACMtxLmIJhTXgYhk1
	 domk43sblHLqOJ9EiL8W/MIum+WzbOOIHyEz6bthZ8vaqNoMtXdGgvT+0gjYwYsAMI
	 UJ5GkM5qawXWb5Wu7BFM3+M0/IctE8BxQU8XUd4VKVLUlK+sSdBtj959fs0fmVlSwr
	 lrnaq+hlrENezkudgpJZewQRG9vh/WkEh9RfhhFPTpKdx41nmVP7qMNO3YXveRxNnU
	 Vk8uK72Iw+BFg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 215F5E2F2ED;
	Tue,  6 Feb 2024 14:40:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2 0/2] nfc: hci: Save a few bytes of memory when registering
 a 'nfc_llc' engine
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170723042613.26701.2610648109297572739.git-patchwork-notify@kernel.org>
Date: Tue, 06 Feb 2024 14:40:26 +0000
References: <cover.1706946099.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <cover.1706946099.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: krzysztof.kozlowski@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Sat,  3 Feb 2024 08:51:02 +0100 you wrote:
> nfc_llc_register() calls pass a string literal as the 'name' parameter.
> 
> So kstrdup_const() can be used instead of kfree() to avoid a memory
> allocation in such cases.
> 
> v2: Add a new helper function, nfc_llc_del_engine(), to reduce code
>     duplication. This is needed to address Jakub Kicinski's comment
>     about nfc_llc_exit() that was not updated in v1.
> 
> [...]

Here is the summary with links:
  - [v2,1/2] nfc: hci: Introduce nfc_llc_del_engine() to reduce code duplication
    https://git.kernel.org/netdev/net-next/c/d6f4aac19ad4
  - [v2,2/2] nfc: hci: Save a few bytes of memory when registering a 'nfc_llc' engine
    https://git.kernel.org/netdev/net-next/c/83cdd8db7508

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



