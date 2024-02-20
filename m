Return-Path: <linux-kernel+bounces-73232-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DC8A385BFC0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 16:22:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 93C34281E9C
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 15:22:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21DA762D9;
	Tue, 20 Feb 2024 15:21:55 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 374847602F;
	Tue, 20 Feb 2024 15:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708442511; cv=none; b=jM20ZvnmIkh+06E4ffUUe45Xbcs+GY1taTOs3VfNy4Xk7YFNe75kmS/vyfajaC//JQW4LJZBFsTegXOVVfngakM3FFyIXiR2ECJ1LBCukCplkg9eU8ngfx899Bb4WUwWOIa/CV2w+PDL6KqU+8di7hht2/a6+SOpqAIBh70Bsy4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708442511; c=relaxed/simple;
	bh=b9b3K79qsHpoWeCkXdTpiDWhIZirWAQ4tWnT5kHY/w0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Tt3Ng5JcDsqDFEk9P5H/R+AGJDASj4iyoZHnlRcDzVtCXP86ykm5Lxnm9DJ7yrJU1H6I7L1OA9V60ODLYXIak9p+F0rvw9x3hDtqvpmFYn98VzG+dbqmu2TmxpFBm6zg8vSFb8WmGVmkVjZfRpl0kn7tmoZthS4lfSYIMb7W1jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7493CFEC;
	Tue, 20 Feb 2024 07:22:28 -0800 (PST)
Received: from [10.1.197.60] (eglon.cambridge.arm.com [10.1.197.60])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BDDEA3F73F;
	Tue, 20 Feb 2024 07:21:44 -0800 (PST)
Message-ID: <2f373abf-f0c0-4f5d-9e22-1039a40a57f0@arm.com>
Date: Tue, 20 Feb 2024 15:21:43 +0000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/17] x86/resctrl : Support AMD Assignable Bandwidth
 Monitoring Counters (ABMC)
Content-Language: en-GB
To: Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
 reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
 bp@alien8.de, dave.hansen@linux.intel.com
Cc: x86@kernel.org, hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
 tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
 kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
 jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
 rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
 jithu.joseph@intel.com, kai.huang@intel.com, kan.liang@linux.intel.com,
 daniel.sneddon@linux.intel.com, pbonzini@redhat.com, sandipan.das@amd.com,
 ilpo.jarvinen@linux.intel.com, peternewman@google.com,
 maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, eranian@google.com
References: <20231201005720.235639-1-babu.moger@amd.com>
 <cover.1705688538.git.babu.moger@amd.com>
From: James Morse <james.morse@arm.com>
In-Reply-To: <cover.1705688538.git.babu.moger@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Babu,

On 19/01/2024 18:22, Babu Moger wrote:
> These series adds the support for Assignable Bandwidth Monitoring Counters
> (ABMC). It is also called QoS RMID Pinning feature
> 
> The feature details are documented in the  APM listed below [1].
> [1] AMD64 Architecture Programmer's Manual Volume 2: System Programming
> Publication # 24593 Revision 3.41 section 19.3.3.3 Assignable Bandwidth
> Monitoring (ABMC). The documentation is available at
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=206537
> 
> The patches are based on top of commit
> 1ac6b49423e83af2abed9be7fbdf2e491686c66b (tip/master)
> 
> # Introduction
> 
> AMD hardware can support 256 or more RMIDs. However, bandwidth monitoring
> feature only guarantees that RMIDs currently assigned to a processor will
> be tracked by hardware. The counters of any other RMIDs which are no longer
> being tracked will be reset to zero. The MBM event counters return
> "Unavailable" for the RMIDs that are not active.
>
> Users can create 256 or more monitor groups. But there can be only limited
> number of groups that can be give guaranteed monitoring numbers.  With ever
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

At a high level, if existing software can't use the counters, I'd prefer we move them into
perf. We're currently re-inventing the perf wheel. (this argument doesn't hold for the
llc_occupancy, which is a state not counter!)

But if this lets someone 'pin' the counters for the groups they monitor, then use existing
tools, that seems a good enough argument for doing this.


> Without ABMC enabled, monitoring will work in current mode without
> assignment option.

