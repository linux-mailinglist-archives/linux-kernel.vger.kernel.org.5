Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A4867F9FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 13:41:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjK0Mlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 07:41:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbjK0Mlh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 07:41:37 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF14183;
        Mon, 27 Nov 2023 04:41:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701088904; x=1732624904;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=v3n/pRVGJN+BSoahXNcOeH95ditBSNEnKGtGNzh0jZc=;
  b=PQLoey2QR1ek9PLv/aSSIVIyHyI3HgitEcZfwBcGGSGxU4Ly50Pckrnh
   myZ+IhQ+MEZiA/lR6XrF05Jg4kEFfTqD2CD1AEDguOoRqTA84e7D/W3TD
   i2KO1lhdNAJWLk00YllDHROHqk/a9zMqfjjHIqq95c+olPFf00U7eJbCa
   fjKav0AJ2ohYy/s6T6lzSnTiM5Nf7NH3KGDFXqF+qRWXUWIZEcrLR3mL1
   HiY7fSzjQPYqWwCrvsfTLiq/bdYRJOm8QP47a8/FXZKdk8dfNCBjw3nJW
   Mq9dGS2G5+g2FJjhKIVmNtsExUMumKZJWko2ywy1losnTPv2PDqX0Ke6s
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="5883172"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="5883172"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 04:41:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10906"; a="802625987"
X-IronPort-AV: E=Sophos;i="6.04,230,1695711600"; 
   d="scan'208";a="802625987"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Nov 2023 04:41:39 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@intel.com>)
        id 1r7avg-0000000HTOL-0Mob;
        Mon, 27 Nov 2023 14:41:36 +0200
Date:   Mon, 27 Nov 2023 14:41:35 +0200
From:   Andy Shevchenko <andriy.shevchenko@intel.com>
To:     George Stark <gnstark@salutedevices.com>
Cc:     pavel@ucw.cz, lee@kernel.org, vadimp@nvidia.com,
        mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        linux-leds@vger.kernel.org, linux-kernel@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        "jic23@kernel.org" <jic23@kernel.org>, kernel@salutedevices.com
Subject: Re: [PATCH 0/8] devm_led_classdev_register() usage problem
Message-ID: <ZWSOfya16XoCfy5H@smile.fi.intel.com>
References: <20231025130737.2015468-1-gnstark@salutedevices.com>
 <ZWDBOfpsC5AVT8bX@smile.fi.intel.com>
 <13cd5524-0d40-4f07-b542-002b79b37533@salutedevices.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13cd5524-0d40-4f07-b542-002b79b37533@salutedevices.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 25, 2023 at 03:47:41AM +0300, George Stark wrote:
> On 11/24/23 18:28, Andy Shevchenko wrote:
> > On Wed, Oct 25, 2023 at 04:07:29PM +0300, George Stark wrote:
> > > Lots of drivers use devm_led_classdev_register() to register their led objects
> > > and let the kernel free those leds at the driver's remove stage.
> > > It can lead to a problem due to led_classdev_unregister()
> > > implementation calls led_set_brightness() to turn off the led.
> > > led_set_brightness() may call one of the module's brightness_set callbacks.
> > > If that callback uses module's resources allocated without using devm funcs()
> > > then those resources will be already freed at module's remove() callback and
> > > we may have use-after-free situation.
> > > 
> > > Here is an example:
> > > 
> > > module_probe()
> > > {
> > >      devm_led_classdev_register(module_brightness_set_cb);
> > >      mutex_init(&mutex);
> > > }
> > > 
> > > module_brightness_set_cb()
> > > {
> > >      mutex_lock(&mutex);
> > >      do_set_brightness();
> > >      mutex_unlock(&mutex);
> > > }
> > > 
> > > module_remove()
> > > {
> > >      mutex_destroy(&mutex);
> > > }
> > > 
> > > at rmmod:
> > > module_remove()
> > >      ->mutex_destroy(&mutex);
> > > devres_release_all()
> > >      ->led_classdev_unregister();
> > >          ->led_set_brightness();
> > >              ->module_brightness_set_cb();
> > >                   ->mutex_lock(&mutex);  /* use-after-free */
> > > 
> > > I think it's an architectural issue and should be discussed thoroughly.
> > > Some thoughts about fixing it as a start:
> > > 1) drivers can use devm_led_classdev_unregister() to explicitly free leds before
> > > dependend resources are freed. devm_led_classdev_register() remains being useful
> > > to simplify probe implementation.
> > > As a proof of concept I examined all drivers from drivers/leds and prepared
> > > patches where it's needed. Sometimes it was not as clean as just calling
> > > devm_led_classdev_unregister() because several drivers do not track
> > > their leds object at all - they can call devm_led_classdev_register() and drop the
> > > returned pointer. In that case I used devres group API.
> > > 
> > > Drivers outside drivers/leds should be checked too after discussion.
> > > 
> > > 2) remove led_set_brightness from led_classdev_unregister() and force the drivers
> > > to turn leds off at shutdown. May be add check that led's brightness is 0
> > > at led_classdev_unregister() and put a warning to dmesg if it's not.
> > > Actually in many cases it doesn't really need to turn off the leds manually one-by-one
> > > if driver shutdowns whole led controller. For the last case to disable the warning
> > > new flag can be brought in e.g LED_AUTO_OFF_AT_SHUTDOWN (similar to LED_RETAIN_AT_SHUTDOWN).
> > 
> > NAK.
> > 
> > Just fix the drivers by wrapping mutex_destroy() into devm, There are many
> > doing so. You may be brave enough to introduce devm_mutex_init() somewhere
> > in include/linux/device*
> 
> Just one thing about mutex_destroy(). It seems like there's no single
> opinion on should it be called in 100% cases e.g. in remove() paths.
> For example in iio subsystem Jonathan suggests it can be dropped in simple
> cases: https://www.spinics.net/lists/linux-iio/msg73423.html
> 
> So the question is can we just drop mutex_destroy() in module's remove()
> callback here if that mutex is needed for devm subsequent callbacks?

mutex_destroy() makes sense when debugging mutexes. It's harmless to drop,
but will make life harder to one who is trying to debug something there...

-- 
With Best Regards,
Andy Shevchenko


