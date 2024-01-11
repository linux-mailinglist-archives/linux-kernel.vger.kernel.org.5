Return-Path: <linux-kernel+bounces-23742-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EEFE682B101
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:52:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8DE201F22AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2954E51C20;
	Thu, 11 Jan 2024 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i/3EBLIO"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70EB24CB5E
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0C818C4167E;
	Thu, 11 Jan 2024 14:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704984638;
	bh=iGnhSFR4oy8vML/vLeOSYSO2FOyqacVWkaXJJeDyNUM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=i/3EBLIOo6blQ/RTham11oq8xEbA+ix9e1GUFP3qr5Km+lP4dFbNgj8zfhJWUc6wn
	 Gw6IIhtXLXdCmd8hKsAR80QhMetUXYHI2tA9Dy5/1Y3GPw5zywjjHLSPOogx3QW8OY
	 4W6TqQByS4uC2WiNITnApAg1Hi647lv+u1b7Hd8VeQ8fVwtkRaAMLmSMcEsOHz6Tsh
	 0/oqIa6vmzPmxY4Ud8xRbNUD/nbafrwlkRkYXd7YKnrg/GRn1yXayYYatPaqksCbGj
	 HDt+A9yiXCY6tBVw0Ee2oN6kRT9p3Tc5Rn7RUJt1kvXoQo9t4Pfqz7K7SniATUKiVZ
	 GQRYFXvMmcYWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id ED18FD8C975;
	Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv; fix __user annotation in save_v_state()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170498463796.20080.14961218265938269771.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jan 2024 14:50:37 +0000
References: <20231123142708.261733-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20231123142708.261733-1-ben.dooks@codethink.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 23 Nov 2023 14:27:08 +0000 you wrote:
> The save_v_state() is technically sending a __user pointer through
> __put_user() and thus is generating a sparse warning so force the
> value to be "void *" to fix:
> 
> arch/riscv/kernel/signal.c:94:16: warning: incorrect type in initializer (different address spaces)
> arch/riscv/kernel/signal.c:94:16:    expected void *__val
> arch/riscv/kernel/signal.c:94:16:    got void [noderef] __user *[assigned] datap
> Fixes:  8ee0b41898fa26f66e32 ("riscv: signal: Add sigcontext save/restore for vector")
> Signed-off-by: Ben Dooks <ben.dooks@codethink.co.uk>
> 
> [...]

Here is the summary with links:
  - riscv; fix __user annotation in save_v_state()
    https://git.kernel.org/riscv/c/869436dae72a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



