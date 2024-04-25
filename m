Return-Path: <linux-kernel+bounces-159345-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E2AE8B2D61
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Apr 2024 01:00:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C145F1C21889
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Apr 2024 23:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1126E15665E;
	Thu, 25 Apr 2024 23:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="igobG6I1"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51D20155356
	for <linux-kernel@vger.kernel.org>; Thu, 25 Apr 2024 23:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714086032; cv=none; b=Xxg3t2+Ga3gBzWXvlEPv/6BkiDrCYTUSik5O2WFmM/376eNYaIlcYROScM5iL83+LthSF8A+vikeDAFW+99nlx+9H/wDrw1aiDu1vtB7dLVkWh16PfJXh4+t6NXWxKeGyD5L8y4Z7LbURPoijkvmkIfNf4hkpneXAtj/tEH8aT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714086032; c=relaxed/simple;
	bh=0IGnkNdF8z2leS3iHikpEP2XzTkGqpBJAJtmSy49Z6E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Upp0goxHJ89yNRI83c9AVI4FHfgHSfYZBblPpbEztF0HR+hPDuzKYLUzcWlz78Mg3SikBFLIdQMM9iciLReM7jXNOT3rBRJ6YNnNhYmDS5JJ/MUZR45Cl83fMu9uoc/99g96FXB+6k1k5WDvIWWoB972lv/R8NtZwURtyQOyhW4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=igobG6I1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D1B12C113CE;
	Thu, 25 Apr 2024 23:00:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714086030;
	bh=0IGnkNdF8z2leS3iHikpEP2XzTkGqpBJAJtmSy49Z6E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=igobG6I1CIejK3yulBtwPYYuUDOux+sA3KDMxUeoo77zreXe2fsH0rwgnilrFa2kv
	 rrVQ3QDCuLHqfxWwjpiQcbO5dOcRw+iEQs5KpJyMx6uCbwvcHLkGQSDtaxx8TxOePH
	 MVcpp6xyKCqlEDichpFaY6xlVq8ZLYxBcm3hgEVseGIwG2YqKcOs7LrWr18srHhmWu
	 mYsSStSFkag+e7aqShyVpn6N7xl5nE0bUgQi8+1u+ZqpZTARJOGZ0m/bxrlONDECIH
	 1P2lSqGo8G6PAasWGvInZlaM5MvHlXoOynirIFBtRjV7mHNQIr9dMerZlJa6+CWUAa
	 rl8zJrZklWfHg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id BFD58CF21C3;
	Thu, 25 Apr 2024 23:00:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH riscv/fixes] riscv: hwprobe: fix invalid sign extension for
 RISCV_HWPROBE_EXT_ZVFHMIN
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171408603078.8761.11289399768939570785.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 23:00:30 +0000
References: <20240409143839.558784-1-cleger@rivosinc.com>
In-Reply-To: <20240409143839.558784-1-cleger@rivosinc.com>
To: =?utf-8?b?Q2zDqW1lbnQgTMOpZ2VyIDxjbGVnZXJAcml2b3NpbmMuY29tPg==?=@codeaurora.org
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Tue,  9 Apr 2024 16:38:37 +0200 you wrote:
> The current definition yields a negative 32bits signed value which
> result in a mask with is obviously incorrect. Replace it by using a
> 1ULL bit shift value to obtain a single set bit mask.
> 
> Fixes: 5dadda5e6a59 ("riscv: hwprobe: export Zvfh[min] ISA extensions")
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> 
> [...]

Here is the summary with links:
  - [riscv/fixes] riscv: hwprobe: fix invalid sign extension for RISCV_HWPROBE_EXT_ZVFHMIN
    https://git.kernel.org/riscv/c/5ea6764d9095

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



