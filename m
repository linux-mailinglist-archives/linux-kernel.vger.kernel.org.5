Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B0A778C863
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:15:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbjH2PPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235510AbjH2POz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:14:55 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9712D184
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:14:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693322092; x=1724858092;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lpqzDadLvEurem+mFKVtcc9dXopNbGIXrWuPlvW/NOU=;
  b=jyXXkYQbSr8XQFgrqdTzwXH4H3Gi/v3vcjl1C1DPD0HHaQgN9vD5tl9m
   dNpu3Ts6UyKwcCjRlEFf+kVIDKoHfFzjkB6cYLM+jrlN1R0uJ5AjAqUMo
   PhHzzOAN47eEb9S18jgBKLIc+9Zp0+czVMoti7EFa7B5kdExahxC8TusM
   r9zDfhAknVoWKBSv7G+6GtTZSfbNQ+EW5qrwAbFk4NVxgrQfsUymNuJVP
   JJ4Axa7t4aQ/g0drXE7GQi9ah2pCpvcVzw3hNQ/FTDZwP6S5aSm65uszl
   5FdpTQpitmWV1AOng0vX0+dgFjwGJKpqmGCsLtBsLZSsZoGhawZ0MQTGQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="461759822"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="461759822"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 08:09:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="985371499"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="985371499"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 29 Aug 2023 08:09:13 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb0L9-004uWz-2p;
        Tue, 29 Aug 2023 18:09:11 +0300
Date:   Tue, 29 Aug 2023 18:09:11 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lee Jones <lee@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] mfd: max77541: Simplify probe()
Message-ID: <ZO4KF0RM6i0Kp/5l@smile.fi.intel.com>
References: <20230828153805.78421-1-biju.das.jz@bp.renesas.com>
 <ZO4GViBrAvAG5EPT@smile.fi.intel.com>
 <OS0PR01MB5922AE1C328FD2485C4D83BB86E7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB5922AE1C328FD2485C4D83BB86E7A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 29, 2023 at 02:58:20PM +0000, Biju Das wrote:
> > On Mon, Aug 28, 2023 at 04:38:05PM +0100, Biju Das wrote:

...

> > > While at it, drop leading commas from OF table.
> > 
> > Sure?

...

> See there is a comma after every .data, that is leading commas right?

No, it's called trailing.

Ex.:

  lead  ..., trail
  0, 1, ..., N


-- 
With Best Regards,
Andy Shevchenko


