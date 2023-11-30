Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 882537FFE0C
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 22:53:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377046AbjK3Vxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 16:53:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377029AbjK3Vxr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 16:53:47 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8C8D10DF;
        Thu, 30 Nov 2023 13:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701381234; x=1732917234;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=szEhgwh4Idld7dvIWDY2z9wrG2QKjBvPHBigd0PVM6M=;
  b=XFbvk5rJIBsGranFm9lPqGqPKDgMZMjJH9USjnuAUtLV214BHRBAC5oG
   ww0uXvtWUK/yUOs/talrmOIO5m1SJtakF2hNUTFi11lTvv1JszDgpalhp
   MFrJXk/Lt0+35BQzMTUV+n9+PcVA86Hk3rFKQhye2T/3s7vVA17zgYJJ7
   6RixaXmVQ2hykYn3qrkdz76xAaBW7BfWqpOhyY+grdyh3XkwYl7QlCleK
   8qQh3yFuTGJMwH4RVTR9y4YJ9qnWurtiUeIaZfY3WNEBFoXKMQQJnresy
   ktJ2ram43nOOnBrbHml6EtozY5N0/fdMgA/zJkxltUsO/eWOjFh/Ljbor
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="6631891"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="6631891"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 13:53:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="719263954"
X-IronPort-AV: E=Sophos;i="6.04,240,1695711600"; 
   d="scan'208";a="719263954"
Received: from araj-dh-work.jf.intel.com ([10.165.157.158])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 13:53:53 -0800
Date:   Thu, 30 Nov 2023 13:51:27 -0800
From:   Ashok Raj <ashok_raj@linux.intel.com>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux@roeck-us.net, jdelvare@suse.com, fenghua.yu@intel.com,
        linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ashok Raj <ashok.raj@intel.com>
Subject: Re: [PATCH 1/3] hwmon: (coretemp) Introduce enum for attr index
Message-ID: <ZWkDQ5y3e4oPONni@araj-dh-work.jf.intel.com>
References: <20231127131651.476795-1-rui.zhang@intel.com>
 <20231127131651.476795-2-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231127131651.476795-2-rui.zhang@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 27, 2023 at 09:16:49PM +0800, Zhang Rui wrote:
> Introduce enum coretemp_attr_index to better describe the index of each
> sensor attribute and the maximum number of basic/possible attributes.
> 
> No functional change.
> 
> Signed-off-by: Zhang Rui <rui.zhang@intel.com>
> ---
>  drivers/hwmon/coretemp.c | 12 ++++++++++--
>  1 file changed, 10 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwmon/coretemp.c b/drivers/hwmon/coretemp.c
> index ba82d1e79c13..6053ed3761c2 100644
> --- a/drivers/hwmon/coretemp.c
> +++ b/drivers/hwmon/coretemp.c
> @@ -43,10 +43,18 @@ MODULE_PARM_DESC(tjmax, "TjMax value in degrees Celsius");
>  #define BASE_SYSFS_ATTR_NO	2	/* Sysfs Base attr no for coretemp */
>  #define NUM_REAL_CORES		128	/* Number of Real cores per cpu */
>  #define CORETEMP_NAME_LENGTH	28	/* String Length of attrs */
> -#define MAX_CORE_ATTRS		4	/* Maximum no of basic attrs */
> -#define TOTAL_ATTRS		(MAX_CORE_ATTRS + 1)
>  #define MAX_CORE_DATA		(NUM_REAL_CORES + BASE_SYSFS_ATTR_NO)
>  
> +enum coretemp_attr_index {
> +	ATTR_LABEL,
> +	ATTR_CRIT_ALARM,
> +	ATTR_TEMP,
> +	ATTR_TJMAX,
> +	ATTR_TTARGET,
> +	TOTAL_ATTRS,			/* Maximum no of possible attrs */
> +	MAX_CORE_ATTRS = ATTR_TJMAX + 1	/* Maximum no of basic attrs */

This seems odd. TOTAL_ATTRS being the last entry seems fine, but defining a
MAX_CORE_ATTR the way above sounds a bit hacky.

> +};
> +
>  #ifdef CONFIG_SMP
>  #define for_each_sibling(i, cpu) \
>  	for_each_cpu(i, topology_sibling_cpumask(cpu))
> -- 
> 2.34.1
> 
