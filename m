Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CC0E79CBF8
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 11:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232503AbjILJhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Sep 2023 05:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbjILJhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Sep 2023 05:37:07 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62D28116
        for <linux-kernel@vger.kernel.org>; Tue, 12 Sep 2023 02:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694511423; x=1726047423;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WqYuHuWBEhbVVx3fVuk2CQ/aPhBVdcOjOzZurmUHths=;
  b=BmVBDfEyuDHiI8tBvijg3eS9ERvzbpDXsuFuwXBia+Qgwu6ADlo0/Rqr
   7EVjHUMY4ZivEPBWtnXQjpvpb1lR5uRPTPq63FPC5vSw7CvsTv1WXjjfo
   3diC9MfqjU+KYqBSFNrdcgOCk4b1YeGfBGzJlF8HhIV7RrhMEli9Dz0NG
   R/Yo77ovHtD0rJwWpq+r0LzmCaCWHHTDyDs806EfA4Mq3ELF4AIuidjYX
   GCeTDLLEFpm9jd6rKJtUiPGxiDBHzZpl3FxlnXE5wwVG0B/7q7FkiTnro
   e+mSEHKj+xKDY9sPvz4TpjLmJSQuby2n5UABKIHcocwnQzQFR2xfyMhVL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="382137991"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="382137991"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 02:37:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10830"; a="778731161"
X-IronPort-AV: E=Sophos;i="6.02,139,1688454000"; 
   d="scan'208";a="778731161"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Sep 2023 02:37:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfzpJ-008Y95-25;
        Tue, 12 Sep 2023 12:36:57 +0300
Date:   Tue, 12 Sep 2023 12:36:57 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Yury Norov <yury.norov@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <marc.zyngier@arm.com>,
        linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH 1/4] bitmap: define a cleanup function for bitmaps
Message-ID: <ZQAxOVC0QIdTSNkU@smile.fi.intel.com>
References: <20230912085541.13682-1-brgl@bgdev.pl>
 <20230912085541.13682-2-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230912085541.13682-2-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2023 at 10:55:38AM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Add support for autopointers for bitmaps allocated with bitmap_alloc()
> et al.

Makes sense,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


