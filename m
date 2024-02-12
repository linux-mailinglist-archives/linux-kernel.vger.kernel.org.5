Return-Path: <linux-kernel+bounces-61928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DD01885188B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 16:56:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 91CC71F22B46
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A138C3CF7A;
	Mon, 12 Feb 2024 15:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="aL+V///l"
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA713CF68
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707753401; cv=none; b=tOn0OxrGTpMrG9bj9RBtl4BDqJXJo6as7Oz5chePPNDkCNsDc4vFDysLiJoONXXG/GHiUYmzL2X9QvRCJ5N6yubZSaMjcMoKJKx6GDZLNMgb9ZxN+nKDkhPUsG5Vm5hJiRMI+bD0vv6LfxlB5LQ7nhjWnKNFrOjL6J1oiTG3eJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707753401; c=relaxed/simple;
	bh=SlIAEswCtdMnuXycyPc/T1ee9S3/cBlWhgi8NkL0dmM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MfT0O0+1ks57D2Ht6uXfRDUSL1yU/tuuBDcZlQizDnh4i0DjGqMOTUgt2kIhLJzKtjhpVNXjlrgUGUkSanHJe9hZhxurw7XYZ576rU1cYcHZ5abtcqkddyEQ6dCP1R/CLevemeEwjXzwpIs3+BTRkuc/wcGv9x3i2DZzZR9dnMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=aL+V///l; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id C1C7B40E0196;
	Mon, 12 Feb 2024 15:56:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id w1rDdywF6PGa; Mon, 12 Feb 2024 15:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1707753393; bh=D7p8PKNHYp9VzJeXUXSzbf4ukN194cyAi9OYp6Ij3QI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=aL+V///lS6JzDXEq/Sx3gU4tqGacQPWSuplGf7qRL/z2WRluyO4hCGtYS0qBEjpgz
	 9hYYeDDITsUKHL1eKtI14bnNNDkDmQm+KThcJul3HIJVPcu5rvClYfPrPXqAgjCEyC
	 LCAr4p2qBQeatfL2o8Uu80QRci9B/Qa9xfJSJ/u8zIbqS19fBE+a/9hSqxZMAxNB7K
	 IfF2yopG6X/GC4+A9MbpLU63HIJRQA3KSsz917dSADK/WGQjKGOyMCmaBr66XdNnm0
	 UIkP8N54U/VHrTdAJEgrpGhfF3xzUHrgqKBXef+jhzOxQ5YtTcB4W15uXLBYLuOo/U
	 cbUfltC1s7RUdjxYp1KfFHSj+2v2Eov9Yjh7hsKCUiaRYXxpm6yziRdKdU+hhpp3h6
	 AVVcNdhnMqHD2U8Gwl4QsoYB2nQJnKJijxgAQbLC5bTxiKViyYT/Ec0ZCmkByQXIo5
	 HP+4Z8SQ2jeGG13w81JZ3NTeoAB5pb0HPULdbdcSeKzlDURuRNskCPrRMMTkAZrjgX
	 V2tJGJcc9C/ahZfmSUgM2yDo8PxF2gg+34tg7TbJXkWz9iPuim3Bv9iDVd9TxwN8Bs
	 de29GU3jmK/aqHUdW3MCcMPI4nz4+Dd0MdsIn+bBcPjPNP3J7dAPo0HFFyMe+H5snR
	 rGx4SW02+gKxQ5Hc7g31lhIo=
Received: from zn.tnic (pd953021b.dip0.t-ipconnect.de [217.83.2.27])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 42F6A40E0192;
	Mon, 12 Feb 2024 15:56:15 +0000 (UTC)
Date: Mon, 12 Feb 2024 16:56:09 +0100
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
Subject: Re: [patch v5 13/19] x86/mm/numa: Use core domain size on AMD
Message-ID: <20240212155609.GXZco_mU_K3wtg70W6@fat_crate.local>
References: <20240117115752.863482697@linutronix.de>
 <20240117115909.142089057@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240117115909.142089057@linutronix.de>

On Tue, Jan 23, 2024 at 01:53:50PM +0100, Thomas Gleixner wrote:
> @@ -158,26 +156,25 @@ int __init amd_numa_init(void)
>  		return -ENOENT;
>  
>  	/*
> -	 * We seem to have valid NUMA configuration.  Map apicids to nodes
> -	 * using the coreid bits from early_identify_cpu.
> +	 * We seem to have valid NUMA configuration. Map apicids to nodes
> +	 * using the size of the core domain in the APIC space.

Since you're touching the comments:

	/*
	 * Valid NUMA configuration detected. Map APICIDs to nodes...

>  	 */
> -	bits = boot_cpu_data.x86_coreid_bits;
> -	cores = 1 << bits;
> -	apicid_base = 0;
> +	cores = topology_get_domain_size(TOPO_CORE_DOMAIN);

num_cores ...

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

