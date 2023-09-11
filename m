Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563DA79AE6C
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 01:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356382AbjIKWDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 18:03:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236287AbjIKKKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 06:10:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF6E101;
        Mon, 11 Sep 2023 03:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694427041; x=1725963041;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=FZOFUYe1WhhZO3v6oURDqElM6ZV1goFETHTw7RTM4a0=;
  b=Ax8xivzdMSOwEwKgdlyYNh1yzPBH+7aYNOBtTHoZ3GBvHm2n7eD/jLYc
   ofxzg9DjrCYJGQ8Me6yMDQWW6Hx/MtQd/bzFyT2zKFHelO4+yDiJyt5CI
   5hNJ3QpbPXyp6EWqbCwrINyO9oAXj1DxmM1/JGjy+rRAgLdVKFTIfvf3U
   beXtSeU7aTURF5wen1Uvyjo6qNSkrMnt0iLYQFvM8h1+zNypletoH5N+0
   MqUk4UFTxlvRGIwrXdiyYzfZjb9jlt8OciuI1vUfuww8Q1TVZqtU5Vuzf
   fdwm9auKe9iyErXVll2si2Bnu9Nvduv02yiKAKzZRkv4ZoxHPeiFhX35+
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="380743389"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="380743389"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:10:41 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10829"; a="990045128"
X-IronPort-AV: E=Sophos;i="6.02,243,1688454000"; 
   d="scan'208";a="990045128"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Sep 2023 03:10:39 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qfdsK-008HrE-2u;
        Mon, 11 Sep 2023 13:10:36 +0300
Date:   Mon, 11 Sep 2023 13:10:36 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>
Subject: Re: [PATCH v2 0/4] Match data improvements for mcp23s08 driver
Message-ID: <ZP7nnIdwQCcOV6MY@smile.fi.intel.com>
References: <20230909121903.34062-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230909121903.34062-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 09, 2023 at 01:18:59PM +0100, Biju Das wrote:
> This patch series aims to add match data improvements for mcp23s08 driver.
> This patch series is only compile tested.

Now, do you see the common grounds for unifying two data structure types you
created?

IN the common header you may introduce a type and use it in the both files.

For the patches 1 & 3 (the API simplification):
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


