Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F8827F4A20
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 16:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343723AbjKVPUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 10:20:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229634AbjKVPUM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 10:20:12 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 635CE1B9;
        Wed, 22 Nov 2023 07:20:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700666409; x=1732202409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=aSKcICh48rp5vFNFfBA5X+u+RnnJ1IEAt0fGGCIvPuY=;
  b=gjazjEdNYutGEbbBPPa2KN6q79FIz8fG5Nk05zxhmgVf5I6Ur/19AVfl
   1DpGpgAXWk1/PFcXKdsm8s9QPgZT9I+kr2NOmYQZQtX+jq2Z7wmDgO9HP
   HLYScGkfF+MQ3WLZZgo293r9OFkfhzG9BKskwkz81HBtsJots7PD1zN4Z
   ByjeJyivu6ynVw+jgZZRQJYmcZgZAcMeehbYeMJKbryjOmOIojDb9My56
   z0rprSbQxY0dbeb7+S5PQu/kFc16wGCnhBZU+QHT+/0/KZ7K75vQzIpXc
   DaAyVHzvbDMKO8nZMXRg0RCnlD22D+Trb/5eUwpXpD1L27RID0U7GqAVM
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="10738263"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="10738263"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 07:20:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="910850391"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="910850391"
Received: from fdefranc-mobl3.ger.corp.intel.com (HELO fdefranc-mobl3.localnet) ([10.213.13.75])
  by fmsmga001-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 07:20:05 -0800
From:   "Fabio M. De Francesco" <fabio.maria.de.francesco@linux.intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Fabio De Francesco <fabio.maria.de.francesco@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Signed-off-by missing for commit in the mm tree
Date:   Wed, 22 Nov 2023 16:20:02 +0100
Message-ID: <4884533.31r3eYUQgx@fdefranc-mobl3>
Organization: intel
In-Reply-To: <20231121083951.5b314a98@canb.auug.org.au>
References: <20231121083951.5b314a98@canb.auug.org.au>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 20 November 2023 22:39:51 CET Stephen Rothwell wrote:
> Hi all,
>
> Commit
> 
>   b2419063123e ("mm/util: use kmap_local_page() in memcmp_pages()")
> 
> is missing a Signed-off-by from its author.
> 
> Well, not actually, but it helps if the Author of the commit and the
> Signed-off-by use the same email address (or slightly more similar
> than this:
> 
> Author: Fabio De Francesco <fabio.maria.de.francesco@intel.com>
> Signed-off-by: Fabio M. De Francesco
> <fabio.maria.de.francesco@linux.intel.com>

I'm sorry for this mistake. This was the first patch I sent using the 
[*].intel.com domains, so I was expecting that something could have been badly 
configured.

I think that the other four MM patches I sent the same day have no problems.
I'll be more careful next time.

Thanks,

Fabio



