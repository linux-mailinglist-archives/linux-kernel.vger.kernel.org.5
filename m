Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B31047BF2CA
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Oct 2023 08:12:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1442211AbjJJGM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Oct 2023 02:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1442156AbjJJGM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Oct 2023 02:12:27 -0400
X-Greylist: delayed 347 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Oct 2023 23:12:22 PDT
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26041B0;
        Mon,  9 Oct 2023 23:12:22 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (2a00-1190-d1dd-0-c641-1eff-feae-163d.v6.cust.suomicom.net [IPv6:2a00:1190:d1dd:0:c641:1eff:feae:163d])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4S4QXz3C4nzyWn;
        Tue, 10 Oct 2023 09:12:09 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1696918339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XuMIcU8cZvU0jZEP/BNe7LPcBPMAKzlOUZkaZJUYjtI=;
        b=NJl5giuUzCG4Ku92wHfREsnir3US0FQ0HpE+6qjTjfsoW3tP8fuBpFZedO0+9jkxcOD89k
        htnlWd3aHs/6xBDFSESObrhER1KQ5laaq/hrHe8IrfFWnNs/RDi3J+7m51XDNDcYevhNxM
        Oay+fyJPJ65uyhE2Hyiv0gL+0byFDnw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1696918339;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XuMIcU8cZvU0jZEP/BNe7LPcBPMAKzlOUZkaZJUYjtI=;
        b=egiMaw3kzxckyRstS8g7T1uT5eABEm0ZHU5IJ2g4mwK6HAdnR4gnGkA1mMiQfs3Xto2cDO
        wIYKsxIDcCEBtppuPiN21Tlx6/HpjWu119w6dOoAJcRNI2A2uyWezzHOYdSBydXdoEHpfD
        8HsqAlt7hefyQvPHxvzbrGczi+wBTqM=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1696918339; a=rsa-sha256; cv=none;
        b=XSefguaJ+zDIvDnCsD8PE9y8DwNenrZuxp+M04F1rd3jXV7aWhzzsGv9gj1sMxX5bPQCSH
        8+GQ/Xf4k8ooDJ1ONGci26litC2xx/PcbTTwWg6r2JwrYdQ8dybt17SE8rrTPoQ9iEA7Hy
        qMxtwwcd/jLMP3YrVjPjLi1XxYlfoMA=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 0F723634CA9;
        Tue, 10 Oct 2023 09:12:09 +0300 (EEST)
Date:   Tue, 10 Oct 2023 06:12:08 +0000
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Kieran Bingham <kieran.bingham@ideasonboard.com>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        "Paul J. Murphy" <paul.j.murphy@intel.com>,
        Daniele Alessandrelli <daniele.alessandrelli@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/5] media: i2c: imx335: Enable regulator supplies
Message-ID: <ZSTrOB10pDhJq6gG@valkosipuli.retiisi.eu>
References: <20231010005126.3425444-1-kieran.bingham@ideasonboard.com>
 <20231010005126.3425444-3-kieran.bingham@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231010005126.3425444-3-kieran.bingham@ideasonboard.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kieran,

On Tue, Oct 10, 2023 at 01:51:23AM +0100, Kieran Bingham wrote:
> Provide support for enabling and disabling regulator supplies to control
> power to the camera sensor.
> 
> Signed-off-by: Kieran Bingham <kieran.bingham@ideasonboard.com>
> ---
>  drivers/media/i2c/imx335.c | 41 ++++++++++++++++++++++++++++++++++++--
>  1 file changed, 39 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/i2c/imx335.c b/drivers/media/i2c/imx335.c
> index ec729126274b..bf12b9b69fce 100644
> --- a/drivers/media/i2c/imx335.c
> +++ b/drivers/media/i2c/imx335.c
> @@ -75,6 +75,19 @@ struct imx335_reg_list {
>  	const struct imx335_reg *regs;
>  };
>  
> +static const char * const imx335_supply_name[] = {
> +	/*
> +	 * Turn on the power supplies so that they rise in order of
> +	 *           1.2v,-> 1.8 -> 2.9v

This won't happen with regulator_bulk_enable(). Does the spec require this?

> +	 * All power supplies should finish rising within 200ms.
> +	 */
> +	"avdd", /* Analog (2.9V) supply */
> +	"ovdd", /* Digital I/O (1.8V) supply */
> +	"dvdd", /* Digital Core (1.2V) supply */
> +};
> +
> +#define IMX335_NUM_SUPPLIES ARRAY_SIZE(imx335_supply_name)
> +
>  /**
>   * struct imx335_mode - imx335 sensor mode structure
>   * @width: Frame width
> @@ -126,6 +139,8 @@ struct imx335 {
>  	struct v4l2_subdev sd;
>  	struct media_pad pad;
>  	struct gpio_desc *reset_gpio;
> +	struct regulator_bulk_data supplies[IMX335_NUM_SUPPLIES];
> +
>  	struct clk *inclk;
>  	struct v4l2_ctrl_handler ctrl_handler;
>  	struct v4l2_ctrl *link_freq_ctrl;
> @@ -781,6 +796,17 @@ static int imx335_parse_hw_config(struct imx335 *imx335)
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
> @@ -859,6 +885,17 @@ static int imx335_power_on(struct device *dev)
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

You're not handling the error case later on in the function.

> +
> +	/* Set XCLR */
>  	gpiod_set_value_cansleep(imx335->reset_gpio, 1);
>  
>  	ret = clk_prepare_enable(imx335->inclk);
> @@ -867,7 +904,7 @@ static int imx335_power_on(struct device *dev)
>  		goto error_reset;
>  	}
>  
> -	usleep_range(20, 22);
> +	usleep_range(20, 22); /* T4 */
>  
>  	return 0;
>  
> @@ -889,8 +926,8 @@ static int imx335_power_off(struct device *dev)
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
