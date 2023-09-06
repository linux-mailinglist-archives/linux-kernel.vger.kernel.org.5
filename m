Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34E3C793634
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 09:25:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjIFHZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 03:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231214AbjIFHZg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 03:25:36 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82E4A1982
        for <linux-kernel@vger.kernel.org>; Wed,  6 Sep 2023 00:25:06 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id a640c23a62f3a-9a2a4a5472dso132053066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Sep 2023 00:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693985104; x=1694589904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=L1hUUio95wuW9V9qd5PRJ6Ur/vyv480neY2DMXLqJvE=;
        b=lTTDvUlutzdZLtPqXzpu+RUYklhs6QNIMLPh8qhg4bOju3/SBJilPLq4/5O042qKrO
         3pQgqKjULGO6R12lReA+fMKt6lkg+rltjUYFR5kwojrioBtzgYhq+ktdLUb1L0CVjCWn
         mkhv2Ivex72DZFL/l/jV9sSY+wa6f1RCRUB/9pjsD4gEuZGbIXQjFlfQl+d1XXQwRUzw
         YSHhE4senYVc1c3rZQP9Y1iL4dkm8l2VKBuSxwXgYUj/lvLJs/WyQ2AcU+nQUXaa2ICR
         Ix1tuKBelTR6x0dI7Ah1TuR2WsasMmxPP4FgsuRm6XsECGXUDdu6wRwisTd1kXc3kFef
         j8cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693985104; x=1694589904;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=L1hUUio95wuW9V9qd5PRJ6Ur/vyv480neY2DMXLqJvE=;
        b=KObMPFHqFSOamPbkTmic9dP3XsKf6d9TMg/kcQf7fSFJbjJ+BJg+mTUrfEn3I8zfvM
         F8ze5a+gjODhN1oxz5K7XxGl/dqztg7xj/PVa1/pn4ooDZ0Z8zg0+V0qA5kXgct0tNZx
         qbFxwXZ2reN2Z3L0fO9eMxn+5MhkcLz+8auYywA+CublYO5eZ2/j11Z5qcku47QkBYnX
         xn8zR6Q74tFjSGWroQmlUf+1MVarI7cY2BYjNysEa4rHjH+2Lb7c0YSvWN4sN4stSAQG
         05GMD6rdEtBx040VaYOVwniODc198hyUVBZicQR7A+tALPbiXZY6Y+2SaXB3dgotjXDh
         27vw==
X-Gm-Message-State: AOJu0Yy/QUlWlXEUuH6/4I1XWDxLvwiASfZ0LtBUnBBwpXH6f6c4eMDm
        mSp4OfUImO+gmhRvISxoxoNzJA==
X-Google-Smtp-Source: AGHT+IHJAfBjF3n0DF37CfqLh4KI1JSODUSnTOSTOSgfGl6RzMSyCgbgHLwUbX5ibOFIwoxy1VSwWQ==
X-Received: by 2002:a17:907:31c9:b0:9a1:e5bf:c907 with SMTP id xf9-20020a17090731c900b009a1e5bfc907mr1967842ejb.2.1693985103706;
        Wed, 06 Sep 2023 00:25:03 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id j9-20020a170906410900b0099bd5b72d93sm8590614ejk.43.2023.09.06.00.25.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Sep 2023 00:25:03 -0700 (PDT)
Message-ID: <569755e5-7cce-7077-3078-36c2d1422f97@linaro.org>
Date:   Wed, 6 Sep 2023 09:25:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 2/3] media: i2c: Add driver for THine THP7312
Content-Language: en-US
To:     Paul Elder <paul.elder@ideasonboard.com>,
        linux-media@vger.kernel.org
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230905233118.183140-1-paul.elder@ideasonboard.com>
 <20230905233118.183140-3-paul.elder@ideasonboard.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230905233118.183140-3-paul.elder@ideasonboard.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/09/2023 01:31, Paul Elder wrote:
> Add driver for the THine THP7312 ISP.
> 
> Signed-off-by: Paul Elder <paul.elder@ideasonboard.com>
> ---

...

