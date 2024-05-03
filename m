Return-Path: <linux-kernel+bounces-167796-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCD38BAF46
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 16:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD7DD1C22488
	for <lists+linux-kernel@lfdr.de>; Fri,  3 May 2024 14:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14034481B9;
	Fri,  3 May 2024 14:53:45 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E514A6FC7;
	Fri,  3 May 2024 14:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714748024; cv=none; b=cpkxeCoKLKcOMR0Q3B0bwKFfybVdvIPixNKXmtBe0mPzk3fxp+U2OTSYihKr3DYtn1qc849/cUQowJt2t/S616FX9j57yngh9MBn7W7Eh6+eQ035XSYsySGE/h9t7ZsL4NUE8MBzSdPOM66e6IuXN/JH01Od5ovheTiRPBe/B60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714748024; c=relaxed/simple;
	bh=cHdEgixh0acGhZvMQ36hprLY16zcikyllyzLBwk7dXQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SwiTe80mZeWz3gdCtIXl1A5NWz2PoB7wIZnNIyrnihC6RTxu19U2wEEJNqFbC07kaK3tGks/vlpNxHJ4XQBiJe1Z0XO0Di1Agf8QfWG/J2LISOUmJvHMIrPmLKnZmu7JtfhiGRns1lbFBo+I+HzH/on0X9WiMg7EbUeR9FhAaBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6AA9F13D5;
	Fri,  3 May 2024 07:54:07 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 069923F73F;
	Fri,  3 May 2024 07:53:37 -0700 (PDT)
Date: Fri, 3 May 2024 15:53:35 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
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
Message-ID: <ZjT6b/nbZWjm0vw+@e133380.arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <f7dac996d87b4144e4c786178a7fd3d218eaebe8.1711674410.git.babu.moger@amd.com>
 <ZjO9hpuLz/jJYqvT@e133380.arm.com>
 <4875492c-13cd-4a77-a42f-243fe0f868a2@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4875492c-13cd-4a77-a42f-243fe0f868a2@intel.com>

On Thu, May 02, 2024 at 10:52:15AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 5/2/2024 9:21 AM, Dave Martin wrote:
> > On Thu, Mar 28, 2024 at 08:06:50PM -0500, Babu Moger wrote:
> >> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> >> index 2d96565501ab..64ec70637c66 100644
> >> --- a/Documentation/arch/x86/resctrl.rst
> >> +++ b/Documentation/arch/x86/resctrl.rst
> >> @@ -328,6 +328,77 @@ with the following files:
> >>  	 None of events are assigned on this mon group. This is a child
> >>  	 monitor group of the non default control mon group.
> >>  
> >> +	Assignment state can be updated by writing to this interface.
> >> +
> >> +	NOTE: Assignment on one domain applied on all the domains. User can
> >> +	pass one valid domain and assignment will be updated on all the
> >> +	available domains.
> >> +
> >> +	Format is similar to the list format with addition of op-code for the
> >> +	assignment operation.
> >> +
> >> +        * Default CTRL_MON group:
> >> +                "//<domain_id><op-code><assignment_flags>"
> >> +
> >> +        * Non-default CTRL_MON group:
> >> +                "<CTRL_MON group>//<domain_id><op-code><assignment_flags>"
> >> +
> >> +        * Child MON group of default CTRL_MON group:
> >> +                "/<MON group>/<domain_id><op-code><assignment_flags>"
> >> +
> >> +        * Child MON group of non-default CTRL_MON group:
> >> +                "<CTRL_MON group>/<MON group>/<domain_id><op-code><assignment_flags>"
> > 
> > The final bullet seems to cover everything, if we allow <CTRL_MON group>
> > and <MON group> to be independently empty strings to indicate the
> > default control and/or monitoring group respectively.
> > 
> > Would that be simpler than treating this as four separate cases?
> > 
> > Also, will this go wrong if someone creates a resctrl group with '\n'
> > (i.e., a newline character) in the name?
> 
> There is a check for this in rdtgroup_mkdir().

Ah, right.  Found it.  I guess that works.

On a (sort of) related point, are there any concerns about namespace
clashes in resctrlfs?  This looks like a potential issue for the resctrl
top-level directory at least.

It's not clear to me how userspace can pick a name for a resctrl group
that is guaranteed not to clash with the name of one of resctrl's own
files in a future kernel.

(Note, this is nothing to do with series; I haven't been sure where to
fit this into the dicsussion...)

> 
> > 
> >> +
> >> +	Op-code can be one of the following:
> >> +	::
> >> +
> >> +	 = Update the assignment to match the flags
> >> +	 + Assign a new state
> >> +	 - Unassign a new state
> >> +	 _ Unassign all the states
> > 
> > I can't remember whether I already asked this, but is "_" really
> > needed here?
> 
> Asked twice:
> https://lore.kernel.org/lkml/ZiaRXrmDDjc194JI@e133380.arm.com/
> https://lore.kernel.org/lkml/ZiervIprcwoApAqw@e133380.arm.com/
> 
> Answered:
> https://lore.kernel.org/lkml/4cd220cc-2e8e-4193-b01a-d3cd798c7118@amd.com/
> 
> You seemed ok with answer then:
> https://lore.kernel.org/lkml/ZiffF93HM8bE3qo7@e133380.arm.com/

There, I was asking about "_" meaning "no flags" in "=_".

> 
> > 
> > Wouldn't it be the case that
> > 
> > 	//*_
> > 
> > would mean just the same thing as
> > 
> > 	//*=_
> > 
> > ...?  (assuming the "*" = "all domains" convention already discussed)
> > 
> > Maybe I'm missing something here.
> 
> I believe have an explicit operator ("+", "=", or "-") simplifies
> parsing while providing an interface consistent with what users are already
> used to.
> 
> Reinette

That was the point I was trying to make here, apologies if I wasn't
clear.

Cheers
---Dave

