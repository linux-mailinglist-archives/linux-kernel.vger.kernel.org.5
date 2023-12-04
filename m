Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 234348040B3
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Dec 2023 22:06:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233640AbjLDVGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Dec 2023 16:06:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229741AbjLDVGC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Dec 2023 16:06:02 -0500
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DF9AA;
        Mon,  4 Dec 2023 13:06:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1701723969; x=1733259969;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=h6gP1NQbY4dX1qmROHunnGHZVaEKfBaVBQOc5gafk60=;
  b=CpG+rDlQdoD8yB5t4Uyl3qMdpP0VOWPQR4oZ8VQZEM415og2iWJQVG61
   FIDcBOf4a1WOZcH1sd0NFBDjkcKoIDfEarpzRPdtD+AAfwJZJSRt0LdpK
   sDtdLjbU+BLj83WY+TPwwPLD779tEAj6v111dPwJHUOTrp7Dm9sIbwhVG
   xsRmCPjZLVd5IJ7UdLz9c9u/nJyfNutJFuJ130e8AY70WV1HHC8ymVQjy
   ZOdLGFdSWbHnECKAydeeFA1LBqBAki+NfHqjdqhYOUqeuKYOVdnmj3mce
   IYRKG1KrXka2ofREIau9CDqUMfMThoYP6Ym9qBoQD6zRIUPBZjO16XpFt
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="866205"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="866205"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 13:06:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10914"; a="914567672"
X-IronPort-AV: E=Sophos;i="6.04,250,1695711600"; 
   d="scan'208";a="914567672"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga001.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Dec 2023 13:06:06 -0800
Received: from andy by smile.fi.intel.com with local (Exim 4.97)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1rAG8h-00000001su4-0hwj;
        Mon, 04 Dec 2023 23:06:03 +0200
Date:   Mon, 4 Dec 2023 23:06:02 +0200
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
Subject: Re: [PATCH v7 2/2] iio: pressure: driver for Honeywell HSC/SSC series
Message-ID: <ZW4_OoyKSZ3EBL2x@smile.fi.intel.com>
References: <20231204194401.20891-1-petre.rodan@subdimension.ro>
 <20231204194401.20891-2-petre.rodan@subdimension.ro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231204194401.20891-2-petre.rodan@subdimension.ro>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 04, 2023 at 09:43:59PM +0200, Petre Rodan wrote:
> Adds driver for digital Honeywell TruStability HSC and SSC series
> pressure and temperature sensors.
> Communication is one way. The sensor only requires 4 bytes worth of
> clock pulses on both i2c and spi in order to push the data out.
> The i2c address is hardcoded and depends on the part number.
> There is no additional GPIO control.

...

> +static const char hsc_iio_dev_name[] = "hsc030pa";

Useless, you can use it directly in the assignment.

...

