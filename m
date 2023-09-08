Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9347D7985EB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Sep 2023 12:34:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242948AbjIHKed (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Sep 2023 06:34:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232099AbjIHKeb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Sep 2023 06:34:31 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F09F11BF0;
        Fri,  8 Sep 2023 03:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1694169267; x=1725705267;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Lt9/l8LfGMpTc9AbtXr/yiF27RStf8Q1zDhFTijERZw=;
  b=jk1dzNxgPdpF4/xZv/8kUokQZuPmVkJZe8bIOxoLfW7aXAaVz+1/NKQ0
   MJPPFuUM0xo2i9O4WEQpq/GKJiks4ZGOcLhrRtxmIBxQ/JArkXQizwaf/
   GpH5LRAXTDj99YiVZtqdalyg2Gk2gHwAwh/ntPrZQmtXdLZ91UO5ZoM54
   ennr1DVzVg1osnlmz3/SAGMEdIVuf+EyTsDgF4vlfQUq1AAgDhbWbvHJy
   Ekiod3PZMzHJJU4ftA5Bg8TomeuOWvIvxtmIs3/sqAgCUkP1qCdKivRh0
   T0TZvAVsN0H4WI6LitKCivjUK3mBYdpKezFEwcBrVb4fvwYWqEa9+rbGD
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="381432178"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="381432178"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2023 03:34:26 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10826"; a="745565658"
X-IronPort-AV: E=Sophos;i="6.02,236,1688454000"; 
   d="scan'208";a="745565658"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga007.fm.intel.com with SMTP; 08 Sep 2023 03:34:22 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 08 Sep 2023 13:34:21 +0300
Date:   Fri, 8 Sep 2023 13:34:21 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Biju Das <biju.das.au@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v3 4/5] usb: typec: tcpci_rt1711h: Add
 enable_pd30_extended_message variable to struct rt1711h_chip_info
Message-ID: <ZPr4rf2uMXd/CoG6@kuha.fi.intel.com>
References: <20230906080619.36930-1-biju.das.jz@bp.renesas.com>
 <20230906080619.36930-5-biju.das.jz@bp.renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230906080619.36930-5-biju.das.jz@bp.renesas.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 06, 2023 at 09:06:18AM +0100, Biju Das wrote:
> The RT1715 has PD30 extended message compared to RT1711H. Add a variable
> enable_pd30_extended_message to struct rt1711h_chip_info to enable this
> feature for RT1715.
> 
> Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
> Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> v2->v3:
>  * Added Rb tag from Andy.
> v1->v2:
>  * Changed enable_pd30_extended_message variable type to bool.
> ---
>  drivers/usb/typec/tcpm/tcpci_rt1711h.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/usb/typec/tcpm/tcpci_rt1711h.c b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> index 40822bae9ae8..5d2dc7ead9d0 100644
> --- a/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> +++ b/drivers/usb/typec/tcpm/tcpci_rt1711h.c
> @@ -54,6 +54,7 @@
>  struct rt1711h_chip_info {
>  	u32 rxdz_sel;
>  	u16 did;
> +	bool enable_pd30_extended_message;
>  };
>  
>  struct rt1711h_chip {
> @@ -110,7 +111,7 @@ static int rt1711h_init(struct tcpci *tcpci, struct tcpci_data *tdata)
>  		return ret;
>  
>  	/* Enable PD30 extended message for RT1715 */
> -	if (chip->info->did == RT1715_DID) {
> +	if (chip->info->enable_pd30_extended_message) {
>  		ret = regmap_update_bits(regmap, RT1711H_RTCTRL8,
>  					 RT1711H_ENEXTMSG, RT1711H_ENEXTMSG);
>  		if (ret < 0)
> @@ -400,6 +401,7 @@ static const struct rt1711h_chip_info rt1711h = {
>  static const struct rt1711h_chip_info rt1715 = {
>  	.rxdz_sel = RT1711H_BMCIO_RXDZSEL,
>  	.did = RT1715_DID,
> +	.enable_pd30_extended_message = true,
>  };
>  
>  static const struct i2c_device_id rt1711h_id[] = {
> -- 
> 2.25.1

-- 
heikki
