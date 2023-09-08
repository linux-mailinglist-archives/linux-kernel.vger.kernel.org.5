Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E71527985FA
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:40:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbjIHKkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232562AbjIHKkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:40:09 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56BB71BEA;
        Fri,  8 Sep 2023 03:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694169605; x=1725705605;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=ChRIocRSvTPLzU4K33bYP3OHnOGAoO8zbuDdSmmGjoA=;
  b=EjwMfWJXQ4HxG96HFppGKA2Elukb52zFzcEM7WbJosRxu8X/Pm2JWly+
   WLtmg9fiWu0IRvwbe5z1T4DkYJwAwFcVVqC7U5tz+l7Gme3jFgTFr06Up
   G4brA8zn49vYZws3Np6gqbc3hxJVNIG/8dZkPORRc2jBRXCoAB5kZL9j6
   /4KnOhZnMkWipWTN4OVfODJAgeUZ64lVjsehUHCIwlNCnmh+YE0IwSXXs
   i5c3Jv2upSbYnmApvM5fZldyJueg7q6lKQObkkldv7awf15c/NXLAf57w
   O+lkssZLnir7dUkWC7WTZ0r3JfbHOT0ehhJBWOPB1w0vGO7G2ZPLID14I
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="408606122"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="408606122"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 03:40:04 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="735917683"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="735917683"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by orsmga007.jf.intel.com with SMTP; 08 Sep 2023 03:40:01 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 08 Sep 2023 13:40:00 +0300
Date:   Fri, 8 Sep 2023 13:40:00 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 5/5] usb: typec: tcpci_rt1711h: Drop CONFIG_OF
 ifdeffery
Message-ID: <ZPr6AFK8W0Y31H50@kuha.fi.intel.com>
References: <20230906080619.36930-1-biju.das.jz@bp.renesas.com>
 <20230906080619.36930-6-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906080619.36930-6-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 09:06:19AM +0100, Biju Das wrote:
> Drop of_match_ptr() from rt1711h_of_match and get rid of ugly CONFIG_OF
> ifdeffery. This slightly increases the size of rt1711h_of_match on non-OF
> system and shouldn't be an issue.
> 
> It also allows, in case if needed, to enumerate this device via ACPI with
> PRP0001 magic.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v2->v3:
>  * Added Rb tag from Andy.
>  * Updated commit description for ACPI with PRP0001 magic.
> v2:
>  * New patch
> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index 5d2dc7ead9d0..67422d45eb54 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -7,6 +7,7 @@
>  
>  #include <linux/bits.h>
>  #include <linux/kernel.h>
> +#include <linux/mod_devicetable.h>
>  #include <linux/module.h>
>  #include <linux/i2c.h>
>  #include <linux/interrupt.h>
> @@ -411,19 +412,17 @@ static const struct i2c_device_id rt1711h_id[] = {
>  };
>  MODULE_DEVICE_TABLE(i2c, rt1711h_id);
>  
> -#ifdef CONFIG_OF
>  static const struct of_device_id rt1711h_of_match[] = {
>  	{ .compatible = "richtek,rt1711h", .data = &rt1711h },
>  	{ .compatible = "richtek,rt1715", .data = &rt1715 },
>  	{}
>  };
>  MODULE_DEVICE_TABLE(of, rt1711h_of_match);
> -#endif
>  
>  static struct i2c_driver rt1711h_i2c_driver = {
>  	.driver = {
>  		.name = "rt1711h",
> -		.of_match_table = of_match_ptr(rt1711h_of_match),
> +		.of_match_table = rt1711h_of_match,
>  	},
>  	.probe = rt1711h_probe,
>  	.remove = rt1711h_remove,
> -- 
> 2.25.1

-- 
heikki
