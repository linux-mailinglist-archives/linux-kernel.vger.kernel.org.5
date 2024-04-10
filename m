Return-Path: <linux-kernel+bounces-138738-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5475B89F9C4
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:20:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0B0941F21F21
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:20:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DC9D15F41E;
	Wed, 10 Apr 2024 14:20:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gSgTtKc4"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4BCC15EFCC
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758833; cv=none; b=QOFhS79OIM/EmNhHkAw7ZIFfGSaOxPXrgeI4csUCJGNNtfcmcJjXk0zgNTIR8421FXhGTJGfssU8H/LDqHxk+QvJvpYejPsFuIYRzH83fF0dIOdqpsy4YpW9+octgxmsKhJEXi3mnfrJkzKpkfM74M0UpD2nBAu9lmsa1uJF21M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758833; c=relaxed/simple;
	bh=eC+Z9N5ahPdK92RFfh/c+mNGqNL0+z2FsfyJ+SMTgvo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=PoWKocgcMH8KrRSK3u3EGcpAOfm7b4JR3epn1PoTHK0dy1EIu8vRaUjtrPNBu1fqBr9g4/fVBrcUhpTt4df9ORY/6EG5JyjL5+Sj3adgWVMTNMyCFvcpD10pU3mirWZ0GFlBLiCPbAs79mmPoOfP1AXCRgTVkUDqGDRNEkBmrL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gSgTtKc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 6366CC433C7;
	Wed, 10 Apr 2024 14:20:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712758833;
	bh=eC+Z9N5ahPdK92RFfh/c+mNGqNL0+z2FsfyJ+SMTgvo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gSgTtKc4jIBQvla84kxwNpeU6lyHv4ZNr0YSikGOIY4aRJaMKZqBxI3F6FPEwqDHB
	 4O0WLOqbqwiZ2c+LI48F9A/FSv5YFTqyLz500eeqx8vqy8P7/9lq/Isfc2eqG/cytQ
	 XBk/B9vueVJPwT5EtfVxir3rssao85wYThEeUMpItManb71hnlHe/eRXXzHRPQcofA
	 sP4vYck9sSS/pu1n7iSUxiYEAl1OEyCxCuuEtjemSHh+7s9DBcS+pKI6H5pe3G5YxE
	 LOg/TORLO2U2bxc9MwF90J85TOxW1TpIPI4ItBvqbp2TJpMKI3XNd1JDMwTi1uCv5u
	 6ht5FKZYXUkXw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 53B30CF21C4;
	Wed, 10 Apr 2024 14:20:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 0/4] riscv: 64-bit NOMMU fixes and enhancements
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171275883333.18495.7159115515897564807.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 14:20:33 +0000
References: <20240227003630.3634533-1-samuel.holland@sifive.com>
In-Reply-To: <20240227003630.3634533-1-samuel.holland@sifive.com>
To: Samuel Holland <samuel.holland@sifive.com>
Cc: linux-riscv@lists.infradead.org, palmer@dabbelt.com,
 linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Mon, 26 Feb 2024 16:34:45 -0800 you wrote:
> This series aims to improve support for NOMMU, specifically by making it
> easier to test NOMMU kernels in QEMU and on various widely-available
> hardware (errata permitting). After all, everything supports Svbare...
> 
> After applying this series, a NOMMU kernel based on defconfig (changing
> only the three options below*) boots to userspace on QEMU when passed as
> -kernel.
> 
> [...]

Here is the summary with links:
  - [1/4] riscv: Fix TASK_SIZE on 64-bit NOMMU
    (no matching commit)
  - [2/4] riscv: Fix loading 64-bit NOMMU kernels past the start of RAM
    (no matching commit)
  - [3/4] riscv: Remove MMU dependency from Zbb and Zicboz
    https://git.kernel.org/riscv/c/9c4319d69744
  - [4/4] riscv: Allow NOMMU kernels to run in S-mode
    https://git.kernel.org/riscv/c/f862bbf4cdca

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



