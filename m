Return-Path: <linux-kernel+bounces-23732-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 286D682B0F6
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:51:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8A721F23267
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:51:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA5F74E1C3;
	Thu, 11 Jan 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GBnAtEH1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D699495D1
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id AF128C43390;
	Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704984637;
	bh=nNHoCRmS5didV6mSaD6BjLjyd87nCy39fs25lN2LzMs=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GBnAtEH1ZC+pnrk3tUJCWry2AHPQaXwQBOgHrA4zwoQUxPp7P4rH0+8Ibdb8U3tKK
	 oOx5Oi7zQft3ixA5sGHG/E15FS6CJpBmf3p9DUbkJIP1K4MN9R14FwX+r7mhGAqn9J
	 1nwKNvCh+QlnFzJxEjrSc3ntr8b7G2ZFWMXuCjSDLXmH8hjw0+H0NGyqQ7ZF5Yoalz
	 BfxKox/xZXcPj8a0/1J/ur8dfv4bQsFq4u0210Aypw+dzAUeVpsM0nKMzG++s5y1kh
	 eeon6/bCAtzPGEMqh+cRrQOWRUxzVDr/32OF1WUmZSW2kUHitGZaOxbfNinZ60SJDs
	 wBqgdRr5wsFvQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 98F30D8C975;
	Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/3] riscv: modules: Fix module loading error handling
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170498463762.20080.10354089217933383289.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jan 2024 14:50:37 +0000
References: <20240104-module_loading_fix-v3-0-a71f8de6ce0f@rivosinc.com>
In-Reply-To: <20240104-module_loading_fix-v3-0-a71f8de6ce0f@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, palmer@rivosinc.com,
 linux-kernel@vger.kernel.org, lkp@intel.com, error27@gmail.com,
 julia.lawall@inria.fr, dan.carpenter@linaro.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 04 Jan 2024 11:42:46 -0800 you wrote:
> When modules are loaded while there is not ample allocatable memory,
> there was previously not proper error handling. This series fixes a
> use-after-free error and a different issue that caused a non graceful
> exit after memory was not properly allocated.
> 
> Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [v3,1/3] riscv: Fix module loading free order
    https://git.kernel.org/riscv/c/78996eee79eb
  - [v3,2/3] riscv: Correctly free relocation hashtable on error
    https://git.kernel.org/riscv/c/4b38b36bfbd8
  - [v3,3/3] riscv: Fix relocation_hashtable size
    https://git.kernel.org/riscv/c/a35551c7244d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



