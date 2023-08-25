Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDE367884B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Aug 2023 12:21:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244242AbjHYKUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Aug 2023 06:20:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244454AbjHYKUQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Aug 2023 06:20:16 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0ABC9E;
        Fri, 25 Aug 2023 03:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692958814; x=1724494814;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=lQJ7DKzc2oXt4rUd3d6tJI49oHr2VicpFOk6XH2iFSs=;
  b=PGOPyNvXX3PKk1ywgg/RNVC3wUMrMLd89fR8PT59BcvpU3X+XVnwgrux
   XTxZb1qX+9M+S/kTsu1EGMIwJ5VAOGzNdmkvRezR8NUs0mGFLP9gZaKe5
   jgHhNvWvazj0enFbbAtji+3mMvE9FdqCxY8RJWDk1cdsuqz+nwHOcIsib
   MlBqRlQq/mPdn6lt7jnAc8+qesxASNyqUoOGjRXLneoOiZeoSNPL1NlRx
   lhlo74wpmZmk+wxx8ET5FK44wclLWlu9sr6ehf9M9/aeYiVidc5QiQc4A
   fvPFff7Ocfxw/MqAgXB2fiF+MxQ9a5m4Qxugaqb4WMv21epA5cwQbrsX1
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="378466533"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="378466533"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Aug 2023 03:19:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10812"; a="984065698"
X-IronPort-AV: E=Sophos;i="6.02,195,1688454000"; 
   d="scan'208";a="984065698"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 25 Aug 2023 03:19:40 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qZTuk-00CiqI-2Y;
        Fri, 25 Aug 2023 13:19:38 +0300
Date:   Fri, 25 Aug 2023 13:19:38 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Linhua Xu <Linhua.xu@unisoc.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        lh xu <xulh0829@gmail.com>,
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH 5/6] pinctrl: sprd: Increase the range of register values
Message-ID: <ZOiAOqpJsd7ljyal@smile.fi.intel.com>
References: <20230825031826.31599-1-Linhua.xu@unisoc.com>
 <20230825031826.31599-6-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230825031826.31599-6-Linhua.xu@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 25, 2023 at 11:18:25AM +0800, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> As the UNISOC pin controller version iterates, more registers are required
> to meet new functional requirements. Thus modify them.

...

+ bits.h and...

> +#define NUM_OFFSET	(22)
> +#define TYPE_OFFSET	(18)
> +#define BIT_OFFSET	(10)
> +#define WIDTH_OFFSET	(6)

Why do you need parentheses? Also what do these represent
(since they are decimal numbers)?

...

>  #define SPRD_PIN_INFO(num, type, offset, width, reg)	\
>  		(((num) & 0xFFF) << NUM_OFFSET |	\
>  		 ((type) & 0xF) << TYPE_OFFSET |	\
>  		 ((offset) & 0xFF) << BIT_OFFSET |	\
>  		 ((width) & 0xF) << WIDTH_OFFSET |	\
> -		 ((reg) & 0xF))
> +		 ((reg) & 0x1F))

...use GENMASK() everywhere above.

...

>  		.type = (((a) >> TYPE_OFFSET) & 0xf),		\
>  		.bit_offset = (((a) >> BIT_OFFSET) & 0xff),	\
>  		.bit_width = ((a) >> WIDTH_OFFSET & 0xf),	\
> -		.reg = ((a) & 0xf)				\
> +		.reg = ((a) & 0x1f)				\

Ditto.

-- 
With Best Regards,
Andy Shevchenko


