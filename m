Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1987778FA3D
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 10:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347212AbjIAIvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Sep 2023 04:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348551AbjIAIvJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Sep 2023 04:51:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5D7410EF
        for <linux-kernel@vger.kernel.org>; Fri,  1 Sep 2023 01:51:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693558264; x=1725094264;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=N2JhWu16noynEhUFQXj18o427aexXuBHoBeQG2E9mLo=;
  b=cQB1VpT4BnQI9wdMJEd/Eh2scoTWFpgkRinnY5conM7Hfx5LiiF/jmgh
   x+WNaivLhkj4sUzqVkRE/p2r31JVbUtqCZiipBiKxM1xwSlvobv0R1k7p
   H3UV+NdGlDuC2z7nWWC6KKp849M02I7ke7iw9a1yFhw/XIcWR+tbq+I3c
   kqxrTKZtupwYFGvftFTNBejVlX6EVoExJKftcvTe43HgrpV9TgesjCzEv
   uYhiRL4gZudzTYNza/lKmOKNbBCaYjyykAn3XXiHjD6Vm8kETwtGFY6GI
   +n1a4/g28rtIIVvZrxRFB6mYi1JL/GdVs3XDS5TbxtsdSmmJ9gN9a2gC3
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="407164851"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="407164851"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 01:51:03 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="739854298"
X-IronPort-AV: E=Sophos;i="6.02,219,1688454000"; 
   d="scan'208";a="739854298"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga002.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Sep 2023 01:51:00 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qbzrk-005co0-3D;
        Fri, 01 Sep 2023 11:50:56 +0300
Date:   Fri, 1 Sep 2023 11:50:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] ASoC: wm8580: Move OF table
Message-ID: <ZPGl8CroYVfRUDwk@smile.fi.intel.com>
References: <20230831201429.94554-1-biju.das.jz@bp.renesas.com>
 <20230831201429.94554-3-biju.das.jz@bp.renesas.com>
 <ZPEiGxftpGsHrhdc@smile.fi.intel.com>
 <OS0PR01MB59225F3B6218648EE650606B86E4A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OS0PR01MB59225F3B6218648EE650606B86E4A@OS0PR01MB5922.jpnprd01.prod.outlook.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 01, 2023 at 06:33:08AM +0000, Biju Das wrote:
> Hi Andy,
> 
> > Subject: Re: [PATCH v3 2/2] ASoC: wm8580: Move OF table
> > 
> > On Thu, Aug 31, 2023 at 09:14:29PM +0100, Biju Das wrote:
> > > Move OF table near to the user.
> > 
> > It does a bit more that that.
> 
> OK I will send separate patch for removing trailing comma
> in terminator.

It's fine to have them in a single patch as they are kinda related
(since you touch the lines anyway). My point is that this change
also needs to be described in the commit message.

-- 
With Best Regards,
Andy Shevchenko


