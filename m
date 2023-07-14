Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E23C753487
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jul 2023 10:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbjGNID2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jul 2023 04:03:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234735AbjGNIC7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jul 2023 04:02:59 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE14C3581
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:00:27 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51e344efd75so3245495a12.1
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jul 2023 01:00:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689321626; x=1691913626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hhIEaZT66fpgOrz7emi75FsAfVnGXApsKGJmEeC5HNM=;
        b=qMYVT9o8N49LnyLccxc5EzVogUYRt2wP/EAEH8rFgGXfHiVoJK25hX5emK8VALfm/3
         RRErlGglhdF8X7RyoN+Gz9EucNdXmml+awz3ZNPPKDW92XcoIPYGiyIwQ2rY1fN8GdAA
         ZLhPFn/trk9lpiUrs89IDqdnkn2gfPEjPOVU6Y0qwwR7Ih3asBEteRE7JaK/ieueE9PC
         sreYXT8BoCm54dHAa1mdhE4M7R36dxdN1rDNhyqEJtiSC8Z1U53s1OcVEVzf8D7wLLE8
         JxccKBAafM5xSBT6WVTbBlV/SOwnp5/2vF+vRJenC4jrKhByyQNR/syNCHVkLW1uPEG3
         T8NQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689321626; x=1691913626;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hhIEaZT66fpgOrz7emi75FsAfVnGXApsKGJmEeC5HNM=;
        b=TKAv7caehE33kXtfBn3ttpubjctoPfc9LHTkHR9+TGRhzJ4BM3Aa4v1mi7rcwMWp60
         hgmkD81jDh5N4cr0NvnLMLO+WHcXAtFs/zt8ib0ih+V/Q95F/B6wd0h2eghbZ92yMkt4
         DUqUS+cDRWNcDk8piVthz+sikWPfuJh8UhbQ44W8mqCutiXYpyZHEj5bX6bLKa+ml1cp
         fgfU4KLBKQwupTtxXRGHbIU/70Od7Suv+vi/uIOKrhLYGmmXvbueV9QEwzlKmrkgQB2+
         Ca4V8qZSRgdpBDMdHkiywvuITZJZhQnXOwpPIfvWk8CWZcxGeG0S2VstISwGG/EEX3c+
         uG/w==
X-Gm-Message-State: ABy/qLYA0FvL4XIAp45tw4FAcOjM74iNabhuJr5gymlxXJw5iZudPxbA
        tUsui8JYWj3/5cuXxBKvFE+u6w==
X-Google-Smtp-Source: APBJJlHuuFhssaTeRZ/9vCODR9ZcDG6llqQ10STvCGNK4bwPUEjcp9uDRzpgitEg6C0iQVneHKPsIQ==
X-Received: by 2002:a05:6402:35b:b0:51d:a012:ec2 with SMTP id r27-20020a056402035b00b0051da0120ec2mr2277963edw.3.1689321626412;
        Fri, 14 Jul 2023 01:00:26 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id x19-20020aa7dad3000000b0051e28d315a2sm5358978eds.78.2023.07.14.01.00.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jul 2023 01:00:25 -0700 (PDT)
Message-ID: <0d0cec7f-030f-ebc1-11f0-06214197a351@linaro.org>
Date:   Fri, 14 Jul 2023 10:00:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v7 2/5] media: platform: visconti: Add Toshiba Visconti
 Video Input Interface driver
Content-Language: en-US
To:     Yuji Ishikawa <yuji2.ishikawa@toshiba.co.jp>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Sakari Ailus <sakari.ailus@iki.fi>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Nobuhiro Iwamatsu <nobuhiro1.iwamatsu@toshiba.co.jp>,
        Mark Brown <broonie@kernel.org>
Cc:     linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230714015059.18775-1-yuji2.ishikawa@toshiba.co.jp>
 <20230714015059.18775-3-yuji2.ishikawa@toshiba.co.jp>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230714015059.18775-3-yuji2.ishikawa@toshiba.co.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/07/2023 03:50, Yuji Ishikawa wrote:
