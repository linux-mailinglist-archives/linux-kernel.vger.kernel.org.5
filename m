Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFC1175C85E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 15:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230229AbjGUNwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 09:52:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231213AbjGUNwq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 09:52:46 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 741263C04;
        Fri, 21 Jul 2023 06:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689947544; x=1721483544;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=SVttKu/eu28MCOim1B0YM+4ULop9gmNJ5KJQB5200Kc=;
  b=QPpBFLUjM6UnpeKd0zcrEXOM6WenbVrZroVsoT93aODt2oYc3qqBydk/
   9UfzAIeHvGGg1nzIxFx+gWVKALNUhskSSZQYat93/SIZ5f6xTUXSuT/27
   hx1wrqPTiU16yasUZVTEyIUZFpQUBUaUxNSG7u4AAXtt/p+CaT2jK+gkC
   AW8M0RmMQ5p5uCZybIvrZ+64gyUw9qfaeCGmQEKF/cFwH+PCefOMgleVq
   MnFhFuZnO29m/TSRvg5dbiDPO+VN6LpSqn+TJ2lDaBSsyOpuKJVJ+Dw+V
   ROtNysue1xTwkUu4IVRhNy14+k3RxqdPkWjDEh/itrGFjKgDxxK/4kuQ/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="430818248"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="430818248"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 06:51:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10778"; a="794964238"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="794964238"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP; 21 Jul 2023 06:51:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMqXj-0073G3-0u;
        Fri, 21 Jul 2023 16:51:39 +0300
Date:   Fri, 21 Jul 2023 16:51:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jani Nikula <jani.nikula@intel.com>,
        Imre Deak <imre.deak@intel.com>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org
Cc:     Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Helge Deller <deller@gmx.de>, Stephen Boyd <sboyd@kernel.org>,
        Nikita Shubin <nikita.shubin@maquefel.me>,
        Nikita Shubin via B4 Relay 
        <devnull+nikita.shubin.maquefel.me@kernel.org>
Subject: Re: [PATCH v1 1/1] drm/i915: Move abs_diff() to math.h
Message-ID: <ZLqNazKSE8f6XBsg@smile.fi.intel.com>
References: <20230721134235.15517-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721134235.15517-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 04:42:35PM +0300, Andy Shevchenko wrote:
> abs_diff() belongs to math.h. Move it there.
> This will allow others to use it.

Sorry, forgot omap-serial case.
Will be v2 soon.

-- 
With Best Regards,
Andy Shevchenko


