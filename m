Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75CD07D581A
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Oct 2023 18:24:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343817AbjJXQY5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Oct 2023 12:24:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343557AbjJXQY4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Oct 2023 12:24:56 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0594AC;
        Tue, 24 Oct 2023 09:24:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698164694; x=1729700694;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=40e+f7eh4ga/K3xOmneirQMsE3tMgWO2g/N4Y02fNIM=;
  b=fc5J5c4PzTH94gnIsIQlWDLWk36NJaBOHGYE8EZushyx9sMzBn6pXfD3
   0HcJEei7MIZiJeGX6Doz0f8rZRNmjn+xV3g0MpXIz4q3u2i8wfqvas1tu
   giOYkOn1x0ELddBPmnyYl4w1qCMhp9a4UBnjD4kBTOVe/NbPQ/578Sm5d
   uOsH2fFiC1C396sexpZ1I3gfHlDCmSdg2kpQoBkheI+WtpQJMDit+tkqL
   gSLUmQ0/76L+C9VTIvtiRsSV3cHSc87ZVCyD0NLcI+sfacYDfHn3OhyI7
   VfPo+ko1FFBn/WG4JlgZWFcIBQxEi04btbtJidBfB/06R1Pi0KPhetW4u
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="389958679"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="389958679"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 09:23:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10873"; a="735083166"
X-IronPort-AV: E=Sophos;i="6.03,248,1694761200"; 
   d="scan'208";a="735083166"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Oct 2023 09:23:54 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qvKC7-00000008Kbq-1FZ9;
        Tue, 24 Oct 2023 19:23:51 +0300
Date:   Tue, 24 Oct 2023 19:23:51 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        David Laight <David.Laight@aculab.com>,
        linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        Vasily Gorbik <gor@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        kernel@collabora.com
Subject: Re: [PATCH v4 3/3] clk: composite: replace open-coded abs_diff()
Message-ID: <ZTfvl/NeygZgeH0R@smile.fi.intel.com>
References: <20231024161931.78567-1-sebastian.reichel@collabora.com>
 <20231024161931.78567-4-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231024161931.78567-4-sebastian.reichel@collabora.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2023 at 06:18:17PM +0200, Sebastian Reichel wrote:
> Replace the open coded abs_diff() with the existing helper function.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>

-- 
With Best Regards,
Andy Shevchenko