> Add support to Video Input Interface on Toshiba Visconti ARM SoCs.
> The interface device includes CSI2 Receiver,
> frame grabber, video DMAC and image signal processor.
> 
> A driver instance provides three /dev/videoX device files;
> one for RGB image capture, another one for optional RGB capture
> with different parameters and the last one for RAW capture.
> 

...

> +static int visconti_viif_parse_dt(struct viif_device *viif_dev)
> +{
> +	struct device_node *of = viif_dev->dev->of_node;
> +	struct v4l2_fwnode_endpoint fw_ep;
> +	struct viif_subdev *viif_sd;
> +	struct device_node *ep;
> +	unsigned int i;
> +	int num_ep;
> +	int ret;
> +
> +	memset(&fw_ep, 0, sizeof(struct v4l2_fwnode_endpoint));

Why you cannot initialize it in declaration? = { 0 }?

> +
> +	num_ep = of_graph_get_endpoint_count(of);
> +	if (!num_ep)
> +		return -ENODEV;
> +
> +	ret = visconti_viif_init_async_subdevs(viif_dev, num_ep);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < num_ep; i++) {
> +		ep = of_graph_get_endpoint_by_regs(of, 0, i);
> +		if (!ep) {
> +			dev_err(viif_dev->dev, "No subdevice connected on endpoint %u.\n", i);
> +			ret = -ENODEV;
> +			goto error_put_node;
> +		}
> +
> +		ret = v4l2_fwnode_endpoint_parse(of_fwnode_handle(ep), &fw_ep);
> +		if (ret) {
> +			dev_err(viif_dev->dev, "Unable to parse endpoint #%u.\n", i);
> +			goto error_put_node;
> +		}
> +
> +		if (fw_ep.bus_type != V4L2_MBUS_CSI2_DPHY ||
> +		    fw_ep.bus.mipi_csi2.num_data_lanes == 0) {
> +			dev_err(viif_dev->dev, "missing CSI-2 properties in endpoint\n");
> +			ret = -EINVAL;
> +			goto error_put_node;
> +		}
> +
> +		/* Setup the ceu subdevice and the async subdevice. */
> +		viif_sd = &viif_dev->subdevs[i];
> +		INIT_LIST_HEAD(&viif_sd->asd.list);
> +
> +		viif_sd->num_lane = fw_ep.bus.mipi_csi2.num_data_lanes;
> +		viif_sd->asd.match_type = V4L2_ASYNC_MATCH_FWNODE;
> +		viif_sd->asd.match.fwnode =
> +			fwnode_graph_get_remote_port_parent(of_fwnode_handle(ep));
> +
> +		viif_dev->asds[i] = &viif_sd->asd;
> +		of_node_put(ep);
> +	}
> +
> +	return num_ep;
> +
> +error_put_node:
> +	of_node_put(ep);
> +	return ret;
> +}
> +
> +static const struct of_device_id visconti_viif_of_table[] = {
> +	{
> +		.compatible = "toshiba,visconti5-viif",
> +	},
> +	{},
> +};
> +MODULE_DEVICE_TABLE(of, visconti_viif_of_table);
> +
> +#define NUM_IRQS   3
> +#define IRQ_ID_STR "viif"
> +
> +static int visconti_viif_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct viif_device *viif_dev;
> +	dma_addr_t tables_dma;
> +	int ret, i, num_sd;
> +
> +	ret = dma_set_mask_and_coherent(dev, DMA_BIT_MASK(36));
> +	if (ret)
> +		return ret;
> +
> +	viif_dev = devm_kzalloc(dev, sizeof(*viif_dev), GFP_KERNEL);
> +	if (!viif_dev)
> +		return -ENOMEM;
> +
> +	platform_set_drvdata(pdev, viif_dev);
> +	viif_dev->dev = dev;
> +
> +	spin_lock_init(&viif_dev->regbuf_lock);
> +	mutex_init(&viif_dev->pow_lock);
> +	mutex_init(&viif_dev->stream_lock);
> +
> +	viif_dev->capture_reg = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(viif_dev->capture_reg))
> +		return PTR_ERR(viif_dev->capture_reg);
> +
> +	viif_dev->csi2host_reg = devm_platform_ioremap_resource(pdev, 1);
> +	if (IS_ERR(viif_dev->csi2host_reg))
> +		return PTR_ERR(viif_dev->csi2host_reg);
> +
> +	viif_dev->hwaif_reg = devm_platform_ioremap_resource(pdev, 2);
> +	if (IS_ERR(viif_dev->hwaif_reg))
> +		return PTR_ERR(viif_dev->hwaif_reg);
> +
> +	viif_dev->mpu_reg = devm_platform_ioremap_resource(pdev, 3);
> +	if (IS_ERR(viif_dev->mpu_reg))
> +		return PTR_ERR(viif_dev->mpu_reg);
> +
> +	viif_dev->run_flag_main = false;
> +
> +	for (i = 0; i < NUM_IRQS; i++) {
> +		ret = platform_get_irq(pdev, i);
> +		if (ret < 0) {
> +			dev_err(dev, "failed to acquire irq resource\n");
> +			return ret;

return dev_err_probe()

> +		}
> +		viif_dev->irq[i] = ret;
> +		ret = devm_request_irq(dev, viif_dev->irq[i], visconti_viif_irq, 0, IRQ_ID_STR,
> +				       viif_dev);
> +		if (ret) {
> +			dev_err(dev, "irq request failed\n");

return dev_err_probe()

> +			return ret;
> +		}
> +	}
> +
> +	viif_dev->tables =
> +		dma_alloc_wc(dev, sizeof(struct viif_table_area), &tables_dma, GFP_KERNEL);
> +	if (!viif_dev->tables) {
> +		dev_err(dev, "dma_alloc_wc failed\n");

Are you sure DMA memory allocation errors shall be printed?

> +		return -ENOMEM;
> +	}
> +	viif_dev->tables_dma = (struct viif_table_area *)tables_dma;
> +
> +	/* power control */

