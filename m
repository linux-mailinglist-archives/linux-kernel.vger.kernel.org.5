Return-Path: <linux-kernel+bounces-34305-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6437C8377D5
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 00:53:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DAC328AED3
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Jan 2024 23:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8B74E1CC;
	Mon, 22 Jan 2024 23:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XxdWbR5N"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E0FC38DCC
	for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705967578; cv=none; b=WJBZH83BhxR/J1onCv50uJ4y4RZxBrS+F/xrS8MW4JAp4j/kcYGrcePWWcBEKomHuQYsUhx4SPb22l3ftgMBgTpRgbBtHtjz9jAdFVPmIh089VwNxum3sPXqfuHVgUhXNSswevdhSN5qbVa3zu/cwQP3h1/iy0rnEK82iAa4mrA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705967578; c=relaxed/simple;
	bh=3eVeComrwr86ZuOxJi0T6/Ud2Y6QycTfq4pL9KBAx0U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=gjJoQxT/61B5hmCvLyLs9+PzYNMJVvgTKtNIEeNeqe/zJK8xuW8sOiyCbDjTHIGa8uSa8eRiouSTena/8whbtwjKrhtD6mNK6pcpyh/nk2BPzUI6j8XmJCFuyW+2qh8aBtCiPDFyauZ3u9tY17cenMpyqEUw2ebDqT2ZXxdCI+M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XxdWbR5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id B46CDC43390;
	Mon, 22 Jan 2024 23:52:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705967577;
	bh=3eVeComrwr86ZuOxJi0T6/Ud2Y6QycTfq4pL9KBAx0U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XxdWbR5N+ZU/LxQUpVqdkFLcNnXBayx72WcjrplGotWkBWNq+HpdDfEGXvx7VOZXK
	 6jrY8+hhnGfXsvPQOHlPKxDnIrFU/9Deryp8f35KH7ffnQpgZWZDoJh3w+HQFka1G8
	 MbM1DMpFEMWimhcYVhPtfq3CULcfZqytaNCKFyUvyoGZ6hturz2tNwX9d2qFL/xOgw
	 +rJeFhJb+HM9ZgVL4fyXjPSoSz9Gpfl++k5KksLuLFy4zetJQREY2jklhV9zzGoZMN
	 PHj4fWAKo6JNRlMdKsqSQFfCMJnEFc/RM2pni80agscQnsWrHAw5mNXchOixe93lAV
	 mcx3eV3wnIXvw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9C287E0B63B;
	Mon, 22 Jan 2024 23:52:57 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: remove unneeded #include <asm-generic/export.h>
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170596757763.31397.10703280405391487918.git-patchwork-notify@kernel.org>
Date: Mon, 22 Jan 2024 23:52:57 +0000
References: <20240120213312.3033528-1-masahiroy@kernel.org>
In-Reply-To: <20240120213312.3033528-1-masahiroy@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 viro@zeniv.linux.org.uk

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 21 Jan 2024 06:33:11 +0900 you wrote:
> Commit 62694797f56b ("use linux/export.h rather than
> asm-generic/export.h") replaced deprecated <asm-generic/export.h>
> inclusions.
> 
> Commit c2a658d41924 ("riscv: lib: vectorize copy_to_user/copy_from_user")
> introduced a new instance of #include <asm-generic/export.h>.
> 
> [...]

Here is the summary with links:
  - riscv: remove unneeded #include <asm-generic/export.h>
    https://git.kernel.org/riscv/c/3a6dd5f614a1

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



