Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 56B717B369A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233600AbjI2PXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233536AbjI2PXB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:23:01 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F165F9;
        Fri, 29 Sep 2023 08:22:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696000978; x=1727536978;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NlacZmizqV6T4MirzFGoCsXo3cO1zhZooZmKEx5tnxM=;
  b=aYuTt/YDQ5XghZ2srE7aZOE3r6ruGpRDRhhvELiHKdfePBlWFxgnlf2D
   6Bm4QQB1CEfCp/d0ewIlj60jaOVcFfnVXZaDvc2FyjDKq/Z5I4WuDjoh8
   7aD1caoph9BiR12AglMf/ElM34T9gFU8a3dFFeB+rnyHukwX/9+JkiYsx
   V79dx4G6hgVFHGX5tTaIVoZvMHSOmx5wk5LG7s6eneribjtJdWOyHUjDv
   jE9LlJDOOtnxI0/fuDqvVmTNYeiiG3PHZatSBNNQIS/rS5u74Pqbn5L0F
   +NFb+5NjKBNmEyyVgEUDTDmU6jRbfcuMDy2rgYtSsbJ3RTbyQyw0Ee56m
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="361699977"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="361699977"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:22:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="726626698"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="726626698"
Received: from smorozov-mobl1.ger.corp.intel.com ([10.252.52.167])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:22:28 -0700
Date:   Fri, 29 Sep 2023 18:22:26 +0300 (EEST)
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
Subject: Re: [PATCH v10 05/10] x86/resctrl: Unwind the errors inside
 rdt_enable_ctx()
In-Reply-To: <20230915224227.1336967-6-babu.moger@amd.com>
Message-ID: <1f11b7d3-cb83-4e2b-a5c-11de87bb43b5@linux.intel.com>
References: <20230915224227.1336967-1-babu.moger@amd.com> <20230915224227.1336967-6-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1669564657-1696000957=:1989"
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

--8323329-1669564657-1696000957=:1989
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 15 Sep 2023, Babu Moger wrote:

> rdt_enable_ctx() enables the features provided during resctrl mount.
> 
> Additions to rdt_enable_ctx() are required to also modify error paths
> of rdt_enable_ctx() callers to ensure correct unwinding if errors
> are encountered after calling rdt_enable_ctx(). This is error prone.
> 
> Introduce rdt_disable_ctx() to refactor the error unwinding of
> rdt_enable_ctx() to simplify future additions. This also simplifies
> cleanup in rdt_kill_sb().
> 
> Remove cdp_disable_all() as it is not used anymore after the refactor.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 53 ++++++++++++++++----------
>  1 file changed, 32 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 35945b4bf196..3ea874c80c22 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2290,14 +2290,6 @@ int resctrl_arch_set_cdp_enabled(enum resctrl_res_level l, bool enable)
>  	return 0;
>  }
>  
> -static void cdp_disable_all(void)
> -{
> -	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L3))
> -		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
> -	if (resctrl_arch_get_cdp_enabled(RDT_RESOURCE_L2))
> -		resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
> -}
> -
>  /*
>   * We don't allow rdtgroup directories to be created anywhere
>   * except the root directory. Thus when looking for the rdtgroup
> @@ -2377,19 +2369,42 @@ static int mkdir_mondata_all(struct kernfs_node *parent_kn,
>  			     struct rdtgroup *prgrp,
>  			     struct kernfs_node **mon_data_kn);
>  
> +static void rdt_disable_ctx(void)
> +{
> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
> +	set_mba_sc(false);
> +}
> +
>  static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>  {
>  	int ret = 0;
>  
> -	if (ctx->enable_cdpl2)
> +	if (ctx->enable_cdpl2) {
>  		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, true);
> +		if (ret)
> +			goto out_done;
> +	}
>  
> -	if (!ret && ctx->enable_cdpl3)
> +	if (ctx->enable_cdpl3) {
>  		ret = resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, true);
> +		if (ret)
> +			goto out_cdpl2;
> +	}
>  
> -	if (!ret && ctx->enable_mba_mbps)
> +	if (ctx->enable_mba_mbps) {
>  		ret = set_mba_sc(true);
> +		if (ret)
> +			goto out_cdpl3;
> +	}
> +
> +	return 0;
>  
> +out_cdpl3:
> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
> +out_cdpl2:
> +	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
> +out_done:
>  	return ret;
>  }
>  
> @@ -2497,13 +2512,13 @@ static int rdt_get_tree(struct fs_context *fc)
>  	}
>  
>  	ret = rdt_enable_ctx(ctx);
> -	if (ret < 0)
> -		goto out_cdp;
> +	if (ret)
> +		goto out;
>  
>  	ret = schemata_list_create();
>  	if (ret) {
>  		schemata_list_destroy();
> -		goto out_mba;
> +		goto out_ctx;
>  	}
>  
>  	closid_init();
> @@ -2562,11 +2577,8 @@ static int rdt_get_tree(struct fs_context *fc)
>  	kernfs_remove(kn_info);
>  out_schemata_free:
>  	schemata_list_destroy();
> -out_mba:
> -	if (ctx->enable_mba_mbps)
> -		set_mba_sc(false);
> -out_cdp:
> -	cdp_disable_all();
> +out_ctx:
> +	rdt_disable_ctx();
>  out:
>  	rdt_last_cmd_clear();
>  	mutex_unlock(&rdtgroup_mutex);
> @@ -2798,12 +2810,11 @@ static void rdt_kill_sb(struct super_block *sb)
>  	cpus_read_lock();
>  	mutex_lock(&rdtgroup_mutex);
>  
> -	set_mba_sc(false);
> +	rdt_disable_ctx();
>  
>  	/*Put everything back to default values. */
>  	for_each_alloc_capable_rdt_resource(r)
>  		reset_all_ctrls(r);
> -	cdp_disable_all();
>  	rmdir_all_sub();
>  	rdt_pseudo_lock_release();
>  	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1669564657-1696000957=:1989--
