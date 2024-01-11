Return-Path: <linux-kernel+bounces-23741-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CE5F82B0FF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EFF6C28764B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294FB51038;
	Thu, 11 Jan 2024 14:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hXwEmxrb"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632D24BA99;
	Thu, 11 Jan 2024 14:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2BA3C43609;
	Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704984638;
	bh=poNz0ZTftVJwt7XbLawzBiVnhFM+TAQwKnLBWaeIY2A=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hXwEmxrbdHXjEbjKT9cmMGDMp+soTGur9boVUpX+yeXIiv8b/u8G07PEnaRSiyW8R
	 edIyBL50tFk+tmk7o5ApNztR7sVfp6uPBu1W/3M2OhYjlfSXp3HAq9AG4DICw+c5vg
	 nM4Th8RmkSpe8yPk0RibQysBTzv/dzIqqNAMDZC+mRV37CNFOJFf+EwAuTZ53ZsjW8
	 k68dOyaYeWRvO5J04bjhvjgnBUI/QWE4ngvvRNgFQ6NSY3icogjF+fJOGZAARhYryy
	 E8La/cu6qcGeBEzqFHwyJrTbFJiwtUXHc49IYMH0ac+nTlDwYCxam9b2BLi4abZYQ1
	 OLeNk5edMfekA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDBA3DFC698;
	Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v5 0/5] RISC-V SBI debug console extension support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170498463783.20080.10723421328706946354.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jan 2024 14:50:37 +0000
References: <20231124070905.1043092-1-apatel@ventanamicro.com>
In-Reply-To: <20231124070905.1043092-1-apatel@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 conor@kernel.org, ajones@ventanamicro.com, linux-serial@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 24 Nov 2023 12:39:00 +0530 you wrote:
> The SBI v2.0 specification is now frozen. The SBI v2.0 specification defines
> SBI debug console (DBCN) extension which replaces the legacy SBI v0.1
> functions sbi_console_putchar() and sbi_console_getchar().
> (Refer v2.0-rc5 at https://github.com/riscv-non-isa/riscv-sbi-doc/releases)
> 
> This series adds support for SBI debug console (DBCN) extension in
> Linux RISC-V.
> 
> [...]

Here is the summary with links:
  - [v5,1/5] RISC-V: Add stubs for sbi_console_putchar/getchar()
    https://git.kernel.org/riscv/c/f503b167b660
  - [v5,2/5] RISC-V: Add SBI debug console helper routines
    https://git.kernel.org/riscv/c/f43fabf444ca
  - [v5,3/5] tty/serial: Add RISC-V SBI debug console based earlycon
    https://git.kernel.org/riscv/c/c77bf3607a0f
  - [v5,4/5] tty: Add SBI debug console support to HVC SBI driver
    https://git.kernel.org/riscv/c/88ead68e764c
  - [v5,5/5] RISC-V: Enable SBI based earlycon support
    https://git.kernel.org/riscv/c/50942ad6ddb5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



