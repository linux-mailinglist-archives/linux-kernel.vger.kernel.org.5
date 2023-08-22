Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6025E78400B
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 13:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235443AbjHVLui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 07:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232164AbjHVLuh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 07:50:37 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92D2EE7C;
        Tue, 22 Aug 2023 04:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692705006; x=1724241006;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Tb1ZgTNEv//QWjmP/W9YhxcHqD78jgLo96nw42Vh75U=;
  b=T9iVfFajQYSoTBHes+Y35X6M5Dlsl6LIPKdduT4heUUUbymBGjhUtXni
   rCzN2Ln3XfIdmeDS/4MYk+lvdps3/qEpZ6jhU/UM2wREGRsEY9qi53SJz
   t+S+BfIfv5x+r93SIeu10x6IFqPYlPr/nFQRhpkCmgI3T0nYal2ATFfMU
   BuQ6WIA5EZhgFNp/1a6++QoA7fc8+vf4MiWZboFmUYFjz0ZMKp6qsxglQ
   yGUJu/AzC3ymVbroGRv+QivbAL231ezw/nJUASNKgZlFvjkEiCz/i8bDy
   AHWZpbRmqCDmPat0QnyTJYL3n0NSaUT9rXW3kZyQPsNV60pRWhbawMzP2
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="354196191"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="354196191"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2023 04:48:19 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10809"; a="910068812"
X-IronPort-AV: E=Sophos;i="6.01,192,1684825200"; 
   d="scan'208";a="910068812"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP; 22 Aug 2023 04:48:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qYPrr-008luy-0s;
        Tue, 22 Aug 2023 14:48:15 +0300
Date:   Tue, 22 Aug 2023 14:48:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v1] pinctrl: intel: consolidate ACPI dependency
Message-ID: <ZOSgftLu20ndQPzL@smile.fi.intel.com>
References: <20230822073056.10208-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230822073056.10208-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 22, 2023 at 01:00:56PM +0530, Raag Jadav wrote:
> Since all the Intel specific platform drivers depend on ACPI, we can
> consolidate their config dependency.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


