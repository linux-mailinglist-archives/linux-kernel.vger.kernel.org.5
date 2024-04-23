Return-Path: <linux-kernel+bounces-155181-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C2DA8AE668
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:39:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4119B1C21F6F
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:39:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A493B131BB1;
	Tue, 23 Apr 2024 12:37:50 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C928786252;
	Tue, 23 Apr 2024 12:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875870; cv=none; b=bbjVezm08W1hnXs0BAs5VO2KQA4bh/8TuMnMLjApO/Yjn18mOg5QErFGM0JJU5W7F9HywaZq9sy2MdCsWqM0zatTalLh99IwbobLnSb3n0ttBq/KWOsFqvAbQwS1kMoOLb9lgZ7IV8lTrG0Bvu7WT6yokoxoTvJYdzaPUmE9E28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875870; c=relaxed/simple;
	bh=a3kqUHLYmR5pmzhg2OJxtmhHSNHmTXPyeYCaZXx0lOU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pehxt97DQTz4kwhA2IhbvjTdE1F9pmOgTbpLVu3kgfEH6GwMqubtD+kc8VeDyxPowb/yAISClN/jgQYI0XtM0qYrXyS0Pz1gB9YO8uhhDnwVWZZED1OjErFn9VAzGhK1kVYHTMmrX/C55UKkVTrbzQ8/xSfIMBjKlYJNmABIH2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 561E9339;
	Tue, 23 Apr 2024 05:38:11 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38DBB3F7BD;
	Tue, 23 Apr 2024 05:37:39 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:37:33 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: "Moger, Babu" <babu.moger@amd.com>
Cc: Peter Newman <peternewman@google.com>, corbet@lwn.net,
	fenghua.yu@intel.com, reinette.chatre@intel.com, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, paulmck@kernel.org,
	rdunlap@infradead.org, tj@kernel.org, peterz@infradead.org,
	yanjiewtw@gmail.com, kim.phillips@amd.com, lukas.bulwahn@gmail.com,
	seanjc@google.com, jmattson@google.com, leitao@debian.org,
	jpoimboe@kernel.org, rick.p.edgecombe@intel.com,
	kirill.shutemov@linux.intel.com, jithu.joseph@intel.com,
	kai.huang@intel.com, kan.liang@linux.intel.com,
	daniel.sneddon@linux.intel.com, pbonzini@redhat.com,
	sandipan.das@amd.com, ilpo.jarvinen@linux.intel.com,
	maciej.wieczor-retman@intel.com, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, eranian@google.com,
	james.morse@arm.com
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
Message-ID: <ZierjRNDMfg5swT8@e133380.arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <CALPaoCheW=Jz2R3gMKcgwQe6ONDrRqu3tUxeg=A3USg6BC8buA@mail.gmail.com>
 <7ccd59b8-9fe3-4d1f-82f5-f33d96dbf5ac@amd.com>
 <ZiaRewZJnLaDSx3m@e133380.arm.com>
 <004dcaeb-30ae-4b27-895a-4025a670fcbf@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <004dcaeb-30ae-4b27-895a-4025a670fcbf@amd.com>

