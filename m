Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9BA7B244D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Sep 2023 19:48:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjI1RsW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Sep 2023 13:48:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjI1RsV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Sep 2023 13:48:21 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3363219D;
        Thu, 28 Sep 2023 10:48:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695923299; x=1727459299;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CanKWAodHiTu5WTKJSJfie0L+vqae9jyj3QHk3pesLA=;
  b=T5kDwa2t87Ri/f20Q8Fyzaj2qjZ/Fozrd2oke7WUKtt9IKgJeAMWQEop
   TJEuP0SFR6uH4EehhgwCSPRkUswc46dAFIHbPBwrT+n/C473WTZJpmj0R
   +u+cG/2xBHVIME7RxFxM5HJ3IUZUKKPHqHKXfo/T1b6oaR6M9NRJN8cQ5
   U8p2t5b5n/Pn04ewuQuouTEHp3nBPZmX67kQQuG+f4hGDAgSIiWkR0ZQ6
   Mde0IiSIh6kPUiM5aONgUW46wJ5OjkIKXg8BYXUOcPYr+6f07Py3aoz99
   57uB3YEALyXavWspA/F9ArgTIl7FMpao77y3b8Y3plyv1bPuVDqrEEcJV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="448621491"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="448621491"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:48:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="778995159"
X-IronPort-AV: E=Sophos;i="6.03,184,1694761200"; 
   d="scan'208";a="778995159"
Received: from agluck-desk3.sc.intel.com (HELO agluck-desk3) ([172.25.222.74])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2023 10:48:17 -0700
Date:   Thu, 28 Sep 2023 10:48:16 -0700
From:   Tony Luck <tony.luck@intel.com>
To:     Reinette Chatre <reinette.chatre@intel.com>
Cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Peter Newman <peternewman@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
        Shaopeng Tan <tan.shaopeng@fujitsu.com>,
        James Morse <james.morse@arm.com>,
        Jamie Iles <quic_jiles@quicinc.com>,
        Babu Moger <babu.moger@amd.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v5 5/8] x86/resctrl: Introduce snc_nodes_per_l3_cache
Message-ID: <ZRW8YF5l0tdtLKmm@agluck-desk3>
References: <20230722190740.326190-1-tony.luck@intel.com>
 <20230829234426.64421-1-tony.luck@intel.com>
 <20230829234426.64421-6-tony.luck@intel.com>
 <80393c0e-29fd-dd02-75b4-f0640e162c8d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <80393c0e-29fd-dd02-75b4-f0640e162c8d@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 25, 2023 at 04:27:45PM -0700, Reinette Chatre wrote:
> Hi Tony,
> 
> On 8/29/2023 4:44 PM, Tony Luck wrote:
> 
> Could the commit message please provide a brief overview of what SNC is
> before jumping to the things needed to support it?

Ok. Added an overview.

> 
> > Intel Sub-NUMA Cluster mode requires several changes in resctrl
> 
> I think the intention is to introduce the acronym here so maybe:
> "Intel Sub-NUMA Cluster (SNC) ..."

Commit now starts with this definiton.

> 
> > behavior for correct operation.
> > 
> > Add a global integer "snc_nodes_per_l3_cache" that will show how many
> > SNC nodes share each L3 cache. When this is "1", SNC mode is either
> > not implemented, or not enabled.
> > 
> > A later patch will detect SNC mode and set snc_nodes_per_l3_cache to
> > the appropriate value. For now it remains at the default "1" to
> > indicate SNC mode is not active.
> > 
> > Code that needs to take action when SNC is enabled is:
> > 1) The number of logical RMIDs available for use is the number of
> >    physical RMIDs divided by the number of SNC nodes.
> 
> Could this maybe be "... number of SNC nodes per L3 cache" to be
> specific? Even so, this jumps into supporting logical RMIDs and 
> physical RMIDs without introducing what logical vs physical means.
> Is this something that can be added to the intro of this commit message?

Added that to be specific. Also added more preamble text to set
up context.

> 
> > 2) Likewise the "mon_scale" value must be adjusted for the number
> >    of SNC nodes.
> > 3) When reading an RMID counter code must adjust from the logical
> >    RMID used to the physical RMID value that must be loaded into
> >    the IA32_QM_EVTSEL MSR.
> > 4) The L3 cache is divided between the SNC nodes. So the value
> >    reported in the resctrl "size" file is adjusted.
> > 5) The "-o mba_MBps" mount option must be disabled in SNC mode
> >    because the monitoring is being done per SNC node, while the
> >    bandwidth allocation is still done at the L3 cache scope.
> 
> This motivation for disabling is not clear to me. Why is only
> mba_MBps impacted? MBA is also at the L3 scope and it is not
> disabled. Neither is cache allocation that remains at L3
> scope with its monitoring moving to node scope.

