Return-Path: <linux-kernel+bounces-31914-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D5E883364F
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:13:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD817B229B7
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:13:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83ACA28E18;
	Sat, 20 Jan 2024 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iJI69Cs1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A2D208AE
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784999; cv=none; b=i5NbA32/3KuC40srAcx73B1zvX632zJzLQyOUI+y1nt3atZeToGPeEoCy5pI/0P4GJ71kDSsJs0EBU7sjIA9zQ2UuUYP9ZTu0U3wYST80w6YEIx+tKV63vbUzr7fQm3CREi5EymGG7Et/vZGsFKsVZw9QhH4up/CAdH22wVm4zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784999; c=relaxed/simple;
	bh=Uc9RmMV/bChQHcwZy6eVR8V+6YZdJL9xxLXYJdzSFVk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=CLshllKXA/b0DlgxAU+sHbiZ77Y+3hPNFqMZn8NiWvsatvXS1Ctq8bOEf7Ns2YLA5AN/s6WoxLnXpAHDvScn34wjLD6WVrsujH5biTeMk9/E0TndE6YUU922NDE8WKtxTiORkTs8PoyewbgFi2fdM2Gfnbn/vufxkJdZnIZgpn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iJI69Cs1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3E057C43609;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784999;
	bh=Uc9RmMV/bChQHcwZy6eVR8V+6YZdJL9xxLXYJdzSFVk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=iJI69Cs1UJUXFrDB1btlsmANpWWvbJ99kvEPHdb56qHFlu1bOBTkFRdZq4Ckr3JI8
	 QHT0BnkadFAbz+TNz2sgLuhFWUqfxowUW7W+ZVz4S3rlltTYMg7Y224NGZ7Z0WuT5H
	 JZmcRmlbghoIiCh5ek6oAGFAx0Xc8Or/vVZLO1B7GPdoGQxhB7mtw/RLe3EUuXaByU
	 nEuPVTRQYF5W91pG2W4SfEkQMTQmDH6AXY86UWVlcdlm91iHhzLQDhm+dGsGAB0R2J
	 ghXBKMjYzrhkbQFItYrWb0vVseuAA2gn3lzGaC0IZwNL6Bokpk2W1ObgxCLhYWVS+F
	 GgYGa62h8iyVw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 2B217D8C970;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: lib: Check if output in asm goto supported
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578499917.24348.742461114194301217.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:59 +0000
References: <20240118-csum_remove_output_operands_asm_goto-v2-1-5d1b73cf93d4@rivosinc.com>
In-Reply-To: <20240118-csum_remove_output_operands_asm_goto-v2-1-5d1b73cf93d4@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 18 Jan 2024 14:36:45 -0800 you wrote:
> The output field of an asm goto statement is not supported by all
> compilers. If it is not supported, fallback to the non-optimized code.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> Fixes: a04c192eabfb ("riscv: Add checksum library")
> ---
> The OutputOperands field for asm goto statements is only supported
> starting from GCC 11. Split the asm goto to remove the use of this
> feature.
> 
> [...]

Here is the summary with links:
  - [v2] riscv: lib: Check if output in asm goto supported
    https://git.kernel.org/riscv/c/4525462dd0db

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



