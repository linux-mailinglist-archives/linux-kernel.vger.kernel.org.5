Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2ADE7B60EA
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Oct 2023 08:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230334AbjJCGnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Oct 2023 02:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjJCGnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Oct 2023 02:43:39 -0400
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5922BAC;
        Mon,  2 Oct 2023 23:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696315414; x=1727851414;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=AvOwi0cnTJOn8GMWGwytu1+ms7MaRvbJQFq+zu+RxOg=;
  b=ATwFqnzEHUpKwrErHlY6Muyo6C8ORLONN2pTTTk+c4Z7XAHMulmvFFE1
   vw9WhmgTbRCsFkczTFCAm2D3R/uaBna/ixHB4L3iD3Uhg7GgHHPqCGGE7
   bT35AAOOsLxKUiOJer4SaK7+G2uWyH8qIpyOu+aFDAPrPxjcFhWcNI20X
   IDxAxl64Z6jWWTJHZoXr9fwSm9nmnANB6/YnAKeNzXxOCj8oYO4eMeTg7
   nH2LcLW44K64AgwxYBgYJt5k5nZ1MdrnhvQkZo2pl6gaqTod7hpA/8IZI
   yMeIOtXxqJ4Lqq3sv/MzE9+734pdT1R62eoSUAtCu7qVD6UyomnzpzOqM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="1395689"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="1395689"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Oct 2023 23:43:34 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10851"; a="894369495"
X-IronPort-AV: E=Sophos;i="6.03,196,1694761200"; 
   d="scan'208";a="894369495"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 02 Oct 2023 23:42:07 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Tue, 03 Oct 2023 09:43:28 +0300
Date:   Tue, 3 Oct 2023 09:43:28 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     Abdel Alkuor <alkuor@gmail.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, bryan.odonoghue@linaro.org,
        gregkh@linuxfoundation.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, ryan.eleceng@gmail.com,
        robh+dt@kernel.org, conor+dt@kernel.org,
        devicetree@vger.kernel.org, Abdel Alkuor <abdelalkuor@geotab.com>
Subject: Re: [PATCH v9 09/14] USB: typec: tps6598x: Refactor tps6598x port
 registration
Message-ID: <ZRu4EGVcZU+r0H0I@kuha.fi.intel.com>
References: <20231001081134.37101-1-alkuor@gmail.com>
 <20231001081134.37101-10-alkuor@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231001081134.37101-10-alkuor@gmail.com>
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 01, 2023 at 04:11:29AM -0400, Abdel Alkuor wrote:
> From: Abdel Alkuor <abdelalkuor@geotab.com>
> 
> tps6598x and cd321x use TPS_REG_SYSTEM_CONF to get dr/pr roles
> where other similar devices don't have this register such as tps25750.
> 
> Move tps6598x port registration to its own function
> 
> Signed-off-by: Abdel Alkuor <abdelalkuor@geotab.com>

This one can be moved to the beginning of the series.

Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>

