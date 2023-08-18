Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E810B780B08
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Aug 2023 13:22:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376619AbjHRLWA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Aug 2023 07:22:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376621AbjHRLVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Aug 2023 07:21:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5896A3AB2;
        Fri, 18 Aug 2023 04:21:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1692357700; x=1723893700;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CKRSS1iusdv1+5oh3j8yKQXBHN0I1ieRa1yex02/XD8=;
  b=Qo3UWgb/EViDQ2UH4qA2I9NmULITXiti1v8KOp/7RUY6Px7PbSLOryt3
   MT2xVWtIDpO2EyOsDioJv4j+UsA3k8VBy9Tmu7THr1EYof8AGs6LEDyRU
   5a6uU6EiCav85kG/KmNFk1cOtbqJ8XhdQgeXhd34kJulN0mlOdRkyGb2F
   QfAnVJBW6bRz4l5ixx1IqRGiHmzEi6FzDds60qIRPlBVdwsHhDDxVsm3e
   sv8Uq4U1nIXRv0mbdYSQbppNChpj5zlvu1/oVXCgEQtPGWfSTLbM8hMsQ
   8g1HCTmx/eFNEyoAGrIfsVeFhIGD3UKpUCvEt6sH4hfP3FjbdHRuNwJXS
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="370538362"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="370538362"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Aug 2023 04:21:39 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10805"; a="728579674"
X-IronPort-AV: E=Sophos;i="6.01,183,1684825200"; 
   d="scan'208";a="728579674"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 18 Aug 2023 04:21:38 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qWxXs-005WEC-1U;
        Fri, 18 Aug 2023 14:21:36 +0300
Date:   Fri, 18 Aug 2023 14:21:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Angel Iglesias <ang.iglesiasg@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: [PATCH 2/2] iio: pressure: bmp280: Add support for BMP390
Message-ID: <ZN9UQMR8X4/vMV1Z@smile.fi.intel.com>
References: <cover.1692305434.git.ang.iglesiasg@gmail.com>
 <a34c72a2027c4b98bd815e8cf01f56d69c5d1386.1692305434.git.ang.iglesiasg@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a34c72a2027c4b98bd815e8cf01f56d69c5d1386.1692305434.git.ang.iglesiasg@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 17, 2023 at 11:05:22PM +0200, Angel Iglesias wrote:
> Adds BMP390 device id to the supported ids on bmp380 sensor family

...

>  #define BMP180_CHIP_ID			0x55
>  #define BMP280_CHIP_ID			0x58
>  #define BME280_CHIP_ID			0x60
> +#define BMP390_CHIP_ID			0x60

Keep it a bit better ordered. At the first glance, move
before BME.

-- 
With Best Regards,
Andy Shevchenko


