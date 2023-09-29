Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 343097B3709
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:40:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233710AbjI2Pkt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:40:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233622AbjI2Pkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:40:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8D7CB4;
        Fri, 29 Sep 2023 08:40:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696002040; x=1727538040;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MyboEM7UH8s3FHhQHPjmv8x4en1uRLADS8XT/N5vA3E=;
  b=O0yvMlryMWRiBy4lKzsrUy1yfGw9h6GQqixmQeF9CWPoOfdoaBgQ4+I1
   KfmYddnIQ6TRuXPB6EQ7+Mnnqy2o+eAuQP90wtWDnb2/ah8HSd7PeT+f+
   twNaJHHDfinZGZV3urvfDApj2qUlIdf+Qp28/7377KZcyPq0Z5Ckvbub1
   SknB03AUpwZLDelXI9BEK8rki549ms1S0riOMgK25OQ5B8+0yED3ySKqe
   5o4M3AaBmzyXstSPLIoHnfKj6WaaQZgChJwo20UfCr64BK0UxN8NBLyef
   gNkeHlAPk7gnEvjWZlKrFSFNdB2RlxosGhOebED0GBKB5cPlw2MgBNYR5
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="361703264"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="361703264"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:40:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="815644202"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="815644202"
Received: from smorozov-mobl1.ger.corp.intel.com ([10.252.52.167])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:40:32 -0700
Date:   Fri, 29 Sep 2023 18:40:29 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Babu Moger <babu.moger@amd.com>
cc:     corbet@lwn.net, reinette.chatre@intel.com, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, fenghua.yu@intel.com,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        paulmck@kernel.org, akpm@linux-foundation.org,
        quic_neeraju@quicinc.com, rdunlap@infradead.org,
        damien.lemoal@opensource.wdc.com, songmuchun@bytedance.com,
        peterz@infradead.org, jpoimboe@kernel.org, pbonzini@redhat.com,
        chang.seok.bae@intel.com, pawan.kumar.gupta@linux.intel.com,
        jmattson@google.com, daniel.sneddon@linux.intel.com,
        sandipan.das@amd.com, tony.luck@intel.com, james.morse@arm.com,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        bagasdotme@gmail.com, eranian@google.com,
        christophe.leroy@csgroup.eu, jarkko@kernel.org,
        adrian.hunter@intel.com, quic_jiles@quicinc.com,
        peternewman@google.com
Subject: Re: [PATCH v10 08/10] x86/resctrl: Display CLOSID for resource
 group
In-Reply-To: <20230915224227.1336967-9-babu.moger@amd.com>
Message-ID: <77ffcd20-7bae-2017-a0d8-865d13434658@linux.intel.com>
References: <20230915224227.1336967-1-babu.moger@amd.com> <20230915224227.1336967-9-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1951734013-1696002039=:1989"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1951734013-1696002039=:1989
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 15 Sep 2023, Babu Moger wrote:

> In x86, hardware uses CLOSID to identify a control group. When a user
> creates a control group this information is not visible to the user.
> It can help resctrl debugging.
> 
> Add CLOSID(ctrl_hw_id) to the control groups display in resctrl
> interface. Users can see this detail when resctrl is mounted with
> "-o debug" option.
> 
> Other architectures do not use "CLOSID". Use the names ctrl_hw_id
> to refer to "CLOSID" in an effort to keep the naming generic.
> 
> For example:
>  $cat /sys/fs/resctrl/ctrl_grp1/ctrl_hw_id
>  1
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/arch/x86/resctrl.rst     |  4 ++++
>  arch/x86/kernel/cpu/resctrl/internal.h |  3 +++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 23 +++++++++++++++++++++++
>  3 files changed, 30 insertions(+)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 28d35aaa74b4..54691c8b832d 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -352,6 +352,10 @@ When control is enabled all CTRL_MON groups will also contain:
>  	file. On successful pseudo-locked region creation the mode will
>  	automatically change to "pseudo-locked".
>  
> +"ctrl_hw_id":
> +	Available only with debug option. The identifier used by hardware
> +	for the control group. On x86 this is the CLOSID.
> +
>  When monitoring is enabled all MON groups will also contain:
>  
>  "mon_data":
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 68d1b7147291..a07fa4329b65 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -299,6 +299,9 @@ struct rdtgroup {
>   *		--> RFTYPE_CTRL (Files only for CTRL group)
>   *		    Files: mode, schemata, size
>   *
> + *			--> RFTYPE_DEBUG (Files to help resctrl debugging)
> + *			    File: ctrl_hw_id
> + *
>   */
>  #define RFTYPE_INFO			BIT(0)
>  #define RFTYPE_BASE			BIT(1)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 150105c21fee..953b082cec8a 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -779,6 +779,22 @@ static int rdtgroup_tasks_show(struct kernfs_open_file *of,
>  	return ret;
>  }
>  
> +static int rdtgroup_closid_show(struct kernfs_open_file *of,
> +				struct seq_file *s, void *v)
> +{
> +	struct rdtgroup *rdtgrp;
> +	int ret = 0;
> +
> +	rdtgrp = rdtgroup_kn_lock_live(of->kn);
> +	if (rdtgrp)
> +		seq_printf(s, "%u\n", rdtgrp->closid);
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
> @@ -1863,6 +1879,13 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= rdtgroup_size_show,
>  		.fflags		= RFTYPE_CTRL_BASE,
>  	},
> +	{
> +		.name		= "ctrl_hw_id",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdtgroup_closid_show,
> +		.fflags		= RFTYPE_CTRL_BASE | RFTYPE_DEBUG,
> +	},
>  
>  };

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1951734013-1696002039=:1989--
