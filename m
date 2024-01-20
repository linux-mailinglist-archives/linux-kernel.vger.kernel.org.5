Return-Path: <linux-kernel+bounces-31903-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 39A87833635
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:11:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E48C1282C0D
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:10:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A31156C5;
	Sat, 20 Jan 2024 21:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ncG4baLy"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B82D2154AE;
	Sat, 20 Jan 2024 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784992; cv=none; b=PsCyCnus+Hu7j5fo9bO2V4v7igc1Ph5pBii7a6XTP5vDJVvVWvKovTfMXsR/zZnJqcdXtHpV5X60DRxOMdNjz0El/24R2dcxvLHOtqNPtHLwUgsUf5iA21m5L0OZ0c93DyUX8kcB7AN9EuuJFRd8XUVQbv/od+DNffeX+q41Rb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784992; c=relaxed/simple;
	bh=Rp5EUqsK/zub74udKI73W3OYZb8MEebPJJcJBbBEBqQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ExmyYjVKWeaXPOEALthsus/LJQb161E8TEVDrFfyjwD/IFSBEjNEBNfrHETNaMH+6kN8sHiYcbN1DWZykvxEdvNm5XkyppruzjSsaWF0bAMemuPolDhLrjkdM5AUHP/kMyeSR8lBQfPS2xkaKuhXAah6jBiIJQPEhgNm/tBjvGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ncG4baLy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3A8E3C43390;
	Sat, 20 Jan 2024 21:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784992;
	bh=Rp5EUqsK/zub74udKI73W3OYZb8MEebPJJcJBbBEBqQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ncG4baLylKP+ss4CNXGIlS1a6uVEW90QY99EMGmgpt4V0oF/pEjWEZ3npunq0fl94
	 6PShq8XUgcdedvfzb/WzPJFqk0JtjmvcUPRYOzk0iNlMKX8YNyCcm+ak7wj9Cs0cQ0
	 nYdvbHahPXimCBXcoo/hRh31unWRJgPFFXQANqeWvuw1gUb1052zmkYbcwW8lH3JNy
	 UferhTZ58Bmo4LtIjuw6GElQDqC1PevMsZITHmk7jIkMPCrGudcbfNOBvQcvgU4wUP
	 b2WVtO6lkZuexwY2RgZZyq4EE1kc6h0RZ0V/MEDn2mCQykMUkd9XAAR3j8w4O3c98P
	 WXy4hDcSfDJug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2A88ED8C96C;
	Sat, 20 Jan 2024 21:09:52 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v6 0/5] RISC-V SBI debug console extension support
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578499217.24348.10595488871949157918.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:52 +0000
References: <20240119113449.492152-1-apatel@ventanamicro.com>
In-Reply-To: <20240119113449.492152-1-apatel@ventanamicro.com>
To: Anup Patel <apatel@ventanamicro.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, gregkh@linuxfoundation.org, jirislaby@kernel.org,
 conor@kernel.org, ajones@ventanamicro.com, linux-serial@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 19 Jan 2024 17:04:44 +0530 you wrote:
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
  - [v6,1/5] RISC-V: Add stubs for sbi_console_putchar/getchar()
    https://git.kernel.org/riscv/c/f503b167b660
  - [v6,2/5] RISC-V: Add SBI debug console helper routines
    (no matching commit)
  - [v6,3/5] tty/serial: Add RISC-V SBI debug console based earlycon
    https://git.kernel.org/riscv/c/c77bf3607a0f
  - [v6,4/5] tty: Add SBI debug console support to HVC SBI driver
    (no matching commit)
  - [v6,5/5] RISC-V: Enable SBI based earlycon support
    https://git.kernel.org/riscv/c/50942ad6ddb5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



