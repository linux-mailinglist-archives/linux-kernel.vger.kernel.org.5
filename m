Return-Path: <linux-kernel+bounces-155184-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D63128AE66C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 14:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EA8C9B24685
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Apr 2024 12:40:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57AD513443F;
	Tue, 23 Apr 2024 12:38:29 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 747B585631;
	Tue, 23 Apr 2024 12:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713875908; cv=none; b=XOjhtNNCLY5hNFnclgoBzFYHHrrTxa4R3U6M0izA2Zi019+0LrO5ELLsqV69GBugTz2g4pcOyUJ4H4rXODD1nnP/8yJgjfgoFICO2YzN50Ha30DuGmJiPR1aKrTpnuV/vybEroIiXrIhEpH3ccfnpGxJghuHJoFVT/7Zibpy4Zo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713875908; c=relaxed/simple;
	bh=W3QJ3abnpeI4gXmfwcQAafj4T+GPRhWjzlZLcC4bPRY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=P47/aOF8kg7mzR+Mb5ydIB6ACa+o8vB/kxW7nAxpQKfunTknCfSW/UzHy1K7Z2MRuZSoyG0vm5okyyP2QE9hSuP12OSAdfN87TlLbmLy0BucKNT68XFWKUs1HnYdGBwBRL871e96IWokEmFLBbTLXdJtD/W5HLAJ3wZibl30NS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D5717339;
	Tue, 23 Apr 2024 05:38:54 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CF0673F7BD;
	Tue, 23 Apr 2024 05:38:22 -0700 (PDT)
Date: Tue, 23 Apr 2024 13:38:20 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Peter Newman <peternewman@google.com>
Cc: Babu Moger <babu.moger@amd.com>, corbet@lwn.net, fenghua.yu@intel.com,
	reinette.chatre@intel.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org,
	hpa@zytor.com, paulmck@kernel.org, rdunlap@infradead.org,
	tj@kernel.org, peterz@infradead.org, yanjiewtw@gmail.com,
	kim.phillips@amd.com, lukas.bulwahn@gmail.com, seanjc@google.com,
	jmattson@google.com, leitao@debian.org, jpoimboe@kernel.org,
	rick.p.edgecombe@intel.com, kirill.shutemov@linux.intel.com,
	jithu.joseph@intel.com, kai.huang@intel.com,
	kan.liang@linux.intel.com, daniel.sneddon@linux.intel.com,
	pbonzini@redhat.com, sandipan.das@amd.com,
	ilpo.jarvinen@linux.intel.com, maciej.wieczor-retman@intel.com,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	eranian@google.com, james.morse@arm.com
Subject: Re: [RFC PATCH v3 00/17] x86/resctrl : Support AMD Assignable
 Bandwidth Monitoring Counters (ABMC)
Message-ID: <ZiervIprcwoApAqw@e133380.arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <ZiaRXrmDDjc194JI@e133380.arm.com>
 <CALPaoCh5DDmojnkUZPnACkq_ugwKnqCnwLHj2sV69TSTzpAL9g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALPaoCh5DDmojnkUZPnACkq_ugwKnqCnwLHj2sV69TSTzpAL9g@mail.gmail.com>

Hi Peter,

On Mon, Apr 22, 2024 at 11:23:50AM -0700, Peter Newman wrote:
> Hi Dave,
> 
> On Mon, Apr 22, 2024 at 9:33 AM Dave Martin <Dave.Martin@arm.com> wrote:
> >
> > Hi Babu,
> >
> > On Thu, Mar 28, 2024 at 08:06:33PM -0500, Babu Moger wrote:
> > >        Assignment flags can be one of the following:
> > >
> > >         t  MBM total event is assigned
> >
> > With my MPAM hat on this looks a bit weird, although I suppose it
> > follows on from the way "mbm_total_bytes" and "mbm_local_bytes" are
> > already exposed in resctrlfs.
> >
> > From an abstract point of view, "total" and "local" are just event
> > selection criteria, additional to those in mbm_cfg_mask.  The different
> > way they are treated in the hardware feels like an x86 implementation
> > detail.
> >
> > For MPAM we don't currently distinguish local from non-local traffic, so
> > I guess this just reduces to a simple on-off (i.e., "t" or nothing),
> > which I guess is tolerable.
> >
> > This might want more thought if there is an expectation that more
> > categories will be added here, though (?)
> 
> There should be a path forward whenever we start supporting
> user-configured counter classes. I assume the letters a-z will be
> enough to cover all the counter classes which could be used at once.

Ack, though I'd appreciate a response on the point about "_" below in
case people missed it.

> 
> >
> > >         l  MBM local event is assigned
> > >         tl Both total and local MBM events are assigned
> > >         _  None of the MBM events are assigned
> >
> > This use of '_' seems unusual.  Can we not just have the empty string
> > for "nothing assigned"?
> >
> > Since every assignment is terminated by ';' or end-of-line, I don't
> > think that there would be any parsing ambiguity (?)
> >
> > >
> > >       Examples:
> > >
> > >       # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> > >       non_defult_group//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> > >       non_defult_group/non_default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> > >       //0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> > >       /default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> > >
> > >       There are four groups and all the groups have local and total event assigned.
> > >
> > >       "//" - This is a default CONTROL MON group
> > >
> > >       "non_defult_group//" - This is non default CONTROL MON group
> > >
> > >       "/default_mon1/"  - This is Child MON group of the defult group
> > >
> > >       "non_defult_group/non_default_mon1/" - This is child MON group of the non default group
> > >
> > >       =tl means both total and local events are assigned.
> > >
> > > e. Update the group assignment states using the interface file /sys/fs/resctrl/info/L3_MON/mbm_assign_control.
> > >
> > >       The write format is similar to the above list format with addition of
> > >       op-code for the assignment operation.
> >
> > With by resctrl newbie hat on:
> >
> > It feels a bit complex (for the kernel) to have userspace needing to
> > write a script into a magic file that we need to parse, specifying
> > updates to a bunch of controls already visible as objects in resctrlfs
> > in their own right.
> >
> > What's the expected use case here?
> 
> I went over the use case of iterating a small number of monitors over
> a much larger number of monitoring groups here:
> 
> https://lore.kernel.org/lkml/CALPaoCi=PCWr6U5zYtFPmyaFHU_iqZtZL-LaHC2mYxbETXk3ig@mail.gmail.com/
> 
> >
> > If userspace really does need to switch lots of events simultaneously
> > then I guess the overhead of enumerating and poking lots of individual
> > files might be unacceptable though, and we would still need some global
> > interfaces for operations such as "unassign everything"...
> 
> My main goal is for the number of parallel IPI batches to all the
> domains (or write syscalls) to be O(num_rmids / num_monitors) rather
> than O(num_rmids * num_monitors) as I need to know how frequently we
> can afford to sample the current memory bandwidth of the maximum
> number of monitoring groups supported.

Fair enough; I wasn't fully aware of the background discussions.

Cheers
---Dave

