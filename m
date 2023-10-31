Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FF317DCC16
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Oct 2023 12:46:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344061AbjJaLqU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Oct 2023 07:46:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344042AbjJaLqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Oct 2023 07:46:18 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68AEDA;
        Tue, 31 Oct 2023 04:46:14 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-543456dbd7bso3151094a12.1;
        Tue, 31 Oct 2023 04:46:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698752773; x=1699357573; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=LWE1x/QoQTItg0sKrOkyzpWfv9LTBX18ZDhLGCgROwM=;
        b=Ci3J2ZnGTRBJepQypCCkbcXayTbiBMLpIhtyd2AhGNQMSLohxA7fDsppirHS0MORPw
         749nornK41w3RC6q36k4VVSZzzhUBlh5BdBdFv3B48Po5OQzPfDoJXw+DByLn1v0K+bK
         8BMKKQuNW/MEuE1wxLukxCDfFiknDazbbrwbU9hrNCusdAFD+al2x+rP1zeJxSN+kIWI
         frk0UcIa1Thtic1etRa9VyRk6WEFJZJGI4n9evKmKD0MNRcnAlThGJU596Ie3NeGRLoa
         Z/W9qNhcBjlo/G2aR1MbcXzZQ/mJRX/l9Id/d1cJPAemOB+dH9s2cF+vSqdDqsuN67P9
         koLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698752773; x=1699357573;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LWE1x/QoQTItg0sKrOkyzpWfv9LTBX18ZDhLGCgROwM=;
        b=ljTmRWgVo+qDcj/Yi6p10hMCjx5BRQwj7sD8AJEYNKIYZp8zcS8R8Q0SZQOvRPWD9C
         7+qNs3ayoi6WdeA0Kdrl4D9DdlwjxmZ078UxIFisgKpw3yRyHq2OiLaZv8XsxBjpkF2x
         xRhd1VWGoK/kmL7xQMrkRA0uWFaQyhH3wKZ+1mexWV4ki2CeyD7XV+QpFBoL5HaYpo+6
         ZwVYBWXsCavRbgJmNKxV6KlfX9YRaaAQP+oWgx8HbjuRmysUuSSaY+9oQAlo4OzCcApl
         0aDUma5pzZql52HL8BhSXQe2gX/1aTLi4tjGumdV0AIe7mcfFbEAmVB+PUEg/L02fd0L
         aOqA==
X-Gm-Message-State: AOJu0YyLkmbF5RA/Y815S6hUB17cBwOd7Tp+o3RfDnS0MZYPJYyFMRwg
        wM/4WBXEUQMBdpnpKSq4FWE=
X-Google-Smtp-Source: AGHT+IFVDI/OZWWdBj10U4UsmFm/5KWGAQUdRCx4bWtUrFRSSGNIaMnQTw9fgD0s0HpRhuhNx6cvSw==
X-Received: by 2002:a17:906:c116:b0:9a2:295a:9bbc with SMTP id do22-20020a170906c11600b009a2295a9bbcmr2103475ejc.37.1698752772764;
        Tue, 31 Oct 2023 04:46:12 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-59-109.cust.vodafonedsl.it. [188.217.59.109])
        by smtp.gmail.com with ESMTPSA id z5-20020a170906714500b0099ce188be7fsm851854ejj.3.2023.10.31.04.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Oct 2023 04:46:12 -0700 (PDT)
Date:   Tue, 31 Oct 2023 12:46:09 +0100
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
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
Subject: Re: [PATCH v10 3/3] media: i2c: Add support for alvium camera
Message-ID: <ZUDpAR3ZyBVrUyat@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20231020141354.2500602-1-tomm.merciai@gmail.com>
 <20231020141354.2500602-4-tomm.merciai@gmail.com>
 <a98bca80-944c-493b-9872-75b94cd24eea@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a98bca80-944c-493b-9872-75b94cd24eea@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe, Laurent, Sakari,
Thanks for the comments.

