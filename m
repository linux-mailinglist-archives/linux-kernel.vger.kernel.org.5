Return-Path: <linux-kernel+bounces-57367-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A13784D78E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 02:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA9D0284297
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 01:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F8441E897;
	Thu,  8 Feb 2024 01:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bgDQTMtP"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C095C1CF91
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 01:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707355829; cv=none; b=RQj2INxHw9+BY1aqhP0BNyx47XCzY9GX/gHANV67f/qCbRJ51puLt1JxKgFcV+AVqtypX6PD5kZD6HBo2Eo9cOfOSLq6eAxV8itSOcBq1CRJiBYu0jrSDmCOrU+bur61RSaqRnZ+JnmcejxVFE44knwBT64TGUj1LW+KUUccfPY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707355829; c=relaxed/simple;
	bh=LM9rriYZStkud30VJaubR5guh0n/IwnZmlpk5h5RwCY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dVFV1UzCOQRsejtgReQqaTZI1C3P1XQIuuwBNqNi08IgEH8wLVTsOl/OWnpXyhRKVLtfEIYLaXxMjdezg8fdSZJm/EMoU5D8XW6g9IJz1/vmaF+GEcs1rGrx6A37oDAvcMnQ3bRmrGETdZqUEzcMevoZEs3zCbOWC2SYAWTArsQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bgDQTMtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 63569C433B2;
	Thu,  8 Feb 2024 01:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707355829;
	bh=LM9rriYZStkud30VJaubR5guh0n/IwnZmlpk5h5RwCY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=bgDQTMtPRgF2FFfkL82Uhv8R185R3Ak4jsEKvagyrfNdEIcmeFNq1ufMbkCCrRXpv
	 is/VDTHrzXW7aEpIq7NcXlE5f7d3KeepQXY8zH95fT29sbtev3Sr7GBK8lGtzR2yoX
	 W2NwnieCz/m+2EOrsyF0tmQdgkUwjrFrXCfLuja6w0urv6VmEP/VkCnFTLRqE8z2Iy
	 A+36FAa0hIUxUhKBS+UofXPcDoRKQYJtkU8cSSg8BOJvuPWLYpAmgcinLaErPOwEDt
	 y/lU9wIRsAsbW+lfa+SNwtJukqHG6ee/xbpRimFd9+O8kKW4ZnsRAb59fGG33ju44u
	 hgL2oM5qzvrDw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 46AD2D8C97E;
	Thu,  8 Feb 2024 01:30:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH -fixes 0/2] svnapot fixes
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170735582928.12826.2812001497496359961.git-patchwork-notify@kernel.org>
Date: Thu, 08 Feb 2024 01:30:29 +0000
References: <20240117195741.1926459-1-alexghiti@rivosinc.com>
In-Reply-To: <20240117195741.1926459-1-alexghiti@rivosinc.com>
To: Alexandre Ghiti <alexghiti@rivosinc.com>
Cc: linux-riscv@lists.infradead.org, paul.walmsley@sifive.com,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, panqinglin2020@iscas.ac.cn,
 ajones@ventanamicro.com, linux-kernel@vger.kernel.org

Hello:

This series was applied to riscv/linux.git (fixes)
by Palmer Dabbelt <palmer@rivosinc.com>:

On Wed, 17 Jan 2024 20:57:39 +0100 you wrote:
> While merging riscv napot and arm64 contpte support, I noticed we did
> not abide by the specification which states that we should clear a
> napot mapping before setting a new one, called "break before make" in
> arm64 (patch 1). And also that we did not add the new hugetlb page size
> added by napot in hugetlb_mask_last_page() (patch 2).
> 
> Alexandre Ghiti (2):
>   riscv: Fix set_huge_pte_at() for NAPOT mapping
>   riscv: Fix hugetlb_mask_last_page() when NAPOT is enabled
> 
> [...]

Here is the summary with links:
  - [1/2] riscv: Fix set_huge_pte_at() for NAPOT mapping
    https://git.kernel.org/riscv/c/1458eb2c9d88
  - [2/2] riscv: Fix hugetlb_mask_last_page() when NAPOT is enabled
    https://git.kernel.org/riscv/c/a179a4bfb694

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



