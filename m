Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACCFC774096
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:05:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229730AbjHHRF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjHHREo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:04:44 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB2EB19BEA;
        Tue,  8 Aug 2023 09:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510524; x=1723046524;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tMJrfIaDobN4ipiyrDWHuNHNte9Iz5SKbwSXc9SphBo=;
  b=CXa15VOHxdqZP5y1ceXt4R+I1f7QOD6G1f/xbAFLFN1c6HsYyZ4RCuoR
   xIwZ5/ihEPpbWhjrfqiFJLUABxTC+gZXShkuf7THec5s3Ef9R+N2QlAnY
   EtkEI6INjxcfTuLI8FL+zQGQ1FUr+8p5SrUsF3L4ND9jkaEeOKbFbmo6l
   O1Za/ELQPXoQNFfiPuRfW4FMAduzpf51jD7D+cHNdauzwhR7r18u/14gH
   wFO7fq5FHtCzqHLOHZWTOeVnGcAJGlopuwx/PH7+1uUk+mMrNDD5GrwqH
   FvQGKoF9sqXp10V9GzQN2W1gwRYCr5OomdlGk3Z/I5GU7D87utmm2OlrC
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373575133"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="373575133"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:53:57 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="724930236"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="724930236"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 08 Aug 2023 06:53:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTN9j-00AdSU-01;
        Tue, 08 Aug 2023 16:53:51 +0300
Date:   Tue, 8 Aug 2023 16:53:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Nuno =?iso-8859-1?Q?S=E1?= <nuno.sa@analog.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Samuel Holland <samuel@sholland.org>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        wenhua lin <wenhua.lin1994@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH] input: keyboard: Add sprd-keypad driver
Message-ID: <ZNJI7pJKzs5/9KrV@smile.fi.intel.com>
References: <20230808072501.3393-1-Wenhua.Lin@unisoc.com>
 <20230808100721.00006775@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230808100721.00006775@Huawei.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 10:07:21AM +0100, Jonathan Cameron wrote:
> On Tue, 8 Aug 2023 15:25:01 +0800
> Wenhua Lin <Wenhua.Lin@unisoc.com> wrote:

...

> > +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> > +	data->base = devm_ioremap_resource(&pdev->dev, res);
> 
> devm_platform_get_and_ioremap_resource)

Is res used anywhere else?

> > +	if (IS_ERR(data->base)) {
> > +		dev_err(&pdev->dev, "ioremap resource failed.\n");
> > +		ret =  PTR_ERR(data->base);
> > +		goto err_free;
> 
> Read up on what devm calls do - there is no need to manually free
> things that were allocated with them in the error paths or remove.
> So this should be a direct return. Also use
> 		return dev_err_probe(&pdev->dev, PTR_ERR(data->base),
> 				     "....")

Btw, with

	struct device *dev = &pdev->dev;

all these become neater.

> It both creates neater code and for cases where deferred probing
> is possible you will get a nice message on 'why' registered for
> debug purposes.
> 
> > +	}

-- 
With Best Regards,
Andy Shevchenko


