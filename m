Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401A97B0447
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Sep 2023 14:35:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231637AbjI0MfM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Sep 2023 08:35:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230109AbjI0MfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Sep 2023 08:35:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F97139;
        Wed, 27 Sep 2023 05:35:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695818108; x=1727354108;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=wHFoOefAecLIgZERRLYz5FZSvZCU5QTJbhhe5Vz/dxI=;
  b=CBehDosFCt8rbHzmhCC3UPTn1+Xc9xKwsxJRhIOsRsfVp0H/5VBIkjj3
   aDutM/FIG95DKX0RL6rqKRfYRAjFQ76sVXzPhQk7Ps7AUQa+/tDiuKWGd
   4otIF/pAEi0HQgN2HE8ASSdc3i6g8VfMOGcU8asJPGiqMkmauqblNiz73
   9d9QeuDUraVpuSK0cOM/ynoUD+eYjyR7cev2RzmldvVmAsu5jTiata5Dd
   eCtHKHO07RKQGTAzA6tEB1NBaTeCrMDK5LzDyKHdACeuPt+G2pbkCv1Vu
   kur5pkWruS0BBk+1pJRAhKGCYxFc4vmK5EGmk7ylMqtZHiFfPTzxA5nLL
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="412723452"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="412723452"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 05:35:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="819405757"
X-IronPort-AV: E=Sophos;i="6.03,181,1694761200"; 
   d="scan'208";a="819405757"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga004.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2023 05:35:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qlTks-00000000sqT-25xD;
        Wed, 27 Sep 2023 15:35:02 +0300
Date:   Wed, 27 Sep 2023 15:35:02 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Jagath Jog J <jagathjog1996@gmail.com>, jic23@kernel.org,
        lars@metafoo.de, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC 2/2] iio: imu: Add driver for BMI323 IMU
Message-ID: <ZRQhdkVNFdCfPseY@smile.fi.intel.com>
References: <20230918080314.11959-1-jagathjog1996@gmail.com>
 <20230918080314.11959-3-jagathjog1996@gmail.com>
 <20230927095708.l57kmdc3mmrtaco7@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230927095708.l57kmdc3mmrtaco7@pengutronix.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 11:57:08AM +0200, Uwe Kleine-König wrote:
> On Mon, Sep 18, 2023 at 01:33:14PM +0530, Jagath Jog J wrote:

...

> > Datasheet: https://www.bosch-sensortec.com/media/boschsensortec/downloads/datasheets/bst-bmi323-ds000.pdf
> 
> Maybe put this link better in the driver.

Why? We have a handful commits with this and it's better to see the link
to the datasheet without browsing the source code.

-- 
With Best Regards,
Andy Shevchenko


