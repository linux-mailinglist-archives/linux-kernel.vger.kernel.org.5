Return-Path: <linux-kernel+bounces-90911-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EB7E8706B2
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 17:13:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 155EE28D1BA
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Mar 2024 16:13:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20EC4495F0;
	Mon,  4 Mar 2024 16:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="B5XdHQA5"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBB44482DF
	for <linux-kernel@vger.kernel.org>; Mon,  4 Mar 2024 16:13:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709568805; cv=none; b=mvbJeodhvY1R3bImPnBdDVgD2J64i1Di3ZJnVd8V1xG0Gv21G3kRDiVDtTdgWoeaV9IqU0nhUAPoa2JXV760UoqSJLzCLapbMIQooBOMm3bDMIBcg/DpTbyYbv+QuT2dAQfi7vQeseYPrCx2QoZiI1YPem/Smw7jPKucBNU/fGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709568805; c=relaxed/simple;
	bh=wcm9UPT5XROxhAqpn7C086cxpBM0LwaDlXfeSna61mw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I8i/t6CjO2WvUcB+KcH3InAQj2dSMUk4dTatuxQ2oFXyc9BWOQDZEn6WOzhSxSoS+oROCYXi1Oaam0YcVOkUY/cjFIBwrApvfJXvlyWSsTkPvIafT2QcLnYiDVIRn3t4WT6kfgj3lwo2mRHTU5VyNl/WAt7WqbF2Hez4bYaVCB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=B5XdHQA5; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id 5365C20B74C0; Mon,  4 Mar 2024 08:13:23 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 5365C20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1709568803;
	bh=/s3kBNQ4qHQCJpWRZJjObzotgm+otYnfX9VPdyY3KKQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B5XdHQA50EGWvjAxYjg72N4ZgrjGlhEsMx1wcsDMUC5SA5LTPj/ICcAXrgk2RImD2
	 Ki0r4TxTm17d8x30m+/QrhrGupkAt+kcO/SfJL9eXvZwrRgI+RX2rMRSowhyTzv+a1
	 kZDXb5MjMHw77pvMXIEjW4C1yx0WYfGt0BvrKw3Q=
Date: Mon, 4 Mar 2024 08:13:23 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	linux-kernel@vger.kernel.org, sgeorgejohn@microsoft.com
Cc: ssengar@microsoft.com, libo.chen@oracle.com, mhklinux@outlook.com
Subject: Re: [PATCH] x86/Kconfig: Allow NR_CPUS between 512 and 8192
Message-ID: <20240304161323.GA15009@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1708422613-15714-1-git-send-email-ssengar@linux.microsoft.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1708422613-15714-1-git-send-email-ssengar@linux.microsoft.com>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Tue, Feb 20, 2024 at 01:50:13AM -0800, Saurabh Sengar wrote:
> Today there is no way one can choose any value between 512 to 8192
> for NR_CPUS seamlessly. NR_CPUS is guarded by NR_CPUS_RANGE_END which
> is further dependent on CPUMASK_OFFSTACK to allow NR_CPUs > 512.
> 
> For x86, CPUMASK_OFFSTACK can only be enabled either by selecting MAXSMP
> or DEBUG_PER_CPU_MAPS. Both of these options has a cost to pay. MAXSMP
> will increase the NR_CPUS to 8192 which will have impact on kernel image
> size whereas DEBUG_PER_CPU_MAPS will have additional run time overheads.
> Thus there is no good way to have NR_CPUS anything between 512 to 8192.
> 
> Fix this by selecting CPUMASK_OFFSTACK if NR_CPUS > 512 and
> let NR_CPUS_RANGE_END set to 8192.
> 
> On a Hyper-V system where max number of CPUs are only 2048, this
> patch saves around 1 MB of kernel image size, compare to MAXSMP.
> 
> Signed-off-by: Saurabh Sengar <ssengar@linux.microsoft.com>
> ---
> 
> I want to mention that in ARM and other archs its very simple
> to select any value for NR_CPUS. This is an attempt to have more
> flexibilty in x86 arch as well to choose NR_CPUS.
> 
> Some of the earlier discussions reated to it which could be of interest:
> https://lore.kernel.org/lkml/1708092603-14504-1-git-send-email-ssengar@linux.microsoft.com/
> https://lore.kernel.org/lkml/794a1211-630b-3ee5-55a3-c06f10df1490@linux.com/
> 
> Another approach I can think of is to allow CPUMASK_OFFSTACK to be enabled
> more freely like the below patch of Libo Chen, that will also solve the
> problem I am addressing. But I feel this patch may have impact on other
> archs as well and I am not sure if that is in best interest of all the archs.
> 
> https://lore.kernel.org/lkml/20220412231508.32629-2-libo.chen@oracle.com/
> 
>  arch/x86/Kconfig | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index 07a0c8d4e9c7..458f3f250d7f 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -34,6 +34,7 @@ config X86_64
>  	select SWIOTLB
>  	select ARCH_HAS_ELFCORE_COMPAT
>  	select ZONE_DMA32
> +	select CPUMASK_OFFSTACK if NR_CPUS > 512
>  
>  config FORCE_DYNAMIC_FTRACE
>  	def_bool y
> @@ -1006,8 +1007,7 @@ config NR_CPUS_RANGE_END
>  config NR_CPUS_RANGE_END
>  	int
>  	depends on X86_64
> -	default 8192 if  SMP && CPUMASK_OFFSTACK
> -	default  512 if  SMP && !CPUMASK_OFFSTACK
> +	default 8192 if  SMP
>  	default    1 if !SMP
>  
>  config NR_CPUS_DEFAULT
> 
> -- 
> 2.34.1
> 

x86 Maintainers,

Kind reminder to have your feedback on this patch.

- Saurabh