> +
> +static int thp7312_change_mode(struct thp7312_isp_dev *isp_dev,
> +			       enum thp7312_mode mode)
> +{
> +	struct i2c_client *client = isp_dev->i2c_client;
> +	u8 reg_val = 0;
> +	struct reg_value *reg_data;
> +	int i;
> +	int ret;
> +	struct thp7312_mode_info *info = &thp7312_mode_info_data[mode];
> +
> +	ret = thp7312_read_poll_timeout(isp_dev, THP7312_REG_CAMERA_STATUS, reg_val,

This and many other palces do not look like wrapped according to Linux
coding style, so at 80. And please do not use argument "but checkpatch",
but read the Coding Style.

> +					reg_val == 0x80, 20000, 200000);
> +	if (ret < 0) {
> +		dev_err(&client->dev, "%s(): failed to poll ISP: %d\n",
> +			__func__, ret);
> +		return ret;
> +	}
> +


> +static int thp7312_reset(struct thp7312_isp_dev *isp_dev)
> +{
> +	struct device *dev = &isp_dev->i2c_client->dev;
> +	u8 camera_status = -1;
> +	int ret;
> +
> +	gpiod_set_value_cansleep(isp_dev->reset_gpio, 1);
> +	
> +	fsleep(10000);
> +	
> +	gpiod_set_value_cansleep(isp_dev->reset_gpio, 0);
> +	
> +	fsleep(300000);
> +
> +	while (camera_status != 0x80) {
> +		ret = thp7312_read_reg(isp_dev, 0xF001, &camera_status);
> +		if (ret < 0) {
> +			dev_err(dev, "Failed to read camera status register\n");
> +			return ret;
> +		}
> +
> +		if (camera_status == 0x00) {
> +			dev_info(dev, "Camera initializing...");

That's a debug at most.

> +		} else if (camera_status == 0x80) {
> +			dev_info(dev, "Camera initialization done");

dev_dbg

> +			break;
> +		} else {
> +			dev_err(dev,
> +				"Camera Status field incorrect; camera_status=%x\n",
> +				camera_status);
> +		}
> +
> +		usleep_range(70000, 80000);
> +	}
> +
> +	return 0;
> +}
> +
> +static int thp7312_set_power_on(struct device *dev)
> +{
> +	struct v4l2_subdev *sd = dev_get_drvdata(dev);
> +	struct thp7312_isp_dev *isp_dev = to_thp7312_dev(sd);
> +
> +	int ret;
> +
> +	ret = regulator_bulk_enable(THP7312_NUM_SUPPLIES, isp_dev->supplies);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret = clk_prepare_enable(isp_dev->iclk);
> +	if (ret < 0) {
> +		dev_err(dev, "clk prepare enable failed\n");
> +		goto error_pwdn;
> +	}
> +
> +	/*
> +	 * We cannot assume that turning off and on again will reset, so do a
> +	 * software reset on power up. While at it, reprogram the MIPI lanes,
> +	 * in case they get cleared when powered off.
> +	 */
> +	ret = thp7312_reset(isp_dev);
> +	if (ret < 0)
> +		goto error_clk_disable;
> +
> +	ret = thp7312_set_mipi_lanes(isp_dev);
> +	if (ret < 0)
> +		goto error_clk_disable;
> +
> +	return 0;
> +
> +error_clk_disable:
> +	clk_disable_unprepare(isp_dev->iclk);
> +error_pwdn:
> +	regulator_bulk_disable(THP7312_NUM_SUPPLIES, isp_dev->supplies);
> +
> +	return ret;
> +}
> +
> +static int thp7312_set_power_off(struct device *dev)
> +{
> +	struct v4l2_subdev *sd = dev_get_drvdata(dev);
> +	struct thp7312_isp_dev *isp_dev = to_thp7312_dev(sd);
> +
> +	isp_dev->streaming = false;
> +
> +	regulator_bulk_disable(THP7312_NUM_SUPPLIES, isp_dev->supplies);
> +	clk_disable_unprepare(isp_dev->iclk);
> +
> +	return 0;
> +}
> +
> +static int thp7312_get_regulators(struct thp7312_isp_dev *isp_dev)
> +{
> +	int i;
> +
> +	for (i = 0; i < THP7312_NUM_SUPPLIES; i++)
> +		isp_dev->supplies[i].supply = thp7312_supply_name[i];
> +
> +	return devm_regulator_bulk_get(&isp_dev->i2c_client->dev,
> +				       THP7312_NUM_SUPPLIES,
> +				       isp_dev->supplies);
> +}


...

> +	case V4L2_CID_POWER_LINE_FREQUENCY:
> +		if (ctrl->val == V4L2_CID_POWER_LINE_FREQUENCY_60HZ) {
> +			value = THP7312_AE_FLICKER_MODE_60;
> +		} else if (ctrl->val==V4L2_CID_POWER_LINE_FREQUENCY_50HZ) {
> +			value = THP7312_AE_FLICKER_MODE_50;
> +		} else {
> +			if (isp_dev->fw_major_version == 40 && isp_dev->fw_minor_version == 03) {
> +				/* THP7312_AE_FLICKER_MODE_DISABLE is not supported */
> +				value = THP7312_AE_FLICKER_MODE_50; 
> +			} else {
> +				value = THP7312_AE_FLICKER_MODE_DISABLE;
> +			}
> +		}
> +		ret = thp7312_write_reg(isp_dev, THP7312_REG_AE_FLICKER_MODE, value);
> +		break;
> +		
> +	case V4L2_CID_SATURATION:
> +		ret = thp7312_write_reg(isp_dev, THP7312_REG_SATURATION, ctrl->val);
> +		break;
> +		
> +	case V4L2_CID_CONTRAST:
> +		ret = thp7312_write_reg(isp_dev, THP7312_REG_CONTRAST, ctrl->val);
> +		break;
> +		
> +	case V4L2_CID_SHARPNESS:
> +		ret = thp7312_write_reg(isp_dev, THP7312_REG_SHARPNESS, ctrl->val);
> +		break;
> +		
> +	default:
> +		dev_err(dev, "unsupported control id: %d\n", ctrl->id);
> +		break;
> +	}
> +
> +	pm_runtime_put(&client->dev);
> +
> +	return ret;
> +}
> +
> +static const struct v4l2_ctrl_ops thp7312_ctrl_ops = {
> +	.s_ctrl = thp7312_s_ctrl,
> +};
> +
> +static const struct v4l2_ctrl_config thp7312_v4l2_ctrls_custom[] = {
> +	{
> +		.ops = &thp7312_ctrl_ops,
> +		.id = V4L2_CID_THINE_LOW_LIGHT_COMPENSATION,
> +		.name = "Low Light Compensation",
> +		.type = V4L2_CTRL_TYPE_BOOLEAN,
> +		.min = 0,
> +		.def = 1,
> +		.max = 1,
> +		.step = 1,
> +	},
> +		
> +	{

}, {


...

> +
> +static int thp7312_parse_dt(struct thp7312_isp_dev *isp_dev)
> +{
> +	struct fwnode_handle *endpoint;
> +	struct device *dev = &isp_dev->i2c_client->dev;
> +	int ret;
> +
> +	endpoint = fwnode_graph_get_next_endpoint(dev_fwnode(dev), NULL);
> +	if (!endpoint) {
> +		dev_err(dev, "endpoint node not found\n");
> +		return -EINVAL;

return dev_err_probe


> +	}
> +
> +	ret = v4l2_fwnode_endpoint_parse(endpoint, &isp_dev->ep);
> +	fwnode_handle_put(endpoint);
> +	if (ret) {
> +		dev_err(dev, "Could not parse endpoint\n");
> +		return ret;

return dev_err_probe

> +	}
> +
> +	if (isp_dev->ep.bus_type != V4L2_MBUS_CSI2_DPHY) {
> +		dev_err(dev, "Unsupported bus type %d\n", isp_dev->ep.bus_type);
> +		return -EINVAL;

return dev_err_probe


> +	}
> +
> +	return 0;
> +}
> +
> +static int thp7312_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct thp7312_isp_dev *isp_dev;
> +	int ret;
> +
> +	dev_info(dev, "Start of probe %s:%d", __func__, __LINE__);

No, no silly tracing messages. Never.

> +	isp_dev = devm_kzalloc(dev, sizeof(*isp_dev), GFP_KERNEL);
> +	if (!isp_dev)
> +		return -ENOMEM;
> +	isp_dev->i2c_client = client;
> +
> +	thp7312_init_fmt(isp_dev);
> +
> +	isp_dev->current_mode =
> +		(struct thp7312_mode_info *)thp7312_find_mode(isp_dev,
> +							      isp_dev->current_fr,
> +							      isp_dev->fmt.width,
> +							      isp_dev->fmt.height,
> +							      true);
> +
> +	/* TODO fix firmware */
> +	/* update mode hardcoded at 0 for now */
> +	isp_dev->fw_update_mode = 0;
> +	isp_dev->fw_major_version = 0;
> +	isp_dev->fw_minor_version = 0;
> +	isp_dev->thp7312_register_rw_address = 61440;
> +
> +	ret = thp7312_parse_dt(isp_dev);
> +	if (ret < 0) {
> +		dev_err(dev, "Failed to parse DT: %d\n", ret);

Why do you print errors twice?

> +		return ret;

> +	}
> +
> +	ret = thp7312_get_regulators(isp_dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to get regulators: %d\n", ret);

return dev_err_probe

> +		return ret;
> +	}
> +
> +	isp_dev->iclk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(isp_dev->iclk)) {
> +		dev_err(dev, "Failed to get iclk\n");

return dev_err_probe

> +		return PTR_ERR(isp_dev->iclk);
> +	}
> +
> +	/* request reset pin */
> +	isp_dev->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(isp_dev->reset_gpio)) {
> +		dev_err(dev, "Failed to get reset gpio\n");

Please start from a new driver as base for your code, so all such
trivialities do not have to be repeated over and over

return dev_err_probe

> +		return PTR_ERR(isp_dev->reset_gpio);
> +	}
> +
> +	v4l2_i2c_subdev_init(&isp_dev->sd, client, &thp7312_subdev_ops);
> +	isp_dev->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE | V4L2_SUBDEV_FL_HAS_EVENTS;
> +	isp_dev->pad.flags = MEDIA_PAD_FL_SOURCE;
> +	isp_dev->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
> +
> +	mutex_init(&isp_dev->lock);
> +
> +	ret = media_entity_pads_init(&isp_dev->sd.entity, 1, &isp_dev->pad);
> +	if (ret)
> +		goto mutex_destroy;
> +
> +	ret = thp7312_set_power_on(dev);
> +	if (ret)
> +		goto entity_cleanup;
> +
> +	ret = thp7312_read_firmware_version(isp_dev);
> +	if (ret < 0) {
> +		dev_warn(dev, "Camera is not found\n");
> +		goto power_off;
> +	}
> +
> +	dev_info(dev, "THP7312 firmware version = %02d.%02d",
> +		 isp_dev->fw_major_version, isp_dev->fw_minor_version);
> +
> +	ret = thp7312_init_controls(isp_dev);
> +	if (ret)
> +		goto power_off;
> +
> +	isp_dev->sd.ctrl_handler = &isp_dev->ctrl_handler;
> +
> +	ret = v4l2_async_register_subdev(&isp_dev->sd);
> +	if (ret < 0) {
> +		dev_err(dev, "Subdev registeration failed");
> +		goto free_ctrls;
> +	}
> +
> +	pm_runtime_set_active(dev);
> +	pm_runtime_enable(dev);
> +
> +	dev_info(dev, "v4l2 async register subdev done");

