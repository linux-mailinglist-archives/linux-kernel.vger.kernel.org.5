Return-Path: <linux-kernel+bounces-50922-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63A818483CC
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 05:50:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9330B21664
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Feb 2024 04:50:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 690C210976;
	Sat,  3 Feb 2024 04:50:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OjXlsSjn"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F078FBFC;
	Sat,  3 Feb 2024 04:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706935828; cv=none; b=J8gKgq8xFcmJwwowaprSgK/C3pG0xSdYcXpCz7PGACy3075Si0gK+s5WM5NaHCezry4fr7+tAZKf6ZfCQDnNOGXz7coWOI7JbjS8U91ebKPdZuUWEAZYsLF/t2nPxaWJP0z8qfL1tg57Z3AxANZRz40Ekc+D8l7DxAF3lU7wh3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706935828; c=relaxed/simple;
	bh=dxoDwdhwgsrylGbBAflkQtaQE7+NPSz4G5Mo6+1zpI8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NUit3SNEbDnEtTJPyi7UsGRpB/2oIMW+F6xtIX/DV0mu7Z6yJ9yG3QBRGVTbA+gW6Iw3GnDlwSt6Hkx/pYxjOy0DdijwmH1z0kfTv4XGnEt+B2AZaGJ8JbcEZiiwKXSdCv5RfT9RqrT8CpiU2Uu1fkh9FtGKUbVlz8mzO/UYiGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OjXlsSjn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id EB3ABC433C7;
	Sat,  3 Feb 2024 04:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706935828;
	bh=dxoDwdhwgsrylGbBAflkQtaQE7+NPSz4G5Mo6+1zpI8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=OjXlsSjnJ+nK8NqVhAJfNAsh7f9ck81t4u1vSym5Xaqx/Vjmkp/LyOA5asi57TSNo
	 lUG9PSCCx5DRRLMORsAJnxfMz5LUFQ6OHdtWULFI4+cG/RJwYWHbVnLC/STxoam6oM
	 bkGUUEeE43zyAU006kLZ6Pn+Y4wf9BMIhnbRzQd/PXNLKSzmp9t9hOaAiFIXbkbVW1
	 gVMYp9hCZaxafw+bQl+4YEL9Wlkdi9y0suXZuHbdK0MMOcQOWn5SWXWevHnrzF7Vjf
	 //yj3abKakY8XUI7H+yAOwolGftyLQ9AM8nDw5nqO50UhgAHWF02QcIZ1VOdW968Hy
	 4Zg3D9MTmRwIQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id D1C10C04E32;
	Sat,  3 Feb 2024 04:50:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net] net: atlantic: Fix DMA mapping for PTP hwts ring
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170693582785.20949.4926544018376508267.git-patchwork-notify@kernel.org>
Date: Sat, 03 Feb 2024 04:50:27 +0000
References: <20240201094752.883026-1-ivecera@redhat.com>
In-Reply-To: <20240201094752.883026-1-ivecera@redhat.com>
To: Ivan Vecera <ivecera@redhat.com>
Cc: netdev@vger.kernel.org, epomozov@marvell.com, irusskikh@marvell.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 richardcochran@gmail.com, dmitry.bezrukov@aquantia.com,
 sergey.samoilenko@aquantia.com, linux-kernel@vger.kernel.org

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  1 Feb 2024 10:47:51 +0100 you wrote:
> Function aq_ring_hwts_rx_alloc() maps extra AQ_CFG_RXDS_DEF bytes
> for PTP HWTS ring but then generic aq_ring_free() does not take this
> into account.
> Create and use a specific function to free HWTS ring to fix this
> issue.
> 
> Trace:
> [  215.351607] ------------[ cut here ]------------
> [  215.351612] DMA-API: atlantic 0000:4b:00.0: device driver frees DMA memory with different size [device address=0x00000000fbdd0000] [map size=34816 bytes] [unmap size=32768 bytes]
> [  215.351635] WARNING: CPU: 33 PID: 10759 at kernel/dma/debug.c:988 check_unmap+0xa6f/0x2360
> ...
> [  215.581176] Call Trace:
> [  215.583632]  <TASK>
> [  215.585745]  ? show_trace_log_lvl+0x1c4/0x2df
> [  215.590114]  ? show_trace_log_lvl+0x1c4/0x2df
> [  215.594497]  ? debug_dma_free_coherent+0x196/0x210
> [  215.599305]  ? check_unmap+0xa6f/0x2360
> [  215.603147]  ? __warn+0xca/0x1d0
> [  215.606391]  ? check_unmap+0xa6f/0x2360
> [  215.610237]  ? report_bug+0x1ef/0x370
> [  215.613921]  ? handle_bug+0x3c/0x70
> [  215.617423]  ? exc_invalid_op+0x14/0x50
> [  215.621269]  ? asm_exc_invalid_op+0x16/0x20
> [  215.625480]  ? check_unmap+0xa6f/0x2360
> [  215.629331]  ? mark_lock.part.0+0xca/0xa40
> [  215.633445]  debug_dma_free_coherent+0x196/0x210
> [  215.638079]  ? __pfx_debug_dma_free_coherent+0x10/0x10
> [  215.643242]  ? slab_free_freelist_hook+0x11d/0x1d0
> [  215.648060]  dma_free_attrs+0x6d/0x130
> [  215.651834]  aq_ring_free+0x193/0x290 [atlantic]
> [  215.656487]  aq_ptp_ring_free+0x67/0x110 [atlantic]
> ...
> [  216.127540] ---[ end trace 6467e5964dd2640b ]---
> [  216.132160] DMA-API: Mapped at:
> [  216.132162]  debug_dma_alloc_coherent+0x66/0x2f0
> [  216.132165]  dma_alloc_attrs+0xf5/0x1b0
> [  216.132168]  aq_ring_hwts_rx_alloc+0x150/0x1f0 [atlantic]
> [  216.132193]  aq_ptp_ring_alloc+0x1bb/0x540 [atlantic]
> [  216.132213]  aq_nic_init+0x4a1/0x760 [atlantic]
> 
> [...]

Here is the summary with links:
  - [net] net: atlantic: Fix DMA mapping for PTP hwts ring
    https://git.kernel.org/netdev/net/c/2e7d3b67630d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



