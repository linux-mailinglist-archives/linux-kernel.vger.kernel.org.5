Return-Path: <linux-kernel+bounces-31904-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7BF833637
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:11:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52369282B26
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:11:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F6D9156E5;
	Sat, 20 Jan 2024 21:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hCV1Pi8H"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7012B156DB;
	Sat, 20 Jan 2024 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784994; cv=none; b=JJE2GKc2/T/4QwicjiHJF1/vwbbJMKnGKKdgvly81D+cI2ArgvjXIRSc3Jf3j/CbSznazQDotErpsspCxKKfWoDxvX+CE1BsaUme7IralYfmqbtOpSodxDu4zToOvqPHMx4RYsZSVmvb+GgJWAJ1o7PJLBYoDi9dUGwri+vGNo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784994; c=relaxed/simple;
	bh=kk7385kyA89gDCaUa5qTgEWS2EMtvZOz94x65C7D7dI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=RwsrucMad6avDTyl0XnHfuYKzYm46lBxxBNPF17mp6SnSy4evrSrz4uBrdRIJHiDVIYhYrBf6phK7Sx79ZUZ+kNZZh04/RA9vgJUI+kOWaLhQR0fygTxc6inVs+FYueePUHxjlQ1bi+oNV0+rm+QOVXi+NhEedE7IfnA1f9kQRY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hCV1Pi8H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id E99D1C433F1;
	Sat, 20 Jan 2024 21:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784994;
	bh=kk7385kyA89gDCaUa5qTgEWS2EMtvZOz94x65C7D7dI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hCV1Pi8Hn6xiWKXLnP0V27FJFaQtUKw6fR3Fyl4Qfp0tNieG6dpDNqgVT4z6fteJb
	 LNetZnccnIspVUdafDdAmiqXVwxzaoIcdNYBlsb1r4elQJyctHa58FuEDa4FYQX1wE
	 EoohajfIVNKNtCk+OwgwJFzE+oYzBa3birQNrtFCIEuM2qKMtEFqUYJCBMnrNEuoHN
	 ILE2EnKHXXAjvzxt5XMC5MVC9lHtnvlhmmqRsooA7DHh65IOltewmFSahVJCnY5C24
	 rIlyggfFM1xt75h65g5zTgdmg/0wLqYSG8g38vPxLDJGhu3xnW5JSwfDlCv79x9m9v
	 Qg9OC+ZSUshEA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D7C91D8C96C;
	Sat, 20 Jan 2024 21:09:53 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v12 for-next 0/4] riscv: ftrace: Miscellaneous ftrace
 improvements
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578499387.24348.15355889386163139110.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:53 +0000
References: <20231130121531.1178502-1-bjorn@kernel.org>
In-Reply-To: <20231130121531.1178502-1-bjorn@kernel.org>
To: =?utf-8?b?QmrDtnJuIFTDtnBlbCA8Ympvcm5Aa2VybmVsLm9yZz4=?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, rostedt@goodmis.org, mhiramat@kernel.org,
 mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
 aou@eecs.berkeley.edu, suagrfillet@gmail.com, guoren@kernel.org,
 bjorn@rivosinc.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org, songshuaishuai@tinylab.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 30 Nov 2023 13:15:27 +0100 you wrote:
> From: Björn Töpel <bjorn@rivosinc.com>
> 
> NB! Song told me that he would not have the time work on this series,
> so I picked it up.
> 
> This series includes a three ftrace improvements for RISC-V:
> 
> [...]

Here is the summary with links:
  - [v12,for-next,1/4] riscv: select FTRACE_MCOUNT_USE_PATCHABLE_FUNCTION_ENTRY
    https://git.kernel.org/riscv/c/b546d6363af4
  - [v12,for-next,2/4] riscv: ftrace: Make function graph use ftrace directly
    https://git.kernel.org/riscv/c/35e61e8827ee
  - [v12,for-next,3/4] riscv: ftrace: Add DYNAMIC_FTRACE_WITH_DIRECT_CALLS support
    https://git.kernel.org/riscv/c/196c79f19a92
  - [v12,for-next,4/4] samples: ftrace: Add RISC-V support for SAMPLE_FTRACE_DIRECT[_MULTI]
    https://git.kernel.org/riscv/c/629291dd8499

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



