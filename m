Return-Path: <linux-kernel+bounces-161594-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 597C98B4E65
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Apr 2024 00:01:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FCFF1C203F6
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Apr 2024 22:01:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23E062E40C;
	Sun, 28 Apr 2024 22:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uCkCXnmI"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81893C144;
	Sun, 28 Apr 2024 22:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714341635; cv=none; b=Wkpw64tDFmIj2SZRCT4QEbVnLTCzuExaLzsDIbwcUs6EB+FEjZYAnm+lcB2CVEzfY01w/9RjIBHVlNUe0ERNxOVncXsjeLMsV5NLEhkU6zHsps+pEyOAy9IJIyXfeW4BVfU7jZYj0CKxuj7wDHV9j+j6WHiFXFt53kSzD7oqEgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714341635; c=relaxed/simple;
	bh=hvDaSGrdUfrxihrtEy8f7ZRBMYbrTI8GonchTutnack=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=aC7aC/U6XAGEOiJZuVlBDhIvvoAEj0t6KJhAtcxTKX0g5qXRpKZGKJ1QsB7SbDl2ek9N4pu75DY0gOACSEfTn866ImUDWARn4055ymYdBkRWOOtCQpLzP6Ee/1hOGjcCBYXWK/bNoySwaglvDBrm02xGAjvmfkSHTun49L/5w1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uCkCXnmI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 0B635C4AF4D;
	Sun, 28 Apr 2024 22:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714341635;
	bh=hvDaSGrdUfrxihrtEy8f7ZRBMYbrTI8GonchTutnack=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=uCkCXnmI4MTKNlX+GeicRK53ttSjQCUQ/uM+AYE3MgiN/PJMWaE42g9J+Rb+4zW7P
	 auUxs1C72m5ezXgMdgaAzEEhvrnC8+M+3mRToUvljeFOS5ZwpnZkM2CPJRdCsuAnks
	 8Y6XntuKf2ZkC9zdpHqc6QnqugRPZyJw1PPPdlMuzmtLBhasral9GLDvwPPDQbVgEX
	 P+iLu62rfa3KvSTVVW21970E8c6yH6nr5fMxHZ58mrDGHFW5wrAvW8P3fr5BK8PZ3/
	 wwmv/0a7wHF0h02wz62CwUHBU9QqCZzTEUze2FrktXtL0CszMjgcOrp61gIPCB7IJW
	 LeS2CKq+NrQWg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0142BC43614;
	Sun, 28 Apr 2024 22:00:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v3 0/2] riscv: fix patching with IPI
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171434163499.22130.13571396411882252090.git-patchwork-notify@kernel.org>
Date: Sun, 28 Apr 2024 22:00:34 +0000
References: <20240229121056.203419-1-alexghiti@rivosinc.com>
In-Reply-To: <20240229121056.203419-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, andrea@rivosinc.com,
 samuel.holland@sifive.com, anup@brainfault.org, rostedt@goodmis.org,
 mhiramat@kernel.org, mark.rutland@arm.com, linux-kernel@vger.kernel.org,
 linux-trace-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Thu, 29 Feb 2024 13:10:54 +0100 you wrote:
> patch 1 removes a useless memory barrier and patch 2 actually fixes the
> issue with IPI in the patching code.
> 
> Changes in v3:
> - Remove wrong cleanup as noted by Samuel
> - Enhance comment about usage of release semantics as suggested by
>   Andrea
> - Add RBs from Andrea
> 
> [...]

Here is the summary with links:
  - [v3,1/2] riscv: Remove superfluous smp_mb()
    https://git.kernel.org/riscv/c/29cee75fb66e
  - [v3,2/2] riscv: Fix text patching when IPI are used
    https://git.kernel.org/riscv/c/c97bf629963e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



