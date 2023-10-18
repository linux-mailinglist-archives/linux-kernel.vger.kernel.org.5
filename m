Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F11F7CD354
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 07:01:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjJRFBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 01:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229563AbjJRFBf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 01:01:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08662103;
        Tue, 17 Oct 2023 22:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697605294; x=1729141294;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xa+xut1TfI2HMab1q65v9qAkFEYsv5oUYEFQQ4ltZ4M=;
  b=Julb1pfO13XJyWaefCiEmekd69bJj5BDrQL0cS5SH43Azy2RDyCQrCK0
   5x7uPO1XBZIXngPRJccEvFGX4z/2YhouMMvZxXYnK3hxJ44H55tedAk4c
   KMnCP7L19faMqfLp/SQOMwLcCQVmB4JDgwT0yrJ+yKrjH6ge7q/eipWLv
   nhYbplyyVkSpLbSS4odvSdLCnindetXq02lOj60yg6FNvmzqITsB/Diz1
   f+MYT1U4V3L2qfy4Q/4eqY0eJXK+Gb4vlWCk+9S5aTzd61g8ckvNDOZgT
   inC0CfxOKfVileVWRHHpOZ+0erU9KIoAOI9mPXj3EViI0mAsycgR//fvN
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="389813958"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="389813958"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 22:01:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10866"; a="1003626061"
X-IronPort-AV: E=Sophos;i="6.03,234,1694761200"; 
   d="scan'208";a="1003626061"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 22:01:26 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qsygO-00000006VXl-0ZsZ;
        Wed, 18 Oct 2023 08:01:24 +0300
Date:   Wed, 18 Oct 2023 08:01:23 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: Re: [PATCH v1 1/1] Revert "pinctrl: avoid unsafe code pattern in
 find_pinctrl()"
Message-ID: <ZS9mo4/jnRNoTE+v@smile.fi.intel.com>
References: <20231017141806.535191-1-andriy.shevchenko@linux.intel.com>
 <CACRpkdbHJHsgJ=3pYveP-x-Vuwwf3ib6TnFOt3UpCrKevf=d1w@mail.gmail.com>
 <ZS7TuodhwNxU9Ez6@smile.fi.intel.com>
 <CACRpkdZfzq81SZnEpB_Acp_=8Xc2TEMNi8yS_j4wNBcQKXgrgg@mail.gmail.com>
 <ZS7kY/+80Be4geGM@smile.fi.intel.com>
 <ZS7_5VGvRnw99gzd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZS7_5VGvRnw99gzd@google.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 02:43:01PM -0700, Dmitry Torokhov wrote:
> On Tue, Oct 17, 2023 at 10:45:39PM +0300, Andy Shevchenko wrote:

Thanks for your response.

...

> I wonder, could you please post entire dmesg for your system?

Working, non-working or both?

...

> I think the right answer is "fix the userspace" really in this case. We
> could also try extend of_alias_get_id() to see if we could pass some
> preferred numbering on x86. But this will again be fragile if the
> knowledge resides in the driver and is not tied to a particular board
> (as it is in DT case): there could be multiple controllers, things will
> be shifting board to board...

Any suggestion how should it be properly done in the minimum shell environment?
(Busybox uses mdev with static tables IIRC and there is no fancy udev or so)

-- 
With Best Regards,
Andy Shevchenko


