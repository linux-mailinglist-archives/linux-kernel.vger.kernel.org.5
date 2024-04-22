Return-Path: <linux-kernel+bounces-153709-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 23D8F8AD1F2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:33:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6F377B23176
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:33:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B3715381B;
	Mon, 22 Apr 2024 16:33:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA8C6A039;
	Mon, 22 Apr 2024 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803626; cv=none; b=AQVGgfEHwBGLHqob+ze9Y6OqXExwarB3+tlNtbsynQ5OHIZdE57NnqjyoELWz/qPGIi2+l5+c/6cTrC1f6Azon59OzONWRxEY8exIvkq3+ozsV2U+4KSfL2njxFO7LgpOSHOetBkhyJRMHVlG+H/rHPQNBdI3cLabFx6pCRwYYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803626; c=relaxed/simple;
	bh=OwBYg8unRhddZSwTi6Si2WuI4k4EEoNCgB/yNTwLNy0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ta+ybohsUnNMkYzK9eLU+QBEKoUqfQwAvjiwNu60peFr2k7whOQqzUSwH9S8nLF92vt1i1xVtEZOGxINBLcuPdFv5A3DigECx4lmRiK+VdpFro+6edZ/FNqL0NQsMN2nNIvarwt20r0G2/rXQB7vu+eWflo2G18TCpU35CVqtvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4C27D339;
	Mon, 22 Apr 2024 09:34:12 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E961C3F7BD;
	Mon, 22 Apr 2024 09:33:39 -0700 (PDT)
Date: Mon, 22 Apr 2024 17:33:34 +0100
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
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
Message-ID: <ZiaRXrmDDjc194JI@e133380.arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1711674410.git.babu.moger@amd.com>

Hi Babu,

On Thu, Mar 28, 2024 at 08:06:33PM -0500, Babu Moger wrote:
> 
> This series adds the support for Assignable Bandwidth Monitoring Counters
> (ABMC). It is also called QoS RMID Pinning feature
> 
> The feature details are documented in the  APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC). The documentation is available at
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> 
> The patches are based on top of commit
> cd80c2c94699913f9334414189487ff3f93cf0b5 (tip/master)

A few very general comments from me here, since I'm not vary familiar
with this topic...


> # Introduction
> 
> AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
> feature only guarantees that RMIDs currently assigned to a processor will
> be tracked by hardware. The counters of any other RMIDs which are no longer
> being tracked will be reset to zero. The MBM event counters return
> "Unavailable" for the RMIDs that are not active.
>     
> Users can create 256 or more monitor groups. But there can be only limited
> number of groups that can give guaranteed monitoring numbers. With ever
> changing configurations there is no way to definitely know which of these
> groups will be active for certain point of time. Users do not have the
> option to monitor a group or set of groups for certain period of time
> without worrying about RMID being reset in between.
>     
> The ABMC feature provides an option to the user to assign an RMID to the
> hardware counter and monitor the bandwidth for a longer duration.
> The assigned RMID will be active until the user unassigns it manually.
> There is no need to worry about counters being reset during this period.
> Additionally, the user can specify a bitmask identifying the specific
> bandwidth types from the given source to track with the counter.
> 
> Without ABMC enabled, monitoring will work in current mode without
> assignment option.
> 
> # Linux Implementation
> 
> Linux resctrl subsystem provides the interface to count maximum of two
> memory bandwidth events per group, from a combination of available total
> and local events. Keeping the current interface, users can assign a maximum
> of 2 ABMC counters per group. User will also have the option to assign only
> one counter to the group. If the system runs out of assignable ABMC
> counters, kernel will display an error. Users need to unassign an already
> assigned counter to make space for new assignments.
> 
> 
> # Examples
> 
> a. Check if ABMC support is available
> 	#mount -t resctrl resctrl /sys/fs/resctrl/
> 
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign
> 	[abmc] 
> 	legacy_mbm
> 
> 	Linux kernel detected ABMC feature and it is enabled.
> 
> b. Check how many ABMC counters are available. 
> 
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign_cntrs 
> 	32
> 
> c. Create few resctrl groups.
> 
> 	# mkdir /sys/fs/resctrl/mon_groups/default_mon1
> 	# mkdir /sys/fs/resctrl/non_defult_group
> 	# mkdir /sys/fs/resctrl/non_defult_group/mon_groups/non_default_mon1
> 
> d. This series adds a new interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control
>    to list and modify the group's assignment states.
> 
>    The list follows the following format:

