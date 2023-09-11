Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D92F079B037
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbjIKV30 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 17:29:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbjIKJ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:57:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B663E67;
        Mon, 11 Sep 2023 02:56:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694426219; x=1725962219;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ccQZ6EnQu6CIa4qQy8IVpBeF7c/wK9EQzEgUbK0W49o=;
  b=dZrlgsMSh0TpyU355X8TOEnys/BiZwbTIQZZgbryD7p94/ae/NPAyG+3
   yunQwMDXHYFtQI6V1rhghUfhhu9I8U1BVzxZA/LzdMijCERUcrI2XcY3P
   UVc+swih/50JEIEPKCFA6u7Lpoersr0PRa+UMqzu0ahACSXliskUB4jxD
   Min+NXyekbaOWnO7Qx5FRXvMmW1ZZwEqI5eMLDw66/6dgXJRiLEb4L1cz
   3Z8PpFSOFE6wpaqf7AS4Tv+997LvPF2zVgsZI7fnFBxlm4a9raWgA7vBS
   udtyDCZXlm361j6VPN4zHHEwqNV1MmFE9AwwyCksQ1vfU7aeH1WLZwo0J
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="363064646"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="363064646"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 02:56:59 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="866883398"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="866883398"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 02:56:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfdf3-008HgA-19;
        Mon, 11 Sep 2023 12:56:53 +0300
Date:   Mon, 11 Sep 2023 12:56:53 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linhua Xu <Linhua.xu@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        lh xu <xulh0829@gmail.com>,
        Zhirong Qiu <zhirong.qiu@unisoc.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH V2 6/6] pinctrl: sprd: Add pinctrl support for UMS9621
Message-ID: <ZP7kZUV2MQPYLZwM@smile.fi.intel.com>
References: <20230908055146.18347-1-Linhua.xu@unisoc.com>
 <20230908055146.18347-7-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908055146.18347-7-Linhua.xu@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 01:51:46PM +0800, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> Add the pin control driver for UNISOC UMS9621 platform.

> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/mod_devicetable.h>
> +#include <linux/platform_device.h>
> +

...

> +#define	PINCTRL_REG_OFFSET		0x44

0x0044

> +#define	PINCTRL_REG_MISC_OFFSET		0x444

...

> +static const struct of_device_id sprd_pinctrl_of_match[] = {
> +	{ .compatible = "sprd,ums9621-pinctrl", },

Inner comma is not needed.

> +	{ }
> +};


-- 
With Best Regards,
Andy Shevchenko


