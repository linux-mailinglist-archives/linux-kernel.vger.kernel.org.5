Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47DB0752921
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 18:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234985AbjGMQwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 12:52:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231925AbjGMQwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 12:52:37 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 513711FC0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 09:52:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689267156; x=1720803156;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=JqXMq5WZ95DqjgVxvww1Q/0jvY3SQLw4w6B8FSX7C1c=;
  b=G3r3osphxAesTI8eVc+U2PKMYXMBhlozkFU+vii6Nc3pfR6z6yJhYeVp
   FM3VdZ0NvWsmVlSJ2GZYFkRBzh0lfM6A2xM9XBjT5wCEwmAn+amHT5LFH
   dRPrOE1dMPpRmdXMojorXdfQ2+tUvyzP3ifAKWDn1T3HiR2qayQl6j9kj
   TEKbUMLkX6JjLFJ3qQFe5/3vvCdXZpOTGAWbp2WDNAF/JrqBUqMD3/d9u
   rUH/QkTi7qx/Jfq9P/jS4KvrrugT3LJiI5fqNrCWoPN1JDgtvQpan9zzk
   MP4raKd2rgBj/oMX9KLQs8zjRkKBDe9OsddvEn/PlefuKbg9W47IV+inx
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="345568308"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="345568308"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 09:52:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="896090334"
X-IronPort-AV: E=Sophos;i="6.01,203,1684825200"; 
   d="scan'208";a="896090334"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2023 09:52:34 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJzYO-002RS7-2x;
        Thu, 13 Jul 2023 19:52:32 +0300
Date:   Thu, 13 Jul 2023 19:52:32 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Randy Dunlap <rdunlap@infradead.org>
Cc:     linux-kernel@vger.kernel.org, Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH] cpumask: eliminate kernel-doc warnings
Message-ID: <ZLAr0GtOVBHe8rMU@smile.fi.intel.com>
References: <20230713030832.17900-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230713030832.17900-1-rdunlap@infradead.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 12, 2023 at 08:08:32PM -0700, Randy Dunlap wrote:
> Update lib/cpumask.c and <linux/cpumask.h> to fix all kernel-doc
> warnings:
> 
> include/linux/cpumask.h:185: warning: Function parameter or member 'srcp1' not described in 'cpumask_first_and'
> include/linux/cpumask.h:185: warning: Function parameter or member 'srcp2' not described in 'cpumask_first_and'
> include/linux/cpumask.h:185: warning: Excess function parameter 'src1p' description in 'cpumask_first_and'
> include/linux/cpumask.h:185: warning: Excess function parameter 'src2p' description in 'cpumask_first_and'
> 
> lib/cpumask.c:59: warning: Function parameter or member 'node' not described in 'alloc_cpumask_var_node'
> lib/cpumask.c:169: warning: Function parameter or member 'src1p' not described in 'cpumask_any_and_distribute'
> lib/cpumask.c:169: warning: Function parameter or member 'src2p' not described in 'cpumask_any_and_distribute'

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Thanks for fixing this!

> Fixes: 7b4967c53204 ("cpumask: Add alloc_cpumask_var_node()")
> Fixes: 839cad5fa54b ("cpumask: fix function description kernel-doc notation")
> Fixes: 93ba139ba819 ("cpumask: use find_first_and_bit()")
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> ---
>  include/linux/cpumask.h |    8 ++++++--
>  lib/cpumask.c           |    5 ++++-
>  2 files changed, 10 insertions(+), 3 deletions(-)
> 
> diff -- a/lib/cpumask.c b/lib/cpumask.c
> --- a/lib/cpumask.c
> +++ b/lib/cpumask.c
> @@ -45,6 +45,7 @@ EXPORT_SYMBOL(cpumask_next_wrap);
>   * alloc_cpumask_var_node - allocate a struct cpumask on a given node
>   * @mask: pointer to cpumask_var_t where the cpumask is returned
>   * @flags: GFP_ flags
> + * @node: memory node from which to allocate or %NUMA_NO_NODE
>   *
>   * Only defined when CONFIG_CPUMASK_OFFSTACK=y, otherwise is
>   * a nop returning a constant 1 (in <linux/cpumask.h>)
> @@ -157,7 +158,9 @@ EXPORT_SYMBOL(cpumask_local_spread);
>  static DEFINE_PER_CPU(int, distribute_cpu_mask_prev);
>  
>  /**
> - * cpumask_any_and_distribute - Return an arbitrary cpu within srcp1 & srcp2.
> + * cpumask_any_and_distribute - Return an arbitrary cpu within src1p & src2p.
> + * @src1p: first &cpumask for intersection
> + * @src2p: second &cpumask for intersection
>   *
>   * Iterated calls using the same srcp1 and srcp2 will be distributed within
>   * their intersection.
> diff -- a/include/linux/cpumask.h b/include/linux/cpumask.h
> --- a/include/linux/cpumask.h
> +++ b/include/linux/cpumask.h
> @@ -175,8 +175,8 @@ static inline unsigned int cpumask_first
>  
>  /**
>   * cpumask_first_and - return the first cpu from *srcp1 & *srcp2
> - * @src1p: the first input
> - * @src2p: the second input
> + * @srcp1: the first input
> + * @srcp2: the second input
>   *
>   * Returns >= nr_cpu_ids if no cpus set in both.  See also cpumask_next_and().
>   */
> @@ -1197,6 +1197,10 @@ cpumap_print_bitmask_to_buf(char *buf, c
>  /**
>   * cpumap_print_list_to_buf  - copies the cpumask into the buffer as
>   *	comma-separated list of cpus
> + * @buf: the buffer to copy into
> + * @mask: the cpumask to copy
> + * @off: in the string from which we are copying, we copy to @buf
> + * @count: the maximum number of bytes to print
>   *
>   * Everything is same with the above cpumap_print_bitmask_to_buf()
>   * except the print format.

-- 
With Best Regards,
Andy Shevchenko


