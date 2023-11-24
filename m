Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E20797F6DAF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Nov 2023 09:10:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344862AbjKXIJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Nov 2023 03:09:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbjKXIJw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Nov 2023 03:09:52 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F814D44
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:09:57 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id a1e0cc1a2514c-7c143044625so555769241.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Nov 2023 00:09:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1700813396; x=1701418196; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TdMUhpyI2+dQyC5Jb7ZVd4mPkClI52AZ3LWo5a/osyo=;
        b=OEBStme8+bJxfR0Nx4UBbq63nnGahaq05y51DJEXunPYXY8SxsEJeZnU53TzLNECcW
         bsPXcAgEjJ9aC6/oXXHv8NBAOo8UYyieCwKBzAWvfZ/jDWiO2zVn8G+8rrRiFANJi97v
         O0DdT4rHsUcIVayZeRfoZkO+mrUr1PDXTy0rKQ7irQutNoz6Di5Y0jw5huj/QyUtJvlA
         zFaZdS7sLBjs5aDE9n2lsvwDrSD4M7NOMjbe/pHiZYha7SVKWiaxD1Xzg7n+clOlwLzy
         0wuPvTHm2bZD5YbdeDE6Wyi1ixVvH2rasprzKmDi4LJewhpMLCln5JHvBG4bEW0AzBQQ
         6Ouw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700813396; x=1701418196;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TdMUhpyI2+dQyC5Jb7ZVd4mPkClI52AZ3LWo5a/osyo=;
        b=bx7qB2qKnraqWfOV1svKGXh/CIzK8YACHMvfKZB2PPDUYeacCEv6DuSpXHC3LfGL8x
         1R5vHWzE1ZOafhQJNUYua+D29JeGD4eMWnOPFKKqOQ66JVmvPbHhToHzaoCLOVArcF12
         7Bao2kQ3YqV25/xIgWp2/JuGXj5JlicYn+zM76RKlFLn8Mx5uMGx7im7c8M/4UIF0eo5
         vzbsT5gwUWDfoYPmxKfPScFqlOgfHY4tTF5h08WuB/zb27ZPp1wy6dCmdqwyLmtrZGfr
         XrMSeGfRFxA2H3YihXRUSPnY40fYAvWuuTO/4EEhE2HuKBH0bm/M+ha1BbGH/aOZeolS
         K1YQ==
X-Gm-Message-State: AOJu0YyDCXrxuW70BLYG6TADzSX8UhYe+tyRbaUHBZ2gI+1RBdWQ+r0a
        t0gx7ZgogpRmhKXwTfODySfAdQ==
X-Google-Smtp-Source: AGHT+IHKESaqwzFkAII+v/Gc3bBjqRwWiSLQkt08GJSOgnaFma7ZBn0Qe9nodZJupkTfCYrNnqZ27A==
X-Received: by 2002:a05:6122:2015:b0:49e:2145:1651 with SMTP id l21-20020a056122201500b0049e21451651mr2101831vkd.6.1700813396304;
        Fri, 24 Nov 2023 00:09:56 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.100])
        by smtp.gmail.com with ESMTPSA id 38-20020a9f2029000000b007a01cbe8f28sm520429uam.4.2023.11.24.00.09.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Nov 2023 00:09:55 -0800 (PST)
Message-ID: <4a4a3313-2fb5-4b20-a24f-4422aeedbc41@linaro.org>
Date:   Fri, 24 Nov 2023 09:09:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] media: i2c: Add GC08A3 image sensor driver
Content-Language: en-US
To:     Zhi Mao <zhi.mao@mediatek.com>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     shengnan.wang@mediatek.com, yaya.chang@mediatek.com,
        10572168@qq.com, Project_Global_Chrome_Upstream_Group@mediatek.com,
        yunkec@chromium.org, conor+dt@kernel.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        jacopo.mondi@ideasonboard.com, sakari.ailus@linux.intel.com,
        hverkuil-cisco@xs4all.nl, heiko@sntech.de,
        jernej.skrabec@gmail.com, macromorgan@hotmail.com,
        linus.walleij@linaro.org, laurent.pinchart@ideasonboard.com,
        hdegoede@redhat.com, tomi.valkeinen@ideasonboard.com,
        gerald.loacker@wolfvision.net, andy.shevchenko@gmail.com,
        bingbu.cao@intel.com, dan.scally@ideasonboard.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20231123115104.32094-1-zhi.mao@mediatek.com>
 <20231123115104.32094-3-zhi.mao@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231123115104.32094-3-zhi.mao@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/11/2023 12:51, Zhi Mao wrote:
