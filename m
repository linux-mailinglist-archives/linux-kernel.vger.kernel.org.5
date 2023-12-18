Return-Path: <linux-kernel+bounces-4250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C3EB8179DA
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 19:40:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B24D41C22C04
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Dec 2023 18:40:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D57D22091;
	Mon, 18 Dec 2023 18:40:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GMbvKZ1a"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46E41DDFB
	for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 18:40:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2cc7ba7d12eso2624761fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 Dec 2023 10:40:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1702924811; x=1703529611; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UUuQUJz43blsxMNNzN8yRPfJcYv8gwVoB5l6CN+d7vc=;
        b=GMbvKZ1alAf8tSb0ehibsDOQoBFjYhDxuy292/Wb7KaYkoWgQFKd/15Dl76pKfmZBY
         Vd8+HBcs/n/h3L+4JcJdjmBbdqlB9EeF8LzgUIbeRJQ3zd3/t7cYrcAkAS172hf5bNyh
         L7HPtLpeU8VJrIMHsPbUAH9u32gjE3/kN8l5WX5zSj69d1eDVjPPIgu19muEj8zL7VXO
         Ops3G9M/MwWs6HeNWuE+WCRIvmmzTlPbt6R7g0EVioPUVVreVK+Ld42ebMYxIU7CUFQm
         a6R1Uc5vmz7tfPdkeYdEX7fY1/ai8icAutBQkTypJTkD3AQtZUh4Fg+jlYAvOebIFgak
         8nHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702924811; x=1703529611;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UUuQUJz43blsxMNNzN8yRPfJcYv8gwVoB5l6CN+d7vc=;
        b=tC33zEInfhou66KkXzjrKkHJyInq/qyiaeIzlwvKChRBp0ggX8y5WFVJh/3WCcu+55
         WVmJzr6A8bhsbiHKITk8OZdu2wbeOh1utPUAUx2e/VuST2GQG3Qh4btZ1EV6K3f2F0wS
         324x3CXj4b5allkFknlDHKCu8PlX6pUEazHE4uDu8sLMdUl3seleYZ4S4+vbVaGk7Lxe
         bkxL1V8gx6SIdiooFDstdhfuzj2JnKXC5ekahaqQ+QvIBoICStmiDAFSRugn8VXJvCni
         f9prtBB5fHWf2WsaI7DswdchAh3NZDiEvNffZf8EMIh4pxpDLlAlvdRXgTHTY7It0gG7
         HTJw==
X-Gm-Message-State: AOJu0YxispoPrnTmqVoefTwPoFWHsiI6ZnKJpMtyFCBmzHNvg4Twew8k
	YRxVI+aThBtH8oQWrnbG4Zoxww==
X-Google-Smtp-Source: AGHT+IE6wY5yYOE9OiOBaKZfhtu33reO2Old2D50iLa8FUxyLqrUrvHf/I+McuDA4uv0Bv/Gnbwhzg==
X-Received: by 2002:a05:6512:4011:b0:50e:2d47:b99 with SMTP id br17-20020a056512401100b0050e2d470b99mr1508904lfb.191.1702924810541;
        Mon, 18 Dec 2023 10:40:10 -0800 (PST)
Received: from ?IPV6:2001:14ba:a0db:1f00::227? (dzdqv0yyyyyyyyyyyykxt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::227])
        by smtp.gmail.com with ESMTPSA id s22-20020a056512315600b0050e3de11f02sm197038lfi.53.2023.12.18.10.40.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Dec 2023 10:40:10 -0800 (PST)
Message-ID: <416be20b-d37f-4807-9ef1-e0b67f283987@linaro.org>
Date: Mon, 18 Dec 2023 20:40:09 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/34] media: iris: register video device to platform
 driver
Content-Language: en-GB
To: Dikshita Agarwal <quic_dikshita@quicinc.com>,
 linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
 stanimir.k.varbanov@gmail.com, quic_vgarodia@quicinc.com, agross@kernel.org,
 andersson@kernel.org, konrad.dybcio@linaro.org, mchehab@kernel.org,
 bryan.odonoghue@linaro.org
Cc: linux-arm-msm@vger.kernel.org, quic_abhinavk@quicinc.com
References: <1702899149-21321-1-git-send-email-quic_dikshita@quicinc.com>
 <1702899149-21321-7-git-send-email-quic_dikshita@quicinc.com>
