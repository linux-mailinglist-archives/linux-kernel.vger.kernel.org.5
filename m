Return-Path: <linux-kernel+bounces-166672-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FDC8B9DF4
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 17:58:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 967511F2202B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 May 2024 15:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9091015B96E;
	Thu,  2 May 2024 15:58:46 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A25F1F5F6
	for <linux-kernel@vger.kernel.org>; Thu,  2 May 2024 15:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714665526; cv=none; b=q9DolCLkr5pVVSzIwKJXWvoXXRMCql48znmip7sD4bzAkbPQ5ugT1Dgn7VqwFiBctMxkFSc+SkYAT86U1H3z2KR4FIFdLueGu6tq/bjTt3miMRSL0QXIZLEgR8wupj3clKscczft4q5YdtZEXM4uH9HY1aNhgVAeN/1QlVemmUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714665526; c=relaxed/simple;
	bh=yyE+ZEdf8UN5xDxOi4JLEeKVEqMHLM/n9v4wAEl/cFA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jjCQ9b8WR92Ki+t1gLhalmxbDy4K96wi6M99lVKZANcsI6PE/ni1HpO/xDpToshmPt7TG6l0SjM3LP1jKctyrtvJZj1hcqHxq0MAKiPaiSP0eKdCjrbrMB3VQJ7PHFD/aESI9Al6EdbKEF/moHFkYJBFKABnF9cbW+qoaClL3lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 56CC22F4;
	Thu,  2 May 2024 08:59:08 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E72533F793;
	Thu,  2 May 2024 08:58:39 -0700 (PDT)
Date: Thu, 2 May 2024 16:58:37 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: Amit Singh Tomar <amitsinght@marvell.com>
Cc: Reinette Chatre <reinette.chatre@intel.com>,
	James Morse <james.morse@arm.com>, x86@kernel.org,
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
	dfustini@baylibre.com, David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v1 28/31] x86/resctrl: Drop __init/__exit on assorted
 symbols
Message-ID: <ZjO4LXqGcy4bwsn4@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-29-james.morse@arm.com>
 <c27c7813-5744-4363-bb7b-f9fbe80fd549@intel.com>
 <ZhfzF8L6w1pgJJ1r@e133380.arm.com>
 <47af4fef-35d3-4d88-9afa-42c1a99fbe07@marvell.com>
 <ZhlfQKMg4xeA53SD@e133380.arm.com>
 <b87653fa-34e3-4124-a96f-f5d2b9730f10@marvell.com>
 <ZjEaA+YRPA+p9msM@e133380.arm.com>
 <cb40c3e6-f678-45c7-b8e7-a6f337b51dfb@marvell.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb40c3e6-f678-45c7-b8e7-a6f337b51dfb@marvell.com>

On Wed, May 01, 2024 at 09:51:51PM +0530, Amit Singh Tomar wrote:
> 
> > > > I think James will need to comment on this, but I think that yes, it
> > > > is probably appropriate to require a reboot.  I think an MPAM error
> > > > interrupt should only happen if the software did something wrong, so
> > > > it's a bit like hitting a BUG(): we don't promise that everything works
> > > > 100% properly until the system is restarted.  Misbehaviour should be
> > > > contained to MPAM though.
> > > > 
> > > if "resctrl" is nonfunctional in this state, then this comment[1] here does
> > > *not* make sense.
> > > 
> > > "restore any modified controls to their reset values."
> > 
> > Can you clarify what you mean here?
> 
> What I meant was, What's the rationale behind restoring the modified
> controls, if user is going to restart the system anyways (in order to use
> MPAM again), but later realized that it is needed so that *non* MPAM loads
> (user may still want to run other things even after MPAM error interrupt)
> would not have any adverse effect with modified controls.
> 
> Therefore, taking my statement back.

Ack: we can't force the system to restart without losing data.  Really,
the decision about when and whether to attempt a graceful shutdown or
reboot should be left to userspace.  But until userspace does shut down
the system, we do our best to behave as if the broken part of the system
(MPAM) were not present at all.

[...]

Cheers
---Dave

