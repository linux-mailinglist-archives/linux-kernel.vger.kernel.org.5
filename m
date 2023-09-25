Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 216327ADAFA
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 17:08:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232647AbjIYPIx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 11:08:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232674AbjIYPIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 11:08:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C492120;
        Mon, 25 Sep 2023 08:08:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695654523; x=1727190523;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=xqajMAeo9FklI77B0Q+uzt8n4v+u75LktqHbw8btNgM=;
  b=cQXeQZ9r2bvdusu/erE0OEq6A7QuVsVY7iraBF2H9GVF3u+YS86VaeRO
   pspcJyMv2eFc4fdQwgqTFFllplbA/AFPce5z9IYjCPkIhxTJId0bf4r2h
   G225Xa6Q/rxQ94F2e66VzkabDmJGSd8pnuZkvU9z6QyAhnKH3yfkWo0v7
   VTvW6Fq+VmOn7zEZfzYhOEbVtOByApj0Qmt5QCT3VojJh86t+LHW4Ih5E
   2vVUhnkmULLahH1HwHVlpdXkuN7UfBVN0Itek9rWhbKUldPzogScJcEYn
   /yR43nFEMgMYn99pH1buThc6CipYWRey9MT9jMfkkg3NCWcnD5ww/QMba
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="371596723"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="371596723"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:08:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="814007768"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="814007768"
Received: from stamengx-mobl1.ger.corp.intel.com ([10.249.32.149])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 08:08:26 -0700
Date:   Mon, 25 Sep 2023 18:08:24 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jithu Joseph <jithu.joseph@intel.com>
cc:     Hans de Goede <hdegoede@redhat.com>, markgross@kernel.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        rostedt@goodmis.org, ashok.raj@intel.com, tony.luck@intel.com,
        LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, patches@lists.linux.dev,
        ravi.v.shankar@intel.com, pengfei.xu@intel.com
Subject: Re: [PATCH v2 1/9] platform/x86/intel/ifs: Store IFS generation
 number
In-Reply-To: <20230922232606.1928026-2-jithu.joseph@intel.com>
Message-ID: <9c405d3c-3376-5a35-3a4a-62b59f764043@linux.intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com> <20230922232606.1928026-1-jithu.joseph@intel.com> <20230922232606.1928026-2-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-2019316765-1695654510=:2147"
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

--8323329-2019316765-1695654510=:2147
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 8BIT

On Fri, 22 Sep 2023, Jithu Joseph wrote:

> IFS generation number is reported via MSR_INTEGRITY_CAPS.  As IFS
> support gets added to newer CPUs, some differences are expected during
> IFS image loading and test flows.
> 
> Define MSR bitmasks to extract and store the generation in driver data,
> so that driver can modify its MSR interaction appropriately.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  arch/x86/include/asm/msr-index.h      | 1 +
>  drivers/platform/x86/intel/ifs/ifs.h  | 2 ++
>  drivers/platform/x86/intel/ifs/core.c | 3 +++
>  3 files changed, 6 insertions(+)
> 
> diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
> index 1d111350197f..838e5a013a07 100644
> --- a/arch/x86/include/asm/msr-index.h
> +++ b/arch/x86/include/asm/msr-index.h
> @@ -222,6 +222,7 @@
>  #define MSR_INTEGRITY_CAPS_ARRAY_BIST          BIT(MSR_INTEGRITY_CAPS_ARRAY_BIST_BIT)
>  #define MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT	4
>  #define MSR_INTEGRITY_CAPS_PERIODIC_BIST	BIT(MSR_INTEGRITY_CAPS_PERIODIC_BIST_BIT)
> +#define MSR_INTEGRITY_CAPS_SAF_GEN_MASK	GENMASK_ULL(10, 9)
>  
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
> index 306f886b52d2..4ff2aa4b484b 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -1,6 +1,7 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /* Copyright(c) 2022 Intel Corporation. */
>  
> +#include <linux/bitfield.h>
>  #include <linux/module.h>
>  #include <linux/kdev_t.h>
>  #include <linux/semaphore.h>
> @@ -94,6 +95,8 @@ static int __init ifs_init(void)
>  	for (i = 0; i < IFS_NUMTESTS; i++) {
>  		if (!(msrval & BIT(ifs_devices[i].test_caps->integrity_cap_bit)))
>  			continue;
> +		ifs_devices[i].rw_data.generation = FIELD_GET(MSR_INTEGRITY_CAPS_SAF_GEN_MASK,
> +							      msrval);
>  		ret = misc_register(&ifs_devices[i].misc);
>  		if (ret)
>  			goto err_exit;
> 

Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

-- 
 i.

--8323329-2019316765-1695654510=:2147--