Added text for why (essentially the s/w feedback loop now has
independent MBM inputs from each SNC node, but still only one
MBA control at L3 cache scope. The feedback code can't do any
thing useful if one SNC node says "I'm running too fast" while
another node sharing same L3 says "I'm running too slow".

> 
> > 
> > Signed-off-by: Tony Luck <tony.luck@intel.com>
> > ---
> >  arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
> >  arch/x86/kernel/cpu/resctrl/core.c     |  7 +++++++
> >  arch/x86/kernel/cpu/resctrl/monitor.c  | 16 +++++++++++++---
> >  arch/x86/kernel/cpu/resctrl/rdtgroup.c |  4 ++--
> >  4 files changed, 24 insertions(+), 5 deletions(-)
> > 
> > diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> > index c61fd6709730..326ca6b3688a 100644
> > --- a/arch/x86/kernel/cpu/resctrl/internal.h
> > +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> > @@ -446,6 +446,8 @@ DECLARE_STATIC_KEY_FALSE(rdt_alloc_enable_key);
> >  
> >  extern struct dentry *debugfs_resctrl;
> >  
> > +extern int snc_nodes_per_l3_cache;
> > +
> >  enum resctrl_res_level {
> >  	RDT_RESOURCE_L3,
> >  	RDT_RESOURCE_L2,
> > diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> > index 9fcc264fac6c..ed4f55b3e5e4 100644
> > --- a/arch/x86/kernel/cpu/resctrl/core.c
> > +++ b/arch/x86/kernel/cpu/resctrl/core.c
> > @@ -48,6 +48,13 @@ int max_name_width, max_data_width;
> >   */
> >  bool rdt_alloc_capable;
> >  
> > +/*
> > + * Number of SNC nodes that share each L3 cache.
> > + * Default is 1 for systems that do not support
> > + * SNC, or have SNC disabled.
> > + */
> 
> There is some extra space available to make the lines longer.

Re-formatted to use longer lines.

> 
> > +int snc_nodes_per_l3_cache = 1;
> > +
> >  static void
> >  mba_wrmsr_intel(struct rdt_domain *d, struct msr_param *m,
> >  		struct rdt_resource *r);
> > diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
> > index 42262d59ef9b..b6b3fb0f9abe 100644
> > --- a/arch/x86/kernel/cpu/resctrl/monitor.c
> > +++ b/arch/x86/kernel/cpu/resctrl/monitor.c
> > @@ -148,8 +148,18 @@ static inline struct rmid_entry *__rmid_entry(u32 rmid)
> >  
> >  static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
> >  {
> > +	struct rdt_resource *r = &rdt_resources_all[RDT_RESOURCE_L3].r_resctrl;
> > +	int cpu = smp_processor_id();
> > +	int rmid_offset = 0;
> >  	u64 msr_val;
> >  
> > +	/*
> > +	 * When SNC mode is on, need to compute the offset to read the
> > +	 * physical RMID counter for the node to which this CPU belongs
> > +	 */
> 
> Please end sentence with a period.

Added period.

> 
> > +	if (snc_nodes_per_l3_cache > 1)
> > +		rmid_offset = (cpu_to_node(cpu) % snc_nodes_per_l3_cache) * r->num_rmid;
> > +
> >  	/*
> >  	 * As per the SDM, when IA32_QM_EVTSEL.EvtID (bits 7:0) is configured
> >  	 * with a valid event code for supported resource type and the bits
> > @@ -158,7 +168,7 @@ static int __rmid_read(u32 rmid, enum resctrl_event_id eventid, u64 *val)
> >  	 * IA32_QM_CTR.Error (bit 63) and IA32_QM_CTR.Unavailable (bit 62)
> >  	 * are error bits.
> >  	 */
> > -	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid);
> > +	wrmsr(MSR_IA32_QM_EVTSEL, eventid, rmid + rmid_offset);
> >  	rdmsrl(MSR_IA32_QM_CTR, msr_val);
> >  
> >  	if (msr_val & RMID_VAL_ERROR)
> > @@ -783,8 +793,8 @@ int __init rdt_get_mon_l3_config(struct rdt_resource *r)
> >  	int ret;
> >  
> >  	resctrl_rmid_realloc_limit = boot_cpu_data.x86_cache_size * 1024;
> > -	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale;
> > -	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
> > +	hw_res->mon_scale = boot_cpu_data.x86_cache_occ_scale / snc_nodes_per_l3_cache;
> > +	r->num_rmid = (boot_cpu_data.x86_cache_max_rmid + 1) / snc_nodes_per_l3_cache;
> >  	hw_res->mbm_width = MBM_CNTR_WIDTH_BASE;
> >  
> >  	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
> > diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > index 5feec2c33544..a8cf6251e506 100644
> > --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> > @@ -1367,7 +1367,7 @@ unsigned int rdtgroup_cbm_to_size(struct rdt_resource *r,
> >  		}
> >  	}
> >  
> > -	return size;
> > +	return size / snc_nodes_per_l3_cache;
> >  }
> >  
> >  /**
> > @@ -2600,7 +2600,7 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
> >  		ctx->enable_cdpl2 = true;
> >  		return 0;
> >  	case Opt_mba_mbps:
> > -		if (!supports_mba_mbps())
> > +		if (!supports_mba_mbps() || snc_nodes_per_l3_cache > 1)
> >  			return -EINVAL;
> >  		ctx->enable_mba_mbps = true;
> >  		return 0;
> 
> 
> Reinette
