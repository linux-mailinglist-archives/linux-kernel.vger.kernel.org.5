Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6313678F10C
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:17:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242860AbjHaQRm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243613AbjHaQRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:17:41 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 674E51B0
        for <linux-kernel@vger.kernel.org>; Thu, 31 Aug 2023 09:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693498656; x=1725034656;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=18wR8ngZpT/NhFFAjntbyC0LHD/2G9QIXcCJpwW6+Jg=;
  b=KsEJ5L9lEk0/Zs9Di60TCM1kT8UMbPwT1dKPu7yuF13dIEnEyUeiVjfn
   8boZqcxje7h/QO/2G4PEwMPkJ1k2ReSFABSBtluadVefP39W3kvJrSy0Z
   Ul/vSMl8qvHRJPA9B+M0iiiiBWlWAnDrkuTthoQfHFumP+t5GOdTi/V7c
   xh3ds/4SetxYT9e5RJmeKgU2hDEtJURMDFvmiqM6Z/88fKGh5cAQ6bKmF
   JTpRgoEmCFtVHbqNn37EOvSnnSURU8YWTal2+WACGXMjQIx7OfJFg2C13
   GO69htpnViyoFBphUU7yY94EBurHXaruLzcczfEvYOn9rUXlyeaHFRrHD
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="375933983"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="375933983"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 09:15:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="913344695"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="913344695"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga005.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 09:14:57 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qbkJo-005Qpr-1v;
        Thu, 31 Aug 2023 19:14:52 +0300
Date:   Thu, 31 Aug 2023 19:14:52 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Douglas Anderson <dianders@chromium.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>, Zhu Wang <wangzhu9@huawei.com>,
        =?iso-8859-1?Q?Adri=E1n?= Larumbe <adrian.larumbe@collabora.com>,
        Thierry Reding <treding@nvidia.com>,
        Ville =?iso-8859-1?Q?Syrj=E4l=E4?= 
        <ville.syrjala@linux.intel.com>,
        Guillaume BRUN <the.cheaterman@gmail.com>,
        Rob Herring <robh@kernel.org>, Sandor Yu <Sandor.yu@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>, Ondrej Jirman <megi@xff.cz>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/4] drm/bridge: Drop CONFIG_OF conditionals around
 of_node pointers
Message-ID: <ZPC8fJxQsRqJKK7k@smile.fi.intel.com>
References: <20230831080938.47454-1-biju.das.jz@bp.renesas.com>
 <20230831080938.47454-4-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831080938.47454-4-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 09:09:37AM +0100, Biju Das wrote:
> Having conditional around the of_node pointers turns out to make driver
> code use ugly #ifdef and #if blocks. So drop the conditionals.

...

>  	anx78xx->bridge.of_node = client->dev.of_node;

>  	panel_bridge->bridge.of_node = panel->dev->of_node;

>  	hdmi->bridge.of_node = pdev->dev.of_node;

>  	dsi->bridge.of_node = pdev->dev.of_node;

Yeah, I would really switch all of these to

	bridge->fwnode = dev_fwnode(...);

But it's a suggestion for a separate change that I think can happen
sooner than later.

-- 
With Best Regards,
Andy Shevchenko


