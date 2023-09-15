Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F0D27A2443
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Sep 2023 19:06:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235229AbjIORFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Sep 2023 13:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235499AbjIORFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Sep 2023 13:05:22 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56DE72724;
        Fri, 15 Sep 2023 10:04:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694797494; x=1726333494;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=aysai3SOeuDv7ALo+1RgOm9eYqO3zsn50ZmfVEljzUI=;
  b=NKSO3qyIygezQpJlG2PXbOO0emrhvk3IMGKXDpbVUL4apwpmR5Hu7+Ts
   JAKk2ge85Rq/ehieMuq5BRnJWdgNqjQWQPOkyjgG0Bsdv2bd6lHC6ir15
   sqAJo6JVmApGyCdckVnq+TJZBj1Th4r/2MQ2JUfBw5qsO+JlEqS7KIt7i
   AM5UdAuJeTRRY91I8NeNoP112Nic5IcEMP4vyIqGeON8M61R36wdf+86D
   OFjJhu2qKVmUUs5PD+UtdpFLNALw4n2IcF8wNJN1zU7YAw7fBzwB+jTyK
   y06WeP29E8YK7QpN888czRJORCgsjx2c5XVjq+Pjdl2NSrAw8AHTlll8F
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="379218163"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="379218163"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 10:04:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10834"; a="1075855824"
X-IronPort-AV: E=Sophos;i="6.02,149,1688454000"; 
   d="scan'208";a="1075855824"
Received: from srdoo-mobl1.ger.corp.intel.com ([10.252.38.99])
  by fmsmga005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Sep 2023 10:04:12 -0700
Date:   Fri, 15 Sep 2023 20:04:09 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jithu Joseph <jithu.joseph@intel.com>
cc:     hdegoede@redhat.com, markgross@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        x86@kernel.org, hpa@zytor.com, rostedt@goodmis.org,
        ashok.raj@intel.com, tony.luck@intel.com,
        linux-kernel@vger.kernel.org, platform-driver-x86@vger.kernel.org,
        patches@lists.linux.dev, ravi.v.shankar@intel.com,
        pengfei.xu@intel.com
Subject: Re: [PATCH 10/10] platform/x86/intel/ifs: ARRAY BIST for Sierra
 Forest
In-Reply-To: <20230913183348.1349409-11-jithu.joseph@intel.com>
Message-ID: <cabbda89-f89f-aa75-d661-c8d5f6cc5d93@linux.intel.com>
References: <20230913183348.1349409-1-jithu.joseph@intel.com> <20230913183348.1349409-11-jithu.joseph@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 13 Sep 2023, Jithu Joseph wrote:

