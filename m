Return-Path: <linux-kernel+bounces-31913-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D528383364C
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:12:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5CE05B22BE8
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5675A28E06;
	Sat, 20 Jan 2024 21:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aC23AqXs"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CE1418031;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784999; cv=none; b=nA5WYaPU4qbEW/CMxnwOESM5MUO7qcyW87W64500qraRFdiPNd1PKthkQoEEoU37hiv5mT7n2NPAzOX1gFEsO4SlMY2PzKbqb6CDm4oOcsk/qB4BbAGpwD2qShsTfhSS8KrfVlbRdwPNn+8uKOcTqYIf7soi29VYYTq98ndwWuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784999; c=relaxed/simple;
	bh=d2EDRJscbCIR87e+6SnLlBw0VYMjOFKxJr55Hwex2FA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=JiORI+Pm0qRTJgRL+ZLxMDUnXxdRzxeVyE1Bu/7WLL4enCihK5KLWCZrmUhz0LPU2PKWklvn673mrub7LOfvbzOjjrDLsHNTvqiW6oRZ0gVZ5f2T2EJSFC5XmYKDa5NLOBcjbUNpMlfXFYBv8neErvkMg3Xw1St3Vzrwgog7KBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aC23AqXs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5D862C433C7;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784999;
	bh=d2EDRJscbCIR87e+6SnLlBw0VYMjOFKxJr55Hwex2FA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=aC23AqXs7VHpIWiNRcIP8h2e8I6bW9BN91dlVCjUKu+I8jXrGM1pOxKU30hOLCwnF
	 JJDgvcX9l6fbSuH+iGk4kTOuSSDCiLasqckZrqXIORTywo65heqUCbF/H8qT/9QW6z
	 IMPYzJ4q/NfxWYn6OYmITbb5ZsyDpCBXIQ1wrTTkbkM6sQgiAiZ/nGQGhU67RknzTm
	 N0WhsAF4BGF02s7zEEAwDxanV3Ac6ynKYapWOQAe0JQ5eSMDvSeoGRvCHDn5EbbgYE
	 5aYLv7PBoplGmFrEMamBoY0nL1te4lK6Hq4fLF+6ociv1IMr8JZnUtBVxCIJHxXIcl
	 xasxyDiQmSfyA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4BCD1D8C978;
	Sat, 20 Jan 2024 21:09:59 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: add dependency among Image(.gz), loader(.bin),
 and vmlinuz.efi
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578499930.24348.3965347675241435191.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:59 +0000
References: <20231119100024.2370992-1-masahiroy@kernel.org>
In-Reply-To: <20231119100024.2370992-1-masahiroy@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 linux-kbuild@vger.kernel.org, ardb@kernel.org, sjg@chromium.org

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 19 Nov 2023 19:00:24 +0900 you wrote:
> A common issue in Makefile is a race in parallel building.
> 
> You need to be careful to prevent multiple threads from writing to the
> same file simultaneously.
> 
> Commit 3939f3345050 ("ARM: 8418/1: add boot image dependencies to not
> generate invalid images") addressed such a bad scenario.
> 
> [...]

Here is the summary with links:
  - [v2] riscv: add dependency among Image(.gz), loader(.bin), and vmlinuz.efi
    https://git.kernel.org/riscv/c/c4db7ff7a9ed

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



