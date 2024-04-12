Return-Path: <linux-kernel+bounces-142782-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 69D628A3006
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 15:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 991731C225A4
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 13:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2130985939;
	Fri, 12 Apr 2024 13:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rdsm4wWM"
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6341750241;
	Fri, 12 Apr 2024 13:59:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712930388; cv=none; b=jnBpiYGP/JUUtqqDUSNPXWOri6UL4cNBoPIhhAvi91KmHJZuDa21OPnWo0KYLLq3OYWWvaJsUibE3XEppdfEPH0sJPHzS8pnpYUnn878Ka2MrO33bqH/VH8lVu1ugVz/6zo2ZjQSJpZbclgkeIc+2n8bBNgUzLXc/MyTTZ7BkHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712930388; c=relaxed/simple;
	bh=C99AA46+hvRTtGxy3XR5W1R/6pmDxUu9xBGnM02STvk=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UObsYCgtilVOznZt18nrH79zZOSkRmgwk7ybkZte/jnjYrz+pSoP+zIbawc4LRXHHdtrGRHVRIdJ0GXuHNkbD+MSqpDuG4woaxn0X4G9iDFF1zrgt8jZAWTS1KRUqoXE/cbbk25V6xwTLxaSkzhEuZA9w6STlWR6Fit6tMQAbtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rdsm4wWM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7DCDC2BD10;
	Fri, 12 Apr 2024 13:59:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712930388;
	bh=C99AA46+hvRTtGxy3XR5W1R/6pmDxUu9xBGnM02STvk=;
	h=Date:From:To:Subject:References:In-Reply-To:From;
	b=Rdsm4wWMk8OGENFAWQJMUQ3jg7//LUF2BXzZ+tZwd4eQmlyho1CrXN9vMlFie6uid
	 zzCaWvTPDe2uLER1Ctb1Jfv1j+g25uOZ9vfXV8CTJecRQausksZ733VDydUlYvkhuT
	 1uFedZE1+kjuTsDVnTK3AIvApw9ExaqxVSsH6G7+bQ0pNeIkpbTX6wEjJM0m3G5I0e
	 UsP0LCqhx8M4RwnWBQCNCxDBGuI+E69Jv1wZvdS09FVOjvWGKPNP5SYmKEfgl4pyXL
	 9QRJWAywnO0JsMdcmK1yIL9sIRYFnm7rRvJoMdU4TQr4hadEm2XwMMD7Ia2gHnzaXe
	 gEHyfb6iJZrXQ==
Date: Fri, 12 Apr 2024 14:59:43 +0100
From: Will Deacon <will@kernel.org>
To: Andrea della Porta <andrea.porta@suse.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2] arm64: Add the arm64.no32bit_el0 command line option
Message-ID: <20240412135942.GB28004@willie-the-truck>
References: <20240207105847.7739-1-andrea.porta@suse.com>
 <Zeb6RX2wpBvuJiIZ@apocalypse>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zeb6RX2wpBvuJiIZ@apocalypse>
User-Agent: Mutt/1.10.1 (2018-07-13)

On Tue, Mar 05, 2024 at 11:56:05AM +0100, Andrea della Porta wrote:
> On 11:58 Wed 07 Feb     , Andrea della Porta wrote:
> > Introducing the field 'el0' to the idreg-override for register
> > ID_AA64PFR0_EL1. This field is also aliased to the new kernel
> > command line option 'arm64.no32bit_el0' as a more recognizable
> > and mnemonic name to disable the execution of 32 bit userspace
> > applications (i.e. avoid Aarch32 execution state in EL0) from
> > kernel command line.
> > 
> > Changes in V2:
> > - fixed the order of appearance of arm64.no32bit_el0 entry in
> >   kernel-parameters.txt documentation.
> > 
> > Link: https://lore.kernel.org/r/ZVTleETzfFUchs77@apocalypse
> > Signed-off-by: Andrea della Porta <andrea.porta@suse.com>
> > ---
> >  Documentation/admin-guide/kernel-parameters.txt | 3 +++
> >  arch/arm64/kernel/idreg-override.c              | 2 ++
> >  2 files changed, 5 insertions(+)
> > 
> > diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> > index 65731b060e3f..fa7cdf2f4f3a 100644
> > --- a/Documentation/admin-guide/kernel-parameters.txt
> > +++ b/Documentation/admin-guide/kernel-parameters.txt
> > @@ -415,6 +415,9 @@
> >  	arcrimi=	[HW,NET] ARCnet - "RIM I" (entirely mem-mapped) cards
> >  			Format: <io>,<irq>,<nodeID>
> >  
> > +	arm64.no32bit_el0 [ARM64] Unconditionally disable the execution of
> > +			32 bit applications
> > +
> >  	arm64.nobti	[ARM64] Unconditionally disable Branch Target
> >  			Identification support
> >  
> > diff --git a/arch/arm64/kernel/idreg-override.c b/arch/arm64/kernel/idreg-override.c
> > index e30fd9e32ef3..642cda19e42d 100644
> > --- a/arch/arm64/kernel/idreg-override.c
> > +++ b/arch/arm64/kernel/idreg-override.c
> > @@ -86,6 +86,7 @@ static const struct ftr_set_desc pfr0 __prel64_initconst = {
> >  	.override	= &id_aa64pfr0_override,
> >  	.fields		= {
> >  	        FIELD("sve", ID_AA64PFR0_EL1_SVE_SHIFT, pfr0_sve_filter),
> > +		FIELD("el0", ID_AA64PFR0_EL1_EL0_SHIFT, NULL),
> >  		{}
> >  	},
> >  };
> > @@ -197,6 +198,7 @@ static const struct {
> >  	{ "arm64.nomops",		"id_aa64isar2.mops=0" },
> >  	{ "arm64.nomte",		"id_aa64pfr1.mte=0" },
> >  	{ "nokaslr",			"arm64_sw.nokaslr=1" },
> > +	{ "arm64.no32bit_el0",		"id_aa64pfr0.el0=1" },
> >  };
> >  
> >  static int __init parse_hexdigit(const char *p, u64 *v)
> > -- 
> > 2.41.0
> > 
> 
> A gentle ping about this patch... any thoughts about it?

It looks reasonable to me, but arch/arm64/kernel/idreg-override.c no
longer exists upstream, so you need to rebase.

Thanks,

Will

