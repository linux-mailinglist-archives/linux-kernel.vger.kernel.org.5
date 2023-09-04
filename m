Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E1FF79138D
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 10:34:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245162AbjIDIet (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 04:34:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbjIDIes (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 04:34:48 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D5193;
        Mon,  4 Sep 2023 01:34:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1693816485; x=1725352485;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=QPvilHNcZ73Z+piXyBECqcWu7tJp9af8ek7uk1Qti8k=;
  b=F83xWcGT5hGv5URVSVntUpZSZmSOsTtOHZQnLTf/y4wJpZwb5JwXI+tR
   Cup3kEpeJ2wv36M9RisBExcanPHsE0iFGXLp9xa8xojDYqi49GcoKJeiP
   +nXJiFFKqU+pTby/oUo42mo1kCDxMGFLdwKR1CnQaHaXhlNriCBbiG+nN
   07Yu9fCkZEmKncyuSUkuE4jSYDYVNCs6rk0t2tLpz7SbHPI4rnZijRSG0
   MLjuIVYnBvg+F07Ytzj1yoO3c3x2aGl+lKNdExNNydHpgsKtKNHLk2ROf
   CdHW5r5uj0d9DmyGP/sQZKAS0/ENPbIeVeSHvCkZgIv1dMkRIO82IWXmM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="366771277"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="366771277"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Sep 2023 01:34:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10822"; a="810837159"
X-IronPort-AV: E=Sophos;i="6.02,225,1688454000"; 
   d="scan'208";a="810837159"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga004.fm.intel.com with SMTP; 04 Sep 2023 01:34:37 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Mon, 04 Sep 2023 11:34:36 +0300
Date:   Mon, 4 Sep 2023 11:34:36 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v2 1/5] usb: typec: tcpci_rt1711h: Make similar OF and ID
 table
Message-ID: <ZPWWnOyhoOkLzOlV@kuha.fi.intel.com>
References: <20230831160501.55081-1-biju.das.jz@bp.renesas.com>
 <20230831160501.55081-2-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230831160501.55081-2-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 31, 2023 at 05:04:57PM +0100, Biju Das wrote:
> Make similar OF and ID table to extend support for ID match
> using i2c_match_data() later. Currently it works only for OF match
> tables as the driver_data is wrong for ID match.
> 
> While at it, drop a space from the terminator braces for ID table and
> remove trailing comma in the terminator entry for OF table.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> ---
> v1->v2:
>  * Drop space from ID table
>  * Remove trailing comma in the terminator entry for OF table.
> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index 17ebc5fb684f..5ed3d0864431 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -392,9 +392,9 @@ static void rt1711h_remove(struct i2c_client *client)
>  }
>  
>  static const struct i2c_device_id rt1711h_id[] = {
> -	{ "rt1711h", 0 },
> -	{ "rt1715", 0 },
> -	{ }
> +	{ "rt1711h", RT1711H_DID },
> +	{ "rt1715", RT1715_DID },
> +	{}

This is too confusing and messy. Don't assign those RT1711H_DID in
this patch at all - you are not using the I2C driver data anywhere
yet, and in next patch where you start using it, you replace those
assignments with an actual driver data structure that then contain the
values (that did memeber). So there is not point in using the driver
data here at all.

Just make this patch a cleanup patch where you remove the commas, and
deal with those RT1715_DID in the next patch just like you already do.

>  };
>  MODULE_DEVICE_TABLE(i2c, rt1711h_id);
>  
> @@ -402,7 +402,7 @@ MODULE_DEVICE_TABLE(i2c, rt1711h_id);
>  static const struct of_device_id rt1711h_of_match[] = {
>  	{ .compatible = "richtek,rt1711h", .data = (void *)RT1711H_DID },
>  	{ .compatible = "richtek,rt1715", .data = (void *)RT1715_DID },
> -	{},
> +	{}
>  };
>  MODULE_DEVICE_TABLE(of, rt1711h_of_match);
>  #endif

thanks,

-- 
heikki
