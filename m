Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FE777D96CE
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345737AbjJ0LlK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230101AbjJ0LlI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:41:08 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA132AC;
        Fri, 27 Oct 2023 04:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698406867; x=1729942867;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=tfYPNBrQrn/k/0WL1o63AtwhXR27xp15zWxe0UNlrOk=;
  b=oKrgOxVHrasCsnN2Kbe2eFYT/86lnX1JiB+nDBQB7aasUK1rTbADzyrn
   yGOC+JssPsvkDnRMaH1sZHDT7mWjT+p96CCKRduox/QE3a0va8lrtMGya
   PBHzi3oQ7Kqu+xM49aUZM5Uemr6hQH1bmP0PzrkH/crbMoPTgSLDjhSTX
   PYkK75qIu9xnkE594hG5MOtFYePUONUPc6lzpQEL7KjVXurMnm7KdD5r0
   3hNP7MqFQHoMg8RAYgll4TRAhMLTYl7BhEWoaBv4abSnVGfQbSn92Vamv
   NyFiBNv0NqmthW/zS63OHp4fEPcL+7iXdrMhNL10wWaWhHHGJp3bmfsbM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="6387682"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="6387682"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:41:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="883161150"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="883161150"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:41:01 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qwLD0-000000098Gb-3OxA;
        Fri, 27 Oct 2023 14:40:58 +0300
Date:   Fri, 27 Oct 2023 14:40:58 +0300
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
Subject: Re: [PATCH V3 5/6] pinctrl: sprd: Add pinctrl support for UMS512
Message-ID: <ZTuhynkAntZ0jDne@smile.fi.intel.com>
References: <20231027071426.17724-1-Linhua.xu@unisoc.com>
 <20231027071426.17724-6-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027071426.17724-6-Linhua.xu@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 03:14:25PM +0800, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> Add the pin control driver for UNISOC UMS512 platform.

...

> +#include <linux/kernel.h>

array_size.h is pending for v6.7-rc1.

-- 
With Best Regards,
Andy Shevchenko


