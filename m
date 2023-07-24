Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D290A75F9E4
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 16:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbjGXO3e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 10:29:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbjGXO3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 10:29:32 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28B90E66
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 07:29:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690208969; x=1721744969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ptetqP70i7cB7AXi3WKMSEKGgpo8qePz8JSJ5VlYKpg=;
  b=CgOYGLjxuz6Zzxzv++W4a7K/SxyVb8IcJja+8FTYP/TRLuGKQ3cKVE5r
   kEq/9C8nS/h6tFFFq/CKGyQryz10xeNDPLFu2wYOC+dibC+4qjEaFx2Z5
   6KnV6xjUfUUeiCcIhUey8ahc+Wtb+NQwBpmHRstuHozeMoK16VpYi4qxg
   CujyehAyTIOkVH3BIxByg9aCfPmN2tFAU6vqiNJGK+RsnN/avwNYKLUut
   kAKqQttb3i3AqgI6kvoGYerQMUgl4UxoyREjNIcV+HYVDUcwqjxgjg+nK
   Oj/i+fGhCrl1rYDTxg1IcjQr/Thn2lXDoH9JUTC0z3MqT00O0w0ZE4UqT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="357453667"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="357453667"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 07:29:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10781"; a="760810404"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="760810404"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 24 Jul 2023 07:29:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qNwYv-00GzIe-1H;
        Mon, 24 Jul 2023 17:29:25 +0300
Date:   Mon, 24 Jul 2023 17:29:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Herve Codina <herve.codina@bootlin.com>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v1 1/1] minmax: Fix header inclusions
Message-ID: <ZL6KxZh9SwizrApS@smile.fi.intel.com>
References: <20230721133932.12679-1-andriy.shevchenko@linux.intel.com>
 <20230721161033.55bc133c@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721161033.55bc133c@bootlin.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 04:10:33PM +0200, Herve Codina wrote:
> On Fri, 21 Jul 2023 16:39:32 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

> Reviewed-by: Herve Codina <herve.codina@bootlin.com>

Thank you!

Note, the https://lore.kernel.org/all/20230724142307.28411-1-andriy.shevchenko@linux.intel.com/
has a fix to the broken builds the LKP reported about.

-- 
With Best Regards,
Andy Shevchenko


