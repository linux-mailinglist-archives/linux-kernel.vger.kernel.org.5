Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F8C07CC361
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343714AbjJQMlq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:41:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233345AbjJQMlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:41:45 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFA2B6;
        Tue, 17 Oct 2023 05:41:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697546504; x=1729082504;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=DqvnkqZQqzze6HgU3TyN9STbBqmIck9svTPXj7BsI6o=;
  b=MsxJTOB77B+242DBDHi/DWMrG5diPk+mYX8D3ZH9yUhnrwYo6cwLlERv
   w5rpn3Ok8YJIOmbBLRR6b20IRa8zprB4C4XMcu9QQfetjqiwVBFoFsGfR
   3bCGDjYGrFvkBdqzS/Nt4qapHdwQ3YPyu4A99zYhMl0a5is4YZU8YG9SK
   AEeiSiSFf97BlfqmnCSC6qxWfNV6YyexSc2jDbrvxBPwwHS7WdYcduMZL
   jUJ0EKfZf14Dt6dgog4LX/HTeHfEbBSx1h3Rw1kG8pLRXROzbLsUznaIR
   8c6FinJlSei4fq8J+9CWQNf1c464uWxtPtQszg7RWNzKGpYOWrGJZztzQ
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="376137314"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="376137314"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:41:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="732712448"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="732712448"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga006.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:41:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qsjOF-00000006Ho0-00jH;
        Tue, 17 Oct 2023 15:41:39 +0300
Date:   Tue, 17 Oct 2023 15:41:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 54/73] pinctrl: intel: drop the wrappers around
 pinctrl_gpio_direction_input()
Message-ID: <ZS6BAkfFeA+6GYfz@smile.fi.intel.com>
References: <20231017120431.68847-1-brgl@bgdev.pl>
 <20231017120431.68847-55-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017120431.68847-55-brgl@bgdev.pl>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 02:04:12PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> pinctrl_gpio_direction_input() now has the same signature as the
> wrappers around it so we can drop them.

Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Now, for the sake of symmetry can you add (at least to the all
Intel drivers you modified in this series) the following:


int pinctrl_gpio_direction_output_with_value(struct gpio_chip *gc,
					     unsigned int offset, int value)
{
	gc->set(gc, offset, value);
        return pinctrl_gpio_direction_output(gc, offset);
}


?

And respectively in this driver

	.direction_output = pincttl_gpio_direction_output_with_value,


-- 
With Best Regards,
Andy Shevchenko


