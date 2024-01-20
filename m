Return-Path: <linux-kernel+bounces-31901-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69F2C83362E
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:10:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B43D1F21BCA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE68314F65;
	Sat, 20 Jan 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GCFgON7j"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15D2014A86;
	Sat, 20 Jan 2024 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784989; cv=none; b=Lq2G81hRj7csw139FnAKhT/TwTJgAKPC/UBVssdxX2PqMvrLHh4+OWam4izCyJakFcT84WplcLrSDMgK7WF4cJEZH8j7GA07xkoGrgldz+yhOU5JpaNzpEPiqdclA+MLDonrc/RsZhrYu6PNt+e5aKLFNC6Q/+t1QrCvZtFv1hk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784989; c=relaxed/simple;
	bh=2UTuaFwcqkRBRMR5A80pWR7ePvnb57nQBapA7qClW9g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=o6qNyKo9mCE3w+Dod5n3EoGuyclOAfZDGORWJGjic3dtXtaklh68aoz9vnou5dF2oL1qsEBwT87waXHFWAKT6QRpcoYGT5X5pg8nhpPytEOyr1aH5wRpciLnHzGXZ9alVh/o6IlD34vBkjhRJA/OPJpXjgTAoTsHT6DwKH0P43g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GCFgON7j; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D89D9C43141;
	Sat, 20 Jan 2024 21:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784988;
	bh=2UTuaFwcqkRBRMR5A80pWR7ePvnb57nQBapA7qClW9g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=GCFgON7je9PmSZ4JWW4H7qhf2jXKJufA9RJF+aDPsUTPyFRTwt8720JgNMYl1nQOx
	 5z96haFqCw4cJpkp/avsXwPOKPdGDhbXj2SmyVhUYirkdEWnRHr87oAbbTzbU2lToI
	 XVGVCKWCtTJrgSY9ixOL95af/XN2w43U589ETZIDlAN7m5HYoAGz86IeUTqr7ON/B+
	 SqUIGruWhHRoCJ3gX7h5s2NQCBRKIHV8+a7D51Uy6QB2F1x7hQECHLOdB+4mPO2C60
	 jbnIPDaQPRrqq91pz4HFZIDD7ULmwvSv70Uq+YKiq4r8sUWZetzmMK1BBqbX1hUZZm
	 OUJDHPoC6B8Ug==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id C48C5D8C96C;
	Sat, 20 Jan 2024 21:09:48 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/2] riscv, crash: don't export some symbols when CONFIG_MMU=n
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578498880.24348.17790461588886369808.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:48 +0000
References: <ZW03ODUKGGhP1ZGU@MiWiFi-R3L-srv>
In-Reply-To: <ZW03ODUKGGhP1ZGU@MiWiFi-R3L-srv>
To: Baoquan He <bhe@redhat.com>
Cc: linux-riscv@lists.infradead.org, rdunlap@infradead.org,
 sfr@canb.auug.org.au, akpm@linux-foundation.org, ignat@cloudflare.com,
 linux-next@vger.kernel.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, eric_devolder@yahoo.com

Hello:

This series was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Mon, 4 Dec 2023 10:19:36 +0800 you wrote:
> When dropping select of KEXEC and dependency on ARCH_SUPPORTS_KEXEC
> from CRASH_DUMP, compiling error is reported when below config items are
> set:
> -----------------------
> CONFIG_CRASH_CORE=y
> CONFIG_KEXEC_CORE=y
> CONFIG_CRASH_DUMP=y
> ......
> 
> [...]

Here is the summary with links:
  - [1/2] riscv, crash: don't export some symbols when CONFIG_MMU=n
    https://git.kernel.org/riscv/c/c41bd2514184
  - [2/2] riscv, kexec: fix dependency of two items
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



