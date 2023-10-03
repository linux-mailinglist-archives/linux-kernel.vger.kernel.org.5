Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9795D7B64E1
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239305AbjJCJAK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:00:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjJCJAJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:00:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE85CAF;
        Tue,  3 Oct 2023 02:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696323604; x=1727859604;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=wdsojALH/g94kOE3J1YReNKHhGVsyHpHEXJJtTbH4/k=;
  b=WKb/5jw+NYyzQbj+m+UnNjPnTEQT229MVgcqSbt+oszQ4Me2lwiv34th
   KLxa7ctkOpz8LPeW6dwapHnFTtFjG581m3n1EqSRlp5BngwglpfKkSnxN
   ie7Qtvvxwyga7GQ+Jj76jXnvnXfcs2On+LsVF1iDT1vaMajru/oKkZLiy
   4wz5NuLl69xJctcwFGAkr5YmA4htjQDIWNyezC5FLl1zaj1BBeD2NNiQe
   HlYF/6sbswQJj0gnv47d0S2D6p6ZAy1JVR8meSFLIFr5qMmGYSIXTg+FD
   5XTu5rurBYxGSh+rk67QODI7WSMItdAAdyVZwozP9RkYzCJ/7izz/h6ew
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="449314948"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="449314948"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 02:00:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1081934039"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="1081934039"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 02:00:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qnbG3-00000002RJS-1y5f;
        Tue, 03 Oct 2023 11:59:59 +0300
Date:   Tue, 3 Oct 2023 11:59:59 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1 2/2] pinctrl: lynxpoint: drop runtime PM support
Message-ID: <ZRvYDwbxPQOWGTvU@smile.fi.intel.com>
References: <20231003081519.27524-1-raag.jadav@intel.com>
 <20231003081519.27524-2-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003081519.27524-2-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 01:45:19PM +0530, Raag Jadav wrote:
> Since Lynxpoint pinctrl device is not attached to acpi_lpss_pm_domain,
> runtime PM serves no purpose here. Drop it and switch to pm_sleep_ptr()
> as now we only have resume handle in place.
> 
> No functional impact.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