To check I understand: the counters will get spuriously reset a the whim of the hardware?


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
> 	#cat /sys/fs/resctrl/info/L3_MON/mon_features 
> 	llc_occupancy
> 	mbm_total_bytes
> 	mbm_total_bytes_config
> 	mbm_local_bytes
> 	mbm_local_bytes_config
> 	mbm_assign_capable ←  Linux kernel detected ABMC feature
> 
> b. Check if ABMC is enabled. By default, ABMC feature is disabled.
>    Monitoring works in legacy monitor mode when ABMC is not enabled.
> 
> 	#cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
> 	0
> 
> c. There will be new file "monitor_state" for each monitor group when ABMC
>    feature is supported. However, monitor_state is not available if ABMC is
>    disabled.
> 	#cat /sys/fs/resctrl/monitor_state 
> 	Unsupported
> 	
> d. Read the event mbm_total_bytes and mbm_local_bytes. Without ABMC
>    enabled, monitoring will work in current mode without assignment option.
> 	
> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	779247936
> 	# cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
> 	765207488
> 	
> e. Enable ABMC mode.
> 
> 	#echo 1 > /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>         #cat /sys/fs/resctrl/info/L3_MON/mbm_assign_enable
>         1

Why does this mode need enabling? Can't it be enabled automatically on hardware that
supports it, or enabled implicitly when the first assignment attempt arrives?

I guess this is really needed for a reset - could we implement that instead? This way
there isn't an extra step user-space has to do to make the assignments work.


> f. Read the monitor states. By default, both total and local MBM
> 	events are in "unassign" state.
> 	
> 	#cat /sys/fs/resctrl/monitor_state
> 	total=unassign;local=unassign


> g. Read the event mbm_total_bytes and mbm_local_bytes. In ABMC mode,
>    the MBA events are not available until the user assigns the events
>    explicitly.

How does this fit with "monitoring will work in current mode without assignment option.".
You mentioned the hardware resets the counters when this mode is enabled, does it also
refuse to count until the MSR is programmed?

If so - is there any mileage in auto-assigning the first N RMID to counters when the
groups are created? This way existing user-space tools work until they exceed the limits
of hardware. From that point a counter needs to be unassigned from another group. (we'd
need to make it easy to find which groups have a counter assigned)


> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	Unsupported
> 	
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes 
> 	Unsupported
> 
> h. The event llc_occupancy is not affected by ABMC mode. Users can still
>    read the llc_occupancy.
> 
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/llc_occupancy 
> 	557056

{
	MPAM would be the same - because llc_occupancy isn't a counter its a view of the
	state, its possible to multiplex a single llc_occupancy counter behind the scenes
	to provide the value for as many groups as needed. I suspect any other
	architecture would  have the same property.
}

> i. Now assign the total event and read the monitor_state.
> 	
> 	#echo total=assign > /sys/fs/resctrl/monitor_state
> 	#cat /sys/fs/resctrl/monitor_state 
> 	total=assign;local=unassign
> 	
> j. Now that the total event is assigned. Read the total event.
> 	
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	6136000
> 	
> k. Now assign the local event and read the monitor_state.
> 	
> 	#echo local=assign > /sys/fs/resctrl/monitor_state
> 	#cat /sys/fs/resctrl/monitor_state
> 	total=assign;local=assign
> 
>         Users can also assign both total and local events in one single
> 	command.
> 
> l. Now that both total and local events are assigned, read the events.
> 	
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_total_bytes
> 	6136000
> 	#cat /sys/fs/resctrl/mon_data/mon_L3_00/mbm_local_bytes
> 	58694

(the bandwidth configuration stuff is the existing BMEC support right?)

From user-space's perspective MPAM could be made to look the same.

There ought to be some indication to user-space of how many counters it can assign, this
number might be different for different resources. This won't be a problem today, but if
we had 'mbm_total_bytes' on the L2 cache, the number of counters may be different.

MPAM platforms are unlikely to support both 'mbm_total' and 'mbm_local',  I think this is
just a documentation problem to say that mbm_local can't be configured if its not
supported - user-space can't blindly assign both.

If the configuration is changed over time - I bet user-space needs a quick way to find
where the counters are currently assigned - walking the tree to find out is a bit rubbish.
A file that lists the "control_group_name[/mon_group_name]" would help.


Thanks,

James

