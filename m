Return-Path: <linux-kernel+bounces-112212-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A86798876F4
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 04:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DACD01C2308D
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 03:50:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9758F881E;
	Sat, 23 Mar 2024 03:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qEiSDPqK"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF6E25256;
	Sat, 23 Mar 2024 03:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711165828; cv=none; b=IelXKJQhgR816IThWKAOXAu3E+JzNoGmAd/VeBQtIKw41RE2DKfMK6BpoQAqC0uSLkZBzy/LrjV6GCKzKRydF/Gl39qZnu8C+yJcuqOHnVwth0vqde9sRULYDX27u1lWPfcmnizeMZhrRToxURZN281qKrbGAY3Y0fJzEiywB98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711165828; c=relaxed/simple;
	bh=g4wocxc6/o7/+1kXUUHeHRoXYZ5/fZMi4UFcS2oOFM0=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NSKN7wr625RRqYnYriHQaHiDVasYT5rs4Z3zRrgLXgPxzZhWQ8JVy89lkOFKDzP/kWSJJZeJpekPVpDLqN8G0Ii2+Y93y9YeY/B7kAtSwAx0AnhEdeVcSM9OtKnu0lFia9ZuiMsMXMWo3pmld17VqOPQCiAw96es03YIyhDKxfY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qEiSDPqK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 44471C43399;
	Sat, 23 Mar 2024 03:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711165828;
	bh=g4wocxc6/o7/+1kXUUHeHRoXYZ5/fZMi4UFcS2oOFM0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qEiSDPqK1G0qowZ3Pk/BUnK1PcMN0TLnDkrnAOhdaOG3sS9IsU6m7Cy/uiYaBqtxR
	 mJLx/omooO3t2RMQq06llwZ38SV+K6w6THjTnsEE6ehgS5+A3rULosvhZe4mG+mzCs
	 xoiXNR+nYlcSNbkv0J1CEoJUwbbAVxplwQmqrDLsz6IPj67D9hNUkvhrg1y3PBE1s7
	 j3HdSm+0rFiH+F7YdGxz/RhhnxuaF+QepIV9Qc4EE7RvWkUHDy1l0GnGGqCUjiHWJu
	 ckDACD/pk8+5adTYmC2Ro38122KHXvhPT1CEhqTF6aMdgcDZXfdE09ItD++UHdrKLo
	 oPrDKylAss/0A==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 3355AD8BCE5;
	Sat, 23 Mar 2024 03:50:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf v2] bpf: verifier: reject addr_space_cast insn without
 arena
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171116582820.31313.2054096271449855670.git-patchwork-notify@kernel.org>
Date: Sat, 23 Mar 2024 03:50:28 +0000
References: <20240322153518.11555-1-puranjay12@gmail.com>
In-Reply-To: <20240322153518.11555-1-puranjay12@gmail.com>
To: Puranjay Mohan <puranjay12@gmail.com>
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 andrii@kernel.org, martin.lau@linux.dev, eddyz87@gmail.com, song@kernel.org,
 yonghong.song@linux.dev, kpsingh@kernel.org, sdf@google.com,
 haoluo@google.com, jolsa@kernel.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, bpf@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
 memxor@gmail.com

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri, 22 Mar 2024 15:35:18 +0000 you wrote:
> The verifier allows using the addr_space_cast instruction in a program
> that doesn't have an associated arena. This was caught in the form an
> invalid memory access in do_misc_fixups() when while converting
> addr_space_cast to a normal 32-bit mov, env->prog->aux->arena was
> dereferenced to check for BPF_F_NO_USER_CONV flag.
> 
> Reject programs that include the addr_space_cast instruction but don't
> have an associated arena.
> 
> [...]

Here is the summary with links:
  - [bpf,v2] bpf: verifier: reject addr_space_cast insn without arena
    https://git.kernel.org/bpf/bpf/c/122fdbd2a030

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



