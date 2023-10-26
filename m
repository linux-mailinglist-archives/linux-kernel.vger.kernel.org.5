Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 758B77D825F
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Oct 2023 14:16:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344888AbjJZMQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Oct 2023 08:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231173AbjJZMQt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Oct 2023 08:16:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D39111
        for <linux-kernel@vger.kernel.org>; Thu, 26 Oct 2023 05:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698322608; x=1729858608;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=KYf5xL0TV2CYbvS3/g0bvhK+S0g+N3mpJs+DacTeBpg=;
  b=clSHfqA2QsjM8usPfI6GlhA5RCWFgf6h9QICoxa5zuIJ5ZWNKJvwWAkm
   +EklTOwDGklq28h0bCTBORkTVpFMH+Ed6lMfF2KrmiigNWTIs16uzAnn8
   zcx6hcfp9CWCJ7ZnsXo6ydlFu6YXW8aBqqnFP7/6hiHIknbxlI01ZItb+
   f5eah3iQ1lXMeg8H+uyMF+5zeEXgyNwjyEyi6yb7R1IxBjVVPCtnklQ8/
   kfSqmlxPO0iShwENTUjKGcmg+YqfLFH2JyPc2HhNHn2izY7uYbbyWHrRs
   SfWEGMeqB/1KrFlaXl3wwd0HTHN3KL/AXsxdWNPz7WFh8wWi12C2pTD/o
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="9083655"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="9083655"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:16:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10874"; a="875918200"
X-IronPort-AV: E=Sophos;i="6.03,253,1694761200"; 
   d="scan'208";a="875918200"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2023 05:16:43 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qvzI0-00000008qlC-0TIq;
        Thu, 26 Oct 2023 15:16:40 +0300
Date:   Thu, 26 Oct 2023 15:16:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Alexander Potapenko <glider@google.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, pcc@google.com,
        andreyknvl@gmail.com, aleksander.lobakin@intel.com,
        linux@rasmusvillemoes.dk, yury.norov@gmail.com,
        alexandru.elisei@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, eugenis@google.com,
        syednwaris@gmail.com, william.gray@linaro.org,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH v9 1/2] lib/bitmap: add bitmap_{read,write}()
Message-ID: <ZTpYpyPP0MWNpF2W@smile.fi.intel.com>
References: <20231025083812.456916-1-glider@google.com>
 <ZTpYbCa0Qmry0HGH@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZTpYbCa0Qmry0HGH@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 26, 2023 at 03:15:40PM +0300, Andy Shevchenko wrote:
> On Wed, Oct 25, 2023 at 10:38:11AM +0200, Alexander Potapenko wrote:

...

> >   *  bitmap_to_arr64(buf, src, nbits)            Copy nbits from buf to u64[] dst
> >   *  bitmap_get_value8(map, start)               Get 8bit value from map at start
> >   *  bitmap_set_value8(map, value, start)        Set 8bit value to map at start
> > + *  bitmap_read(map, start, nbits)              Read an nbits-sized value from
> > + *                                              map at start
> > + *  bitmap_write(map, value, start, nbits)      Write an nbits-sized value to
> > + *                                              map at start
> 
> I still didn't get the grouping you implied with this...

Ah, sorry, I haven't noticed the descriptions are two-liners.

-- 
With Best Regards,
Andy Shevchenko


