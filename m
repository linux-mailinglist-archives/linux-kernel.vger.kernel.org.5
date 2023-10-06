Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 137247BB2FD
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 10:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230457AbjJFIYD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 04:24:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbjJFIYC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 04:24:02 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D743E4;
        Fri,  6 Oct 2023 01:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696580641; x=1728116641;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=E80aXb6KA2m/idUhBmAYneH/x7DAi94bVX2/wa6rCbA=;
  b=bfzPyQ0uOM0YzkUGh6LTLKhpCP9ySEu8LDNIyJLvIEKwAJhTj9KSrqlM
   GmnQRTQ1LUq58Uj39Pi7buIWGyxPiz70pbwG/yo8UryI/Q+SSV6UW6lOE
   fQ2cZ37XUcIPKiMLMg+FqKGVnu7ssvLQfxn3AWHr4ygFvaMdMvf69Bq6o
   xd75oGALtOU8qGLaI5+xiquqFU2VFQUdziZ+5vopeLFF74a5DjqLgsN/m
   a5LcoNeZRO4Dd5+FvfGUPufZf5cJkohU02Wvg6J2eTTEerMrNIwvp+UF2
   MrbXWk5OLnvGUey300AhxME9wK4jfxD7ymviKRBHWSEMQgYeGjuKNbQeV
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="363982760"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="363982760"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 01:24:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10854"; a="752112540"
X-IronPort-AV: E=Sophos;i="6.03,203,1694761200"; 
   d="scan'208";a="752112540"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Oct 2023 01:23:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qog7o-00000003EjU-2xs2;
        Fri, 06 Oct 2023 11:23:56 +0300
Date:   Fri, 6 Oct 2023 11:23:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH v1 1/1] pinctrl: broxton: Replace MODULE_ALIAS() with
 MODULE_DEVICE_TABLE()
Message-ID: <ZR/EHJCpzayD6i9H@smile.fi.intel.com>
References: <20231005133949.3613943-1-andriy.shevchenko@linux.intel.com>
 <0a25dad3-85d0-4bb5-8246-093057519e7b@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0a25dad3-85d0-4bb5-8246-093057519e7b@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2023 at 04:32:51PM +0200, Krzysztof Kozlowski wrote:
> On 05/10/2023 15:39, Andy Shevchenko wrote:
> > As Krzysztof pointed out the better is to use MODULE_DEVICE_TABLE()
> > as it will be consistent with the content of the real ID table of
> > the platform devices.

> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


