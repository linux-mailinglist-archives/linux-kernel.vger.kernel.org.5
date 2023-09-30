Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC82D7B416F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 17:04:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234396AbjI3PEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 11:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234377AbjI3PEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 11:04:33 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BDD8BD
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 08:04:30 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-533f193fc8dso15270520a12.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 08:04:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696086268; x=1696691068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cHgLhVHDgOAlF4wu9DFadd8d0WYR6p1ep8mvPGVkL/s=;
        b=FrdzB8g+re0degGX2AsGA4uVjvLQBOOONu1J5mHRfqQKJjEZVji94Q/rRvD5zAkfDK
         4z/pJbOWpj74ObF2M8eJ/IXB7RlRvFyh1zRzrRGvQ1KvtzAWbTZ0Ud5obuyQnetmV//M
         gHDUSgXJoqVv9CxI+Hc7kOqRUXzKrbDeD4I9nDxEDjLqf0XWnEZlcvZf47FQNi/Hc7a7
         JYgaFXlDE44b7gQe6OP3AGogifQnpEtCxqXeTjNSFcQ9Sv5gexKJwT1VmYLX56x+6XzA
         Eo3yTpg+qYM+6JFLwCoe2lZ94FYg7P+HRGil1tUhXqGICoTCEaWkVzwjCPSndv5lIa7K
         IYhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696086268; x=1696691068;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cHgLhVHDgOAlF4wu9DFadd8d0WYR6p1ep8mvPGVkL/s=;
        b=cvgBR8fDnUg0W+lW5tTW3d8Kb4PhF1GFr0VH9GcfCA6L60k9LEspND2N7s+CvYMpGN
         E7XQZ6G6dDtbqU77eABTnN0zisy3YryOhdbPT6grjnedXgNoVJ3T45RtafutfipUThoR
         XPPdr24RXp5puTt1wFn98MxnXC0M90VeBCOndI6iS1+CKiH8k+SNlnXvr+LR4rBZDl3f
         NPS3akGu/lzt8Od2aKCwDUO+x1v8uThk5ftsSyeq5mPJl5HzYDm/LvhCE8LUQSVvY4Nc
         tm5tstJZC6OMMNVa5WDW2sM4641cgELGIqQvSb8hri3s6ckNcOVyPhkF0OtYPoc2HCDZ
         kLYw==
X-Gm-Message-State: AOJu0YxY8yHeUqrSTr5/sHfQj/X1PwUDq2EUz1WwKErevAfD4YgjmJK9
        ppoUv2DpTM7R+nmtDC0keMDSCqjIwoc4CU7620/q1g==
X-Google-Smtp-Source: AGHT+IHhRctQjp6SEkrLfgDpbelzW7ba1wtfB09VjYgl+5ev3gZPCEXIDBvesM/Ymznx/D35vZDtYg==
X-Received: by 2002:aa7:ca48:0:b0:522:38cb:d8cb with SMTP id j8-20020aa7ca48000000b0052238cbd8cbmr5845250edt.20.1696086268499;
        Sat, 30 Sep 2023 08:04:28 -0700 (PDT)
Received: from [192.168.8.76] ([88.154.47.206])
        by smtp.gmail.com with ESMTPSA id v10-20020aa7dbca000000b005330b2d1904sm12695228edt.71.2023.09.30.08.04.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Sep 2023 08:04:28 -0700 (PDT)
Message-ID: <51f4ac00-40c1-4dc2-9ab2-611f18462a84@linaro.org>
Date:   Sat, 30 Sep 2023 17:04:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/3] media: rockchip: Add a driver for Rockhip's camera
 interface
Content-Language: en-US
To:     Mehdi Djait <mehdi.djait@bootlin.com>, mchehab@kernel.org,
        heiko@sntech.de, ezequiel@vanguardiasur.com.ar,
        hverkuil-cisco@xs4all.nl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     paul.kocialkowski@bootlin.com, miquel.raynal@bootlin.com,
        maxime.chevallier@bootlin.com, luca.ceresoli@bootlin.com,
        thomas.petazzoni@bootlin.com, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, linux-rockchip@lists.infradead.org,
        devicetree@vger.kernel.org
References: <cover.1695981374.git.mehdi.djait@bootlin.com>
 <2214ee8c72a870360c8009441a7fab9a2ad01ce2.1695981374.git.mehdi.djait@bootlin.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <2214ee8c72a870360c8009441a7fab9a2ad01ce2.1695981374.git.mehdi.djait@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/09/2023 12:08, Mehdi Djait wrote:
> Introduce a driver for the camera interface on some Rockchip platforms.
> 
...

> +static const struct of_device_id rk_vip_plat_of_match[] = {
> +	{
> +		.compatible = "rockchip,px30-vip",
> +		.data = &px30_vip_match_data,
> +	},
> +	{},
> +};
> +
> +void rk_vip_soft_reset(struct rk_vip_device *vip_dev)
> +{
> +	reset_control_assert(vip_dev->vip_rst);
> +
> +	udelay(5);
> +
> +	reset_control_deassert(vip_dev->vip_rst);
> +}
> +
> +static int rk_vip_plat_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *match;
> +	struct device_node *node = pdev->dev.of_node;
> +	struct device *dev = &pdev->dev;
> +	struct v4l2_device *v4l2_dev;
> +	struct rk_vip_device *vip_dev;
> +	const struct vip_match_data *data;
> +	struct resource *res;
> +	int i, ret, irq;
> +
> +	match = of_match_node(rk_vip_plat_of_match, node);
> +	if (IS_ERR(match))