On Tue, Oct 31, 2023 at 11:23:24AM +0100, Christophe JAILLET wrote:
> Le 20/10/2023 à 16:13, Tommaso Merciai a écrit :
> > The Alvium camera is shipped with sensor + isp in the same housing.
> > The camera can be equipped with one out of various sensor and abstract
> > the user from this. Camera is connected via MIPI CSI-2.
> > 
> > Most of the camera module features are supported, with the main exception
> > being fw update.
> > 
> > The driver provides all mandatory, optional and recommended V4L2 controls
> > for maximum compatibility with libcamera
> > 
> > References:
> >   - https://www.alliedvision.com/en/products/embedded-vision-solutions
> > 
> > Signed-off-by: Tommaso Merciai <tomm.merciai@gmail.com>
> > ---
> 
> Hi, a few nits and a question at the end.
> 
> > +static int alvium_setup_mipi_fmt(struct alvium_dev *alvium)
> > +{
> > +	int avail_fmt_cnt = 0;
> > +	int sz = 0;
> > +	int fmt = 0;
> > +
> > +	alvium->alvium_csi2_fmt = NULL;
> > +
> > +	/* calculate fmt array size */
> > +	for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
> > +		if (alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit])
> > +			if ((!alvium_csi2_fmts[fmt].is_raw) ||
> > +				  (alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]))
> > +				sz++;
> > +	}
> > +
> > +	/* init alvium_csi2_fmt array */
> > +	alvium->alvium_csi2_fmt_n = sz;
> > +	alvium->alvium_csi2_fmt = kmalloc_array(sz,
> > +						     sizeof(struct alvium_pixfmt),
> 
> This could be on the previous line

Nitpicker  :)
Thanks

> 
> > +						     GFP_KERNEL);
> > +
> > +	/* Create the alvium_csi2 fmt array from formats available */
> > +	for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
> > +		if (!alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit])
> > +			continue;
> > +
> > +		if ((!alvium_csi2_fmts[fmt].is_raw) ||
> > +				(alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit])) {
> > +			alvium->alvium_csi2_fmt[avail_fmt_cnt] =
> > +					alvium_csi2_fmts[fmt];
> > +			avail_fmt_cnt++;
> > +		}
> > +	}
> > +
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int alvium_s_frame_interval(struct v4l2_subdev *sd,
> > +				   struct v4l2_subdev_frame_interval *fi)
> > +{
> > +	struct alvium_dev *alvium = sd_to_alvium(sd);
> > +	int ret;
> > +
> > +	if (alvium->streaming)
> > +		return -EBUSY;
> > +
> > +	ret = alvium_set_frame_interval(alvium, fi);
> > +	if (!ret) {
> > +		ret = alvium_set_frame_rate(alvium);
> > +		if (ret)
> > +			return -EIO;
> 
> Why not ret?

Right I can return ret aswell here.
Thanks.

> 
> > +	}
> > +
> > +	return ret;
> > +}
> 
> ...
> 
> > +static int alvium_get_dt_data(struct alvium_dev *alvium)
> > +{
> > +	struct device *dev = &alvium->i2c_client->dev;
> > +	struct fwnode_handle *fwnode = dev_fwnode(dev);
> > +	struct fwnode_handle *endpoint;
> > +	int ret = -EINVAL;
> > +
> > +	if (!fwnode)
> > +		return -EINVAL;
> > +
> > +	/* Only CSI2 is supported for now: */
> > +	alvium->ep.bus_type = V4L2_MBUS_CSI2_DPHY;
> > +
> > +	endpoint = fwnode_graph_get_endpoint_by_id(fwnode, 0, 0, 0);
> > +	if (!endpoint) {
> > +		dev_err(dev, "endpoint node not found\n");
> > +		return -EINVAL;
> > +	}
> > +
> > +	if (v4l2_fwnode_endpoint_alloc_parse(endpoint, &alvium->ep)) {
> > +		dev_err(dev, "could not parse endpoint\n");
> > +		goto error_out;
> 
> This could go to another label to be less confusing, but
> v4l2_fwnode_endpoint_free() looks to be a no-op here, so good enough.

Thanks for the comment.
To be honest right now this is clear to me
I prefere to stay on the following :)
Prefer to keep just only one path.

> 
> > +	}
> > +
> > +	if (!alvium->ep.nr_of_link_frequencies) {
> > +		dev_err(dev, "no link frequencies defined");
> > +		goto error_out;
> > +	}
> > +
> > +	return 0;
> > +
> > +error_out:
> > +	v4l2_fwnode_endpoint_free(&alvium->ep);
> > +	fwnode_handle_put(endpoint);
> > +
> > +	return ret;
> > +}
> > +
> > +static int alvium_power_on(struct alvium_dev *alvium, bool on)
> > +{
> > +	int ret = 0;
> 
> Useless init.

Right.

> 
> > +
> > +	if (!on)
> > +		return regulator_disable(alvium->reg_vcc);
> > +
> > +	ret = regulator_enable(alvium->reg_vcc);
> > +	if (ret)
> > +		return ret;
> > +
> > +	/* alvium boot time 7s*/
> 
> space missing before */

Oooks :)
Thanks.

