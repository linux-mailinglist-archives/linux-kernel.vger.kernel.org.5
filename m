Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CFC978F12E
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 18:23:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238230AbjHaQXM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 12:23:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241534AbjHaQXF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 12:23:05 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EF9112C;
        Thu, 31 Aug 2023 09:22:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693498977; x=1725034977;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=GGX5htp3AON2nxraBoBvb08szZP0d7Lzxqr8UlKVBSA=;
  b=lEQZU/7FWuoCRag1NHKnUtXdc4KgtqnDOjrbcysfLN7HILeGedJxFbvS
   4KxigAzxV/WTYGsUDRkoVEgA0AagKfx+WGxy74DqPWyDddIEUihfEnqXX
   vjYAOLbjqneZuxN+X3QREink6AhQQ3eAS3k7wuyj3OLegKQ0USFNDFjLb
   lCp40pJY2sumFQRNPsVe8zCwGjKRP5iMk125PfiZjjFX4m/2oqetmTeKB
   Q/XFpbAi9zyDTgy6bQ7ETK/CUIco/6YdFmxXTTgexCKHw15wppe/7XxX/
   ja3qHt8RP8+dDGRn/Gi6Dk49xl9tfuIxisfuPovCBxZLdHptYewWIGb9n
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="356307140"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="356307140"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 09:22:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10819"; a="854327679"
X-IronPort-AV: E=Sophos;i="6.02,217,1688454000"; 
   d="scan'208";a="854327679"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga002.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2023 09:21:59 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1qbkQe-005Quy-2K;
        Thu, 31 Aug 2023 19:21:56 +0300
Date:   Thu, 31 Aug 2023 19:21:56 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Match data improvements for rt1711h driver
Message-ID: <ZPC+JNfPlfRvehvG@smile.fi.intel.com>
References: <20230831160501.55081-1-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831160501.55081-1-biju.das.jz@bp.renesas.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 05:04:56PM +0100, Biju Das wrote:
> This patch series extend support for retrieving match data for ID lookup
> by using i2c_get_match_data().
> 
> The first patch fixes the driver_data for ID table and second patch
> convert enum->pointer for constification of data and extending match data
> support for ID table. The third and fourth patches replaces comparison of
> did against hardware differences with data and feature variable. The last
> patch drop CONFIG_OF ifdeffery.
> 
> This patch series is only compile tested.

FWIW, with the cosmetic changes it's fine,
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

-- 
With Best Regards,
Andy Shevchenko


