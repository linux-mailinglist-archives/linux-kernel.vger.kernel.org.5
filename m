Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB0DE78C887
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 17:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237235AbjH2PYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 11:24:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237304AbjH2PYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 11:24:36 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B1071B7
        for <linux-kernel@vger.kernel.org>; Tue, 29 Aug 2023 08:24:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693322674; x=1724858674;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=S2OrXeEetaXxJWO+nOv8YwZ1HTZJEMQj0WR/NSWMXcA=;
  b=Uli0EvZfyWF1qsSxEL4eW9HTSPy0F9fyWPCd8k4Ruhr8mH884EwBedvP
   QG7JEWLBWRtw/pibmvoEfo79ApcfBQtZgUPae5yk8bNVjVguThlBspeDg
   x1nc83DWqYrpT+gHltSGWg9OPJH1xslVAvpR87pRU7/jFTvTVSNDWqk93
   s/JJ8QwZCrZQKDdysNRbf/YxUuo9HVwI6AzYCfbyWTpEhIDebd9DTpe/L
   mdCKUkt4PuA4ASx4HLLXFZFdLgLzWyKfSa+6dSiUOHX9i5gibnYynXOvP
   B6oiwUMb+cv7Vgq6JVNH7EDYtP0/g1oNiZSBROMYq/I/6C8i29SVQZ20K
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="406392730"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="406392730"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Aug 2023 08:24:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10817"; a="853321234"
X-IronPort-AV: E=Sophos;i="6.02,210,1688454000"; 
   d="scan'208";a="853321234"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP; 29 Aug 2023 08:24:31 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qb0Zx-004ukL-1k;
        Tue, 29 Aug 2023 18:24:29 +0300
Date:   Tue, 29 Aug 2023 18:24:29 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] ASoC: ak4642: Simplify probe()
Message-ID: <ZO4NrT36gbwc27+0@smile.fi.intel.com>
References: <20230828180003.127896-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230828180003.127896-1-biju.das.jz@bp.renesas.com>
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

On Mon, Aug 28, 2023 at 07:00:03PM +0100, Biju Das wrote:
> Simpilfy probe() by replacing of_device_get_match_data() and id lookup for
> retrieving match data by i2c_get_match_data() and replace
> dev_err()->dev_err_probe().

...

> -	if (np) {
> -		const struct of_device_id *of_id;
> -

> +	if (dev_fwnode(dev)) {

Why do we need this at all?

>  		mcko = ak4642_of_parse_mcko(dev);
>  		if (IS_ERR(mcko))
>  			mcko = NULL;

This can suffice on its own, right?

Can be done in a separate change as a precursor to this one.

> -
> -		of_id = of_match_device(ak4642_of_match, dev);
> -		if (of_id)
> -			drvdata = of_id->data;
> -	} else {
> -		const struct i2c_device_id *id =
> -			i2c_match_id(ak4642_i2c_id, i2c);
> -		drvdata = (const struct ak4642_drvdata *)id->driver_data;
>  	}

-- 
With Best Regards,
Andy Shevchenko


