Return-Path: <linux-kernel+bounces-57369-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0D4D84D790
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D0B341C2260C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:30:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8572E1E89E;
	Thu,  8 Feb 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvznHYv1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09D51D54D
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707355829; cv=none; b=gtFw4in/0l7Ogcuh1vyiyZfl4tYhWZSZmHcWMynsFeIjXCm3j5fec16Gt4c37LPEkn/TZKskSPNVAmZD0imBpTNsnF5W8tQTQOHX1obTseyZu18nak30WH7qTteD2qorNT+wsqWuF8LSnCmg3OVGsW1B2xQwfqNYLWxUlaPc5zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707355829; c=relaxed/simple;
	bh=eKM7cbq2LsQtT2XrjxLN0imXBewanhEf/4QaFmByZU8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=YdrI/8hbhzj0gfCZ1JHT+4UOSh1RdqA+hCAh/2d+Q8t1IPmpUMbuo+suawMMzGQMymLFbxu3bFbcVpwYfpSl26MVuUJousBkTc+oD79M1/F0ltpSa68bx4C9F9fdGKFa//J7p3r15B5BRmbxxPs6r+0S5DWXuQAjADUNDYmmXms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvznHYv1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 3B46EC43390;
	Thu,  8 Feb 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707355829;
	bh=eKM7cbq2LsQtT2XrjxLN0imXBewanhEf/4QaFmByZU8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hvznHYv1RguuNuXyuqydB4E7vEKoEBRsC/cwIRjaRO4bRGijC+LiiVl17Pewsgw9G
	 5AcgCGzZSS1jOkjOQp6tZSyhqRp27C3K2euzh/qxNRfQgcd8dKeX65qRki9eTL+7CA
	 Djastyta5r6eHNnR2BtUS3HdBVB2AciD06RDrBUOhnEyDAnFrAS+NP+M32GsFZ+W3L
	 gr/wld8sPg1uupwo3sINuXxtx5TBMliMVzfAN5HQrNYpd3claiyqxQ0QIOPttYvUHP
	 aLcdMTU8oJerv5/GwFDnGvKZogT0JXmbkhXuGPGqIMg11skuo1at5XGLoWaWjBRt6w
	 kFfBgpMmitDOg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1D7ACD8C96E;
	Thu,  8 Feb 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: declare overflow_stack as exported from traps.c
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170735582911.12826.14792273436491773148.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 01:30:29 +0000
References: <20231123134214.81481-1-ben.dooks@codethink.co.uk>
In-Reply-To: <20231123134214.81481-1-ben.dooks@codethink.co.uk>
To: Ben Dooks <ben.dooks@codethink.co.uk>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 23 Nov 2023 13:42:14 +0000 you wrote:
> The percpu area overflow_stacks is exported from arch/riscv/kernel/traps.c
> for use in the entry code, but is not declared anywhere. Add the relevant
> declaration to arch/riscv/include/asm/stacktrace.h to silence the following
> sparse warning:
> 
> arch/riscv/kernel/traps.c:395:1: warning: symbol '__pcpu_scope_overflow_stack' was not declared. Should it be static?
> 
> [...]

Here is the summary with links:
  - riscv: declare overflow_stack as exported from traps.c
    https://git.kernel.org/riscv/c/2cf963787529

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



