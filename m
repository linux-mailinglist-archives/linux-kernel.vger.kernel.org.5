Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A786779F5D6
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 02:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232896AbjINAXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Sep 2023 20:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjINAXu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Sep 2023 20:23:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AF25E4B
        for <linux-kernel@vger.kernel.org>; Wed, 13 Sep 2023 17:23:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694651026; x=1726187026;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ibRPzuTs9RlH2bygxH3UxKliLnlVLu0fWmJh4zT8MoQ=;
  b=Qoe/gzvIEHOKGH9akbYmZV5gG/pnRsUgqNgHpL9gqjl6TapB8Htz8iZV
   5I5tR+MyK8+8qSekafX4knq6gxMdkMuRitFA7pPQB4Bp7Ob3xfUo72xjs
   Ob9JX7cHxbTLy37zBnHcpG+BHqlYH8bAIQlq7zgzfhN9XfQhY0Ueqx7aH
   xm6wDqXMbPggZCFdCZaLnFQ6hVFSsDI0X1WoPiXtQKlXzhjz8eYe35G18
   IZoUDq3v/yZ81hYZcXtEHSGbDW80L7N1KegWL20oFZ5ct2oeM4BLgShdg
   vGkNx2MmfkYPbzSgPuRNC9GAS2CbD1rkPfthYktkYrGD857ai8fAAUIcP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="377726434"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="377726434"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 17:23:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10832"; a="747522457"
X-IronPort-AV: E=Sophos;i="6.02,144,1688454000"; 
   d="scan'208";a="747522457"
Received: from ls.sc.intel.com (HELO localhost) ([172.25.112.31])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Sep 2023 17:23:26 -0700
Date:   Wed, 13 Sep 2023 17:23:25 -0700
From:   Isaku Yamahata <isaku.yamahata@linux.intel.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     "Huang, Kai" <kai.huang@intel.com>,
        "kirill.shutemov@linux.intel.com" <kirill.shutemov@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "Christopherson,, Sean" <seanjc@google.com>,
        "bp@alien8.de" <bp@alien8.de>, "x86@kernel.org" <x86@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "Yamahata, Isaku" <isaku.yamahata@intel.com>,
        "n.borisov.lkml@gmail.com" <n.borisov.lkml@gmail.com>,
        isaku.yamahata@linux.intel.com
Subject: Re: [PATCH v4 00/12] Unify TDCALL/SEAMCALL and TDVMCALL assembly
Message-ID: <20230914002325.GD3638268@ls.amr.corp.intel.com>
References: <cover.1692096753.git.kai.huang@intel.com>
 <a64122a6-0be1-8263-4629-8cae0c013305@redhat.com>
 <f94aa81502421f169806c1349efb28c74878ea46.camel@intel.com>
 <BL1PR11MB5978F08618A3E2389618F33CF7F1A@BL1PR11MB5978.namprd11.prod.outlook.com>
 <e95c3a61-45bf-40f7-1f5a-67e1b7e64db4@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <e95c3a61-45bf-40f7-1f5a-67e1b7e64db4@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 03:37:49PM +0200,
Paolo Bonzini <pbonzini@redhat.com> wrote:

> On 9/12/23 02:57, Huang, Kai wrote:
> > > > +#include <asm/tdx.h>
> > > > 
> > > > #include <asm-generic/asm-prototypes.h>
> > > > 
> > > Thanks Paolo!
> > > 
> > > I never met this issue, not even from LKP.  Do you happen to know
> > > which Kconfig option can trigger this?  Or would you mind sharing
> > > your .config?
> > (replying via outlook due to some networking issue of my home
> > network)
> > 
> > After digging, this is due to exporting __seamcall*() assembly
> > functions while MODVERSIONS is enabled.
> > 
> > This series itself doesn't cause this warning.
> > 
> > I didn't export them in this series because I would like to leave to
> > KVM patches when we are sure we need to export them.
> > 
> > E.g., I have seamcall*() wrappers to retry running out of entropy,
> > and we may have concern exporting __seamcall*() low level functions
> > directly and may wish to export higher level wrappers.
> > 
> > So I think the fix should be with the patch that truly exports those
> > __seamcall*().  I'll talk to Isaku on this to get his idea.
> 
> Ah indeed it's not caused by your patches, but rather by the Isaku's KVM TDX
> support ("KVM: TDX: Add C wrapper functions for SEAMCALLs to the TDX
> module").  The fix is just to squash the #include into his patch.

Yes, I'll squash the fix into the patch.
-- 
Isaku Yamahata <isaku.yamahata@linux.intel.com>
