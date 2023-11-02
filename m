Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 792F27DE932
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 01:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbjKBAMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 20:12:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbjKBAMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 20:12:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 868C0A2
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 17:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698883957; x=1730419957;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vYfhzy8fZ7Ny+UadVkRxU8n9LN9W0p5r1y3p+Q8SM7g=;
  b=jzqwdRkz4w7SuTM8Fnpa1H6SoKL9IOCtl1TSw63TbvyrgvA9oCNxrTfF
   VPW7JJYX60g2At1dvqETokIyXDlzNqlwUxHDhJwEJY4Ke2tkt/ZDLbp2Z
   Xd1WZTh1ske/Zbc+03QF1IwLMYQQKfjo3p8iuunycn30G+6oi4Z/DVtM2
   s+qN1P9iqI27/hAJn2Ym8jcAuX35/JdhTNwT1YQdYDtXUZnZMxK7F1WD7
   bUDPRfUHGXOSl3jonglc85MAP6XF2cAXlf1sP+Oh5JcLZA+o53lIVWmyQ
   ZbM1hl1jaNojt3E06ZLg9oC/05qgOvfGr9S0oKpHFEq4MUpiRgjdkZyEJ
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="7242451"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="7242451"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 17:12:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="761091342"
X-IronPort-AV: E=Sophos;i="6.03,269,1694761200"; 
   d="scan'208";a="761091342"
Received: from bfahim-mobl1.amr.corp.intel.com (HELO box.shutemov.name) ([10.252.34.188])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 17:12:33 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 85C8110A30E; Thu,  2 Nov 2023 03:12:30 +0300 (+03)
Date:   Thu, 2 Nov 2023 03:12:30 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        Kai Huang <kai.huang@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: Add Intel TDX entry
Message-ID: <20231102001230.rxifhrrqvcndr2wy@box.shutemov.name>
References: <20231101233314.2567-1-kirill.shutemov@linux.intel.com>
 <4b05bf79-c394-4a63-b6d5-eccbdc708115@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4b05bf79-c394-4a63-b6d5-eccbdc708115@linux.intel.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 04:53:42PM -0700, Kuppuswamy Sathyanarayanan wrote:
> Hi,
> 
> On 11/1/2023 4:33 PM, Kirill A. Shutemov wrote:
> > Add myself as Intel TDX maintainer.
> > 
> > I drove upstreaming most of TDX code so far and I will continue
> > working on TDX for foreseeable future.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
> > ---
> 
> Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Thanks!

> >  MAINTAINERS | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> > 
> > diff --git a/MAINTAINERS b/MAINTAINERS
> > index 7608b714653f..1cbec6b235f9 100644
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@ -23466,6 +23466,18 @@ F:	arch/x86/kernel/dumpstack.c
> >  F:	arch/x86/kernel/stacktrace.c
> >  F:	arch/x86/kernel/unwind_*.c
> >  
> > +X86 TRUST DOMAIN EXTENSIONS (TDX)
> > +M:	Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> > +L:	x86@kernel.org
> > +L:	linux-coco@lists.linux.dev
> > +S:	Maintained
> > +T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/tdx
> > +F:	arch/x86/boot/compressed/tdx*
> > +F:	arch/x86/coco/tdx/
> > +F:	arch/x86/include/asm/shared/tdx.h
> > +F:	arch/x86/include/asm/tdx.h
> > +F:	arch/x86/virt/vmx/tdx/
> > +
> 
> Do you want to include drivers/virt/coco/tdx-guest?

Yeah, missed this one.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
