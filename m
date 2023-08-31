Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A67B178F44F
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243694AbjHaUzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:55:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233704AbjHaUzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:55:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F22D1B0;
        Thu, 31 Aug 2023 13:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693515305; x=1725051305;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=D5MKd0EognNthiZZNZN30iHIGBUfCWSvq+JGCaxbtPc=;
  b=kIQga41FJpLQUsmiLEiLTJbzFev2yLPfe65Z26hfH5sNBDe3eWXzgFaC
   uVHOav4YM5DeqqX8e9KntIW6k7dXNuzDsi9VvqDPAeHpBk30P2XoCwW6P
   zes2HzPRvOUvVGHFOChBWTNMIA/CJyERlBTsDQzPKm9G975VL7X7c1czO
   8CTTciOGX4K+D7wMDzHcU6WzpxnPPTwD0NQfMwQGtzhiJsTxVjYiF6smw
   7vpR3QFxT32528YGbZ+e2QUoK3RHj66OUQktuv7EMz2ZECmAqFaApz7bI
   zxyQHYqGYNDTLut/xkTsn/jl4ncft7no2jFHgTf8jG0NXlGxleVpgaYHV
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375998302"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="375998302"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 13:55:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="739682735"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="739682735"
Received: from folaez-mobl1.amr.corp.intel.com (HELO desk) ([10.209.111.20])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 13:55:04 -0700
Date:   Thu, 31 Aug 2023 13:54:55 -0700
From:   Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
To:     Takahiro Itazuri <itazur@amazon.com>
Cc:     linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Takahiro Itazuri <zulinx86@gmail.com>
Subject: Re: [PATCH v2] docs: Update desc of best effort mode
Message-ID: <20230831205455.ozr7iaraatcaj2ug@desk>
References: <20230831111847.71030-1-itazur@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831111847.71030-1-itazur@amazon.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 12:18:47PM +0100, Takahiro Itazuri wrote:
> Moves the description of the best effort mitigation mode to the table of
> the possible values in the mds and tsx_async_abort docs, and adds the
> same one to the mmio_stale_data doc.

I would suggest to change the subject prefix to:

docs/hw-vuln: Update desc of best effort mode

or

Documentation/hw-vuln: Update desc of best effort mode

> Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
> ---
> 
> v1 -> v2: https://lore.kernel.org/all/20230830144426.80258-1-itazur@amazon.com/
> - Puts the desc into the table of the possible values.
> 
> ---
>  Documentation/admin-guide/hw-vuln/mds.rst     | 33 ++++++++-----------
>  .../hw-vuln/processor_mmio_stale_data.rst     | 13 +++++++-
>  .../admin-guide/hw-vuln/tsx_async_abort.rst   | 32 ++++++++----------
>  3 files changed, 38 insertions(+), 40 deletions(-)
> 
> diff --git a/Documentation/admin-guide/hw-vuln/mds.rst b/Documentation/admin-guide/hw-vuln/mds.rst
> index 48ca0bd85..0fe98151a 100644
> --- a/Documentation/admin-guide/hw-vuln/mds.rst
> +++ b/Documentation/admin-guide/hw-vuln/mds.rst
> @@ -102,9 +102,19 @@ The possible values in this file are:
>       * - 'Vulnerable'
>         - The processor is vulnerable, but no mitigation enabled
>       * - 'Vulnerable: Clear CPU buffers attempted, no microcode'
> -       - The processor is vulnerable but microcode is not updated.
> -
> -         The mitigation is enabled on a best effort basis. See :ref:`vmwerv`
> +       - The processor is vulnerable but microcode is not updated. The
> +         mitigation is enabled on a best effort basis.
> +
> +         If the processor is vulnerable but the availability of the microcode
> +         based mitigation mechanism is not advertised via CPUID, the kernel
> +         selects a best effort mitigation mode. This mode invokes the mitigation
> +         instructions without a guarantee that they clear the CPU buffers.
> +
> +         This is done to address virtualization scenarios where the host has the
> +         microcode update applied, but the hypervisor is not yet updated to
> +         expose the CPUID to the guest. If the host has updated microcode the
> +         protection takes effect; otherwise a few CPU cycles are wasted
> +         pointlessly.
>       * - 'Mitigation: Clear CPU buffers'
>         - The processor is vulnerable and the CPU buffer clearing mitigation is
>           enabled.
> @@ -119,23 +129,6 @@ to the above information:
>      'SMT Host state unknown'  Kernel runs in a VM, Host SMT state unknown
>      ========================  ============================================
>  
> -.. _vmwerv:
> -
> -Best effort mitigation mode
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -
> -  If the processor is vulnerable, but the availability of the microcode based
> -  mitigation mechanism is not advertised via CPUID the kernel selects a best
> -  effort mitigation mode.  This mode invokes the mitigation instructions
> -  without a guarantee that they clear the CPU buffers.
> -
> -  This is done to address virtualization scenarios where the host has the
> -  microcode update applied, but the hypervisor is not yet updated to expose
> -  the CPUID to the guest. If the host has updated microcode the protection
> -  takes effect otherwise a few cpu cycles are wasted pointlessly.
> -
> -  The state in the mds sysfs file reflects this situation accordingly.
> -

