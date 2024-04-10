Return-Path: <linux-kernel+bounces-138726-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4434189F9B3
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 16:17:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 35358B34CBB
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Apr 2024 14:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8D716C86B;
	Wed, 10 Apr 2024 14:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WSrS7PUk"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEE281607B7
	for <linux-kernel@vger.kernel.org>; Wed, 10 Apr 2024 14:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712758230; cv=none; b=FN2rpYrEtfkwb45sGrplGLJSAdDokcz4TdJVj+WydT2GttZ5pR9EiN9SBZjYXlV9Sq0EcjMqtPcqRIR/N8VnoPuC8BB95hlFFe1855bZLHl5G8TijTr7GJwTbj9P8NAt933BX7K6G/5dIoABY0y3yk2NRaaQaZR4EvzX5DOFap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712758230; c=relaxed/simple;
	bh=F9ACgS7cWelDT7epvt7ZecgrWTrrldqZ71X+OkUkYrQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=kFEIu4OtOHo6A+/ZylVuOe5QUUKDUeVCu44cxBzuQUT8jbKjC+WWNjT6O1AZkKGg2Mdu0cMLr0feIZoQe8Q/gsn1Z/MToKpPGE1Qb/wpB7oiHOd0mnQCX/DGZYA+xGIUC+VicQhW+fgKMxdEbJc9MdfuVD6wwjADz0Eco04moOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WSrS7PUk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7C4D7C433B2;
	Wed, 10 Apr 2024 14:10:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712758229;
	bh=F9ACgS7cWelDT7epvt7ZecgrWTrrldqZ71X+OkUkYrQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=WSrS7PUkZjXDMvMwRg+842OxNUdkNs2MAAgGudcRwuoK/PVyYdhINSIHmOilKlFtI
	 lrO/2w2sJF2GzPbfyi7B05MmT6cSAZafZ/e4uQ68r6ksI2Fr0WKqcTnkfKAaiTDbes
	 6EoBSVqD1Y4HZcQmEyon+HaGDdhf2eaNwGF4BRbunDq4/82uN3KeSGf24nGPeXrBDI
	 0pSPO2QkNaX8En3yBCIyAsb30Ny6+bqJ9n5yH2xUkpvhLD9EfF3W3fmNq5yE5Sl/RA
	 XdmaDQDrvbefQXiCTfxcR8+9YbpuCgeWQyLmhukRRI1KwGT5t8ZdqRbt0VNvcRp0rf
	 TTnWB1VzfKAwQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6680DD6030E;
	Wed, 10 Apr 2024 14:10:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv: merge two if-blocks for KBUILD_IMAGE
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <171275822941.12683.5122789501184205985.git-patchwork-notify@kernel.org>
Date: Wed, 10 Apr 2024 14:10:29 +0000
References: <20240323113500.1249272-1-masahiroy@kernel.org>
In-Reply-To: <20240323113500.1249272-1-masahiroy@kernel.org>
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, linux-kernel@vger.kernel.org

Hello:

This patch was applied to riscv/linux.git (for-next)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Sat, 23 Mar 2024 20:35:00 +0900 you wrote:
> In arch/riscv/Makefile, KBUILD_IMAGE is assigned in two separate
> if-blocks.
> 
> When CONFIG_XIP_KERNEL is disabled, the decision made by the first
> if-block is overwritten by the second one, which is redundant and
> unreadable.
> 
> [...]

Here is the summary with links:
  - riscv: merge two if-blocks for KBUILD_IMAGE
    https://git.kernel.org/riscv/c/3b938e231b66

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



