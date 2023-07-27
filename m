Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 129F2765360
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 14:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233809AbjG0MNy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 08:13:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbjG0MNw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 08:13:52 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1B22D6A
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:13:47 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-99bcc0adab4so119423166b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 05:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690460026; x=1691064826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2mH+Rp4hSfnfzF/tM/KbcwfyGEwPjJ6t1DC9fcpN9vs=;
        b=ULSIU0yhJ878Y/H7wl/vpxvHi5mUdrRaM9uzsVLLNJB1UZr97BZEzMrhZFmMGFDkNh
         l/LPI3x4SP/pfKtk6Lk2ouk1ZZrQIpB4OBk4gaYtV6heVaWKLbJc/e2bEVqaC0dVhQNk
         bbAAaK9gXR6sUhFHWm0ID6CmcLraEIadZ6fEDNAJMzIrqCiIqFtxy0dnre3xqrc5L8L9
         fssUUNom/Hir5FY6BVjYQmW+Pr/bJgVpt4obun4yuyKyZznbsW/DP3V1hCZg8CwsyYzy
         yq8amupcCMsW1Dsk5FEyTtjlJc/1dHIQhPp9U+/doOkJQTc9EYvuLjZ9aLRuQrx6WycC
         qJMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690460026; x=1691064826;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2mH+Rp4hSfnfzF/tM/KbcwfyGEwPjJ6t1DC9fcpN9vs=;
        b=I1NszbjA8poykeJczYJ7nmqG13VJNCfsJNzKiEgBjGTMEQhRnlf1+5s1HI3JPgQ9ip
         yxBYjm1NdtBF4Yxn0p6aSK+85sytKZri3TBorZ/ix6KAq/J8xGfJINMsV2AegXcf2cZl
         dLxHAFlbbvXkjSAvgIAeeokNneR5PvXrUXaOQRugUkc1pH0ryq4c48MTqaKQpzAPdgxC
         zwJ2bFACOjPd2PrDQWwLdyUNQDXbOUcLbaTqEcLrc62ACZiKU5+gvTqnSEyTZbLPgUvu
         0lqwTgMn5BpfYgQk5GTxUg0gJgHeufQJRw+LGWRYlK5IVugJ6pbA7oCcsF2/p/RDKQE9
         k7Aw==
X-Gm-Message-State: ABy/qLZUOdupML+Hh0oEO669SMiOkxAFGAiBp6wQ62Q/d6YQYSaaza9p
        IyRGqJcNtI+ZUa0qa+8T9Cmj3g==
X-Google-Smtp-Source: APBJJlFtTydzjExxCW2N0thWNf60e/JzMuJjuuZISZRxsnDyWezae/QKskV4QnPmRVwurLShFjR1mg==
X-Received: by 2002:a17:906:84:b0:994:539d:f97f with SMTP id 4-20020a170906008400b00994539df97fmr2048729ejc.37.1690460025986;
        Thu, 27 Jul 2023 05:13:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id m15-20020a17090607cf00b00993159ce075sm688182ejc.210.2023.07.27.05.13.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 05:13:45 -0700 (PDT)
Message-ID: <ef4825d6-1016-cbf2-0cd3-94b0fc4165f4@linaro.org>
Date:   Thu, 27 Jul 2023 14:13:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 2/2] media: imagination: Add E5010 JPEG Encoder driver
Content-Language: en-US
To:     Devarsh Thakkar <devarsht@ti.com>, mchehab@kernel.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, hverkuil-cisco@xs4all.nl,
        laurent.pinchart@ideasonboard.com, eugen.hristev@collabora.com,
        ezequiel@vanguardiasur.com.ar, u.kleine-koenig@pengutronix.de,
        sakari.ailus@linux.intel.com, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     praneeth@ti.com, nm@ti.com, vigneshr@ti.com, a-bhatia1@ti.com,
        j-luthra@ti.com, b-brnich@ti.com, detheridge@ti.com,
        p-mantena@ti.com, vijayp@ti.com
References: <20230727112546.2201995-1-devarsht@ti.com>
 <20230727112546.2201995-3-devarsht@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230727112546.2201995-3-devarsht@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 13:25, Devarsh Thakkar wrote:
> This adds support for stateful V4L2 M2M based driver
> for Imagination E5010 JPEG Encoder [1] which supports baseline
> encoding with two different quantization tables and compression
> ratio as demanded.
> 
> Support for both contigous and non-contigous YUV420 and YUV422
> semiplanar formats is added along with alignment restrictions
> as required by the hardware.
> 
> System and runtime PM hooks are added in the driver along with v4l2
> crop and selection API support.
> 
> Minimum resolution supported is 64x64 and
> Maximum resolution supported is 8192x8192.
> 


...

