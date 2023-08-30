Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9828978E101
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 22:53:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240375AbjH3UxB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 16:53:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240241AbjH3Uw7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 16:52:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9FEB1A6
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 13:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693428752; x=1724964752;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=79CUxP1wTyhPFDGLZ7ap/sNFWMyiamUP+nlrb3cclew=;
  b=frljazfoay6yUNZ/2wAZbcs2xY28QT8ut7sfbkBPdG8UtSzLkdW+2yAZ
   r5IuBtc+pVbfV8Zc8pD41u7wlejtytBxFOl3nZldhdPm0DB/RFs7BXfld
   AMQ6t73FfbYdYQpB4W+TkUGoyqjCBtsClV4oOcrfekP0bSmzOe1OvDp/2
   vbdYf8TLzR8stWkeSpMIVNLqFHKK/ILh/Fbgq9zylm8hFnZkmzDO4Yvxp
   2Bbw24GAlOBvOlT1uLgqYpF0U7J456NiJs+TwoVBu1wyAlGIC0rYvqkzu
   1jtm+LY46RBIbXtRuW8pXfr5cmVF6OkpgGfTnF3UdEAJcQXv5wiauN0ao
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="378462294"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="378462294"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 13:48:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10818"; a="742383278"
X-IronPort-AV: E=Sophos;i="6.02,214,1688454000"; 
   d="scan'208";a="742383278"
Received: from asehgal1-mobl.amr.corp.intel.com (HELO [10.212.136.74]) ([10.212.136.74])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Aug 2023 13:48:55 -0700
Message-ID: <2225b58f-2894-403e-9e6e-4827383b87c6@linux.intel.com>
Date:   Wed, 30 Aug 2023 13:48:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/5] virt: coco: Add a coco/Makefile and coco/Kconfig
Content-Language: en-US
To:     Dan Williams <dan.j.williams@intel.com>, linux-coco@lists.linux.dev
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        tglx@linutronix.de
References: <169342399185.3934343.3035845348326944519.stgit@dwillia2-xfh.jf.intel.com>
 <169342399880.3934343.12969478676791150366.stgit@dwillia2-xfh.jf.intel.com>
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <169342399880.3934343.12969478676791150366.stgit@dwillia2-xfh.jf.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/30/2023 12:33 PM, Dan Williams wrote:
> In preparation for adding another coco build target, relieve
> drivers/virt/Makefile of the responsibility to track new compilation
> unit additions to drivers/virt/coco/, and do the same for
> drivers/virt/Kconfig.
> 
> Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> ---

Looks good to me

Reviewed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

>  drivers/virt/Kconfig       |    6 +-----
>  drivers/virt/Makefile      |    4 +---
>  drivers/virt/coco/Kconfig  |    9 +++++++++
>  drivers/virt/coco/Makefile |    7 +++++++
>  4 files changed, 18 insertions(+), 8 deletions(-)
>  create mode 100644 drivers/virt/coco/Kconfig
>  create mode 100644 drivers/virt/coco/Makefile
> 
> diff --git a/drivers/virt/Kconfig b/drivers/virt/Kconfig
> index f79ab13a5c28..40129b6f0eca 100644
> --- a/drivers/virt/Kconfig
> +++ b/drivers/virt/Kconfig
> @@ -48,10 +48,6 @@ source "drivers/virt/nitro_enclaves/Kconfig"
>  
>  source "drivers/virt/acrn/Kconfig"
>  
> -source "drivers/virt/coco/efi_secret/Kconfig"
> -
> -source "drivers/virt/coco/sev-guest/Kconfig"
> -
> -source "drivers/virt/coco/tdx-guest/Kconfig"
> +source "drivers/virt/coco/Kconfig"
>  
>  endif
> diff --git a/drivers/virt/Makefile b/drivers/virt/Makefile
> index e9aa6fc96fab..f29901bd7820 100644
> --- a/drivers/virt/Makefile
> +++ b/drivers/virt/Makefile
> @@ -9,6 +9,4 @@ obj-y				+= vboxguest/
>  
>  obj-$(CONFIG_NITRO_ENCLAVES)	+= nitro_enclaves/
>  obj-$(CONFIG_ACRN_HSM)		+= acrn/
> -obj-$(CONFIG_EFI_SECRET)	+= coco/efi_secret/
> -obj-$(CONFIG_SEV_GUEST)		+= coco/sev-guest/
> -obj-$(CONFIG_INTEL_TDX_GUEST)	+= coco/tdx-guest/
> +obj-y				+= coco/
> diff --git a/drivers/virt/coco/Kconfig b/drivers/virt/coco/Kconfig
> new file mode 100644
> index 000000000000..fc5c64f04c4a
> --- /dev/null
> +++ b/drivers/virt/coco/Kconfig
> @@ -0,0 +1,9 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Confidential computing related collateral
> +#
> +source "drivers/virt/coco/efi_secret/Kconfig"
> +
> +source "drivers/virt/coco/sev-guest/Kconfig"
> +
> +source "drivers/virt/coco/tdx-guest/Kconfig"
> diff --git a/drivers/virt/coco/Makefile b/drivers/virt/coco/Makefile
> new file mode 100644
> index 000000000000..55302ef719ad
> --- /dev/null
> +++ b/drivers/virt/coco/Makefile
> @@ -0,0 +1,7 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Confidential computing related collateral
> +#
> +obj-$(CONFIG_EFI_SECRET)	+= efi_secret/
> +obj-$(CONFIG_SEV_GUEST)		+= sev-guest/
> +obj-$(CONFIG_INTEL_TDX_GUEST)	+= tdx-guest/
> 
> 

-- 
Sathyanarayanan Kuppuswamy
Linux Kernel Developer
