Return-Path: <linux-kernel+bounces-133446-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D657E89A3CE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 20:00:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8B8B51F244E3
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 18:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CAA5171E67;
	Fri,  5 Apr 2024 18:00:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DFLz+VJk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2221DFEB;
	Fri,  5 Apr 2024 18:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712340029; cv=none; b=CXr6xyK9uqZ+0qUqhmfaHZZxv3+5Sa/cWirA4yMhYUYDyoh1i5NdgOX3L/Ftf2Mn9bheEMiXFUAfnVyVfBVrmTmgnKDwYz6nNgYLBhbxeWqADAzp2dqxM1y2sRizXbwIyuDe9JLtlSm9St3akfFLykEEEcCDzJY/HrT3r5MkpR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712340029; c=relaxed/simple;
	bh=Wwti1x3AI9lHvX7vovmnr2R3ixVUqD5YSxNppd9rzEk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=MfgqVWwpBue1ev0s7KDVZZANalRHtb6m25kzvZKsJ5AFDiwn6nf/8PATyv9OL+HlQBxDVLRNDdjYtn17v38D/9EiPEthlhwvgoevL3aPaqvSjPDhZ+4lBuqIOBU25FcNlZRni4XeJF94clYYzJ4L3bm3MTr7+Ve1HBaKopqLCA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DFLz+VJk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B37B9C43390;
	Fri,  5 Apr 2024 18:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712340028;
	bh=Wwti1x3AI9lHvX7vovmnr2R3ixVUqD5YSxNppd9rzEk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DFLz+VJk6eKVZUve1j65gczJySvRp54J1p/958VkgyduxSHQh5fsqa0lUtGApEDE/
	 b8J8x4ke5i8V8oOGUssAeGGsPTElBJOfWgkKkklr5hjCY8DTsw7CGVUGIAexZsaban
	 Nyr4qwpx4p4O24GzoNaxQ3AENIPWf6vXSwVVXLQrvVVNaADHzmRE/Wnh/3vK0uB55W
	 kfnmqU8I0O302qgwGmLpTo+naSkUvis0aelmVrZ4evNe8N8qQnoceE67mGqFvmeYQ3
	 XiiC3W3kidYibZKUZvf/0nmDTOrLpmzmhUQ5slweTUqt8UjMzac9S0bt6UM5HOuZdv
	 dtMtN5nQU9r0g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9EFD3C395F6;
	Fri,  5 Apr 2024 18:00:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf-next v2 0/2] bpf: Allow invoking kfuncs from
 BPF_PROG_TYPE_SYSCALL progs
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171234002864.5871.233926232355884228.git-patchwork-notify@kernel.org>
Date: Fri, 05 Apr 2024 18:00:28 +0000
References: <20240405143041.632519-1-void@manifault.com>
In-Reply-To: <20240405143041.632519-1-void@manifault.com>
To: David Vernet <void@manifault.com>
Cc: bpf@vger.kernel.org, ast@kernel.org, daniel@iogearbox.net,
 andrii@kernel.org, martin.lau@linux.dev, song@kernel.org,
 yonghong.song@linux.dev, john.fastabend@gmail.com, kpsingh@kernel.org,
 sdf@google.com, haoluo@google.com, jolsa@kernel.org,
 linux-kernel@vger.kernel.org, kernel-team@meta.com

Hello:

This series was applied to bpf/bpf-next.git (master)
by Andrii Nakryiko <andrii@kernel.org>:

On Fri,  5 Apr 2024 09:30:39 -0500 you wrote:
> Currently, a set of core BPF kfuncs (e.g. bpf_task_*, bpf_cgroup_*,
> bpf_cpumask_*, etc) cannot be invoked from BPF_PROG_TYPE_SYSCALL
> programs. The whitelist approach taken for enabling kfuncs makes sense:
> it not safe to call these kfuncs from every program type. For example,
> it may not be safe to call bpf_task_acquire() in an fentry to
> free_task().
> 
> [...]

Here is the summary with links:
  - [bpf-next,v2,1/2] bpf: Allow invoking kfuncs from BPF_PROG_TYPE_SYSCALL progs
    https://git.kernel.org/bpf/bpf-next/c/a8e03b6bbb2c
  - [bpf-next,v2,2/2] selftests/bpf: Verify calling core kfuncs from BPF_PROG_TYPE_SYCALL
    https://git.kernel.org/bpf/bpf-next/c/1bc724af00cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



