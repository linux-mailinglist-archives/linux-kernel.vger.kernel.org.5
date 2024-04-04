Return-Path: <linux-kernel+bounces-132199-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AC28899139
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 00:21:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEA2E1F23251
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Apr 2024 22:21:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CAF413C826;
	Thu,  4 Apr 2024 22:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KzoNgv3q"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F95E13C3EF
	for <linux-kernel@vger.kernel.org>; Thu,  4 Apr 2024 22:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712269232; cv=none; b=TJKkOM+F4f9KQoZOai8N6eTSrZOoyakI7kGoLuMCAHnHukZ0ALN4xhqNBisRJby5CX3CX5MhUNbpYR5qG03wBWmEEJ9L+WyLXxnpEHys6TmV2Xyy8o0ltLxLDgv4Zu4S7Xf+dYLo/ZgXspJP3oCORGMnwPgHlHyoSCFhwxATV0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712269232; c=relaxed/simple;
	bh=ITc7lhybI9dOMuknPIwOvjsPCGJG6azRtbKJsWOMuF4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=g24cLUsRnocw4EhRpBZgFHy8P5Rjtw2G6jPO5CwyxAzeOGuApXReSYuRwD+ccA2+qFRoPYbLerP0izbiZ+oO9JdlCLLP3TygqgHqt0CD//A0MZcZWAxIOUR11G5306EmFWjwrAVSAlfMugZJsOnaCY48njLrcB6gni4ngAHp82Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KzoNgv3q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 30B19C433F1;
	Thu,  4 Apr 2024 22:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712269232;
	bh=ITc7lhybI9dOMuknPIwOvjsPCGJG6azRtbKJsWOMuF4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KzoNgv3qqEMfvifn/aFpHeHtWDLxRInKP4Ys41Y6MVtbc0sBdvxABkFmXEzqoRTRG
	 emDga91/39sQhaRcQE0MiXo9hHm9PtrSX2lB80hc2n+PIbQ5MCTXN8oADLAp+KbHWf
	 cQELvjswRZyHsC6wlilCc6uwxqgrrj7PXCu63MdSLpa70Rx+CqHIUkiDes2IM+x9e3
	 sxHFXwpJe5vzD5ChjCv7vLZG0QRVKbEp0qihT7l6hSOaUxWdtwbA4hChN0708A6XuN
	 X3ZZtVyBlRXCAK6qKyswktdyW1D7vmldhyknWN9+yFaRy5saoPGun4LTw09G4YAr2a
	 zXMNwREznDJHQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 17970D84BAE;
	Thu,  4 Apr 2024 22:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/2] ftrace fixes
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171226923209.6067.4357956363525619450.git-patchwork-notify@kernel.org>
Date: Thu, 04 Apr 2024 22:20:32 +0000
References: <20240326203017.310422-1-alexghiti@rivosinc.com>
In-Reply-To: <20240326203017.310422-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, jszhang@kernel.org,
 bjorn@kernel.org, pulehui@huawei.com, daniel@iogearbox.net,
 puranjay12@gmail.com, zong.li@sifive.com, mhiramat@kernel.org,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 26 Mar 2024 21:30:15 +0100 you wrote:
> Both were reported recently as there are efforts ongoing to
> reimplement ftrace on riscv and both are independent of this rework,
> so here they are.
> 
> Alexandre Ghiti (2):
>   riscv: Fix warning by declaring arch_cpu_idle() as noinstr
>   riscv: Disable preemption when using patch_map()
> 
> [...]

Here is the summary with links:
  - [1/2] riscv: Fix warning by declaring arch_cpu_idle() as noinstr
    https://git.kernel.org/riscv/c/8a48ea87ce89
  - [2/2] riscv: Disable preemption when using patch_map()
    https://git.kernel.org/riscv/c/a370c2419e46

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



