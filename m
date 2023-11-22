Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC2DC7F45F6
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Nov 2023 13:24:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344060AbjKVMYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Nov 2023 07:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344052AbjKVMYl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Nov 2023 07:24:41 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB206BB;
        Wed, 22 Nov 2023 04:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1700655876; x=1732191876;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kr7pFCA+hyLTInnoyirdGMzdzPrrMizL8DP7KhcstOM=;
  b=UPy0ZLvlu7b/EaoxU2CNyU+2uTNf7zl19KSYsNHIrNhTVmfqwcOOgUi2
   YYJIiYrfIxr8cxnOGD4YaIUEZMXH4okhIMABQ9uLddd3E82b2NkdedkYx
   kY5sP+xT1N1kyP8fbBXKyh8hb1cObX27/yRT7uQz5uTPehdRK+EZ6f1uP
   D3ptzQdbBNrEy3Jlo28ku3reXDcl57RYdoSCZ0ZgjZVqAetqagBP9lLH9
   cgSc2t+RhLiezsWJYt3K9aVo0+j7+wPtiEM0ZITHUnLvzjMwOTU5HRDZD
   CsNYBh8qGdHLKTj9M75ExBAP0Mh1+jOJdYhZ+HLNhaUOq+pnpL/xty6OA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="5184366"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="5184366"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:24:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10901"; a="1014216745"
X-IronPort-AV: E=Sophos;i="6.04,218,1695711600"; 
   d="scan'208";a="1014216745"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Nov 2023 04:24:33 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1r5m9W-0000000G5Jg-22HO;
        Wed, 22 Nov 2023 14:16:22 +0200
Date:   Wed, 22 Nov 2023 14:16:22 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v5 17/39] net: cirrus: add DT support for Cirrus EP93xx
Message-ID: <ZV3xFjmU56hwBfLc@smile.fi.intel.com>
References: <20231122-ep93xx-v5-0-d59a76d5df29@maquefel.me>
 <20231122-ep93xx-v5-17-d59a76d5df29@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231122-ep93xx-v5-17-d59a76d5df29@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 22, 2023 at 11:59:55AM +0300, Nikita Shubin wrote:
> - add OF ID match table
> - get phy_id from the device tree, as part of mdio
> - copy_addr is now always used, as there is no SoC/board that aren't
> - dropped platform header

...

>  #include <linux/interrupt.h>
>  #include <linux/moduleparam.h>
>  #include <linux/platform_device.h>
> +#include <linux/of.h>

Perhaps more ordering?

>  #include <linux/delay.h>
>  #include <linux/io.h>
>  #include <linux/slab.h>

...

> +	err = of_property_read_u32(np, "reg", &phy_id);
> +	of_node_put(np);
> +	if (err)
> +		return dev_err_probe(&pdev->dev, -ENOENT, "Failed to locate \"phy_id\"\n");

Why shadowing the actual error code?

> +
> +	dev = alloc_etherdev(sizeof(struct ep93xx_priv));
>  	if (dev == NULL) {
>  		err = -ENOMEM;
>  		goto err_out;
>  	}

-- 
With Best Regards,
Andy Shevchenko


