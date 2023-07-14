Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8281375336D
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 09:46:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235455AbjGNHqR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 03:46:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235456AbjGNHqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 03:46:12 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32DCE30FA;
        Fri, 14 Jul 2023 00:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689320769; x=1720856769;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=CHvxp8kAGhqGFyc+K55VoEx9FObk2JSKYuF9UANj9Z0=;
  b=YMZVqVg5nl0/+ZIoEcGhz/xgtleqqA/HVbtsg1v7hRItYNsQUl/sERjt
   vFjz0aFHhYfRCIrwyH9DachYOfJU09iJc1nfGQJkMSHToDo/b7kmTT5ua
   ZeHoxj+wSREzYg2sOOqQq1bhgzx3ifnlZOOxvRfumto4odgpJQmuG7OR2
   8fU0Ew4DnW7YrcA4jTZS4MXVR1LyET0N+qmc1CedZ4jNIjgCBb5qckvb6
   kjvE2QfiRGINSVVq/8DjaPdqDiZcBBbSeD/T6Zq2fCUFyzicnASMJREkS
   e4dou/aFXRtk89KdNpDZ+rcEI2lpScVwn2MY7/vtfK59lOtTNtgHsi3LA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="431586955"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="431586955"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jul 2023 00:46:08 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10770"; a="968908750"
X-IronPort-AV: E=Sophos;i="6.01,204,1684825200"; 
   d="scan'208";a="968908750"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 14 Jul 2023 00:46:05 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qKDV5-002aw9-0P;
        Fri, 14 Jul 2023 10:46:03 +0300
Date:   Fri, 14 Jul 2023 10:46:02 +0300
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
Message-ID: <ZLD9OooZZ1FZg/SL@smile.fi.intel.com>
References: <20230711200141.239025-1-gnstark@sberdevices.ru>
 <ZK7GCAgA1gljrxyl@smile.fi.intel.com>
 <fe1b4eb7-e137-fe43-44cb-8de597fe00e4@sberdevices.ru>
 <ZK/pNQcT6CrZWIzM@smile.fi.intel.com>
 <df30fcca-8f7e-bfb2-be92-0eb76726d3e7@sberdevices.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <df30fcca-8f7e-bfb2-be92-0eb76726d3e7@sberdevices.ru>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 14, 2023 at 02:11:19AM +0300, George Stark wrote:
> On 7/13/23 15:08, Andy Shevchenko wrote:
> > On Thu, Jul 13, 2023 at 02:04:05AM +0300, George Stark wrote:
> > > On 7/12/23 18:26, Andy Shevchenko wrote:
> > > > On Tue, Jul 11, 2023 at 11:00:16PM +0300, George Stark wrote:
> > > > 
> > > > I gave you a tag, any reason why you haven't applied it to your patches?
> > > 
> > > if you're talking about patch 6 commit message - yes, I missed the last line
> > > in your letter, I'll fix it.
> > 
> > I believe I answered to the cover letter [1], which means that it applies to
> > the entire series. If you don't include tag of the reviewer(s) who spent time
> > on your code, you have to well justify WHY you did so.
> > 
> > [1]: https://lore.kernel.org/lkml/ZKvQaoFxO5gpAFdM@smile.fi.intel.com/
> 
> Hello Andy
> 
> I think I've understood at last what you meant by "not applied tag". I'm not
> experienced kernel contributor yet and believed that RvBs and Acks are added
> by one who merges patches or by some kind of magic :)

If you (not a maintainer) respin the series, it's your responsibility to add /
drop / update tags. And hence to explain any modifications to that.

> Of course I'll add the tag, I missed it not on purpose.
> Thank you very much for help and your work for the common good.

No problem, as I said, I'm in favour of your good contribution,
just some processing issues which can be easily fixed.

-- 
With Best Regards,
Andy Shevchenko