From: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <1702899149-21321-7-git-send-email-quic_dikshita@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 18/12/2023 13:32, Dikshita Agarwal wrote:
> Iris is a multi pipe based video acceleration hardware
> block that offloads video stream encoding and decoding
> from the application processor (AP). It supports H.264
> and H.265 encoding and decoding, as well as VP9 decoding.
> The AP communicates with hardware through a well defined
> protocol which provides fine-grained and asynchronous
> control over individual hardware features.
> 
> This patch introduces basic probe and remove functions.

Documentation/process/submitting-patches.rst

Other than that LGTM

> It handles setting up a video device as well as registering
> it with the V4L2 subsystem.
> 
> Signed-off-by: Dikshita Agarwal <quic_dikshita@quicinc.com>
> ---
>   drivers/media/platform/qcom/Kconfig                |   1 +
>   drivers/media/platform/qcom/Makefile               |   1 +
>   drivers/media/platform/qcom/vcodec/iris/Kconfig    |  13 +++
>   drivers/media/platform/qcom/vcodec/iris/Makefile   |   3 +
>   .../media/platform/qcom/vcodec/iris/iris_core.h    |  34 +++++++
>   .../media/platform/qcom/vcodec/iris/iris_probe.c   | 111 +++++++++++++++++++++
>   6 files changed, 163 insertions(+)
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/Kconfig
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/Makefile
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_core.h
>   create mode 100644 drivers/media/platform/qcom/vcodec/iris/iris_probe.c
> 
> diff --git a/drivers/media/platform/qcom/Kconfig b/drivers/media/platform/qcom/Kconfig
> index e94142f..7c88837 100644
> --- a/drivers/media/platform/qcom/Kconfig
> +++ b/drivers/media/platform/qcom/Kconfig
> @@ -4,3 +4,4 @@ comment "Qualcomm media platform drivers"
>   
>   source "drivers/media/platform/qcom/camss/Kconfig"
>   source "drivers/media/platform/qcom/vcodec/venus/Kconfig"
> +source "drivers/media/platform/qcom/vcodec/iris/Kconfig"
> diff --git a/drivers/media/platform/qcom/Makefile b/drivers/media/platform/qcom/Makefile
> index 3d2d82b..3c76969 100644
> --- a/drivers/media/platform/qcom/Makefile
> +++ b/drivers/media/platform/qcom/Makefile
> @@ -1,3 +1,4 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   obj-y += camss/
>   obj-y += vcodec/venus/
> +obj-y += vcodec/iris/
> diff --git a/drivers/media/platform/qcom/vcodec/iris/Kconfig b/drivers/media/platform/qcom/vcodec/iris/Kconfig
> new file mode 100644
> index 0000000..850a5b4
> --- /dev/null
> +++ b/drivers/media/platform/qcom/vcodec/iris/Kconfig
> @@ -0,0 +1,13 @@
> +config VIDEO_QCOM_IRIS
> +        tristate "Qualcomm Iris V4L2 encoder/decoder driver"
> +        depends on VIDEO_DEV
> +        depends on ARCH_QCOM
> +        select QCOM_MDT_LOADER if ARCH_QCOM
> +        select QCOM_SCM
> +        select DMABUF_HEAPS
> +	select DMABUF_HEAPS_SYSTEM
> +        help
> +          This is a V4L2 driver for Qualcomm Iris video accelerator
> +          hardware. It accelerates encoding and decoding operations
> +          on various Qualcomm SoCs.
> +          To compile this driver as a module choose m here.
> diff --git a/drivers/media/platform/qcom/vcodec/iris/Makefile b/drivers/media/platform/qcom/vcodec/iris/Makefile
> new file mode 100644
> index 0000000..5536ae0
> --- /dev/null
> +++ b/drivers/media/platform/qcom/vcodec/iris/Makefile
> @@ -0,0 +1,3 @@
> +iris-objs += iris_probe.o
> +
> +obj-$(CONFIG_VIDEO_QCOM_IRIS) += iris.o
> diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_core.h b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
> new file mode 100644
> index 0000000..ab7fcee
> --- /dev/null
> +++ b/drivers/media/platform/qcom/vcodec/iris/iris_core.h
> @@ -0,0 +1,34 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#ifndef _IRIS_CORE_H_
> +#define _IRIS_CORE_H_
> +
> +#include <linux/types.h>
> +#include <media/v4l2-device.h>
> +
> +/**
> + * struct iris_core - holds core parameters valid for all instances
> + *
> + * @dev: reference to device structure
> + * @reg_base: IO memory base address
> + * @irq: iris irq
> + * @v4l2_dev: a holder for v4l2 device structure
> + * @vdev_dec: iris video device structure for decoder
> + * @v4l2_file_ops: iris v4l2 file ops
> + * @v4l2_ioctl_ops: iris v4l2 ioctl ops
> + */
> +
> +struct iris_core {
> +	struct device				*dev;
> +	void __iomem				*reg_base;
> +	int					irq;
> +	struct v4l2_device			v4l2_dev;
> +	struct video_device			*vdev_dec;
> +	const struct v4l2_file_operations	*v4l2_file_ops;
> +	const struct v4l2_ioctl_ops		*v4l2_ioctl_ops;
> +};
> +
> +#endif
> diff --git a/drivers/media/platform/qcom/vcodec/iris/iris_probe.c b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
> new file mode 100644
> index 0000000..2e93118
> --- /dev/null
> +++ b/drivers/media/platform/qcom/vcodec/iris/iris_probe.c
> @@ -0,0 +1,111 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2022-2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/module.h>
> +#include <linux/of_device.h>
> +#include <linux/platform_device.h>
> +
> +#include "iris_core.h"
> +
> +static int iris_register_video_device(struct iris_core *core)
> +{
> +	struct video_device *vdev;
> +	int ret;
> +
> +	vdev = video_device_alloc();
> +	if (!vdev)
> +		return -ENOMEM;
> +
> +	strscpy(vdev->name, "qcom-iris-decoder", sizeof(vdev->name));
> +	vdev->release = video_device_release;
> +	vdev->fops = core->v4l2_file_ops;
> +	vdev->ioctl_ops = core->v4l2_ioctl_ops;
> +	vdev->vfl_dir = VFL_DIR_M2M;
> +	vdev->v4l2_dev = &core->v4l2_dev;
> +	vdev->device_caps = V4L2_CAP_VIDEO_M2M_MPLANE | V4L2_CAP_STREAMING;
> +
> +	ret = video_register_device(vdev, VFL_TYPE_VIDEO, -1);
> +	if (ret)
> +		goto err_vdev_release;
> +
> +	core->vdev_dec = vdev;
> +	video_set_drvdata(vdev, core);
> +
> +	return ret;
> +
> +err_vdev_release:
> +	video_device_release(vdev);
> +
> +	return ret;
> +}
> +
> +static void iris_remove(struct platform_device *pdev)
> +{
> +	struct iris_core *core;
> +
> +	core = platform_get_drvdata(pdev);
> +	if (!core)
> +		return;
> +
> +	video_unregister_device(core->vdev_dec);
> +
> +	v4l2_device_unregister(&core->v4l2_dev);
> +}
> +
> +static int iris_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct iris_core *core;
> +	int ret;
> +
> +	core = devm_kzalloc(&pdev->dev, sizeof(*core), GFP_KERNEL);
> +	if (!core)
> +		return -ENOMEM;
> +	core->dev = dev;
> +
> +	core->reg_base = devm_platform_ioremap_resource(pdev, 0);
> +	if (IS_ERR(core->reg_base))
> +		return PTR_ERR(core->reg_base);
> +
> +	core->irq = platform_get_irq(pdev, 0);
> +	if (core->irq < 0)
> +		return core->irq;
> +
> +	ret = v4l2_device_register(dev, &core->v4l2_dev);
> +	if (ret)
> +		return ret;
> +
> +	ret = iris_register_video_device(core);
> +	if (ret)
> +		goto err_v4l2_unreg;
> +
> +	platform_set_drvdata(pdev, core);
> +
> +	return ret;
> +
> +err_v4l2_unreg:
> +	v4l2_device_unregister(&core->v4l2_dev);
> +
> +	return ret;
> +}
> +
> +static const struct of_device_id iris_dt_match[] = {
> +	{ .compatible = "qcom,sm8550-iris", },
> +	{ },
> +};
> +MODULE_DEVICE_TABLE(of, iris_dt_match);
> +
> +static struct platform_driver qcom_iris_driver = {
> +	.probe = iris_probe,
> +	.remove_new = iris_remove,
> +	.driver = {
> +		.name = "qcom-iris",
> +		.of_match_table = iris_dt_match,
> +	},
> +};
> +
> +module_platform_driver(qcom_iris_driver);
> +MODULE_DESCRIPTION("Qualcomm Iris video driver");
> +MODULE_LICENSE("GPL");

-- 
With best wishes
Dmitry


