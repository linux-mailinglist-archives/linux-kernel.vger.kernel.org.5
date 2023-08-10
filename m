Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FEC777C49
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 17:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235198AbjHJPgw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 11:36:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjHJPgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 11:36:51 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABD5526B6;
        Thu, 10 Aug 2023 08:36:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691681810; x=1723217810;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=NTbuf4AyYKmPslKaW6cwFEVLhlsLUMNyTDrHunTksbU=;
  b=ZyuunNgI9aQM6CTyHwawW5DXskTwB5GHO43oqwp0gbPQJZc18iJeMDoo
   Y2a6xda8bAGZORIN/WMnaMUmIDqwXhALzqaToU8rElG9SYnhTR8B0+TQr
   GpfY9iD4PdAoUECJxuovS7A8jjDvgEbd6f89H8CBhHo4bXiFzjG4s0AQP
   DeWT/ytpTIhH7t4jFoOngx4YgbZ+OO+iblzNSS7CdxFqO2CPC9HBRMTlD
   TYg8d2QflWK+fwOz+V2uNRX4tneNt1KvZ0QgfrmIiEWo0eSoO3ce3jLhx
   WwicXzNtT5T4W1BX/p5ePeTqA7gTWAn7NZXAMeseiqKCnDgv26BR38DSw
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="375149709"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="375149709"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2023 08:36:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10798"; a="761819428"
X-IronPort-AV: E=Sophos;i="6.01,162,1684825200"; 
   d="scan'208";a="761819428"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga008.jf.intel.com with ESMTP; 10 Aug 2023 08:36:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qU7iH-0079nW-0e;
        Thu, 10 Aug 2023 18:36:37 +0300
Date:   Thu, 10 Aug 2023 18:36:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Nuno =?iso-8859-1?Q?S=E1?= <noname.nuno@gmail.com>
Cc:     Dumitru Ceclan <mitrutzceclan@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Okan Sahin <okan.sahin@analog.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Lee Jones <lee@kernel.org>, Haibo Chen <haibo.chen@nxp.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Leonard =?iso-8859-1?Q?G=F6hrs?= <l.goehrs@pengutronix.de>,
        Ceclan Dumitru <dumitru.ceclan@analog.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] iio: adc: ad717x: add AD717X driver
Message-ID: <ZNUEBDsMg6UfeOtl@smile.fi.intel.com>
References: <20230810093322.593259-1-mitrutzceclan@gmail.com>
 <20230810093322.593259-2-mitrutzceclan@gmail.com>
 <34f5e2118a4714048231e6ee9a8f244248616bd0.camel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <34f5e2118a4714048231e6ee9a8f244248616bd0.camel@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 10, 2023 at 01:57:02PM +0200, Nuno Sá wrote:
> On Thu, 2023-08-10 at 12:33 +0300, Dumitru Ceclan wrote:

...

> Is ad717x_gpio_cleanup() being used anywhere? Moreover I would maybe just get rid of
> the #ifdef wrapper and just select GPIOLIB. How often will it be disabled anyways?

The agreement is that users are depend on and not selecting GPIOLIB.
Any news in these agreement terms?

...

> > +       id &= AD717X_ID_MASK;
> > +       if (id != st->info->id)
> > +               dev_warn(&st->sd.spi->dev, "Unexpected device id: %x, expected:
> > %x\n",
> > +                                           id, st->info->id);
> > +
> 
> Shouldn't we error out?

It seems a new way of thinking about unsupported CHIP ID. Dunno if hw vendors
won't ever do a dirty trick that new ID must be programmed differently and
otherwise burn hardware to a smoke...

I'm with you here, unknown chips mustn't be supported.

...

> > +                               *val = -(1 << (chan->scan_type.realbits - 1));
> 
> nit: I don't expect the driver to really be updated with more devices (it's
> like this for a long time) but the above is not very extensible... Imagine we
> add a device with 32bit channels? We would enter shady waters If I'm not
> missing anything.

Also 1 << 31 is UB in accordance with C standard.

...

> > +       st->info = device_get_match_data(&spi->dev);
> > +       if (!st->info)
> > +               return -ENODEV;
> > +
> 
> spi_get_device_match_data() (not really sure if this is still applicable
> since some work related to this is being done for i2c - and eventually in spi
> I guess).

Still applicable.

-- 
With Best Regards,
Andy Shevchenko


