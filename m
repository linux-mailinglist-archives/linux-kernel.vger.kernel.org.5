Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3820765096
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 12:09:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232979AbjG0KJ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 06:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232889AbjG0KJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 06:09:25 -0400
Received: from mgamail.intel.com (unknown [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89FC497;
        Thu, 27 Jul 2023 03:09:24 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="365728277"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="365728277"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2023 03:09:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="756593356"
X-IronPort-AV: E=Sophos;i="6.01,234,1684825200"; 
   d="scan'208";a="756593356"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 27 Jul 2023 03:09:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qOxvr-00Gaad-2k;
        Thu, 27 Jul 2023 13:09:19 +0300
Date:   Thu, 27 Jul 2023 13:09:19 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Romain Perier <romain.perier@gmail.com>
Cc:     Andrei Coardos <aboutphysycs@gmail.com>,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, brgl@bgdev.pl,
        linus.walleij@linaro.org, daniel@thingy.jp,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: Re: [PATCH] gpio: msc313: remove unnecessary call to
 platform_set_drvdata()
Message-ID: <ZMJCT0jtCzUuSnQP@smile.fi.intel.com>
References: <20230721131157.26640-1-aboutphysycs@gmail.com>
 <ZLqu56eHfpc0TnMw@smile.fi.intel.com>
 <ZL/L1tiKjLDP5bet@smile.fi.intel.com>
 <CABgxDoL4ftygpXKKuRoAKJ41KRTLQZr-YOiWLC5pM96-qe_=eQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgxDoL4ftygpXKKuRoAKJ41KRTLQZr-YOiWLC5pM96-qe_=eQ@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,MAY_BE_FORGED,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 27, 2023 at 09:00:36AM +0200, Romain Perier wrote:

First of all, please do not top-post!

> The private data is "struct msc313_gpio *gpio". This private data is
> "binded" to the gpio_chip via devm_gpiochip_add_data, right ?

No.

> Then it is retrieved via gpiochip_get_data(chip), right ?

No.

The driver data is used in PM callbacks. See below.

> Le mar. 25 juil. 2023 à 15:22, Andy Shevchenko <andy@kernel.org> a écrit :
> >
> > On Fri, Jul 21, 2023 at 07:14:31PM +0300, Andy Shevchenko wrote:
> > > On Fri, Jul 21, 2023 at 04:11:57PM +0300, Andrei Coardos wrote:
> > > > This function call was found to be unnecessary as there is no equivalent
> > > > platform_get_drvdata() call to access the private data of the driver.
> >
> > Not true.

^^^^

> > > > Also, the private data is defined in this driver, so there is no risk of
> > > > it being accessed outside of this driver file.
> > >
> > > Reviewed-by: Andy Shevchenko <andy@kernel.org>
> >
> > I have to withdraw this, the patch is wrong.
> > NAK.
> >
> > Sorry for the confusion (I have looked for the wrong pattern).

-- 
With Best Regards,
Andy Shevchenko


