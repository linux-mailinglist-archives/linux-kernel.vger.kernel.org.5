Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5946579B482
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 02:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358784AbjIKWN3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:13:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236202AbjIKJzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 05:55:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 799B0E67;
        Mon, 11 Sep 2023 02:55:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694426137; x=1725962137;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0JcFDOUw0C238xlJbCbweIkrVkXKg1zh7PJyy8AyPxY=;
  b=Gufs04b97kcySToqEwElpDD6IW5QH7ki6WKiCR2cPNhUOoMjjnGgTuhz
   LlOgKCBfkV0F5WyfvuMuEdBC06z0H5CwYnmxTtvmWBPql+bNq5InAj3Jc
   6yoY8dTeTUT+vrZkdw8qd5/Buj+BeZAMltHVKx/2f1Ztodmt8/neyT+aN
   jCeMT1pQcOhb5vAdAVsxnmDYDruvefJIddMCSp7fa6I7O2b0XBaIznSkk
   LY6QM+KQs56Q4oR3VDBH5eo/0QtOLOcpDV6p7ygRgbtY6InkMJR3JVH/Z
   vr2IbSuG8Vc0CffFN758cPkXeCNUkSzcwMbL+lZwLUXRUlHSMqZKQCLBw
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="444458285"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="444458285"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 02:55:36 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="808781738"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="808781738"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 02:55:33 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfddi-008HfF-2S;
        Mon, 11 Sep 2023 12:55:30 +0300
Date:   Mon, 11 Sep 2023 12:55:30 +0300
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
Subject: Re: [PATCH V2 5/6] pinctrl: sprd: Increase the range of register
 values
Message-ID: <ZP7kErjprsXbe7wv@smile.fi.intel.com>
References: <20230908055146.18347-1-Linhua.xu@unisoc.com>
 <20230908055146.18347-6-Linhua.xu@unisoc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230908055146.18347-6-Linhua.xu@unisoc.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 08, 2023 at 01:51:45PM +0800, Linhua Xu wrote:
> From: Linhua Xu <Linhua.Xu@unisoc.com>
> 
> As the UNISOC pin controller version iterates, more registers are required
> to meet new functional requirements. Thus modify them.

LGTM,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


