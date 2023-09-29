Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482657B36C1
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:25:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233597AbjI2PZ4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:25:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbjI2PZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:25:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A64FF7;
        Fri, 29 Sep 2023 08:25:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696001152; x=1727537152;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=M20ejqqOgKLj/KDTmG8TFlSsEsdSjuI0oU4rBfV71jA=;
  b=XPKaQke6BEEnRMG7jc5Pog/I+fmEFUxQolzTHCN9mtnPD+8fifxBDI91
   IU4x7FeJ+u1d7bxPKwNvB50mI7ckK7QOcRUhRsCftgIirJAkXfOyCm2fa
   k9pXpRwFjEz1Wv+LTRo9FhDTXC+Y+3hWLD109yQ4rXkNkkcGphjeTQPBz
   BF1yvUY+/XuYtTo4AB0gZo3lucDnPUMuoRP02Qy/siSTsnmcV1e/AKhH+
   Gxpo6UHmu+KJN8WqyJJoN+Nep2BY70OvxnWSePv/F/Lur3pLCRU/ZyHFy
   3O9RAokTBnukZvSyIqo5eT+51DuNzIGuYHX/QluIPiv0T66FLiyYXw3Vk
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="367377054"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="367377054"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:25:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="753411168"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="753411168"
Received: from smorozov-mobl1.ger.corp.intel.com ([10.252.52.167])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:25:43 -0700
Date:   Fri, 29 Sep 2023 18:25:40 +0300 (EEST)
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
Subject: Re: [PATCH v10 07/10] x86/resctrl: Introduce "-o debug" mount
 option
In-Reply-To: <20230915224227.1336967-8-babu.moger@amd.com>
Message-ID: <aa0a87c-e00-9cf2-b76f-bd3bbde84519@linux.intel.com>
References: <20230915224227.1336967-1-babu.moger@amd.com> <20230915224227.1336967-8-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-452488885-1696001150=:1989"
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

--8323329-452488885-1696001150=:1989
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 15 Sep 2023, Babu Moger wrote:

> Add "-o debug" option to mount resctrl filesystem in debug mode.
> When in debug mode resctrl displays files that have the new
> RFTYPE_DEBUG flag to help resctrl debugging.
> 
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  Documentation/arch/x86/resctrl.rst     |  5 ++++-
>  arch/x86/kernel/cpu/resctrl/internal.h |  2 ++
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
>  3 files changed, 24 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/arch/x86/resctrl.rst b/Documentation/arch/x86/resctrl.rst
> index 8154e9975d1e..28d35aaa74b4 100644
> --- a/Documentation/arch/x86/resctrl.rst
> +++ b/Documentation/arch/x86/resctrl.rst
> @@ -35,7 +35,7 @@ about the feature from resctrl's info directory.
>  
>  To use the feature mount the file system::
>  
> - # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps]] /sys/fs/resctrl
> + # mount -t resctrl resctrl [-o cdp[,cdpl2][,mba_MBps][,debug]] /sys/fs/resctrl
>  
>  mount options are:
>  
> @@ -46,6 +46,9 @@ mount options are:
>  "mba_MBps":
>  	Enable the MBA Software Controller(mba_sc) to specify MBA
>  	bandwidth in MBps
> +"debug":
> +	Make debug files accessible. Available debug files are annotated with
> +	"Available only with debug option".
>  
>  L2 and L3 CDP are controlled separately.
>  
> diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
> index 14988c9f402c..68d1b7147291 100644
> --- a/arch/x86/kernel/cpu/resctrl/internal.h
> +++ b/arch/x86/kernel/cpu/resctrl/internal.h
> @@ -59,6 +59,7 @@ struct rdt_fs_context {
>  	bool				enable_cdpl2;
>  	bool				enable_cdpl3;
>  	bool				enable_mba_mbps;
> +	bool				enable_debug;
>  };
>  
>  static inline struct rdt_fs_context *rdt_fc2context(struct fs_context *fc)
> @@ -306,6 +307,7 @@ struct rdtgroup {
>  #define RFTYPE_TOP			BIT(6)
>  #define RFTYPE_RES_CACHE		BIT(8)
>  #define RFTYPE_RES_MB			BIT(9)
> +#define RFTYPE_DEBUG			BIT(10)
>  #define RFTYPE_CTRL_INFO		(RFTYPE_INFO | RFTYPE_CTRL)
>  #define RFTYPE_MON_INFO			(RFTYPE_INFO | RFTYPE_MON)
>  #define RFTYPE_TOP_INFO			(RFTYPE_INFO | RFTYPE_TOP)
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index a34657f0bd0c..150105c21fee 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -59,6 +59,8 @@ static void rdtgroup_destroy_root(void);
>  
>  struct dentry *debugfs_resctrl;
>  
> +static bool resctrl_debug;
> +
>  void rdt_last_cmd_clear(void)
>  {
>  	lockdep_assert_held(&rdtgroup_mutex);
> @@ -1874,6 +1876,9 @@ static int rdtgroup_add_files(struct kernfs_node *kn, unsigned long fflags)
>  
>  	lockdep_assert_held(&rdtgroup_mutex);
>  
> +	if (resctrl_debug)
> +		fflags |= RFTYPE_DEBUG;
> +
>  	for (rft = rfts; rft < rfts + len; rft++) {
>  		if (rft->fflags && ((fflags & rft->fflags) == rft->fflags)) {
>  			ret = rdtgroup_add_file(kn, rft);
> @@ -2377,6 +2382,8 @@ static void rdt_disable_ctx(void)
>  	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L3, false);
>  	resctrl_arch_set_cdp_enabled(RDT_RESOURCE_L2, false);
>  	set_mba_sc(false);
> +
> +	resctrl_debug = false;
>  }
>  
>  static int rdt_enable_ctx(struct rdt_fs_context *ctx)
> @@ -2401,6 +2408,9 @@ static int rdt_enable_ctx(struct rdt_fs_context *ctx)
>  			goto out_cdpl3;
>  	}
>  
> +	if (ctx->enable_debug)
> +		resctrl_debug = true;
> +
>  	return 0;
>  
>  out_cdpl3:
> @@ -2605,6 +2615,7 @@ enum rdt_param {
>  	Opt_cdp,
>  	Opt_cdpl2,
>  	Opt_mba_mbps,
> +	Opt_debug,
>  	nr__rdt_params
>  };
>  
> @@ -2612,6 +2623,7 @@ static const struct fs_parameter_spec rdt_fs_parameters[] = {
>  	fsparam_flag("cdp",		Opt_cdp),
>  	fsparam_flag("cdpl2",		Opt_cdpl2),
>  	fsparam_flag("mba_MBps",	Opt_mba_mbps),
> +	fsparam_flag("debug",		Opt_debug),
>  	{}
>  };
>  
> @@ -2637,6 +2649,9 @@ static int rdt_parse_param(struct fs_context *fc, struct fs_parameter *param)
>  			return -EINVAL;
>  		ctx->enable_mba_mbps = true;
>  		return 0;
> +	case Opt_debug:
> +		ctx->enable_debug = true;
> +		return 0;
>  	}
>  
>  	return -EINVAL;
> @@ -3705,6 +3720,9 @@ static int rdtgroup_show_options(struct seq_file *seq, struct kernfs_root *kf)
>  	if (is_mba_sc(&rdt_resources_all[RDT_RESOURCE_MBA].r_resctrl))
>  		seq_puts(seq, ",mba_MBps");
>  
> +	if (resctrl_debug)
> +		seq_puts(seq, ",debug");
> +
>  	return 0;
>  }
>  
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-452488885-1696001150=:1989--
