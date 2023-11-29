Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB847FD917
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:17:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233973AbjK2OQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbjK2OQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:16:58 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E82AF;
        Wed, 29 Nov 2023 06:17:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701267425; x=1732803425;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=bhjXUMgXeV40oruQhYztJWCViluwOW0nwAoxxNUPFrw=;
  b=HUNl8vMTV3IZ194T+u9vY4wD5vGTgocJltBtWlLWGeVj7yHkwb8W6iSp
   OPLwbHS3K3MEskLNYF7qSM+CY1XwC2nUaCoEqqOf0sjUTVNP9H63w3Zqg
   90eVq0nIK8XsRpoawziBHfZYnkXslB/oXy4jvqIZeOWbMqXvidbPpjiZj
   tZeR0WYMfichk8ksd9cYSkjSY5SF11ZTOtGJhLeyb2TNzubKhMybaiXTN
   k9XqvHJL0ZGfXZUjU7+jg+9Y7EaSd5nsttjLu9is9cEf5CEaYlePF96ef
   H/uB1JN449c8Qpy0NF5kZ5f1e/wPQbL8jCNY8PCfv9LOYGfBci6SSnDP8
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="459665555"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="459665555"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:17:04 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="745272986"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="745272986"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:17:02 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8LN5-00000000SV2-0AMp;
        Wed, 29 Nov 2023 16:16:59 +0200
Date:   Wed, 29 Nov 2023 16:16:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petre Rodan <petre.rodan@subdimension.ro>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v5 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series pressure sensors
Message-ID: <ZWdH2rNSmj_jisuv@smile.fi.intel.com>
References: <20231129070452.1521-1-petre.rodan@subdimension.ro>
 <ZWcUPkzfGqxYsysp@smile.fi.intel.com>
 <ZWdB-vU2MAptRk8d@sunspire>
 <ZWdHYsWN-RWr75T6@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWdHYsWN-RWr75T6@smile.fi.intel.com>
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

On Wed, Nov 29, 2023 at 04:14:59PM +0200, Andy Shevchenko wrote:
> On Wed, Nov 29, 2023 at 03:51:54PM +0200, Petre Rodan wrote:
> > On Wed, Nov 29, 2023 at 12:36:46PM +0200, Andy Shevchenko wrote:
> > > On Wed, Nov 29, 2023 at 09:04:49AM +0200, Petre Rodan wrote:

...

> > just to have the privilege of using match_string() on hsc_triplet_variants.
> > now, which is worse for maintenance? a handful of lines of code that do a
> > loop of strncmp or the clutter depicted above?
> > 
> > I can go either way, but I want to make sure you see where this leads.
> 
> That's the suggestion, yes.

Btw, if you have any idea how to make a generic API that suits your and
similar cases, I'm all ears!

-- 
With Best Regards,
Andy Shevchenko


