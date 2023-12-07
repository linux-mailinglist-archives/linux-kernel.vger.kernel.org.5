Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DFB68082BC
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Dec 2023 09:18:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378179AbjLGISq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Dec 2023 03:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231297AbjLGISZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Dec 2023 03:18:25 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D91D10F5
        for <linux-kernel@vger.kernel.org>; Thu,  7 Dec 2023 00:18:27 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-332f90a375eso624578f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Dec 2023 00:18:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701937106; x=1702541906; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QOiHdnlRFMkFDlB5kWfckw6pOd4LrZY+T64mekZ8KZ8=;
        b=Sc3utKT+faJf2RLKTIIMOjv8R1v8YBK0cF3zmWbZTvdz/+wXZ/zIfgL46XegSK/xYt
         EauILm49mpCX37ElX5alvBRy+VvMr16NAnfD0r+sldYntQ5n9XeIuH/zR0JFRJLJDH7z
         frvVEjuE2G/tqM+ESoC8yNojLxzKbSzkj7sd8S6O9MbsPEEw1gtC9xSFOd/Aa28FgAbs
         9IbWI9YsqOg4CZ+iTMl+Q4hysdc4aUZiOEjdJsIRyD75jpXI9XlJeAkrgi4iDdVKBzX8
         gD5CFEy7PAah6eWySgRhP2pjJzLl3/Tt/UKHpfKKPNBypq6IM7FBu5GbqKfqq5BHEBfT
         rz6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701937106; x=1702541906;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QOiHdnlRFMkFDlB5kWfckw6pOd4LrZY+T64mekZ8KZ8=;
        b=tf4OgpGkm2zUeYlCFAXUX+odzH9TpevxFU1W89lOqKy+zZHp9CWsJ2NQ8tVO2ExiI8
         QlPmx1IQaSwmIX2JPy+FL04f4uqzyVJxnD/HhSZW4GHmPEDAlWiJ0bs39r7Lz0s6AB59
         kgwIe+9lzTIM/vWZ7JSvBF+0bRxHZd+jOefLaqTqge4G4KXV35ulZuzcH8S6Lb4C9kTp
         o6aFvxu0HLNiWiAwb2RfbaAWzw3FpSEaaahfGkRwNxLihhI7019VHbWWnR6MthNeXORg
         5JKvt3XeiCXyssjpqU79nR2E03Gz2TqxC1iXEgvOW6nPta9VG31KFKAUljq2ciJ9RsFA
         uq1w==
X-Gm-Message-State: AOJu0YwfPw4EfrGnhWzCdQ6o/zON1rrriZWSidzJ3l/KmE2wZ2ovT0LV
        xaEL3IECSjMr0QsW+ZnVvZvgOw==
X-Google-Smtp-Source: AGHT+IG0Hqjq4jL95ujUQNv0S8dq6POI/VWfXbt1AkrXJOS/hFOqrD20mf12V0yHjuu6XI2Gf3wfZQ==
X-Received: by 2002:a05:600c:6985:b0:40c:ddd:5758 with SMTP id fp5-20020a05600c698500b0040c0ddd5758mr1451711wmb.12.1701937105870;
        Thu, 07 Dec 2023 00:18:25 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id o13-20020adfe80d000000b003333d46a9e8sm765592wrm.56.2023.12.07.00.18.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Dec 2023 00:18:25 -0800 (PST)
Message-ID: <1d58c2b9-4206-409c-b312-87f4fb649512@linaro.org>
Date:   Thu, 7 Dec 2023 09:18:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] media: i2c: Add GC08A3 image sensor driver
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
References: <20231207052016.25954-1-zhi.mao@mediatek.com>
 <20231207052016.25954-2-zhi.mao@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20231207052016.25954-2-zhi.mao@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/12/2023 06:20, Zhi Mao wrote:
> Add a V4L2 sub-device driver for Galaxycore GC08A3 image sensor.
> 
> Reviewed-By: yunkec@chromium.org

I don't see review given here:

https://lore.kernel.org/linux-media/20231123115104.32094-1-zhi.mao@mediatek.com/

