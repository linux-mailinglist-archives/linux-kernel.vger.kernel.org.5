Return-Path: <linux-kernel+bounces-138722-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49EA789FA47
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:45:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9B1D3B34C42
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D80B16C6AD;
	Wed, 10 Apr 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a7uAUX4K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB3715FA61
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758229; cv=none; b=JNAkfg97FHn2jb1PlqGeaWZ0VB7tWgW2E/NkvhaLDKXt05THPYJqFidlbx6JGKNONfu6Zc/n14wkRC3/JKOlV/UKXMvTUgGsO4GWqC99yWTA/XbzO8a+v1no9n+h52gU5+/WCYNF9mRIXlh17isXH+3rCyQlcC6bhtQw156YOGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758229; c=relaxed/simple;
	bh=pA2puDfsXBvwxZQ8Kq+VZtCBdu+BVDgjdRVe7SG11Mc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=BZimx6A+wlrBbo3lbpRcmcJmCWr3xzMP9YVoK0CQnRtAFZstu5Xct5+VWpEll7CGFtA9tJeTL+pKG3p44P6+Zjf0W6Clo4ditClvCEvQ/WQKTxThimyRd1w8zS5ZhPc0IrjRaUX5NPo5Bd/az/7smbycVi8RQkQwmA9DfA0qDzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a7uAUX4K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 57F19C433C7;
	Wed, 10 Apr 2024 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712758229;
	bh=pA2puDfsXBvwxZQ8Kq+VZtCBdu+BVDgjdRVe7SG11Mc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=a7uAUX4KZ/UY8dG3Usm2Qf3HmQzaXTXlc/s1+Udy1KBMBMcibRnHp5KFeTwPM1Ul6
	 u2l0YcUu57K0c8f55z1+4ChI2e89Aa1iZ0mrcxKHFN5+ghDyXbHcd0TjJEmBXJ5OpP
	 yMvETvgC40y/BQWipNVYl3ESaJuE00WPRcUtkQVqN+A/apcjq/Fh316GVcK6Tw9OjH
	 Yi7XZcpBFMgf51JZC05yDDWjQf2BE/KeEeYAbgJ6QJvXT9h5KWMQizW84k3/nY1ycg
	 8P00B+w17yNfPqyaJZyJAV426aR5mQ4mhXk0TuLIvZ6kYvHWHoLAg/Vsj2hxD5ClXS
	 BCdKX1stOCFHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 45BCDC395F8;
	Wed, 10 Apr 2024 14:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: Remove unused asm/signal.h file
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171275822928.12683.16257664003820380019.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 14:10:29 +0000
References: <20240330111308.2053965-1-shorne@gmail.com>
In-Reply-To: <20240330111308.2053965-1-shorne@gmail.com>
To: Stafford Horne <shorne@gmail.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 guoren@kernel.org, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, bjorn@rivosinc.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 30 Mar 2024 11:13:05 +0000 you wrote:
> When riscv moved to common entry the definition and usage of
> do_work_pending was removed.  This unused header file remains.
> 
> Remove the header file as it is not used.
> 
> I have tested compiling the kernel with this patch applied and saw no
> issues.  Noticed when auditing how different ports handle signals
> related to saving FPU state.
> 
> [...]

Here is the summary with links:
  - [v2] riscv: Remove unused asm/signal.h file
    https://git.kernel.org/riscv/c/3dfbd2d26b64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



