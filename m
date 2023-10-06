Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CB77BBB81
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 17:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232785AbjJFPOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 11:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjJFPOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 11:14:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C183CE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 08:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696605271; x=1728141271;
  h=date:from:cc:subject:message-id:references:mime-version:
   content-transfer-encoding:in-reply-to;
  bh=huPc4rVdST50Hrp24BOOy+5pYnjFSHRfnqsmLwx8krY=;
  b=Ts99dUeyJcC9jh2Wsw4OXtfTF2+T+WwKKL6T8De6t0Pa5dZNBgq+fugE
   2TBityf3i2GCa6SZ5gnKPxrfsGSSVa7QHyxbiDmouCkwHRdImol4iNSBj
   GJsq1tn47Ec9s2ktjj1TL/1eF1Zobbl+PmUfeBp0oQ5yVu3+lpMUnxAS5
   wv+PSPrF+MVIjpMzOFKn3y7VHVhqZ+y9tFudN0HPiv42fdWwy1amOHRUK
   ndQFdHFwWdtT1EXnbh2Lgb8ukhBT03413GyWIXJNMWyJ0bhibRBeoxAXV
   9ERcSwBUvEbHHJo3J0baA+GsCv12KvyFGeO+Rypk2/ytLAAQunAcUjEF2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="386594526"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="386594526"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 08:14:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10855"; a="842857824"
X-IronPort-AV: E=Sophos;i="6.03,204,1694761200"; 
   d="scan'208";a="842857824"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 08:14:27 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qomX2-00000003LUj-3wVc;
        Fri, 06 Oct 2023 18:14:24 +0300
Date:   Fri, 6 Oct 2023 18:14:24 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        JaimeLiao <jaimeliao.tw@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, linux-mtd@lists.infradead.org,
        linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Subject: Re: [PATCH v1 1/1] mtd: rawnand: Remove unused of_gpio.h inclusion
Message-ID: <ZSAkUMnXw4SbS2pC@smile.fi.intel.com>
References: <20230615164210.25515-1-andriy.shevchenko@linux.intel.com>
 <CAFBinCAJ5m+NTVry56=0AYMYr9xiM9KS7F837Hqb=ptOG_u54g@mail.gmail.com>
 <ZKvW0yzxU1ktDALd@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZKvW0yzxU1ktDALd@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,MISSING_HEADERS,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+Cc: GPIO maintainers

On Mon, Jul 10, 2023 at 01:00:51PM +0300, Andy Shevchenko wrote:
> On Fri, Jun 16, 2023 at 12:10:52AM +0200, Martin Blumenstingl wrote:
> > On Thu, Jun 15, 2023 at 6:42 PM Andy Shevchenko
> > <andriy.shevchenko@linux.intel.com> wrote:
> > >
> > > The of_gpio.h is not and shouldn't be used in the drivers. Remove it.
> > >
> > > Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> > Acked-by: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Thank you!
> 
> Can it be applied now?

So, this is still not applied, does it mean we need to go via GPIO tree
with it?

-- 
With Best Regards,
Andy Shevchenko


