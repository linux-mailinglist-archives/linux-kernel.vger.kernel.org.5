Return-Path: <linux-kernel+bounces-140647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B568A1727
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:28:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B991281E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 527F314E2FC;
	Thu, 11 Apr 2024 14:28:52 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AACEE1E516
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845731; cv=none; b=db4XijAsRAYPmRDwRNsK+0rIAzStiqlgrd004UYAUYDGMKSM0LotBH4lv0X9sys/9U4lheMWqYQK0f8lBNbGYLsiNd3SZuEuyESjq/4P/4XXkIvgW0rbWuN9bdNKO2SJmE9gTDfamftYx38P6WabC7q1KAQrLRKEW70CXheJPig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845731; c=relaxed/simple;
	bh=zIPKsy14lY3vPwb7exGbuCetT9iThntwPT7HQt2IwgI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jOI6xFu/8Sz2Hy99FabgfGBGVNCVogcyCotCM2MsA6D6YF2odD0iuq/9sgCdejLqpcBQHOCaDWwLbfSB6HQuyyQKwaqU52gRtbQd2tZbWzx5Q+Hnt+fEAvz+h1WuER2PmAS9whBmEHsR7uxO24d2ymNvdOPONrYeGPhe8MHS8fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8BFAF339;
	Thu, 11 Apr 2024 07:29:19 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F38B3F64C;
	Thu, 11 Apr 2024 07:28:47 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:28:44 +0100
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
Message-ID: <ZhfznA2Sp3KFdjrA@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-31-james.morse@arm.com>
 <8f4a05d5-2040-4cf2-8c05-a190c25d64db@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8f4a05d5-2040-4cf2-8c05-a190c25d64db@intel.com>

On Mon, Apr 08, 2024 at 08:42:00PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:51 AM, James Morse wrote:
> ..
> > diff --git a/include/linux/resctrl_types.h b/include/linux/resctrl_types.h
> > index 4788bd95dac6..fe0b10b589c0 100644
> > --- a/include/linux/resctrl_types.h
> > +++ b/include/linux/resctrl_types.h
> > @@ -7,6 +7,36 @@
> >  #ifndef __LINUX_RESCTRL_TYPES_H
> >  #define __LINUX_RESCTRL_TYPES_H
> >  
> > +#define CQM_LIMBOCHECK_INTERVAL	1000
> > +
> > +#define MBM_CNTR_WIDTH_BASE		24
> > +#define MBM_OVERFLOW_INTERVAL		1000
> > +#define MAX_MBA_BW			100u
> > +#define MBA_IS_LINEAR			0x4
> > +
> > +/* rdtgroup.flags */
> > +#define	RDT_DELETED		1
> > +
> > +/* rftype.flags */
> > +#define RFTYPE_FLAGS_CPUS_LIST	1
> > +
> > +/*
> > + * Define the file type flags for base and info directories.
> > + */
> > +#define RFTYPE_INFO			BIT(0)
> > +#define RFTYPE_BASE			BIT(1)
> > +#define RFTYPE_CTRL			BIT(4)
> > +#define RFTYPE_MON			BIT(5)
> > +#define RFTYPE_TOP			BIT(6)
> > +#define RFTYPE_RES_CACHE		BIT(8)
> > +#define RFTYPE_RES_MB			BIT(9)
> > +#define RFTYPE_DEBUG			BIT(10)
> > +#define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
> > +#define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
> > +#define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
> > +#define RFTYPE_CTRL_BASE		(RFTYPE_BASE | RFTYPE_CTRL)
> > +#define RFTYPE_MON_BASE			(RFTYPE_BASE | RFTYPE_MON)
> > +
> >  /* Reads to Local DRAM Memory */
> >  #define READS_TO_LOCAL_MEM		BIT(0)
> >  
> 
> Not all these new seem to belong in this file. Could you please confirm?
> 
> For example:
> Earlier in series it was mentioned that struct rdtgroup is private to the
> fs so having RDT_DELETED is unexpected as it implies access to struct rdtgroup.
> 
> CQM_LIMBOCHECK_INTERVAL seems private to the fs code, so too
> RFTYPE_FLAGS_CPUS_LIST.
> 
> Reinette
> 

I'll flag this for James to review.

These have to be moved out of the x86 private headers, but you're right
that some of them seem logically private to the resctrl core.

I guess some of these could move to fs/resctrl/internal.h?

OTOH, might it be preferable to keep all the flag definitions for a
given member together for ease of maintenance, even if some are for
resctrl internal use only?

Cheers
---Dave

