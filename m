Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34C527B35ED
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjI2Onr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:43:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233404AbjI2Ono (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:43:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55F0C10CF
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:36:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695998210; x=1727534210;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=MTPjlxopFTw41xA/5FF1b4ucJ27JmoiuLtnR94OsBeo=;
  b=dNn9QKqf0DVcTIJM0ChTLnWJweeOxt66UKSsgW+lka+AEg7w7M978Cyi
   zTiOV17GHJPgopIDM89K5/LZjacR8o+GYMa2SeD668Xxj4i51P+KjFXcn
   u5nTXxsXjyWLBqKHHOUqdmYotJ863lMDvb4vn1b2d0MFFvMw9+giBm4KY
   z9gLiowcOdL3U8em/8itnDzQOCWBdzgImllfFTYouw5m3/Yt0GzyTHsQk
   87xrsDxJuelSp0hfa1Z2mbiinIhXNDgPw8t3sTjh70WLJyoLsym/W2pPd
   oTSbf+2bKYhjlLiySMta30YPUfvNI4u/01+3tp0DKdPu5KLTTulxfR4qx
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="361688535"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="361688535"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 07:36:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="996950482"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="996950482"
Received: from smorozov-mobl1.ger.corp.intel.com ([10.252.52.167])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 07:36:46 -0700
Date:   Fri, 29 Sep 2023 17:36:44 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Newman <peternewman@google.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 1/4] x86/resctrl: Rename arch_has_sparse_bitmaps
In-Reply-To: <81216b7633a6838ea72ca6d4471be233b980e4f9.1695977733.git.maciej.wieczor-retman@intel.com>
Message-ID: <ac2ec634-4666-cfe2-49d5-2cbda5a4412a@linux.intel.com>
References: <cover.1695977733.git.maciej.wieczor-retman@intel.com> <81216b7633a6838ea72ca6d4471be233b980e4f9.1695977733.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-814904506-1695998209=:1989"
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

--8323329-814904506-1695998209=:1989
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 29 Sep 2023, Maciej Wieczor-Retman wrote:

> A later patch exposes the value of arch_has_sparse_bitmaps to
> user space via the existing term of a bitmask. Rename
> arch_has_sparse_bitmaps to arch_has_sparse_bitmasks to ensure
> consistent terminology throughout resctrl.
> 
> Suggested-by: Reinette Chatre <reinette.chatre@intel.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v3:
> - Add Peter's tested-by and reviewed-by tags.
> - Make this patch first in the series. (Reinette)
> - Change the patch message. (Reinette)
> - Drop rmid_busy_llc comment name change. (Reinette)
> 
> Changelog v2:
> - Create this patch.
> 
>  arch/x86/kernel/cpu/resctrl/core.c        | 4 ++--
>  arch/x86/kernel/cpu/resctrl/ctrlmondata.c | 4 ++--
>  include/linux/resctrl.h                   | 4 ++--
>  3 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
> index 030d3b409768..c09e4fdded3c 100644
> --- a/arch/x86/kernel/cpu/resctrl/core.c
> +++ b/arch/x86/kernel/cpu/resctrl/core.c
> @@ -872,7 +872,7 @@ static __init void rdt_init_res_defs_intel(void)
>  
>  		if (r->rid == RDT_RESOURCE_L3 ||
>  		    r->rid == RDT_RESOURCE_L2) {
> -			r->cache.arch_has_sparse_bitmaps = false;
> +			r->cache.arch_has_sparse_bitmasks = false;
>  			r->cache.arch_has_per_cpu_cfg = false;
>  			r->cache.min_cbm_bits = 1;
>  		} else if (r->rid == RDT_RESOURCE_MBA) {
> @@ -892,7 +892,7 @@ static __init void rdt_init_res_defs_amd(void)
>  
>  		if (r->rid == RDT_RESOURCE_L3 ||
>  		    r->rid == RDT_RESOURCE_L2) {
> -			r->cache.arch_has_sparse_bitmaps = true;
> +			r->cache.arch_has_sparse_bitmasks = true;
>  			r->cache.arch_has_per_cpu_cfg = true;
>  			r->cache.min_cbm_bits = 0;
>  		} else if (r->rid == RDT_RESOURCE_MBA) {
> diff --git a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> index b44c487727d4..ab45012288bb 100644
> --- a/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> +++ b/arch/x86/kernel/cpu/resctrl/ctrlmondata.c
> @@ -113,8 +113,8 @@ static bool cbm_validate(char *buf, u32 *data, struct rdt_resource *r)
>  	first_bit = find_first_bit(&val, cbm_len);
>  	zero_bit = find_next_zero_bit(&val, cbm_len, first_bit);
>  
> -	/* Are non-contiguous bitmaps allowed? */
> -	if (!r->cache.arch_has_sparse_bitmaps &&
> +	/* Are non-contiguous bitmasks allowed? */
> +	if (!r->cache.arch_has_sparse_bitmasks &&
>  	    (find_next_bit(&val, cbm_len, zero_bit) < cbm_len)) {
>  		rdt_last_cmd_printf("The mask %lx has non-consecutive 1-bits\n", val);
>  		return false;
> diff --git a/include/linux/resctrl.h b/include/linux/resctrl.h
> index 8334eeacfec5..66942d7fba7f 100644
> --- a/include/linux/resctrl.h
> +++ b/include/linux/resctrl.h
> @@ -94,7 +94,7 @@ struct rdt_domain {
>   *			zero CBM.
>   * @shareable_bits:	Bitmask of shareable resource with other
>   *			executing entities
> - * @arch_has_sparse_bitmaps:	True if a bitmap like f00f is valid.
> + * @arch_has_sparse_bitmasks:	True if a bitmask like f00f is valid.
>   * @arch_has_per_cpu_cfg:	True if QOS_CFG register for this cache
>   *				level has CPU scope.
>   */
> @@ -102,7 +102,7 @@ struct resctrl_cache {
>  	unsigned int	cbm_len;
>  	unsigned int	min_cbm_bits;
>  	unsigned int	shareable_bits;
> -	bool		arch_has_sparse_bitmaps;
> +	bool		arch_has_sparse_bitmasks;
>  	bool		arch_has_per_cpu_cfg;
>  };
>  
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>


-- 
 i.

--8323329-814904506-1695998209=:1989--
