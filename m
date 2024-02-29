Return-Path: <linux-kernel+bounces-87268-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F25386D1ED
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 19:20:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F0051C21638
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:20:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F26347A15A;
	Thu, 29 Feb 2024 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KE4v+x8K"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E5C7829E
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 18:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709230832; cv=none; b=DRp5yUCaCwLeUmOTPTZRg0hgru4VVvGxFQcqndUNeBnJUwXKuBdZ4eITIJ5Qbzsr3k9Ua4QozKjNy7O3OkCNI8rBNb47cw4jNwOL69fKntrrpT9fTD7MFLwCEuUN8dWizhRNhcqPS6pe62sT7tBtgCK9iI6jr0HWddbmlRqC+OU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709230832; c=relaxed/simple;
	bh=xM3JMCH1s+ja4ELiHjz4kIVpPXrV8y6OXtjRrWaxqsA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=XxaNQ85MBE4Bfd3cm7ltVE6t8Q99EIKtt2wmbuiUS4SwiCwYphSMqPhEM8Yyd/85+26csvOPKaX3CKhPnTWMSU64Y0RIvOL9BSx975rzLn2+Qt6T+Yb+L692/uQBXIaTh1iziR4FB55nxeSuKuqwvWE+pCWObEnr0eXtkHf/oek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KE4v+x8K; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 07614C43394;
	Thu, 29 Feb 2024 18:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709230832;
	bh=xM3JMCH1s+ja4ELiHjz4kIVpPXrV8y6OXtjRrWaxqsA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KE4v+x8KjkYvHJUWW8sg6hjIQy9xhIF+qbWmcNMHd12ey7LI9jObE7Ipcjj0ANf4M
	 yz1uBhVzVQvkJqFjBu9mC5jStx8Ty9bu0LEt83DYXEXL+K8+q2mDLY9NYXerB22XPM
	 Wkbf7och/bGhe7G7+TFtRKwV/0yenDGE9wrMxPX+GtM5tXfAl92K+pNs4LDflfijkY
	 DIjSWEonf5r7KLpxHekkh65OKddjPAOhBXcpqeNFbwzL8suZKiLeDXfhoQMUsPkG7x
	 FZw1bDuZYl/X0WODj30/ay/l8NEkUX4BQIZovI9+Jg2Pf4m8g2AVRnacRj4PghJtFd
	 1yZMO1JjRXcKQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7697C3274B;
	Thu, 29 Feb 2024 18:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] MAINTAINERS: Update SiFive driver maintainers
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170923083187.760.6327659014794043857.git-patchwork-notify@kernel.org>
Date: Thu, 29 Feb 2024 18:20:31 +0000
References: <20240215234941.1663791-1-samuel.holland@sifive.com>
In-Reply-To: <20240215234941.1663791-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, conor@kernel.org, palmer@dabbelt.com,
 paul.walmsley@sifive.com, greentime.hu@sifive.com, green.wan@sifive.com,
 aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 15 Feb 2024 15:49:11 -0800 you wrote:
> Add myself as a maintainer for the various SiFive drivers, since I have
> been performing cleanup activity on these drivers and reviewing patches
> to them for a while now. Remove Palmer as a maintainer, as he is focused
> on overall RISC-V architecture support.
> 
> Collapse some duplicate entries into the main SiFive drivers entry:
>  - Conor is already maintainer of standalone cache drivers as a whole,
>    and these files are also covered by the "sifive" file name regex.
>  - Paul's git tree has not been updated since 2018, and all file names
>    matching the "fu540" pattern also match the "sifive" pattern.
>  - Green has not been active on the LKML for a couple of years.
> 
> [...]

Here is the summary with links:
  - MAINTAINERS: Update SiFive driver maintainers
    https://git.kernel.org/riscv/c/680945f0aa50

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



