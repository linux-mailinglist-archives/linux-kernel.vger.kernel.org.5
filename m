Return-Path: <linux-kernel+bounces-31906-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E8FB083363B
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 22:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A37B5281434
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Jan 2024 21:11:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628D915AD2;
	Sat, 20 Jan 2024 21:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KbmoeAq7"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7A3B156FB
	for <linux-kernel@vger.kernel.org>; Sat, 20 Jan 2024 21:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705784996; cv=none; b=KWPfHOuCPOialbPC7WSEsYThFUfeBOyS+pkY2G5Jau/hY1UXUPFhqBc0tPpXqPV77Vo+CxYahPpTlQPFV+/Gg91jSerUANcDZZ2IGvNvSe63iIU4D+i2Zlaa5J8HLYobD07x1/NOjhJ5eOukt63jqrBgMyhBuAapY2jvPgHkz/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705784996; c=relaxed/simple;
	bh=M7g5eRyDPxCySbVq6qDMpJN6lmzZYx8poGv+sF2twdY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r7wYuN5UdtJE0H+fR5M4cJaTEAQqDk2nx78DjWL1MNZQaiMP9PRLdsNfWZVMwMNzRkI+M+u1vlwDauXMX+L/bkKMGZUwG955bQ1Z62nWsDF2hjBg4HUA3SvewivLnxVYRcOAs65Mv99BmmVUlzGfzFtg7OflEI+aad8KIp0nYlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KbmoeAq7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 46711C43601;
	Sat, 20 Jan 2024 21:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705784996;
	bh=M7g5eRyDPxCySbVq6qDMpJN6lmzZYx8poGv+sF2twdY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=KbmoeAq7o7z84/lro+jEKm1k97jjrEPcVrACcDrYuLRy9Kepw5VBWZrC2wJxF6fuH
	 PW7SfU7Frq6lq7u1MDRxrasoF4gu1E1+tGwyHKlfb23T8CvY27FhMBUVLdIQURQjZm
	 TME1+Nh7DgfUkJdAsotvo6Ifk0SKEU6aBcd3MR33o1jGwt+90HguzQ/40bkIov21X2
	 if9wnzOWEZ8tvlAmKNrcP/dSqnu9Cxx5gHjMTGQiQ42QM79wr3k0Gy1ev8sOroM4MG
	 iq0uAD6C40c1E84s5qKqFoqo2AtGwThoOMyFSclSGQthE4LlXigIyHTYu1T8IvDXPE
	 lyUifJs78Drdg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 363D3D8C970;
	Sat, 20 Jan 2024 21:09:56 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] riscv, kexec: fix the ifdeffery for AFLAGS_kexec_relocate.o
From: patchwork-bot+linux-riscv@kernel.org
Message-Id: 
 <170578499621.24348.1106516858388911395.git-patchwork-notify@kernel.org>
Date: Sat, 20 Jan 2024 21:09:56 +0000
References: <20231201062538.27240-1-bhe@redhat.com>
In-Reply-To: <20231201062538.27240-1-bhe@redhat.com>
To: Baoquan He <bhe@redhat.com>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
 kexec@lists.infradead.org, mick@ics.forth.gr, changbin.du@intel.com,
 paul.walmsley@sifive.com, palmer@dabbelt.com, aou@eecs.berkeley.edu

Hello:

This patch was applied to riscv/linux.git (fixes)
by Andrew Morton <akpm@linux-foundation.org>:

On Fri,  1 Dec 2023 14:25:38 +0800 you wrote:
> This was introduced in commit fba8a8674f68 ("RISC-V: Add kexec
> support").
> 
> It should work on CONFIG_KEXEC_CORE, but not CONFIG_KEXEC only, since
> we could set CONFIG_KEXEC_FILE=y and CONFIG_KEXEC=N, or only set
> CONFIG_CRASH_DUMP=y and disable both CONFIG_KEXEC and CONFIG_KEXEC_FILE.
> In these cases, the AFLAGS won't take effect with the current ifdeffery
> for AFLAGS_kexec_relocate.o.
> 
> [...]

Here is the summary with links:
  - riscv, kexec: fix the ifdeffery for AFLAGS_kexec_relocate.o
    https://git.kernel.org/riscv/c/d53a154cdc54

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



