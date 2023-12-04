Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AD080344B
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 14:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233789AbjLDNS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 08:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229711AbjLDNS4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 08:18:56 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B9B4AC;
        Mon,  4 Dec 2023 05:19:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701695944; x=1733231944;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=blRWcQemAp0zrvU2vELHpiLg3H45UrfeHyClI630l4s=;
  b=WNMu+zTVANQ8c5CNjeNwp88HDiYqTSN5oTWng5FKsIyl+08ocJNoSnUb
   Q2yuHhKuobH2ZtyB8mtcpXt4++/bGzkuLgY3NHaUjZDT00MvMxiEHmss+
   SQLiPDpSQFo+MzXT67qEuqVq6aOnp6DNywUMnwoMdg4WnSZ5VFS38MU55
   ILYs7o1xBMywTOvIFqKEqB/z1gGVjEaV+LnHSoPbG+TbxefJ+Hh2YtpJC
   nEUEBfgXkAxXrd/Ct4MyKkLIHIiObyE20tIwRvIGLJPLxpkHefzpRIE2+
   7Dg/w+brLafuZHu1K49xCMETU3SJ4xqMjN9o8LQ04b+UaEnJhcWMykFMZ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="775926"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="775926"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:19:03 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="720319000"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="720319000"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 05:19:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rA8qg-00000001l0l-2AuV;
        Mon, 04 Dec 2023 15:18:58 +0200
Date:   Mon, 4 Dec 2023 15:18:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 07/10] pinctrl: baytrail: use gpiochip_dup_line_label()
Message-ID: <ZW3RwqZHvRRoYLXn@smile.fi.intel.com>
References: <20231204093509.19225-1-brgl@bgdev.pl>
 <20231204093509.19225-8-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204093509.19225-8-brgl@bgdev.pl>
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

On Mon, Dec 04, 2023 at 10:35:06AM +0100, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use the new gpiochip_dup_line_label() helper to safely retrieve the
> descriptor label.

Fine by me,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Still would be nice to have an immutable tag/branch with the first and
this patches (at least) that I can incorporate into my pin control tree
(TBH I do not expect collisions, but just in case).

-- 
With Best Regards,
Andy Shevchenko


