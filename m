Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D577F35B7
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Nov 2023 19:11:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234310AbjKUSLz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Nov 2023 13:11:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjKUSLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Nov 2023 13:11:52 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C636F9;
        Tue, 21 Nov 2023 10:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700590309; x=1732126309;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6gNaIiHSkGOx3pUPJYXxwWlzVU2Zgy4WYJYQocOPIYw=;
  b=NY7HjabjmQ+PvDEkKeFzMNvRXxjMUv1eJsLq8aLVy10sgUngp9lE2lYL
   XaT8lKc2KRgOiUrQ7ujfqeurlvrAlN2zpko7cKnG0rE0V1x2waOGQR138
   lXcGX1/OK2PH4MG6DgnlNcdgwkoiYiRdT0VH3hEga33BmU0wd1Lod0xwy
   IkNgVRqD5/kYH570/O3TIgCazGSSLJyw7PJc631oEPDt1yOjEsSQON1B5
   ++rkYBp5RWfTIeuWYJoXRkgbs6S4dXusAjqYdT/tL0c650c1B+sw6P+ns
   2APk0f44tnkQnjlnebgqHSC3X7hUgnemMUHHu3unt+4eBtEzgSu3zt3lP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="13443304"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="13443304"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 10:11:45 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1013992261"
X-IronPort-AV: E=Sophos;i="6.04,216,1695711600"; 
   d="scan'208";a="1013992261"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Nov 2023 10:11:42 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r5VDo-0000000Fsrj-1UCn;
        Tue, 21 Nov 2023 20:11:40 +0200
Date:   Tue, 21 Nov 2023 20:11:39 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     openbmc@lists.ozlabs.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: nuvoton: Convert to use struct pingroup
 and PINCTRL_PINGROUP()
Message-ID: <ZVzy227f3cIiTmtE@smile.fi.intel.com>
References: <20231120194802.1675239-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231120194802.1675239-1-andriy.shevchenko@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 20, 2023 at 09:48:02PM +0200, Andy Shevchenko wrote:
> The pin control header provides struct pingroup and PINCTRL_PINGROUP() macro.
> Utilize them instead of open coded variants in the driver.

Linus, I dunno if you are going to apply this sooner (assuming Jonathan is okay
with the change), but I have a bigger pending series where this will be a
prerequisite. So, when I will be ready and if it's not being applied (yet),
I'll include it into the bigger series as well.

-- 
With Best Regards,
Andy Shevchenko


