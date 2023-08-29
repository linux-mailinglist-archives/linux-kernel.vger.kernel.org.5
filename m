Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DD5178C827
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234053AbjH2O7C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:59:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbjH2O6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:58:46 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D561BC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:58:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693321124; x=1724857124;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=MvhqyS4ce7t8iByMHKHstZcA8GJKDvlSv2FT4RuSisM=;
  b=LnzORlq2dSPxEG9G4al5+0ZqKiSimEyZ2riT0JyECEOu/V/BL0Bm3ugn
   hWccBP3jsD8SpjX145z238pkbD1r5ivDZolwemLc9abbdBGWIxSm6wD5w
   tUMOEJ8xkd/Oem7M4EIIJH59YLl9JExNbiKT2FbQovq5dPQD9q63MNAdq
   QtOI0Z58rbMIsOunrTHAqHUBD+PkBxqB8Y/X93Q9eB88RgXI1eUB+f9Cn
   2yL7cdu9s9zJSaYq67ZGr22/KEyjc2yIw63wIhI/RYhoudaUXHViwUjuv
   pmIhVq4w6kRStV28SqGa5jIZ1MStKcmEnbXEhPcmt7+b49CN40iVbSAOq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="355713105"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="355713105"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:58:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="1069489564"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="1069489564"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 29 Aug 2023 07:58:41 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb0Ax-004uOo-1m;
        Tue, 29 Aug 2023 17:58:39 +0300
Date:   Tue, 29 Aug 2023 17:58:39 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <x1077012@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Match data improvements for tlv320aic32x4 driver
Message-ID: <ZO4Hn8FrtqdVN379@smile.fi.intel.com>
References: <20230828191014.138310-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828191014.138310-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 08:10:12PM +0100, Biju Das wrote:
> This patch series aims to add match data improvements for tlv320aic32x4
> driver.
> 
> This patch series is only compile tested.

Also convert SPI to the new similar API.

-- 
With Best Regards,
Andy Shevchenko


