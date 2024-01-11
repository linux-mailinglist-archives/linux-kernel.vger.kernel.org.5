Return-Path: <linux-kernel+bounces-23734-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D8582B0F7
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04C7D287106
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD7814E1CA;
	Thu, 11 Jan 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MvrdmSn8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D664495CC
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8D49C43394;
	Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704984637;
	bh=+blWXOkxs+elmiiGxL/nzv66ZE7UIH/a2iH3jf6WOV0=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=MvrdmSn8UtowhN7o/iJd1KQk9lDrmGaHxmqnpBMwd+g65GDsWrjHwTwFLFw1GOjjW
	 xUtteiGQz/iuIIo7ObwUmeJNgViVe8hZn23amuaxOhhxLCy+yljeuI+HRvEv1ZJDRb
	 kD7rwvNmZkqzctQLIbgLORTKrX+s2TfM5KYD7F1nN/YtMscXTA3pzOk0T5Ci9IXicu
	 fWbxOz1/ZFhf0lrJAZkcgLRVOTSIIoiDMffVVe8RoxFlnBLhQDJIKaKURLkiNMpkKq
	 1dSSsSGZUJ7yLXk8oVlkCO7F7E2w5gQGfM5TBaY7F7ym5r3Ot4NDHjk0BJWc6GnmGy
	 NMdspWQtG15Iw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8D54EDFC698;
	Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: vector: Check SR_SD before saving vstate
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170498463757.20080.7960935665061816471.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jan 2024 14:50:37 +0000
References: <20231221070449.1809020-1-songshuaishuai@tinylab.org>
In-Reply-To: <20231221070449.1809020-1-songshuaishuai@tinylab.org>
To: Song Shuai <songshuaishuai@tinylab.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, andy.chiu@sifive.com,
 greentime.hu@sifive.com, conor.dooley@microchip.com, guoren@kernel.org,
 bjorn@rivosinc.com, xiao.w.wang@intel.com, heiko@sntech.de,
 ruinland.tsai@sifive.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 21 Dec 2023 15:04:49 +0800 you wrote:
> The SD bit summarizes the dirty states of FS, VS, or XS fields,
> providing a "fast check" before saving fstate or vstate.
> 
> Let __switch_to_vector() check SD bit as __switch_to_fpu() does.
> 
> Fixes: 3a2df6323def ("riscv: Add task switch support for vector")
> Signed-off-by: Song Shuai <songshuaishuai@tinylab.org>
> 
> [...]

Here is the summary with links:
  - riscv: vector: Check SR_SD before saving vstate
    https://git.kernel.org/riscv/c/e1b76bc00ed1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



