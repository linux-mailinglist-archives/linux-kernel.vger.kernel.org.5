Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0279F7D96FD
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 13:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345737AbjJ0Lxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 07:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231302AbjJ0Lxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 07:53:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380F7C0;
        Fri, 27 Oct 2023 04:53:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698407627; x=1729943627;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6j4nEEHAKMjdOyJDZ/9IAVm04nHIqIN/b9c9uN60LTU=;
  b=bkIx6pvr0BHIaAukcbRJ1Pao2NXZCoeJ5eFqzr5tjaov/tyQqvguqDZA
   k67Oka6jQbJdZtBQCiRrNZbFOIBzCvAcfS5aCZczynWbT4LKDzHk6RT4E
   Es5rK11+0F/SwW2VumLep478mp90xGfAflQ1P/WKE9/JZXmajAy1tdVtN
   tnW9QNCk6KU06mqJnojrdbIabfdxSbY5d/q6k6ogGOtwkMe31JjmBKQdF
   efsIEno7/Y2Sojcv9uLnlrk3Gaha3DLKqJd4wTFSYLdfRL6CkynWdi45p
   rqwoXIY7SHbxt5tmTQhJpIfXghOz23R2dceg6Rh66MT0khPF//1EJ+hB9
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="552742"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="552742"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:53:47 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10875"; a="850225852"
X-IronPort-AV: E=Sophos;i="6.03,256,1694761200"; 
   d="scan'208";a="850225852"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Oct 2023 04:53:44 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qwLEH-000000098HO-1RTk;
        Fri, 27 Oct 2023 14:42:17 +0300
Date:   Fri, 27 Oct 2023 14:42:17 +0300
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
Subject: Re: [PATCH V3 6/6] pinctrl: sprd: Add pinctrl support for UMS9621
Message-ID: <ZTuiGakYZvv7Db1u@smile.fi.intel.com>
References: <20231027071426.17724-1-Linhua.xu@unisoc.com>
 <20231027071426.17724-7-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231027071426.17724-7-Linhua.xu@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 27, 2023 at 03:14:26PM +0800, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> Add the pin control driver for UNISOC UMS9621 platform.

...

> +#include <linux/kernel.h>

array_size.h

-- 
With Best Regards,
Andy Shevchenko


