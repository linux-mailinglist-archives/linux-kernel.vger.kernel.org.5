Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74138765611
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 16:36:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233812AbjG0Ogc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 10:36:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232141AbjG0Og3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 10:36:29 -0400
Received: from mgamail.intel.com (unknown [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3CC30D3;
        Thu, 27 Jul 2023 07:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690468588; x=1722004588;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TjuMUfQ5gRMaae5Age8wszPVJmes8/brvAgOH+GendI=;
  b=E24wKkfyTQ5x6ODqoAsEPOWO5AiQhzVtI5b6I3HqtLCO6dFSS82tHiI6
   ZzvRapraufrATz7luvMkvRHYTKzUYC/YHPN1GierEyHKm82D5dBYysPT8
   YJ0p2touGaLdUv/cVAahdW8wweYNg1+1NZ8BxqxIkryz7q9cCUMFf8FKd
   t38iomxhq0yzaGEYviqAhBZ18UITzQCvTHclZiY7fepKEas19fgmWtWIL
   ZymnzbpJx4q0wcpdC0nh61ft6Uc0+L8dGcHyB3KiirBJOYqx7uBx56gG5
   Z8ORiTV+aRTnLn2zWVTFVWi0TqaOMtovX25YikwfluIjnSfVIIY91CgW/
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="353240739"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="353240739"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 07:36:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10784"; a="756709514"
X-IronPort-AV: E=Sophos;i="6.01,235,1684825200"; 
   d="scan'208";a="756709514"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 27 Jul 2023 07:36:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qP25x-00893s-2O;
        Thu, 27 Jul 2023 17:36:01 +0300
Date:   Thu, 27 Jul 2023 17:36:01 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tony Lindgren <tony@atomide.com>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org
Cc:     Jiri Slaby <jirislaby@kernel.org>
Subject: Re: [PATCH v1 1/1] serial: core: Replace strncmp()+strlen() with
 plain strcmp()
Message-ID: <ZMKA0f987+Oac8eT@smile.fi.intel.com>
References: <20230727090507.81962-1-andriy.shevchenko@linux.intel.com>
 <ZMJcKc49Z69ZhfGk@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZMJcKc49Z69ZhfGk@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 02:59:37PM +0300, Andy Shevchenko wrote:
> On Thu, Jul 27, 2023 at 12:05:07PM +0300, Andy Shevchenko wrote:
> > There is no sense to call strlen() ahead of strncmp().
> > The same effect can be achieved by calling strcmp() directly.
> > Replace strncmp()+strlen() with plain strcmp().
> 
> It seems I will have more against serial core, perhaps it makes sense to unite
> them in a single series.

Actually this change is simply wrong. Sorry for the noise.

-- 
With Best Regards,
Andy Shevchenko