Drop.

> +
> +	return 0;
> +
> +free_ctrls:
> +	v4l2_ctrl_handler_free(&isp_dev->ctrl_handler);
> +power_off:
> +	thp7312_set_power_off(dev);
> +entity_cleanup:
> +	media_entity_cleanup(&isp_dev->sd.entity);
> +mutex_destroy:
> +	mutex_destroy(&isp_dev->lock);
> +	return ret;
> +}
> +
> +static void thp7312_remove(struct i2c_client *client)
> +{
> +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
> +	struct thp7312_isp_dev *isp_dev = to_thp7312_dev(sd);
> +
> +	v4l2_async_unregister_subdev(&isp_dev->sd);
> +	v4l2_ctrl_handler_free(&isp_dev->ctrl_handler);
> +	media_entity_cleanup(&isp_dev->sd.entity);
> +	v4l2_device_unregister_subdev(sd);
> +	pm_runtime_disable(&client->dev);
> +	mutex_destroy(&isp_dev->lock);
> +}
> +
> +static const struct i2c_device_id thp7312_id[] = {
> +	{"thp7312", 0},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(i2c, thp7312_id);
> +
> +static const struct of_device_id thp7312_dt_ids[] = {
> +	{ .compatible = "thine,thp7312" },
> +	{ /* sentinel */ }
> +};
> +MODULE_DEVICE_TABLE(of, thp7312_dt_ids);
> +
> +static const struct dev_pm_ops thp7312_pm_ops = {
> +	SET_RUNTIME_PM_OPS(thp7312_set_power_off, thp7312_set_power_on, NULL)
> +};
> +
> +static struct i2c_driver thp7312_i2c_driver = {
> +	.driver = {
> +		.name  = "thp7312",
> +		.of_match_table	= thp7312_dt_ids,
> +	},
> +	.id_table = thp7312_id,
> +	.probe_new = thp7312_probe,

probe

> +	.remove   = thp7312_remove,
> +};
> +
> +module_i2c_driver(thp7312_i2c_driver);
> +
> +MODULE_DESCRIPTION("THP7312 MIPI Camera Subdev Driver");
> +MODULE_LICENSE("GPL");

Best regards,
Krzysztof