of_match_node does no return ERR_PTR.

> +		return PTR_ERR(match);
> +
> +	vip_dev = devm_kzalloc(dev, sizeof(*vip_dev), GFP_KERNEL);
> +	if (!vip_dev)
> +		return -ENOMEM;
> +
> +	dev_set_drvdata(dev, vip_dev);
> +	vip_dev->dev = dev;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	if (irq < 0)
> +		return irq;
> +
> +	ret = devm_request_irq(dev, irq, rk_vip_irq_pingpong, IRQF_SHARED,

Shared? With devm? This is error-prone pattern (as discussed few times
on the list). Are you 100% sure that all your use-cases are correct?

> +			       dev_driver_string(dev), dev);
> +	if (ret < 0) {
> +		dev_err(dev, "request irq failed: %d\n", ret);

return dev_err_probe

> +		return ret;
> +	}
> +
> +	vip_dev->irq = irq;
> +	data = match->data;
> +	vip_dev->chip_id = data->chip_id;
> +
> +	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
> +	vip_dev->base_addr = devm_ioremap_resource(dev, res);

Use wrapper for these two.

> +
> +	if (IS_ERR(vip_dev->base_addr))
> +		return PTR_ERR(vip_dev->base_addr);
> +
> +	for (i = 0; i < data->clks_num; i++)
> +		vip_dev->clks[i].id = data->clks[i];
> +
> +	vip_dev->num_clk = data->clks_num;
> +
> +	ret = devm_clk_bulk_get(dev, vip_dev->num_clk, vip_dev->clks);
> +	if (ret)
> +		return ret;
> +
> +	vip_dev->vip_rst = devm_reset_control_array_get(dev, false, false);
> +	if (IS_ERR(vip_dev->vip_rst))
> +		return PTR_ERR(vip_dev->vip_rst);
> +
> +	/* Initialize the stream */
> +	rk_vip_stream_init(vip_dev);
> +	strscpy(vip_dev->media_dev.model, "rk_vip",
> +		sizeof(vip_dev->media_dev.model));
> +	vip_dev->media_dev.dev = &pdev->dev;
> +	v4l2_dev = &vip_dev->v4l2_dev;
> +	v4l2_dev->mdev = &vip_dev->media_dev;
> +	strscpy(v4l2_dev->name, "rk_vip", sizeof(v4l2_dev->name));
> +
> +	ret = v4l2_device_register(vip_dev->dev, &vip_dev->v4l2_dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	media_device_init(&vip_dev->media_dev);
> +
> +	ret = media_device_register(&vip_dev->media_dev);
> +	if (ret < 0) {
> +		v4l2_err(v4l2_dev, "Failed to register media device: %d\n",
> +			 ret);
> +		goto err_unreg_v4l2_dev;
> +	}
> +
> +	/* create & register platform subdev (from of_node) */
> +	ret = rk_vip_register_platform_subdevs(vip_dev);
> +	if (ret < 0)
> +		goto err_unreg_media_dev;
> +
> +	vip_dev->sensor.std = V4L2_STD_NTSC;
> +	rk_vip_set_default_format(vip_dev);
> +	pm_runtime_enable(&pdev->dev);
> +
> +	return 0;
> +
> +err_unreg_media_dev:
> +	media_device_unregister(&vip_dev->media_dev);
> +err_unreg_v4l2_dev:
> +	v4l2_device_unregister(&vip_dev->v4l2_dev);
> +	return ret;
> +}
> +
> +static int rk_vip_plat_remove(struct platform_device *pdev)
> +{
> +	struct rk_vip_device *vip_dev = platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(&pdev->dev);
> +
> +	media_device_unregister(&vip_dev->media_dev);
> +	v4l2_device_unregister(&vip_dev->v4l2_dev);
> +	rk_vip_unregister_stream_vdev(vip_dev);
> +
> +	return 0;
> +}
> +
> +static int __maybe_unused rk_vip_runtime_suspend(struct device *dev)
> +{
> +	struct rk_vip_device *vip_dev = dev_get_drvdata(dev);
> +
> +	clk_bulk_disable_unprepare(vip_dev->num_clk, vip_dev->clks);
> +
> +	return pinctrl_pm_select_sleep_state(dev);
> +}
> +
> +static int __maybe_unused rk_vip_runtime_resume(struct device *dev)
> +{
> +	struct rk_vip_device *vip_dev = dev_get_drvdata(dev);
> +	int ret;
> +
> +	ret = pinctrl_pm_select_default_state(dev);
> +	if (ret < 0)
> +		return ret;
> +
> +	return clk_bulk_prepare_enable(vip_dev->num_clk, vip_dev->clks);
> +}
> +
> +static const struct dev_pm_ops rk_vip_plat_pm_ops = {
> +	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +				pm_runtime_force_resume)
> +	SET_RUNTIME_PM_OPS(rk_vip_runtime_suspend, rk_vip_runtime_resume, NULL)
> +};
> +
> +static struct platform_driver rk_vip_plat_drv = {
> +	.driver = {
> +		   .name = VIP_DRIVER_NAME,
> +		   .of_match_table = of_match_ptr(rk_vip_plat_of_match),

drop of_match_ptr, causes warnings in your code.


Best regards,
Krzysztof

