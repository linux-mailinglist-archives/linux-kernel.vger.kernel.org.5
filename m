Return-Path: <linux-kernel+bounces-94670-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14D2C8742EB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 23:41:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A8F4F1F2375F
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Mar 2024 22:41:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCCC1C2AF;
	Wed,  6 Mar 2024 22:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s5KWhNTA"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE8861B59D;
	Wed,  6 Mar 2024 22:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709764832; cv=none; b=RnTB9Idih4b5sDwETG5zksl1yAJPSdKstUaDJaAAtOiBF4BQWSC9XYDoO/qcAEsovbzEzCK3hda56WzeE9VcORTgYsi6x6S+cKLc7MFLXjcBSHlfbNGvXrAhqYR9IMy6v7rYJmXNpCT0C5V+A6/oaU+NpIqcSYK+W4ZkLjq4szA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709764832; c=relaxed/simple;
	bh=AEovCiiEXVApMoLVDcg5c4GHI5Cl3cHsFPUm+rDkwAU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=VpCLcUzu4bwBnMOChOa1+WNy1JaGFYbFFhnTkUlmse8WEpzJZiUsmLeQ/sqUi/mLgsrSdYoHgsMWp8NYW2dEI3sKoE/4N/Bsk/80AXowETR+D9eyt5M0w1kPBSwvR5Q/W2D7cwh8AeWekvbxVGHUQdiJVR6xUwPyLAgoAQfrUuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s5KWhNTA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id ACA27C433F1;
	Wed,  6 Mar 2024 22:40:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709764830;
	bh=AEovCiiEXVApMoLVDcg5c4GHI5Cl3cHsFPUm+rDkwAU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=s5KWhNTA0B37vZARTbe3FnPyfrscIhrgVJeAE7ArWE+INoia81W5brE+KrUqhfASi
	 mcT/1a/2j8PHwHO5oOMxxXNONqdJiMJiwKthFZOdz4gdDaL7RrHSb72rH+hHGurXmR
	 n87I6DnaLfLfQSMTcGATB0f6Kw1sdUb4w6oZDTNNmBC9P5Rexn0fAIbzeUkOLDxsFc
	 cocO4Vg2I0aiUqs3TplON8l7JhYBi0OhoJU2tvZ7FTGJ9SxsC9zUboQerCkuzrGAsJ
	 qPKmKlb+Vo3YXPamsW16rISA2XYDn0OXSq/ULW24pWNAi5GNufr9SerZotEkmHtOXZ
	 Trlkw8tOPjDew==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 86753C3274B;
	Wed,  6 Mar 2024 22:40:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next 0/1] Support kCFI + BPF on riscv64
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170976483053.9451.12256048383404087701.git-patchwork-notify@kernel.org>
Date: Wed, 06 Mar 2024 22:40:30 +0000
References: <20240303170207.82201-1-puranjay12@gmail.com>
In-Reply-To: <20240303170207.82201-1-puranjay12@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 ast@kernel.org, daniel@iogearbox.net, andrii@kernel.org,
 martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org, luke.r.nels@gmail.com,
 xi.wang@gmail.com, bjorn@kernel.org, samitolvanen@google.com,
 peterz@infradead.org, keescook@chromium.org, linux-riscv@lists.infradead.org,
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Sun,  3 Mar 2024 17:02:06 +0000 you wrote:
> With CONFIG_CFI_CLANG, the compiler injects a type preamble immediately
> before each function and a check to validate the target function type
> before indirect calls:
> 
>   ; type preamble
>     .word <id>
>   function:
>     ...
>   ; indirect call check
>     lw      t1, -4(a0)
>     lui     t2, <hi20>
>     addiw   t2, t2, <lo12>
>     beq     t1, t2, .Ltmp0
>     ebreak
>   .Ltmp0:
>     jarl    a0
> 
> [...]

Here is the summary with links:
  - [bpf-next,1/1] riscv64/cfi,bpf: Support kCFI + BPF on riscv64
    https://git.kernel.org/bpf/bpf-next/c/dfd646d117b7

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



