Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351CA79148A
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 11:14:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352389AbjIDJOZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 05:14:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231458AbjIDJOY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 05:14:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C60CCC;
        Mon,  4 Sep 2023 02:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693818860; x=1725354860;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=4ruG78SK6aD0ZgzS7S5z29TWvybvk1HBJtQGhR0/XC0=;
  b=NW4W8aOKukvvP6SCb9XJ8wfBOtBFawZLm2ftTT0GYTY9hbTWDQL83bCJ
   +B3cARzDZ9pXlscb4brJRXuytU4El4TXkG+rLyYx8HjpIVBlWH0cu6KCo
   N2L3hfr2x0sXDBlt3k39Q4DWCpHYYj733SpRrshePcKUM4A0s5UfDcLut
   8dD9I0xPKe6PoXcXOkmzQ2PZ2ATeVOcdcNvIzXBrYGR8TDt0kgVel+0Lk
   PxKrnL4FY98z01fZl4cStuPLUQPhpeaD4iAKgsHtAWhh7QnwoROKxbG4C
   JrH80w4C93MKCe4j7sS5Cwl7Uei7fpSPL5xn1iiWberFZfoJcYWrtF32D
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="462923812"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="462923812"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:14:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="806185273"
X-IronPort-AV: E=Sophos;i="6.02,226,1688454000"; 
   d="scan'208";a="806185273"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 02:14:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qd5ey-006NnE-0J;
        Mon, 04 Sep 2023 12:14:16 +0300
Date:   Mon, 4 Sep 2023 12:14:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH 0/2] Match data improvements for mcp23s08 driver
Message-ID: <ZPWf52gkpWCmR83i@smile.fi.intel.com>
References: <20230902090937.32195-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230902090937.32195-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 02, 2023 at 10:09:35AM +0100, Biju Das wrote:
> This patch series aims to add match data improvements for mcp23s08 driver.
> 
> This patch series is only compile tested.

When driver has SPI and I2C parts, always take into account both of them.
There is more work needed here.

-- 
With Best Regards,
Andy Shevchenko


