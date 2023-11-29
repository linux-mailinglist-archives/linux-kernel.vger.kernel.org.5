Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAD6F7FD90E
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 15:15:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234059AbjK2OPC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 09:15:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbjK2OPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 09:15:00 -0500
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3383AF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 06:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701267307; x=1732803307;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=WucPZjtsdY3mwPYiDeb29kvKCxSfqM2GO2HiwiDGwIw=;
  b=BlBU7unBSYK/w1FkOzqm/zv3PuOoUG0lGrT8u5U8TqLmKAnNGZwxxO1j
   A9NqeiTchLapl1ecKGcR0SzFC7TiRv9DqA/XeQqqdqI29QCgMqi3OsJ44
   +Ee/t8at/a04GMtUKHUY4dyjBZaBNB06zxoeLbGWXOeTgJLSiJr+0lRwx
   Oq/81TcOv/6kMnNsUs2/DnjIHwmvb4ZMkls6yOJaYvFJSyeYhz51nuJu8
   ph8UQ2td1ol+mGdSBXMippJxR6D1eCZHoKTZ5krd99hIdILs4CH0NfwPZ
   ZtFHDBXNtWw7fN3A992uDRE0nVtcyBtp2NA/XtVunbIQurAxYX+iIzwMP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="153891"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="153891"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:15:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10909"; a="803310349"
X-IronPort-AV: E=Sophos;i="6.04,235,1695711600"; 
   d="scan'208";a="803310349"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga001.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Nov 2023 06:15:01 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8LL9-00000000SSw-0kod;
        Wed, 29 Nov 2023 16:14:59 +0200
Date:   Wed, 29 Nov 2023 16:14:58 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Petre Rodan <petre.rodan@subdimension.ro>
Cc:     linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        Matti Vaittinen <mazziesaccount@gmail.com>,
        Andreas Klinger <ak@it-klinger.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v5 2/2] iio: pressure: driver for Honeywell HSC/SSC
 series pressure sensors
Message-ID: <ZWdHYsWN-RWr75T6@smile.fi.intel.com>
References: <20231129070452.1521-1-petre.rodan@subdimension.ro>
 <ZWcUPkzfGqxYsysp@smile.fi.intel.com>
 <ZWdB-vU2MAptRk8d@sunspire>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWdB-vU2MAptRk8d@sunspire>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 03:51:54PM +0200, Petre Rodan wrote:
> On Wed, Nov 29, 2023 at 12:36:46PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 29, 2023 at 09:04:49AM +0200, Petre Rodan wrote:

...

> > > +		for (index = 0; index < ARRAY_SIZE(hsc_range_config); index++) {
> > > +			if (strncmp(hsc_range_config[index].triplet,
> > > +				    triplet,
> > > +				    HSC_PRESSURE_TRIPLET_LEN - 1) == 0) {
> > > +				hsc->pmin = hsc_range_config[index].pmin;
> > > +				hsc->pmax = hsc_range_config[index].pmax;
> > > +				found = 1;
> > > +				break;
> > > +			}
> > > +		}
> > > +		if (hsc->pmin == hsc->pmax || !found)
> > > +			return dev_err_probe(dev, -EINVAL,
> > > +				"honeywell,pressure-triplet is invalid\n");
> > 
> > This one is important. I think I told already twice that this is NIH
> > device_property_match_property_string(). Please, use this API directly.
> 
> let me see if we are on the same frequency.
> 
> you told me to use match_string/sysfs_match_string.
> using any of those assume having the strings in an array, which means I have to
>  clutter the code with 242 extra lines in order to split up hsc_range_config:
> 
> enum hsc_variants {
>     HSC001BA = 0,
>     HSC1_6BA = 1,
>     [ .. 115 lines skipped ]
>     HSC150PG = 117,

	HSC_VARIANTS_MAX

> }
> 
> static const char * const hsc_triplet_variants[] = {

static const char * const hsc_triplet_variants[HSC_VARIANTS_MAX] = {

> 	[HSC001BA] = "001BA",
> 	[HSC1_6BA] = "1.6BA",
> 	[ .. 115 lines skipped ]
> 	[HSC150PG] = "150PG",
> };
> 
> and change my structure to
> 
> static const struct hsc_range_config hsc_range_config[] = {

static const struct hsc_range_config hsc_range_config[HSC_VARIANTS_MAX] = {

> 	[HSC001BA] = { .pmin = 0, .pmax = 100000 },
> 	[ .. 117 lines skipped ]
> };
> 
> just to have the privilege of using match_string() on hsc_triplet_variants.
> now, which is worse for maintenance? a handful of lines of code that do a
> loop of strncmp or the clutter depicted above?
> 
> I can go either way, but I want to make sure you see where this leads.

That's the suggestion, yes.

...

> > > +#ifndef _HSC030PA_H
> > > +#define _HSC030PA_H
> > 
> > > +#include <linux/mutex.h>
> > 
> > > +#include <linux/property.h>
> > 
> > Is not used here.
> 
> ok.
> since we are here, can you please tell me how is mutex.h used outside of
> hsc030pa.c where it was included previously?

I'm not sure I understand you. Maybe I was unclear, sorry for that.
I meant the property.h is not used in the _header_ file. Am I mistaken?

-- 
With Best Regards,
Andy Shevchenko