> Add a V4L2 sub-device driver for Galaxycore GC08A3 image sensor.
> 
> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> ---
>  drivers/media/i2c/Kconfig  |   14 +
>  drivers/media/i2c/Makefile |    1 +
>  drivers/media/i2c/gc08a3.c | 2046 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 2061 insertions(+)
>  create mode 100644 drivers/media/i2c/gc08a3.c


> +static int gc08a3_start_streaming(struct gc08a3 *gc08a3)
> +{
> +	const struct gc08a3_mode *mode;
> +	const struct gc08a3_reg_list *reg_list;
> +	int link_freq_index;
> +	int ret;
> +
> +	dev_info(gc08a3->dev, "%s ++\n", __func__);

Drop

> +
> +	mutex_lock(&gc08a3->mutex);
> +
> +	link_freq_index = gc08a3->cur_mode->link_freq_index;
> +	dev_info(gc08a3->dev, "----link_freq_index = %d ", link_freq_index);
> +
> +	reg_list = &link_freq_configs[link_freq_index].reg_list;
> +	ret = gc08a3_write_reg_list(gc08a3, reg_list);
> +	if (ret) {
> +		dev_err(gc08a3->dev, "could not sent common table %d\n", ret);
> +		goto error;
> +	}
> +
> +	mode = gc08a3->cur_mode;
> +	dev_info(gc08a3->dev, "----write regtbl: mode(id:%d, WxH:%dx%d)",
> +		 mode->mode_id, mode->width, mode->height);
> +	reg_list = &mode->reg_list;
> +
> +	ret = gc08a3_write_reg_list(gc08a3, reg_list);
> +	if (ret < 0) {
> +		dev_err(gc08a3->dev, "could not sent mode table %d\n", ret);
> +		goto error;
> +	}
> +	ret = __v4l2_ctrl_handler_setup(&gc08a3->ctrls);
> +	if (ret < 0) {
> +		dev_err(gc08a3->dev, "could not sync v4l2 controls\n");
> +		goto error;
> +	}
> +
> +	ret = gc08a3_write_reg(gc08a3, GC08A3_STRAEMING_REG,
> +			       GC08A3_REG_VALUE_08BIT, 1);
> +	if (ret < 0) {
> +		dev_err(gc08a3->dev, "write STRAEMING_REG failed: %d\n", ret);
> +		goto error;
> +	}
> +
> +	mutex_unlock(&gc08a3->mutex);
> +
> +	dev_info(gc08a3->dev, "%s --\n", __func__);

Drop


> +
> +	return 0;
> +
> +error:
> +	mutex_unlock(&gc08a3->mutex);
> +	return ret;
> +}
> +
> +static int gc08a3_stop_streaming(struct gc08a3 *gc08a3)
> +{
> +	int ret;
> +
> +	dev_info(gc08a3->dev, "%s ++\n", __func__);

Drop

> +
> +	ret = gc08a3_write_reg(gc08a3, GC08A3_STRAEMING_REG,
> +			       GC08A3_REG_VALUE_08BIT, 0);
> +	if (ret < 0)
> +		dev_err(gc08a3->dev, "could not sent stop streaming %d\n", ret);
> +
> +	dev_info(gc08a3->dev, "%s --\n", __func__);
> +

Drop

...

> +
> +static int gc08a3_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct gc08a3 *gc08a3;
> +	int ret;
> +
> +	dev_info(dev, "--- %s +", __func__);


No, drop such silly debug messages. Everywhere. Really everywhere.

> +
> +	ret = gc08a3_parse_fwnode(dev);
> +	if (ret)
> +		return ret;
> +
> +	gc08a3 = devm_kzalloc(dev, sizeof(*gc08a3), GFP_KERNEL);
> +	if (!gc08a3)
> +		return -ENOMEM;
> +
> +	gc08a3->dev = dev;
> +
> +	gc08a3->xclk = devm_clk_get(dev, NULL);
> +	if (IS_ERR(gc08a3->xclk)) {
> +		dev_err(dev, "could not get xclk\n");

Syntax is:
return dev_err_probe()

> +		return PTR_ERR(gc08a3->xclk);
> +	}
> +
> +	ret = clk_set_rate(gc08a3->xclk, GC08A3_DEFAULT_CLK_FREQ);
> +	if (ret) {
> +		dev_err(dev, "could not set xclk frequency\n");
> +		return ret;
> +	}
> +
> +	ret = gc08a3_get_regulators(dev, gc08a3);
> +	if (ret < 0) {
> +		dev_err(dev, "cannot get regulators\n");

return dev_err_probe()

> +		return ret;
> +	}
> +
> +	gc08a3->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
> +	if (IS_ERR(gc08a3->enable_gpio)) {
> +		dev_err(dev, "cannot get enable gpio\n");

return dev_err_probe()

> +		return PTR_ERR(gc08a3->enable_gpio);
> +	}
> +
> +	gc08a3->regmap = devm_regmap_init_i2c(client, &sensor_regmap_config);
> +	if (IS_ERR(gc08a3->regmap)) {
> +		dev_err(dev, "regmap init failed\n");

return dev_err_probe()

> +		return PTR_ERR(gc08a3->regmap);
> +	}
> +
> +	v4l2_i2c_subdev_init(&gc08a3->sd, client, &gc08a3_subdev_ops);
> +
> +	gc08a3_power_on(gc08a3->dev);
> +
> +	ret = gc08a3_identify_module(gc08a3);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to find sensor: %d\n", ret);
> +		gc08a3_power_off(gc08a3->dev);
> +		return ret;
> +	}
> +
> +	mutex_init(&gc08a3->mutex);
> +	gc08a3->cur_mode = &gc08a3_modes[0];
> +
> +	ret = gc08a3_init_controls(gc08a3);
> +	if (ret) {
> +		dev_err(&client->dev, "failed to init controls: %d", ret);

No power off?

> +		goto free_ctrl;
> +	}
> +
> +	gc08a3->sd.flags |= V4L2_SUBDEV_FL_HAS_DEVNODE;
> +	gc08a3->pad.flags = MEDIA_PAD_FL_SOURCE;
> +	gc08a3->sd.dev = &client->dev;
> +	gc08a3->sd.entity.function = MEDIA_ENT_F_CAM_SENSOR;
> +
> +	dev_dbg(&client->dev, "gc08a3->sd.name: %s, dev->of_node->name: %s\n",
> +		gc08a3->sd.name, dev->of_node->name);
> +	if (V4L2_SUBDEV_NAME_SIZE - strlen(gc08a3->sd.name) - 2 <
> +	    strlen(dev->of_node->name)) {
> +		dev_err(&client->dev,
> +			"the string length of (sd.name + of_node->name) is too long.\n");

This looks like random error handling. You had goto in previous cases.

> +		return -EINVAL;
> +	}
> +	strncat(gc08a3->sd.name, " ", 1);
> +	strncat(gc08a3->sd.name, dev->of_node->name,
> +		V4L2_SUBDEV_NAME_SIZE - strlen(gc08a3->sd.name) - 2);
> +	dev_dbg(&client->dev, "after: gc08a3->sd.name: %s\n", gc08a3->sd.name);
> +
> +	ret = media_entity_pads_init(&gc08a3->sd.entity, 1, &gc08a3->pad);
> +	if (ret < 0) {
> +		dev_err(dev, "could not register media entity\n");
> +		goto free_ctrl;
> +	}
> +
> +	ret = v4l2_async_register_subdev_sensor(&gc08a3->sd);
> +	if (ret < 0) {
> +		dev_err(dev, "could not register v4l2 device\n");
> +		goto free_entity;
> +	}
> +
> +	pm_runtime_set_active(gc08a3->dev);
> +	pm_runtime_enable(gc08a3->dev);
> +	pm_runtime_idle(gc08a3->dev);
> +
> +	dev_info(dev, "--- %s -", __func__);

