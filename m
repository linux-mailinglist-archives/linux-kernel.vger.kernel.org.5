Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B932F7A668B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Sep 2023 16:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232793AbjISOXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Sep 2023 10:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232686AbjISOXg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Sep 2023 10:23:36 -0400
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [IPv6:2a0a:edc0:2:b01:1d::104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9628513E
        for <linux-kernel@vger.kernel.org>; Tue, 19 Sep 2023 07:23:29 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qibdB-0002Ps-MM; Tue, 19 Sep 2023 16:23:13 +0200
Received: from [2a0a:edc0:2:b01:1d::c0] (helo=ptx.whiteo.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <mfe@pengutronix.de>)
        id 1qibdA-007TfL-DJ; Tue, 19 Sep 2023 16:23:12 +0200
Received: from mfe by ptx.whiteo.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1qibdA-009fzF-AF; Tue, 19 Sep 2023 16:23:12 +0200
Date:   Tue, 19 Sep 2023 16:23:12 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Andy Shevchenko <andy@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Stefan Agner <stefan@agner.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-gpio@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH v3 4/6] gpio: vf610: add i.MX8ULP of_device_id entry
Message-ID: <20230919142312.erbn64n52y4f5vl5@pengutronix.de>
References: <20230918-vf610-gpio-v3-0-ada82a17adc5@nxp.com>
 <20230918-vf610-gpio-v3-4-ada82a17adc5@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230918-vf610-gpio-v3-4-ada82a17adc5@nxp.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peng,

please see my notes below.

On 23-09-18, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> i.MX8ULP GPIO supports similar feature as i.MX7ULP GPIO, but i.MX8ULP is
> not compatible with i.MX7ULP per binding doc. i.MX8ULP only has one
> register base, not two base.
> 
> Add a new of_device_id entry for i.MX8ULP. But to make the driver could
> also support old bindings, check the compatible string first, before
> check the device data.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/gpio/gpio-vf610.c | 55 +++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 49 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/gpio/gpio-vf610.c b/drivers/gpio/gpio-vf610.c
> index dbc7ba0ee72c..ef2455093708 100644
> --- a/drivers/gpio/gpio-vf610.c
> +++ b/drivers/gpio/gpio-vf610.c
> @@ -25,6 +25,7 @@
>  struct fsl_gpio_soc_data {
>  	/* SoCs has a Port Data Direction Register (PDDR) */
>  	bool have_paddr;
> +	bool is_imx8ulp;

I would invert the logic:

	bool have_dual_base;

>  };
>  
>  struct vf610_gpio_port {
> @@ -60,13 +61,22 @@ struct vf610_gpio_port {
>  #define PORT_INT_EITHER_EDGE	0xb
>  #define PORT_INT_LOGIC_ONE	0xc
>  
> +#define IMX8ULP_GPIO_BASE_OFF	0x40
> +#define IMX8ULP_BASE_OFF	0x80
> +

static const struct fsl_gpio_soc_data vf610_data = {
	.have_dual_base = true,
};

static const struct fsl_gpio_soc_data imx_data = {
	.have_paddr = true,
	.have_dual_base = true,
};

static const struct fsl_gpio_soc_data imx8ulp_data = {
	.have_paddr = true,
};

This also introduces .data pointer for the vf610 case and we could drop
the 'port->sdata' guard from the
'if (port->sdata && port->sdata->paddr)' pattern. This of course would
be an additional patch.

> +
>  static const struct of_device_id vf610_gpio_dt_ids[] = {
>  	{ .compatible = "fsl,vf610-gpio",	.data = NULL, },
>  	{ .compatible = "fsl,imx7ulp-gpio",	.data = &imx_data, },
> +	{ .compatible = "fsl,imx8ulp-gpio",	.data = &imx8ulp_data, },
>  	{ /* sentinel */ }
>  };
>  
> @@ -255,6 +265,42 @@ static void vf610_gpio_disable_clk(void *data)
>  	clk_disable_unprepare(data);
>  }
>  
> +static int vf610_gpio_map_base(struct platform_device *pdev, struct vf610_gpio_port *port)
> +{
> +	struct device *dev = &pdev->dev;
> +	bool dual_base;
> +
> +	/* support old compatible strings */
> +	if (device_is_compatible(dev, "fsl,imx7ulp-gpio") &&
> +	    (device_is_compatible(dev, "fsl,imx93-gpio") ||
> +	    (device_is_compatible(dev, "fsl,imx8ulp-gpio")))) {
> +		dual_base = true;

Move this part into probe() (see below) and drop the rest.

> +	} else if (port->sdata && port->sdata->is_imx8ulp) {
> +		dual_base = false;
> +	} else {
> +		dual_base = true;
> +	};
> +
> +	if (dual_base) {

	if (port->sdata-have_dual_base) {

> +		port->base = devm_platform_ioremap_resource(pdev, 0);
> +		if (IS_ERR(port->base))
> +			return PTR_ERR(port->base);
> +
> +		port->gpio_base = devm_platform_ioremap_resource(pdev, 1);
> +		if (IS_ERR(port->gpio_base))
> +			return PTR_ERR(port->gpio_base);
> +	} else {
> +		port->base = devm_platform_ioremap_resource(pdev, 0);
> +		if (IS_ERR(port->base))
> +			return PTR_ERR(port->base);
> +
> +		port->gpio_base = port->base + IMX8ULP_GPIO_BASE_OFF;
> +		port->base = port->base + IMX8ULP_BASE_OFF;
> +	}
> +
> +	return 0;
> +}
> +
>  static int vf610_gpio_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
> @@ -269,13 +315,10 @@ static int vf610_gpio_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	port->sdata = of_device_get_match_data(dev);

	/* Handle old device-tree bindings */
	if (device_is_compatible(dev, "fsl,imx7ulp-gpio") &&
	    (device_is_compatible(dev, "fsl,imx93-gpio") ||
	    (device_is_compatible(dev, "fsl,imx8ulp-gpio"))))
		port->sdata->have_dual_base = true;

> -	port->base = devm_platform_ioremap_resource(pdev, 0);
> -	if (IS_ERR(port->base))
> -		return PTR_ERR(port->base);
>  
> -	port->gpio_base = devm_platform_ioremap_resource(pdev, 1);
> -	if (IS_ERR(port->gpio_base))
> -		return PTR_ERR(port->gpio_base);
> +	ret = vf610_gpio_map_base(pdev, port);
> +	if (ret)
> +		return ret;
>  
>  	port->irq = platform_get_irq(pdev, 0);
>  	if (port->irq < 0)

Regards,
  Marco
