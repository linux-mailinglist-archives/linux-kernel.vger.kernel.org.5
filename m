Return-Path: <linux-kernel+bounces-87622-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D03D986D69B
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 23:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6D89F1F23D38
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 22:10:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF62E74C04;
	Thu, 29 Feb 2024 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HhnqoDpI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EB486D53E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709244635; cv=none; b=C2OgJkMa4eVmTPudQJ4UHoalsVZWTY+ueM+7REqk29GP3Qnq00mciO8goI7fJXNMy4brFJ3SOOL0VZaYlKYbTdRF2ucF0rSMcMoW4RmsAQGBzg2B8QV3XemN5HRIWbHZV4rTSOLZ1ijBLknyib24AJ60X0OduqiMMroHNBaAB/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709244635; c=relaxed/simple;
	bh=tUo71G6vN1xdSm/Cxcki/r+K/AKoYBs0PEiPWXD9No8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YRKEygNaWN/XNexwlHPzUPE01DBS7ABGKdvHJrPj6MB4lERgXFfGWs7Dc7VO9ojqo801As5HoLLE9TjyxY9J0l4ZaSULWe4mO+lSgzObdpUyxKo+VFBlcKsLnSUX32p+FuLbFU36aA2a+ucS4bCI8yTSY3JvPQWaTU+DWCJmv54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HhnqoDpI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B7695C43394;
	Thu, 29 Feb 2024 22:10:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709244634;
	bh=tUo71G6vN1xdSm/Cxcki/r+K/AKoYBs0PEiPWXD9No8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HhnqoDpIDEeE/DcU6GIaH1NLVMLEgFwkhn7TnLEkSu1kp9dWR7Ql/gZieWyPdrFU5
	 CwPX7xlukzJxD+UAtPDsbITzX0uTrV64wQvJCdi2FOvjIn3EOcevuxs1YlbglhZKCX
	 jg/74d/7lWpe7rKBmp/4ZcS+9RwfPOcpnyGnI5yTYw0sKdI/4eBmN82PUwq08c5oZu
	 RrsOc7l0WPc08dh3wG2ffAe05yBLDt+LcfBIQJbc91/FPPVrd5nc4jqv6oRCmegcdY
	 uD+5+3hruILgkWzJi6SMjJfcYS/ZHyhRVecwbodhXOnvKCaX4XPOYIDE7zB3Aw2wRv
	 WoLqr0ans9yjA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C723D990A4;
	Thu, 29 Feb 2024 22:10:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes 1/2] riscv: Fix enabling cbo.zero when running in
 M-mode
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170924463463.14902.9593113600242840892.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 22:10:34 +0000
References: <20240212022642.1968739-1-samuel.holland@sifive.com>
In-Reply-To: <20240212022642.1968739-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, ajones@ventanamicro.com,
 palmer@dabbelt.com, linux-kernel@vger.kernel.org, stable@kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 11 Feb 2024 18:26:14 -0800 you wrote:
> When the kernel is running in M-mode, the CBZE bit must be set in the
> menvcfg CSR, not in senvcfg.
> 
> Cc: stable@kernel.org
> Fixes: 43c16d51a19b ("RISC-V: Enable cbo.zero in usermode")
> Signed-off-by: Samuel Holland <samuel.holland@sifive.com>
> 
> [...]

Here is the summary with links:
  - [-fixes,1/2] riscv: Fix enabling cbo.zero when running in M-mode
    https://git.kernel.org/riscv/c/3fb3f7164edc
  - [-fixes,2/2] riscv: Save/restore envcfg CSR during CPU suspend
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



