Return-Path: <linux-kernel+bounces-161586-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BEAAD8B4E60
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:00:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F94F1F20FA5
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:00:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01EAA10961;
	Sun, 28 Apr 2024 22:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HFePvE/R"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 376301C14
	for <linux-kernel@vger.kernel.org>; Sun, 28 Apr 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341635; cv=none; b=QtsFgQEIxl7XNUu666ETpmpVN9U/L6y4UfTyrofHJ34fGxo7u8VYKBLlII/aXkW2ktyou86SAAMCoG0O9WoGISxfqUVKBCMUyBDQfZXJh6uYtSJbTh2br7CqUA+qz97rK2Ds37ct84bKTyrRyfYHyoHlT4wu4o+DYNfCX4/O+Ns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341635; c=relaxed/simple;
	bh=i0lgj4Gi4l7oqdJ7DvxdlIR0OkstYyRvXjI4yj9zdRo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=EYsfN8sONAZmS4pmb5KoJz5vidQ5mbdDDMlYNjPVbmKcVAU2kkukWTqb38WiokU7oX5DCkwK+gRV8Td4KJouY/6nTIxAuo3Vy2B95aZzQc26cZ9hyDw3xjBeDw0MnxfNuJwy1r80RDOF7Vi2MbcZ1/gEs198Elp3vHMRdtKaJho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HFePvE/R; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E4C54C4AF1D;
	Sun, 28 Apr 2024 22:00:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714341635;
	bh=i0lgj4Gi4l7oqdJ7DvxdlIR0OkstYyRvXjI4yj9zdRo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HFePvE/RtKH5Z6L5x9jhbEi8evaKNPLoBTsa4exJ6iHJHGMnIZa9Gs12Blr+04Zfa
	 AUMZQ+KhknlXyFoc9+0tIAK1det3byxvh3G283lbaVWw2El3zKRJc9AX2WtPsarDjk
	 Mg1cwWrbFaDANMRPXIpl/ufu9auK1/3B2+UphJtOYd9YsXPTKJN3ESD7AWtVZXF4xh
	 9j1ZeLhUJ2WNmjdDNN5KnLdOBxXhR654ga6RFGbkucalf8FTOXgtu/DG7FZCmTIjJb
	 EoTBKGhc9fTs0GgYcZEOrM/dsM/y/A+R8YgMKDPQR15ePzjs7uHxhe21/ObDkWmaGg
	 yf0oHbOXpbrhQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7432C4167D;
	Sun, 28 Apr 2024 22:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 RESEND] riscv: select ARCH_HAS_FAST_MULTIPLIER
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171434163487.22130.12031747809558123919.git-patchwork-notify@kernel.org>
Date: Sun, 28 Apr 2024 22:00:34 +0000
References: <20240325105823.1483-1-jszhang@kernel.org>
In-Reply-To: <20240325105823.1483-1-jszhang@kernel.org>
To: Jisheng Zhang <jszhang@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 samuel.holland@sifive.com, alexghiti@rivosinc.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 25 Mar 2024 18:58:23 +0800 you wrote:
> Currently, riscv linux requires at least IMA, so all platforms have a
> multiplier. And I assume the 'mul' efficiency is comparable or better
> than a sequence of five or so register-dependent arithmetic
> instructions. Select ARCH_HAS_FAST_MULTIPLIER to get slightly nicer
> codegen. Refer to commit f9b4192923fa ("[PATCH] bitops: hweight()
> speedup") for more details.
> 
> [...]

Here is the summary with links:
  - [v3,RESEND] riscv: select ARCH_HAS_FAST_MULTIPLIER
    https://git.kernel.org/riscv/c/0a16a1728790

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



