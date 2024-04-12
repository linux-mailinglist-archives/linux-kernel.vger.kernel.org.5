Return-Path: <linux-kernel+bounces-143059-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C0A958A33A8
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 18:22:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FA8B1F21FB3
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Apr 2024 16:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03E1C149DE4;
	Fri, 12 Apr 2024 16:20:47 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AECC147C7D
	for <linux-kernel@vger.kernel.org>; Fri, 12 Apr 2024 16:20:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712938846; cv=none; b=XFcUCSTtjpxk62mke+bQXNNdcX9lRCBlNdTGuRv0by0b4/MEr04+aM3GGuMC0xvH8KQiJFi51uXsfTpAKmIMgPY50O0MsdJ3xvaCKiNeCBC9Llo1dBAzNaEV4khr54Y4nXeIj7KWq0ablqo6FJaIAk5oy9kwnt2mClyRT84Ja2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712938846; c=relaxed/simple;
	bh=yC3XTUFwDh0xSStE/nTpmKIcliT8G1Hdq6DqZfDKtq0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ovZyEqdGCO5B/xqYBjR8OeHAG93I1ExmvT0uogaUFw3aQDn10fv6PbsBWUUazAPrNgmyB5ulW2O8uADTamedxHQ3CRk/x+sx+CFXqBzs5WbmEwrmSUIHuEwCWXXG3X/Z77sukLUemys0owm7cNbJpQwKBk1+hl2lLKvNJ04zkJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7CDD3339;
	Fri, 12 Apr 2024 09:21:13 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 866883F64C;
	Fri, 12 Apr 2024 09:20:41 -0700 (PDT)
Date: Fri, 12 Apr 2024 17:20:39 +0100
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
Subject: Re: [PATCH v1 30/31] x86/resctrl: Move the filesystem bits to
 headers visible to fs/resctrl
Message-ID: <ZhlfV446640jF/rd@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-31-james.morse@arm.com>
 <8f4a05d5-2040-4cf2-8c05-a190c25d64db@intel.com>
 <ZhfznA2Sp3KFdjrA@e133380.arm.com>
 <0baf690b-4ed4-4dad-9f50-e5df93d599fd@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0baf690b-4ed4-4dad-9f50-e5df93d599fd@intel.com>

On Thu, Apr 11, 2024 at 10:43:55AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 4/11/2024 7:28 AM, Dave Martin wrote:
> > On Mon, Apr 08, 2024 at 08:42:00PM -0700, Reinette Chatre wrote:
> >> Hi James,
> >>
> >> On 3/21/2024 9:51 AM, James Morse wrote:
> >> ..
> >>> diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
> >>> index 4788bd95dac6..fe0b10b589c0 100644
> >>> --- a/include/linux/resctrl_types.h
> >>> +++ b/include/linux/resctrl_types.h
> >>> @@ -7,6 +7,36 @@
> >>>  #ifndef __LINUX_RESCTRL_TYPES_H
> >>>  #define __LINUX_RESCTRL_TYPES_H
> >>>  
> >>> +#define CQM_LIMBOCHECK_INTERVAL	1000
> >>> +
> >>> +#define MBM_CNTR_WIDTH_BASE		24
> >>> +#define MBM_OVERFLOW_INTERVAL		1000
> >>> +#define MAX_MBA_BW			100u
> >>> +#define MBA_IS_LINEAR			0x4
> >>> +
> >>> +/* rdtgroup.flags */
> >>> +#define	RDT_DELETED		1
> >>> +
> >>> +/* rftype.flags */
> >>> +#define RFTYPE_FLAGS_CPUS_LIST	1
> >>> +
> >>> +/*
> >>> + * Define the file type flags for base and info directories.
> >>> + */
> >>> +#define RFTYPE_INFO			BIT(0)
> >>> +#define RFTYPE_BASE			BIT(1)
> >>> +#define RFTYPE_CTRL			BIT(4)
> >>> +#define RFTYPE_MON			BIT(5)
> >>> +#define RFTYPE_TOP			BIT(6)
> >>> +#define RFTYPE_RES_CACHE		BIT(8)
> >>> +#define RFTYPE_RES_MB			BIT(9)
> >>> +#define RFTYPE_DEBUG			BIT(10)
> >>> +#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
> >>> +#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
> >>> +#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
> >>> +#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
> >>> +#define RFTYPE_MON_BASE			(RFTYPE_BASE | RFTYPE_MON)
> >>> +
> >>>  /* Reads to Local DRAM Memory */
> >>>  #define READS_TO_LOCAL_MEM		BIT(0)
> >>>  
> >>
> >> Not all these new seem to belong in this file. Could you please confirm?
> >>
> >> For example:
> >> Earlier in series it was mentioned that struct rdtgroup is private to the
> >> fs so having RDT_DELETED is unexpected as it implies access to struct rdtgroup.
> >>
> >> CQM_LIMBOCHECK_INTERVAL seems private to the fs code, so too
> >> RFTYPE_FLAGS_CPUS_LIST.
> >>
> >> Reinette
> >>
> > 
> > I'll flag this for James to review.
> > 
> > These have to be moved out of the x86 private headers, but you're right
> > that some of them seem logically private to the resctrl core.
> > 
> > I guess some of these could move to fs/resctrl/internal.h?
> 
> It looks to me that way.
> 
> > 
> > OTOH, might it be preferable to keep all the flag definitions for a
> > given member together for ease of maintenance, even if some are for
> > resctrl internal use only?
> 
> Indeed, those RFTYPE flags really seem to be fs code but I agree that
> architectures' use of RFTYPE_RES_CACHE and RFTYPE_RES_MB does make this
> complicated and having these in a central place is reasonable to me.
> 
> Reinette

Maybe we could split these into two groups, and clearly comment the ones
that have no user outside resctrl as internal use only?

That's not as clean as removing those definitions from a shared header,
but at least would help document the issue until/unless a better
solution is found...

Cheers
---Dave

