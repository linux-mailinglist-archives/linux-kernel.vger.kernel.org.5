Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBE0077B899
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Aug 2023 14:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbjHNM11 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Aug 2023 08:27:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbjHNM06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Aug 2023 08:26:58 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9D8CF5;
        Mon, 14 Aug 2023 05:26:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692016017; x=1723552017;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=UVnGR/e7s7Oy0cT08NpHAbsQGs/NrtJMpsbs1TTLcG4=;
  b=jF2dOGvRFCC+riaEqEp1KJ7/ux7d5mw2AMoecDaMo1SG/rS4CMzLRTGi
   /rMnSHdQ6TZNnQ7LM/e3h0HUEAPgaWn0r2Slk93F+P8vrN5fwp+Im3P2r
   ynihT1d0MZs25rB+xOoBjZIS+m5O3tSfRxr6VxhPy7nkWCJeQUOCW0162
   C0hcMCObe0sZPX/9PGNhlbgsR7EkzQQQLkOQUR2HtoKYbh9RO8wztkdmn
   LmrJUtTj6y+xvuNO766M/vQoQ1hkN8I3mtPdwZ1dNjmRNqfm7mLuT0yc5
   YFlMeBYmocl0yrYk9QGW8p77Q9j+At8eX6nneVMS72nTI0/nFwHX9lbQ4
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="374795345"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="374795345"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2023 05:26:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10802"; a="733425851"
X-IronPort-AV: E=Sophos;i="6.01,172,1684825200"; 
   d="scan'208";a="733425851"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 14 Aug 2023 05:26:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qVWer-004TMA-03;
        Mon, 14 Aug 2023 15:26:53 +0300
Date:   Mon, 14 Aug 2023 15:26:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-gpio@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: regression from commit b0ce9ce408b6 ("gpiolib: Do not unexport
 GPIO on freeing")
Message-ID: <ZNodjIqcoP9iVU1w@smile.fi.intel.com>
References: <20230808102828.4a9eac09@dellmb>
 <ZNYKjnPjIRWIYVot@smile.fi.intel.com>
 <20230814093934.1793961e@dellmb>
 <ZNoNgWQG/5jdXlCK@smile.fi.intel.com>
 <20230814135556.5a2c08c3@dellmb>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230814135556.5a2c08c3@dellmb>
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

On Mon, Aug 14, 2023 at 01:55:56PM +0200, Marek Behún wrote:
> On Mon, 14 Aug 2023 14:18:25 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> 
> > On Mon, Aug 14, 2023 at 09:39:34AM +0200, Marek Behún wrote:
> > > On Fri, 11 Aug 2023 13:16:46 +0300
> > > Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:

...

> > > tested, works.  
> > 
> > I convert this to the Tested-by tag, I hope you won't object.
> > But tell me if it's the case.
> 
> Yes, Tested-by, maybe even Reported-by.

Both. As they are about different phases of the flow.

-- 
With Best Regards,
Andy Shevchenko