> +
> +static int e5010_release(struct file *file)
> +{
> +	struct e5010_dev *dev = video_drvdata(file);
> +	struct e5010_context *ctx = file->private_data;
> +
> +	dprintk(dev, 1, "Releasing instance: 0x%p, m2m_ctx: 0x%p\n", ctx, ctx->fh.m2m_ctx);

Why do you print pointers? Looks like code is buggy and you still keep
debugging it.

> +	mutex_lock(&dev->mutex);
> +	v4l2_ctrl_handler_free(&ctx->ctrl_handler);
> +	v4l2_m2m_ctx_release(ctx->fh.m2m_ctx);
> +	v4l2_fh_del(&ctx->fh);
> +	v4l2_fh_exit(&ctx->fh);
> +	kfree(ctx);
> +	mutex_unlock(&dev->mutex);
> +
> +	return 0;
> +}
> +

...

> +static int e5010_init_device(struct e5010_dev *dev)
> +{
> +	int ret = 0;
> +
> +	/*TODO: Set MMU in bypass mode until support for the same is added in driver*/
> +	e5010_hw_bypass_mmu(dev->mmu_base, 1);
> +
> +	if (e5010_hw_enable_auto_clock_gating(dev->jasper_base, 1))
> +		dev_warn(dev->dev, "Failed to enable auto clock gating\n");
> +
> +	if (e5010_hw_enable_manual_clock_gating(dev->jasper_base, 0))
> +		dev_warn(dev->dev, "Failed to disable manual clock gating\n");
> +
> +	if (e5010_hw_enable_crc_check(dev->jasper_base, 0))
> +		dev_warn(dev->dev, "Failed to disable CRC check\n");
> +
> +	if (e5010_hw_enable_output_address_error_irq(dev->jasper_base, 1))
> +		dev_err(dev->dev, "Failed to enable Output Address Error interrupts\n");
> +
> +	ret = e5010_hw_set_input_source_to_memory(dev->jasper_base, 1);
> +	if (ret) {
> +		dev_err(dev->dev, "Failed to set input source to memory\n");
> +		goto fail;

retturn ret;

> +	}
> +
> +	ret = e5010_hw_enable_picture_done_irq(dev->jasper_base, 1);
> +	if (ret)
> +		dev_err(dev->dev, "Failed to enable Picture Done interrupts\n");
> +fail:
> +	return ret;
> +}
> +
> +static int e5010_probe(struct platform_device *pdev)
> +{
> +	const struct of_device_id *of_dev_id;
> +	struct e5010_dev *dev;

dev is struct device, so call it differently.

> +	struct resource *res;
> +	int irq, ret = 0;
> +
> +	of_dev_id = of_match_device(e5010_of_match, &pdev->dev);
> +	if (!of_dev_id) {
> +		dev_err(&pdev->dev, "%s: Unable to match device\n", __func__);

I don't think this can happen.

> +		return -ENODEV;
> +	}
> +
> +	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(32));
> +	if (ret) {
> +		dev_err(&pdev->dev, "32-bit consistent DMA enable failed\n");
> +		return ret;
> +	}
> +
> +	dev = devm_kzalloc(&pdev->dev, sizeof(*dev), GFP_KERNEL);
> +	if (!dev)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, dev);
> +
> +	dev->dev = &pdev->dev;
> +
> +	mutex_init(&dev->mutex);
> +	spin_lock_init(&dev->hw_lock);
> +
> +	dev->vdev = &e5010_videodev;
> +	dev->vdev->v4l2_dev = &dev->v4l2_dev;
> +	dev->vdev->lock = &dev->mutex;
> +	dev->vdev->queue = NULL;
> +	dev->vdev->prio = NULL;
> +	dev->vdev->dev_parent = NULL;
> +	dev->vdev->minor = -1;
> +
> +	ret = v4l2_device_register(&pdev->dev, &dev->v4l2_dev);
> +	if (ret) {
> +		dev_err(dev->dev, "Failed to register v4l2 device\n");
> +		return ret;

return dev_err_probe

> +	}
> +
> +	dev->m2m_dev = v4l2_m2m_init(&e5010_m2m_ops);
> +	if (!dev->m2m_dev) {

This cannot happen. Read the function.

> +		dev_err(dev->dev, "Failed to initialize m2m device\n");
> +		ret = -ENOMEM;
> +		goto fail_after_v4l2_register;
> +	}
> +
> +	video_set_drvdata(dev->vdev, dev);
> +
> +	ret = video_register_device(dev->vdev, VFL_TYPE_VIDEO, 0);
> +	if (ret) {
> +		dev_err(dev->dev, "Failed to register video device\n");
> +		ret = -ENOMEM;

Why?

> +		goto fail_after_v4l2_register;
> +	}
> +
> +	dev_info(dev->dev, "Device registered as /dev/video%d\n",
> +		 dev->vdev->num);
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regjasper");
> +	if (!res) {
> +		dev_err(dev->dev, "Missing 'regjasper' resources area\n");
> +		ret = -ENOMEM;
> +		goto fail_after_video_register_device;
> +	}
> +	dev->jasper_base = devm_ioremap_resource(&pdev->dev, res);

Use helper function to combine two calls into one.

