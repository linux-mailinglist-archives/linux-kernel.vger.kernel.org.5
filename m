Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0758D7C59B8
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 18:58:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233207AbjJKQ6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 12:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230158AbjJKQ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 12:58:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27D3C8F;
        Wed, 11 Oct 2023 09:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697043514; x=1728579514;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Z5se6xYN/FXfpvGisGS7mwT3AWsP0eFELWW4F2YrIUE=;
  b=b1EGupwZ7mvOXIhZuSjflocd/Aw0msjx6fud8uFH7sGWp4qdUlrsPqAr
   bxHvpp2pXmBP4ES0gvSGhIbqWoKWLn/YqnTo4+oBDH4RrpexLeGM5A4rt
   jVdtIXsbIdBB9Do76jjJ+70FA79bMWwiPc81oi/oW7Vm1eAksms4Lb4Mp
   dC7jtbwaTBq5EPkOjOF2bL0Y909OhoQ/JYOsS0FUOfz2YRup/MGeOqCzp
   Gc4Y5Xf/Uajc8c0NFM160gD4Z3jtKB3+OP1YbxffgtCIixuMooY5wDSIp
   Pk5kTxg1uQyaqHLmvc1pEjl00MphSk6N5Fq7Tz2mxlRRPpR6goEj1KPfR
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="3303830"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="3303830"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 09:58:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10860"; a="927643842"
X-IronPort-AV: E=Sophos;i="6.03,216,1694761200"; 
   d="scan'208";a="927643842"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 09:58:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qqcXV-00000004n49-2GVv;
        Wed, 11 Oct 2023 19:58:29 +0300
Date:   Wed, 11 Oct 2023 19:58:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v2 04/62] gpio: cdev: use pinctrl_gpio_can_use_line_new()
Message-ID: <ZSbUNSgL2p356tMV@smile.fi.intel.com>
References: <20231011120830.49324-1-brgl@bgdev.pl>
 <20231011120830.49324-5-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011120830.49324-5-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 02:07:32PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Use the improved variant of pinctrl_gpio_can_use_line() which takes a
> pointer to the gpio_chip and a controller-relative offset.

Whatever name will be
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


