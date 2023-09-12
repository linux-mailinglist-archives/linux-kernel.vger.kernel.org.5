Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3818379D6C3
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 18:50:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbjILQud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 12:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237090AbjILQu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 12:50:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0EDD10E9;
        Tue, 12 Sep 2023 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694537424; x=1726073424;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=pmICX2sNV56aNUWsgFt6oKaBVKAaT6NCme0Ya3baEu4=;
  b=mhQlcb3zCfqRbAReX11mx9zPL38n6QeoGI6ZC2miTAycbbeQQDLch7FN
   FPzfji9pS7aewaL7eq+/mLOc7E2bk0aJL7hf2Or8HrR0ryvIX5CPmuz7h
   H0UbTQMMjkvSaMs47IE450mbzJs5PnJwWn4T+A3qusXr0InLIyxJKF9h+
   PhOcEBHxsL/LenPU1wmGgiglfLdI2PeRCmilF1bWb9tRTK4NuKCClMIW8
   40gc4ljXH8hR9xfbSQEmwkYogQPSBb9t8ag+oOM9OOkTwoRNNPDmRQ29Q
   pRwFc4QoWP8VAKFypzvlm0I9ful6Ww274fsEO1ykS+XWfxc4+vAsCeuYu
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="375762346"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="375762346"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:50:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10831"; a="720485017"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="720485017"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 09:50:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qg6aO-008dWu-1A;
        Tue, 12 Sep 2023 19:50:00 +0300
Date:   Tue, 12 Sep 2023 19:50:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
Cc:     Raag Jadav <raag.jadav@intel.com>, linus.walleij@linaro.org,
        dan.carpenter@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v1] pinctrl: baytrail: fix debounce disable case
Message-ID: <ZQCWuJbMzlV6t8Wa@smile.fi.intel.com>
References: <20230912154815.28975-1-raag.jadav@intel.com>
 <20230912155443.GF1599918@black.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912155443.GF1599918@black.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 06:54:43PM +0300, Mika Westerberg wrote:
> On Tue, Sep 12, 2023 at 09:18:15PM +0530, Raag Jadav wrote:
> > We don't need to update debounce pulse value in case debounce is to be
> > disabled. Break such a case where arg value is zero.
> > 
> > Fixes: 4cfff5b7af8b ("pinctrl: baytrail: consolidate common mask operation")
> > Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> > Closes: https://lore.kernel.org/linux-gpio/d164d471-5432-4c3c-afdb-33dc8f53d043@moroto.mountain/
> > Signed-off-by: Raag Jadav <raag.jadav@intel.com>
> 
> Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