> ---
> Changes in v9:
>   - No changes
> Changes in v8:
>   - No changes
> Changes in v7:
>   - Add driver name to commit subject
> Changes in v6:
>   - No changes
> Changes in v5:
>   - Incorporating tps25750 into tps6598x driver
> 
>  drivers/usb/typec/tipd/core.c | 99 +++++++++++++++++++----------------
>  1 file changed, 54 insertions(+), 45 deletions(-)
> 
> diff --git a/drivers/usb/typec/tipd/core.c b/drivers/usb/typec/tipd/core.c
> index 52dc1cc16bed..0195eabd96bf 100644
> --- a/drivers/usb/typec/tipd/core.c
> +++ b/drivers/usb/typec/tipd/core.c
> @@ -1032,14 +1032,64 @@ static int tps25750_apply_patch(struct tps6598x *tps)
>  	return 0;
>  };
>  
> +static int
> +tps6598x_register_port(struct tps6598x *tps, struct fwnode_handle *fwnode)
> +{
> +	int ret;
> +	u32 conf;
> +	struct typec_capability typec_cap = { };
> +
> +	ret = tps6598x_read32(tps, TPS_REG_SYSTEM_CONF, &conf);
> +	if (ret)
> +		return ret;
> +
> +	typec_cap.revision = USB_TYPEC_REV_1_2;
> +	typec_cap.pd_revision = 0x200;
> +	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
> +	typec_cap.driver_data = tps;
> +	typec_cap.ops = &tps6598x_ops;
> +	typec_cap.fwnode = fwnode;
> +
> +	switch (TPS_SYSCONF_PORTINFO(conf)) {
> +	case TPS_PORTINFO_SINK_ACCESSORY:
> +	case TPS_PORTINFO_SINK:
> +		typec_cap.type = TYPEC_PORT_SNK;
> +		typec_cap.data = TYPEC_PORT_UFP;
> +		break;
> +	case TPS_PORTINFO_DRP_UFP_DRD:
> +	case TPS_PORTINFO_DRP_DFP_DRD:
> +		typec_cap.type = TYPEC_PORT_DRP;
> +		typec_cap.data = TYPEC_PORT_DRD;
> +		break;
> +	case TPS_PORTINFO_DRP_UFP:
> +		typec_cap.type = TYPEC_PORT_DRP;
> +		typec_cap.data = TYPEC_PORT_UFP;
> +		break;
> +	case TPS_PORTINFO_DRP_DFP:
> +		typec_cap.type = TYPEC_PORT_DRP;
> +		typec_cap.data = TYPEC_PORT_DFP;
> +		break;
> +	case TPS_PORTINFO_SOURCE:
> +		typec_cap.type = TYPEC_PORT_SRC;
> +		typec_cap.data = TYPEC_PORT_DFP;
> +		break;
> +	default:
> +		return -ENODEV;
> +	}
> +
> +	tps->port = typec_register_port(tps->dev, &typec_cap);
> +	if (IS_ERR(tps->port))
> +		return PTR_ERR(tps->port);
> +
> +	return 0;
> +}
> +
>  static int tps6598x_probe(struct i2c_client *client)
>  {
>  	struct device_node *np = client->dev.of_node;
> -	struct typec_capability typec_cap = { };
>  	struct tps6598x *tps;
>  	struct fwnode_handle *fwnode;
>  	u32 status;
> -	u32 conf;
>  	u32 vid;
>  	int ret;
>  	u64 mask1;
> @@ -1112,10 +1162,6 @@ static int tps6598x_probe(struct i2c_client *client)
>  		goto err_clear_mask;
>  	trace_tps6598x_status(status);
>  
> -	ret = tps6598x_read32(tps, TPS_REG_SYSTEM_CONF, &conf);
> -	if (ret < 0)
> -		goto err_clear_mask;
> -
>  	/*
>  	 * This fwnode has a "compatible" property, but is never populated as a
>  	 * struct device. Instead we simply parse it to read the properties.
> @@ -1133,50 +1179,13 @@ static int tps6598x_probe(struct i2c_client *client)
>  		goto err_fwnode_put;
>  	}
>  
> -	typec_cap.revision = USB_TYPEC_REV_1_2;
> -	typec_cap.pd_revision = 0x200;
> -	typec_cap.prefer_role = TYPEC_NO_PREFERRED_ROLE;
> -	typec_cap.driver_data = tps;
> -	typec_cap.ops = &tps6598x_ops;
> -	typec_cap.fwnode = fwnode;
> -
> -	switch (TPS_SYSCONF_PORTINFO(conf)) {
> -	case TPS_PORTINFO_SINK_ACCESSORY:
> -	case TPS_PORTINFO_SINK:
> -		typec_cap.type = TYPEC_PORT_SNK;
> -		typec_cap.data = TYPEC_PORT_UFP;
> -		break;
> -	case TPS_PORTINFO_DRP_UFP_DRD:
> -	case TPS_PORTINFO_DRP_DFP_DRD:
> -		typec_cap.type = TYPEC_PORT_DRP;
> -		typec_cap.data = TYPEC_PORT_DRD;
> -		break;
> -	case TPS_PORTINFO_DRP_UFP:
> -		typec_cap.type = TYPEC_PORT_DRP;
> -		typec_cap.data = TYPEC_PORT_UFP;
> -		break;
> -	case TPS_PORTINFO_DRP_DFP:
> -		typec_cap.type = TYPEC_PORT_DRP;
> -		typec_cap.data = TYPEC_PORT_DFP;
> -		break;
> -	case TPS_PORTINFO_SOURCE:
> -		typec_cap.type = TYPEC_PORT_SRC;
> -		typec_cap.data = TYPEC_PORT_DFP;
> -		break;
> -	default:
> -		ret = -ENODEV;
> -		goto err_role_put;
> -	}
> -
>  	ret = devm_tps6598_psy_register(tps);
>  	if (ret)
>  		goto err_role_put;
>  
> -	tps->port = typec_register_port(&client->dev, &typec_cap);
> -	if (IS_ERR(tps->port)) {
> -		ret = PTR_ERR(tps->port);
> +	ret = tps6598x_register_port(tps, fwnode);
> +	if (ret)
>  		goto err_role_put;
> -	}
>  
>  	if (status & TPS_STATUS_PLUG_PRESENT) {
>  		ret = tps6598x_read16(tps, TPS_REG_POWER_STATUS, &tps->pwr_status);
> -- 
> 2.34.1

-- 
heikki
