Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E280176E71E
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Aug 2023 13:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234259AbjHCLkP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Aug 2023 07:40:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232996AbjHCLkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Aug 2023 07:40:12 -0400
Received: from mgamail.intel.com (unknown [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BBA0272A;
        Thu,  3 Aug 2023 04:40:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691062810; x=1722598810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Dd/pEIvh1vm5WdGjLrClzQBU3IOusOV95Grmu8xadFg=;
  b=YpR+dH2OjRfoUz48D3lxNp7qWvxdOK+xQonSIr7PRUFclSQ8fD4uPI7p
   7vNojSoaNKRU1Fb4xZza94ig+SUOqY9RIng9X2a0yL8KAHKjw3+9gqO/9
   LtJNVKHaORRdgYjrwp1YlPUM0IUTV87KPd/v2IA2zrsy/ZuwoH0wDi4Bw
   bzrnXD6+9snfg3IUZJZjPsNvQFx6NqTs8GYo816bFPnjgJTReTg6Q8Yvw
   mVe7d66XXWtc1/+BSrTjKqFVpbcuDSEGfz4z07bDnzVSEuzL48N9kjkcn
   kdmtCI4Q64HZkM5spPysSaCBYyfDj6DQ9ixUTG61AffZI9NVazKeKsG9A
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="373479426"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="373479426"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2023 04:40:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10790"; a="723190547"
X-IronPort-AV: E=Sophos;i="6.01,252,1684825200"; 
   d="scan'208";a="723190547"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 03 Aug 2023 04:40:06 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qRWgX-00AYix-0s;
        Thu, 03 Aug 2023 14:40:05 +0300
Date:   Thu, 3 Aug 2023 14:40:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Conor Dooley <conor@kernel.org>
Cc:     Jisheng Zhang <jszhang@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: serial: snps-dw-apb-uart: make
 interrupt optional
Message-ID: <ZMuSFYQ4YyIKnI0k@smile.fi.intel.com>
References: <20230802150545.3742-1-jszhang@kernel.org>
 <20230802150545.3742-2-jszhang@kernel.org>
 <20230802-halogen-bungee-63273b2c456c@spud>
 <ZMrRWP5mK+nksn4M@smile.fi.intel.com>
 <20230802-risk-getting-e6005e86be81@spud>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230802-risk-getting-e6005e86be81@spud>
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

On Wed, Aug 02, 2023 at 11:53:59PM +0100, Conor Dooley wrote:
> On Thu, Aug 03, 2023 at 12:57:44AM +0300, Andy Shevchenko wrote:
> > On Wed, Aug 02, 2023 at 04:43:48PM +0100, Conor Dooley wrote:
> > > On Wed, Aug 02, 2023 at 11:05:44PM +0800, Jisheng Zhang wrote:
> > > > The driver fall back to poll style when there's no irq. "poll" still
> > > > looks better than no support.
> > > 
> > > What is the user for this where the interrupt is not actually wired up
> > > in the hardware?
> > 
> > FYI: kernel console doesn't use interrupts, so for example it might be
> > the debug port. Note, I have no idea of the Zhang's case, just my assumption.
> 
> I'm less interested in what the software is doing, it's what the device 
> that has not connected the interrupt is that I am curious about.

As I said. The hw may be purely for debugging purposes (and yes, I have heard
about such a hardware).

-- 
With Best Regards,
Andy Shevchenko


