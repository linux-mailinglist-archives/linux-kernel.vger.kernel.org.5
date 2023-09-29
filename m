Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9A0F7B2FC3
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Sep 2023 12:11:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjI2KLY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Sep 2023 06:11:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbjI2KLX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Sep 2023 06:11:23 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1AD1AA;
        Fri, 29 Sep 2023 03:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695982281; x=1727518281;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=cwygypsftUhJKZZZOd1A+p7k0PnDeSnAi6qDNn5przY=;
  b=AO2SYydbxkaOsDRL15wHbRrJZqiW8cRbTJESHS7v4cqlQMNmmwJajkUQ
   LO4cVcMlG1d3nZHCRLrGSnJvYObp//oPqlep4Ryt3ntOLxVhHQsSvYu3f
   Kx2Mjl5kMbOS/68ZL8TOqQHUQNvN3ptSN/yChggp9SZvQ3vlvz/Dzd93u
   PbPI+RpH67DjH4jSi2NF8BD542Kiv3nVlH7HM+oazA6ZhbSggeRkHqYJp
   SK+NxSaiiVmDaa6H2VaCT0zTGGXYFcTlAv5hh87WVSBnqFu6xmFobzy4I
   kZzZ3Gw1DAvQy0tPjAlgQlUwsJlIrZNtF2xb8IJw/xgQWklKnnF06MXbB
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="448762762"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="448762762"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2023 03:11:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10847"; a="753332876"
X-IronPort-AV: E=Sophos;i="6.03,187,1694761200"; 
   d="scan'208";a="753332876"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga007.fm.intel.com with SMTP; 29 Sep 2023 03:11:06 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Fri, 29 Sep 2023 13:11:05 +0300
Date:   Fri, 29 Sep 2023 13:11:05 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v7 03/14] USB: typec: tps6598x: Add patch mode to tps6598x
Message-ID: <ZRaiuXnrPuEPBQZF@kuha.fi.intel.com>
References: <20230927175348.18041-1-alkuor@gmail.com>
 <20230927175348.18041-4-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230927175348.18041-4-alkuor@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 27, 2023 at 01:53:37PM -0400, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> TPS25750 has a patch mode indicating the device requires
> a configuration to get the device into operational mode
> 
> Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>
> ---
> Changes in v7:
>   - Add driver name to commit subject
> Changes in v6:
>   - Return current mode and check it directly
> Changes in v5:
>   - Incorporating tps25750 into tps6598x driver
> 
>  drivers/usb/typec/tipd/core.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 32420c61660d..58679b1c0cfe 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -68,6 +68,7 @@ enum {
>  	TPS_MODE_BOOT,
>  	TPS_MODE_BIST,
>  	TPS_MODE_DISC,
> +	TPS_MODE_PTCH,
>  };
>  
>  static const char *const modes[] = {
> @@ -75,6 +76,7 @@ static const char *const modes[] = {
>  	[TPS_MODE_BOOT]	= "BOOT",
>  	[TPS_MODE_BIST]	= "BIST",
>  	[TPS_MODE_DISC]	= "DISC",
> +	[TPS_MODE_PTCH] = "PTCH",
>  };
>  
>  /* Unrecognized commands will be replaced with "!CMD" */
> @@ -593,12 +595,15 @@ static int tps6598x_check_mode(struct tps6598x *tps)
>  	if (ret)
>  		return ret;
>  
> -	switch (match_string(modes, ARRAY_SIZE(modes), mode)) {
> +	ret = match_string(modes, ARRAY_SIZE(modes), mode);
> +
> +	switch (ret) {
>  	case TPS_MODE_APP:
> -		return 0;
> +	case TPS_MODE_PTCH:
> +		return ret;
>  	case TPS_MODE_BOOT:
>  		dev_warn(tps->dev, "dead-battery condition\n");
> -		return 0;
> +		return ret;
>  	case TPS_MODE_BIST:
>  	case TPS_MODE_DISC:
>  	default:
> @@ -765,7 +770,7 @@ static int tps6598x_probe(struct i2c_client *client)
>  	tps->irq_handler = irq_handler;
>  	/* Make sure the controller has application firmware running */
>  	ret = tps6598x_check_mode(tps);
> -	if (ret)
> +	if (ret < 0)
>  		return ret;

You are doing two things in this patch - you are adding PTCH mode, and
changing the meaning of the tps6598x_check_mode() return value. Please
make a note also about the latter in the commit message.

Or, just return the mode in the patch were you start using it in
tps6598x_probe().

Br,

-- 
heikki
