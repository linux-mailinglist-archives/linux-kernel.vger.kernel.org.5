Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DECEF7CC32F
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343672AbjJQM2x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:28:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232763AbjJQM2u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:28:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09949120;
        Tue, 17 Oct 2023 05:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697545729; x=1729081729;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=VS/4hgHGNPQNPkCsYFXnIvv0lB2nn/ohpybKAs9rvpE=;
  b=l4hjgAklm/4y3QJVpcrt8C0Jpa88gBlRafLn7vbmqdkkE7g2DnOHXkRZ
   Lz03LYf8j02N5Ip1HF7cVqslwcXCfYxrh5DQ+sbW6lwA9ZRXixydnOzgW
   jPJZQi8ZT6TidvbTNrVdMajSA+4QU1mkL3OcQN8Bgycoi1bfyFMGiILt2
   BaihEAOBZ52eZzTnxc8WM+isfjUpnEYNS1h9fYHMKGQudVkY2X+w2vaFv
   WDMwwBXV3ahVfvChA6SZBB7eRgkfSasmH300/5nRAE+ttpYqXjnfFV1N0
   mEIK3E7UuxApEoLTTsLf6/T4YsseiwY0Lfpzkt+gsEjwIL2lkfOIFbmWc
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="376135196"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="376135196"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:28:48 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="879801470"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="879801470"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:28:46 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qsjBg-00000006Hds-3xhk;
        Tue, 17 Oct 2023 15:28:40 +0300
Date:   Tue, 17 Oct 2023 15:28:40 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH v3 53/73] pinctrl: intel: lynxpoint: drop the wrappers
 around pinctrl_gpio_direction_input()
Message-ID: <ZS59+F8trJIjZ1hl@smile.fi.intel.com>
References: <20231017120431.68847-1-brgl@bgdev.pl>
 <20231017120431.68847-54-brgl@bgdev.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231017120431.68847-54-brgl@bgdev.pl>
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

On Tue, Oct 17, 2023 at 02:04:11PM +0200, Bartosz Golaszewski wrote:
> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> 
> pinctrl_gpio_direction_input() now has the same signature as the
> wrappers around it so we can drop them.

W/o "intel:" part in the Subj
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


