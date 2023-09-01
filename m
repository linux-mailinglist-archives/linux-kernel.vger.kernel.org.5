Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A479E78FCFE
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:15:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345727AbjIAMPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbjIAMPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:15:17 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80DC7E40;
        Fri,  1 Sep 2023 05:15:14 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="376138995"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="376138995"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:15:14 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="883170555"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="883170555"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:15:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qc33N-005fRS-1A;
        Fri, 01 Sep 2023 15:15:09 +0300
Date:   Fri, 1 Sep 2023 15:15:09 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 0/3] pinctrl: da9062: don't pull in internal GPIOLIB
 headers
Message-ID: <ZPHVzRPvstmnIyQj@smile.fi.intel.com>
References: <20230901112926.13216-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901112926.13216-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_SOFTFAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 01:29:23PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> I'm removing instances of users of internal GPIOLIB headers which should
> not be included by anyone but GPIO core code. The pinctrl-da9062 driver
> uses gpiochip_get_desc() which we should put into the gpio/driver.h
> header as it does sometimes make sense for GPIO providers to get its own
> descriptors without having to go through gpiochip_request_own_desc().

Reviewed-by: Andy Shevchenko <andy@kernel.org>

-- 
With Best Regards,
Andy Shevchenko


