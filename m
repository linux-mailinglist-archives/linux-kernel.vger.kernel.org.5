Return-Path: <linux-kernel+bounces-24339-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423A482BB4B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:30:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66AD71C251BA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3999C5C917;
	Fri, 12 Jan 2024 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MikZ87mn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 705BC45015
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 06:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id F0A7CC43399;
	Fri, 12 Jan 2024 06:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705041031;
	bh=aZ9M2uKV6onpNRKsHx+QyMJOm0urWPWtFbPW2xqWs08=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MikZ87mnhB9HH1R7gMvXdNW9prX/1oyBMOBB/8n5d5VPk95YQZqp5DIGcEgOWzzdG
	 yUclOZ8J0/Pi8L6xpIH9l+I2pF+kK99NORstrRmjGNm1Xtxv+HjXvP883xKL5ipKeB
	 u9+XA41SJbg4z4/kRa4Bj7Zawf9WeyIt2A/zl3OhCUUPIzU1PBVtRt4QEtdNE9OdHO
	 crFRG+4EqPcQGoLbQljsQSuSIfOUVUvJSwcT++jm0F1QtYEnFV6vdijlkEJJRqE8sK
	 MMXvAHzjNgHTHRiLo5hQUEhPUIsKaiv5beCMWnyTcTqwPmxTgC6i3mCCUPp0ejYnbZ
	 MBDQSBYzxceBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7034D8C987;
	Fri, 12 Jan 2024 06:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: Add support for BATCHED_UNMAP_TLB_FLUSH
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170504103087.17535.15863318828506386951.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 06:30:30 +0000
References: <20240108193640.344929-1-alexghiti@rivosinc.com>
In-Reply-To: <20240108193640.344929-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 jszhang@kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon,  8 Jan 2024 20:36:40 +0100 you wrote:
> Allow to defer the flushing of the TLB when unmapping pages, which allows
> to reduce the numbers of IPI and the number of sfence.vma.
> 
> The ubenchmarch used in commit 43b3dfdd0455 ("arm64: support
> batched/deferred tlb shootdown during page reclamation/migration") that
> was multithreaded to force the usage of IPI shows good performance
> improvement on all platforms:
> 
> [...]

Here is the summary with links:
  - [v2] riscv: Add support for BATCHED_UNMAP_TLB_FLUSH
    https://git.kernel.org/riscv/c/54d7431af73e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



