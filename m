Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE8347B64FD
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 11:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjJCJI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 05:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjJCJI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 05:08:26 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA4979E;
        Tue,  3 Oct 2023 02:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696324103; x=1727860103;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GNdDkE0295DLsorKWTDOi5Sj8aKZsui3/WlnS5ZyMJI=;
  b=gm5LQ/zwyWcEFCLRw43vdFbiC2aS2rchGoXYZm+K17QNcmErB/2F4vk9
   2KDw6pCqr6fiHssjUPG61WNveyrWzlEPqv0DQ42i+EU/k9YBq/3XPZ+8c
   YEKOuV4adiIoXWF7VfwilhXRWkn8II1oqwsTPcQWVx6UARQJjT3vHw6YI
   GDyEoWWxMlGmpRSbqlsw1WDuCsiPW0Gpys0Es69EnbBnMapDQU+fh6/Gn
   Qco8X8BcFagXQNpvQq6peoQHY6ckzU9tbFtiN4kIOkJK72+sLNncFOEW4
   EH2iWhB7b4Imr8a5sGpp/Ghf8L+l5A+IQ14JYOi53eKRUwPOFe96J8yxT
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="367876985"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="367876985"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 02:08:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="816615399"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="816615399"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga008.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Oct 2023 02:08:21 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC1)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qnbO6-00000002RQC-1J8S;
        Tue, 03 Oct 2023 12:08:18 +0300
Date:   Tue, 3 Oct 2023 12:08:18 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Raag Jadav <raag.jadav@intel.com>
Cc:     linus.walleij@linaro.org, mika.westerberg@linux.intel.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        mallikarjunappa.sangannavar@intel.com, bala.senthil@intel.com
Subject: Re: [PATCH v1] pinctrl: intel: refine intel_config_set_pull()
 function
Message-ID: <ZRvaAhpMEypapy26@smile.fi.intel.com>
References: <20231003081824.28810-1-raag.jadav@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231003081824.28810-1-raag.jadav@intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 03, 2023 at 01:48:24PM +0530, Raag Jadav wrote:
> Improve intel_config_set_pull() implementation in Intel pinctrl driver by:
> 
> - Reducing scope of spinlock by moving unneeded operations out of it.
> - Utilizing temporary variables for common operations.
> - Limiting IO operations to positive cases.

Pushed to my review and testing queue, thanks!

-- 
With Best Regards,
Andy Shevchenko