On Mon, Apr 22, 2024 at 03:44:26PM -0500, Moger, Babu wrote:
> Hi Dave,
> 
> On 4/22/24 11:34, Dave Martin wrote:
> > Hi Babu,
> > 
> > On Thu, Apr 04, 2024 at 03:02:45PM -0500, Moger, Babu wrote:
> >> Hi Peter,
> >>
> >>
> >> On 4/4/24 14:08, Peter Newman wrote:
> >>> Hi Babu,
> >>>
> >>> On Thu, Mar 28, 2024 at 6:07 PM Babu Moger <babu.moger@amd.com> wrote:
> >>>>    The list follows the following format:
> >>>>
> >>>>        * Default CTRL_MON group:
> >>>>                "//<domain_id>=<assignment_flags>"
> >>>>
> >>>>        * Non-default CTRL_MON group:
> >>>>                "<CTRL_MON group>//<domain_id>=<assignment_flags>"
> >>>>
> >>>>        * Child MON group of default CTRL_MON group:
> >>>>                "/<MON group>/<domain_id>=<assignment_flags>"
> >>>>
> >>>>        * Child MON group of non-default CTRL_MON group:
> >>>>                "<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"
> >>>>
> >>>>        Assignment flags can be one of the following:
> >>>>
> >>>>         t  MBM total event is assigned
> >>>>         l  MBM local event is assigned
> >>>>         tl Both total and local MBM events are assigned
> >>>>         _  None of the MBM events are assigned
> >>>>
> >>>>         Examples:
> >>>>
> >>>>         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> >>>>         non_defult_group//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> >>>>         non_defult_group/non_default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> >>>>         //0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> >>>>         /default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> >>>>
> >>>>         There are four groups and all the groups have local and total event assigned.
> >>>>
> >>>>         "//" - This is a default CONTROL MON group
> >>>>
> >>>>         "non_defult_group//" - This is non default CONTROL MON group
> >>>>
> >>>>         "/default_mon1/"  - This is Child MON group of the defult group
> >>>>
> >>>>         "non_defult_group/non_default_mon1/" - This is child MON group of the non default group
> >>>>
> >>>>         =tl means both total and local events are assigned.
> >>>
> >>> I recall there was supposed to be a way to perform the same update on
> >>> all domains together so that it isn't tedious to not do per-domain
> >>
> >> Yes. Correct. Reinette suggested to have "no domains" means ALL the domains.
> > 
> > Would "*" be more intuitive?
> 
> We could. But I don't see the need for wildcard ("*") or ranges and
> complexity that comes with that.

For "*", I mean that this would just stand for "all cpus", not a generic
string match; apologies if I didn't make that clear.

I think that an explicit "*" is still a less surprising way to say
"everything" than "" (which if it means anything at all, usually means
"nothing").

I may have misunderstood the intention here: _if_ the intention is to
provide a way to enable/disable an event in all domains without having
to enumerate them all one by one, then I think "*" is preferable syntax
to "".  That was my only real suggestion here.

> 
> Even in schemata processing we don't use the wildcard or ranges and also
> there is no mention of that in documentation.
> https://www.kernel.org/doc/Documentation/x86/resctrl.rst

I know, though writing the schemata files can be tedious and annoying,
since their content is often very repetitive, so ...

> 
> Domains(or nodes) are processed one by one. Some examples.
> 
>  # cat schemata
>     SMBA:0=2048;1=2048;2=2048;3=2048
>       MB:0=2048;1=2048;2=2048;3=2048
>       L3:0=ffff;1=ffff;2=ffff;3=ffff
> 
>   # echo "SMBA:1=64" > schemata
>   # cat schemata
>     SMBA:0=2048;1=  64;2=2048;3=2048
>       MB:0=2048;1=2048;2=2048;3=2048
>       L3:0=ffff;1=ffff;2=ffff;3=ffff

.. it would be convenient to be able to do something like

# echo "SMBA:*=64" >schemata
# grep SMBA: schemata
SMBA:0=  64;1=  64;2=  64;3=  64

Anyway, this is nothing directly to do with this series; just a
thought.


> > Whatever is done here to describe the "wildcard node", would it be worth
> > having the node field parse the same way in the "schemata" files?
> > 
> > Is there any merit in having range match expressions, e.g. something like
> > 
> > 	0-3,8-11=foo;4-7,12-*=bar
> > 
> > (The latter is obvious feature creep though, so a real use case for this
> > would be needed to justify it.  I don't have one right now...)

[...]

> Thanks
> Babu Moger

I do agree that unless someone jumps up and down saying this would
help their use case, this is probably a step too far.

Just thinking aloud (and this kind of feature could be added later in a
backwards compatible way if someone really needs it).

Cheers
---Dave

