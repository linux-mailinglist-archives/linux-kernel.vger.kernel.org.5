Return-Path: <linux-kernel+bounces-117464-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0029188B1B8
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 21:39:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5880CC61DBD
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Mar 2024 17:30:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C727137760;
	Mon, 25 Mar 2024 16:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="BZ46ITCh"
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 466AF136E29
	for <linux-kernel@vger.kernel.org>; Mon, 25 Mar 2024 16:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711383863; cv=none; b=EdrGqLYArw8R5BNXO04UFlg3i/GCZdr12BCMFPef4tXzQ61iqvfMYfaaTM79xg7EBVHMynQ2d0kAponxmxhPYZBt3THdPSPE4zsA3+5xynCMyO4wKb1ZhfvwcJeINSss9BWOlZQg71dKJk0BUrrWYy5PxEriWxLPt067riA13EY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711383863; c=relaxed/simple;
	bh=JQ3cLutCgf+EA/6Tf2bn7MLHZvfht6ZbP6A9PFbXXdU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzyLrfN6oYI+BJVfzykn++rnjbiV8uKgapM0YLBaZu81S2pJ4WsCmHqOW3zMI/9BSDlRPbUIhwsXa4EKWJCtdoZEhMVF+fm1WR2QunUtfxHZiIK63LAMwRxhtf5Y4BDOiyXyM42QNQ4oD6A9uORn9rusf7unCvA34i9YBOOk9AM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=BZ46ITCh; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id B9F9E20B74C0; Mon, 25 Mar 2024 09:24:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com B9F9E20B74C0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1711383861;
	bh=iPGrZ9SmN53G8u5M1SheUaPzZr69QMkWMXhrj84JnuQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BZ46ITChWxQk22Y1uJhyr03RJlNvEXltK6QgfWd0FEhrOoNL6vE5i8wb9i9kxvwBX
	 1DTxtenDrrHB0lIkf5Ipq1SwSBONUxOdU4HVpqkpu7jzpdVyqXn5GJrs9qB/I1W75h
	 xTnuJXvo1BjTC2Pi5dpYK7ga672ukr5ZOF1omjqA=
Date: Mon, 25 Mar 2024 09:24:21 -0700
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: dave.hansen@linux.intel.com, luto@kernel.org, peterz@infradead.org,
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
	linux-kernel@vger.kernel.org, ssengar@microsoft.com,
	sgeorgejohn@microsoft.com
Subject: Re: [PATCH] x86/numa: Map NUMA node to CPUs as per DeviceTree
Message-ID: <20240325162421.GA2326@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <1710265404-23146-1-git-send-email-ssengar@linux.microsoft.com>
 <87v85bfzg0.ffs@tglx>
 <20240324162833.GA18417@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
 <87jzlqfk4n.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87jzlqfk4n.ffs@tglx>
User-Agent: Mutt/1.5.21 (2010-09-15)

On Mon, Mar 25, 2024 at 03:42:32PM +0100, Thomas Gleixner wrote:
> On Sun, Mar 24 2024 at 09:28, Saurabh Singh Sengar wrote:
> > I recognize that due to recent changes, each dtb platform will now need to set
> > a pointer for x86_init.mpparse.early_parse_smp_cfg to get the dtb_cpu_setup
> > executed.
> 
> No. DT does not need the early parse call. The early parse call _cannot_
> enumerate APICs.
> 
> > This was not the requirement before because earlier x86_dtb_init was
> > anyway getting called.
> 
> For the wrong reasons.
> 
> > Do you think we should improve this as well by setting
> > x86_init.mpparse.early_parse_smp_cfg to x86_dtb_parse_smp_config for all the
> > dtb platforms by default.
> 
> No.
> 
> > I see the ce4100 platform is setting the parse_smp_cfg, shouldn't the
> > early_parse_smp_cfg be more accurate there ?
> 
> Again. No. Early is not the point where APICs can be enumerated.
> 
> What we can do is the below.
> 
> Thanks,
> 
>         tglx
> ---
> --- a/arch/x86/include/asm/prom.h
> +++ b/arch/x86/include/asm/prom.h
> @@ -24,18 +24,15 @@ extern u64 initial_dtb;
>  extern void add_dtb(u64 data);
>  void x86_of_pci_init(void);
>  void x86_dtb_parse_smp_config(void);
> +void x86_flattree_get_config(void);
>  #else
>  static inline void add_dtb(u64 data) { }
>  static inline void x86_of_pci_init(void) { }
>  static inline void x86_dtb_parse_smp_config(void) { }
> +static inline void x86_flattree_get_config(void) { }
>  #define of_ioapic 0
>  #endif
>  
> -#ifdef CONFIG_OF_EARLY_FLATTREE
> -void x86_flattree_get_config(void);
> -#else
> -static inline void x86_flattree_get_config(void) { }
> -#endif
>  extern char cmd_line[COMMAND_LINE_SIZE];
>  
>  #endif /* __ASSEMBLY__ */
> --- a/arch/x86/kernel/devicetree.c
> +++ b/arch/x86/kernel/devicetree.c
> @@ -277,9 +277,9 @@ static void __init dtb_apic_setup(void)
>  	dtb_ioapic_setup();
>  }
>  
> -#ifdef CONFIG_OF_EARLY_FLATTREE
>  void __init x86_flattree_get_config(void)
>  {
> +#ifdef CONFIG_OF_EARLY_FLATTREE
>  	u32 size, map_len;
>  	void *dt;
>  
> @@ -301,8 +301,10 @@ void __init x86_flattree_get_config(void
>  
>  	if (initial_dtb)
>  		early_memunmap(dt, map_len);
> -}
>  #endif
> +	if (of_have_populated_dt())
> +		x86_init.mpparse.parse_smp_cfg = x86_dtb_parse_smp_config;
> +}
>  
>  void __init x86_dtb_parse_smp_config(void)
>  {

Thanks for suggestion, this will fix for all the x86 dtb platforms at once.
I wonder if there will be any user of x86_dtb_parse_smp_config outside
of this file after this change. Possibly we can make it static ?

I can send the v2, however if you prefer pushing all these changes yourself
please let me know.

- Saurabh

