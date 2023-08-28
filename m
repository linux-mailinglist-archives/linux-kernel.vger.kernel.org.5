Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C61478AD75
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Aug 2023 12:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232050AbjH1Ksd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Aug 2023 06:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232111AbjH1KsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Aug 2023 06:48:11 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F0311B4
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 03:48:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693219682; x=1724755682;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=hqTn4OWArUED+Sh4oIj6OK93XFWFbPb60hshBveyuLU=;
  b=OYgqUmcbzUkYzYF9f4Za9xPXbN10xOp7TFjjnaugNc2LZJCCd6cWeNHR
   NoCvtyq9xSdTm/E3LDBGtkElznno5YkIrIS/I/RptFOJiNWzdGFYy5DtE
   8kefs8MlH/gLwNakbtJXeW5Q0Ew1vrGaVx05dd7piPt/QZul/T6lS0JIB
   ryPbtNLeqG4fWANygNcwC9qZW77xXOEBCNKfZwKwqmNElG5mLpb4/dbAi
   n1Bfg4T+2cXcN5wM23Gtl3IXUvM3PDo/f4XyEgTqka1PDs/p7YKwjZT6c
   l6EpB7VDIlO25KyeWKJKW4e8HDdBRVoEPiLbJhxMM92O7REBZCMxag6iV
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="373961580"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="373961580"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2023 03:48:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10815"; a="738201018"
X-IronPort-AV: E=Sophos;i="6.02,207,1688454000"; 
   d="scan'208";a="738201018"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP; 28 Aug 2023 03:47:56 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qaZmk-00Er8N-1m;
        Mon, 28 Aug 2023 13:47:54 +0300
Date:   Mon, 28 Aug 2023 13:47:54 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Shenghao Ding <shenghao-ding@ti.com>, robh+dt@kernel.org,
        lgirdwood@gmail.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, kevin-lu@ti.com,
        13916275206@139.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, liam.r.girdwood@intel.com,
        mengdong.lin@intel.com, baojun.xu@ti.com,
        thomas.gfeller@q-drop.com, peeyush@ti.com, navada@ti.com,
        broonie@kernel.org, gentuser@gmail.com
Subject: Re: [PATCH v5 1/2] ALSA: hda/tas2781: Add tas2781 HDA driver
Message-ID: <ZOx7WjdGPzPkqiQv@smile.fi.intel.com>
References: <20230828022556.578-1-shenghao-ding@ti.com>
 <87cyz71y7j.wl-tiwai@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87cyz71y7j.wl-tiwai@suse.de>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 28, 2023 at 08:24:16AM +0200, Takashi Iwai wrote:
> On Mon, 28 Aug 2023 04:25:55 +0200,
> Shenghao Ding wrote:
> > 
> > Integrate tas2781 configs for Lenovo Laptops. All of the tas2781s in the
> > laptop will be aggregated as one audio device. The code support realtek
> > as the primary codec.
> > 
> > Signed-off-by: Shenghao Ding <shenghao-ding@ti.com>
> 
> Shenghao, your previous patches have been already merged!
> Please take the latest sound.git tree before the submission.
> 
> Make your changes on top of the latest sound.git tree in a
> fine-grained incremental way, and submit those instead *ASAP*, so that
> the necessary fixes can be merged for 6.6-rc1.

...with Cc'ing me, please.

-- 
With Best Regards,
Andy Shevchenko


