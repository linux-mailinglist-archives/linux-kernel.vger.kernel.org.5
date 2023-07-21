Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E77E75C4CA
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 12:36:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230133AbjGUKgo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 06:36:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229749AbjGUKgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 06:36:39 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CA9172A;
        Fri, 21 Jul 2023 03:36:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1689935797; x=1721471797;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=9Pcy3XY7VtAgZTGY4GeeWAbZPg9qIYLRSlYZUTwuw5g=;
  b=SVPIZIOly0Gdw+7OuPbGbHox/Did7AXZ/SeoGua/cplx5ePvk8ne4sWh
   Hq7MHj2vmO5z/zLzcerH2PtxGfouzIFO7Sa44YdugS+XPy/euy6ISPmsO
   e0e0jppoVLV7wyT/Hk/uYSGO0vm42kpGSeK5U9YwQ7QkWHrUSgJx0958Z
   7K+seHRJJ0Bpv0kMHK0Qnz3k3nY+Cu0lxoQV8Y/Cw7oDwwpPPKrCpz0Gq
   fwricUbOXHVpq/yQMvwwKF6UwWdwnEChni+kBNaAXoklRASd8MM30Wguj
   2Mc8NSvCLp458jY8raoRn9shnKsgrs8l7Vpe8VbUjK2ZQVVQiYgHHyc/s
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="367030658"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="367030658"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2023 03:36:35 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10777"; a="1055519765"
X-IronPort-AV: E=Sophos;i="6.01,220,1684825200"; 
   d="scan'208";a="1055519765"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 21 Jul 2023 03:36:32 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qMnUt-000KTV-0e;
        Fri, 21 Jul 2023 13:36:31 +0300
Date:   Fri, 21 Jul 2023 13:36:30 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, Dhruva Gole <d-gole@ti.com>,
        Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        John Ogness <john.ogness@linutronix.de>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-omap@vger.kernel.org
Subject: Re: [PATCH v3 0/3] Serial core controller port device name fixes
Message-ID: <ZLpfrtxG3/TBS3Sk@smile.fi.intel.com>
References: <20230721072147.59121-1-tony@atomide.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230721072147.59121-1-tony@atomide.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 21, 2023 at 10:21:39AM +0300, Tony Lindgren wrote:
> A few issues have been found with device naming for the serial core
> controller port device. These issues currently mostly affect the output
> for /sys/bus/serial-base/devices, but need to be also fixed to avoid
> port addressing issues later on.

With the addressed change,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
for the entire series, good fixes!

-- 
With Best Regards,
Andy Shevchenko


