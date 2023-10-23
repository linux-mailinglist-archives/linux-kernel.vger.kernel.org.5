Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFDB67D3AA9
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Oct 2023 17:25:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231672AbjJWPZw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Oct 2023 11:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjJWPZt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Oct 2023 11:25:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A34A103;
        Mon, 23 Oct 2023 08:25:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698074747; x=1729610747;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=NgDpzqQTC3ic3dX8yIQLqGn1RA2nSeerJwpaVTSsnPw=;
  b=JlTKuu/Xafb1LACObj/24kC8dfrGllnl5KVPMwgxshhgFowXmwTHUKEm
   SElXIFPv7xkeKS+p451zueXzO5wOzLKhRPXch/x2vLVcbUYzSVadcD6zb
   Zwwc6JQvHs5ki28jCse8g2DhNP+ezZCHRN2fhi7rzVRxcjqeEWx15TBgN
   rgtHnWNgnQQQ+PNZlMC2nL8FOGEBwYSEI8wRkdQfgNW7+zJf4T+lE8e1r
   wI7BT2ivs7ruFx+nDpLWQSwfnorRlvAmIA7nsD/8YzS9P3OTiKSZQ2BqL
   v7BpulERddW0AOpjG8IsXMwSgLULlrM3vtN3n3l+YEGEklLuHHMbtNYXu
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="451089825"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="451089825"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 08:25:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10872"; a="758162231"
X-IronPort-AV: E=Sophos;i="6.03,244,1694761200"; 
   d="scan'208";a="758162231"
Received: from foliveix-mobl5.amr.corp.intel.com ([10.251.211.194])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Oct 2023 08:25:44 -0700
Date:   Mon, 23 Oct 2023 18:25:41 +0300 (EEST)
From:   =?ISO-8859-15?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     "David E. Box" <david.e.box@linux.intel.com>
cc:     LKML <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org, dave.hansen@linux.intel.com,
        arnd@arndb.de, peterz@infradead.org, aleksander.lobakin@intel.com,
        rajvi.jingar@linux.intel.com
Subject: Re: [PATCH V4 10/17] linux/io.h: iounmap/ioport_unmap cleanup.h
 support
In-Reply-To: <20231018231624.1044633-11-david.e.box@linux.intel.com>
Message-ID: <2183ee3-cfd7-f8f1-cd6c-b24e5fa97075@linux.intel.com>
References: <20231018231624.1044633-1-david.e.box@linux.intel.com> <20231018231624.1044633-11-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="8323329-592939299-1698074746=:1721"
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--8323329-592939299-1698074746=:1721
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 18 Oct 2023, David E. Box wrote:

> Add auto-release cleanups for ioumap and ioport_unmap.

ioumap -> iounmap

Add () into function names.

-- 
 i.


> 
> Suggested-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> Signed-off-by: David E. Box <david.e.box@linux.intel.com>
> ---
> V4 - New patch
> 
>  include/linux/io.h | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/include/linux/io.h b/include/linux/io.h
> index 7304f2a69960..1488832c4ad2 100644
> --- a/include/linux/io.h
> +++ b/include/linux/io.h
> @@ -6,6 +6,7 @@
>  #ifndef _LINUX_IO_H
>  #define _LINUX_IO_H
>  
> +#include <linux/cleanup.h>
>  #include <linux/types.h>
>  #include <linux/init.h>
>  #include <linux/bug.h>
> @@ -20,6 +21,9 @@ __visible void __iowrite32_copy(void __iomem *to, const void *from, size_t count
>  void __ioread32_copy(void *to, const void __iomem *from, size_t count);
>  void __iowrite64_copy(void __iomem *to, const void *from, size_t count);
>  
> +DEFINE_FREE(iounmap, void __iomem *, iounmap(_T));
> +DEFINE_FREE(ioport_unmap, void __iomem *, ioport_unmap(_T));
> +
>  #ifdef CONFIG_MMU
>  int ioremap_page_range(unsigned long addr, unsigned long end,
>  		       phys_addr_t phys_addr, pgprot_t prot);
> 

--8323329-592939299-1698074746=:1721--
