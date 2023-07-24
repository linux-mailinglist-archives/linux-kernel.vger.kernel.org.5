Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0A475F1A3
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jul 2023 12:00:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232997AbjGXKAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jul 2023 06:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232965AbjGXKAN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jul 2023 06:00:13 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2D784ED5
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 02:54:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1690192457; x=1721728457;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=scpBJ577mRimOo62TKgu6+oiwI4ovv5AJtXfkH9zf/A=;
  b=NOFNbbZUe5n4JU18bP4d/K7dRUqW0jATwVRi2pgcwlTJFQ/Bs0TgFDbY
   IRj9aNn2+D+eXDGt1G0Qq1MUYBtK9yE8Py8aCrg7Ytp1Etk89F4FbDwJD
   vF6Mq7wpN/F0mocOjdWIjxB/6KolrrkZJyxhxhKY2mhdSMbDQ0h5X6Egd
   6AEUTUIVPic6DRzr9rabcrbYuhkDCU0r8dHGQok/DlwtfSnuVBHtQkGlz
   QHrO0/Ekc7Xukvqm+RwB+uKbPx8dHH06OrUHUeusqtrSN0b9YESznoeXH
   ZR4rRTUWxh0dQHCLC4M8Y7JpnOVcPM3vQDRiQy2Mk0GW9d2IvunGiOifY
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="367423782"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="367423782"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jul 2023 02:52:20 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10780"; a="972201808"
X-IronPort-AV: E=Sophos;i="6.01,228,1684825200"; 
   d="scan'208";a="972201808"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP; 24 Jul 2023 02:52:16 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qNsEg-007Lw4-1L;
        Mon, 24 Jul 2023 12:52:14 +0300
Date:   Mon, 24 Jul 2023 12:52:14 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Cc:     Brent Lu <brent.lu@intel.com>, alsa-devel@alsa-project.org,
        Cezary Rojewski <cezary.rojewski@intel.com>,
        Liam Girdwood <liam.r.girdwood@linux.intel.com>,
        Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
        Bard Liao <yung-chuan.liao@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        Yong Zhi <yong.zhi@intel.com>,
        Ajye Huang <ajye_huang@compal.corp-partner.google.com>,
        Uday M Bhat <uday.m.bhat@intel.com>,
        Terry Cheong <htcheong@chromium.org>,
        Mac Chiang <mac.chiang@intel.com>,
        "Dharageswari . R" <dharageswari.r@intel.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Subject: Re: [PATCH 1/2] ASoC: Intel: maxim-common: get codec number from ACPI
Message-ID: <ZL5Jzod5NBETv9Dp@smile.fi.intel.com>
References: <20230720092628.758834-1-brent.lu@intel.com>
 <20230720092628.758834-2-brent.lu@intel.com>
 <dc6de509-6984-1434-b53f-9600e8bc7c49@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dc6de509-6984-1434-b53f-9600e8bc7c49@linux.intel.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 24, 2023 at 11:08:17AM +0200, Pierre-Louis Bossart wrote:
> On 7/20/23 11:26, Brent Lu wrote:

...

> > +/* helper function to get the number of specific codec */

...and leak a lot of reference counts...

> > +static int get_num_codecs(const char *hid)
> > +{
> > +	struct acpi_device *adev = NULL;
> > +	int dev_num = 0;
> > +
> > +	do {
> > +		adev = acpi_dev_get_next_match_dev(adev, hid, NULL, -1);
> 
> Humm, I am a bit worried about reference counts.
> 
> See
> https://elixir.bootlin.com/linux/latest/source/drivers/acpi/utils.c#L916,
> it's not clear to me where the get() is done.
> 
> Adding Andy to make sure this is done right.

Thank you for Cc'ing.

Yes, the above code is problematic. One has to use the respective for_each
macro (defined nearby the used API).

> > +		if (adev)
> > +			dev_num++;
> > +	} while (adev != NULL);
> > +
> > +	return dev_num;
> > +}

-- 
With Best Regards,
Andy Shevchenko


