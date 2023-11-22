Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E92607F4FB4
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 19:36:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjKVSg7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 13:36:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231470AbjKVSg5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 13:36:57 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5566D62;
        Wed, 22 Nov 2023 10:36:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700678213; x=1732214213;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c0xFg9deCV85cczPKWp2cY1uCXt2E2OindP8iQIcnNs=;
  b=bPmszwYKtyPKJx26DKefGFJjHK2VqowWv9nCa+Wag5wU5ildmYXUa9kT
   rIHY53U5bP4IRC5611Dsy5QeKa4McIZyiV6PPJVRksATNVIBRXG38VKUh
   BcrUE0u0VGYaI0SSDcSPwssNP8Z7WU2XYcV0RxutFE4HDr6S+X7v4e6sP
   gNOT9Tzvq8A2alFerazUAkNGq+Y7vpgkIowonzYGUC/XHPQ0fuv/ZWL0R
   D7WytgVfTshVkvf/fDVbpW/SLMowLboWatu5saJDk5CUN4QrKnb+wdINO
   XgelYf6pWX3tKb4RBUg8zNxjmET9GdDu5Vi1+U0Jyke9Gw2Y4mxc54e2+
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10902"; a="423227842"
X-IronPort-AV: E=Sophos;i="6.04,219,1695711600"; 
   d="scan'208";a="423227842"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 10:30:53 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="716789936"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="716789936"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 03:17:22 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r5l1m-0000000G4Mg-2yei;
        Wed, 22 Nov 2023 13:04:18 +0200
Date:   Wed, 22 Nov 2023 13:04:18 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     mika.westerberg@linux.intel.com, linus.walleij@linaro.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v1] pinctrl: intel: use the correct _PM_OPS() export macro
Message-ID: <ZV3gMilp-vhSPxc9@smile.fi.intel.com>
References: <20231122105401.11006-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122105401.11006-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 04:24:01PM +0530, Raag Jadav wrote:
> Since we don't have runtime PM handles here, we should be using
> EXPORT_NS_GPL_DEV_SLEEP_PM_OPS() macro, so that the compiler can
> discard it in case CONFIG_PM_SLEEP=n.

Obviously correct fix, I've pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


