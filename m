Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D69927520CD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 14:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234504AbjGMMJC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 08:09:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234289AbjGMMJA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 08:09:00 -0400
Received: from mga12.intel.com (mga12.intel.com [192.55.52.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74C702694;
        Thu, 13 Jul 2023 05:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689250139; x=1720786139;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Bb0TagrB9pGtt34RXfKQh8x3qUDQ2DG/XKEjSn6IR8U=;
  b=QR1YFnPflgqGOMLzhDKLkZhD4wqYo2SXW8oZb/D2Qc+ZW5Tfd+oTWhbJ
   UesoGjTHLQ1FJIyEIhJ87c+dol946MPCjPouXjq+T7LaUAMl1qVdWREPv
   7G0v+Ln1F9mk4wD8JidX5whf4vs2TIBhBuWPLzcNC0xDb8oJrqrolCpjN
   yC1D46Iakq0dFegHXN2sbA3ag7Gp9o/zx6jIRSoZX0IMKQq0v2/7UQ0wm
   JAKFU2NufTMnQZcHD4ZXdfYDOiI9pf/3/wlprG6aUfrt0S/I9g4o6HLJC
   huFTSBi9SRcJtNzZ+NCpFQ4bWMd9bZtW0jaU1L1ofcvQtc/YgHKwIAS2j
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="344758536"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="344758536"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2023 05:08:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="787418770"
X-IronPort-AV: E=Sophos;i="6.01,202,1684825200"; 
   d="scan'208";a="787418770"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP; 13 Jul 2023 05:08:23 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qJv7N-002OKz-0v;
        Thu, 13 Jul 2023 15:08:21 +0300
Date:   Thu, 13 Jul 2023 15:08:21 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     George Stark <gnstark@sberdevices.ru>
Cc:     jic23@kernel.org, lars@metafoo.de, neil.armstrong@linaro.org,
        khilman@baylibre.com, jbrunet@baylibre.com,
        martin.blumenstingl@googlemail.com, nuno.sa@analog.com,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        kernel@sberdevices.ru
Subject: Re: [PATCH v5 0/6] iio: adc: meson: add iio channels to read channel
 7 mux inputs
Message-ID: <ZK/pNQcT6CrZWIzM@smile.fi.intel.com>
References: <20230711200141.239025-1-gnstark@sberdevices.ru>
 <ZK7GCAgA1gljrxyl@smile.fi.intel.com>
 <fe1b4eb7-e137-fe43-44cb-8de597fe00e4@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fe1b4eb7-e137-fe43-44cb-8de597fe00e4@sberdevices.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 13, 2023 at 02:04:05AM +0300, George Stark wrote:
> Hello Andy
> 
> On 7/12/23 18:26, Andy Shevchenko wrote:
> > On Tue, Jul 11, 2023 at 11:00:16PM +0300, George Stark wrote:
> > > Changelog:
> > 
> > I gave you a tag, any reason why you haven't applied it to your patches?
> 
> if you're talking about patch 6 commit message - yes, I missed the last line
> in your letter, I'll fix it.

I believe I answered to the cover letter [1], which means that it applies to
the entire series. If you don't include tag of the reviewer(s) who spent time
on your code, you have to well justify WHY you did so.

[1]: https://lore.kernel.org/lkml/ZKvQaoFxO5gpAFdM@smile.fi.intel.com/

-- 
With Best Regards,
Andy Shevchenko


