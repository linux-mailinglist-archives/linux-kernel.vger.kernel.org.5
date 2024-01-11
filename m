Return-Path: <linux-kernel+bounces-23735-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 689FA82B0F8
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 15:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1B6921F222D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Jan 2024 14:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF74D4EB21;
	Thu, 11 Jan 2024 14:50:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XggMf5a8"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 336DF495FB
	for <linux-kernel@vger.kernel.org>; Thu, 11 Jan 2024 14:50:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id C4AE1C433A6;
	Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704984637;
	bh=QEltCOghjDHZcleTwVJs57Hiqfo45501vMQF9TdPbNw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XggMf5a8thlS8ZWv5KV1lrlRp922G8wC7o8T6DeasRsCajZZMOepavAmdDIc7PmSA
	 bRQWtvSmHBmqOMSPaXXuIk4+mm+GGUA01qbWkQQRjsqaFYxe9uKKfQY9G4UdeJlxOF
	 YHRaBFv0YGDS2hiHBr5/2nIxoUrRq9ci/rGMB2YudM2s8UGY6fd55Z2ie9HYbJVy7M
	 PpHbYUbpJ+WvuNWs2tW849GsXLO+1ckKdiU1CTyxw6e3P0KcZXE5Z8ms0voVi7VAfx
	 4Dscqip2NmNI3XlCvlQ9YHF88GvMsdauT2lFbBgmapiropnrw8oq7kmUP7AjX283ej
	 c3MlnTSkW9GHw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id A8BEBD8C97A;
	Thu, 11 Jan 2024 14:50:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/3] Fix XIP boot and make XIP testable in QEMU
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170498463768.20080.204922306048177003.git-patchwork-notify@kernel.org>
Date: Thu, 11 Jan 2024 14:50:37 +0000
References: <20231212130116.848530-1-haxel@fzi.de>
In-Reply-To: <20231212130116.848530-1-haxel@fzi.de>
To: Frederik Haxel <haxel@fzi.de>
Cc: linux-riscv@lists.infradead.org, vitaly.wool@konsulko.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu,
 greentime.hu@sifive.com, andy.chiu@sifive.com, heiko@sntech.de,
 conor.dooley@microchip.com, cleger@rivosinc.com, samitolvanen@google.com,
 masahiroy@kernel.org, guoren@kernel.org, namcaov@gmail.com,
 alexghiti@rivosinc.com, akpm@linux-foundation.org, anup@brainfault.org,
 bhe@redhat.com, chenjiahao16@huawei.com, bjorn@rivosinc.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 12 Dec 2023 14:01:11 +0100 you wrote:
> XIP boot seems to be broken for some time now. A likely reason why no one
> seems to have noticed this is that XIP is more difficult to test, as it is
> currently not easily testable with QEMU.
> 
> These patches fix the XIP boot and allow an XIP build without BUILTIN_DTB,
> which in turn makes it easier to test an image with the QEMU virt machine.
> 
> [...]

Here is the summary with links:
  - [1/3] riscv: Make XIP bootable again
    https://git.kernel.org/riscv/c/66f1e6809397
  - [2/3] riscv: Fixed wrong register in XIP_FIXUP_FLASH_OFFSET macro
    https://git.kernel.org/riscv/c/5daa37264102
  - [3/3] riscv: Allow disabling of BUILTIN_DTB for XIP
    https://git.kernel.org/riscv/c/6c4a2f6329f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



