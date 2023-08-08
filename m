Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF0DB774088
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233187AbjHHREn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjHHRD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:03:59 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A12A519BEC;
        Tue,  8 Aug 2023 09:01:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1691510507; x=1723046507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=EHzA/a69zS6IxZZOnKkr5lxAatAYM7/Zegj9a9NxFpQ=;
  b=L2mTFQQ6xOIsYJ1lu/fsK0ye3PE/grKcdGH/gbEIxeeG12T1h/8g84AQ
   MykDKsG08iTKj7unI+BO1mDbscBhlxm40lRbPCe/4wUPLZDhVZMnbV1YT
   1sk+0Qwx5OFLeKYY+LCBwI8j9XoRiX35v5wbnLXm7/N9j6Vz5Vh6OfCpn
   hVMOwiGkrgNdkGBVl1+2BzPjIcqD89Zx6VckDnVsJyRxxX8wO6O/Y9hTP
   v4Gx5nGUjea6TLvTRHpRSWmYZZgSKQHDvUmEKaXzI1sz4ftzsASlDsTy+
   gcBEXCGmUzqsBb/WHsz31pO/Tsckb5kNDWXJDQ8O2O9tV3z64ATcqqiDF
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="373569036"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="373569036"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2023 06:26:21 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10795"; a="1062019916"
X-IronPort-AV: E=Sophos;i="6.01,156,1684825200"; 
   d="scan'208";a="1062019916"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 08 Aug 2023 06:26:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qTMj0-009guo-0A;
        Tue, 08 Aug 2023 16:26:14 +0300
Date:   Tue, 8 Aug 2023 16:26:13 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] iio: adc: mcp3911: add support for the whole
 MCP39xx family
Message-ID: <ZNJCdRc5rXGEBVrY@smile.fi.intel.com>
References: <20230807071831.4152183-1-marcus.folkesson@gmail.com>
 <20230807071831.4152183-2-marcus.folkesson@gmail.com>
 <ZNETcVNsEmvK0KKH@smile.fi.intel.com>
 <ZNHtMBG4yHpgL1kj@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZNHtMBG4yHpgL1kj@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 08, 2023 at 09:22:24AM +0200, Marcus Folkesson wrote:
> On Mon, Aug 07, 2023 at 06:53:21PM +0300, Andy Shevchenko wrote:
> > On Mon, Aug 07, 2023 at 09:18:31AM +0200, Marcus Folkesson wrote:

...

> > > -	ret = mcp3911_config(adc);
> > > +	ret = device_property_read_u32(&adc->spi->dev, "microchip,device-addr", &adc->dev_addr);
> > 
> > Why not spi->dev? Ditto for other uses like this.
> 
> After all, I think it is better to stick sith adc->spi-dev to be
> consistent with the rest of the probe function. Change to spi->dev
> should probably be a seperate patch.
> Do you agree?

Make sure you first switch to use shorter form and then add this one.
In that case I agree.

-- 
With Best Regards,
Andy Shevchenko


