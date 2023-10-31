Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 378127DCAB0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 11:23:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343653AbjJaKXe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 06:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234960AbjJaKXc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 06:23:32 -0400
Received: from smtp.smtpout.orange.fr (smtp-22.smtpout.orange.fr [80.12.242.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F1C783
        for <linux-kernel@vger.kernel.org>; Tue, 31 Oct 2023 03:23:29 -0700 (PDT)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id xlu8q2cnY68frxlu8qL2tt; Tue, 31 Oct 2023 11:23:27 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
        s=t20230301; t=1698747807;
        bh=Myq1U3QBIihOjHNsgI08XXFH79QnzufYtuvBE6MQkhA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To;
        b=kf8g+8rjIE886rXX2+4/OIpkvM4EVEvhQpg+0AcAbrNnBSgNaGwSiHweKxZJAJOPL
         3O+ivj/aiYrgdIV8e6LEBamJRQi/tzvljz9uu7ijrf5LUqPAWarHjRPFwrTJaPzQyD
         u/PCo182zFNAvxmTEj9uzTpmIiOestwxttRmMVdQaD3YAq4HUV4Tv9pbnjmYU0JCMZ
         g4dnOZS4hL2VX65crvux6E+8wGFr+s4Q3jtJNZODAw/98nNTItWWSvmKJe7j2slhD9
         BBiRWjhE0a8FAZ++O8wfj5sPXqrHCXy4C0Np8wf9yRV8/pDNggmTAkEoeQ0rVA2W23
         4pNoJjtxarisA==
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 31 Oct 2023 11:23:27 +0100
X-ME-IP: 86.243.2.178
Message-ID: <a98bca80-944c-493b-9872-75b94cd24eea@wanadoo.fr>
Date:   Tue, 31 Oct 2023 11:23:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 3/3] media: i2c: Add support for alvium camera
To:     Tommaso Merciai <tomm.merciai@gmail.com>
Cc:     sakari.ailus@linux.intel.com, martin.hecht@avnet.eu,
        michael.roeder@avnet.eu, mhecht73@gmail.com,
        linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Daniel Scally <djrscally@gmail.com>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-kernel@vger.kernel.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>
References: <20231020141354.2500602-1-tomm.merciai@gmail.com>
 <20231020141354.2500602-4-tomm.merciai@gmail.com>
Content-Language: fr
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20231020141354.2500602-4-tomm.merciai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 20/10/2023 à 16:13, Tommaso Merciai a écrit :
> The Alvium camera is shipped with sensor + isp in the same housing.
> The camera can be equipped with one out of various sensor and abstract
> the user from this. Camera is connected via MIPI CSI-2.
> 
> Most of the camera module features are supported, with the main exception
> being fw update.
> 
> The driver provides all mandatory, optional and recommended V4L2 controls
> for maximum compatibility with libcamera
> 
> References:
>   - https://www.alliedvision.com/en/products/embedded-vision-solutions
> 
> Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> ---

Hi, a few nits and a question at the end.

> +static int alvium_setup_mipi_fmt(struct alvium_dev *alvium)
> +{
> +	int avail_fmt_cnt = 0;
> +	int sz = 0;
> +	int fmt = 0;
> +
> +	alvium->alvium_csi2_fmt = NULL;
> +
> +	/* calculate fmt array size */
> +	for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
> +		if (alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit])
> +			if ((!alvium_csi2_fmts[fmt].is_raw) ||
> +				  (alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]))
> +				sz++;
> +	}
> +
> +	/* init alvium_csi2_fmt array */
> +	alvium->alvium_csi2_fmt_n = sz;
> +	alvium->alvium_csi2_fmt = kmalloc_array(sz,
> +						     sizeof(struct alvium_pixfmt),

This could be on the previous line.

> +						     GFP_KERNEL);
> +
> +	/* Create the alvium_csi2 fmt array from formats available */
> +	for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
> +		if (!alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit])
> +			continue;
> +
> +		if ((!alvium_csi2_fmts[fmt].is_raw) ||
> +				(alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit])) {
> +			alvium->alvium_csi2_fmt[avail_fmt_cnt] =
> +					alvium_csi2_fmts[fmt];
> +			avail_fmt_cnt++;
> +		}
> +	}
> +
> +	return 0;
> +}

...

> +static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> +				   struct v4l2_subdev_frame_interval *fi)
> +{
> +	struct alvium_dev *alvium = sd_to_alvium(sd);
> +	int ret;
> +
> +	if (alvium->streaming)
> +		return -EBUSY;
> +
> +	ret = alvium_set_frame_interval(alvium, fi);
> +	if (!ret) {
> +		ret = alvium_set_frame_rate(alvium);
> +		if (ret)
> +			return -EIO;

Why not ret?

> +	}
> +
> +	return ret;
> +}

...

