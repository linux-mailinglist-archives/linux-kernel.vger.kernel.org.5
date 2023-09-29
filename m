Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91D767B3764
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 17:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233737AbjI2P7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 11:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233141AbjI2P7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 11:59:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B35FB199;
        Fri, 29 Sep 2023 08:59:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696003187; x=1727539187;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=Je6EGKZMv+TsDqILwXjgiaxO2rBwrwYSjxArwTiyOh8=;
  b=ljNQ7CB9uLJQSR3h9LrLSj00LVUiFWi3YNAeE5aYl/3AzQav6hw7bf+b
   ze9pytBa1iqw3n6srX+oeFb8FA+HE706bkGIFh4A/eXHfpgPRdQsnMraQ
   crbzk3xW24MdKpuTAHnrsrU34ojMBkCBVHlqvB3gwHs5zM+fAFLXK0whs
   HrXwUhJ/FjqS6wQOPRHyPfbtMMJyx5HA0gA7JSvoSxtj02gNpDCXkGKE4
   oKehC46WqVSjo734d2ukxXbsNAwM3g5DYsFmc9LlwqsEbfZZdKLzs+QjX
   gMOrqM29MDC63z8KVMRAzCkS8fEInO04dS0XfIA0GIVwvosze+6QHu9O5
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="367383373"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="367383373"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:59:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="743474304"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="743474304"
Received: from smorozov-mobl1.ger.corp.intel.com ([10.252.52.167])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 08:59:38 -0700
Date:   Fri, 29 Sep 2023 18:59:35 +0300 (EEST)
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
Subject: Re: [PATCH v10 09/10] x86/resctrl: Add support for the files for
 MON groups only
In-Reply-To: <20230915224227.1336967-10-babu.moger@amd.com>
Message-ID: <b0c837f8-de37-f25d-6e0-8bfc1fa894ae@linux.intel.com>
References: <20230915224227.1336967-1-babu.moger@amd.com> <20230915224227.1336967-10-babu.moger@amd.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-822049506-1696003186=:1989"
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

--8323329-822049506-1696003186=:1989
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 15 Sep 2023, Babu Moger wrote:

> There are 3 types resctrl root files.
> 1. RFTYPE_BASE : Files common for both MON and CTRL groups
> 2. RFTYPE_BASE | RFTYPE_CTRL : Files only for CTRL groups
> 3. RFTYPE_BASE | RFTYPE_MON : Files only for MON groups
> 
> Files only for the MON groups are not supported now. Add the
> support to create these files.
> 
> Signed-off-by: Babu Moger <babu.moger@amd.com>
> ---
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 953b082cec8a..55d1b90f460e 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -2533,6 +2533,7 @@ static void schemata_list_destroy(void)
>  static int rdt_get_tree(struct fs_context *fc)
>  {
>  	struct rdt_fs_context *ctx = rdt_fc2context(fc);
> +	unsigned long flags = RFTYPE_CTRL_BASE;
>  	struct rdt_domain *dom;
>  	struct rdt_resource *r;
>  	int ret;
> @@ -2563,7 +2564,10 @@ static int rdt_get_tree(struct fs_context *fc)
>  
>  	closid_init();
>  
> -	ret = rdtgroup_add_files(rdtgroup_default.kn, RFTYPE_CTRL_BASE);
> +	if (rdt_mon_capable)
> +		flags |= RFTYPE_MON;
> +
> +	ret = rdtgroup_add_files(rdtgroup_default.kn, flags);
>  	if (ret)
>  		goto out_schemata_free;
>  
> @@ -3253,8 +3257,8 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  			     enum rdt_group_type rtype, struct rdtgroup **r)
>  {
>  	struct rdtgroup *prdtgrp, *rdtgrp;
> +	unsigned long files = 0;
>  	struct kernfs_node *kn;
> -	uint files = 0;
>  	int ret;
>  
>  	prdtgrp = rdtgroup_kn_lock_live(parent_kn);
> @@ -3306,10 +3310,13 @@ static int mkdir_rdt_prepare(struct kernfs_node *parent_kn,
>  		goto out_destroy;
>  	}
>  
> -	if (rtype == RDTCTRL_GROUP)
> +	if (rtype == RDTCTRL_GROUP) {
>  		files = RFTYPE_BASE | RFTYPE_CTRL;
> -	else
> +		if (rdt_mon_capable)
> +			files |= RFTYPE_MON;
> +	} else {
>  		files = RFTYPE_BASE | RFTYPE_MON;
> +	}
>  
>  	ret = rdtgroup_add_files(kn, files);
>  	if (ret) {
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-822049506-1696003186=:1989--
