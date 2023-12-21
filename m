Return-Path: <linux-kernel+bounces-7769-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E3081ACD6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 04:00:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A02FBB24F70
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 03:00:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B5CF4696;
	Thu, 21 Dec 2023 03:00:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lt9OOwBl"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68D44404
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 03:00:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6582FC433C9;
	Thu, 21 Dec 2023 03:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703127624;
	bh=DlB1PsE5QvFJiR3jLnenmYmuaHLaOGUOCHYp8CiFS6E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lt9OOwBlmb6xtJ8woQBRH3zDl5C/1DAxRLGUgpfp2e4sxK1tlaZ8zwTD+8EDf46Tp
	 YZRuXwDvg7+KylexDwGlDPeBWaTwAngOuoj7It/n2HMwInWmTHUXlmqI+OGQGOsOlY
	 ARipeoBwTQ+85PkUfU2eBQqUFKWuced1HcI5vZ5ZFoCECdX60kOpO7Ju1cBNK3dvuC
	 uyEB/vKskMMOEMsGC2jzpOmpwWd5f8PofK64t34yAz5Z+cOqwTAyAzckzsFkcCI3wo
	 84bQ6Lmd6x2zZc7zeiegn4487IrBj8Wlg4OMaZPeRWlBki9Eu/UQI7uiyQQJkBeuio
	 3dCr2XsR2+sZg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E284C561EE;
	Thu, 21 Dec 2023 03:00:24 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes 0/2] Fix WX mappings in the linear mapping after module
 unloading
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170312762431.27922.8717451486214293003.git-patchwork-notify@kernel.org>
Date: Thu, 21 Dec 2023 03:00:24 +0000
References: <20231213134027.155327-1-alexghiti@rivosinc.com>
In-Reply-To: <20231213134027.155327-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, vincent.chen@sifive.com,
 zong.li@sifive.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 13 Dec 2023 14:40:25 +0100 you wrote:
> I fell onto a bunch of WX mappings in the linear mapping after a module
> gets unloaded, this is because our module_alloc() does not set the
> VM_FLUSH_RESET_PERMS flag (patch 1) and that
> set_direct_map_default_noflush() must clean the X bit (patch 2).
> 
> Note that the Fixes tags are correct but patch 2 will fail to apply
> since a change in this function just landed in 6.7.
> 
> [...]

Here is the summary with links:
  - [-fixes,1/2] riscv: Fix module_alloc() that did not reset the linear mapping permissions
    https://git.kernel.org/riscv/c/2f748fa7b60a
  - [-fixes,2/2] riscv: Fix set_direct_map_default_noflush() to reset _PAGE_EXEC
    https://git.kernel.org/riscv/c/3b5c14361d61

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