Drop the comment, it is useless.

> +	pm_runtime_enable(dev);
> +
> +	/* build media_dev */
> +	viif_dev->media_dev.hw_revision = 0;
> +	strscpy(viif_dev->media_dev.model, VIIF_DRIVER_NAME, sizeof(viif_dev->media_dev.model));
> +	viif_dev->media_dev.dev = dev;
> +	/* TODO: platform:visconti-viif-0,1,2,3 for each VIIF driver instance */
> +	snprintf(viif_dev->media_dev.bus_info, sizeof(viif_dev->media_dev.bus_info), "%s-0",
> +		 VIIF_BUS_INFO_BASE);
> +	media_device_init(&viif_dev->media_dev);
> +
> +	/* build v4l2_dev */
> +	viif_dev->v4l2_dev.mdev = &viif_dev->media_dev;
> +	ret = v4l2_device_register(dev, &viif_dev->v4l2_dev);
> +	if (ret)
> +		goto error_dma_free;
> +
> +	ret = media_device_register(&viif_dev->media_dev);
> +	if (ret) {
> +		dev_err(dev, "Failed to register media device: %d\n", ret);
> +		goto error_v4l2_unregister;

dev_err_probe

> +	}
> +
> +	ret = visconti_viif_csi2rx_register(viif_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to register csi2rx sub node: %d\n", ret);

dev_err_probe


> +		goto error_media_unregister;
> +	}
> +
> +	ret = visconti_viif_isp_register(viif_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to register isp sub node: %d\n", ret);

dev_err_probe


> +		goto error_media_unregister;
> +	}
> +	ret = visconti_viif_capture_register(viif_dev);
> +	if (ret) {
> +		dev_err(dev, "failed to register capture node: %d\n", ret);

dev_err_probe

> +		goto error_media_unregister;
> +	}
> +
> +	/* handle subdevices in device tree */
> +	num_sd = visconti_viif_parse_dt(viif_dev);
> +	if (ret < 0) {
> +		ret = num_sd;

ret = dev_err_probe

> +		goto error_media_unregister;
> +	}
> +
> +	viif_dev->notifier.v4l2_dev = &viif_dev->v4l2_dev;
> +	v4l2_async_nf_init(&viif_dev->notifier);
> +	for (i = 0; i < num_sd; i++)
> +		__v4l2_async_nf_add_subdev(&viif_dev->notifier, viif_dev->asds[i]);
> +	viif_dev->notifier.ops = &viif_notify_ops;
> +	ret = v4l2_async_nf_register(&viif_dev->v4l2_dev, &viif_dev->notifier);
> +	if (ret)
> +		goto error_media_unregister;
> +
> +	viif_dev->wq = create_workqueue("visconti-viif");
> +	if (!viif_dev->wq)
> +		return -ENOMEM;

