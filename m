Return-Path: <linux-kernel+bounces-150393-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B6B8A9E74
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 17:31:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E2FE1F21E8B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 15:31:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AB5D16D311;
	Thu, 18 Apr 2024 15:31:23 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7DC216C68D
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 15:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713454282; cv=none; b=q4DoQy2A4ak/4mXh1f1/hxeNZxxdvjFouGp2z+UU+6CJKttFc5IZlthBgGROD41YYl+5JDIXGbZeLycg2YjNPJ5M0rVOcpdYH90CNoCgLbTIH75ZjTwG3wWl/0Edpk8LjGIiTIQfIAVsPnUQAN5ytd05HlYGwABRQBnYNqjxsuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713454282; c=relaxed/simple;
	bh=aOh9Z/6F9nxNnnV4/HckasZrKgdTqj6rioO5IhOcDLM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=lJq2gruXMc7Zr0MGqrVzGMurr4QI5GwcYFA1PDirW8FmH8L8heqmN2gh4XPI/AwTcu8bE8nNCPCirTKUxKcg3jmPEWx8+A4wpsRptlNtyfKYoDmGXouIVQc77ua+YKUU+YCQhqYMheQw09JGMdk9m7DjTupgFJ+4bP5dtBCJSG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1EE5E2F;
	Thu, 18 Apr 2024 08:31:48 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1F553F738;
	Thu, 18 Apr 2024 08:31:16 -0700 (PDT)
Date: Thu, 18 Apr 2024 16:31:14 +0100
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
Subject: Re: [PATCH v1 18/31] x86/resctrl: Allow
 resctrl_arch_mon_event_config_write() to return an error
Message-ID: <ZiE8wjwwQic++d2a@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-19-james.morse@arm.com>
 <d598767d-1c44-4417-9dc6-7078c97df39f@intel.com>
 <Zhfw3d3YCKu7PD3G@e133380.arm.com>
 <fbb116ab-d3db-4ab0-a597-980f85866db9@intel.com>
 <Zh/fxTLDAyUHTcn0@e133380.arm.com>
 <ff24ac06-a983-4bb8-939f-50f892a274f4@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ff24ac06-a983-4bb8-939f-50f892a274f4@intel.com>

On Wed, Apr 17, 2024 at 10:19:31PM -0700, Reinette Chatre wrote:
> Hi Dave,
> 
> On 4/17/2024 7:42 AM, Dave Martin wrote:
> > Hi Rainette,
> > 
> > On Thu, Apr 11, 2024 at 10:39:37AM -0700, Reinette Chatre wrote:
> >> Hi Dave,
> >>
> >> On 4/11/2024 7:17 AM, Dave Martin wrote:
> >>> On Mon, Apr 08, 2024 at 08:23:36PM -0700, Reinette Chatre wrote:
> >>>> Hi James,
> >>>>
> >>>> On 3/21/2024 9:50 AM, James Morse wrote:
> >>>>> resctrl_arch_mon_event_config_write() writes a bitmap of events provided
> >>>>> by user-space into the configuration register for the monitors.
> >>>>>
> >>>>> This assumes that all architectures support all the features each bit
> >>>>> corresponds to.
> >>>>>
> >>>>> MPAM can filter monitors based on read, write, or both, but there are
> >>>>> many more options in the existing bitmap. To allow this interface to
> >>>>> work for machines with MPAM, allow the architecture helper to return
> >>>>> an error if an incompatible bitmap is set.
> >>>>>
> >>>>> When valid values are provided, there is no change in behaviour. If
> >>>>> an invalid value is provided, currently it is silently ignored, but
> >>>>> last_cmd_status is updated. After this change, the parser will stop
> >>>>> at the first invalid value and return an error to user-space. This
> >>>>> matches the way changes to the schemata file are made.
> >>>>>
> >>>>
> >>>> Is this needed? With move of mbm_cfg_mask to rdt_resource I expect
> >>>> MPAM would use it to set what the valid values are. With that done,
> >>>> when user space provides a value, mon_config_write() compares user
> >>>> provided value against mbm_cfg_mask and will already return early
> >>>> (before attempting to write to hardware) with error
> >>>> if value is not supported. This seems to accomplish the goal of this
> >>>> patch?
> >>>
> >>> This sounds plausible.
> >>>
> >>> In a recent snapshot of James' MPAM code, it looks like we could be
> >>> initialising rdt_resource::mbm_cfg_mask when setting up the rdt_resource
> >>> struct for resctrl, though in fact this information is captured
> >>> differently right now.  I'm sure why (though James may have a
> >>> reason). [1]
> >>>
> >>> I don't see an obvious reason though why we couldn't set mbm_cfg_mask
> >>> and detect bad config values globally in mon_config_write(), the same as
> >>> for the existing AMD BMEC case.
> >>>
> >>> Nothing in the MPAM architecture stops hardware vendors from randomly
> >>> implementing different capabilities in different components of the
> >>> system, but provided that we only expose the globally supported subset
> >>> of event filtering capabilities to resctrl this approach looks workable.
> >>> This consistent with the James' MPAM code deals with other feature
> >>> mismatches across the system today.
> >>>
> >>> [1] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/platform/mpam/mpam_resctrl.c?h=mpam/snapshot/v6.7-rc2#n730
> >>
> >> My response was based on what I understood from the goal of this change
> >> as described by the changelog. The patch does not appear to match with
> >> the goals stated in changelog.
> >>
> >> As I understand the patch it aims to detect when there is an invalid
> >> event id. It is not possible for this scenario to occur because this code
> >> is always called with a valid event id.
> >>
> >> Reinette
> > 
> > I guess this will need discussion with James.  FWIW, my impression was
> > that the real goal of this patch was to allow a bad event config to be
> > detected at cross-call time and reported asynchronously.  Changes
> > elsewhere look to be there just to make error reporting consistent for
> > other existing paths too.
> 
> How do you interpret "bad event config"?
> 
> As I understand it, this patch only sets an error in one scenario:
> 
> 	 	index = mon_event_config_index_get(mon_info->evtid);
> 	 	if (index == INVALID_CONFIG_INDEX) {
>  			pr_warn_once("Invalid event id %d\n", mon_info->evtid);
> 			mon_info->err = -EINVAL;
> 	 		return;
>  		}
> 
> When will mon_info->evtid be anything but QOS_L3_MBM_TOTAL_EVENT_ID or
> QOS_L3_MBM_LOCAL_EVENT_ID? 
> 
> Reinette

I don't know; my reading of this was that since there was a pr_warn()
already, and since James was adding the capability to return an error,
he figured that a suitable error ought to be returned in this case.

But the real reason for the error return mechanism seems to be
resctrl_arch_mon_event_config_write() in the MPAM code, here:

https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/commit/?h=mpam/snapshot/v6.7-rc2&id=db0ac51f60675b6c4a54ccd24fa7198ec321c56d

I agree though that if we set mbm_cfg_mask in the rdt_resource at probe
time, the code in mon_config_write() ought to catch such cases cleanly
before making the cross-call.  So maybe the new mechanism isn't needed.

I think I need to discuss this with James, to figure out if there's any
reason why that wouldn't work.

Cheers
---Dave

