Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82B467CC39C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Oct 2023 14:46:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234920AbjJQMq2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Oct 2023 08:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234954AbjJQMqY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Oct 2023 08:46:24 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8F6ADB;
        Tue, 17 Oct 2023 05:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1697546782; x=1729082782;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3e7Pt+S/Uvdkd0uVVdxwprHoLQrAZ1BrAXGrEg8lX50=;
  b=EQsI2VbcmIfbMnEek6Jxmo3BfFIojpfoJuUl0qYarXW4VoypWGyk/zYJ
   2LuMUeGeHAl5CuKidvG39Z8Izuy4WKuJzCMeayw97a1gRDKPyLGoNJw2s
   a55QO5j4+hBbWREshPGgPiD+Fs+k49eXiILowQ6AVrQHMHVNumof9WJ17
   zxEKUBud2J/VzF4XP3eBS+Y+i5KvDmQdSMlt/M5PbK5KulUfA791524ap
   2yOJq9NRPR0y1wSTVIlGaG3P3YG0+hHPBp8gdYJ5jAVJfXCEmItz1CgOV
   CIJ9BtlZzh3Dvryystqq1/88AsEvAdGvYPigExjgntyZcUcHi9gpaCUYA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="389641123"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="389641123"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:46:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10865"; a="872553098"
X-IronPort-AV: E=Sophos;i="6.03,232,1694761200"; 
   d="scan'208";a="872553098"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Oct 2023 05:46:20 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC2)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qsjSj-00000006Hrt-3f56;
        Tue, 17 Oct 2023 15:46:17 +0300
Date:   Tue, 17 Oct 2023 15:46:17 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Cc:     Bartosz Golaszewski <brgl@bgdev.pl>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH v3 54/73] pinctrl: intel: drop the wrappers around
 pinctrl_gpio_direction_input()
Message-ID: <ZS6CGcRPNzkCdnoD@smile.fi.intel.com>
References: <20231017120431.68847-1-brgl@bgdev.pl>
 <20231017120431.68847-55-brgl@bgdev.pl>
 <ZS6BAkfFeA+6GYfz@smile.fi.intel.com>
 <CACMJSesgT-a8krB8gvf0gJ-C+p6s1TdRcE6W_42CxR9bDvrGHg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACMJSesgT-a8krB8gvf0gJ-C+p6s1TdRcE6W_42CxR9bDvrGHg@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 17, 2023 at 02:44:25PM +0200, Bartosz Golaszewski wrote:
> On Tue, 17 Oct 2023 at 14:41, Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> >
> > On Tue, Oct 17, 2023 at 02:04:12PM +0200, Bartosz Golaszewski wrote:
> > > From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> > >
> > > pinctrl_gpio_direction_input() now has the same signature as the
> > > wrappers around it so we can drop them.
> >
> > Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> >
> > Now, for the sake of symmetry can you add (at least to the all
> > Intel drivers you modified in this series) the following:
> 
> Good idea but this is v6.8 material, I don't want to extend this
> series anymore at this point.

Then let's postpone at least Intel and Cypress patches after v6.8-rc1 is out.

-- 
With Best Regards,
Andy Shevchenko