No error cleanup?

> +	INIT_WORK(&viif_dev->work, visconti_viif_wthread_l1info);
> +
> +	return 0;
> +
> +error_media_unregister:
> +	media_device_unregister(&viif_dev->media_dev);
> +error_v4l2_unregister:
> +	v4l2_device_unregister(&viif_dev->v4l2_dev);
> +error_dma_free:
> +	pm_runtime_disable(dev);
> +	dma_free_wc(&pdev->dev, sizeof(struct viif_table_area), viif_dev->tables,
> +		    (dma_addr_t)viif_dev->tables_dma);
> +	return ret;
> +}
> +
> +static int visconti_viif_remove(struct platform_device *pdev)
> +{
> +	struct viif_device *viif_dev = platform_get_drvdata(pdev);
> +
> +	destroy_workqueue(viif_dev->wq);
> +	visconti_viif_isp_unregister(viif_dev);
> +	visconti_viif_capture_unregister(viif_dev);
> +	v4l2_async_nf_unregister(&viif_dev->notifier);

Why these three are not called in probe error paths?

> +	media_device_unregister(&viif_dev->media_dev);
> +	v4l2_device_unregister(&viif_dev->v4l2_dev);
> +	pm_runtime_disable(&pdev->dev);
> +	dma_free_wc(&pdev->dev, sizeof(struct viif_table_area), viif_dev->tables,
> +		    (dma_addr_t)viif_dev->tables_dma);
> +
> +	return 0;
> +}
> +
> +static int visconti_viif_runtime_suspend(struct device *dev)
> +{
> +	/* This callback is kicked when the last device-file is closed */
> +	struct viif_device *viif_dev = dev_get_drvdata(dev);
> +
> +	mutex_lock(&viif_dev->pow_lock);

Why?

> +	visconti_viif_hw_off(viif_dev);
> +	mutex_unlock(&viif_dev->pow_lock);
> +
> +	return 0;
> +}
> +
> +static int visconti_viif_runtime_resume(struct device *dev)
> +{
> +	/* This callback is kicked when the first device-file is opened */
> +	struct viif_device *viif_dev = dev_get_drvdata(dev);
> +
> +	viif_dev->rawpack_mode = (u32)VIIF_RAWPACK_DISABLE;
> +
> +	mutex_lock(&viif_dev->pow_lock);

Why?

> +
> +	/* Initialize HWD driver */
> +	visconti_viif_hw_on(viif_dev);
> +
> +	/* VSYNC mask setting of MAIN unit */
> +	viif_main_vsync_set_irq_mask(viif_dev, MASK_INT_M_SYNC_MASK_SET);
> +
> +	/* STATUS error mask setting of MAIN unit */
> +	viif_main_status_err_set_irq_mask(viif_dev, MASK_INT_M_DELAY_INT_ERROR);
> +
> +	/* VSYNC mask settings of SUB unit */
> +	viif_sub_vsync_set_irq_mask(viif_dev, MASK_INT_S_SYNC_MASK_SET);
> +
> +	/* STATUS error mask setting(unmask) of SUB unit */
> +	viif_sub_status_err_set_irq_mask(viif_dev,
> +					 MASK_INT_S_RESERVED_SET | MASK_INT_S_DELAY_INT_ERROR);
> +
> +	mutex_unlock(&viif_dev->pow_lock);
> +
> +	return 0;
> +}
> +

Best regards,
Krzysztof