This does not look like real review. Where was it performed? How
thorough was it? How many review iterations did it include?  Why there
is no name but anonymous review?



> Signed-off-by: Zhi Mao <zhi.mao@mediatek.com>
> ---
>  drivers/media/i2c/Kconfig  |   14 +
>  drivers/media/i2c/Makefile |    1 +
>  drivers/media/i2c/gc08a3.c | 1888 ++++++++++++++++++++++++++++++++++++
>  3 files changed, 1903 insertions(+)
>  create mode 100644 drivers/media/i2c/gc08a3.c
> 

...

> +static inline struct gc08a3 *to_gc08a3(struct v4l2_subdev *sd)
> +{
> +	return container_of(sd, struct gc08a3, sd);
> +}
> +
> +static int gc08a3_power_on(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
> +	struct gc08a3 *gc08a3 = to_gc08a3(sd);
> +	int ret;
> +
> +	gpiod_set_value_cansleep(gc08a3->enable_gpio, 0);

Why do you put make enable GPIO low? That's not how enable GPIO is
supposed to work...

> +	usleep_range(GC08A3_MIN_SLEEP_US, GC08A3_MAX_SLEEP_US);
> +
> +	ret = regulator_bulk_enable(GC08A3_NUM_SUPPLIES, gc08a3->supplies);
> +	if (ret < 0) {
> +		dev_err(gc08a3->dev, "failed to enable regulators: %d\n", ret);
> +		return ret;
> +	}
> +
> +	ret = clk_prepare_enable(gc08a3->xclk);
> +	if (ret < 0) {
> +		regulator_bulk_disable(GC08A3_NUM_SUPPLIES, gc08a3->supplies);
> +		dev_err(gc08a3->dev, "clk prepare enable failed\n");
> +		return ret;
> +	}
> +
> +	usleep_range(GC08A3_MIN_SLEEP_US, GC08A3_MAX_SLEEP_US);
> +
> +	gpiod_set_value_cansleep(gc08a3->enable_gpio, 1);
> +	usleep_range(GC08A3_MIN_SLEEP_US, GC08A3_MAX_SLEEP_US);
> +
> +	return 0;
> +}
> +
> +static int gc08a3_power_off(struct device *dev)
> +{
> +	struct i2c_client *client = to_i2c_client(dev);
> +	struct v4l2_subdev *sd = i2c_get_clientdata(client);
> +	struct gc08a3 *gc08a3 = to_gc08a3(sd);
> +
> +	gpiod_set_value_cansleep(gc08a3->enable_gpio, 0);

How making enable GPIO low is related to power off? Enable means you
turn on some feature, not shutdown. Look at common GPIO consumer
bindings in the kernel.


...

> +static int gc08a3_probe(struct i2c_client *client)
> +{
> +	struct device *dev = &client->dev;
> +	struct gc08a3 *gc08a3;
> +	int ret;
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
> +	if (IS_ERR(gc08a3->xclk))
> +		return dev_err_probe(dev, PTR_ERR(gc08a3->xclk),
> +					 "failed to get xclk\n");

Misaligned indentation

> +
> +	ret = clk_set_rate(gc08a3->xclk, GC08A3_DEFAULT_CLK_FREQ);
> +	if (ret)
> +		return dev_err_probe(dev, ret,
> +					 "failed to set xclk frequency\n");

Misaligned indentation

> +
> +	ret = gc08a3_get_regulators(dev, gc08a3);
> +	if (ret < 0)
> +		return dev_err_probe(dev, ret,
> +					 "failed to get regulators\n");

Misaligned indentation

> +
> +	gc08a3->enable_gpio = devm_gpiod_get(dev, "enable", GPIOD_OUT_LOW);
> +	if (IS_ERR(gc08a3->enable_gpio))
> +		return dev_err_probe(dev, PTR_ERR(gc08a3->enable_gpio),
> +					 "failed to get gpio\n");

Misaligned indentation... probably entire code is misaligned.


Best regards,
Krzysztof

