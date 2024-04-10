Return-Path: <linux-kernel+bounces-138723-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 246FE89F98F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:11:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8CFA1F2BD95
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:11:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0DF16C686;
	Wed, 10 Apr 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gm2J74Aa"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB7E15FA6E
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758229; cv=none; b=aWwlwWbKfkwovufPRpPJfC3vTmjwLndshgmrlgqaNLwvzYRW7IWzAvfzpreI7KS4PUm7zls3BGDWpD6y8hvMy93gWF6jNvU9JayRanKOF1ZPqH3ICC7oCq/OKLmYCafrRE8Proewmnra3SHMz1xXvLJRxSJrqewSbHPSHg8YXCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758229; c=relaxed/simple;
	bh=hfbU9Wccw2aZ8tuskEDPQxJylxwyJQeYp2Cl+ti/nWk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=nsvKTbnMfknbCVrThHCq08VwTbaM5lwezDgXQk3Ry503bF78yskzT8cYeDbwuSryuawcqGYDi1lDOCSZxLKUwaUfl9QxgQqVjBdPK6SCNDgh/8cY8qa36zDxFrfjq8SAlp+sKnft1BD9esJsSpACrVZS8+H9A+nquTtvNYxMESo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gm2J74Aa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 733B9C43399;
	Wed, 10 Apr 2024 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712758229;
	bh=hfbU9Wccw2aZ8tuskEDPQxJylxwyJQeYp2Cl+ti/nWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gm2J74AaF+CIR8WZ6vyVWplRPpxFKH0WdmI71eS6HFXnp6A3NJVF+bqqTkEA/lOpo
	 HxTXzpSO/Pie183DJDp6OVDItulmV1dKXenE5fHy+10NoXicwbix7c4pYDVGKHICSm
	 27cOrx18fePsFkjk9SkPB+xlgiY6F/4nj6YdUVjoTm429lvZieR6Y0IJTUOeP0a+hl
	 tq7mabwovyKQXlYX8lkqa4TfLGGM3SJ28Jlq2kfRarq+rQ1pvE5lmLdVBWWhAEkAsl
	 FtGh+ltdgfTveHmxaPtTJSdSA+u8QhAjAEmki0zY9eqEjMawY14jpkq0i84X+2VIm/
	 9xO8TDYDjiIgA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 5EAE4CF21C4;
	Wed, 10 Apr 2024 14:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] riscv: remove unused header
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171275822938.12683.4481489069563984558.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 14:10:29 +0000
References: <20231212-removeasmgeneric-v2-1-a0e6d7df34a7@google.com>
In-Reply-To: <20231212-removeasmgeneric-v2-1-a0e6d7df34a7@google.com>
To: Tanzir Hasan <tanzirh@google.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 nnn@google.com

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue, 12 Dec 2023 00:20:14 +0000 you wrote:
> arch/riscv/kernel/sys_riscv.c builds without using anything
> from asm-generic/mman-common.h. There seems to be no reason
> to include this file.
> 
> Signed-off-by: Tanzir Hasan <tanzirh@google.com>
> ---
> 
> [...]

Here is the summary with links:
  - [v2] riscv: remove unused header
    https://git.kernel.org/riscv/c/84c3a079ab98

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



