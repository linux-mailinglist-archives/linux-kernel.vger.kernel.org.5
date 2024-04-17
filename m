Return-Path: <linux-kernel+bounces-148698-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D1FE58A8659
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 16:44:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 579AFB25DC3
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Apr 2024 14:44:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809C4145B20;
	Wed, 17 Apr 2024 14:41:33 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 941E6145356
	for <linux-kernel@vger.kernel.org>; Wed, 17 Apr 2024 14:41:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713364893; cv=none; b=qFVV+RNkdgkFkndk2gVxOdzr0+fZBP/OFaNqzaWQkYlrUyL+CYVQmi06TAuwP2vkKL1DKaUfF5fRoSZfoqhsFFEFOxDYVbdhkhjUxIuzZQDCqUFRcT+p2xgIP3kT/0PFFDWy44ZY/i4lXUU9fmIfZqccMneI3QssUNDbbbmVL3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713364893; c=relaxed/simple;
	bh=QmHmQjhS4ZracszR7nZ2gUEAQ/yZV8486QKbSkbjcs0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LfowdyW8bBCxsVPOhHZce5BFkMMFSeWfCZg8B1Jj01xGJrNhkTlejolz4NyKBxQRZOnF52W//qODFhVpn6boRKpwlhsNU0Ic1CQD6rbEZMkKWtSvKPeWrzao2IeN2JtfPh9DMs9LO0H31DvUF4mLnUN8VyMzjoKOK9oh/4d/VWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BA3AD339;
	Wed, 17 Apr 2024 07:41:58 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 947DF3F738;
	Wed, 17 Apr 2024 07:41:27 -0700 (PDT)
Date: Wed, 17 Apr 2024 15:41:24 +0100
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
Subject: Re: [PATCH v1 12/31] x86/resctrl: Move max_{name,data}_width into
 resctrl code
Message-ID: <Zh/flJb3obutHTbD@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-13-james.morse@arm.com>
 <fc4ee516-54b7-47cb-b881-00ce10d311a9@intel.com>
 <ZhfwjBJPeTvO04BL@e133380.arm.com>
 <d269b5d2-bd6d-44b2-8d99-0e0a2790bf50@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d269b5d2-bd6d-44b2-8d99-0e0a2790bf50@intel.com>

Hi Reinette,

On Thu, Apr 11, 2024 at 10:38:20AM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 4/11/2024 7:15 AM, Dave Martin wrote:
> > On Mon, Apr 08, 2024 at 08:19:15PM -0700, Reinette Chatre wrote:
> >> Hi James,
> >>
> >> On 3/21/2024 9:50 AM, James Morse wrote:
> >>> @@ -2595,6 +2601,12 @@ static int schemata_list_add(struct rdt_resource *r, enum resctrl_conf_type type
> >>>  	if (cl > max_name_width)
> >>>  		max_name_width = cl;
> >>>  
> >>> +	/*
> >>> +	 * Choose a width for the resource data based on the resource that has
> >>> +	 * widest name and cbm.
> >>
> >> Please check series to ensure upper case is used for acronyms.
> > 
> > [...]
> > 
> >> Reinette
> > 
> > This patch is just moving existing code around AFAICT.  See:
> > commit de016df88f23 ("x86/intel_rdt: Update schemata read to show data in tabular format")
> > 
> > Since no new usage of any term is being introduced here, can it be
> > left as-is?
> > 
> > There seem to be other uses of "cbm" with this sense in the resctrl
> > code already.
> 
> I am not asking to change all existing usages of these terms but in
> any new changes, please use upper case for acronyms.

While there is a general argument to be made here, it sounds from this
like you are not requesting a change to this patch; can you confirm?

Cheers
---Dave

