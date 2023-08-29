Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C26A78C825
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 16:59:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237140AbjH2O63 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 10:58:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237136AbjH2O6E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 10:58:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46F34184
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 07:58:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693321082; x=1724857082;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Ck545Pxbz0uvt5JTh4DBhYmcQrfA5M8/JWV7Pbu5juE=;
  b=Mh3l3LTxAMYGfXiV5Km5O836kAuN41nR5Jp476t9h1ewczcX4lot8gvh
   H1t0fOD7TTWklqMF/3RZt/OOMXgVnWddbEhr7/g/bKPCw68AOPPXEOYUi
   19nMpcIe21lw4uhXZaKv/Mpe0EsCqFu2aiK1UA/u/ADL4fOMbHuZeC/Jt
   nNSaQ/2sxDDtyc98g546debtC56oV0wFk7ZFO1Rt5tvG23cKpcXNSyIcj
   WLiV/j7CR07KdP3z+cXkJtyZcOXpUCac35U2BLhKOiJG/c+4HxAeIj9vZ
   zLHWVY0YmzMVLXXViRWiaM1toiSKHuBXkap411v4gqPy3Cu37bVDD53iy
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="372799785"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="372799785"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 07:58:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="732235172"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="732235172"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga007.jf.intel.com with ESMTP; 29 Aug 2023 07:57:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb0AE-004uNa-1s;
        Tue, 29 Aug 2023 17:57:54 +0300
Date:   Tue, 29 Aug 2023 17:57:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Shenghao Ding <shenghao-ding@ti.com>, Kevin Lu <kevin-lu@ti.com>,
        Baojun Xu <x1077012@ti.com>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] ASoC: codec: tlv320aic32x4: Add enum aic32x4_type
 to aic32x4_probe()
Message-ID: <ZO4Hci2jfp07U2Ne@smile.fi.intel.com>
References: <20230828191014.138310-1-biju.das.jz@bp.renesas.com>
 <20230828191014.138310-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828191014.138310-2-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 08:10:13PM +0100, Biju Das wrote:
> Add enum aic32x4_type to aic32x4_probe() and drop using dev_set_drvdata()
> from tlv320aic32x4_{i2c,spi} drivers.

Yep, something like this, which looks okay to me
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


