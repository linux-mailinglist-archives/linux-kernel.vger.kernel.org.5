Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EB307ADF96
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Sep 2023 21:28:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233305AbjIYT2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Sep 2023 15:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233308AbjIYT2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Sep 2023 15:28:04 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FF0B10C;
        Mon, 25 Sep 2023 12:27:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695670078; x=1727206078;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=G+AzBDEkkM1eADSIyN25cfwmNNwetV4UoEJVlZExwOM=;
  b=Pl+pSi3ZUIbM1xn4IahcvgUD+Fbz4qkphC/Z5UTzEQA5AlIr/ZKf7bxg
   /KehrDltwLEQUX3IyNUZRxslf4ejTB41g7c8Wr2WG4Yobe9MuQEOJDbWb
   V3Gb5RC/RfqqJUBCkbNAQMzYLCKeM+gKM7gFiFSgQhaTXu6TH0a9Lwzmt
   QtWj0QQU+FPibRpY6Eb6UVhOIwWSALEw3Ta6IIuzj1lBssAvjef4T3x4s
   uTR489LmPu4Q/s9VTQfoU1c8RfARWhz+iaTjQjlsZaDzW86NnN7n0Jhjm
   O2cJX4Iakm6QVAHCKlr2/K0yf0vjPNvNv1Ycs453q1YW5vHvQjVycdav1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="384123235"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="384123235"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 12:27:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10843"; a="995506037"
X-IronPort-AV: E=Sophos;i="6.03,175,1694761200"; 
   d="scan'208";a="995506037"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga006.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Sep 2023 12:27:53 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.97-RC0)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qkrFG-00000000Q7q-3Fmf;
        Mon, 25 Sep 2023 22:27:50 +0300
Date:   Mon, 25 Sep 2023 22:27:50 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     "Patel, Utkarsh H" <utkarsh.h.patel@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "heikki.krogerus@linux.intel.com" <heikki.krogerus@linux.intel.com>,
        "pmalani@chromium.org" <pmalani@chromium.org>,
        "chrome-platform@lists.linux.dev" <chrome-platform@lists.linux.dev>,
        "bleung@chromium.org" <bleung@chromium.org>
Subject: Re: [PATCH v4 4/5] platform/chrome: cros_ec_typec: Add Displayport
 Alternatemode 2.1 Support
Message-ID: <ZRHfNoiDazz1ZDtD@smile.fi.intel.com>
References: <20230920023243.2494410-1-utkarsh.h.patel@intel.com>
 <20230920023243.2494410-5-utkarsh.h.patel@intel.com>
 <ZQsE5hgm4qYpr/My@smile.fi.intel.com>
 <CY4PR11MB0037E70612B8067062AC1C40A9FCA@CY4PR11MB0037.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CY4PR11MB0037E70612B8067062AC1C40A9FCA@CY4PR11MB0037.namprd11.prod.outlook.com>
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

On Mon, Sep 25, 2023 at 03:54:40PM +0000, Patel, Utkarsh H wrote:

...

> > > +	/**
> > 
> > Are you sure?
> > 
> > > +	 * Get cable VDO for thunderbolt cables and cables with DPSID but
> > does not
> > > +	 * support DPAM2.1.
> > > +	 */
> > 
> Yes, there are TBT3 cables which advertise DPSID but does not provide any DP
> capabilities in the DP discover mode VDO but does support UHBR.  In that
> case, need to use TBTSID and use capabilities from TBT discover mode VDO.

My comment was against the style of the comment, not about content.

...

> > You can also make it a bit more readable with (use better names if you think it's
> > needed)
> > 
> > 	u32 signalling = 0;
> > 	u32 cable_type = 0;
> 
> In v2 version of this patch I had them but there was feedback to remove extra
> variables and use them inline. 

OK!

-- 
With Best Regards,
Andy Shevchenko