> +static int alvium_get_dt_data(struct alvium_dev *alvium)
> +{
> +	struct device *dev = &alvium->i2c_client->dev;
> +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> +	struct fwnode_handle *endpoint;
> +	int ret = -EINVAL;
> +
> +	if (!fwnode)
> +		return -EINVAL;
> +
> +	/* Only CSI2 is supported for now: */
> +	alvium->ep.bus_type = V4L2_MBUS_CSI2_DPHY;
> +
> +	endpoint = fwnode_graph_get_endpoint_by_id(fwnode, 0, 0, 0);
> +	if (!endpoint) {
> +		dev_err(dev, "endpoint node not found\n");
> +		return -EINVAL;
> +	}
> +
> +	if (v4l2_fwnode_endpoint_alloc_parse(endpoint, &alvium->ep)) {
> +		dev_err(dev, "could not parse endpoint\n");
> +		goto error_out;

This could go to another label to be less confusing, but 
v4l2_fwnode_endpoint_free() looks to be a no-op here, so good enough.

> +	}
> +
> +	if (!alvium->ep.nr_of_link_frequencies) {
> +		dev_err(dev, "no link frequencies defined");
> +		goto error_out;
> +	}
> +
> +	return 0;
> +
> +error_out:
> +	v4l2_fwnode_endpoint_free(&alvium->ep);
> +	fwnode_handle_put(endpoint);
> +
> +	return ret;
> +}
> +
> +static int alvium_power_on(struct alvium_dev *alvium, bool on)
> +{
> +	int ret = 0;

Useless init.

> +
> +	if (!on)
> +		return regulator_disable(alvium->reg_vcc);
> +
> +	ret = regulator_enable(alvium->reg_vcc);
> +	if (ret)
> +		return ret;
> +
> +	/* alvium boot time 7s*/

space missing before */

> +	msleep(7000);
> +	return 0;
> +}

...

> +static int alvium_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct alvium_dev *alvium;
> +	int ret;
> +
> +	alvium = devm_kzalloc(dev, sizeof(*alvium), GFP_KERNEL);
> +	if (!alvium)
> +		return -ENOMEM;
> +
> +	alvium->i2c_client = client;
> +
> +	alvium->regmap = devm_cci_regmap_init_i2c(client, 16);
> +	if (IS_ERR(alvium->regmap))
> +		return PTR_ERR(alvium->regmap);
> +
> +	ret = alvium_get_dt_data(alvium);
> +	if (ret)
> +		return ret;
> +
> +	alvium->reg_vcc = devm_regulator_get_optional(dev, "vcc-ext-in");
> +	if (IS_ERR(alvium->reg_vcc))
> +		return dev_err_probe(dev, PTR_ERR(alvium->reg_vcc),
> +			"no vcc-ext-in regulator provided\n");
> +
> +	ret = alvium_power_on(alvium, true);
> +	if (ret)
> +		goto err_powerdown;
> +
> +	if (!alvium_is_alive(alvium)) {
> +		dev_err(dev, "Device detection failed: %d\n", ret);

Nit: Here and below, dev_err_probe() could also be used to display the 
error code in a human readable way.

> +		ret = -ENODEV;
> +		goto err_powerdown;
> +	}
> +
> +	ret = alvium_get_hw_info(alvium);
> +	if (ret) {
> +		dev_err(dev, "get_hw_info fail %d\n", ret);
> +		goto err_powerdown;
> +	}
> +
> +	ret = alvium_hw_init(alvium);
> +	if (ret) {
> +		dev_err(dev, "hw_init fail %d\n", ret);
> +		goto err_powerdown;
> +	}
> +
> +	ret = alvium_setup_mipi_fmt(alvium);
> +	if (ret) {
> +		dev_err(dev, "setup_mipi_fmt fail %d\n", ret);
> +		goto err_powerdown;
> +	}
> +
> +	/*
> +	 * Enable runtime PM without autosuspend:
> +	 *
> +	 * Don't use pm autosuspend (alvium have ~7s boot time).
> +	 * Alvium has been powered manually:
> +	 *  - mark it as active
> +	 *  - increase the usage count without resuming the device.
> +	 */
> +	pm_runtime_set_active(dev);
> +	pm_runtime_get_noresume(dev);
> +	pm_runtime_enable(dev);
> +
> +	/* Initialize the V4L2 subdev. */
> +	ret = alvium_subdev_init(alvium);
> +	if (ret)
> +		goto err_pm;
> +
> +	ret = v4l2_async_register_subdev(&alvium->sd);
> +	if (ret < 0) {
> +		dev_err(dev, "Could not register v4l2 device\n");
> +		goto err_subdev;
> +	}
> +
> +	return 0;
> +
> +err_subdev:
> +	alvium_subdev_cleanup(alvium);

Should this also be called by the remove function?
Or is it already handled by an un-register mechanism?

CJ

> +err_pm:
> +	pm_runtime_disable(dev);
> +	pm_runtime_put_noidle(dev);
> +err_powerdown:
> +	alvium_power_on(alvium, false);
> +
> +	return ret;
> +}
> +

...

