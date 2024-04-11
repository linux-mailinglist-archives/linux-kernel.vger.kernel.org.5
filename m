Return-Path: <linux-kernel+bounces-140638-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 26E7F8A1716
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 16:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 576AD1C22629
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Apr 2024 14:25:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD9314E2FC;
	Thu, 11 Apr 2024 14:25:42 +0000 (UTC)
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A2F114D443
	for <linux-kernel@vger.kernel.org>; Thu, 11 Apr 2024 14:25:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712845541; cv=none; b=A9veS2PKWIxyRRwoH8mlrUvi3FClRxRNcgqgOt4ZIAqRjHSh5xaO0y9pkOQKc+DzyWw8xCweW5YfSIP3ShZNvuroFLlSrM8TNfOT3YU151dfJeA0M7IfaNtNQvBU37YOfCUai8M332y57PVYagf6kY2+g0dRW1NC71o1wWfDut8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712845541; c=relaxed/simple;
	bh=kzC5I+jlXQuHmHtY/Zni2LwuxXuCXvts4jC4WgFE5kQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cXS1nerAmZghyaR+FuWGfKPTSowNDCiN6DTwrnSsRaV4lDvmvoatZ14tp/jsmn5k/gYc5A0eV+KUjX73Calmc0e3Isn5Ol1R1MqNuEHIJATNTjfBSoQukzlTPtVbeA0raad/XQ2y6Dgt+i6HdtbpMXFnxDGSiKmnYz61qI0tyCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB5F4339;
	Thu, 11 Apr 2024 07:26:08 -0700 (PDT)
Received: from e133380.arm.com (e133380.arm.com [10.1.197.52])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8E40E3F64C;
	Thu, 11 Apr 2024 07:25:36 -0700 (PDT)
Date: Thu, 11 Apr 2024 15:25:34 +0100
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
Subject: Re: [PATCH v1 24/31] x86/resctrl: Move get_config_index() to a header
Message-ID: <Zhfy3goUX8kWM5Hn@e133380.arm.com>
References: <20240321165106.31602-1-james.morse@arm.com>
 <20240321165106.31602-25-james.morse@arm.com>
 <bfc39b79-b3bf-4187-ba63-56db1ed6d565@intel.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bfc39b79-b3bf-4187-ba63-56db1ed6d565@intel.com>

On Mon, Apr 08, 2024 at 08:25:26PM -0700, Reinette Chatre wrote:
> Hi James,
> 
> On 3/21/2024 9:50 AM, James Morse wrote:
> > get_config_index() is used by the architecture specific code to map a
> > CLOSID+type pair to an index in the configuration arrays.
> > 
> > MPAM needs to do this too to preserve the ABI to user-space, there is
> > no reason to do it differently.
> > 
> > Move the helper to a header file.
> > 
> > Signed-off-by: James Morse <james.morse@arm.com>
> > ---
> >  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 19 +++----------------
> >  include/linux/resctrl.h                   | 15 +++++++++++++++
> >  2 files changed, 18 insertions(+), 16 deletions(-)

[...]

> > diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> > index 3de5bc63ace0..73c111963433 100644
> > --- a/include/linux/resctrl.h
> > +++ b/include/linux/resctrl.h
> > @@ -258,6 +258,21 @@ bool resctrl_arch_is_evt_configurable(enum resctrl_event_id evt);
> >  void resctrl_arch_mon_event_config_write(void *info);
> >  void resctrl_arch_mon_event_config_read(void *info);
> >  
> > +/* For use by arch code to remap resctrl's smaller CDP CLOSID range */
> > +static inline u32 resctrl_get_config_index(u32 closid,
> > +					   enum resctrl_conf_type type)
> > +{
> > +	switch (type) {
> > +	default:
> > +	case CDP_NONE:
> > +		return closid;
> > +	case CDP_CODE:
> > +			return (closid * 2) + 1;
> > +	case CDP_DATA:
> > +			return (closid * 2);
> > +	}
> > +}
> 
> (please check the tabs)

Noted.  I also see that redundant parentheses seem spuriously added
compared with the original version of this moved code.  I can make a
note to drop them if you prefer.

> This change is unexpected to me. Could you please elaborate how
> MPAM's variant of CDP works?
> 
> Thank you very much.
> 
> Reinette

Note: I haven't discussed this specifically with James, so the following
is my best guess at the rationale...  With that in mind:

For MPAM, CDP isn't a special mode; instead, the PARTIDs for
instructions and data are always configured independently in the CPU.
If resctrl is not configured for CDP, we simply program the same PARTID
value both for instructions and data on task switch.

For a given resctrl control group we could pick two random unrelated
PARTIDs, but there seems to be no advantage in doing that since resctrl
enables cdp globally or not, and we would require more effort to
translate resctrl closids to PARTIDs if we didn't pair the IDs up
systematically.

(See [1], [2] in James' snapshot, which illustrate how he proposes
to do it.)


So, we may as well stick with the same scheme already established for
x86: nothing forces us to do that, but it looks simpler than the
alternatives.  I think that's the idea, anyway.

Then, if the same scheme is used by multiple arches (and 100% of the
arches currently known to resctrl), it probably makes sense to share the
definition of the mapping at least as a default for arches that don't
have their own different ways of doing it.

Does this make sense?

I can recommend adding some of this rationale to the commit message
if it helps (and assuming I'm right!)

Cheers
---Dave


[1] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/drivers/platform/mpam/mpam_resctrl.c?h=mpam/snapshot/v6.7-rc2#n206
[2] https://git.kernel.org/pub/scm/linux/kernel/git/morse/linux.git/tree/arch/arm64/include/asm/mpam.h?h=mpam/snapshot/v6.7-rc2#n146


