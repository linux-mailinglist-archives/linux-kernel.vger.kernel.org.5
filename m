Return-Path: <linux-kernel+bounces-16147-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A18F8239AD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 01:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 917E6B23504
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 00:31:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A7CB632;
	Thu,  4 Jan 2024 00:31:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sJfX7PAp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A9CB365
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 00:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=BU9majFR6rZDd9qwFfDcoHl+cx/MmPzBWfA7gC38Y3s=; b=sJfX7PApe9xZB8v0VKTqy/7TZM
	8RKnJHUYxksxU6zl+7SWpVppGE2IGiRMVCjvRWk5MZumCMdGMZcV9LfplXRzSpvRozIkb5yHpARQa
	bZORfyJu6umPppCHEWV2xIGrir8yaWhX0kD1jhSRZ+RDBaDSP8GZArUObt1IhWeIOTrCzz0niXQxe
	PY9geYqGgZ9jKa1jVxizxTS3AoxJag6cMh77YG0MXFxBDV5jvFgPRARnF8d3Qz1+u9SbbNVrLk+4A
	ogFlJ5PhQjJ5h2wzTkvE3BFtQ0YDjxr7KyxGAFF1m0uO2hl19zPLHeAK4aySSeLwcaBpTvztIX2fg
	2gthSZbA==;
Received: from [50.53.46.231] (helo=[192.168.254.15])
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rLBe0-00CUli-1A;
	Thu, 04 Jan 2024 00:31:32 +0000
Message-ID: <62c7008e-d460-4314-b2af-2122b93d41dc@infradead.org>
Date: Wed, 3 Jan 2024 16:31:31 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/8] ARC: Fix typos
Content-Language: en-US
To: Bjorn Helgaas <helgaas@kernel.org>, Vineet Gupta <vgupta@kernel.org>
Cc: linux-kernel@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
 linux-snps-arc@lists.infradead.org
References: <20240103231605.1801364-1-helgaas@kernel.org>
 <20240103231605.1801364-3-helgaas@kernel.org>
From: Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20240103231605.1801364-3-helgaas@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit



On 1/3/24 15:15, Bjorn Helgaas wrote:
> From: Bjorn Helgaas <bhelgaas@google.com>
> 
> Fix typos, most reported by "codespell arch/arc".  Only touches comments,
> no code changes.
> 
> Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
> Cc: linux-snps-arc@lists.infradead.org
> ---
>  arch/arc/boot/Makefile                    |  4 ++--
>  arch/arc/boot/dts/axc003.dtsi             |  4 ++--
>  arch/arc/boot/dts/vdk_axs10x_mb.dtsi      |  2 +-
>  arch/arc/include/asm/dsp.h                |  2 +-
>  arch/arc/include/asm/entry-compact.h      | 10 +++++-----
>  arch/arc/include/asm/entry.h              |  4 ++--
>  arch/arc/include/asm/irq.h                |  2 +-
>  arch/arc/include/asm/irqflags-compact.h   |  2 +-
>  arch/arc/include/asm/mmu_context.h        |  2 +-
>  arch/arc/include/asm/pgtable-bits-arcv2.h |  2 +-
>  arch/arc/include/asm/shmparam.h           |  2 +-
>  arch/arc/include/asm/smp.h                |  4 ++--
>  arch/arc/include/asm/thread_info.h        |  2 +-
>  arch/arc/include/uapi/asm/swab.h          |  2 +-
>  arch/arc/kernel/entry-arcv2.S             |  8 ++++----
>  arch/arc/kernel/entry.S                   |  4 ++--
>  arch/arc/kernel/head.S                    |  2 +-
>  arch/arc/kernel/intc-arcv2.c              |  2 +-
>  arch/arc/kernel/perf_event.c              |  2 +-
>  arch/arc/kernel/setup.c                   |  2 +-
>  arch/arc/kernel/signal.c                  |  2 +-
>  arch/arc/kernel/traps.c                   |  2 +-
>  arch/arc/kernel/vmlinux.lds.S             |  4 ++--
>  arch/arc/mm/tlbex.S                       |  8 ++++----
>  24 files changed, 40 insertions(+), 40 deletions(-)
> 


> diff --git a/arch/arc/include/asm/pgtable-bits-arcv2.h b/arch/arc/include/asm/pgtable-bits-arcv2.h
> index f3eea3f30b2e..f8f85c04d7a8 100644
> --- a/arch/arc/include/asm/pgtable-bits-arcv2.h
> +++ b/arch/arc/include/asm/pgtable-bits-arcv2.h
> @@ -66,7 +66,7 @@
>   * Other rules which cause the divergence from 1:1 mapping
>   *
>   *  1. Although ARC700 can do exclusive execute/write protection (meaning R
> - *     can be tracked independet of X/W unlike some other CPUs), still to
> + *     can be tracked independent of X/W unlike some other CPUs), still to

                         independently

>   *     keep things consistent with other archs:
>   *      -Write implies Read:   W => R
>   *      -Execute implies Read: X => R

> diff --git a/arch/arc/kernel/signal.c b/arch/arc/kernel/signal.c
> index 0b3bb529d246..5414d9f5c40c 100644
> --- a/arch/arc/kernel/signal.c
> +++ b/arch/arc/kernel/signal.c
> @@ -9,7 +9,7 @@
>   * vineetg: Nov 2009 (Everything needed for TIF_RESTORE_SIGMASK)
>   *  -do_signal() supports TIF_RESTORE_SIGMASK
>   *  -do_signal() no loner needs oldset, required by OLD sys_sigsuspend
> - *  -sys_rt_sigsuspend() now comes from generic code, so discard arch implemen
> + *  -sys_rt_sigsuspend() now comes from generic code, so discard arch implement

                                                                         implementation

>   *  -sys_sigsuspend() no longer needs to fudge ptregs, hence that arg removed
>   *  -sys_sigsuspend() no longer loops for do_signal(), sets TIF_xxx and leaves
>   *   the job to do_signal()


But in any case:

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

-- 
#Randy

