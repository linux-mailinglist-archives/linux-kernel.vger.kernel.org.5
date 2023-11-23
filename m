Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA9E17F617A
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:30:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345784AbjKWOaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345736AbjKWOaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:30:24 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D62B9;
        Thu, 23 Nov 2023 06:30:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700749830; x=1732285830;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=GOtJ/wPUcjOXSBk7IRQC4DD2WhaZ57quY1cxcixvzmw=;
  b=WQPdD5jpJ5VpeXbj1PeyepxUNSvl33+RIsLezS0Q1xdItJs9n6Ie2sft
   1BPBXErLFbFVWzXX86aNajnZXEPUoP7k7HXjmCj/8iu8ASQqRV6xpKC3g
   SBz5DNAc7BGyrOTpZpWfVZjrWjsP3WUuqFX9MonfA7KVaKpwsgZhlLO2K
   Ucd93Ny54vY+ba7J/1KmoxrYqHbch4vF/xSLQ3eP2sLXjGkiLHZnmn7io
   62caroeYZezXEUH2JcNI7uSvFMfsNzZZ3ngQB6+u4mPH7Fsbh6CZBwO4U
   t79uWOphJLc6j01VjmkvyKZPG7LUpNdbQcAFuYVj3cbKSmRKZNq76B9LH
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="382678115"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="382678115"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 06:30:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="717071779"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="717071779"
Received: from mstrobel-mobl.ger.corp.intel.com ([10.252.40.70])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 06:30:28 -0800
Date:   Thu, 23 Nov 2023 16:30:25 +0200 (EET)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, rajvi.jingar@linux.intel.com,
        dave.hansen@linux.intel.com, peterz@infradead.org
Subject: Re: [PATCH V5 12/20] asm-generic/io.h: iounmap/ioport_unmap cleanup.h
 support
In-Reply-To: <20231123040355.82139-13-david.e.box@linux.intel.com>
Message-ID: <f83e4a40-314-d279-75e6-17ad83501982@linux.intel.com>
References: <20231123040355.82139-1-david.e.box@linux.intel.com> <20231123040355.82139-13-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-872993958-1700749829=:1676"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-872993958-1700749829=:1676
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 22 Nov 2023, David E. Box wrote:

> Add auto-release cleanups for iounmap() and ioport_unmap().
> 
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
> V2 - Move from linux/io.h to asm-generic/io.h. Adds iounmap cleanup if
>      iounmap() is defined. Adds ioport_unmap cleanup if CONFIG_IOPORT_MAP
>      is defined.
> 
>  include/asm-generic/io.h | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
> index bac63e874c7b..9ef0332490b1 100644
> --- a/include/asm-generic/io.h
> +++ b/include/asm-generic/io.h
> @@ -8,6 +8,7 @@
>  #define __ASM_GENERIC_IO_H
>  
>  #include <asm/page.h> /* I/O is all done through memory accesses */
> +#include <linux/cleanup.h>
>  #include <linux/string.h> /* for memset() and memcpy() */
>  #include <linux/types.h>
>  #include <linux/instruction_pointer.h>
> @@ -1065,6 +1066,10 @@ static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
>  #endif
>  #endif /* !CONFIG_MMU || CONFIG_GENERIC_IOREMAP */
>  
> +#ifdef iounmap
> +DEFINE_FREE(iounmap, void __iomem *, iounmap(_T));
> +#endif
> +
>  #ifndef ioremap_wc
>  #define ioremap_wc ioremap
>  #endif
> @@ -1127,6 +1132,7 @@ static inline void ioport_unmap(void __iomem *p)
>  extern void __iomem *ioport_map(unsigned long port, unsigned int nr);
>  extern void ioport_unmap(void __iomem *p);
>  #endif /* CONFIG_GENERIC_IOMAP */
> +DEFINE_FREE(ioport_unmap, void __iomem *, ioport_unmap(_T));
>  #endif /* CONFIG_HAS_IOPORT_MAP */
>  
>  #ifndef CONFIG_GENERIC_IOMAP

Has this now built successfully with LKP? (I don't think we get success 
notifications from LKP for patch submissions, only failures).

There were some odd errors last time but I think all they were unrelated 
to this change (besides the checkpatch false positive, I mean).

-- 
 i.

--8323329-872993958-1700749829=:1676--
