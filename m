Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A728B811CD8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Dec 2023 19:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjLMSkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Dec 2023 13:40:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233608AbjLMSjx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Dec 2023 13:39:53 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 031E6E8;
        Wed, 13 Dec 2023 10:39:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1702492800; x=1734028800;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=vzBAwjlFm5H0wFZOlwVBNUmWUdvXmVh+00/0g4KYWUs=;
  b=IGpp4VpG60n+LNJHHKndLwHeZbXkv0TuSuSAINqNz9SdavA7ILlbHRy5
   TRjtUAaG7gDwnjcwEvvL7jpI7xxA2PtzfPN0BTzbcV3lq9Xs0LVqUCS9o
   cjcTtmtFsGtYi3l0ga3KPxKjyfYIKS85MTUqTZk26ZP/xPlXGKZMQLLCI
   Asrvvg87R1DhUm4ud0c/HTkSxkzznVZBUiXtZU8O7tMfXxTqmPDMhCkUt
   J5o5yfLSS5BimQ2ar7dQuUDaV8MQ6IyArxU9XF41rRkNqB62AmkTZgHSI
   u3KVAcjuwS0WYNz0TrV+vL7KCbBcgagH2G3k3v/JbxuX21OaDqmF0S+OJ
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1846436"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="1846436"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:39:59 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10923"; a="1105398045"
X-IronPort-AV: E=Sophos;i="6.04,273,1695711600"; 
   d="scan'208";a="1105398045"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2023 10:39:56 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1rDU9B-00000005bvv-1PfY;
        Wed, 13 Dec 2023 20:39:53 +0200
Date:   Wed, 13 Dec 2023 20:39:53 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     Nikita Shubin <nikita.shubin@maquefel.me>
Cc:     Hartley Sweeten <hsweeten@visionengravers.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Andrew Lunn <andrew@lunn.ch>
Subject: Re: [PATCH v6 18/40] net: cirrus: add DT support for Cirrus EP93xx
Message-ID: <ZXn6ebDA0Eo4G1Aa@smile.fi.intel.com>
References: <20231212-ep93xx-v6-0-c307b8ac9aa8@maquefel.me>
 <20231212-ep93xx-v6-18-c307b8ac9aa8@maquefel.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231212-ep93xx-v6-18-c307b8ac9aa8@maquefel.me>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 12, 2023 at 11:20:35AM +0300, Nikita Shubin wrote:
> - add OF ID match table
> - get phy_id from the device tree, as part of mdio
> - copy_addr is now always used, as there is no SoC/board that aren't
> - dropped platform header

...

>  	mem = platform_get_resource(pdev, IORESOURCE_MEM, 0);
>  	irq = platform_get_irq(pdev, 0);
>  	if (!mem || irq < 0)
>  		return -ENXIO;

Strictly speaking these should be separated and different codes being retuned as
platform_get_irq() might return something different in some cases.

	irq = platform_get_irq(pdev, 0);
	if (irq < 0)
		return irq;

> +	base_addr = ioremap(mem->start, resource_size(mem));
> +	if (!base_addr)
> +		return dev_err_probe(&pdev->dev, -EIO, "Failed to ioremap ethernet registers\n");

Hmm... Why not devm_platform_ioremap_resource()?

-- 
With Best Regards,
Andy Shevchenko


