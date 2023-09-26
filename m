Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5957AEFCB
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Sep 2023 17:37:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235134AbjIZPhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Sep 2023 11:37:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234874AbjIZPht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Sep 2023 11:37:49 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CD2EB;
        Tue, 26 Sep 2023 08:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695742662; x=1727278662;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=T6IyjL9p+uU69BamxAdtTuMWMobDIzJhylvNQq/SuzE=;
  b=dzJd7/Qwf2zkLzbJ+ArBzSo+6FQ1rtCfb/kEIpQHkLxmwPu/G/KAlMOx
   3XLjfrdpLuy7KGUgOcJTWKKr3MhTyNf0x7F0J+1UB3xu07w+w14zfc4hD
   4OIX5j1GxAV/mgIvG4OM6T1tpH0UDP2y15HQtYe2QwX0PgJhI/GUO/0hM
   8Ya/lPliLjoyRYW4FnqmZbV3Y5bgIOvuBN+HisQAlu6hlAeNzGesP3Y7r
   5rrvTrNmv8CeKBDeZEm107rxwKanZ3WOgbEefG6tk44oCepC76h/EwIt+
   S8quZdyAlMqkOI11L8Kp3fcsj/PMlGLSOwUWppG6xu1mNy67NCtXB38Qs
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="381495887"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="381495887"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2023 08:37:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10845"; a="995844198"
X-IronPort-AV: E=Sophos;i="6.03,178,1694761200"; 
   d="scan'208";a="995844198"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga006.fm.intel.com with ESMTP; 26 Sep 2023 08:37:31 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 89FE811D; Tue, 26 Sep 2023 18:37:29 +0300 (EEST)
Date:   Tue, 26 Sep 2023 18:37:29 +0300
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andy@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Raag Jadav <raag.jadav@intel.com>
Subject: Re: [PATCH v1 1/1] pinctrl: intel: Simplify code with cleanup helpers
Message-ID: <20230926153729.GW3208943@black.fi.intel.com>
References: <20230926132336.416612-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230926132336.416612-1-andriy.shevchenko@linux.intel.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 26, 2023 at 04:23:35PM +0300, Andy Shevchenko wrote:
> Use macros defined in linux/cleanup.h to automate resource lifetime
> control in the driver.
> 
> While at it, unify the variables and approach in intel_gpio_irq_*().
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Acked-by: Mika Westerberg <mika.westerberg@linux.intel.com>
