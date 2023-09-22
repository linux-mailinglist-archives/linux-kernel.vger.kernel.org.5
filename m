Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803667AB003
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Sep 2023 12:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjIVKy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Sep 2023 06:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjIVKyu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Sep 2023 06:54:50 -0400
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A94F8AF;
        Fri, 22 Sep 2023 03:54:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695380084; x=1726916084;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=0WB5DDFRtg58eQ7nGqR1DIk4BRpwOkm1iWenUy1vKxo=;
  b=K2DZ9DU78DnZwqibYz1LcQVFwCtv+aEPnyZ1js83iCtmO/xXfPLLhFQ9
   6o7eE3SFMQqMZTGAz7uP09a/aUdjpXnCR6NjFNv6xUvJNCJ6lUhOz0kke
   sqsOqVYQwNJ4mMB3rVPQHGlFl2Y2xNm9H2SzmCpn6LdAg//l0oyGNar36
   pcV8QzUWbzySRmoaW6UkpOJUfbcrPY/usGmQZFWh2FQkHbEegSmP/XTGP
   L9iSK6My8uUpBN0TBzyrmLkUQre6YE9eS+I1AqXRA11NaGjQzt44PhFB+
   q7Nz816MHaUxsJrlzvvzqiStvzvubM3JxPEaJW/MzT00L/2Z3nFjTZsy1
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="467099219"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="467099219"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Sep 2023 03:54:44 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10840"; a="1078325607"
X-IronPort-AV: E=Sophos;i="6.03,167,1694761200"; 
   d="scan'208";a="1078325607"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga005.fm.intel.com with SMTP; 22 Sep 2023 03:54:41 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 22 Sep 2023 13:54:40 +0300
Date:   Fri, 22 Sep 2023 13:54:40 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] usb: typec: drop check because
 i2c_unregister_device() is NULL safe
Message-ID: <ZQ1ycKqP37jTYYGX@kuha.fi.intel.com>
References: <20230922080421.35145-1-wsa+renesas@sang-engineering.com>
 <20230922080421.35145-2-wsa+renesas@sang-engineering.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230922080421.35145-2-wsa+renesas@sang-engineering.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 22, 2023 at 10:04:18AM +0200, Wolfram Sang wrote:
> No need to check the argument of i2c_unregister_device() because the
> function itself does it.
> 
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Acked-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Build tested only. Please apply to your tree.
> 
>  drivers/usb/typec/anx7411.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/usb/typec/anx7411.c b/drivers/usb/typec/anx7411.c
> index 221604f933a4..b12a07edc71b 100644
> --- a/drivers/usb/typec/anx7411.c
> +++ b/drivers/usb/typec/anx7411.c
> @@ -1550,8 +1550,7 @@ static void anx7411_i2c_remove(struct i2c_client *client)
>  	if (plat->workqueue)
>  		destroy_workqueue(plat->workqueue);
>  
> -	if (plat->spi_client)
> -		i2c_unregister_device(plat->spi_client);
> +	i2c_unregister_device(plat->spi_client);
>  
>  	if (plat->typec.role_sw)
>  		usb_role_switch_put(plat->typec.role_sw);
> -- 
> 2.30.2

-- 
heikki
