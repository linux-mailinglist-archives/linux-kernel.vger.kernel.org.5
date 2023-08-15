Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1E677CD16
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Aug 2023 15:01:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237335AbjHONB3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Aug 2023 09:01:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237311AbjHONBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Aug 2023 09:01:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CAA10C1;
        Tue, 15 Aug 2023 06:01:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692104477; x=1723640477;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G0bkXs0Byr/czYVlp2osDUyIGamLcrgyfOrafyJFo8s=;
  b=M+Ejr+hm5A42vSMlNnnPcWyDcJYnj9MamNARXyFDfWKdlVCoPv6W3WmG
   Tm8kCLfOxk0IuqTKQX/SWbm/RsSxcD9MmKChuk5xzN0Q9BsgLk6k+HG2J
   h4tzqI3Kt0MxDtN+ZJVSUObqtoeOcB5LegSDeMHwJWzGwrh4zmUzm1Wrn
   wSCMPBicc1LgW9+iCjIrgnlhtJe1kbm9IWy7F08bbzlWk3y+dGF0M+5Vx
   GwXMe9nhHKrl/MHVtPT7v2xstmyAOaS8VR1jvkkHv7QHNhl7SArPBatGc
   x6U0OIfYTnGyVEtbbjFQmYQFue5ikZTPn2zthEqlWXwuUuGGmM9jx0aOn
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="436163732"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="436163732"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Aug 2023 06:01:16 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="768808518"
X-IronPort-AV: E=Sophos;i="6.01,174,1684825200"; 
   d="scan'208";a="768808518"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP; 15 Aug 2023 06:01:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVtfd-002Dlx-1L;
        Tue, 15 Aug 2023 16:01:13 +0300
Date:   Tue, 15 Aug 2023 16:01:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v1 0/3] Introduce Intel Tangier pinctrl driver
Message-ID: <ZNt3GWQYmFDBj0Cq@smile.fi.intel.com>
References: <20230814054033.12004-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230814054033.12004-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 14, 2023 at 11:10:30AM +0530, Raag Jadav wrote:
> Merrifield and Moorefield pinctrl driver implementations are similar
> in terms of how they access the hardware. We can consolidate their
> pinctrl functionalities into a common library driver.
> 
> This patch set introduces:
> 
> 1. Intel Tangier driver that supports the common pinctrl functionalities
>    for Merrifield and Moorefield platforms.
> 
> 2. Intel Tangier adaptation for Merrifield pinctrl driver.
> 
> 3. Intel Tangier adaptation for Moorefield pinctrl driver.
> 
> Tested on Intel Edison platform.
> No deviation observed in the contents of below entries before and after
> this patchset.
> 
> - /proc/interrupts
> - /sys/kernel/debug/gpio
> - /sys/kernel/debug/pinctrl/*/pins 

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


