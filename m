Return-Path: <linux-kernel+bounces-133434-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B721F89A39C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 19:40:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8A891C21F4C
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Apr 2024 17:40:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CFD9171E4A;
	Fri,  5 Apr 2024 17:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sdZuNBr8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77EE26AB6;
	Fri,  5 Apr 2024 17:40:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712338828; cv=none; b=XhTv/ZG4arXcFUdSNPqex56uKOb/MxB5G16QKJoET/HdcCWmvUTU9Ja/PfPnJZcdyfkQB3Kal8b5sULvvMLuU7udHU7nutmhUlzkP+qNZZQHcre8ZAcIxnn4cju13RUjCrqBk19dno/R92NcGCA2dHrSARDSNvN+cG7xKG1Hua0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712338828; c=relaxed/simple;
	bh=UvNDKM0UOnNcyat9LauY+9hj47mP0EeGvw/4ADSk8wU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dfbOEbZbf+OTof1fH9do6YBRAhqU2RjpY4exOCSq66v7lun7kvXWSKopfP0T1JTQonU8ORJL9sx/LLR6tp//fW31FzzRGlwHQlxNWES8Vjyf7KcfKItu/93mfneCO2yvIRKbWMJshKHpiekO9T0l3QvpkGRgII6szLXKhgPSa+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sdZuNBr8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E43E1C433C7;
	Fri,  5 Apr 2024 17:40:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712338828;
	bh=UvNDKM0UOnNcyat9LauY+9hj47mP0EeGvw/4ADSk8wU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sdZuNBr8rl1qODzgpBJXziDwJzT2lzXtfPUUnGVvsHkhiB+kbM+r/Zo3hbcLyFaHU
	 MYywkK4hw+adZYTH9CmbVLYe2NlR6jzCLAAiYpqpOz4sBEAXxlYChQhke/EIA5caMA
	 +XhSrLppLH0PIl60QK7TL0Bgm7h3HjTtqR3MBZJ6zpmCazLG9ZRf1TcgEIdjOs+RFt
	 v6eSOVGFGuuyy3pdU4Qfd16rZ+J3l2cY6gBibL41UX1czeyVkIzIVovqyO/WyU7fO5
	 QPUYsbfmDwvyYsKIC2t8jqvcSveffcfKwxWCI6Keiji7TqbHbdeoeEtaXwd3cigqwk
	 v7o2T+kUcPhGg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D6E75C395F6;
	Fri,  5 Apr 2024 17:40:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH bpf] MAINTAINERS: bpf: Add Lehui and Puranjay as riscv64
 reviewers
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171233882787.27871.641568432293387927.git-patchwork-notify@kernel.org>
Date: Fri, 05 Apr 2024 17:40:27 +0000
References: <20240405123352.2852393-1-bjorn@kernel.org>
In-Reply-To: <20240405123352.2852393-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@codeaurora.org
Cc: ast@kernel.org, daniel@iogearbox.net, john.fastabend@gmail.com,
 bpf@vger.kernel.org, netdev@vger.kernel.org, pulehui@huawei.com,
 puranjay@kernel.org, bjorn@rivosinc.com, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org

Hello:

This patch was applied to bpf/bpf.git (master)
by Alexei Starovoitov <ast@kernel.org>:

On Fri,  5 Apr 2024 14:33:51 +0200 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> Lehui and Puranjay have been active RISC-V 64-bit BPF JIT
> contributors/reviewers for a long time!
> 
> Let's make it more official by adding them as reviewers in
> MAINTAINERS.
> 
> [...]

Here is the summary with links:
  - [bpf] MAINTAINERS: bpf: Add Lehui and Puranjay as riscv64 reviewers
    https://git.kernel.org/bpf/bpf/c/76cd33899477

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



