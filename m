Return-Path: <linux-kernel+bounces-140624-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 931608A16F5
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:18:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A9681C208D1
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:18:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C2ED14EC53;
	Thu, 11 Apr 2024 14:16:54 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69CF314D43D
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:16:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845013; cv=none; b=Zsr7X38/PLpKneOriX1URy/ccljl53UVkvaMy3X/6FAdOh7B5+kDfMMIzpqCyIDpOYBRMm+mMnio81V3qSpp2asNIkCc+iackugCTPHQ+J2Dv++W2sM2Ya4yqOzbwhgm30HlUBAD/YqJew/+5e9lOUbQwl+meTYqXVgMEWAcVYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845013; c=relaxed/simple;
	bh=pBWfsdVJzUKgs9OPZDeQg7dTF/g77QldF2IQKrKETUM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Az6QM8G3AhKdA7JxICdJC31HaGqxYT5uFQsyUoXbzlAvTxr2pDnvn26GD9e1typDNJFpy/++oBiAQh5dtCSurntmb7Z2QsY2rQFSm4mN0SrrAHWMsGcUzYdFzMyFsGQsLTRJ2IOoujKYwWuWpBJ53hjas4ZR6/WCEHkKR/eWi3E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 416BE339;
	Thu, 11 Apr 2024 07:17:21 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E8BC53F64C;
	Thu, 11 Apr 2024 07:16:48 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:16:46 +0100
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
Subject: Re: [PATCH v1 17/31] x86/resctrl: Move mbm_cfg_mask to struct
 rdt_resource
Message-ID: <Zhfwzh4sHvTYyTJ1@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-18-james.morse@arm.com>
 <966b7b32-6600-4b1f-9535-0298fedd57a7@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <966b7b32-6600-4b1f-9535-0298fedd57a7@intel.com>

On Mon, Apr 08, 2024 at 08:21:24PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
> > The mbm_cfg_mask field lists the bits that user-space can set when
> > configuring an event. This value is output via the last_cmd_status
> > file.
> > 
> > Once the filesystem parts of resctrl are moved to live in /fs/, the
> > struct rdt_hw_resource is inaccessible to the filesystem code. Because
> > this value is output to user-space, it has to be accessible to the
> > filesystem code.
> > 
> > Move it to struct rdt_resource.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> 
> ..
> 
> > diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> > index 975b80102fbe..8a7367d1ce45 100644
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -140,6 +140,8 @@ struct resctrl_membw {
> >   * @format_str:		Per resource format string to show domain value
> >   * @evt_list:		List of monitoring events
> >   * @fflags:		flags to choose base and info files
> > + * @mbm_cfg_mask:	Bandwidth sources that can be tracked when Bandwidth
> > + *			Monitoring Event Configuration (BMEC) is supported.

[...]

> Reinette
> 
> BMEC is an AMD term. If MPAM is planning to use this member then this comment
> should be made generic.

MPAM can (at least) filter reads and/or writes, and it looks like James
is expecting to support this.

However, it probably does make sense to keep the comments neutral in a
common header.

Would the following work?

	* @ mbm_cfg_mask:	Arch-specific event configuration flags



I think that's broad enough to cover all bases, but I'll wait for your
response.

Cheers
---Dave