> +enum hsc_variants {
> +	HSC001BA = 0x0, HSC1_6BA = 0x1, HSC2_5BA = 0x2, HSC004BA = 0x3,
> +	HSC006BA = 0x4, HSC010BA = 0x5, HSC1_6MD = 0x6, HSC2_5MD = 0x7,
> +	HSC004MD = 0x8, HSC006MD = 0x9, HSC010MD = 0xa, HSC016MD = 0xb,
> +	HSC025MD = 0xc, HSC040MD = 0xd, HSC060MD = 0xe, HSC100MD = 0xf,

You can add leading 0 to make them aligned with the below.

> +	HSC160MD = 0x10, HSC250MD = 0x11, HSC400MD = 0x12, HSC600MD = 0x13,
> +	HSC001BD = 0x14, HSC1_6BD = 0x15, HSC2_5BD = 0x16, HSC004BD = 0x17,
> +	HSC2_5MG = 0x18, HSC004MG = 0x19, HSC006MG = 0x1a, HSC010MG = 0x1b,
> +	HSC016MG = 0x1c, HSC025MG = 0x1d, HSC040MG = 0x1e, HSC060MG = 0x1f,
> +	HSC100MG = 0x20, HSC160MG = 0x21, HSC250MG = 0x22, HSC400MG = 0x23,
> +	HSC600MG = 0x24, HSC001BG = 0x25, HSC1_6BG = 0x26, HSC2_5BG = 0x27,
> +	HSC004BG = 0x28, HSC006BG = 0x29, HSC010BG = 0x2a, HSC100KA = 0x2b,
> +	HSC160KA = 0x2c, HSC250KA = 0x2d, HSC400KA = 0x2e, HSC600KA = 0x2f,
> +	HSC001GA = 0x30, HSC160LD = 0x31, HSC250LD = 0x32, HSC400LD = 0x33,
> +	HSC600LD = 0x34, HSC001KD = 0x35, HSC1_6KD = 0x36, HSC2_5KD = 0x37,
> +	HSC004KD = 0x38, HSC006KD = 0x39, HSC010KD = 0x3a, HSC016KD = 0x3b,
> +	HSC025KD = 0x3c, HSC040KD = 0x3d, HSC060KD = 0x3e, HSC100KD = 0x3f,
> +	HSC160KD = 0x40, HSC250KD = 0x41, HSC400KD = 0x42, HSC250LG = 0x43,
> +	HSC400LG = 0x44, HSC600LG = 0x45, HSC001KG = 0x46, HSC1_6KG = 0x47,
> +	HSC2_5KG = 0x48, HSC004KG = 0x49, HSC006KG = 0x4a, HSC010KG = 0x4b,
> +	HSC016KG = 0x4c, HSC025KG = 0x4d, HSC040KG = 0x4e, HSC060KG = 0x4f,
> +	HSC100KG = 0x50, HSC160KG = 0x51, HSC250KG = 0x52, HSC400KG = 0x53,
> +	HSC600KG = 0x54, HSC001GG = 0x55, HSC015PA = 0x56, HSC030PA = 0x57,
> +	HSC060PA = 0x58, HSC100PA = 0x59, HSC150PA = 0x5a, HSC0_5ND = 0x5b,
> +	HSC001ND = 0x5c, HSC002ND = 0x5d, HSC004ND = 0x5e, HSC005ND = 0x5f,
> +	HSC010ND = 0x60, HSC020ND = 0x61, HSC030ND = 0x62, HSC001PD = 0x63,
> +	HSC005PD = 0x64, HSC015PD = 0x65, HSC030PD = 0x66, HSC060PD = 0x67,
> +	HSC001NG = 0x68, HSC002NG = 0x69, HSC004NG = 0x6a, HSC005NG = 0x6b,
> +	HSC010NG = 0x6c, HSC020NG = 0x6d, HSC030NG = 0x6e, HSC001PG = 0x6f,
> +	HSC005PG = 0x70, HSC015PG = 0x71, HSC030PG = 0x72, HSC060PG = 0x73,
> +	HSC100PG = 0x74, HSC150PG = 0x75, HSC_VARIANTS_MAX
> +};

...

> +		return dev_err_probe(dev, ret,
> +			"honeywell,transfer-function could not be read\n");

Indentation?

...

> +		return dev_err_probe(dev, ret,
> +			"honeywell,pressure-triplet could not be read\n");

Ditto.

...

> +			return dev_err_probe(dev, ret,
> +				"honeywell,pmin-pascal could not be read\n");

Ditto.

...

> +			return dev_err_probe(dev, ret,
> +				"honeywell,pmax-pascal could not be read\n");

Ditto.

...

> +		ret = match_string(hsc_triplet_variants, HSC_VARIANTS_MAX,
> +						triplet);
> +		if (ret < 0)
> +			return dev_err_probe(dev, -EINVAL,
> +				"honeywell,pressure-triplet is invalid\n");

Still you can use mentioned device property API.

...

> +		return dev_err_probe(dev, -EINVAL,
> +			"pressure limits are invalid\n");

Indentation?

-- 
With Best Regards,
Andy Shevchenko


