Return-Path: <linux-kernel+bounces-116531-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8122188A3DF
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 15:14:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E88CB3D35B
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 12:54:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8254079B99;
	Mon, 25 Mar 2024 07:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u6j1C1/e"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33080757FA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 04:59:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711342796; cv=none; b=enMILr53MDDOiug/kzGixUWkZHNReUcUkhAkR+WQ29o1h7QhRfgx+lEu7t5KmYfzq3GkHUK+n6QcyMd9x0ZGnU1SDeQ4V6LgcDREJe505xt5epJTfwo3rm2o0IXGPL452I1YDcODXqW2hljeg960R01J70WBFG1+e/RlIOE4GFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711342796; c=relaxed/simple;
	bh=twiWJG016BhE6H2VQrQhrLXAYDefBJMGhfYkdlH/bJE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Fxuzmu0yr218yMQIDTGirFJ0oUiMECax/lpE83mlmieyYmFY6UYN1J5Xlx2sL6TQh2+kKZ0WF3j4KMHDYiXrtdq8o96psKAeEzylSZkHi7gb7ydiCVAmRME7oL67taZ6ZH1sV4/ReJWSHoT1i5vjSZ2L72TGgTzWbnhjsvCaWus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u6j1C1/e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B83C3C43394;
	Mon, 25 Mar 2024 04:59:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711342795;
	bh=twiWJG016BhE6H2VQrQhrLXAYDefBJMGhfYkdlH/bJE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=u6j1C1/eyAxYa4jflK6bjYjmw02F4pPpmS99/FWyD9u91NqHkAsM4/1wtk5UXpb9N
	 UVzioSos0DdaRyGs9EVyVQfLjXkJuM2qJ1vBX8tBG5olkQCMPj+sNrKE+fjRN6XnGd
	 13fHXtAG2oESQC7TVBum3msoyDth7WJaYf1lRpXmMPUcUNOEdpJTSFwz4jB13vSVt0
	 oFXO6jE4l+QkZXYEs0OGwnypESfejVyDW8bfCiQklzRv+Kse6nNWja87fpw/wgRlh0
	 CHqPA0wHyiP7W8j6Yu2p/pWxwN1p9c0e1W+2aPhIrHWVgxV6odavpMjcVIYTg5tVvH
	 iHW7r9gV648rg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A9825D8BCE3;
	Mon, 25 Mar 2024 04:59:55 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] RISC-V Patches for the 6.9 Merge Window
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171134279569.18749.2557475397474494419.git-patchwork-notify@kernel.org>
Date: Mon, 25 Mar 2024 04:59:55 +0000
References: <mhng-105d6a21-7483-4a20-a9e7-8e72770737d8@palmer-ri-x1c9>
In-Reply-To: <mhng-105d6a21-7483-4a20-a9e7-8e72770737d8@palmer-ri-x1c9>
To: Palmer Dabbelt <palmer@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, torvalds@linux-foundation.org,
 linux-kernel@vger.kernel.org

Hello:

This pull request was applied to riscv/linux.git (for-next)
by Linus Torvalds <torvalds@linux-foundation.org>:

On Fri, 22 Mar 2024 07:22:06 -0700 (PDT) you wrote:
> The following changes since commit e0fe5ab4192c171c111976dbe90bbd37d3976be0:
> 
>   riscv: Fix pte_leaf_size() for NAPOT (2024-02-29 10:21:23 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux.git tags/riscv-for-linus-6.9-mw2
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] RISC-V Patches for the 6.9 Merge Window
    https://git.kernel.org/riscv/c/c150b809f7de

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