This section looks possibly inconsistent with (e.)

Is (d.) the userspace read format, with (e.) being the format written by
userspace?


>        * Default CTRL_MON group:
>                "//<domain_id>=<assignment_flags>"
> 
>        * Non-default CTRL_MON group:
>                "<CTRL_MON group>//<domain_id>=<assignment_flags>"
> 
>        * Child MON group of default CTRL_MON group:
>                "/<MON group>/<domain_id>=<assignment_flags>"
> 
>        * Child MON group of non-default CTRL_MON group:
>                "<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"
> 
>        Assignment flags can be one of the following:
> 
>         t  MBM total event is assigned

With my MPAM hat on this looks a bit weird, although I suppose it
follows on from the way "mbm_total_bytes" and "mbm_local_bytes" are
already exposed in resctrlfs.

From an abstract point of view, "total" and "local" are just event
selection criteria, additional to those in mbm_cfg_mask.  The different
way they are treated in the hardware feels like an x86 implementation
detail.

For MPAM we don't currently distinguish local from non-local traffic, so
I guess this just reduces to a simple on-off (i.e., "t" or nothing),
which I guess is tolerable.

This might want more thought if there is an expectation that more
categories will be added here, though (?)

>         l  MBM local event is assigned
>         tl Both total and local MBM events are assigned
>         _  None of the MBM events are assigned

This use of '_' seems unusual.  Can we not just have the empty string
for "nothing assigned"?

Since every assignment is terminated by ';' or end-of-line, I don't
think that there would be any parsing ambiguity (?)

> 
> 	Examples:
> 
> 	# cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control 
> 	non_defult_group//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> 	non_defult_group/non_default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> 	//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> 	/default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> 
> 	There are four groups and all the groups have local and total event assigned.
> 
> 	"//" - This is a default CONTROL MON group
> 
> 	"non_defult_group//" - This is non default CONTROL MON group
> 
> 	"/default_mon1/"  - This is Child MON group of the defult group
> 
> 	"non_defult_group/non_default_mon1/" - This is child MON group of the non default group
> 
> 	=tl means both total and local events are assigned.
> 
> e. Update the group assignment states using the interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control.
> 
> 	The write format is similar to the above list format with addition of
> 	op-code for the assignment operation.

With by resctrl newbie hat on:

It feels a bit complex (for the kernel) to have userspace needing to
write a script into a magic file that we need to parse, specifying
updates to a bunch of controls already visible as objects in resctrlfs
in their own right.

What's the expected use case here?

If userspace really does need to switch lots of events simultaneously
then I guess the overhead of enumerating and poking lots of individual
files might be unacceptable though, and we would still need some global
interfaces for operations such as "unassign everything"...


OTOH, the proposed approach is not so different from the way the
schemata files already work.

> 
>         * Default CTRL_MON group:
>                 "//<domain_id><op-code><assignment_flags>"
> 
>         * Non-default CTRL_MON group:
>                 "<CTRL_MON group>//<domain_id><op-code><assignment_flags>"
> 
>         * Child MON group of default CTRL_MON group:
>                 "/<MON group>/<domain_id><op-code><assignment_flags>"
> 
>         * Child MON group of non-default CTRL_MON group:
>                 "<CTRL_MON group>/<MON group>/<domain_id><op-code><assignment_flags>"
> 
>        Op-code can be one of the following:
> 
>         = Update the assignment to match the flags
>         + Assign a new state
>         - Unassign a new state
>         _ Unassign all the states

If we adopt "empty string" to mean "no events", then

	<foo>/<bar>/<domain>=

would unassign all events, so '_' would not be needed as a separate
syntax.

[...]

Cheers
---Dave

