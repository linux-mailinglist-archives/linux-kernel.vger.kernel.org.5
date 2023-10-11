Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9623D7C5046
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Oct 2023 12:36:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231340AbjJKKgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Oct 2023 06:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjJKKgH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Oct 2023 06:36:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F92092;
        Wed, 11 Oct 2023 03:36:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697020565; x=1728556565;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=xi7AUnUq+Fp7Bte9LJF2zvczyMpeUeaIBpRiwTxaaZ8=;
  b=jBaL0/1DDHUjS91zWiyXAE6IrwnVB9yIv1/vczzu51vCgazGkl+c5gfV
   bOMeXazCBVNWRrV9r76IIRmE7n2rDdF5pWFN+iY+FWOOsnRYxnuj8Tzpb
   lGopswkBNHM9/c2VIrj+AohwG9m1UuUKsP0qafbqE/1gx8H44hzycXb0m
   Z+qF8fUUzDE1wiYK1PYbnRQZN5de1cKvu7YMPlNPCcyPHVMv4t9UbjnUy
   4GYmVN6Yr+Hpogb1uU8x9USGKD94FeRop4r85qZG9royhO2Zo3e2oK+rJ
   WKk5cbDCJ0dQhwMNFrFXJCi9QV+XE/37zAFwVzv8OPYu1GoYSPxELEA3f
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="451120773"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="451120773"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:34:17 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10859"; a="730446138"
X-IronPort-AV: E=Sophos;i="6.03,214,1694761200"; 
   d="scan'208";a="730446138"
Received: from unknown (HELO smile.fi.intel.com) ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Oct 2023 03:34:15 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qqWXc-00000004ayE-3EPX;
        Wed, 11 Oct 2023 13:34:12 +0300
Date:   Wed, 11 Oct 2023 13:34:12 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, pandith.n@intel.com
Subject: Re: [PATCH v1] pinctrl: intel: fetch community only when we need it
Message-ID: <ZSZ6JL2srqZUvakh@smile.fi.intel.com>
References: <20231011064218.19247-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231011064218.19247-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2023 at 12:12:18PM +0530, Raag Jadav wrote:
> We check community features only in case PIN_CONFIG_BIAS_PULL_DOWN while
> setting/getting pad termination. No need to fetch the community otherwise.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


