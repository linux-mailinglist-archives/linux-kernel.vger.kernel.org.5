Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66E967DF2C7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Nov 2023 13:50:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234827AbjKBMuO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Nov 2023 08:50:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjKBMuN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Nov 2023 08:50:13 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95FDA12F;
        Thu,  2 Nov 2023 05:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698929407; x=1730465407;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=c2vyFTVnaWpz+keCJtdyM0qcjQXSrJPEBxbkHvGNQoU=;
  b=NJ4ossLPK6kPRTsjQhW63j1H4mE9/dsNNOqWUZBZBX/rBsqgaB1IL2UB
   wVBUl9Cnc133GEAIULGM5cdcHb2/dUzQQcgqjIjryLcns0WNVMSE0jjjv
   LxklUtYkPRzhimQQca2vU70uuQv89vgGg5ncPUegnjMv6M8MvNT3MrUjS
   OP/JqYbYAuTbiUBuEa6BE8P23QYI/W1EENh4L2yKP7oEc4oIyCSDd/Qk/
   m2YpsXDIZudHF2DV3yfrMQ7Xf8+AzDwUC8NcrGQgorN2CN+knWyrPH3Pe
   Mxk6cRe9io2yIMF0mqX8/O9TcWeTM/W3ZoW/mS59cHZi3XmQ3TOicVfY4
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="455185831"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="455185831"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 05:50:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10881"; a="711142226"
X-IronPort-AV: E=Sophos;i="6.03,271,1694761200"; 
   d="scan'208";a="711142226"
Received: from smile.fi.intel.com ([10.237.72.54])
  by orsmga003.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Nov 2023 05:50:03 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC3)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qyX96-0000000Agna-1mXE;
        Thu, 02 Nov 2023 14:50:00 +0200
Date:   Thu, 2 Nov 2023 14:50:00 +0200
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Paul Gazzillo <paul@pgazz.com>,
        Matt Ranostay <matt@ranostay.sg>,
        Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] iio: light: Add support for APDS9306 Light Sensor
Message-ID: <ZUOa-Ml7YdWoAXBe@smile.fi.intel.com>
References: <20231027074545.6055-1-subhajit.ghosh@tweaklogic.com>
 <20231027074545.6055-3-subhajit.ghosh@tweaklogic.com>
 <20231028162025.4259f1cc@jic23-huawei>
 <84d7c283-e8e5-4c98-835c-fe3f6ff94f4b@gmail.com>
 <6a697c62-6a7c-4b31-bc8e-10f40db0363d@gmail.com>
 <d528b45c-123d-4ef7-b110-7efbfef91bc5@gmail.com>
 <ZUDZIEY_uTVMHh3C@smile.fi.intel.com>
 <b01930d6-5bec-496c-89de-6cf6d178c860@gmail.com>
 <ZUEET34K7AOkFf4A@smile.fi.intel.com>
 <6d553aaa-279f-48bf-96c9-30fdac1ae372@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d553aaa-279f-48bf-96c9-30fdac1ae372@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 01, 2023 at 08:16:32AM +0200, Matti Vaittinen wrote:
> On 10/31/23 15:42, Andy Shevchenko wrote:
> > On Tue, Oct 31, 2023 at 02:07:46PM +0200, Matti Vaittinen wrote:
> > > On 10/31/23 12:38, Andy Shevchenko wrote:
> > > > On Tue, Oct 31, 2023 at 09:11:37AM +0200, Matti Vaittinen wrote:
> > > > > On 10/30/23 12:21, Matti Vaittinen wrote:
> > > > > > On 10/29/23 17:51, Matti Vaittinen wrote:
> > > > > > > On 10/28/23 18:20, Jonathan Cameron wrote:

...

> > > > > 	tmp = gts->max_scale;
> > > > > 
> > > > > 	rem = do_div(tmp, total_gain);
> > > > > 	if (total_gain > 1 && rem >= total_gain / 2)
> > > > > 		tmp += 1ULL;
> > > > 
> > > > ...which is NIH DIV_ROUND_CLOSEST_ULL()
> > > 
> > > There is a difference though. The DIV_ROUND_CLOSEST_ULL() does
> > > 
> > > tmp + total_gain / 2;
> > > 
> > > before division - which in theory may overflow.
> > 
> > Then you can fix it there for everybody, no?
> 
> Now that I know of this macro - Maybe. It's just always scary to touch
> things which seem like fundamental building blocks and which may be used by
> many. Odds are something breaks, so I tend to be very conservative when
> suggesting changes to widely used stuff. Especially when I have no idea when
> and why the API has been added - and if the thing I'm trying to "fix" has
> been a deliberate choice.

Welcome to the club of the div overflow in macros discussion:

https://lore.kernel.org/linux-clk/20231024161931.78567-1-sebastian.reichel@collabora.com/T/#t

-- 
With Best Regards,
Andy Shevchenko


