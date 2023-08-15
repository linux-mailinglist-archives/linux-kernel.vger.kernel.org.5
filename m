Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D27977CD0F
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 14:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237316AbjHOM7O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 08:59:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233524AbjHOM6n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 08:58:43 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10FE110C1;
        Tue, 15 Aug 2023 05:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692104323; x=1723640323;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SHuscfJc7Spgn6W5I+BAK6KTFEfBUxvaCwNrLrNk6o8=;
  b=Ak4hpMjVY0xAKzPhk98Wr3wpFjLS+4aiIFB4cdzkGpAxeKSEcDs/+/5u
   PIRhfZlFhb2Y0MkpcuaaDv1OFSk9P+tjbSluR7S2TOthy5kH8dv8ZqCGL
   ovJcKv2DhCxi5OALxI3FX2dbXBC02gUfehimsyhLAlNSwxJFmwel89Y8v
   GHPNxe9X6dajEpdi3KIXSEqNsFDSBkwN4BK+nNrn7Zj14HYFjBwBhu+8i
   Wa4BGfGVT52XK0+ry5QWjEE12vtL2d+G9yEf65lbXpih/h3LaAFSZoBeb
   rhwOEBaGYWryUxeg72H+3zXkuuU5ucfNvDL2P4qfyd7YYheVG1VIJttie
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="357236335"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="357236335"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 05:58:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="1064445714"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="1064445714"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 15 Aug 2023 05:58:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVtd8-0028BZ-23;
        Tue, 15 Aug 2023 15:58:38 +0300
Date:   Tue, 15 Aug 2023 15:58:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Raag Jadav <raag.jadav@intel.com>, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v1] pinctrl: baytrail: consolidate common mask operation
Message-ID: <ZNt2fuqZxOYTIbGH@smile.fi.intel.com>
References: <20230808084901.18927-1-raag.jadav@intel.com>
 <20230808134142.GQ14638@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808134142.GQ14638@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 04:41:42PM +0300, Mika Westerberg wrote:
> On Tue, Aug 08, 2023 at 02:19:01PM +0530, Raag Jadav wrote:
> > Consolidate common mask operation outside of switch cases and
> > limit IO operations to positive cases.
> > 
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


