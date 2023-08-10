Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67597777A0D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 16:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235529AbjHJOBP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 10:01:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233818AbjHJOBN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 10:01:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66529EA;
        Thu, 10 Aug 2023 07:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691676068; x=1723212068;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=oU596wIwNxfiivZgh0y8qtS/b66W40APOxJVYClgFfg=;
  b=QlWLDPmW8KiPW+tymBFWpRSKtAqX007uZp6QIsSNylibpRrrcAjMf9jy
   RqtmUlSQ760e750HDLEdXXSPt2xt1/djs2IstL8Ru8S3FpNAHY6hYEpK6
   u9d/rQypRALuTirhbaPjTjkrZLzS669kxCa69O5nno6liuSqMjXVcIN3D
   xqiPcvEDIkjA1lSetymcaFZQVNSVLliNXDyPItBiODV96mEgYfb6ZXh68
   mD/EbCuVtut2yVh3YyNjQ1QCvnIUE75zfHJeJrBiJw3T4uX3/oLUDgxh+
   ugYAXcL/ASSttQ5HXFTEVr3+DGCkDWMoT7EHynGOeuzJk7StrcojLrNpv
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="375121777"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="375121777"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 07:01:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="822256388"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="822256388"
Received: from smile.fi.intel.com ([10.237.72.54])
  by FMSMGA003.fm.intel.com with ESMTP; 10 Aug 2023 07:00:58 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qU6Dg-003t6S-15;
        Thu, 10 Aug 2023 17:00:56 +0300
Date:   Thu, 10 Aug 2023 17:00:55 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     wenhua lin <wenhua.lin1994@gmail.com>
Cc:     Wenhua Lin <Wenhua.Lin@unisoc.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
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
        Xiongpeng Wu <xiongpeng.wu@unisoc.com>
Subject: Re: [PATCH] input: keyboard: Add sprd-keypad driver
Message-ID: <ZNTtl9MKHWWbqpnq@smile.fi.intel.com>
References: <20230808072501.3393-1-Wenhua.Lin@unisoc.com>
 <ZNJIa+CbmvDuKq2L@smile.fi.intel.com>
 <CAB9BWhcPpZRNPki1j0spCzN0kF=-1P1ZwtOLULmr2Raz6aO-_w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAB9BWhcPpZRNPki1j0spCzN0kF=-1P1ZwtOLULmr2Raz6aO-_w@mail.gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 08:42:36PM +0800, wenhua lin wrote:
> On Tue, Aug 8, 2023 at 9:51 PM Andy Shevchenko
> <andriy.shevchenko@linux.intel.com> wrote:
> > On Tue, Aug 08, 2023 at 03:25:01PM +0800, Wenhua Lin wrote:
> > > Add matrix keypad driver, support matrix keypad function.
> >
> > Bindings should be prerequisite to this, meaning this has to be a series of
> > two patches.
> 
> I don't quite understand what you mean.
> Can you describe the problem in detail?

...

> > > +     help
> > > +       Keypad controller is used to interface a SoC with a matrix-keypad device,
> > > +       The keypad controller supports multiple row and column lines.
> > > +       Say Y if you want to use the SPRD keyboard.
> > > +       Say M if you want to use the SPRD keyboard on SoC as module.
> >
> > What will be the module name?
> 
> Keypad

With capital letter?
Are you sure?

Also I'm asking this here to make sure that you will make sure the users of it
will know without reading source code.

...

> > >  obj-$(CONFIG_KEYBOARD_ST_KEYSCAN)    += st-keyscan.o
> > >  obj-$(CONFIG_KEYBOARD_SUN4I_LRADC)   += sun4i-lradc-keys.o
> > >  obj-$(CONFIG_KEYBOARD_SUNKBD)                += sunkbd.o
> > > +obj-$(CONFIG_KEYBOARD_SPRD)          += sprd_keypad.o
> >
> > Are you sure it's ordered correctly?
> 
> This configuration is correct, we may not understand what you mean?
>  Any suggestions for this modification?

Latin alphabet is an ordered set.

> > >  obj-$(CONFIG_KEYBOARD_TC3589X)               += tc3589x-keypad.o
> > >  obj-$(CONFIG_KEYBOARD_TEGRA)         += tegra-kbc.o
> > >  obj-$(CONFIG_KEYBOARD_TM2_TOUCHKEY)  += tm2-touchkey.o

...

> > Missing bits.h at least.
> > Revisit you header inclusion block to add exactly what you are using.
> 
> The sprd_keypad.c file will include <linux/interrupt.h>, interrupt.h
> will include <linux/bitops.h>,
> and the bitops.h file will include bits.h. Can this operation method be used?

