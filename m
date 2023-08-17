Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17DDB77F3F0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 11:56:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349856AbjHQJ4L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 05:56:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349694AbjHQJzq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 05:55:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2448C12C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 02:55:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692266145; x=1723802145;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cEgKWuUIDW+33geAvq557YwB+uPMZ6s35JZ4SFcploQ=;
  b=RL021IcrcMtg91WyfjZXxWVomjQRcWMVx5chedHQB4VyAVhrG0g/7jNh
   at92DQxpfKaG5F9cFZF5/ilZc3HB7YnUBqerqz7MAKgm7HltNHQ1f+8ua
   6IDGW41z9x3n5dq/7YOWQoF7SAFsMYvdLWrp2/8Vy6/+z7dLZWP0Vk2eZ
   Y1aAP6BIz/8I7HC5SNWuLSa8GPbpAnl2Mh6//1I8H5nDtJ3THDxpKDlaA
   3Rc/H3uFssT8YKV5CFBX7LfHvJszd75r8Xja5JWRHTKxMgJSVQitgKPsu
   vXRDdS2I+rouYrgvD0GzGRT7mqOlKSMFYZGDrM8q10OTjMlltoYbISMMX
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="376503522"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="376503522"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2023 02:55:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10803"; a="799981391"
X-IronPort-AV: E=Sophos;i="6.01,179,1684825200"; 
   d="scan'208";a="799981391"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 17 Aug 2023 02:55:42 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWZjB-0066W9-11;
        Thu, 17 Aug 2023 12:55:41 +0300
Date:   Thu, 17 Aug 2023 12:55:41 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: drivers/gpio/gpio-pca9570.c:42: warning: Function parameter or
 member 'chip_data' not described in 'pca9570'
Message-ID: <ZN3undSeTOPCM/za@smile.fi.intel.com>
References: <202308171538.nKKUOtbg-lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202308171538.nKKUOtbg-lkp@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 03:11:09PM +0800, kernel test robot wrote:
> Hi Bartosz,

...

> >> drivers/gpio/gpio-pca9570.c:42: warning: Function parameter or member 'chip_data' not described in 'pca9570'

Blame Bart for this :-)

> b8a34582c7f7f2 Shubhrajyoti Datta  2022-10-26  29  
> 16d44b6085c1d9 Sungbo Eo           2020-07-09  30  /**
> 16d44b6085c1d9 Sungbo Eo           2020-07-09  31   * struct pca9570 - GPIO driver data
> 16d44b6085c1d9 Sungbo Eo           2020-07-09  32   * @chip: GPIO controller chip
> b8a34582c7f7f2 Shubhrajyoti Datta  2022-10-26  33   * @p_data: GPIO controller platform data


So, should be @chip_data...

> 16d44b6085c1d9 Sungbo Eo           2020-07-09  34   * @lock: Protects write sequences
> 16d44b6085c1d9 Sungbo Eo           2020-07-09  35   * @out: Buffer for device register
> 16d44b6085c1d9 Sungbo Eo           2020-07-09  36   */
> 16d44b6085c1d9 Sungbo Eo           2020-07-09  37  struct pca9570 {
> 16d44b6085c1d9 Sungbo Eo           2020-07-09  38  	struct gpio_chip chip;
> a3f7c1d6ddcbd4 Bartosz Golaszewski 2022-12-30  39  	const struct pca9570_chip_data *chip_data;
> 16d44b6085c1d9 Sungbo Eo           2020-07-09  40  	struct mutex lock;
> 16d44b6085c1d9 Sungbo Eo           2020-07-09  41  	u8 out;
> 16d44b6085c1d9 Sungbo Eo           2020-07-09 @42  };

-- 
With Best Regards,
Andy Shevchenko


