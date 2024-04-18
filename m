Return-Path: <linux-kernel+bounces-150389-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BE0448A9E51
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:26:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF3751C21B77
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:26:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B75A16C6A9;
	Thu, 18 Apr 2024 15:26:03 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6A316D311
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713453963; cv=none; b=pAwDCEoVin9+By54guLgiY9ppml6JV3C3TI484paT6L6otZKpRV9V2RJr5+JrbYNSqQmMdxb3gUMLAHuD25BAwv8b+xXcNztBnwMd2HHQfelKWCnFaokee0sIAkNSRViG1hDht2qAuqicb8oKER6ZbVjXWAIVJ9IdnqPyeMPLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713453963; c=relaxed/simple;
	bh=bEOqzDXP47lSK/zOMIMKpsftgU8rG8VCYU+LjtwngMs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfNQz2xpdtrBeqgZBgEWBvqJkhxmWe9Zc+DnRM7SlETGyzwy9TXfHp6gHoV45nDhxcYGN0SLkGWMl0xDxgaQs+i0dndhQZiD9sBimTGPAkl4RJQuxpMeZ1fBch+kTm130Aawdk6jEeBBRhmaHpGixVp5uYk6gPpQpKG10zVBrsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DC472F;
	Thu, 18 Apr 2024 08:26:28 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DFFA53F738;
	Thu, 18 Apr 2024 08:25:56 -0700 (PDT)
Date: Thu, 18 Apr 2024 16:25:54 +0100
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
Message-ID: <ZiE7gritCvxF1XS5@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-9-james.morse@arm.com>
 <0ba51259-cb7a-463e-aabd-f88bd0c4007b@intel.com>
 <ZhlegNN3zZ4Q1lk6@e133380.arm.com>
 <fe8e56bb-55bf-4130-876f-3047da182da1@intel.com>
 <Zh6k9uagoaj9oTl6@e133380.arm.com>
 <a32acb5a-a6e1-4de1-841e-9a1372d624a5@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a32acb5a-a6e1-4de1-841e-9a1372d624a5@intel.com>

On Wed, Apr 17, 2024 at 10:15:57PM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 4/16/2024 9:19 AM, Dave Martin wrote:
> > On Mon, Apr 15, 2024 at 11:03:05AM -0700, Reinette Chatre wrote:
> >> Hi Dave,
> >>
> >> On 4/12/2024 9:17 AM, Dave Martin wrote:
> >>> On Mon, Apr 08, 2024 at 08:18:00PM -0700, Reinette Chatre wrote:
> >>>> On 3/21/2024 9:50 AM, James Morse wrote:
> >>>>> To avoid sticky problems in the mpam glue code, move the resctrl
> >>>>> enums into a separate header.
> >>>>
> >>>> Could you please elaborate so that "sticky problems in the mpam glue code" is
> >>>> specific about what problems are avoided?
> >>>
> >>> Maybe just delete the the sticky clause, and leave:
> >>>
> >>> 	Move the resctrl enums into a separate header.
> >>>
> >>> ...since the next paragraph explains the rationale?
> >>
> >> In the x86 area changelogs start with a context paragraph to
> >> provide reader with foundation to parse the subsequent problem and
> >> solution statements (that are also expected to be in separate
> >> paragraphs in that order). 
> > 
> > Acknowledged; I was hoping to avoid a rewrite, but ...
> >>
> >>>>> This lets the arch code declare prototypes that use these enums without
> >>>>> creating a loop via asm<->linux resctrl.h The same logic applies to the
> >>>>> monitor-configuration defines, move these too.
> > 
> > [...]
> > 
> > OK, how about the following:
> > 
> > --8<--
> > 
> > When resctrl is fully factored into core and per-arch code, each arch
> > will need to use some resctrl common definitions in order to define its
> > own specialisations and helpers.  Following conventional practice,
> 
> specializations

Debatable, but OK, fine.

> > it would be desirable to put the dependent arch definitions in an
> > <asm/resctrl.h> header that is included by the common <linux/resctrl.h>
> > header.  However, this can make it awkward to avoid a circular
> > dependency between <linux/resctrl.h> and the arch header.
> > 
> > To avoid solving this issue via conditional inclusion tricks that are
> > likely to be tricky to maintain, move the affected common types and
> 
> To help with motivation please be specific (somebody may interpret above
> that it may not be tricky to maintain). So just ... "that are difficult
> to maintain ...".

Rather than the text encouraging questions about whether there are
reasonable alternative approaches, perhaps this can just be, simply:

"To avoid such dependencies, move the affected types into a new
header [...]"

?

> 
> > constants into a new header that does not need to depend on
> > <linux/resctrl.h> or on the arch headers.
> > 
> > The same logic applies to the monitor-configuration defines, move
> > these too.
> > 
> > -->8--
> > 
> 
> This explains the motivation for this file well, but its contents
> is not obvious to me and after reading [1] I am more weary of including
> code before use. Not all of these definitions are needed
> by the end of this series so there needs to be a good motivation for
> making things global without any visible user.

That's fair.  I guess we need to review the contents of this header and
make sure that everything that's here really should be here.

However, this is not user ABI and there are only 1.5 users of this
interface (given that MPAM is not yet merged).  So, the penalty for
not getting this quite right and fixing it later seems low.

If you agree that adding this header is appropriate, are you OK with
some post-merge cleanup, or do you think it's essential to sanitise this
fully up-front?

> 
> I do understand that in the next stage of this work we may need to deal
> with potentially three subsystems when making changes and there is thus 
> a strong motivation for laying a good foundation now. I do not think this
> should be an excuse to not be diligent in ensuring the changes are
> required.
> 
> > Then:
> > 
> >>>>>
> >>>>> The maintainers entry for these headers was missed when resctrl.h
> >>>>> was created. Add a wildcard entry to match both resctrl.h and
> >>>>> resctrl_types.h.
> >>>>>
> >>>>> Signed-off-by: James Morse <james.morse@arm.com>
> > 
> > The last paragraph looks like it can stand as-is.
> > 
> > Does that look OK?
> 
> Yes.
> 
> Reinette
> 
> [1] https://lore.kernel.org/lkml/ZhecyLQsGZ9Iv8wU@gmail.com/
>  

Cheers
---Dave

