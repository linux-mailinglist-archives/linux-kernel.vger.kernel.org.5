Return-Path: <linux-kernel+bounces-7770-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id AD8DE81ACD5
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3C359B24F92
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:00:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA93C46B5;
	Thu, 21 Dec 2023 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qnNDqOFE"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6E094416
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C2AEC433C7;
	Thu, 21 Dec 2023 03:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703127624;
	bh=7p5HpM/silOKEV2d1IqFkK6Ov7Jg7fNgmjXE6MgPWkM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=qnNDqOFEQFNcm4pqwvBa3xZKbpYBu3TkzZwE4yGybTuhcJwqbJP6rUt2i3JysPj8J
	 bmUk2VFSGfY87PURS7y/IWBc7dLVHU2lnRuwI+Vy/aQmm0kLlMo6LTm12P9zMi+/+r
	 cVZJR4BqV6Z4vZz+YGLUnhN6eaEC9o3L14IQ3uGafILtQstL6s9iboSWSNSwCJUbIN
	 XeiNPHCpaCUHVxx2IYYg0vx8DIhCb1FwZGZabc3FhM+2FcNmaPwrATXJet6jiT75XR
	 y3Yu+A7AfgLCwDzN2+PyMqnmpUaM/42Ay9qJN+CY+IlT+cYNSZOKZRMXy3ftVQEpqz
	 haQPHVkAbC/Dg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 55B46DD4EE7;
	Thu, 21 Dec 2023 03:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes v2] riscv: Fix wrong usage of lm_alias() when splitting
 a huge linear mapping
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170312762434.27922.5406606190736604127.git-patchwork-notify@kernel.org>
Date: Thu, 21 Dec 2023 03:00:24 +0000
References: <20231212195400.128457-1-alexghiti@rivosinc.com>
In-Reply-To: <20231212195400.128457-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 syzbot+afb726d49f84c8d95ee1@syzkaller.appspotmail.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 12 Dec 2023 20:54:00 +0100 you wrote:
> lm_alias() can only be used on kernel mappings since it explicitly uses
> __pa_symbol(), so simply fix this by checking where the address belongs
> to before.
> 
> Fixes: 311cd2f6e253 ("riscv: Fix set_memory_XX() and set_direct_map_XX() by splitting huge linear mappings")
> Reported-by: syzbot+afb726d49f84c8d95ee1@syzkaller.appspotmail.com
> Closes: https://lore.kernel.org/linux-riscv/000000000000620dd0060c02c5e1@google.com/
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [-fixes,v2] riscv: Fix wrong usage of lm_alias() when splitting a huge linear mapping
    https://git.kernel.org/riscv/c/6af3dd2be9cc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



