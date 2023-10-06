Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08B5E7BB2FF
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:24:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjJFIYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjJFIYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:24:42 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EE1E9;
        Fri,  6 Oct 2023 01:24:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696580681; x=1728116681;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ljf1waUrf7As+d2A5ertm4/iT3Jf09hV/mMqxFU7rx0=;
  b=nyGwma2iHwE0RWHp+hrIE4a7cPD1OrRcUpblpKYCPB1Obd/L1m1VDzBm
   IN5B1QsKV87AHUnin0EGil/OAEOUKJGqIA31j9LcSiyIZoF8smyO9ru3H
   G+M9RbguiI/rLn3lpPOvO8+BaRx0QKgElwmfGEMfa3TKXwOJcunuaNh9F
   V5TNmQEl2e2nSh62TCSYYBQNM6BfLiE0WBgBrBH3oyhfvNEKTJXDK7pGe
   hNvgelFNookPpeYicnt3ypJ+EkW/Spaqz46AtlsrYct+kx4HU1OK2A/ID
   lF/SQ3NmJznfuPU84GDrVzgYVqhpAypy60IJBvJEhDKsOYZdJs4+sIMcx
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="363061606"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="363061606"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 01:24:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="701978464"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="701978464"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 01:24:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qog8S-00000003Ejw-46EN;
        Fri, 06 Oct 2023 11:24:36 +0300
Date:   Fri, 6 Oct 2023 11:24:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: denverton: Replace MODULE_ALIAS() with
 MODULE_DEVICE_TABLE()
Message-ID: <ZR/ERJFFS1DGDb6b@smile.fi.intel.com>
References: <20231005135945.3672438-1-andriy.shevchenko@linux.intel.com>
 <63e5048b-094d-42f5-a56d-94969ba0c43e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <63e5048b-094d-42f5-a56d-94969ba0c43e@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 04:32:38PM +0200, Krzysztof Kozlowski wrote:
> On 05/10/2023 15:59, Andy Shevchenko wrote:
> > As Krzysztof pointed out the better is to use MODULE_DEVICE_TABLE()
> > as it will be consistent with the content of the real ID table of
> > the platform devices.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


