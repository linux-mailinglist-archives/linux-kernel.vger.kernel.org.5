Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F2B78FCFB
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:13:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349364AbjIAMNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232105AbjIAMNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:13:34 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73DC0CF3;
        Fri,  1 Sep 2023 05:13:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693570411; x=1725106411;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=mbyeExEHy3Gg2DuAUnH40X7OvWSsiX4l7lADhQMzWUk=;
  b=LThDZoG2uXGEeHQYosbhDFJSAOUXs7LEr39Ct6lNNi3oWj/RQddgZF74
   8L72J8zU+/xPqVI5AThOklt/kETkG7AtTCA01sObRGJ1qLstkEZrXnOJJ
   bgJmCcKVN7UK4vMHv1WIuG+sQZ2UFZ4+T5mI4fMrfRM0U67GY/fp5idK7
   nFZNJSKKRh0IjwYacBuUiJD1F9Nv1foo0PEyyf/LN3npXVzM9v3b3ufJ/
   xDKVh68uT1QMd4AFvPmNoOk5vrpF/+6e27icOjzw1mig9spru2joRMFbo
   1AeWPCF231sZeOg0SaItizINqzcGjTemhuPg6qR3+Pjt0YAIENHK74Anr
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="355705546"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="355705546"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:13:30 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="716753303"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="716753303"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:13:28 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qc31i-005fPt-0N;
        Fri, 01 Sep 2023 15:13:26 +0300
Date:   Fri, 1 Sep 2023 15:13:25 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: remove stray newline in gpio/driver.h
Message-ID: <ZPHVZQ3NmqWE1cYg@smile.fi.intel.com>
References: <20230901113520.13352-1-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230901113520.13352-1-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 01:35:20PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> Fix a double newline in the GPIO provider header.

Separate patch for this?!
I would just fold it in the extern removal and that's it.

-- 
With Best Regards,
Andy Shevchenko