Seems you misunderstand how C language works. The idea is that you need to
include _explicitly_ all library / etc headers that your code is using.
The above is a hackish way to achieve that.

...

> > > +#include <linux/of.h>
> >
> > Why?
> 
> ret = of_property_read_u32(np, "debounce-interval", &data->debounce_ms);
> if (of_get_property(np, "linux,repeat", NULL))
> 
> Two interfaces of_property_read_u32 and of_get_property are used
> in the sprd_keypad_parse_dt function. If of.h is not included, the
> compilation will report an error.

Do not use of_*() in a new code for the drivers.
There are only few exceptions and this driver is not one of them.

...

> > > +#define SPRD_DEF_LONG_KEY_MS         1000
> >
> >         (1 * MSEC_PER_SEC)
> >
> > ?
> 
>     Yes.

It makes more sense to update so easier to get the value and units from
the value.

...

> > > +     u32 rows_en; /* enabled rows bits */
> > > +     u32 cols_en; /* enabled cols bits */
> >
> > Why not bitmaps?
> 
> Bitmap has been used, each bit represents different rows and different columns.

I meant the bitmap type (as of bitmap.h APIs).

...

> > > +static int sprd_keypad_parse_dt(struct device *dev)
> >
> > dt -> fw
> 
> I don't quite understand what you mean,
> is it to change the function name to sprd_keypad_parse_fw?

Yes. And make it firmware (which may be ACPI/DT or something else).

...

> > And I'm wondering if input subsystem already does this for you.
> 
> I don't quite understand what you mean.

Does input subsystem parse the (some of) device properties already?

...

> > > +     data->enable = devm_clk_get(dev, "enable");
> > > +     if (IS_ERR(data->enable)) {
> > > +             if (PTR_ERR(data->enable) != -EPROBE_DEFER)
> > > +                     dev_err(dev, "get enable clk failed.\n");
> > > +             return PTR_ERR(data->enable);
> > > +     }
> > > +
> > > +     data->rtc = devm_clk_get(dev, "rtc");
> > > +     if (IS_ERR(data->rtc)) {
> > > +             if (PTR_ERR(data->enable) != -EPROBE_DEFER)
> > > +                     dev_err(dev, "get rtc clk failed.\n");
> > > +             return PTR_ERR(data->rtc);
> > > +     }
> >
> > Why not bulk?
> > Why not _enabled() variant?
> 
> I don't quite understand what you mean.
> Can you give me an example?

Hmm... seems there is no existing API like that, but still you have bulk
operations.

$ git grep -n clk_bulk.*\( -- include/linux/clk.h

...

> > > +     data->base = devm_ioremap_resource(&pdev->dev, res);
> >
> > devm_platform_ioremap_resource()
> >
> > > +     if (IS_ERR(data->base)) {
> >
> > > +             dev_err(&pdev->dev, "ioremap resource failed.\n");
> >
> > Dup message.
> 
>  Do you mean : dev_err(&pdev->dev, "ioremap resource failed.\n")，
> I think it is necessary to prompt accurate error message.

Yes, and yours is a duplication of a such.

> > > +             ret =  PTR_ERR(data->base);
> > > +             goto err_free;
> > > +     }

...

> > > +             dev_err(&pdev->dev, "alloc input dev failed.\n");
> > > +             ret =  PTR_ERR(data->input_dev);
> 
> > Too many spaces.
> 
> We will fix this issue in patch v2.
> 
> > Here and elsewhere in ->probe() use return dev_err_probe() approach as Dmitry
> > nowadays is okay with that.
> 
> I don't quite understand what you mean.
> Can you describe it in detail?

	return dev_err_probe(...);

or

	ret = dev_err_probe(... PTR_ERR(...), ...);

Btw, most of your questions can be answered by looking into the lately added
drivers in the input subsystem.

...

> > > +clk_free:
> > > +     sprd_keypad_disable(data);
> >
> > See above how this can be avoided.
> 
> This is hard to explain.

What do you mean?
But I guess somebody already mentioned devm_add_action_or_reset().

...

> > > +err_free:
> > > +     devm_kfree(&pdev->dev, data);
> >
> > Huh?!

It's a red flag, and you have no answer to it...

> > > +     return ret;

...

> > > +             .owner = THIS_MODULE,
> >
> > ~15 years this is not needed.
> > Where did you get this code from? Time machine?
> 
> Do you mean the keypad driver is no longer in use?

No, I meant specifically emphasized line.

-- 
With Best Regards,
Andy Shevchenko


