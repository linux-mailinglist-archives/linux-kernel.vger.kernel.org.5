Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1545D7FDA61
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:52:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234613AbjK2Ovv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:51:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234225AbjK2Ovt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:51:49 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BC9130;
        Wed, 29 Nov 2023 06:51:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701269514; x=1732805514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=fs4nT3+fIuEHZgrTiCBSWoggoTMx62a/i65Penk/AKg=;
  b=cYshQqF6HsMYWw2pa2+WIpxPIhikwVmcY42KhGtpwQ/tn8PibjUqeZYU
   GQJ3D3eoXNXe662U3ktEXFsztAM+bFhcyMGpMZg8WXZxbwe2/xuL4lkT1
   61jIYvBIx7CvqwV8u5KveZzONviquMN+c74JJQBeUVXVgwDtPMuYXrubI
   7CpV8M99J2PtpOBxwDGZvyYREi3+Ecmnz9xRajEVqpcJYleOQWjBioWYO
   NjiWvtvjxQwreuziv1uzGWSK8eyy8PSMNOexaVQm70FbEXYqOhmH7sD73
   EDcURoopqJIxu3+Am9XtGS4DuUNAnseE7gj96PMXYSzN6D49YvYZ1Lj5k
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="395987008"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="395987008"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:51:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="839453277"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="839453277"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:51:52 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8Luo-00000000Sxl-06bR;
        Wed, 29 Nov 2023 16:51:50 +0200
Date:   Wed, 29 Nov 2023 16:51:49 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 07/10] pinctrl: baytrail: use gpiochip_dup_line_label()
Message-ID: <ZWdQBWRNwPWXZqqo@smile.fi.intel.com>
References: <20231129142411.76863-1-brgl@bgdev.pl>
 <20231129142411.76863-8-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231129142411.76863-8-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:24:08PM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use the new gpiochip_dup_line_label() helper to safely retrieve the
> descriptor label.

I don't think it will be any collision with other Bay Trail patches,
but I would like to have an immutable branch that I can pull into my tree
(Intel pin control drivers).

-- 
With Best Regards,
Andy Shevchenko


