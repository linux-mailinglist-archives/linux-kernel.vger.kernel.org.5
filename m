Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FFF978F107
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346752AbjHaQQs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:16:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232201AbjHaQQq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:16:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886FFE4C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693498603; x=1725034603;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mI1jts0K9VDoQoxPnmopaYW2ScuYFWqzZgs9yJpJZCo=;
  b=TZ0cYZihyoaAgX2ZYVfHwYH7Zww1xndgbFjf4OGSKXUirPJ6hiKbLpBX
   Iwo+zX9L54XsHwEjohSuT2nDtD37x7JoQqEuskK22AwFUpWsxi35Ypmig
   mJAbVbZIn5H6pv/YU4+eQHJKhXpwJ7f4MbiSZMMUCob6tgRwnverpjh5u
   ZeoCciCX1dlEwmXvCX7lLRVVggb3CMY1Pe6W3jACASRHPceasPgl2I7yO
   RtpOq6SegGyuEUwqXX3jbwCRZrkNQpsC6mTrn+rMj9DlYySG2g++z9fVV
   BOFhWKHO4IPeR7R+rA4KVpHDi2/YUZ9aLkL7lefqhLjA6WKvFOWWu8dA3
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="374903906"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="374903906"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 09:16:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="733169316"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="733169316"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 09:16:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qbkLU-005Qr4-0K;
        Thu, 31 Aug 2023 19:16:36 +0300
Date:   Thu, 31 Aug 2023 19:16:35 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v6 4/4] drm/bridge: panel: Drop CONFIG_OF conditional
 around  *_of_get_bridge()
Message-ID: <ZPC84+k8aot5LyGT@smile.fi.intel.com>
References: <20230831080938.47454-1-biju.das.jz@bp.renesas.com>
 <20230831080938.47454-5-biju.das.jz@bp.renesas.com>
 <20230831093108.GF2698@pendragon.ideasonboard.com>
 <OS0PR01MB592262D3EDAF424252157D5B86E5A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB592262D3EDAF424252157D5B86E5A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 10:47:24AM +0000, Biju Das wrote:
> > On Thu, Aug 31, 2023 at 09:09:38AM +0100, Biju Das wrote:

...

> > > Drop unnecessary CONFIG_OF conditional around devm_drm_of_get_bridge()
> > > and
> > > drmm_of_get_bridge() as it is guarded with #if..#else blocks in
> > > drm_bridge.h.
> > 
> > This will increase the kernel size on non-OF system, to add functions that
> > are not used. I don't think the #ifdef here is problematic.
> 
> OK agreed. I guess for NON-OF system it will give build error
> for function redefinition, if that is the case I would like to
> drop this patch.
> 
> static inline struct drm_bridge *devm_drm_of_get_bridge()
> 
> vs
> 
> struct drm_bridge *devm_drm_of_get_bridge()

Yeah, yet another argument in favour of switching to fwnode.

-- 
With Best Regards,
Andy Shevchenko


