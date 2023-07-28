Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7B867666F0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 10:23:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234892AbjG1IXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 04:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234812AbjG1IW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 04:22:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8642944A1;
        Fri, 28 Jul 2023 01:21:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2171A6203A;
        Fri, 28 Jul 2023 08:21:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98CD0C433C8;
        Fri, 28 Jul 2023 08:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690532476;
        bh=trDnCNuseGajeqLLAPm/8j0t94QcgtOfehlGyJyaXZE=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Mz2ko7Ol0uqzlX1AHZYCgEeua3ecSnCmo+vwwV2++dFEVO/Ao9FhTMMnDncWT/XmF
         WOV6p0E3iGsRa1jaRkxKFZzRDaY9z7RnRspLVZ7AsRXerPNek9iJHJNP2crriUM604
         mpv6mFcyj0M6xFd5g91ru6p1Yet3TLbQPlWOZwIEcpo0+qUtgJbj7pDHE/wMY9n7uV
         UKY+qNnRIAXmIlxkPyZrPoSjRobrR7FJ5ZSXeE9FRhgulCMAppmWZt88EqiYBpDWRE
         JAp/l+VFsql+p3qFz2RsIJhrPQp+LgrYvlv5peaxevseAEE+qMcWGPi7XcSeVCGxOL
         DT4Aod1QyyNEw==
Message-ID: <c134dae7-38ba-baca-38ba-e06bbc6a491b@kernel.org>
Date:   Fri, 28 Jul 2023 10:21:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/2] media: i2c: imx519: Support for the Sony IMX519
 sensor
Content-Language: en-US
To:     Umang Jain <umang.jain@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Lee Jackson <lee.jackson@arducam.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Shawn Tu <shawnx.tu@intel.com>,
        Nicholas Roth <nicholas@rothemail.net>,
        Mikhail Rudenko <mike.rudenko@gmail.com>,
        kieran.bingham@ideasonboard.com,
        Marco Felsch <m.felsch@pengutronix.de>,
        jacopo.mondi@ideasonboard.com
References: <20230727154108.308320-1-umang.jain@ideasonboard.com>
 <20230727154108.308320-3-umang.jain@ideasonboard.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230727154108.308320-3-umang.jain@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 17:41, Umang Jain wrote:
> From: Lee Jackson <lee.jackson@arducam.com>
> 
> Adds a driver for the 16MPix IMX519 CSI2 sensor.
> Whilst the sensor supports 2 or 4 CSI2 data lanes, this driver
> currently only supports 2 lanes. The driver also supports
> Phase Detection Auto Focus (PDAF).


Thank you for your patch. There is something to discuss/improve.


