Return-Path: <linux-kernel+bounces-153710-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C7E3D8AD1F4
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 18:34:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAB451C20BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Apr 2024 16:34:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9071D153813;
	Mon, 22 Apr 2024 16:34:12 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45191DDE9;
	Mon, 22 Apr 2024 16:34:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713803652; cv=none; b=T71CBdj0kQCBCcBxrmr121dxB9Yt7Nug9wXjIlw2TIDWTvS2yGh6MZt8dbPGmmqydJd1h+YMkltzHYCBr+Wl3KgQlmnXs32U/8KPujuLvACpJuq75yyweOTFPufx0E8H0YgV9oB5rm2juH4DM3xu/xQN6zEbKzlXlhweuGDcnkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713803652; c=relaxed/simple;
	bh=d5IIQ+icFprsbUfXtANNO4dU2P3pW3Nchx/JQxVt3b0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eCdezS4XC2U+cdpEj4bpE/kzp/8+iOBm6yLax4cVv6jfUvBLSPu59hPCvuSX5kYE6RGq0McyiFqM7KX87iAEEkFTiUFjhiF+d32KwiTVv3IiCHi4qZ1xvgRZsLvyI4JBNkDbjdG7yhQXcQojP3x4PL8ZOnEp1eFPnbYxG3wGqJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 71E9E1063;
	Mon, 22 Apr 2024 09:34:38 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1F77D3F7BD;
	Mon, 22 Apr 2024 09:34:06 -0700 (PDT)
Date: Mon, 22 Apr 2024 17:34:03 +0100
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
Message-ID: <ZiaRewZJnLaDSx3m@e133380.arm.com>
References: <cover.1711674410.git.babu.moger@amd.com>
 <CALPaoCheW=Jz2R3gMKcgwQe6ONDrRqu3tUxeg=A3USg6BC8buA@mail.gmail.com>
 <7ccd59b8-9fe3-4d1f-82f5-f33d96dbf5ac@amd.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7ccd59b8-9fe3-4d1f-82f5-f33d96dbf5ac@amd.com>

Hi Babu,

On Thu, Apr 04, 2024 at 03:02:45PM -0500, Moger, Babu wrote:
> Hi Peter,
> 
> 
> On 4/4/24 14:08, Peter Newman wrote:
> > Hi Babu,
> > 
> > On Thu, Mar 28, 2024 at 6:07 PM Babu Moger <babu.moger@amd.com> wrote:
> >>    The list follows the following format:
> >>
> >>        * Default CTRL_MON group:
> >>                "//<domain_id>=<assignment_flags>"
> >>
> >>        * Non-default CTRL_MON group:
> >>                "<CTRL_MON group>//<domain_id>=<assignment_flags>"
> >>
> >>        * Child MON group of default CTRL_MON group:
> >>                "/<MON group>/<domain_id>=<assignment_flags>"
> >>
> >>        * Child MON group of non-default CTRL_MON group:
> >>                "<CTRL_MON group>/<MON group>/<domain_id>=<assignment_flags>"
> >>
> >>        Assignment flags can be one of the following:
> >>
> >>         t  MBM total event is assigned
> >>         l  MBM local event is assigned
> >>         tl Both total and local MBM events are assigned
> >>         _  None of the MBM events are assigned
> >>
> >>         Examples:
> >>
> >>         # cat /sys/fs/resctrl/info/L3_MON/mbm_assign_control
> >>         non_defult_group//0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> >>         non_defult_group/non_default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> >>         //0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> >>         /default_mon1/0=tl;1=tl;2=tl;3=tl;4=tl;5=tl;6=tl;7=tl;
> >>
> >>         There are four groups and all the groups have local and total event assigned.
> >>
> >>         "//" - This is a default CONTROL MON group
> >>
> >>         "non_defult_group//" - This is non default CONTROL MON group
> >>
> >>         "/default_mon1/"  - This is Child MON group of the defult group
> >>
> >>         "non_defult_group/non_default_mon1/" - This is child MON group of the non default group
> >>
> >>         =tl means both total and local events are assigned.
> > 
> > I recall there was supposed to be a way to perform the same update on
> > all domains together so that it isn't tedious to not do per-domain
> 
> Yes. Correct. Reinette suggested to have "no domains" means ALL the domains.

Would "*" be more intuitive?

Whatever is done here to describe the "wildcard node", would it be worth
having the node field parse the same way in the "schemata" files?

Is there any merit in having range match expressions, e.g. something like

	0-3,8-11=foo;4-7,12-*=bar

(The latter is obvious feature creep though, so a real use case for this
would be needed to justify it.  I don't have one right now...)

[...]

Cheers
---Dave

