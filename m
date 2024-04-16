Return-Path: <linux-kernel+bounces-147192-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EA82B8A70C7
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:02:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A6DA42862B0
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:02:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5363E132C0E;
	Tue, 16 Apr 2024 16:00:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHTtqi5q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93184130A69;
	Tue, 16 Apr 2024 16:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713283228; cv=none; b=NS5SUimiaSNH+gGVUpdLQtCSmhQsNeipQRQ6u/lj3bHvZry9Pe4wdqF4PjEMxP6kg7uBw173H+MRfUBAT1IVYjzwD84YYCkh0UGqMNJ9yypenrk+CVYBoK9SnOyIvqGiPmUEeUsx+lqLrXs0w0V5r6qH8gzaXmUhUvYmvmgz7u4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713283228; c=relaxed/simple;
	bh=Ttl5C7Gy4GPp5mcr9rDBw4CJPf8zyRH93bSjYUM6PUw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CYC6PKP1Zlfgad8KWsWTPWfO/NLyn4y0vycqoHvai9YDM6+gGQ86FMptD/lwn+echEPdgdSv/r0HFbjnGklb7LfZX1uMVLXRaFHdYerJcfO31oaMBmO2ZC72nLHasFJ8JiNyVuqXALuCqiW6P0cGZ6FqgdnHlLk/xqnzvbPP6ck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHTtqi5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 66B57C32783;
	Tue, 16 Apr 2024 16:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713283228;
	bh=Ttl5C7Gy4GPp5mcr9rDBw4CJPf8zyRH93bSjYUM6PUw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UHTtqi5qBOrFeQv1bGFIzJSFC5ku7yPEZYNlGPSitOOHVinxUNIIPKO12DltSJ+KC
	 1eSym2/Y67mQCIB0l9iCuflC2P/N+nU9eM/jFM0eswAR/wYoSwxxWzF1RLEcn5hhdY
	 yeFDQF/Lyw5sXhZMgmldG5l2s5CwZN6D6mr0yoveEPFc2H8ZeDlgTP4iIv5T//T40L
	 W8gXNHqLIkmXkkhT18rtgWMxIZD8E6XbKwnGLrhkseYvsqyfly62AoDnFoUCxMdqbo
	 TPWM8YSbVJgLvnCagj7dGbj21cudqk1tlZVUlc8LWGHB0B9++yf7tYKeMroe5Wae4Z
	 oPtXZ78aRSWYQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 54465C395C5;
	Tue, 16 Apr 2024 16:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 bpf-next] bpf: Harden and/or/xor value tracking
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171328322834.16684.6567796200399765338.git-patchwork-notify@kernel.org>
Date: Tue, 16 Apr 2024 16:00:28 +0000
References: <20240416115303.331688-1-harishankar.vishwanathan@gmail.com>
In-Reply-To: <20240416115303.331688-1-harishankar.vishwanathan@gmail.com>
To: Harishankar Vishwanathan <harishankar.vishwanathan@gmail.com>
Cc: ast@kernel.org, harishankar.vishwanathan@rutgers.edu,
 sn624@cs.rutgers.edu, sn349@cs.rutgers.edu, m.shachnai@rutgers.edu,
 paul@isovalent.com, srinivas.narayana@rutgers.edu,
 santosh.nagarakatte@rutgers.edu, daniel@iogearbox.net,
 john.fastabend@gmail.com, andrii@kernel.org, martin.lau@linux.dev,
 eddyz87@gmail.com, song@kernel.org, yonghong.song@linux.dev,
 kpsingh@kernel.org, sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 bpf@vger.kernel.org, linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Daniel Borkmann <daniel@iogearbox.net>:

On Tue, 16 Apr 2024 07:53:02 -0400 you wrote:
> This patch addresses a latent unsoundness issue in the
> scalar(32)_min_max_and/or/xor functions. While it is not a bugfix, it
> ensures that the functions produce sound outputs for all inputs.
> 
> The issue occurs in these functions when setting signed bounds. The
> following example illustrates the issue for scalar_min_max_and(), but it
> applies to the other functions.
> 
> [...]

Here is the summary with links:
  - [v3,bpf-next] bpf: Harden and/or/xor value tracking
    https://git.kernel.org/bpf/bpf-next/c/1f586614f3ff

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



