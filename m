Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 481C97619E1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 15:26:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230211AbjGYNZ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 09:25:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229788AbjGYNZy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 09:25:54 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1559419AF;
        Tue, 25 Jul 2023 06:25:44 -0700 (PDT)
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="398633744"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="398633744"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2023 06:25:43 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10782"; a="839864648"
X-IronPort-AV: E=Sophos;i="6.01,230,1684825200"; 
   d="scan'208";a="839864648"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 25 Jul 2023 06:25:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andy@kernel.org>)
        id 1qOI2l-00BM3E-1h;
        Tue, 25 Jul 2023 16:25:39 +0300
Date:   Tue, 25 Jul 2023 16:25:39 +0300
From:   Andy Shevchenko <andy@kernel.org>
To:     Andrei Coardos <aboutphysycs@gmail.com>
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        angelogioacchino.delregno@collabora.com, matthias.bgg@gmail.com,
        brgl@bgdev.pl, linus.walleij@linaro.org,
        Alexandru Ardelean <alex@shruggie.ro>
Subject: Re: [PATCH] gpio: mt7621: remove unnecessary call to
 platfrom_set_drvdata()
Message-ID: <ZL/NUySYJnOrc5Qs@smile.fi.intel.com>
References: <20230721130838.26616-1-aboutphysycs@gmail.com>
 <ZLqf6P22HC0Dd4G5@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZLqf6P22HC0Dd4G5@smile.fi.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 06:10:32PM +0300, Andy Shevchenko wrote:
> On Fri, Jul 21, 2023 at 04:08:38PM +0300, Andrei Coardos wrote:
> > This function call was found to be unnecessary as there is no equivalent
> > platform_get_drvdata() call to access the private data of the driver.

Not true.

> > Also, the private data is defined in this driver, so there is no risk of
> > it being accessed outside of this driver file.
> 
> Reviewed-by: Andy Shevchenko <andy@kernel.org>

I have to withdraw this, the patch is wrong.
NAK.

Sorry for the confusion (I have looked for the wrong pattern).

-- 
With Best Regards,
Andy Shevchenko


