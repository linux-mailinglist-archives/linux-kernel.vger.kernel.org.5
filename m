Return-Path: <linux-kernel+bounces-39318-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8791B83CEAB
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:31:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 296902855DF
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B235513BEBF;
	Thu, 25 Jan 2024 21:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQvcmpdN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1570313AA22;
	Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706218230; cv=none; b=ZRjCME1jedsiZnjiA1P7ggUEHO3ASjMny19Bx3UK66tAnVEKDP/UO1vuinL7k0FaIske47tu8flCmauIPb2bmf/yZz3X4YAefz74+YogittFoXbzDYiRgMeYnZ7QIYAweOqx1xAVF9FUT4UYdaqHs6h17cxK+K0Vk4gz5C/IyYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706218230; c=relaxed/simple;
	bh=X2mNprfouPEmvBoKw8baKQx7oOuTfhqFfvOx4U8Q8wU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=iKF5dFXclga5g+HpFVTztzfP7nEuLSEPZ4hOrRo4EPtK79/HgcmeGOmUF7olTBn2QKyPfs6pbG014B0c5XPCYMiooSZjnP09n9S5fm2rb98Im6ctv/DVLkBgYE/AJSh7SKxrB7J2zC6BWarh6zYWJWDYWmOPll6aysJiC9/V1+U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQvcmpdN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 70F08C43601;
	Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706218229;
	bh=X2mNprfouPEmvBoKw8baKQx7oOuTfhqFfvOx4U8Q8wU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XQvcmpdNzt0ETY1MUWWfaBPOe9ZLr+MHgLnmCec4ax5XDwFNheBmLQQiAa7dNpbnR
	 A8ErelEO4mNiAHDgU5lSz3NJKX8mtlEH2i4QNJVcdMoe3wVt+HVdIFrKWXme8krD8V
	 /cRzq0f+AOYf4fUypSykgJYIqQ5vB++Bqnl++GKZjmgBE0d0PaVaQpD3TethO7rX2j
	 z/kmGB5QoXDmC6OY8mbQ2JWWE9urYtmoYh+BPE+h2cB5rW+cu0eep+qilNpEDsOZ7R
	 EUjLFNLBLx/vuLwYRBwNkUxRnix2NHnvLllsEFOloLdESJyuEAvPm6jhLf2BQDHuoB
	 0Yqn2vdq1RIJA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5CFCDDC9A06;
	Thu, 25 Jan 2024 21:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH V2] riscv: Support RANDOMIZE_KSTACK_OFFSET
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170621822937.6239.4360145858676634125.git-patchwork-notify@kernel.org>
Date: Thu, 25 Jan 2024 21:30:29 +0000
References: <20231109133751.212079-1-songshuaishuai@tinylab.org>
In-Reply-To: <20231109133751.212079-1-songshuaishuai@tinylab.org>
To: Song Shuai <songshuaishuai@tinylab.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, keescook@chromium.org,
 guoren@kernel.org, bjorn@rivosinc.com, jszhang@kernel.org,
 conor.dooley@microchip.com, andy.chiu@sifive.com, samitolvanen@google.com,
 coelacanthushex@gmail.com, dlemoal@kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, palmer@rivosinc.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu,  9 Nov 2023 21:37:51 +0800 you wrote:
> Inspired from arm64's implement -- commit 70918779aec9
> ("arm64: entry: Enable random_kstack_offset support")
> 
> Add support of kernel stack offset randomization while handling syscall,
> the offset is defaultly limited by KSTACK_OFFSET_MAX() (i.e. 10 bits).
> 
> In order to avoid trigger stack canaries (due to __builtin_alloca) and
> slowing down the entry path, use __no_stack_protector attribute to
> disable stack protector for do_trap_ecall_u() at the function level.
> 
> [...]

Here is the summary with links:
  - [V2] riscv: Support RANDOMIZE_KSTACK_OFFSET
    https://git.kernel.org/riscv/c/05d450aabd73

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



