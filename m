Return-Path: <linux-kernel+bounces-48458-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D9B845C5D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 17:00:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C15B1C211C6
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 16:00:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AE2F626D8;
	Thu,  1 Feb 2024 15:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="X3vYBIkP"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B420B1649BD
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 15:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706802960; cv=none; b=q3nCQGbt9Oq6KvY0VqH/USwsQ5L3ynuR9wESZsqCmW5feU7j912CcbKKupuIT9jW+SpjjDXzdsNQtuRJUnirYRbxIrAq5rxPvd6Rl+1xFXHfZbhc7k07odQ2WQz1M+sC9FpgSWojKznJnFcptZwxyaL9VMK8FR1yvmFXVSWp1P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706802960; c=relaxed/simple;
	bh=SQegs6INxW4kbPdC7mvM+U9nwZDqBjt36yUdWjaMJek=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LA7Eqy6tKEz+PuIU0cBPbd4EH10es+RSs+eyGeggZlIsVxzCEu9159bvpzw6MfTo6FNmbz/H/N/hk0iP4RXybvWBfjAVio09H3SPa/AsJbUL/uFh/q1/Pr6ZYDMRNt0xaw+56cbtG/uQbteXAJzyx/jeqpPdbvRG99krvi/O0ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=X3vYBIkP; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 2E26140E01A2;
	Thu,  1 Feb 2024 15:55:55 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id m0CzX3uIrqKW; Thu,  1 Feb 2024 15:55:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1706802952; bh=d3Jg7UFKEpSAr3MxVdix9yi+n7maj5VnqFmdHn+65KQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=X3vYBIkPaOc6g+wQkxcvsXrDE4d5y2DT9KB/w1c1RLpv7MEmXrNhA+gnuEC95rnBE
	 RWtYGJebza7ohziFIRSSkavhrJlz4DROooFBaK/s0Hs1yQsECRIz0i5+728flhDfoi
	 pf5MeIdPvUH7cG257IiwQLsE9IK8QN4o3uYcrZt4NHhZZBHF/GkNjV+s4dgOwT2GBG
	 xh7+EBrH+GNkmSycp+aRLsSZHUGE3Yrg5pSxDtFFI8KOT6MPys+boN7C+G84IS+Ns5
	 iSe7k2muk5bwurSjboV8gVzznjgehDHHiO5MwgS/tl/BDuXRvuWYscyWI/065o8x8L
	 j6hjCGfmgEw+EsUg9VwPkf3rOpGjj8i0cc4Ppe7oX0xbrmaA4imQuKP5xHuvFQ14G8
	 NfEWQX4hvuvNl2GYT+Cbi16y4R6lokz/Qn//b3CNMUFiHiJcuVRRGL67OiEwooz5L5
	 ZCDDxZSy0Qw5Mpvzi4IdyzC3VksAxVZDg8SgxtyFLLf7w3ZGfWINEejwCJEX7ZZM9t
	 E4HVatEpWdvYxL+bzL824SqpX2LC+nGRhh3olAD9ZGgb1pBkNezwKeLTlHq0x9IPGG
	 wnD4AkNPtRAKjEvRZQQ/rLGaJ/YF+6GxZ1fHJGshZ6+Uqe3SnZC5PqB9g4+XxJJMnV
	 SnM4POkuPSv+ANnQeao3z8qU=
Received: from zn.tnic (pd953033e.dip0.t-ipconnect.de [217.83.3.62])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 7FC9140E016C;
	Thu,  1 Feb 2024 15:55:34 +0000 (UTC)
Date: Thu, 1 Feb 2024 16:55:28 +0100
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
Subject: Re: [patch v5 09/19] x86/cpu: Provide an AMD/HYGON specific topology
 parser
Message-ID: <20240201155528.GMZbu-8NRAYFMQPyD_@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115908.880472059@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117115908.880472059@linutronix.de>

On Tue, Jan 23, 2024 at 01:53:43PM +0100, Thomas Gleixner wrote:
> --- a/arch/x86/kernel/cpu/topology.h
> +++ b/arch/x86/kernel/cpu/topology.h
> @@ -9,6 +9,10 @@ struct topo_scan {
>  
>  	// Legacy CPUID[1]:EBX[23:16] number of logical processors

/* comments pls.

>  	unsigned int		ebx1_nproc_shift;
> +
> +	// AMD specific node ID which cannot be mapped into APIC space.
> +	u16			amd_nodes_per_pkg;
> +	u16			amd_node_id;
>  };

..

> +static bool parse_8000_001e(struct topo_scan *tscan, bool has_0xb)
> +{
> +	struct {
> +		// eax
> +		u32	x2apic_id	: 32;

The docs call this ExtendedApicId, not x2apic_id.

> +		// ebx
> +		u32	cuid		:  8,
> +			threads_per_cu	:  8,
> +			__rsvd0		: 16;
> +		// ecx
> +		u32	nodeid		:  8,
> +			nodes_per_pkg	:  3,
> +			__rsvd1		: 21;
> +		// edx
> +		u32	__rsvd2		: 32;
> +	} leaf;
> +
> +	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))

s/boot_cpu_has/cpu_feature_enabled/g

> +		return false;
> +
> +	cpuid_leaf(0x8000001e, &leaf);

..

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

