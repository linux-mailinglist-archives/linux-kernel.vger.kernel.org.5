Return-Path: <linux-kernel+bounces-37636-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B4CC983B2E3
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 21:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB8301C22DD8
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 20:13:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9F8F133428;
	Wed, 24 Jan 2024 20:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="hy91558p"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE661133402
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 20:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706127210; cv=none; b=W6A2Ch8BMeu2uF/pxAvY1U9KqNk5fcr/8AJU2S+oCOaLUSAdUawpq0RynW0lEfzdxg0WjCGYdUEaprbgYzQihJv30hxWCluYQX6VQMYzdQEn0yeJWvQbQGYvjougPlZ5BSxizYrSQjUPYQb3FXq8hxBWBgtbpdKVhd4hppm5tfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706127210; c=relaxed/simple;
	bh=DktWX2ibRGhSuLiG70Ld6p71SNp0IXhmt8Qx63I526Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iK/DAMYJizR9D/0FyeiUPuJ7ord3wIaq0WmNwXlIUGDDJoYEJQUny/z3TzRsg6GZ8pGrrTJlHFPeSUqeLUsnnTg7XuZtRRtuUvLMAF6wgxSuzDIqcytTWd1P7uJU5pVE9hlkJHbeRIu3t34CM3WJlJoLkGXdjZ2Zkn3NE+GNalQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=hy91558p; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 5180140E00C5;
	Wed, 24 Jan 2024 20:13:25 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id pBr2w8FRwX2w; Wed, 24 Jan 2024 20:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706127202; bh=LCJor6I4lXgCgRVguLWw9EWsXhsyLw02SxAWAK79dIY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hy91558pnIeiDtL8BY9wA60GTaPww9+ViU3tP16XM2T/cQx5zHf3XiHxj76pUqeyV
	 09sWmYFlC+5HOjPv4X35Vtm2t9vuarDlMzdDJikWOdey0qKDeufVSNVKT5HJnsXVPf
	 ntpOam6vGzxkRylGSuPtetOHDVFjOsAjd+iB0SUz1VH+1F+FOD8I7hNXOBARK9WIhR
	 aow/6BcZVrG3dSMTJ3xFRNG8bHXKOppzYzXPRbMVhGrPMUyJPZ4ezE+E1Vhh+ltQUf
	 /bG+esA/1vHEURKGwZZdwfFRINuorgPGf71HkwIngsD6nI6D7BQmwyQwQt5wj6AI+L
	 44LM8ybrqxLXOy6J+6x4x4sjg+do66ucR1xed45ZksMsOehVvUxdKO/OumKwunL+BA
	 7EIkfaadC6gjQswCN6VrTa+wICuRpNjTDnrMFhzK2lJil0BXHc2wBPljSz1t/1kgZy
	 dDUmVXMZ5h6q6waoA1DMqWygwUWNxRwOTXDj4T3Pjy7ZQD/J5SSKnQhcMkF7CR/Y0j
	 CfFIUeZW9BUS67AiznnG3TTYWNJy5lxi6rkzWMXJAt362YbX3u9zZBXDVk5btpNcgE
	 ZkPEM2Lj+fmOdgndqOVZIFLOx+DBomVXJirgU8V6JYH/lO2lhs2jo+kbxq81vHXlY9
	 VVN5i1tdIpaeBEoRH2cvfVWo=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 3FB7440E01AE;
	Wed, 24 Jan 2024 20:13:04 +0000 (UTC)
Date: Wed, 24 Jan 2024 21:12:58 +0100
From: Borislav Petkov <bp@alien8.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
	Tom Lendacky <thomas.lendacky@amd.com>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	Arjan van de Ven <arjan@linux.intel.com>,
	Huang Rui <ray.huang@amd.com>, Juergen Gross <jgross@suse.com>,
	Dimitri Sivanich <dimitri.sivanich@hpe.com>,
	Sohil Mehta <sohil.mehta@intel.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Kan Liang <kan.liang@linux.intel.com>,
	Zhang Rui <rui.zhang@intel.com>,
	"Paul E. McKenney" <paulmck@kernel.org>,
	Feng Tang <feng.tang@intel.com>,
	Andy Shevchenko <andy@infradead.org>,
	Michael Kelley <mhklinux@outlook.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>
Subject: Re: [patch v5 03/19] x86/cpu: Add legacy topology parser
Message-ID: <20240124201258.GVZbFvSiaMkKbU3goX@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115908.477060795@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117115908.477060795@linutronix.de>

On Tue, Jan 23, 2024 at 01:53:34PM +0100, Thomas Gleixner wrote:
> From: Thomas Gleixner <tglx@linutronix.de>
> 
> The legacy topology detection via CPUID leaf 4, which provides the number
> of cores in the package and CPUID leaf 1 which provides the number of
> logical CPUs in case that FEATURE_HT is enabled and the CMP_LEGACY feature
> is not set, is shared for Intel, Centaur amd Zhaoxin CPUs.
					   ^^^

x86 maintainer Freudian slip. :-P

Happens to me too.

> Lift the code from common.c without the early detection hack and provide it
> as common fallback mechanism.
> 
> Will be utilized in later changes.
> 
> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> Tested-by: Juergen Gross <jgross@suse.com>
> Tested-by: Sohil Mehta <sohil.mehta@intel.com>
> Tested-by: Michael Kelley <mhklinux@outlook.com>
> 
> 
> ---
>  arch/x86/kernel/cpu/common.c          |    3 ++
>  arch/x86/kernel/cpu/topology.h        |    3 ++
>  arch/x86/kernel/cpu/topology_common.c |   46 +++++++++++++++++++++++++++++++++-
>  3 files changed, 51 insertions(+), 1 deletion(-)
> ---
> --- a/arch/x86/kernel/cpu/common.c
> +++ b/arch/x86/kernel/cpu/common.c
> @@ -891,6 +891,9 @@ void detect_ht(struct cpuinfo_x86 *c)
>  #ifdef CONFIG_SMP
>  	int index_msb, core_bits;
>  
> +	if (topo_is_converted(c))
> +		return;
> +
>  	if (detect_ht_early(c) < 0)
>  		return;
>  
> --- a/arch/x86/kernel/cpu/topology.h
> +++ b/arch/x86/kernel/cpu/topology.h
> @@ -6,6 +6,9 @@ struct topo_scan {
>  	struct cpuinfo_x86	*c;
>  	unsigned int		dom_shifts[TOPO_MAX_DOMAIN];
>  	unsigned int		dom_ncpus[TOPO_MAX_DOMAIN];
> +
> +	// Legacy CPUID[1]:EBX[23:16] number of logical processors

Can we pretty please use the good 'ol multi-line comment style and not
turn tip into a mess with a mixture between single-line and multi-line
comments?

Thanks.

> +	unsigned int		ebx1_nproc_shift;
>  };
>  
>  bool topo_is_converted(struct cpuinfo_x86 *c);


-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

