Return-Path: <linux-kernel+bounces-21396-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 707BC828E91
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FD5F1F269C5
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:40:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F44F3D983;
	Tue,  9 Jan 2024 20:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="unzhnCwN"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3BA3D961
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 20:40:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3051AC433C7;
	Tue,  9 Jan 2024 20:40:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704832828;
	bh=QqQqgvArCAFMZzsCuljjBHuZF/IAw38ss/Kp6GE6Tjg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=unzhnCwNzY2FzHAIGxFYL/q2JHHWvjKjX/vpDuWLftJAH2IgvusFhXbttx4yssJdh
	 CJr0+qfrpzrjiIM/jObh5in1gvK5L3fl4SaOvxhNE+4Dbn8zbeF+sz1dXkrZK//3cA
	 aLDHvbMq53tjKk9xFBm1jKufJ/vtN47pcdkSzQldAfo3cJcvtmLtyytSwaBuCbMfrI
	 WTiWgYNwx4YPGKhF2ZudjgnBDR+fL0n5JWFOdOGw629XoRe7FWYilhxapMkcRQgTud
	 AH05MkJjeFwuPrpkT2Hi78U06Jw/wTyEt8bu0fSBPTSxzailwxeFOso0CBg2yv4XPr
	 wQwqO3LBjnd/w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 16E8CDFC691;
	Tue,  9 Jan 2024 20:40:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes v2] riscv: Check if the code to patch lies in the exit
 section
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170483282808.2051.14425561693362087053.git-patchwork-notify@kernel.org>
Date: Tue, 09 Jan 2024 20:40:28 +0000
References: <20231214091926.203439-1-alexghiti@rivosinc.com>
In-Reply-To: <20231214091926.203439-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, zong.li@sifive.com,
 linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 14 Dec 2023 10:19:26 +0100 you wrote:
> Otherwise we fall through to vmalloc_to_page() which panics since the
> address does not lie in the vmalloc region.
> 
> Fixes: 043cb41a85de ("riscv: introduce interfaces to patch kernel code")
> Signed-off-by: Alexandre Ghiti <alexghiti@rivosinc.com>
> ---
> 
> [...]

Here is the summary with links:
  - [-fixes,v2] riscv: Check if the code to patch lies in the exit section
    https://git.kernel.org/riscv/c/420370f3ae3d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



