Return-Path: <linux-kernel+bounces-99667-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA685878B97
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 00:40:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4900E2823E0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Mar 2024 23:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 468D459157;
	Mon, 11 Mar 2024 23:40:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Dn3gJoJ9"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84DF257890;
	Mon, 11 Mar 2024 23:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710200430; cv=none; b=OxQ8/L2XkN0Pa9RLp7109T3emMplDQBoqI3a23HWc8KzIfhpsLLdS9zrD/voT7duRDmbRRHETaj3MJHpmXqfuklPsRB9+nUta1B1ynmzaH+oxeU9pTWIqSfNINyq0PLPM5haUDxFsK7Df9EPdAyk8Exh1Lc+0jC3xj8/7nLu9BU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710200430; c=relaxed/simple;
	bh=GhHM2Z484ZX1jCAPVE0yiIxkDV/AUIBM6eUbYoi5D2I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vsa535k8U7yR6W2R20wz+adFBfeBbnowoet6stZz1/Lpnez51FhmC5Txcrzwv7GeBv1ghFSP4P6LxUzVf9sLdvDjxk3XM8GCqLgLzh/9wtsNOYLiug4ELmvyFVXBHd+QI4alOx+QXkKXnt7oyC+a6xYd2SCE2o/Zc2mQSuO+pTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn3gJoJ9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EF179C433F1;
	Mon, 11 Mar 2024 23:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710200430;
	bh=GhHM2Z484ZX1jCAPVE0yiIxkDV/AUIBM6eUbYoi5D2I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Dn3gJoJ9izC7sFePlYlBGByDDJr1qQwgXW0zH5QvE5WdziQmNzZtxOPUkb1Fil20G
	 dpL9UFCFSjqpGmOTJVMfUvJvdXXHMHloLiIq6MLQgmh4YiPjK/ZOMcL5HyNgqH87Z2
	 H2S/K9Hc3d5PTdx148Duso34v5MHgrITSUoLDrZVdTxOF3xUB71IdTdZQPj/dKajcL
	 z13JXjJqnPAdF7kM5vuzAff7nwJGaULoWYh3Y3UghK87nTCjqHzHl2KUR/2HUVy5lk
	 cVoXZea3E960W6bSpZHphb9R0kVdHa8KoPOTuXQEYfqMfvffkfpBwoLgXsTUaB8o1D
	 Sm1f4gao8VXHA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D00DFD95056;
	Mon, 11 Mar 2024 23:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2] bpf: hardcode BPF_PROG_PACK_SIZE to 2MB *
 num_possible_nodes()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171020042984.6750.3210035771015171823.git-patchwork-notify@kernel.org>
Date: Mon, 11 Mar 2024 23:40:29 +0000
References: <20240311122722.86232-1-puranjay12@gmail.com>
In-Reply-To: <20240311122722.86232-1-puranjay12@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to bpf/bpf-next.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Mon, 11 Mar 2024 12:27:22 +0000 you wrote:
> On some architectures like ARM64, PMD_SIZE can be really large in some
> configurations. Like with CONFIG_ARM64_64K_PAGES=y the PMD_SIZE is
> 512MB.
> 
> Use 2MB * num_possible_nodes() as the size for allocations done through
> the prog pack allocator. On most architectures, PMD_SIZE will be equal
> to 2MB in case of 4KB pages and will be greater than 2MB for bigger page
> sizes.
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2] bpf: hardcode BPF_PROG_PACK_SIZE to 2MB * num_possible_nodes()
    https://git.kernel.org/bpf/bpf-next/c/d6170e4aaf86

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



