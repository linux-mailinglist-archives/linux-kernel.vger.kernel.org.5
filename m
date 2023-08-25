Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44ABF78927A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Aug 2023 01:41:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231346AbjHYXkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 19:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231423AbjHYXkF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 19:40:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 293182681
        for <linux-kernel@vger.kernel.org>; Fri, 25 Aug 2023 16:39:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693006793; x=1724542793;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fQe2t7QIBBTrp2qK/3y01SE8FftuPfFVvktkv9ZzpsE=;
  b=PEOSHOj/bUIBtfxd9Rcgu0Hsq83ztImJ+lUYoo89rqxtH5Q2oMZ2lXu0
   aVyMM9cQ/561It73HkHmB0riFGZ3AB4VzudRPc2oYs7ziipklOarm1OhD
   U37NKY+zSK6Q+x+JkLeRhcYJmqg/ztpA93lv17JTUq43Da1TnEpSrhRB5
   /heIYupDvZ8Pdiqn0kJMwFiNhNK9l1fi/gdg+Psi5dsvX76JXizn0dnEs
   IWmPQ885j57ETp1RRby2jh94zKWms6eKLQFxGPs+V/pTD/SCfipuWLvhP
   AdfsRNM/ADtecRT7Dp1+I+edYhvITOYdrvt3xv11RrPP/K5uX+nzERln+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="355156596"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="355156596"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 16:37:00 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10813"; a="807689884"
X-IronPort-AV: E=Sophos;i="6.02,202,1688454000"; 
   d="scan'208";a="807689884"
Received: from naikshri-mobl7.ger.corp.intel.com (HELO box.shutemov.name) ([10.249.41.113])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 16:36:57 -0700
Received: by box.shutemov.name (Postfix, from userid 1000)
        id A4130109FED; Sat, 26 Aug 2023 02:36:49 +0300 (+03)
Date:   Sat, 26 Aug 2023 02:36:49 +0300
From:   kirill.shutemov@linux.intel.com
To:     Kai Huang <kai.huang@intel.com>
Cc:     peterz@infradead.org, linux-kernel@vger.kernel.org,
        dave.hansen@intel.com, tglx@linutronix.de, bp@alien8.de,
        mingo@redhat.com, hpa@zytor.com, x86@kernel.org, seanjc@google.com,
        pbonzini@redhat.com, isaku.yamahata@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com,
        n.borisov.lkml@gmail.com
Subject: Re: [PATCH v4 06/12] x86/tdx: Extend TDX_MODULE_CALL to support more
 TDCALL/SEAMCALL leafs
Message-ID: <20230825233649.7afqlopjjmerym3d@box>
References: <cover.1692096753.git.kai.huang@intel.com>
 <d4785de7c392f7c5684407f6c24a73b92148ec49.1692096753.git.kai.huang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d4785de7c392f7c5684407f6c24a73b92148ec49.1692096753.git.kai.huang@intel.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 15, 2023 at 11:02:00PM +1200, Kai Huang wrote:
> Cc: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>

Cc on me is redundant.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
