Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A3076397A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jul 2023 16:45:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233038AbjGZOpo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jul 2023 10:45:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbjGZOpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jul 2023 10:45:42 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 619D11990;
        Wed, 26 Jul 2023 07:45:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690382741; x=1721918741;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=74mpgfL0FeV7YMwi8zS/vUUeKAUF9iLmvpmetcgSpNE=;
  b=AGn6k8SY8NGQqDKCJ72o1CNTdpgB0A1yhh8+qeHtFhuDG1XET8YK26U8
   RBFTblscBY11l4svrN6Lri2cZ2Y/b8SdS2o2OScCqFn1noSgDc1oBPTxH
   x6HPYwvglrX7pJiMUhyePfBHFuVQ0nqqcKTkeZHK52FnL5uqDgLF5EvU4
   qmTpz7Ys97L8Ajl8tfWPimImmii57wTHhvbFIwaeaOlNiI8a3U9bTaXJd
   vExWgxf6hIHg84mLL9bCQ6f53NZkYX161ws0GwU6IzAh+mwcW4w6VAsjN
   Z6EjxTJ+GaQuKF6f0r5aa/IYbIZk6es+FzMAmLXwLZfgTdE8oqodKz8xP
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="366914644"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="366914644"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Jul 2023 07:45:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10783"; a="850485473"
X-IronPort-AV: E=Sophos;i="6.01,232,1684825200"; 
   d="scan'208";a="850485473"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga004.jf.intel.com with ESMTP; 26 Jul 2023 07:45:24 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qOflS-00BRtF-1M;
        Wed, 26 Jul 2023 17:45:22 +0300
Date:   Wed, 26 Jul 2023 17:45:22 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jonathan Corbet <corbet@lwn.net>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Randy Dunlap <rdunlap@infradead.org>
Subject: Re: [PATCH v2 1/1] Documentation: core-api: Drop :export: for
 int_log.h
Message-ID: <ZMExglQlP/KsjQET@smile.fi.intel.com>
References: <20230725104956.47806-1-andriy.shevchenko@linux.intel.com>
 <169031283259.1609546.106488095269313393.b4-ty@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <169031283259.1609546.106488095269313393.b4-ty@kernel.org>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 25, 2023 at 08:20:32PM +0100, Mark Brown wrote:
> On Tue, 25 Jul 2023 13:49:56 +0300, Andy Shevchenko wrote:
> > The :export: keyword makes sense only for C-files, where EXPORT_SYMBOL()
> > might appear. Otherwise kernel-doc may not produce anything out of this
> > file.
> 
> Applied to
> 
>    https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
> 
> Thanks!

Thank you!

-- 
With Best Regards,
Andy Shevchenko


