Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644387FF034
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 14:33:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345565AbjK3NdE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 08:33:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjK3NdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 08:33:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB8ED6C;
        Thu, 30 Nov 2023 05:33:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701351189; x=1732887189;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=Y9xAE4jnRRyfj1G4wW1Lotwm4gpNjAn2zAYETZeXOaw=;
  b=i10DJW9TSl22/CNbIINoSGvsnU1vKerow5s1ScjGckrYdV2tx7CrJXUS
   +1JEpa7xToNyIhRRMCvM0kYmzhYcN5c1Ax2hEcLx6ew49vDgglb7G+g2z
   D1QFEE7V1L8B0vNaOmlHB5K36n9PamfSvAmqmtYTKoCpYFMK6EVfiRgVx
   PQpx7+MyqbFcnXU7shVZhatDfOu+CQOKKbkMx6DaPG8tWVHrvrlRfWJf0
   YR8NEvytO/5m/6kU58oizP5hQiYf4avDDINGBRbOTNsdnpdkwzmQA3ILZ
   sPkv8MNjDdxSC/RWoDWB6unuG+CgO2UA6QQEDp6RTnHHMNWOEwBOeW+Y+
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="424472104"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="424472104"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 05:33:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10910"; a="769309024"
X-IronPort-AV: E=Sophos;i="6.04,239,1695711600"; 
   d="scan'208";a="769309024"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2023 05:33:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1r8hA7-00000000hwz-003K;
        Thu, 30 Nov 2023 15:33:03 +0200
Date:   Thu, 30 Nov 2023 15:33:02 +0200
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
Subject: Re: [PATCH v6 2/2] iio: pressure: driver for Honeywell HSC/SSC series
Message-ID: <ZWiPDlNJCbUAtIy8@smile.fi.intel.com>
References: <20231129170425.3562-1-petre.rodan@subdimension.ro>
 <20231129170425.3562-2-petre.rodan@subdimension.ro>
 <ZWdzz7VzCW5ctend@smile.fi.intel.com>
 <ZWeNNMfqKquDYI9X@sunspire>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZWeNNMfqKquDYI9X@sunspire>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 29, 2023 at 09:12:52PM +0200, Petre Rodan wrote:
> On Wed, Nov 29, 2023 at 07:24:31PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 29, 2023 at 07:04:12PM +0200, Petre Rodan wrote:

...

> > > v6: modifications based on Andy's review
> > >     - use str_has_prefix(), match_string() instead of strncmp()
> > 
> > And why not using the respective property API for that case where
> > match_string() is used?
> 
> I'm lost again.
> 
> 437:  ret = device_property_read_string(dev, "honeywell,pressure-triplet",
> 					&triplet);
> [..]
> 455:	ret = match_string(hsc_triplet_variants, HSC_VARIANTS_MAX,
> 						triplet);
> 		if (ret < 0)
> 			return dev_err_probe(dev, -EINVAL,
> 				"honeywell,pressure-triplet is invalid\n");
> 
> 		hsc->pmin = hsc_range_config[ret].pmin;
> 		hsc->pmax = hsc_range_config[ret].pmax;
> 
> triplet is got via device_property_read_string(), is there some other property
> function I should be using?

I think I mentioned that API, but for your convenience
device_property_match_property_string().

...

> > > +	tmp = div_s64(((s64)(hsc->pmax - hsc->pmin)) * MICRO,
> > > +		      hsc->outmax - hsc->outmin);
> > > +	hsc->p_scale = div_s64_rem(tmp, NANO, &hsc->p_scale_dec);
> > > +	tmp = div_s64(((s64)hsc->pmin * (s64)(hsc->outmax - hsc->outmin)) *
> > > +		      MICRO, hsc->pmax - hsc->pmin);
> > 
> > Why not put MICRO on the previous line?
> 
> oh well, from the review I understood you were asking for the replacement of
> NANO with MICRO on the previous instruction and it did not make much sense (
> units are in pascal and we need a kilopascal output to userland)
> 
> now I understood it's an indentation request. however moving MICRO will cross
> the 80 column rule. but if there will be yet another modification request
> I'll move it.

I understand that it breaks the 80 character rule, but my point is to have
consistency between two divisions (see quoted context) along with the logical
split — line split on argument list split.

-- 
With Best Regards,
Andy Shevchenko


