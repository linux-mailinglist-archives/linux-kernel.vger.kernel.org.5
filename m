Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 136687F6123
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Nov 2023 15:11:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345723AbjKWOLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Nov 2023 09:11:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345696AbjKWOLP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Nov 2023 09:11:15 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C4C6D47;
        Thu, 23 Nov 2023 06:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700748682; x=1732284682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T+S1rlzshvZ8ftnOlxHsPUzLeZYI4iqYxRU8oFrLAWM=;
  b=VIMNKYcezkSS2StDkb+38iNhfWuVPHBmKtd2W+OfhhNbKJ901fEyuh+A
   1iUXvrW4N/zvTp/o13Uiu9GMIATtsVOXBNwEcNhk9iImSEm1fuCP8Xsxt
   aZT5YZFZXm8Y1kbSxDVLvtfqChU74iRuKqqn0xNwWJo08wLfsRoPsCnbh
   gvkZ8b4f6gvYvS+oMyz+JxuWqb6K6GTNKam+FRbRFr7lGI0rdnRt2OIHO
   euFG0kI+r/RwEQco4XKAuNCbgEoLV/B/QM4AIxW14szEUh0PzRs6TspIu
   cVEzT3nVSNPA9IUcm0e3iy4FjGpPfn8YiVqfSpOJ+aHpzpEH85s5vmFGg
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="423404280"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="423404280"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 06:11:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="760670680"
X-IronPort-AV: E=Sophos;i="6.04,221,1695711600"; 
   d="scan'208";a="760670680"
Received: from ckochhof-mobl.ger.corp.intel.com (HELO box.shutemov.name) ([10.252.58.117])
  by orsmga007-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Nov 2023 06:11:16 -0800
Received: by box.shutemov.name (Postfix, from userid 1000)
        id 8D51C10A38A; Thu, 23 Nov 2023 17:11:13 +0300 (+03)
Date:   Thu, 23 Nov 2023 17:11:13 +0300
From:   "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Michael Kelley <mhkelley58@gmail.com>,
        Nikolay Borisov <nik.borisov@suse.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tom Lendacky <thomas.lendacky@amd.com>, x86@kernel.org,
        Dexuan Cui <decui@microsoft.com>, linux-hyperv@vger.kernel.org,
        stefan.bader@canonical.com, tim.gardner@canonical.com,
        roxana.nicolescu@canonical.com, cascardo@canonical.com,
        kys@microsoft.com, haiyangz@microsoft.com, wei.liu@kernel.org,
        sashal@kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v1 3/3] x86/tdx: Provide stub tdx_accept_memory() for
 non-TDX configs
Message-ID: <20231123141113.l3kwputphhj3hxub@box.shutemov.name>
References: <20231122170106.270266-1-jpiotrowski@linux.microsoft.com>
 <20231122170106.270266-3-jpiotrowski@linux.microsoft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122170106.270266-3-jpiotrowski@linux.microsoft.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 06:01:06PM +0100, Jeremi Piotrowski wrote:
> When CONFIG_INTEL_TDX_GUEST is not defined but CONFIG_UNACCEPTED_MEMORY=y is,
> the kernel fails to link with an undefined reference to tdx_accept_memory from
> arch_accept_memory. Provide a stub for tdx_accept_memory to fix the build for
> that configuration.
> 
> CONFIG_UNACCEPTED_MEMORY is also selected by CONFIG_AMD_MEM_ENCRYPT, and there
> are stubs for snp_accept_memory for when it is not defined. Previously this did
> not result in an error when CONFIG_INTEL_TDX_GUEST was not defined because the
> branch that references tdx_accept_memory() was being discarded due to
> DISABLE_TDX_GUEST being set.

And who unsets it now?

-- 
  Kiryl Shutsemau / Kirill A. Shutemov
