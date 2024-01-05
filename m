Return-Path: <linux-kernel+bounces-18380-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 709D7825C3F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 22:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FA02285AFD
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Jan 2024 21:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E871D3608A;
	Fri,  5 Jan 2024 21:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XIwjEhlb"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39DFC23772
	for <linux-kernel@vger.kernel.org>; Fri,  5 Jan 2024 21:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E2788C433CC;
	Fri,  5 Jan 2024 21:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704491427;
	bh=zZbKh0bXY4jP2LnG1owu/TGlfOhgMqLikZKmb67mDlg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XIwjEhlb4OOUssD1jGBzURaXALBo0jBKlPcdvjF10U85umoyNI/ZXOBgaVwX49pgc
	 QsTHWwlk22gCrm9Q8rFUvwiQ7E1xkW13/saKttLuS2Jn+K6ohnkGZP2Ura36SHh6uy
	 Ece4XXBTW99nm8Eq/RFFJq09LmuBKdo4gfeWHT2ZwGrbvhwBVWkzjVDo/hD4+yjd7w
	 Y6lQnAOvD3JcTr3uNLc3AVu5EFzLPR6CHqzW7IZXyLhWcN+90JMBHATeXWPBbe+fIN
	 ARQlM8ZzWTuhU5vkqUgzXjgV1+8AYoMxwQf1r/I4bkFuCIv6KX6ribWLc2xRYLryS8
	 7inC75tPPsbXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CB91FDCB6F9;
	Fri,  5 Jan 2024 21:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] riscv: CPU operations cleanup
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170449142782.26226.4217701485670023420.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jan 2024 21:50:27 +0000
References: <20231121234736.3489608-1-samuel.holland@sifive.com>
In-Reply-To: <20231121234736.3489608-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 21 Nov 2023 15:47:23 -0800 you wrote:
> This series cleans up some duplicated and dead code around the RISC-V
> CPU operations, that was copied from arm64 but is not needed here. The
> result is a bit of memory savings and removal of a few SBI calls during
> boot, with no functional change.
> 
> 
> Samuel Holland (3):
>   riscv: Deduplicate code in setup_smp()
>   riscv: Remove unused members from struct cpu_operations
>   riscv: Use the same CPU operations for all CPUs
> 
> [...]

Here is the summary with links:
  - [1/3] riscv: Deduplicate code in setup_smp()
    https://git.kernel.org/riscv/c/a4166aec1130
  - [2/3] riscv: Remove unused members from struct cpu_operations
    https://git.kernel.org/riscv/c/79093f3ec39c
  - [3/3] riscv: Use the same CPU operations for all CPUs
    https://git.kernel.org/riscv/c/62ff262227a4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