No, drop such silly debug messages.

> +
> +	return 0;
> +
> +free_entity:
> +	media_entity_cleanup(&gc08a3->sd.entity);
> +free_ctrl:
> +	mutex_destroy(&gc08a3->mutex);
> +	v4l2_ctrl_handler_free(&gc08a3->ctrls);
> +	pm_runtime_disable(gc08a3->dev);
> +
> +	return ret;
> +}
> +
> +static void gc08a3_remove(struct i2c_client *client)
> +{
> +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
> +	struct gc08a3 *gc08a3 = to_gc08a3(sd);
> +
> +	v4l2_async_unregister_subdev(&gc08a3->sd);
> +	media_entity_cleanup(&gc08a3->sd.entity);
> +	v4l2_ctrl_handler_free(&gc08a3->ctrls);
> +
> +	pm_runtime_disable(&client->dev);
> +	pm_runtime_set_suspended(&client->dev);
> +
> +	mutex_destroy(&gc08a3->mutex);
> +}
> +
> +static const struct of_device_id gc08a3_of_match[] = {
> +	{ .compatible = "GalaxyCore,gc08a3" },
> +	{}
> +};
> +MODULE_DEVICE_TABLE(of, gc08a3_of_match);
> +
> +static const struct dev_pm_ops gc08a3_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(gc08a3_suspend, gc08a3_resume)
> +		SET_RUNTIME_PM_OPS(gc08a3_power_off, gc08a3_power_on, NULL)

Fix indentation.

This code has very pooro quality. I suggest you to do first internal
review to avoid commenting on trivial errors and using community
resources for this.


Best regards,
Krzysztof

