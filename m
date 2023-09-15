Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E766C7A2385
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 18:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbjIOQX1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 12:23:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjIOQWw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 12:22:52 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43254AF;
        Fri, 15 Sep 2023 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694794967; x=1726330967;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=gZr9jiChR+PI/11CHpgMrz1spTSHcnF3wv8jDHSpulI=;
  b=ITi63aVg4C7WDxIpV7PX7EENe6+PJyq0qRUYiw44GUXhtPA6RBibS7Fn
   uP/eo8yFGuNcVcdJUad8m4NflTbyMLFRfbdNhUK+EJnK9GoXL2qGGEbZ5
   Lwry5ODgHrhja2XwDMiu8/NSbH2YJSYNdq+JkWUR1WsvR8nOVJSNc95RG
   VWi1VR+B8TGbL7+GsnfIAJtOJbPBUPVVTkTnGvlAMKsxFscjNiCToUnOf
   xNxl8SogTQ2kPBerkZh8m54T0CVRGAiViNARPTB0D1J7c4XoiC4kLACHw
   2bMwAZWmnYHLbDpxow3g7TdyasIDCiM/f7b6q6WRcj8KhMVruV/2ae9S1
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="465647686"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="465647686"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:22:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="888277863"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="888277863"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 09:22:07 -0700
Date:   Fri, 15 Sep 2023 19:22:40 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jithu Joseph <jithu.joseph@intel.com>
cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        pengfei.xu@intel.com
Subject: Re: [PATCH 01/10] platform/x86/intel/ifs: Store IFS generation
 number
In-Reply-To: <20230913183348.1349409-2-jithu.joseph@intel.com>
Message-ID: <e7f8136d-d07a-1668-2667-d2836c7112a@linux.intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com> <20230913183348.1349409-2-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023, Jithu Joseph wrote:

> IFS generation number is reported via MSR_INTEGRITY_CAPS.

Please use more characters per line, the limit is 72 characters.

> As IFS support gets added to newer CPUs, some differences
> are expected during IFS image loading and test flows.
> 
> Define MSR bitmasks to extract and store the generation in
> driver data, so that driver can modify its MSR interaction
> appropriately.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  arch/x86/include/asm/msr-index.h      | 2 ++
>  drivers/platform/x86/intel/ifs/ifs.h  | 2 ++
>  drivers/platform/x86/intel/ifs/core.c | 2 ++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 1d111350197f..a71a86a01488 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -222,6 +222,8 @@
>  #define MSR_INTEGRITY_CAPS_ARRAY_BIST          BIT(MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT)
>  #define MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT	4
>  #define MSR_INTEGRITY_CAPS_PERIODIC_BIST	BIT(MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT)
> +#define MSR_INTEGRITY_CAPS_SAF_GEN_REV_SHIFT	9
> +#define MSR_INTEGRITY_CAPS_SAF_GEN_REV_MASK	(0x3ull << MSR_INTEGRITY_CAPS_SAF_GEN_REV_SHIFT)

GENMASK_ULL(), don't add _SHIFT at all as FIELD_GET/PREP() will handle 
it for you.

>  #define MSR_LBR_NHM_FROM		0x00000680
>  #define MSR_LBR_NHM_TO			0x000006c0
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index 93191855890f..d666aeed20fc 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -229,6 +229,7 @@ struct ifs_test_caps {
>   * @status: it holds simple status pass/fail/untested
>   * @scan_details: opaque scan status code from h/w
>   * @cur_batch: number indicating the currently loaded test file
> + * @generation: IFS test generation enumerated by hardware
>   */
>  struct ifs_data {
>  	int	loaded_version;
> @@ -238,6 +239,7 @@ struct ifs_data {
>  	int	status;
>  	u64	scan_details;
>  	u32	cur_batch;
> +	u32	generation;
>  };
>  
>  struct ifs_work {
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
> index 306f886b52d2..88d84aad9334 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -94,6 +94,8 @@ static int __init ifs_init(void)
>  	for (i = 0; i < IFS_NUMTESTS; i++) {
>  		if (!(msrval & BIT(ifs_devices[i].test_caps->integrity_cap_bit)))
>  			continue;
> +		ifs_devices[i].rw_data.generation = (msrval & MSR_INTEGRITY_CAPS_SAF_GEN_REV_MASK)
> +							>> MSR_INTEGRITY_CAPS_SAF_GEN_REV_SHIFT;

FIELD_GET(), don't forget to make sure use have the include for it.

>  		ret = misc_register(&ifs_devices[i].misc);
>  		if (ret)
>  			goto err_exit;
> 

-- 
 i.

