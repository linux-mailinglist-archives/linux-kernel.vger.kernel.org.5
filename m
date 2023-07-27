Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72E1A76508A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjG0KHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229919AbjG0KHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:07:01 -0400
Received: from mgamail.intel.com (unknown [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F667136
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 03:07:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690452420; x=1721988420;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=2I/8Kvj00GvP5GzlD6vkzjoaokn5doSqeVlzX1rZIE8=;
  b=f2p5L0vKIPqbx4DdjKEEA/ncZjlkBm5Fdx3bUoccxrZxlq6SuS0hM7mn
   aV0cRPkgLBgEA52O4BYLgM/M6jwgqZdKks0ru4U3yLUX2zebrRDPlPRuB
   IBL7+C3R83nwfkrrR6HwMWQWGp1Wzh+cG4gzaseqUzigtqi5lRESzeGaB
   p9XKfTcnpjHft1Ba/NC9KOTp2oyyAFan+3gfFrNSf/rpXIB1u0pnFce2B
   X/t0lUHz4vwpToJW5ALDLESZsAtl0SrtbE7ElI8ZPE04QmZFwKwWCHCcj
   GRlyOnve5kxV+0TaSvWmY4ZPPftyp5XAEahtC4k786/9fsY5/FIvDKc+O
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="434542919"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="434542919"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 03:06:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="900839552"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="900839552"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 27 Jul 2023 03:06:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qOxtZ-00GVZs-0k;
        Thu, 27 Jul 2023 13:06:57 +0300
Date:   Thu, 27 Jul 2023 13:06:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 6/6] bitmap: move bitmap_*_region functions to bitmap.h
Message-ID: <ZMJBwAwTN0pTZMkf@smile.fi.intel.com>
References: <20230727020207.36314-1-yury.norov@gmail.com>
 <20230727020207.36314-7-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230727020207.36314-7-yury.norov@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 26, 2023 at 07:02:07PM -0700, Yury Norov wrote:
> Now that bitmap_*_region() functions are implemented as thin wrappers
> around others, it's worth to move them to the header, as it opens room
> for compile-time optimizations.

Don't forget to run

	scripts/kernel-doc -v -none -Wall

against this header.

-- 
With Best Regards,
Andy Shevchenko


