Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7365A7CC37B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234686AbjJQMpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234486AbjJQMpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:45:06 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1DB2FF;
        Tue, 17 Oct 2023 05:45:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697546705; x=1729082705;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kto6jz9elBjTmX5T+91rtJGIQe9VMYdugkFMyKMTbTQ=;
  b=NJMOqrtg5wZhv9xCmw/FNLB3EXv3sEX2JUDQfF0dyZ5pc5MhFCMGAZgl
   G/hQUSPdgUqRwfbuS9h1GnoyPhOhe5Nrf6KkXy4YGHT/BlqFMWMXq/Yxn
   qCvFcByYyojFlx7xg3nPQ1daAJOeeeaFMxhrrqaRSTOZnlt9by0h+5Ipv
   Qth9jUpphg8bSbejcVeyD5HH2eYIdq54Xa5Ro39zLr3NzsB5m6ZHvhFSe
   pQBzm6ygpifSALRRrrXEt49UTziPFF3arQaV7nuObFibUsXxzXbyC/0OX
   BGOLNTe6F9xxSIMDskDtTpRI+GMi6aVfc8JNn0f+/qlPzsiUsRXwdAmkT
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="4372348"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="4372348"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:45:05 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="785476151"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="785476151"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:45:02 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qsjRU-00000006Hqy-1Dcu;
        Tue, 17 Oct 2023 15:45:00 +0300
Date:   Tue, 17 Oct 2023 15:45:00 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 59/73] pinctrl: cy8c95x0: drop the wrapper around
 pinctrl_gpio_direction_input()
Message-ID: <ZS6BzAfieYPLH+FF@smile.fi.intel.com>
References: <20231017120431.68847-1-brgl@bgdev.pl>
 <20231017120431.68847-60-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017120431.68847-60-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 02:04:17PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> pinctrl_gpio_direction_input() now has the same signature as the
> wrapper around it so we can drop them.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

with the same comment as per Intel drivers, i.e.
use pinctrl_gpio_direction_output_with_value().

-- 
With Best Regards,
Andy Shevchenko


