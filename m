Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0DC77B373D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:50:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233576AbjI2Pun (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:50:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjI2Pul (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:50:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C71139;
        Fri, 29 Sep 2023 08:50:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696002639; x=1727538639;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=7+SGseYhX5JNUFvBWvY7B8R/fPn7vX851ry7SYzAZZU=;
  b=MpWPWPdx1rxWt1rIUp+nKHEDFeqRxqSR2+JMC1raj+G4j6PCjfb886AH
   JLNSsfPTUknBsR16BjDzTM8ikzH3QrZ2FFkvu+3J7Qu1/xk/MLahIkrRl
   DIjScRLWFau3SlBg97sM0VfP29Gr7xGbmwzzKum6J90RxUChkAVvo5Be6
   U+IsZN3GO5M1Zio3+Dlsu+K2S4Ziy8UBr6Rx3HBs2aEnsMPyjxuto9xQm
   odRE98nrac17d2SYBLK2+DrFjzZgsvhhzw1++IzzBe2bxlomVuiEcUn4S
   y+dzED4CIwa5zAMdyU/eMfTsQsacVBy3o5NCtnpPcXJOUiJMQG9jjpMtu
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="379599091"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="379599091"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:50:38 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="779322587"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="779322587"
Received: from smorozov-mobl1.ger.corp.intel.com ([10.252.52.167])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:50:28 -0700
Date:   Fri, 29 Sep 2023 18:50:25 +0300 (EEST)
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
Subject: Re: [PATCH v10 06/10] x86/resctrl: Move default group file creation
 to mount
In-Reply-To: <20230915224227.1336967-7-babu.moger@amd.com>
Message-ID: <98f0a397-bdc3-136b-e42a-bbcb169cff4@linux.intel.com>
References: <20230915224227.1336967-1-babu.moger@amd.com> <20230915224227.1336967-7-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-1655808239-1696002637=:1989"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-1655808239-1696002637=:1989
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 15 Sep 2023, Babu Moger wrote:

> The default resource group and its files are created during kernel
> init time. Upcoming changes will make some resctrl files optional
> based on a mount parameter. If optional files are to be added to the
> default group based on the mount option, then each new file needs to
> be created separately and call kernfs_activate() again.
> 
> Create all files of the default resource group during resctrl
> mount, destroyed during unmount, to avoid scattering resctrl
> file addition across two separate code flows.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 58 +++++++++++++++-----------
>  1 file changed, 34 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 3ea874c80c22..a34657f0bd0c 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -54,6 +54,9 @@ static struct kernfs_node *kn_mondata;
>  static struct seq_buf last_cmd_status;
>  static char last_cmd_status_buf[512];
>  
> +static int rdtgroup_setup_root(struct rdt_fs_context *ctx);
> +static void rdtgroup_destroy_root(void);
> +
>  struct dentry *debugfs_resctrl;
>  
>  void rdt_last_cmd_clear(void)
> @@ -2511,10 +2514,14 @@ static int rdt_get_tree(struct fs_context *fc)
>  		goto out;
>  	}
>  
> -	ret = rdt_enable_ctx(ctx);
> +	ret = rdtgroup_setup_root(ctx);
>  	if (ret)
>  		goto out;
>  
> +	ret = rdt_enable_ctx(ctx);
> +	if (ret)
> +		goto out_root;
> +
>  	ret = schemata_list_create();
>  	if (ret) {
>  		schemata_list_destroy();
> @@ -2523,6 +2530,12 @@ static int rdt_get_tree(struct fs_context *fc)
>  
>  	closid_init();
>  
> +	ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
> +	if (ret)
> +		goto out_schemata_free;
> +
> +	kernfs_activate(rdtgroup_default.kn);
> +
>  	ret = rdtgroup_create_info_dir(rdtgroup_default.kn);
>  	if (ret < 0)
>  		goto out_schemata_free;
> @@ -2579,6 +2592,8 @@ static int rdt_get_tree(struct fs_context *fc)
>  	schemata_list_destroy();
>  out_ctx:
>  	rdt_disable_ctx();
> +out_root:
> +	rdtgroup_destroy_root();
>  out:
>  	rdt_last_cmd_clear();
>  	mutex_unlock(&rdtgroup_mutex);
> @@ -2649,7 +2664,6 @@ static int rdt_init_fs_context(struct fs_context *fc)
>  	if (!ctx)
>  		return -ENOMEM;
>  
> -	ctx->kfc.root = rdt_root;
>  	ctx->kfc.magic = RDTGROUP_SUPER_MAGIC;
>  	fc->fs_private = &ctx->kfc;
>  	fc->ops = &rdt_fs_context_ops;
> @@ -2819,6 +2833,7 @@ static void rdt_kill_sb(struct super_block *sb)
>  	rdt_pseudo_lock_release();
>  	rdtgroup_default.mode = RDT_MODE_SHAREABLE;
>  	schemata_list_destroy();
> +	rdtgroup_destroy_root();
>  	static_branch_disable_cpuslocked(&rdt_alloc_enable_key);
>  	static_branch_disable_cpuslocked(&rdt_mon_enable_key);
>  	static_branch_disable_cpuslocked(&rdt_enable_key);
> @@ -3700,10 +3715,8 @@ static struct kernfs_syscall_ops rdtgroup_kf_syscall_ops = {
>  	.show_options	= rdtgroup_show_options,
>  };
>  
> -static int __init rdtgroup_setup_root(void)
> +static int rdtgroup_setup_root(struct rdt_fs_context *ctx)
>  {
> -	int ret;
> -
>  	rdt_root = kernfs_create_root(&rdtgroup_kf_syscall_ops,
>  				      KERNFS_ROOT_CREATE_DEACTIVATED |
>  				      KERNFS_ROOT_EXTRA_OPEN_PERM_CHECK,
> @@ -3711,6 +3724,20 @@ static int __init rdtgroup_setup_root(void)
>  	if (IS_ERR(rdt_root))
>  		return PTR_ERR(rdt_root);
>  
> +	ctx->kfc.root = rdt_root;
> +	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
> +
> +	return 0;
> +}
> +
> +static void rdtgroup_destroy_root(void)
> +{
> +	kernfs_destroy_root(rdt_root);
> +	rdtgroup_default.kn = NULL;
> +}
> +
> +static void __init rdtgroup_setup_default(void)
> +{
>  	mutex_lock(&rdtgroup_mutex);
>  
>  	rdtgroup_default.closid = 0;
> @@ -3720,19 +3747,7 @@ static int __init rdtgroup_setup_root(void)
>  
>  	list_add(&rdtgroup_default.rdtgroup_list, &rdt_all_groups);
>  
> -	ret = rdtgroup_add_files(kernfs_root_to_node(rdt_root), RFTYPE_CTRL_BASE);
> -	if (ret) {
> -		kernfs_destroy_root(rdt_root);
> -		goto out;
> -	}
> -
> -	rdtgroup_default.kn = kernfs_root_to_node(rdt_root);
> -	kernfs_activate(rdtgroup_default.kn);
> -
> -out:
>  	mutex_unlock(&rdtgroup_mutex);
> -
> -	return ret;
>  }
>  
>  static void domain_destroy_mon_state(struct rdt_domain *d)
> @@ -3854,13 +3869,11 @@ int __init rdtgroup_init(void)
>  	seq_buf_init(&last_cmd_status, last_cmd_status_buf,
>  		     sizeof(last_cmd_status_buf));
>  
> -	ret = rdtgroup_setup_root();
> -	if (ret)
> -		return ret;
> +	rdtgroup_setup_default();
>  
>  	ret = sysfs_create_mount_point(fs_kobj, "resctrl");
>  	if (ret)
> -		goto cleanup_root;
> +		return ret;
>  
>  	ret = register_filesystem(&rdt_fs_type);
>  	if (ret)
> @@ -3893,8 +3906,6 @@ int __init rdtgroup_init(void)
>  
>  cleanup_mountpoint:
>  	sysfs_remove_mount_point(fs_kobj, "resctrl");
> -cleanup_root:
> -	kernfs_destroy_root(rdt_root);
>  
>  	return ret;
>  }
> @@ -3904,5 +3915,4 @@ void __exit rdtgroup_exit(void)
>  	debugfs_remove_recursive(debugfs_resctrl);
>  	unregister_filesystem(&rdt_fs_type);
>  	sysfs_remove_mount_point(fs_kobj, "resctrl");
> -	kernfs_destroy_root(rdt_root);
>  }
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-1655808239-1696002637=:1989--
