Return-Path: <linux-kernel+bounces-166710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0259C8B9E6E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 18:22:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1B356B262C1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 16:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FC8C15E200;
	Thu,  2 May 2024 16:21:36 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E44C015DBA2;
	Thu,  2 May 2024 16:21:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714666895; cv=none; b=K3OEUVGs7ClT4mmfNoy9164LmLWXMCXaSG3JoOLBErFS8Z5Muedw2HU42VDpcLyuAgI2x2FORQMJjJXg19dXj1QY7igOdYC31XQOFKrnAN6c8pr02DnBNAPxxnPTZZ1l8me0pme+Ni/2/4O0EOeIA/rJ6xpBYbTWSuusaMK0v2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714666895; c=relaxed/simple;
	bh=7KuVrMh8y0d5hNVEyvQz8xNvnT0naUq6xB2hmMOT/Xs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L7sJb4PqRz8gipVNd4idGtUFv5t++GgTCrp+rX2nO1+/aqWyz1sVRb2I4XQnTsY7Cxl2m6IrNYVk8gEw/vLngKj9f4dfHDOBl6RyQm4QyhNTR+WxKg7Mc6kNcAguQgRsR12lfpjWgyV3HcnBUhZV/8XOwAPpVBPAm4Cr5xbTnRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A0842F4;
	Thu,  2 May 2024 09:21:58 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF5103F793;
	Thu,  2 May 2024 09:21:28 -0700 (PDT)
Date: Thu, 2 May 2024 17:21:26 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Babu Moger <babu.moger@amd.com>
Cc: corbet@lwn.net, fenghua.yu@intel.com, reinette.chatre@intel.com,
	tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
	dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
	paulmck@kernel.org, rdunlap@infradead.org, tj@kernel.org,
	peterz@infradead.org, yanjiewtw@gmail.com, kim.phillips@amd.com,
	lukas.bulwahn@gmail.com, seanjc@google.com, jmattson@google.com,
	leitao@debian.org, jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
	kai.huang@intel.com, kan.liang@linux.intel.com,
	daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
	sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com,
	peternewman@google.com, maciej.wieczor-retman@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	eranian@google.com, james.morse@arm.com
Subject: Re: [RFC PATCH v3 17/17] x86/resctrl: Introduce interface to modify
 assignment states of the groups
Message-ID: <ZjO9hpuLz/jJYqvT@e133380.arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com>

On Thu, Mar 28, 2024 at 08:06:50PM -0500, Babu Moger wrote:
> Introduce rdtgroup_mbm_assign_control_write to assign mbm events.
> Assignment state can be updated by writing to this interface.
> Assignment states are applied on all the domains. Assignment on one
> domain applied on all the domains. User can pass one valid domain and
> assignment will be updated on all the available domains.
> 
> Format is similar to the list format with addition of op-code for the
> assignment operation.
> 
>  * Default CTRL_MON group:
>          "//<domain_id><op-code><assignment_flags>"
> 
>  * Non-default CTRL_MON group:
>          "<CTRL_MON group>//<domain_id><op-code><assignment_flags>"
> 
>  * Child MON group of default CTRL_MON group:
>          "/<MON group>/<domain_id><op-code><assignment_flags>"
> 
>  * Child MON group of non-default CTRL_MON group:
>          "<CTRL_MON group>/<MON group>/<domain_id><op-code><assignment_flags>"
> 
> Op-code can be one of the following:
> 
>  = Update the assignment to match the flags
>  + Assign a new state
>  - Unassign a new state
>  _ Unassign all the states
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
> 
> v3: New patch.
>     Addresses the feedback to provide the global assignment interface.
>     https://lore.kernel.org/lkml/c73f444b-83a1-4e9a-95d3-54c5165ee782@intel.com/
> ---
>  Documentation/arch/x86/resctrl.rst     |  71 ++++++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 236 ++++++++++++++++++++++++-
>  2 files changed, 306 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 2d96565501ab..64ec70637c66 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -328,6 +328,77 @@ with the following files:
>  	 None of events are assigned on this mon group. This is a child
>  	 monitor group of the non default control mon group.
>  
> +	Assignment state can be updated by writing to this interface.
> +
> +	NOTE: Assignment on one domain applied on all the domains. User can
> +	pass one valid domain and assignment will be updated on all the
> +	available domains.
> +
> +	Format is similar to the list format with addition of op-code for the
> +	assignment operation.
> +
> +        * Default CTRL_MON group:
> +                "//<domain_id><op-code><assignment_flags>"
> +
> +        * Non-default CTRL_MON group:
> +                "<CTRL_MON group>//<domain_id><op-code><assignment_flags>"
> +
> +        * Child MON group of default CTRL_MON group:
> +                "/<MON group>/<domain_id><op-code><assignment_flags>"
> +
> +        * Child MON group of non-default CTRL_MON group:
> +                "<CTRL_MON group>/<MON group>/<domain_id><op-code><assignment_flags>"

The final bullet seems to cover everything, if we allow <CTRL_MON group>
and <MON group> to be independently empty strings to indicate the
default control and/or monitoring group respectively.

Would that be simpler than treating this as four separate cases?

Also, will this go wrong if someone creates a resctrl group with '\n'
(i.e., a newline character) in the name?

> +
> +	Op-code can be one of the following:
> +	::
> +
> +	 = Update the assignment to match the flags
> +	 + Assign a new state
> +	 - Unassign a new state
> +	 _ Unassign all the states

I can't remember whether I already asked this, but is "_" really
needed here?

Wouldn't it be the case that

	//*_

would mean just the same thing as

	//*=_

..?  (assuming the "*" = "all domains" convention already discussed)

Maybe I'm missing something here.

[...]

Cheers
---Dave