> Array BIST MSR addresses, bit definition and semantics
> are different for Sierra Forest. Branch into a separate
> Array BIST flow on Sierra Forest when user invokes Array Test.
> 
> Signed-off-by: Jithu Joseph <jithu.joseph@intel.com>
> Reviewed-by: Tony Luck <tony.luck@intel.com>
> Tested-by: Pengfei Xu <pengfei.xu@intel.com>
> ---
>  drivers/platform/x86/intel/ifs/ifs.h     |  4 +++
>  drivers/platform/x86/intel/ifs/core.c    | 15 +++++-----
>  drivers/platform/x86/intel/ifs/runtest.c | 37 +++++++++++++++++++++++-
>  3 files changed, 48 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/platform/x86/intel/ifs/ifs.h b/drivers/platform/x86/intel/ifs/ifs.h
> index 3265a6d8a6f3..2f20588a71f1 100644
> --- a/drivers/platform/x86/intel/ifs/ifs.h
> +++ b/drivers/platform/x86/intel/ifs/ifs.h
> @@ -137,6 +137,8 @@
>  #define MSR_CHUNKS_AUTHENTICATION_STATUS	0x000002c5
>  #define MSR_ACTIVATE_SCAN			0x000002c6
>  #define MSR_SCAN_STATUS				0x000002c7
> +#define MSR_ARRAY_TRIGGER			0x000002d6
> +#define MSR_ARRAY_STATUS			0x000002d7
>  #define MSR_SAF_CTRL				0x000004f0
>  
>  #define SCAN_NOT_TESTED				0
> @@ -270,6 +272,7 @@ struct ifs_test_caps {
>   * @cur_batch: number indicating the currently loaded test file
>   * @generation: IFS test generation enumerated by hardware
>   * @chunk_size: size of a test chunk
> + * @array_gen: test generation of array test
>   */
>  struct ifs_data {
>  	int	loaded_version;
> @@ -281,6 +284,7 @@ struct ifs_data {
>  	u32	cur_batch;
>  	u32	generation;
>  	u32	chunk_size;
> +	u32	array_gen;
>  };
>  
>  struct ifs_work {
> diff --git a/drivers/platform/x86/intel/ifs/core.c b/drivers/platform/x86/intel/ifs/core.c
> index 0938bfbd9086..e8b570930c16 100644
> --- a/drivers/platform/x86/intel/ifs/core.c
> +++ b/drivers/platform/x86/intel/ifs/core.c
> @@ -10,16 +10,16 @@
>  
>  #include "ifs.h"
>  
> -#define X86_MATCH(model)				\
> +#define X86_MATCH(model, array_gen)				\
>  	X86_MATCH_VENDOR_FAM_MODEL_FEATURE(INTEL, 6,	\
> -		INTEL_FAM6_##model, X86_FEATURE_CORE_CAPABILITIES, NULL)
> +		INTEL_FAM6_##model, X86_FEATURE_CORE_CAPABILITIES, array_gen)
>  
>  static const struct x86_cpu_id ifs_cpu_ids[] __initconst = {
> -	X86_MATCH(SAPPHIRERAPIDS_X),
> -	X86_MATCH(EMERALDRAPIDS_X),
> -	X86_MATCH(GRANITERAPIDS_X),
> -	X86_MATCH(GRANITERAPIDS_D),
> -	X86_MATCH(ATOM_CRESTMONT_X),
> +	X86_MATCH(SAPPHIRERAPIDS_X, 0),
> +	X86_MATCH(EMERALDRAPIDS_X, 0),
> +	X86_MATCH(GRANITERAPIDS_X, 0),
> +	X86_MATCH(GRANITERAPIDS_D, 0),
> +	X86_MATCH(ATOM_CRESTMONT_X, 1),
>  	{}
>  };
>  MODULE_DEVICE_TABLE(x86cpu, ifs_cpu_ids);
> @@ -99,6 +99,7 @@ static int __init ifs_init(void)
>  			continue;
>  		ifs_devices[i].rw_data.generation = (msrval & MSR_INTEGRITY_CAPS_SAF_GEN_REV_MASK)
>  							>> MSR_INTEGRITY_CAPS_SAF_GEN_REV_SHIFT;
> +		ifs_devices[i].rw_data.array_gen = (u32)m->driver_data;
>  		ret = misc_register(&ifs_devices[i].misc);
>  		if (ret)
>  			goto err_exit;
> diff --git a/drivers/platform/x86/intel/ifs/runtest.c b/drivers/platform/x86/intel/ifs/runtest.c
> index 997d2f07aa0c..9cfd5c015cb2 100644
> --- a/drivers/platform/x86/intel/ifs/runtest.c
> +++ b/drivers/platform/x86/intel/ifs/runtest.c
> @@ -327,6 +327,38 @@ static void ifs_array_test_core(int cpu, struct device *dev)
>  		ifsd->status = SCAN_TEST_PASS;
>  }
>  
> +#define ARRAY_GEN1_TEST_ALL_ARRAYS	(0x0ULL)
> +#define ARRAY_GEN1_STATUS_FAIL		(0x1ULL)

Unnecessary parenthesis

> +static int do_array_test_gen1(void *status)
> +{
> +	int cpu = smp_processor_id();
> +	int first;
> +
> +	first = cpumask_first(cpu_smt_mask(cpu));
> +
> +	if (cpu == first) {
> +		wrmsrl(MSR_ARRAY_TRIGGER, ARRAY_GEN1_TEST_ALL_ARRAYS);
> +		rdmsrl(MSR_ARRAY_STATUS, *((u64 *)status));
> +	}
> +
> +	return 0;
> +}
> +
> +static void ifs_array_test_gen1(int cpu, struct device *dev)
> +{
> +	struct ifs_data *ifsd = ifs_get_data(dev);
> +	u64	status = 0;

Just use space instead of tab.

> +
> +	stop_core_cpuslocked(cpu, do_array_test_gen1, &status);
> +	ifsd->scan_details = status;
> +
> +	if (status & ARRAY_GEN1_STATUS_FAIL)
> +		ifsd->status = SCAN_TEST_FAIL;
> +	else
> +		ifsd->status = SCAN_TEST_PASS;
> +}
> +
>  /*
>   * Initiate per core test. It wakes up work queue threads on the target cpu and
>   * its sibling cpu. Once all sibling threads wake up, the scan test gets executed and
> @@ -354,7 +386,10 @@ int do_core_test(int cpu, struct device *dev)
>  		ifs_test_core(cpu, dev);
>  		break;
>  	case IFS_TYPE_ARRAY_BIST:
> -		ifs_array_test_core(cpu, dev);
> +		if (ifsd->array_gen == 0)
> +			ifs_array_test_core(cpu, dev);
> +		else
> +			ifs_array_test_gen1(cpu, dev);
>  		break;
>  	default:
>  		return -EINVAL;
> 

-- 
 i.

