Return-Path: <linux-kernel+bounces-138739-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CBB689F9C3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:20:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C59AB1F21543
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DB9C15EFBD;
	Wed, 10 Apr 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y6OL6W7v"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B28A815EFC8
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758833; cv=none; b=mdpLq43nIY2LMwKLdckSOL+MrNA3MlvjyFU+j0GFaChGygi+9mqyYxzlE+FqwLZ3KO3D5sv5L54bJEhGs70euhM7/m5xhc56Ooyl55bXNVaXz8e7TjZ7uVjZpFZe0eYVogJzKPnVp2+1EOxN7GvRRlhEmceXEtxaEYwAfzj4jaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758833; c=relaxed/simple;
	bh=xDkGlfHuxeUMLKmnnKvrUXj70ln4rm8rNPiszU3Vn/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=AsRoPxljsQwHN1gj0kjVqzSoNfxMhh56N6+tlTYu8EowM3QEfFWd1FNTbN2HXSKKFbSY271SEmaf/1CfVP/rTTBb83qymkDRh/bNY2k5/IoIQVHHsDUTxMzV005Sz4G3+Sdj2Noqh+z2KaIvmAzIiwwG4WQAsVgqZCqbx5ukxkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y6OL6W7v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 55CC0C433F1;
	Wed, 10 Apr 2024 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712758833;
	bh=xDkGlfHuxeUMLKmnnKvrUXj70ln4rm8rNPiszU3Vn/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Y6OL6W7vapmqulllVpsNnjRDcPT9oEzn/Rg4xVgasMrP1z0CpfNDJsR5X2iVWRm4Z
	 ry7M9L4OkEHQpe3Q65uHSiAxVYEygosyL89IiF8RBAZJpo5FR9roEQmdQN+GYIOa7T
	 yAMzC10eFvGglUDLckZCGDUDLxOwR+T9N8f2S4kHs3hijhgSRqhA/LUnkMvgc1xq0x
	 BS+tN89A6x41e7iFDAdCYvdtveafvQSX8UcBt23YPwFG2VRQbQiSiGfL+OboCtkrrp
	 68si6Tzhvw1Lt2zJr4i7PtmTbyf+95t1EUT/KvFvpFQn6H5NEx+ERWB4EXieonyq2e
	 2nNai4sEogyQw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4AD22D60310;
	Wed, 10 Apr 2024 14:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v1 0/5] Rework & improve riscv cmpxchg.h and atomic.h
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171275883330.18495.10110341843571163280.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 14:20:33 +0000
References: <20240103163203.72768-2-leobras@redhat.com>
In-Reply-To: <20240103163203.72768-2-leobras@redhat.com>
To: Leonardo Bras <leobras@redhat.com>
Cc: linux-riscv@lists.infradead.org, will@kernel.org, peterz@infradead.org,
 boqun.feng@gmail.com, mark.rutland@arm.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, guoren@kernel.org,
 parri.andrea@gmail.com, geert@linux-m68k.org, mingo@kernel.org,
 andrzej.hajda@intel.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed,  3 Jan 2024 13:31:58 -0300 you wrote:
> While studying riscv's cmpxchg.h file, I got really interested in
> understanding how RISCV asm implemented the different versions of
> {cmp,}xchg.
> 
> When I understood the pattern, it made sense for me to remove the
> duplications and create macros to make it easier to understand what exactly
> changes between the versions: Instruction sufixes & barriers.
> 
> [...]

Here is the summary with links:
  - [v1,1/5] riscv/cmpxchg: Deduplicate xchg() asm functions
    https://git.kernel.org/riscv/c/4bfa185fe3f0
  - [v1,2/5] riscv/cmpxchg: Deduplicate cmpxchg() asm and macros
    https://git.kernel.org/riscv/c/07a0a41cb77d
  - [v1,3/5] riscv/atomic.h : Deduplicate arch_atomic.*
    https://git.kernel.org/riscv/c/906123739272
  - [v1,4/5] riscv/cmpxchg: Implement cmpxchg for variables of size 1 and 2
    https://git.kernel.org/riscv/c/54280ca64626
  - [v1,5/5] riscv/cmpxchg: Implement xchg for variables of size 1 and 2
    https://git.kernel.org/riscv/c/a8ed2b7a2c13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



