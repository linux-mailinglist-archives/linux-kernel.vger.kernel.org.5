Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 848D97B35FC
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 16:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjI2Or2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 10:47:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229508AbjI2Or1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 10:47:27 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1446F9
        for <linux-kernel@vger.kernel.org>; Fri, 29 Sep 2023 07:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695998845; x=1727534845;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version:content-id;
  bh=DkHNKJqK5QAoNV6GKSR8J2VRvWbtTnaGgSQV4oB/QVU=;
  b=b9s2SQKL34lICkDeCLxpMDzxcfUvYwYqTdFh81YEQZQUwK3jV2Q+Oyg5
   anHhNVhJpJ4m6SU0cQokJiivMpp5bgKd5oTQUwgj93h2Uz7tY4D4LYrXH
   iRefM+O8qsxbwF92l4Fvbe1Hi/sU4hC6kfUoA6akTIafhVWew7gsLNvdL
   qnZ9dPesTyZDu/dDRR8rq3bTjRTPcBtXDOaJRUJ1dEqa97ZRKeiyA4G3N
   gAbf/qXdg0m1O9h7BOtMHX674v67To2KaH8CKPRUzhd1N7LjTEqClAjy8
   RWRgaXiyd3U1X6veFqh5ry+YjDDV/sKUyW75uCUWwS/hoKbNp1pSCqrQ/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="413212205"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="413212205"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 07:47:25 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10848"; a="820227173"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="820227173"
Received: from smorozov-mobl1.ger.corp.intel.com ([10.252.52.167])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 07:47:21 -0700
Date:   Fri, 29 Sep 2023 17:47:18 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
cc:     Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Peter Newman <peternewman@google.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/4] x86/resctrl: Add sparse_masks file in info
In-Reply-To: <46d7aa4948b4e669d35dc5b2b0b6b0167ec9c8d7.1695977733.git.maciej.wieczor-retman@intel.com>
Message-ID: <6a7db4d1-fa76-1e12-e49a-ef865b33f8ff@linux.intel.com>
References: <cover.1695977733.git.maciej.wieczor-retman@intel.com> <46d7aa4948b4e669d35dc5b2b0b6b0167ec9c8d7.1695977733.git.maciej.wieczor-retman@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; BOUNDARY="8323329-1618128138-1695998808=:1989"
Content-ID: <3ab5c386-33e3-f0b1-97c2-abee0bdf27a@linux.intel.com>
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

--8323329-1618128138-1695998808=:1989
Content-Type: text/plain; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <ad79d6e0-71d5-a0b0-a5aa-dbea401c917a@linux.intel.com>

On Fri, 29 Sep 2023, Maciej Wieczor-Retman wrote:

> From: Fenghua Yu <fenghua.yu@intel.com>
> 
> Add the interface in resctrl FS to show if sparse cache allocation
> bit masks are supported on the platform. Reading the file returns
> either a "1" if non-contiguous 1s are supported and "0" otherwise.
> The file path is /sys/fs/resctrl/info/{resource}/sparse_masks, where
> {resource} can be either "L2" or "L3".
> 
> Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
> Reviewed-by: Peter Newman <peternewman@google.com>
> Tested-by: Peter Newman <peternewman@google.com>
> Signed-off-by: Maciej Wieczor-Retman <maciej.wieczor-retman@intel.com>
> ---
> Changelog v3:
> - Add Peter's tested-by and reviewed-by tags.
> - Reword patch message slightly. (Reinette)
> 
> Changelog v2:
> - Change bitmap naming convention to bit mask. (Reinette)
> - Change file name to "sparse_masks". (Reinette)
> 
>  arch/x86/kernel/cpu/resctrl/rdtgroup.c | 18 ++++++++++++++++++
>  1 file changed, 18 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> index 725344048f85..945801898a4d 100644
> --- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> +++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
> @@ -895,6 +895,17 @@ static int rdt_shareable_bits_show(struct kernfs_open_file *of,
>  	return 0;
>  }
>  
> +static int rdt_has_sparse_bitmasks_show(struct kernfs_open_file *of,
> +					struct seq_file *seq, void *v)
> +{
> +	struct resctrl_schema *s = of->kn->parent->priv;
> +	struct rdt_resource *r = s->res;
> +
> +	seq_printf(seq, "%u\n", r->cache.arch_has_sparse_bitmasks);
> +
> +	return 0;
> +}
> +
>  /**
>   * rdt_bit_usage_show - Display current usage of resources
>   *
> @@ -1839,6 +1850,13 @@ static struct rftype res_common_files[] = {
>  		.seq_show	= rdtgroup_size_show,
>  		.fflags		= RF_CTRL_BASE,
>  	},
> +	{
> +		.name		= "sparse_masks",
> +		.mode		= 0444,
> +		.kf_ops		= &rdtgroup_kf_single_ops,
> +		.seq_show	= rdt_has_sparse_bitmasks_show,
> +		.fflags		= RF_CTRL_INFO | RFTYPE_RES_CACHE,
> +	},
>  
>  };
>  
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.
--8323329-1618128138-1695998808=:1989--