> +	if (!dev->jasper_base) {
> +		ret = -ENOMEM;

This shouldn't be ENOMEM

> +		goto fail_after_video_register_device;
> +	}
> +
> +	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "regmmu");
> +	if (!res) {
> +		dev_err(dev->dev, "Missing 'regmmu' resources area\n");
> +		ret = -ENOMEM;
> +		goto fail_after_video_register_device;
> +	}
> +	dev->mmu_base = devm_ioremap_resource(&pdev->dev, res);
> +	if (!dev->mmu_base) {
> +		ret = -ENOMEM;

The same.

> +		goto fail_after_video_register_device;
> +	}
> +
> +	dev->last_context_run = NULL;
> +
> +	irq = platform_get_irq(pdev, 0);
> +	ret = devm_request_irq(dev->dev, irq, e5010_irq, 0,
> +			       E5010_MODULE_NAME, dev);
> +	if (ret) {
> +		dev_err(dev->dev, "Failed to register IRQ %d\n", irq);
> +		goto fail_after_video_register_device;
> +	}
> +
> +	dev->clk = devm_clk_get(&pdev->dev, "core_clk");
> +	if (IS_ERR(dev->clk)) {
> +		dev_err(dev->dev, "failed to get clock\n");
> +		ret = PTR_ERR(dev->clk);

ret = dev_err_probe

> +		goto fail_after_video_register_device;
> +	}
> +
> +	pm_runtime_enable(dev->dev);
> +
> +	return 0;
> +
> +fail_after_video_register_device:
> +	v4l2_m2m_release(dev->m2m_dev);
> +fail_after_v4l2_register:
> +	v4l2_device_unregister(&dev->v4l2_dev);
> +	return ret;
> +}
> +
> +static int e5010_remove(struct platform_device *pdev)
> +{
> +	struct e5010_dev *dev = platform_get_drvdata(pdev);
> +
> +	pm_runtime_disable(dev->dev);
> +	video_unregister_device(dev->vdev);
> +	v4l2_m2m_release(dev->m2m_dev);
> +	v4l2_device_unregister(&dev->v4l2_dev);
> +
> +	return 0;
> +}

...

> +#define MAX_PLANES			2
> +#define HEADER_SIZE			0x025E
> +#define MIN_DIMENSION			64
> +#define MAX_DIMENSION			8192
> +#define DEFAULT_WIDTH			640
> +#define DEFAULT_HEIGHT			480
> +#define E5010_MODULE_NAME		"e5010"
> +
> +/* JPEG marker definitions */
> +#define START_OF_IMAGE			0xFFD8
> +#define SOF_BASELINE_DCT		0xFFC0
> +#define END_OF_IMAGE			0xFFD9
> +#define START_OF_SCAN			0xFFDA
> +
> +/* Definitions for the huffman table specification in the Marker segment */
> +#define DHT_MARKER			0xFFC4
> +#define LH_DC				0x001F
> +#define LH_AC				0x00B5
> +
> +/* Definitions for the quantization table specification in the Marker segment */
> +#define DQT_MARKER			0xFFDB
> +#define ACMAX				0x03FF
> +#define DCMAX				0x07FF
> +
> +/* Length and precision of the quantization table parameters */
> +#define LQPQ				0x00430
> +#define QMAX				255
> +
> +/* Misc JPEG header definitions */
> +#define UC_NUM_COMP			3
> +#define PRECISION			8
> +#define HORZ_SAMPLING_FACTOR		(2 << 4)
> +#define VERT_SAMPLING_FACTOR_422	1
> +#define VERT_SAMPLING_FACTOR_420	2
> +#define COMPONENTS_IN_SCAN		3
> +#define PELS_IN_BLOCK			64
> +
> +/* Used for Qp table generation */
> +#define LUMINOSITY			10
> +#define CONTRAST			1
> +#define INCREASE			2
> +#define QP_TABLE_SIZE			(8 * 8)
> +#define QP_TABLE_FIELD_OFFSET		0x04
> +
> +/*
> + * vb2 queue structure
> + * contains queue data information
> + *
> + * @fmt: format info
> + * @width: frame width
> + * @height: frame height
> + * @bytesperline: bytes per line in memory
> + * @size_image: image size in memory
> + */
> +struct e5010_q_data {
> +	struct e5010_fmt *fmt;
> +	u32 width;
> +	u32 height;
> +	u32 width_adjusted;
> +	u32 height_adjusted;
> +	u32 sizeimage[MAX_PLANES];
> +	u32 bytesperline[MAX_PLANES];
> +	bool format_set;
> +	bool streaming;
> +	u32			sequence;
> +	struct v4l2_rect	crop;

Unexpected indentation.

> +};
> +
> +/*
> + * Driver device structure
> + * Holds all memory handles and global parameters
> + * Shared by all instances
> + */
> +struct e5010_dev {
> +	struct device *dev;
> +	struct v4l2_device v4l2_dev;
> +	struct v4l2_m2m_dev *m2m_dev;
> +	struct video_device *vdev;
> +	void __iomem *jasper_base;
> +	void __iomem *mmu_base;
> +	struct clk   *clk;

Please keep style consistent.

> +	struct e5010_context *last_context_run;
> +	/* Protect access to device data */
> +	struct mutex mutex;
> +	/* Protect access to hardware*/
> +	spinlock_t hw_lock;
> +};
> +


Best regards,
Krzysztof

