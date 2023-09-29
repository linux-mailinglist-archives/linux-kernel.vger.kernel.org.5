Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D13717B3224
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 14:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233201AbjI2MO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 08:14:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232964AbjI2MOy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 08:14:54 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C26DA195;
        Fri, 29 Sep 2023 05:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695989693; x=1727525693;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=KNfatNXoG01pvqTGnOOrlsYSgYpTKa6jT4GBdzYHpH4=;
  b=glaReEowGOTXDElaWMWFg9mdA6nVwbcMYtmdfmWcppCLtf4SGP71tmmk
   mEQuHPFZE2bUXx85zeg48meH/Ij1OQNpBM8ejK2Dft8o8bM7k+UOXb9eh
   wuTr1GnPKgCI+p89NquIoQFrdPPTMoqQhOgMiErvqLkjAR52CR4b+dGHr
   i7pmzZfbfENCY/1qf9AxuSFvZhKBxz4aC2opA8tQ7ZN4FVDE8cbz3p+5F
   +KbqtLUPZGGVFj5uDbuGyeSS+tRosDhq2mikCZLSw6pXu29uRaOLwA0+e
   4E8hFCSoywXJqNO5PAyOmtLTtDir3nYESu0qVo4ppbg+KCSIjj5rRjc2+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="3857214"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="3857214"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 05:14:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="813536"
Received: from smorozov-mobl1.ger.corp.intel.com ([10.252.52.167])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 05:14:15 -0700
Date:   Fri, 29 Sep 2023 15:14:47 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        platform-driver-x86@vger.kernel.org,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] platform/x86: ISST: Use fuse enabled mask instead
 of allowed levels
In-Reply-To: <20230925194555.966743-2-srinivas.pandruvada@linux.intel.com>
Message-ID: <6991c0fa-7b3c-b99a-4ac4-9c499d4d808b@linux.intel.com>
References: <20230925194555.966743-1-srinivas.pandruvada@linux.intel.com> <20230925194555.966743-2-srinivas.pandruvada@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Sep 2023, Srinivas Pandruvada wrote:

> Allowed level mask is a mask of levels, which are currently allowed
> to dynamically switch. But even dynamic switching is not allowed,

even if ?

> user should be able to check all parameters for selection via BIOS.

I think you're lacking a negation in the above paragraph because it sounds 
like there's an internal contradiction in it. Can you please take a look.

-- 
 i.


> So when passing the level mask for display to user space, use fuse
> enabled mask, which has all levels.
> 
> Signed-off-by: Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>
> ---
>  drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> index 37f17e229419..48465636aadb 100644
> --- a/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> +++ b/drivers/platform/x86/intel/speed_select_if/isst_tpmi_core.c
> @@ -712,7 +712,7 @@ static int isst_if_get_perf_level(void __user *argp)
>  		return -EINVAL;
>  
>  	perf_level.max_level = power_domain_info->max_level;
> -	perf_level.level_mask = power_domain_info->pp_header.allowed_level_mask;
> +	perf_level.level_mask = power_domain_info->pp_header.level_en_mask;
>  	perf_level.feature_rev = power_domain_info->pp_header.feature_rev;
>  	_read_pp_info("current_level", perf_level.current_level, SST_PP_STATUS_OFFSET,
>  		      SST_PP_LEVEL_START, SST_PP_LEVEL_WIDTH, SST_MUL_FACTOR_NONE)
> 
