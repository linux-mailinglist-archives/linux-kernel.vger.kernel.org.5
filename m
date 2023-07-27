Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46214765B86
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 20:43:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230247AbjG0Sng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 14:43:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjG0Snf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 14:43:35 -0400
Received: from mgamail.intel.com (unknown [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5716F2D5D;
        Thu, 27 Jul 2023 11:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690483413; x=1722019413;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=L5z8yin9ZxPjzkBPLKHCZpn/sE75lTZ1e/7BXlD4ZOQ=;
  b=Mf+VQ3XAJc/iLO67f2K9XkOKaQD2SxFOG2HELrfz3LkOoHJjU6srbyDc
   OPyWuGI1+l5MT3sNFImp5BOm8p3NCaUi/wPUCP+227JZSeRTO4baa/EN5
   4YugVKMc00CocxL8KZXLVF3rGOmhkFOIe6PBcBvZLHt3djFxtHBIUf22K
   o1ScHiw4m3OIwioylg7XoT/l5qvEqrcdE0MFowe/U69Eg6ITmWt3UkeCV
   3+/8krn3+jbddtI9D+0nHu8TgpkJHtcXOclHDavdYFHGgTUvhQv6ekPOQ
   xOoFMxn5PuECITeL2cJo2ektQBhuIPP23F/o6Q9oF0hUHaIYu0ShxHGmn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="348011715"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="348011715"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 11:43:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="817211608"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="817211608"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 27 Jul 2023 11:43:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qP5xR-00Gb8Y-34;
        Thu, 27 Jul 2023 21:43:29 +0300
Date:   Thu, 27 Jul 2023 21:43:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH v1 00/12] HID: cp2112: Cleanups and refactorings
Message-ID: <ZMK60UphgVuj4Z+L@smile.fi.intel.com>
References: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703185222.50554-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 09:52:10PM +0300, Andy Shevchenko wrote:
> After I updated GPIO library for the case Benjamin has with CP2112,
> I have a brief look into the CP2112 driver itself.
> 
> From GPIO perspective it has two main (maitenance) issues:
> - usage of ->to_irq() with IRQ chip present;
> - having IRQ chip not immutable.
> 
> Besides that there are plenty small cleanups here and there.
> Hence this series.

Any comments on this?

-- 
With Best Regards,
Andy Shevchenko


