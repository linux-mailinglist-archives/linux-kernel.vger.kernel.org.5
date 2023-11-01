Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 856FA7DE1AD
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 14:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344304AbjKANdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 09:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344162AbjKANdf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 09:33:35 -0400
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DC96F7;
        Wed,  1 Nov 2023 06:33:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1698845607; x=1730381607;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=TLfikYcSzIKUF7Psef+fS9e6czzFkIgyby047PInD7c=;
  b=Ma+noyr4+ky2IkD6gSL/5CIjCqbwfCyflzPvmKn/Be9H5MjoYWPagBio
   HI201hb5Vpm/Mrf4r9EaIm5WysbE8pbA8Y7RgiEPtGJUAprDPlIL/X0R0
   MijUrogG1x1BD5beNEd+vIswKlCdwOaS/xX7XV6ECTTf9EritBMGLOb1K
   2+LS9iKZ6fPweLlyiW2Ue5tvhKobwMmz0dbbsSfUDKCpvvUGijD7iINAs
   UhY5l2Chv7y41d/+n/WfjRTLl54RUWaJUDfcgviFmDIu+NMEhiZG64mgc
   CZKkU5swfOIAl8N64CnHtG2VlD13C8ah1oBpTtvYuYOGiECGTSEchihmO
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="391359976"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="391359976"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 06:33:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10880"; a="790114629"
X-IronPort-AV: E=Sophos;i="6.03,268,1694761200"; 
   d="scan'208";a="790114629"
Received: from turnipsi.fi.intel.com (HELO kekkonen.fi.intel.com) ([10.237.72.44])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Nov 2023 06:33:23 -0700
Received: from kekkonen.localdomain (localhost [127.0.0.1])
        by kekkonen.fi.intel.com (Postfix) with SMTP id 48DB41207A3;
        Wed,  1 Nov 2023 15:33:22 +0200 (EET)
Date:   Wed, 1 Nov 2023 13:33:22 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     devicetree@vger.kernel.org, linux-media@vger.kernel.org,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/6] media: i2c: imx335: Enable regulator supplies
Message-ID: <ZUJTold9QBOJeTt_@kekkonen.localdomain>
References: <20231101131354.2333498-1-kieran.bingham@ideasonboard.com>
 <20231101131354.2333498-5-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231101131354.2333498-5-kieran.bingham@ideasonboard.com>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

Thanks for the set.

On Wed, Nov 01, 2023 at 01:13:52PM +0000, Kieran Bingham wrote:
> Provide support for enabling and disabling regulator supplies to control
> power to the camera sensor.
> 
> While updating the power on function, document that a sleep is
> represented as 'T4' in the datasheet power on sequence.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> 
> ---
> 
> v2:
>  - document 'supplies' member variable
>  - disable regulators in error path
>  - Remove 'unhelpful' comments
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> ---
>  drivers/media/i2c/imx335.c | 38 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 36 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index 31c612c6bdd8..f17ce40b9c77 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -75,6 +75,14 @@ struct imx335_reg_list {
>  	const struct imx335_reg *regs;
>  };
>  
> +static const char * const imx335_supply_name[] = {
> +	"avdd", /* Analog (2.9V) supply */
> +	"ovdd", /* Digital I/O (1.8V) supply */
> +	"dvdd", /* Digital Core (1.2V) supply */
> +};
> +
> +#define IMX335_NUM_SUPPLIES ARRAY_SIZE(imx335_supply_name)

Please use plain ARRAY_SIZE() where you needed this.

> +
>  /**
>   * struct imx335_mode - imx335 sensor mode structure
>   * @width: Frame width
> @@ -108,6 +116,7 @@ struct imx335_mode {
>   * @sd: V4L2 sub-device
>   * @pad: Media pad. Only one pad supported
>   * @reset_gpio: Sensor reset gpio
> + * @supplies: Regulator supplies to handle power control
>   * @inclk: Sensor input clock
>   * @ctrl_handler: V4L2 control handler
>   * @link_freq_ctrl: Pointer to link frequency control
> @@ -126,6 +135,8 @@ struct imx335 {
>  	struct v4l2_subdev sd;
>  	struct media_pad pad;
>  	struct gpio_desc *reset_gpio;
> +	struct regulator_bulk_data supplies[IMX335_NUM_SUPPLIES];
> +
>  	struct clk *inclk;
>  	struct v4l2_ctrl_handler ctrl_handler;
>  	struct v4l2_ctrl *link_freq_ctrl;
> @@ -781,6 +792,17 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
>  		return PTR_ERR(imx335->reset_gpio);
>  	}
>  
> +	for (i = 0; i < IMX335_NUM_SUPPLIES; i++)
> +		imx335->supplies[i].supply = imx335_supply_name[i];
> +
> +	ret = devm_regulator_bulk_get(imx335->dev,
> +				      IMX335_NUM_SUPPLIES,
> +				      imx335->supplies);
> +	if (ret) {
> +		dev_err(imx335->dev, "Failed to get regulators\n");
> +		return ret;
> +	}
> +
>  	/* Get sensor input clock */
>  	imx335->inclk = devm_clk_get(imx335->dev, NULL);
>  	if (IS_ERR(imx335->inclk)) {
> @@ -863,6 +885,17 @@ static int imx335_power_on(struct device *dev)
>  	struct imx335 *imx335 = to_imx335(sd);
>  	int ret;
>  
> +	ret = regulator_bulk_enable(IMX335_NUM_SUPPLIES,
> +				    imx335->supplies);
> +	if (ret) {
> +		dev_err(dev, "%s: failed to enable regulators\n",
> +			__func__);
> +		return ret;
> +	}
> +
> +	usleep_range(500, 550); /* Tlow */
> +
> +	/* Set XCLR */
>  	gpiod_set_value_cansleep(imx335->reset_gpio, 1);
>  
>  	ret = clk_prepare_enable(imx335->inclk);
> @@ -871,12 +904,13 @@ static int imx335_power_on(struct device *dev)
>  		goto error_reset;
>  	}
>  
> -	usleep_range(20, 22);
> +	usleep_range(20, 22); /* T4 */
>  
>  	return 0;
>  
>  error_reset:
>  	gpiod_set_value_cansleep(imx335->reset_gpio, 0);
> +	regulator_bulk_disable(IMX335_NUM_SUPPLIES, imx335->supplies);
>  
>  	return ret;
>  }
> @@ -893,8 +927,8 @@ static int imx335_power_off(struct device *dev)
>  	struct imx335 *imx335 = to_imx335(sd);
>  
>  	gpiod_set_value_cansleep(imx335->reset_gpio, 0);
> -
>  	clk_disable_unprepare(imx335->inclk);
> +	regulator_bulk_disable(IMX335_NUM_SUPPLIES, imx335->supplies);
>  
>  	return 0;
>  }

-- 
Regards,

Sakari Ailus
