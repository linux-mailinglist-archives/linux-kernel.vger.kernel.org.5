Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B91A87B375F
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:57:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233731AbjI2P5Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:57:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233646AbjI2P5X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:57:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7FB3195;
        Fri, 29 Sep 2023 08:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696003040; x=1727539040;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=QuNwZ8GGaC1YVteAi2IZNrp5mEpQR8V4HvTYvdoFsDI=;
  b=cq9f8kHNxsheRK5rI/AWRoYYv2SU/AlPY7SptZiZhY5N4223AFkFOq3S
   0U/DrviyrMYb5aBZy6nZnxETYAW2GMBvqd9bg2Reb/5CFGogSZaArqAFI
   S754bq0VuTeG23JhWV3k6Cz7yXscaHtlZsZ2cB9kGWxyCeozOu/owWGnp
   aAXeDBQEhLKuSxbaw1BpsDG8DSppzjKZE4i1S41ypEaBdeyEu7JZFoRi3
   4+1zRTq1uuX/X1ZN+98VnGrs6bhVX5c4+i6zzdhS/RdVG4D9JSM33+mvv
   9roY+LgOPhhNUKIkZMuhH2cawHCRCj52GqIgRTuttWzuN2U3YS1N/KBhW
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="385149712"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="385149712"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:56:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="923633407"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="923633407"
Received: from smorozov-mobl1.ger.corp.intel.com ([10.252.52.167])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:56:40 -0700
Date:   Fri, 29 Sep 2023 18:56:37 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Babu Moger <babu.moger@amd.com>
cc:     corbet@lwn.net, Reinette Chatre <reinette.chatre@intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        fenghua.yu@intel.com, dave.hansen@linux.intel.com, x86@kernel.org,
        hpa@zytor.com, paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
Subject: Re: [PATCH v10 10/10] x86/resctrl: Display RMID of resource group
In-Reply-To: <20230915224227.1336967-11-babu.moger@amd.com>
Message-ID: <0f97fcf-ee2e-f63f-1d98-8e11d30384c@linux.intel.com>
References: <20230915224227.1336967-1-babu.moger@amd.com> <20230915224227.1336967-11-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-894282230-1696003007=:1989"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-894282230-1696003007=:1989
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 15 Sep 2023, Babu Moger wrote:

> In x86, hardware uses RMID to identify a monitoring group. When a user
> creates a monitor group these details are not visible. These details
> can help resctrl debugging.
> 
> Add RMID(mon_hw_id) to the monitor groups display in resctrl interface.
> Users can see these details when resctrl is mounted with "-o debug" option.
> 
> Other architectures do not use "RMID". Use the name mon_hw_id to refer
> to "RMID" in an effort to keep the naming generic.
> 
> For example:
>  $cat /sys/fs/resctrl/mon_groups/mon_grp1/mon_hw_id
>  3
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/arch/x86/resctrl.rst     |  4 ++++
>  arch/x86/kernel/cpu/resctrl/internal.h |  5 +++++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 54691c8b832d..98b0eb509ed4 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -369,6 +369,10 @@ When monitoring is enabled all MON groups will also contain:
>  	the sum for all tasks in the CTRL_MON group and all tasks in
>  	MON groups. Please see example section for more details on usage.
>  
> +"mon_hw_id":
> +	Available only with debug option. The identifier used by hardware
> +	for the monitor group. On x86 this is the RMID.
> +
>  Resource allocation rules
>  -------------------------
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index a07fa4329b65..b4910892b0a6 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -296,6 +296,11 @@ struct rdtgroup {
>   *	--> RFTYPE_BASE (Files common for both MON and CTRL groups)
>   *	    Files: cpus, cpus_list, tasks
>   *
> + *		--> RFTYPE_MON (Files only for MON group)
> + *
> + *			--> RFTYPE_DEBUG (Files to help resctrl debugging)
> + *			    File: mon_hw_id
> + *
>   *		--> RFTYPE_CTRL (Files only for CTRL group)
>   *		    Files: mode, schemata, size
>   *
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 55d1b90f460e..ef4b18091e5d 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -795,6 +795,22 @@ static int rdtgroup_closid_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +static int rdtgroup_rmid_show(struct kernfs_open_file *of,
> +			      struct seq_file *s, void *v)
> +{
> +	struct rdtgroup *rdtgrp;
> +	int ret = 0;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (rdtgrp)
> +		seq_printf(s, "%u\n", rdtgrp->mon.rmid);
> +	else
> +		ret = -ENOENT;
> +	rdtgroup_kn_unlock(of->kn);
> +
> +	return ret;
> +}
> +
>  #ifdef CONFIG_PROC_CPU_RESCTRL
>  
>  /*
> @@ -1856,6 +1872,13 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= rdtgroup_tasks_show,
>  		.fflags		= RFTYPE_BASE,
>  	},
> +	{
> +		.name		= "mon_hw_id",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_rmid_show,
> +		.fflags		= RFTYPE_MON_BASE | RFTYPE_DEBUG,
> +	},
>  	{
>  		.name		= "schemata",
>  		.mode		= 0644,
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-894282230-1696003007=:1989--
