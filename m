Return-Path: <linux-kernel+bounces-147221-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 50B238A712B
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 18:19:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 822991C21FC1
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 16:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96F7B131BC9;
	Tue, 16 Apr 2024 16:19:10 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE5412D741
	for <linux-kernel@vger.kernel.org>; Tue, 16 Apr 2024 16:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713284350; cv=none; b=H1ZhN+0lOnZSS9ae9Ch6QfaB8zoXc4W8p4rdWMlRGm0h+bgUrKqNddQ85z9T/MRB21+P1xco5ka9PRU3nmT3xmOgAa73b0bG+Hiv/zEnu9CDFJ1sDgjkEbxI0kys6+qrOdogp0A4FBrMKxA0K2fJH+MjIQSIpOqlSnuBXV6pKJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713284350; c=relaxed/simple;
	bh=H+6hIFGMeFCyIJcxo0lSEDSP1/tIv9dbgao6V0kHu38=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Zt97JeQVa+aBUrkY4694/6JoPt+CrkFqs4KM7vYfoUlTBOs4zy6xtOKlnf1oMAJZ+fxZYRTFo42mKY9S4oS8hClDvvtoaxEH8gxG1SEnlmdW/rLTt+7wJrOXgZn2PjrJmJ3n315PF4ak4sHI/LuFK/JfSlW5A8qWWYMWl64g7/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0C298DA7;
	Tue, 16 Apr 2024 09:19:36 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1C2B63F792;
	Tue, 16 Apr 2024 09:19:05 -0700 (PDT)
Date: Tue, 16 Apr 2024 17:19:02 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: James Morse <james.morse@arm.com>, x86@kernel.org,
	linux-kernel@vger.kernel.org, Fenghua Yu <fenghua.yu@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	shameerali.kolothum.thodi@huawei.com,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	carl@os.amperecomputing.com, lcherian@marvell.com,
	bobo.shaobowang@huawei.com, tan.shaopeng@fujitsu.com,
	baolin.wang@linux.alibaba.com, Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>, peternewman@google.com,
	dfustini@baylibre.com, amitsinght@marvell.com,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v1 08/31] x86/resctrl: Move resctrl types to a separate
 header
Message-ID: <Zh6k9uagoaj9oTl6@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-9-james.morse@arm.com>
 <0ba51259-cb7a-463e-aabd-f88bd0c4007b@intel.com>
 <ZhlegNN3zZ4Q1lk6@e133380.arm.com>
 <fe8e56bb-55bf-4130-876f-3047da182da1@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe8e56bb-55bf-4130-876f-3047da182da1@intel.com>

On Mon, Apr 15, 2024 at 11:03:05AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 4/12/2024 9:17 AM, Dave Martin wrote:
> > On Mon, Apr 08, 2024 at 08:18:00PM -0700, Reinette Chatre wrote:
> >> On 3/21/2024 9:50 AM, James Morse wrote:
> >>> To avoid sticky problems in the mpam glue code, move the resctrl
> >>> enums into a separate header.
> >>
> >> Could you please elaborate so that "sticky problems in the mpam glue code" is
> >> specific about what problems are avoided?
> > 
> > Maybe just delete the the sticky clause, and leave:
> > 
> > 	Move the resctrl enums into a separate header.
> > 
> > ...since the next paragraph explains the rationale?
> 
> In the x86 area changelogs start with a context paragraph to
> provide reader with foundation to parse the subsequent problem and
> solution statements (that are also expected to be in separate
> paragraphs in that order). 

Acknowledged; I was hoping to avoid a rewrite, but ...
> 
> >>> This lets the arch code declare prototypes that use these enums without
> >>> creating a loop via asm<->linux resctrl.h The same logic applies to the
> >>> monitor-configuration defines, move these too.

[...]

OK, how about the following:

--8<--

When resctrl is fully factored into core and per-arch code, each arch
will need to use some resctrl common definitions in order to define its
own specialisations and helpers.  Following conventional practice,
it would be desirable to put the dependent arch definitions in an
<asm/resctrl.h> header that is included by the common <linux/resctrl.h>
header.  However, this can make it awkward to avoid a circular
dependency between <linux/resctrl.h> and the arch header.

To avoid solving this issue via conditional inclusion tricks that are
likely to be tricky to maintain, move the affected common types and
constants into a new header that does not need to depend on
<linux/resctrl.h> or on the arch headers.

The same logic applies to the monitor-configuration defines, move
these too.

-->8--

Then:

> >>>
> >>> The maintainers entry for these headers was missed when resctrl.h
> >>> was created. Add a wildcard entry to match both resctrl.h and
> >>> resctrl_types.h.
> >>>
> >>> Signed-off-by: James Morse <james.morse@arm.com>

The last paragraph looks like it can stand as-is.

Does that look OK?


[...]

> >>> diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
> >>> new file mode 100644
> >>> index 000000000000..4788bd95dac6
> >>> --- /dev/null
> >>> +++ b/include/linux/resctrl_types.h
> >>> @@ -0,0 +1,68 @@
> >>> +/* SPDX-License-Identifier: GPL-2.0 */
> >>> +/*
> >>> + * Copyright (C) 2024 Arm Ltd.
> >>> + * Based on arch/x86/kernel/cpu/resctrl/internal.h
> >>> + */
> >>
> >> Could this header please explain how this file is intended to be used?
> >> What is it intended to contain?
> >>
> >> Reinette
> > 
> > Maybe something like the following?
> > 
> >  * Resctrl types and constants needed for inline function definitions in
> >  * the arch-specific <asm/resctrl.h> headers.
> > 
> 
> ok.
> 
> Reinette
> 

OK, I'll propose to add that.

Cheers
---Dave

