Return-Path: <linux-kernel+bounces-140645-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D4A998A1733
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8BEA9B2CF0E
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:28:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF08F14EC71;
	Thu, 11 Apr 2024 14:27:37 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF56414EC5A
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845657; cv=none; b=M0+dEo3zR9ApKlp1HHli/CJZka6nXyRLSkAjyZeyUY5n8qMNFfu4/DSQ2F5iRD9/gMkcJqsI7g12P1FF9ZnHLV8TE5RTsjTcOSRFNk5iJGB1ZOs0+GHKlBxv8Oaam8iKF97Bt+Syjtr2nCgScSstfl0PdnkE5lW4PhHxCnrA83Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845657; c=relaxed/simple;
	bh=EU/UjKXDgctiWfZFTVYonN3edS86CMZY0PEjyqsc4UI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=otCYVEYrGwVqg251MDlL8esetxvBnZG8Wfnr56wcCs4+GvLGa0eooIqbmOtPb/Yco/0c8sC83amGV3Zqsfk04+XcQ7R3gGKg8CPoz4fkuRtspeTqGW3HyAt9G1uTxKi5tqV9ifgXjNzlfi7WJp0dUQ1YikPURrWZgZYZnB01PHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id D07041596;
	Thu, 11 Apr 2024 07:28:04 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8A7C13F64C;
	Thu, 11 Apr 2024 07:27:32 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:27:30 +0100
From: Dave Martin <Dave.Martin@arm.com>
To: "Shaopeng Tan (Fujitsu)" <tan.shaopeng@fujitsu.com>
Cc: 'James Morse' <james.morse@arm.com>, "x86@kernel.org" <x86@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Fenghua Yu <fenghua.yu@intel.com>,
	Reinette Chatre <reinette.chatre@intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	H Peter Anvin <hpa@zytor.com>, Babu Moger <Babu.Moger@amd.com>,
	"shameerali.kolothum.thodi@huawei.com" <shameerali.kolothum.thodi@huawei.com>,
	D Scott Phillips OS <scott@os.amperecomputing.com>,
	"carl@os.amperecomputing.com" <carl@os.amperecomputing.com>,
	"lcherian@marvell.com" <lcherian@marvell.com>,
	"bobo.shaobowang@huawei.com" <bobo.shaobowang@huawei.com>,
	"baolin.wang@linux.alibaba.com" <baolin.wang@linux.alibaba.com>,
	Jamie Iles <quic_jiles@quicinc.com>,
	Xin Hao <xhao@linux.alibaba.com>,
	"peternewman@google.com" <peternewman@google.com>,
	"dfustini@baylibre.com" <dfustini@baylibre.com>,
	"amitsinght@marvell.com" <amitsinght@marvell.com>,
	David Hildenbrand <david@redhat.com>,
	Rex Nie <rex.nie@jaguarmicro.com>
Subject: Re: [PATCH v1 30/31] x86/resctrl: Move the filesystem bits to
 headers visible to fs/resctrl
Message-ID: <ZhfzUgbpE30ufj+d@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-31-james.morse@arm.com>
 <TYAPR01MB63304D1AC781C7E293CFEF958B3C2@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <TYAPR01MB63304D1AC781C7E293CFEF958B3C2@TYAPR01MB6330.jpnprd01.prod.outlook.com>

On Thu, Apr 04, 2024 at 07:43:03AM +0000, Shaopeng Tan (Fujitsu) wrote:
> Hello James
> 
> > Once the filesystem parts of resctrl move to fs/resctrl, it cannot rely on
> > definitions in x86's internal.h.
> > 
> > Move definitions in internal.h that need to be shared between the filesystem
> > and architecture code to header files that fs/resctrl can include.
> > 
> > Doing this separately means the filesystem code only moves between files of
> > the same name, instead of having these changes mixed in too.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >  arch/x86/include/asm/resctrl.h         |  3 +++
> >  arch/x86/kernel/cpu/resctrl/core.c     |  5 ++++
> >  arch/x86/kernel/cpu/resctrl/internal.h | 36 --------------------------
> >  include/linux/resctrl.h                |  3 +++
> >  include/linux/resctrl_types.h          | 30
> > +++++++++++++++++++++
> >  5 files changed, 41 insertions(+), 36 deletions(-)

[...]

> > diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h index
> > f786ffceeda3..00cc0457af50 100644
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -41,6 +41,9 @@ int proc_resctrl_show(struct seq_file *m,
> >   */
> >  #define RESCTRL_MAX_CBM			32
> > 
> > +extern unsigned int resctrl_rmid_realloc_limit; extern unsigned int
> > +resctrl_rmid_realloc_threshold;
> > +

[FYI, your mailer or editor seems to have messed this patch up a bit in
your reply...]

> These two variables has been defined.
>  44 extern unsigned int resctrl_rmid_realloc_limit;
>  45 extern unsigned int resctrl_rmid_realloc_threshold;
> 400 extern unsigned int resctrl_rmid_realloc_threshold;
> 401 extern unsigned int resctrl_rmid_realloc_limit;
> 
> Best regards,
> Shaopeng TAN

[...]

Strange.  This looks unintentional and there don't seem to be any
relevant #ifdefs or references to these variables in the header that
might justify reordering these declarations.

I'll propose to James that the addition of these duplicates be reverted
out, so long as it doesn't break anything.

Cheers
---Dave