> 
> > +	msleep(7000);
> > +	return 0;
> > +}
> 
> ...
> 
> > +static int alvium_probe(struct i2c_client *client)
> > +{
> > +	struct device *dev = &client->dev;
> > +	struct alvium_dev *alvium;
> > +	int ret;
> > +
> > +	alvium = devm_kzalloc(dev, sizeof(*alvium), GFP_KERNEL);
> > +	if (!alvium)
> > +		return -ENOMEM;
> > +
> > +	alvium->i2c_client = client;
> > +
> > +	alvium->regmap = devm_cci_regmap_init_i2c(client, 16);
> > +	if (IS_ERR(alvium->regmap))
> > +		return PTR_ERR(alvium->regmap);
> > +
> > +	ret = alvium_get_dt_data(alvium);
> > +	if (ret)
> > +		return ret;
> > +
> > +	alvium->reg_vcc = devm_regulator_get_optional(dev, "vcc-ext-in");
> > +	if (IS_ERR(alvium->reg_vcc))
> > +		return dev_err_probe(dev, PTR_ERR(alvium->reg_vcc),
> > +			"no vcc-ext-in regulator provided\n");
> > +
> > +	ret = alvium_power_on(alvium, true);
> > +	if (ret)
> > +		goto err_powerdown;
> > +
> > +	if (!alvium_is_alive(alvium)) {
> > +		dev_err(dev, "Device detection failed: %d\n", ret);
> 
> Nit: Here and below, dev_err_probe() could also be used to display the error
> code in a human readable way.

Oks I switch here and below to use:
dev_err_probe(dev, ret, "...);


> 
> > +		ret = -ENODEV;
> > +		goto err_powerdown;
> > +	}
> > +
> > +	ret = alvium_get_hw_info(alvium);
> > +	if (ret) {
> > +		dev_err(dev, "get_hw_info fail %d\n", ret);
> > +		goto err_powerdown;
> > +	}
> > +
> > +	ret = alvium_hw_init(alvium);
> > +	if (ret) {
> > +		dev_err(dev, "hw_init fail %d\n", ret);
> > +		goto err_powerdown;
> > +	}
> > +
> > +	ret = alvium_setup_mipi_fmt(alvium);
> > +	if (ret) {
> > +		dev_err(dev, "setup_mipi_fmt fail %d\n", ret);
> > +		goto err_powerdown;
> > +	}
> > +
> > +	/*
> > +	 * Enable runtime PM without autosuspend:
> > +	 *
> > +	 * Don't use pm autosuspend (alvium have ~7s boot time).
> > +	 * Alvium has been powered manually:
> > +	 *  - mark it as active
> > +	 *  - increase the usage count without resuming the device.
> > +	 */
> > +	pm_runtime_set_active(dev);
> > +	pm_runtime_get_noresume(dev);
> > +	pm_runtime_enable(dev);
> > +
> > +	/* Initialize the V4L2 subdev. */
> > +	ret = alvium_subdev_init(alvium);
> > +	if (ret)
> > +		goto err_pm;
> > +
> > +	ret = v4l2_async_register_subdev(&alvium->sd);
> > +	if (ret < 0) {
> > +		dev_err(dev, "Could not register v4l2 device\n");
> > +		goto err_subdev;
> > +	}
> > +
> > +	return 0;
> > +
> > +err_subdev:
> > +	alvium_subdev_cleanup(alvium);
> 
> Should this also be called by the remove function?
> Or is it already handled by an un-register mechanism?

Right, I miss this.
Thanks.
I put this to remove function like:

static void alvium_remove(struct i2c_client *client)
{
	struct v4l2_subdev *sd = i2c_get_clientdata(client);
	struct alvium_dev *alvium = sd_to_alvium(sd);
	struct device *dev = &alvium->i2c_client->dev;

	/*
	 * Disable runtime PM. In case runtime PM is disabled in the kernel,
	 * make sure to turn power off manually.
	 */
	pm_runtime_disable(dev);
	if (!pm_runtime_status_suspended(dev))
		alvium_power_on(alvium, false);
	pm_runtime_set_suspended(dev);

	alvium_subdev_cleanup(alvium);
	i2c_unregister_device(alvium->i2c_client);
}


If for you Cristophe, Sakari, Laurent,
it's ok I prefer to skip v11 that I sent this morning too early.
I collected hints from Cristophe right now and I plan to send v12
this afternoon/evening if for you all is ok.

https://github.com/avs-sas/linux/blob/tm/media_stage/v6.6.0-rc3/alvium_drv/v12/drivers/media/i2c/alvium-csi2.c

Please let me know.

Thanks again to all! :)

Regards,
Tommaso

> 
> CJ
> 
> > +err_pm:
> > +	pm_runtime_disable(dev);
> > +	pm_runtime_put_noidle(dev);
> > +err_powerdown:
> > +	alvium_power_on(alvium, false);
> > +
> > +	return ret;
> > +}
> > +
> 
> ...
> 
