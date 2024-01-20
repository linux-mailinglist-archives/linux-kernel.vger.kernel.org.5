Return-Path: <linux-kernel+bounces-31900-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 156D483362C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:10:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C299E28227A
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4641428C;
	Sat, 20 Jan 2024 21:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aOPKD02L"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C30412E5F
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 21:09:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784988; cv=none; b=ozFn9y5YzZIMeGVU1DKEUDMinuBrvajiFYM27f28k3+0eSzELwie9gV50D9UCRWc+Qml4QEw9ciUC7726OOmNpuurBOAdfbXP7yOjtlBn0BEdPau6kLbNsbYt9lSHRFg7SuhppGaenHh1yQ/SrB6GqWg4aZgrIs8B9SviCA7tAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784988; c=relaxed/simple;
	bh=bNkiilsgov/ziqTxm0fKOOWZnPue85pExT1FEtv2t1w=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ALQWfH7jeRqq4S2MQC55VZbRaEQHcyuxH9dZm4gf+dihN3JZ/yW5bZK/CGW1lmsEXY8XWcQ9NKo2jv7DTxtVounZ0SI8S8fXiHcBN0WoZ3up7GN3xiYVPZjBPgutdaAeGU49ujvCwd+gfa3XQ4j7kwmvF5HAJpTBhYpSloNnvn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aOPKD02L; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8B6CCC433F1;
	Sat, 20 Jan 2024 21:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784987;
	bh=bNkiilsgov/ziqTxm0fKOOWZnPue85pExT1FEtv2t1w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aOPKD02LaWcihHz6A2D2EmoHJGpZG+DenkDQxfZo9Vp/DXj/b+9K131PT5VChef1Z
	 DRwsBO1507eN5pMwbW0oNXW6iwMhBcYh0FZ4ZHe/tBH4roGPDhfsSELwxiwaKZvYbl
	 ITpvJ67ovyUnDjtvcOpmRsf3DAS5dvX/zrWjrr3HlY00cxT2VpgBKar0eMSTBaP8dY
	 /1/PJtdv35ZGAjnQ5oTbz0WKdPlDWoQxxBqQoVQlvoJ3gZhopGMO+5pch5Zrybi/aO
	 UBBvkq27YpD3FCA4MUMjost+pI9Ig19rAMRjRcRnV5j1oDtNvmMT3CSdySFzJ1AyXk
	 Jkv0LqpS4LVkQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 74393D8C978;
	Sat, 20 Jan 2024 21:09:47 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] RISC-V: Implement archrandom when Zkr is available
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578498747.24348.16243159445263810097.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:47 +0000
References: <20231130111704.1319081-1-cleger@rivosinc.com>
In-Reply-To: <20231130111704.1319081-1-cleger@rivosinc.com>
To: =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 sameo@rivosinc.com, ben.dooks@codethink.co.uk, conor.dooley@microchip.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 30 Nov 2023 12:17:02 +0100 you wrote:
> From: Samuel Ortiz <sameo@rivosinc.com>
> 
> The Zkr extension is ratified and provides 16 bits of entropy seed when
> reading the SEED CSR.
> 
> We can implement arch_get_random_seed_longs() by doing multiple csrrw to
> that CSR and filling an unsigned long with valid entropy bits.
> 
> [...]

Here is the summary with links:
  - [v2] RISC-V: Implement archrandom when Zkr is available
    https://git.kernel.org/riscv/c/102434010592

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



