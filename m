Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1930B7BFDAA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 15:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232251AbjJJNhp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 09:37:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232243AbjJJNhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 09:37:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18D2C9E
        for <linux-kernel@vger.kernel.org>; Tue, 10 Oct 2023 06:37:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696945061; x=1728481061;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=XxupxmtyB6MfsqYIPevKjc8Mkmjyag2c1qs/SolrDdo=;
  b=NcaBTHCaJnFpf/KRspbxJx6yxaw7m+ElYXQS2qJDzdUimfaD8YUX88lA
   IQcYKtqqXMCM59DPKQAfCESEZufOaysmI+Cl0iMlYheIKhweR9tiGOChq
   J4P1kKwOqsDbjC9dCWAkQwR3qnMBF/XUZbczoR0n+L/zGKXfH9pOOr308
   VVIJ/Rznmgo3fA0eNQm+8bzc0VwGN7h7oZ5Qjg8vofla/qxpCBbA+Kk+P
   v5t7IDI8whCId1bbKFKjEbxcRdj4IUzJiNpf/YXTB900YoSpFq/aX3RJM
   6IcBlSy5Fe5NZKQTAfIKA+ze8B6mLS/HiZfTA7DFSnctlGt3GaIxaxOEj
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="384250793"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="384250793"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 06:36:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="747072144"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="747072144"
Received: from patinira-mobl.amr.corp.intel.com (HELO [10.212.128.216]) ([10.212.128.216])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 06:35:59 -0700
Message-ID: <dcf9317e-5557-4fe7-889c-1a02783fa894@linux.intel.com>
Date:   Tue, 10 Oct 2023 06:35:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] kernel/cpu: Add support for declaring CPU hotplug
 not supported
Content-Language: en-US
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Elena Reshetova <elena.reshetova@intel.com>,
        Jun Nakajima <jun.nakajima@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        kexec@lists.infradead.org, linux-coco@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20231005131402.14611-1-kirill.shutemov@linux.intel.com>
 <20231005131402.14611-3-kirill.shutemov@linux.intel.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <20231005131402.14611-3-kirill.shutemov@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/5/2023 6:13 AM, Kirill A. Shutemov wrote:
> The function cpu_hotplug_not_supported() can be called to indicate that
> CPU hotplug should be disabled. It does not prevent the initial bring up
> of the CPU, but it stops subsequent offlining.
> 
> This function is intended to replace CC_ATTR_HOTPLUG_DISABLED.
> 

Looks good to me.

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> ---
>  include/linux/cpu.h |  2 ++
>  kernel/cpu.c        | 17 ++++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/cpu.h b/include/linux/cpu.h
> index f19f56501809..aab3887cadbc 100644
> --- a/include/linux/cpu.h
> +++ b/include/linux/cpu.h
> @@ -132,6 +132,7 @@ extern void cpus_read_lock(void);
>  extern void cpus_read_unlock(void);
>  extern int  cpus_read_trylock(void);
>  extern void lockdep_assert_cpus_held(void);
> +extern void cpu_hotplug_not_supported(void);
>  extern void cpu_hotplug_disable(void);
>  extern void cpu_hotplug_enable(void);
>  void clear_tasks_mm_cpumask(int cpu);
> @@ -147,6 +148,7 @@ static inline void cpus_read_lock(void) { }
>  static inline void cpus_read_unlock(void) { }
>  static inline int  cpus_read_trylock(void) { return true; }
>  static inline void lockdep_assert_cpus_held(void) { }
> +static inline void cpu_hotplug_not_supported(void) { }
>  static inline void cpu_hotplug_disable(void) { }
>  static inline void cpu_hotplug_enable(void) { }
>  static inline int remove_cpu(unsigned int cpu) { return -EPERM; }
> diff --git a/kernel/cpu.c b/kernel/cpu.c
> index 6de7c6bb74ee..cf536fe1a88a 100644
> --- a/kernel/cpu.c
> +++ b/kernel/cpu.c
> @@ -484,6 +484,9 @@ static int cpu_hotplug_disabled;
>  
>  DEFINE_STATIC_PERCPU_RWSEM(cpu_hotplug_lock);
>  
> +/* Cleared if platform declares CPU hotplug not supported */
> +static bool cpu_hotplug_supported = true;
> +
>  void cpus_read_lock(void)
>  {
>  	percpu_down_read(&cpu_hotplug_lock);
> @@ -543,6 +546,18 @@ static void lockdep_release_cpus_lock(void)
>  	rwsem_release(&cpu_hotplug_lock.dep_map, _THIS_IP_);
>  }
>  
> +/*
> + * Declare CPU hotplug not supported.
> + *
> + * It doesn't prevent initial bring up of the CPU, but stops offlining.
> + */
> +void cpu_hotplug_not_supported(void)
> +{
> +	cpu_maps_update_begin();
> +	cpu_hotplug_supported = false;
> +	cpu_maps_update_done();
> +}

Since this function is not used in this patch, do you need to add __maybe_unused to
avoid warnings?

> +
>  /*
>   * Wait for currently running CPU hotplug operations to complete (if any) and
>   * disable future CPU hotplug (from sysfs). The 'cpu_add_remove_lock' protects
> @@ -1507,7 +1522,7 @@ static int cpu_down_maps_locked(unsigned int cpu, enum cpuhp_state target)
>  	 * If the platform does not support hotplug, report it explicitly to
>  	 * differentiate it from a transient offlining failure.
>  	 */
> -	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED))
> +	if (cc_platform_has(CC_ATTR_HOTPLUG_DISABLED) || !cpu_hotplug_supported)
>  		return -EOPNOTSUPP;
>  	if (cpu_hotplug_disabled)
>  		return -EBUSY;

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
