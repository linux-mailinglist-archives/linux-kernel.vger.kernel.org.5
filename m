Return-Path: <linux-kernel+bounces-77758-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BA5E8609D8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 05:30:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 096EC2874EA
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 04:30:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 791331118D;
	Fri, 23 Feb 2024 04:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ewJTjM/7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB751749C
	for <linux-kernel@vger.kernel.org>; Fri, 23 Feb 2024 04:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708662630; cv=none; b=ZMVJUDOdOI13hCDyquFQXEYbRy2adxJPrdsb7lXFW+wfBEUEekFrk2aRT0si3hCSJlugepU/48XfE3h5gR6MZM3l2VivBkDTJTzK6+vLktOdFacu9ALM591WzPuzdM91dYUmDcYZ/wVeoVfSSJLUawN/zyapr40GXnGPANOv/aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708662630; c=relaxed/simple;
	bh=Eb7VOpynyOUtYxl0w26H7zwiUMIQBQ7D7ZB2sf9JGR4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=n0qUQpIGieqFsVLKmsusj9FpsTL5DBVxsSPJEIstW3WIg6TaEG0wWXYLLxrwylf+yoeyoMUq9SLGSAs1cbk2oGdHNOgwRK5R0vKmh7BQUals5Evxi/n1Lv/P+R0B7E/huQIgUVMcCrzR4piB2/b/lZ0EZAlHfh1DrG3QZB5nS3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ewJTjM/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 36CFFC433F1;
	Fri, 23 Feb 2024 04:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708662630;
	bh=Eb7VOpynyOUtYxl0w26H7zwiUMIQBQ7D7ZB2sf9JGR4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ewJTjM/7nLnnlaslG69/7L7vZlI5tHummIXJNWiRYXx3fSwerbPk7pY1NDysCjkC9
	 3fwWiYyI/juvvJPf2Gkll9cyZJuIfr5+vynmJqsVsx39N7E/3ckWjouT5GB5RF3jPp
	 /wZIOXB1xAykhWrAWEHhkDHbtMhxrPhxdyhGP/dZjifq6TsTXLvtBj6bsZ/dzF//9X
	 2WBPLx08O4LHeS5UgsmNrhCjxmbVnb5ut+P5Jv1tSaPB9DwnrUQJ41wgMvV+k15F5d
	 EuAeV4psRqO7Qtrmob67XYFtKJoLVqdkXmpYbH0Gk/mkuELS+5qNlJFigj81Bw24Ox
	 5cMzuNtWYrFIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 1BFF5D990CD;
	Fri, 23 Feb 2024 04:30:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes] riscv: Fix build error if
 !CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170866263011.22939.3026249859816795239.git-patchwork-notify@kernel.org>
Date: Fri, 23 Feb 2024 04:30:30 +0000
References: <20240211083640.756583-1-alexghiti@rivosinc.com>
In-Reply-To: <20240211083640.756583-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org,
 lkp@intel.com

Hello:

This patch was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sun, 11 Feb 2024 09:36:40 +0100 you wrote:
> The new riscv specific arch_hugetlb_migration_supported() must be
> guarded with a #ifdef CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION to avoid
> the following build error:
> 
> In file included from include/linux/hugetlb.h:851,
>                     from kernel/fork.c:52:
> >> arch/riscv/include/asm/hugetlb.h:15:42: error: static declaration of 'arch_hugetlb_migration_supported' follows non-static declaration
>       15 | #define arch_hugetlb_migration_supported arch_hugetlb_migration_supported
>          |                                          ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    include/linux/hugetlb.h:916:20: note: in expansion of macro 'arch_hugetlb_migration_supported'
>      916 | static inline bool arch_hugetlb_migration_supported(struct hstate *h)
>          |                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>    arch/riscv/include/asm/hugetlb.h:14:6: note: previous declaration of 'arch_hugetlb_migration_supported' with type 'bool(struct hstate *)' {aka '_Bool(struct hstate *)'}
>       14 | bool arch_hugetlb_migration_supported(struct hstate *h);
>          |      ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> 
> [...]

Here is the summary with links:
  - [-fixes] riscv: Fix build error if !CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION
    https://git.kernel.org/riscv/c/fc325b1a915f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



