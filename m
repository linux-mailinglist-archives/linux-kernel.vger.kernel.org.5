Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EC978C809
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:53:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237099AbjH2Owf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:52:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237130AbjH2OwS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:52:18 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81F72194
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:52:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693320734; x=1724856734;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ljeHlax3pGkTv5JkGzapctsfQAphY/2+JOvqqZd87Hg=;
  b=ePzS8afCcDK7RFowbH+nvzY71pI90z5gSbq0ZMybQLhDOi97vzeiqjQC
   z2EcuYkuSL/wQzTbGwTOOQoHLM4uV+wZqsmLrqsPWzvByG41M1Zaq3eMQ
   0mWWp1UgyBI5HPC+EMcF8TWoqwxC6AZixppsLoDIV3V4HKizekWMNEwAi
   hF0CpPpnvIEUV1v8zGcpO8IzBQUoJ5UZnfpVAIgKMOvIaZ9QrcJoa8xu7
   d9iGr1Q5gToiwV9d4/GwmIqBqGV9C1YG/6nKKBLc4yUsbXfR5+/6Gd/ML
   bdI0csj9Q5XA1DCYcYGPWYmv8yuGs0HEM7nqFD/abcetSdXTnEi+1nuim
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="355711822"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="355711822"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:51:51 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="1069487679"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="1069487679"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2023 07:51:48 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb04J-004uHu-05;
        Tue, 29 Aug 2023 17:51:47 +0300
Date:   Tue, 29 Aug 2023 17:51:46 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Lee Jones <lee@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        alsa-devel@alsa-project.org, patches@opensource.cirrus.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] mfd: madera-i2c: Simplify probe()
Message-ID: <ZO4GAorklByxm1si@smile.fi.intel.com>
References: <20230828154941.79780-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828154941.79780-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 04:49:41PM +0100, Biju Das wrote:
> Simplify probe() by replacing of_device_get_match_data() and ID lookup for
> retrieving match data by i2c_get_match_data().

...

> +	type = (unsigned long)i2c_get_match_data(i2c);

uintptr_t ?


-- 
With Best Regards,
Andy Shevchenko


