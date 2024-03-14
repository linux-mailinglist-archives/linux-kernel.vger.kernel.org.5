Return-Path: <linux-kernel+bounces-103243-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 149EE87BCD7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:31:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C44F12845A7
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 12:31:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 509FA6FE1D;
	Thu, 14 Mar 2024 12:30:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fvZy+mwd"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 933FF56440
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 12:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710419432; cv=none; b=EgQktVYd6HaYQc0oDwSJet8pwmZIvATRcHu+0PCbhdlrKhthmASZUl1llIYL3sDYZYochm2qq2D6jf++oYIXwB4uCeHCc7bDf0a52OXttYBn4GH6QtWeGyfhkWwWg1j7OX2cU+qcJH/QswgIwuT81Ibr1YJOiYHSbXM24+GmXkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710419432; c=relaxed/simple;
	bh=ZfYdgQYYHUKBjDat7ZMzQdGoJdurRPJ2XJ2xHAHrl0k=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=jQ1ueein/7km/wdbV1AlLdwy8DP/LVtcb0Nje7Gy6z0ZmY4E5YJqdewYU4NELno2g0A9iqmjfmCFcgoGfVbhqq+A1bHtiChBw7hZGBFvO/4tZkDxYSsGrBdzJLYidvGeBV5XpRUMGoHtBAQhL2CgUFKmkir2SErl9srd56OnpgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fvZy+mwd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 10E2FC43390;
	Thu, 14 Mar 2024 12:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710419432;
	bh=ZfYdgQYYHUKBjDat7ZMzQdGoJdurRPJ2XJ2xHAHrl0k=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fvZy+mwdyc+wi8ZKZlrat5Iavdozk1eOUJq027QwMf1q4vElyuHBKQUk53/y+IrjA
	 dkh1XtQCx9Oh8rP2VvqQmulX9otGgVzP22b3y/E2yCeA9ldN6pFuBXvsew1gKL4t/9
	 +mHw3CVMPBcsFg0kuE9BrYcAo56JuaK/H5YMUyhO0mthCQq+q0XNffKgJESzgwXdet
	 SODh7t4dD9cdhNy2joxs/xxthWTu2IhIjCZD3prqOPTn8vxv3LT9V/p6BJe/sNQuRD
	 6tEero+cAZlwGze+34IMsyZV0vgJa8OR5YC8gi+VUZPxjaVrwlApwMW9sRyzIIYee/
	 DvLC14o6z7q3g==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 02D22D84BB4;
	Thu, 14 Mar 2024 12:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v9 0/4] riscv: Use Kconfig to set unaligned access speed
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171041943200.26728.3861424010420812739.git-patchwork-notify@kernel.org>
Date: Thu, 14 Mar 2024 12:30:32 +0000
References: <20240308-disable_misaligned_probe_config-v9-0-a388770ba0ce@rivosinc.com>
In-Reply-To: <20240308-disable_misaligned_probe_config-v9-0-a388770ba0ce@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, jszhang@kernel.org,
 evan@rivosinc.com, cleger@rivosinc.com, ebiggers@kernel.org,
 quic_eberman@quicinc.com, lohr85@gmail.com, conor.dooley@microchip.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Fri, 08 Mar 2024 10:25:54 -0800 you wrote:
> If the hardware unaligned access speed is known at compile time, it is
> possible to avoid running the unaligned access speed probe to speedup
> boot-time.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> ---
> Changes in v9:
> - Clarify wording for RISCV_MISALIGNED Kconfig option
> - Link to v8: https://lore.kernel.org/r/20240307-disable_misaligned_probe_config-v8-0-55d696cb398b@rivosinc.com
> 
> [...]

Here is the summary with links:
  - [v9,1/4] riscv: lib: Introduce has_fast_unaligned_access()
    https://git.kernel.org/riscv/c/5a83e7313ee1
  - [v9,2/4] riscv: Only check online cpus for emulated accesses
    https://git.kernel.org/riscv/c/313130c62cf1
  - [v9,3/4] riscv: Decouple emulated unaligned accesses from access speed
    https://git.kernel.org/riscv/c/6e5ce7f2eae3
  - [v9,4/4] riscv: Set unaligned access speed at compile time
    https://git.kernel.org/riscv/c/f413aae96cda

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



