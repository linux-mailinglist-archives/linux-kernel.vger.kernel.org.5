Return-Path: <linux-kernel+bounces-24341-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E5FF082BB4D
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 07:30:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 021BC1C245D6
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 06:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 398C75C914;
	Fri, 12 Jan 2024 06:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVQtSdT5"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7058042A84;
	Fri, 12 Jan 2024 06:30:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id E491FC43390;
	Fri, 12 Jan 2024 06:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705041030;
	bh=LbaA4ELxB4Skp90Iisn+iilsYgOn1rWzAtL0zKFTm4s=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UVQtSdT5l8au0eoMDi0L7Lu1wT9wWdEhEPhjCtFo+7hd1ELxuN8fD/Yjp/x4yeBzs
	 LQfUH9o0NG55zsOcj21PGy9fAc+0mMyi7fJrd58eGsKc5GrIHhSOn1sxv66Ye16qrM
	 6WTO3wHbJAzb7UV4oHH/nTjtYW4kzVQjvJ20fnbOxK+q1+yVDlOzw12aVRL3zyajYp
	 0zbLhQbKf4BqJWf/KXeNCgs9pPIiw5FeNKQ17GNPuvHRveDmBMPmHhsF3NQ5i0zM9E
	 GwOCnS6DDWCP4WRbaXnMbYoDCAxnafIvVVrG1zKB/RSPFjq4QN/uZ6zZSodm6iZcNT
	 Ic4gfqr9oDQeA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id CDD6FD8C98B;
	Fri, 12 Jan 2024 06:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: Fix an off-by-one in get_early_cmdline()
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170504103083.17535.2134276105681461724.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jan 2024 06:30:30 +0000
References: <9f66d2b58c8052d4055e90b8477ee55d9a0914f9.1698564026.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <9f66d2b58c8052d4055e90b8477ee55d9a0914f9.1698564026.git.christophe.jaillet@wanadoo.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alexghiti@rivosinc.com,
 bjorn@rivosinc.com, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org, palmer@rivosinc.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 29 Oct 2023 08:20:40 +0100 you wrote:
> The ending NULL is not taken into account by strncat(), so switch to
> strlcat() to correctly compute the size of the available memory when
> appending CONFIG_CMDLINE to 'early_cmdline'.
> 
> Fixes: 26e7aacb83df ("riscv: Allow to downgrade paging mode from the command line")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> 
> [...]

Here is the summary with links:
  - riscv: Fix an off-by-one in get_early_cmdline()
    https://git.kernel.org/riscv/c/adb1f95d388a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



