Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0667280339F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 13:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233387AbjLDM5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 07:57:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233395AbjLDM5d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 07:57:33 -0500
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53DAF109;
        Mon,  4 Dec 2023 04:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701694660; x=1733230660;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7Cj0FSe2KITpAAhEvGgLmANZmxOhurePzJN16LUJB2M=;
  b=RfBguMuLdBuuo3xYIkGcpAEVeGD+FAuIuKfU2OaErgIQiCmh1bIWuift
   kjBiGs2EXMV2T6gV+02C/eKKSUZ+CRS0oP7Cpd3GdQU+XzGGujaCXe7vd
   CJFNK1Aw8vYRjusvm6gNmuNezP38EhowWfOam1AmVkw4V6lsuXE600Qh6
   SmQrOwgH1geSKhMxeUcVzRCNWx3rClINSGZUfNDY6DDdVz0G3xKQvjfyS
   GDv9BzbzBcsfwTGmgpXrQcUuUDFKkHfURulrz0tVULARU4gxKkIxAbNRQ
   zbUlnM9vdF1Sa0RnljcJWbk7xyflKjLOYXCZtNdu7HkP48v+LHYpY88uf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="384130171"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="384130171"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 04:57:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10913"; a="1017839179"
X-IronPort-AV: E=Sophos;i="6.04,249,1695711600"; 
   d="scan'208";a="1017839179"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 04:57:37 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rA8Vx-00000001kkV-3MSm;
        Mon, 04 Dec 2023 14:57:33 +0200
Date:   Mon, 4 Dec 2023 14:57:33 +0200
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
Message-ID: <ZW3Mvds9LFiK7aEz@smile.fi.intel.com>
References: <20231129170425.3562-1-petre.rodan@subdimension.ro>
 <20231129170425.3562-2-petre.rodan@subdimension.ro>
 <ZWdzz7VzCW5ctend@smile.fi.intel.com>
 <ZWeNNMfqKquDYI9X@sunspire>
 <ZWiPDlNJCbUAtIy8@smile.fi.intel.com>
 <ZWtWAPcJTNrD9wgv@sunspire>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZWtWAPcJTNrD9wgv@sunspire>
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

On Sat, Dec 02, 2023 at 06:06:24PM +0200, Petre Rodan wrote:
> On Thu, Nov 30, 2023 at 03:33:02PM +0200, Andy Shevchenko wrote:
> > On Wed, Nov 29, 2023 at 09:12:52PM +0200, Petre Rodan wrote:
> > > On Wed, Nov 29, 2023 at 07:24:31PM +0200, Andy Shevchenko wrote:
> > > 
> > > 437:  ret = device_property_read_string(dev, "honeywell,pressure-triplet",
> > > 					&triplet);
> > > [..]
> > > 455:	ret = match_string(hsc_triplet_variants, HSC_VARIANTS_MAX,
> > > 						triplet);
> > > 		if (ret < 0)
> > > 			return dev_err_probe(dev, -EINVAL,
> > > 				"honeywell,pressure-triplet is invalid\n");
> > > 
> > > 		hsc->pmin = hsc_range_config[ret].pmin;
> > > 		hsc->pmax = hsc_range_config[ret].pmax;
> > > 
> > > triplet is got via device_property_read_string(), is there some other property
> > > function I should be using?
> > 
> > I think I mentioned that API, but for your convenience
> > device_property_match_property_string().
> 
> one of us is not sync-ed with 6.7.0-rc3 :)

No, one of us is not synced with subsystem "for-next", which in this case
is IIO "togreg" (IIRC) and it definitely has the above mentioned API.

-- 
With Best Regards,
Andy Shevchenko


