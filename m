Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2450378FDB4
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 14:48:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbjIAMs3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 08:48:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235386AbjIAMs2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 08:48:28 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6BE81731;
        Fri,  1 Sep 2023 05:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693572472; x=1725108472;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=F3Mb862bybOKUxwgdziumdMDOO9BKtdGVT7nZEluCWo=;
  b=UCBEr/1PdvM4QV5n+Jb8Duu4rRLcVVoRgEJpga7liWPuMwiMble47kYU
   c7YXJNgf4lsyVDnCWNmQuRzu0fvVybd9NYuIUxTyS7DT6iIWZXBvxkYLx
   MOHqvXuwbbcCp1+FWLbmPJY5nC2V1jtDfpwdw08CSgELy7ankHg5LqoHa
   zvKOZ2ADo3eK42szI7OE5M+LusQoxX+eZhSIT9X0Q0L3KbMNlzqnOgh0s
   NubfAaR/8VtA8r3py6jsCEwjMMm5f3vA7nDVUVs6dqtvXF922r0cFg5aU
   5HxvDQSj71Ms0kVJnd1Kcw5Ig9/lWQLgd69UxSqaZOvcg3CNiMT/T2EWi
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375112421"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="375112421"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:46:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="689754234"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="689754234"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 05:46:18 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qc3XT-005fo4-2c;
        Fri, 01 Sep 2023 15:46:15 +0300
Date:   Fri, 1 Sep 2023 15:46:15 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: Re: [PATCH] gpiolib: remove stray newline in gpio/driver.h
Message-ID: <ZPHdFz9qvu8W6EHC@smile.fi.intel.com>
References: <20230901113520.13352-1-brgl@bgdev.pl>
 <ZPHVZQ3NmqWE1cYg@smile.fi.intel.com>
 <CAMRc=Mfinj1rCoOR5_VkEyp9X+=NryyyQtGg3=H5mq_vPz4ZHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMRc=Mfinj1rCoOR5_VkEyp9X+=NryyyQtGg3=H5mq_vPz4ZHA@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 02:29:19PM +0200, Bartosz Golaszewski wrote:
> On Fri, Sep 1, 2023 at 2:13 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Fri, Sep 01, 2023 at 01:35:20PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > Fix a double newline in the GPIO provider header.
> >
> > Separate patch for this?!
> > I would just fold it in the extern removal and that's it.
> 
> It's nowhere near the code I modified in the other one.
> 
> Just slap a reviewed-by on it and let's move on, more important
> patches are coming up. :)

You may apply this without my tag, nothing to review here, seriously.

-- 
With Best Regards,
Andy Shevchenko