> +
> +error_out:
> +	v4l2_fwnode_endpoint_free(&ep_cfg);
> +	fwnode_handle_put(endpoint);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id imx519_dt_ids[] = {
> +	{ .compatible = "sony,imx519"},
> +	{ /* sentinel */ }
> +};
> +
> +static int imx519_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct imx519 *imx519;
> +	const struct of_device_id *match;
> +	u32 xclk_freq;
> +	int ret;
> +
> +	imx519 = devm_kzalloc(&client->dev, sizeof(*imx519), GFP_KERNEL);
> +	if (!imx519)
> +		return -ENOMEM;
> +
> +	v4l2_i2c_subdev_init(&imx519->sd, client, &imx519_subdev_ops);
> +
> +	match = of_match_device(imx519_dt_ids, dev);
> +	if (!match)
> +		return -ENODEV;
> +
> +	/* Check the hardware configuration in device tree */
> +	if (imx519_check_hwcfg(dev))
> +		return -EINVAL;
> +
> +	/* Get system clock (xclk) */
> +	imx519->xclk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(imx519->xclk)) {
> +		dev_err(dev, "failed to get xclk\n");

return dev_err_probe

> +		return PTR_ERR(imx519->xclk);
> +	}
> +
> +	xclk_freq = clk_get_rate(imx519->xclk);
> +	if (xclk_freq != IMX519_XCLK_FREQ) {
> +		dev_err(dev, "xclk frequency not supported: %d Hz\n",
> +			xclk_freq);

return dev_err_probe

> +		return -EINVAL;
> +	}
> +
> +	ret = imx519_get_regulators(imx519);
> +	if (ret) {
> +		dev_err(dev, "failed to get regulators\n");
> +		return ret;

return dev_err_probe

> +	}
> +
> +	/* Request optional enable pin */
> +	imx519->reset_gpio = devm_gpiod_get_optional(dev, "reset",
> +						     GPIOD_OUT_HIGH);
> +
> +	/*
> +	 * The sensor must be powered for imx519_identify_module()
> +	 * to be able to read the CHIP_ID register
> +	 */
> +	ret = imx519_power_on(dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = imx519_identify_module(imx519, IMX519_CHIP_ID);
> +	if (ret)
> +		goto error_power_off;
> +
> +	/* Set default mode to max resolution */
> +	imx519->mode = &supported_modes_10bit[0];
> +	imx519->fmt_code = MEDIA_BUS_FMT_SRGGB10_1X10;
> +
> +	/* Enable runtime PM and turn off the device */
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +	pm_runtime_idle(dev);
> +
> +	/* This needs the pm runtime to be registered. */
> +	ret = imx519_init_controls(imx519);
> +	if (ret)
> +		goto error_power_off;
> +
> +	/* Initialize subdev */
> +	imx519->sd.internal_ops = &imx519_internal_ops;
> +	imx519->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE |
> +			    V4L2_SUBDEV_FL_HAS_EVENTS;
> +	imx519->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
> +
> +	/* Initialize source pads */
> +	imx519->pad[IMAGE_PAD].flags = MEDIA_PAD_FL_SOURCE;
> +	imx519->pad[METADATA_PAD].flags = MEDIA_PAD_FL_SOURCE;
> +
> +	ret = media_entity_pads_init(&imx519->sd.entity, NUM_PADS, imx519->pad);
> +	if (ret) {
> +		dev_err(dev, "failed to init entity pads: %d\n", ret);
> +		goto error_handler_free;
> +	}
> +
> +	ret = v4l2_async_register_subdev_sensor(&imx519->sd);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to register sensor sub-device: %d\n", ret);
> +		goto error_media_entity;
> +	}
> +
> +	return 0;
> +
> +error_media_entity:
> +	media_entity_cleanup(&imx519->sd.entity);
> +
> +error_handler_free:
> +	imx519_free_controls(imx519);
> +
> +error_power_off:
> +	pm_runtime_disable(&client->dev);
> +	pm_runtime_set_suspended(&client->dev);
> +	imx519_power_off(&client->dev);
> +
> +	return ret;
> +}
> +
> +static void imx519_remove(struct i2c_client *client)
> +{
> +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
> +	struct imx519 *imx519 = to_imx519(sd);
> +
> +	v4l2_async_unregister_subdev(sd);
> +	media_entity_cleanup(&sd->entity);
> +	imx519_free_controls(imx519);
> +
> +	pm_runtime_disable(&client->dev);
> +	if (!pm_runtime_status_suspended(&client->dev))
> +		imx519_power_off(&client->dev);
> +	pm_runtime_set_suspended(&client->dev);
> +}
> +
> +MODULE_DEVICE_TABLE(of, imx519_dt_ids);
> +
> +static const struct dev_pm_ops imx519_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(imx519_suspend, imx519_resume)
> +	SET_RUNTIME_PM_OPS(imx519_power_off, imx519_power_on, NULL)
> +};
> +
> +static struct i2c_driver imx519_i2c_driver = {
> +	.driver = {
> +		.name = "imx519",
> +		.of_match_table	= imx519_dt_ids,
> +		.pm = &imx519_pm_ops,
> +	},
> +	.probe_new = imx519_probe,

Are you sure? Wasn't i2c already converted?


Best regards,
Krzysztof