This deletion leaves an extra newline. Same for TAA.

>  Mitigation mechanism
>  -------------------------
> diff --git a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
> index c98fd1190..1302fd1b5 100644
> --- a/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
> +++ b/Documentation/admin-guide/hw-vuln/processor_mmio_stale_data.rst
> @@ -225,8 +225,19 @@ The possible values in this file are:
>       * - 'Vulnerable'
>         - The processor is vulnerable, but no mitigation enabled
>       * - 'Vulnerable: Clear CPU buffers attempted, no microcode'
> -       - The processor is vulnerable, but microcode is not updated. The
> +       - The processor is vulnerable but microcode is not updated. The
>           mitigation is enabled on a best effort basis.
> +
> +         If the processor is vulnerable but the availability of the microcode
> +         based mitigation mechanism is not advertised via CPUID, the kernel
> +         selects a best effort mitigation mode. This mode invokes the mitigation
> +         instructions without a guarantee that they clear the CPU buffers.
> +
> +         This is done to address virtualization scenarios where the host has the
> +         microcode update applied, but the hypervisor is not yet updated to
> +         expose the CPUID to the guest. If the host has updated microcode the
> +         protection takes effect; otherwise a few CPU cycles are wasted
> +         pointlessly.
>       * - 'Mitigation: Clear CPU buffers'
>         - The processor is vulnerable and the CPU buffer clearing mitigation is
>           enabled.
> diff --git a/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst b/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
> index 014167ef8..c6400fe6b 100644
> --- a/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
> +++ b/Documentation/admin-guide/hw-vuln/tsx_async_abort.rst
> @@ -98,7 +98,19 @@ The possible values in this file are:
>     * - 'Vulnerable'
>       - The CPU is affected by this vulnerability and the microcode and kernel mitigation are not applied.
>     * - 'Vulnerable: Clear CPU buffers attempted, no microcode'
> -     - The system tries to clear the buffers but the microcode might not support the operation.
> +     - The processor is vulnerable but microcode is not updated. The
> +       mitigation is enabled on a best effort basis.
> +
> +       If the processor is vulnerable but the availability of the microcode
> +       based mitigation mechanism is not advertised via CPUID, the kernel
> +       selects a best effort mitigation mode. This mode invokes the mitigation
> +       instructions without a guarantee that they clear the CPU buffers.
> +
> +       This is done to address virtualization scenarios where the host has the
> +       microcode update applied, but the hypervisor is not yet updated to
> +       expose the CPUID to the guest. If the host has updated microcode the
> +       protection takes effect; otherwise a few CPU cycles are wasted
> +       pointlessly.
>     * - 'Mitigation: Clear CPU buffers'
>       - The microcode has been updated to clear the buffers. TSX is still enabled.
>     * - 'Mitigation: TSX disabled'
> @@ -106,24 +118,6 @@ The possible values in this file are:
>     * - 'Not affected'
>       - The CPU is not affected by this issue.
>  
> -.. _ucode_needed:
> -
> -Best effort mitigation mode
> -^^^^^^^^^^^^^^^^^^^^^^^^^^^
> -
> -If the processor is vulnerable, but the availability of the microcode-based
> -mitigation mechanism is not advertised via CPUID the kernel selects a best
> -effort mitigation mode.  This mode invokes the mitigation instructions
> -without a guarantee that they clear the CPU buffers.
> -
> -This is done to address virtualization scenarios where the host has the
> -microcode update applied, but the hypervisor is not yet updated to expose the
> -CPUID to the guest. If the host has updated microcode the protection takes
> -effect; otherwise a few CPU cycles are wasted pointlessly.
> -
> -The state in the tsx_async_abort sysfs file reflects this situation
> -accordingly.
> -

Reviewed-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
