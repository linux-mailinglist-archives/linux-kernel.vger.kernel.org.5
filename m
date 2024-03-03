Return-Path: <linux-kernel+bounces-89867-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE34886F6B6
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 20:11:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77CCC281539
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Mar 2024 19:11:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E2AA79DA5;
	Sun,  3 Mar 2024 19:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hsgIgF4N"
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B241479945
	for <linux-kernel@vger.kernel.org>; Sun,  3 Mar 2024 19:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709493084; cv=none; b=G23ZMmmBmMbO2YeI98gUCaDRsGIH3bB/v6GTGFHkEIoYDoZHGMmobTlIrAV3456L8/7psiPhVUFpV4p5/otRFoKynke6NIoNLNHpEkeIjQrDr6a28EfOdKtUt2D6byEPlts6TlZxXVYIsN8yOmYww0E7eenKikqX75SXyST7m8Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709493084; c=relaxed/simple;
	bh=qau0gd7eIdfVjBy+AauJOQ+jCugLVyaR0tipbfWqRX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Jqzvoh+dCK7RN/z2crFjkmhWs43lt8fM4YoyWYv0gz7t+KUnU+fG3oKlFZTK7WF0QVmuRTO49xZYxcuIQHFCsoGZr42PxwdZyATiEg6b2YY/UVGNEZfd0TgpHKHvTPHjdPX41muNsjRohvmeUJ6n8Lgvvb+QqvaiSi9yyZ6RcZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hsgIgF4N; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so626483566b.0
        for <linux-kernel@vger.kernel.org>; Sun, 03 Mar 2024 11:11:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709493081; x=1710097881; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bmtmjSIxMrbeqKm/C6v4CZQ0x5QA4b41PodMBX3Iays=;
        b=hsgIgF4NFzVhM1kzP48HoPnbz//rP+Vdf6chGdleefCVZgSOCwtEAZkmji/DJA0+5E
         4dbbkO8zPd/sU+9kJcD4qou04YEgn0REoIIAI0Fk9TlvqUQ4R7GIJ1hIs7ZXOyVMThJj
         SmotxLu3631lp3QzhDSZT5xHQAIOPjSueGpZDCt4tWDK17bZe4IReS4Gs0n7Wm2Eogw/
         04gPnUCyeXCusjndfi5sxX/S+7qOucRSveJSQIh3piTUvSrnLuujmMZKIw5LTrKFeyWu
         ETIftAXC1wQBlzIWLF2hg0ZX24tQIfLcuDHfx7iQLsCKhvD52rY0dfxk3pLIxUBLxFyB
         ujyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709493081; x=1710097881;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bmtmjSIxMrbeqKm/C6v4CZQ0x5QA4b41PodMBX3Iays=;
        b=SuD5a/3RttbvzclOCUqxsyaZrA7/fVqIbt4DQRMYQ7D7TETyaVQ6qWHLGHNjW0wdfD
         YjDqrKAbXgL34mfBbaxAR//HiedhXeVyfyutnBMeEyxaFwPAx5hGFati1ViieRlnteGR
         1nGJzJwbSP7XTnzlWeLSYqmryLkOkkKHi0mu2nAlrK/3+LNZB0POWaOT3WPf6pttUY0h
         PUT95R9vW2OinHpZS0JUi1XDJs05Ikudy6Y8mKfukXBOiwvMe/SooFPAUgJ8qxjBWTWK
         zYBBnfoFLskBr5tdsLsEvlAKXuUHoneg9TxwlFT/qp1MoiKDzro6kbBMNGvFvzaJwITp
         m+TQ==
X-Forwarded-Encrypted: i=1; AJvYcCW+UaemdTsY5zEpTtQrRnrOqLUBuSWvmrQequLt8XEEoRqDQGkrLmwtbsz3wYL3cUteJEui6JAfuvA3kxgnP9Jn+/hyZ2UjpZm5uXSv
X-Gm-Message-State: AOJu0YypFfZfqq+x+5PkLhS62adz2peeb1Vofvvd7xzs0UyXzGZv47AR
	CFrYoe4WsD3tjUD7n9VtpFy0uCbGNE/03+5aW476RpAhtKgisibXHtAP/h7jZ5c=
X-Google-Smtp-Source: AGHT+IEqR1xbZdpi7AtamsYOnOo13mLNP1UrdXL6QZTD5EC5hdfkTyOQqlWsKywUpBTfjA8G3Mavtw==
X-Received: by 2002:a17:906:a88d:b0:a44:c573:f56f with SMTP id ha13-20020a170906a88d00b00a44c573f56fmr3232074ejb.9.1709493081098;
        Sun, 03 Mar 2024 11:11:21 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id t15-20020a1709063e4f00b00a42f6d17123sm3896905eji.46.2024.03.03.11.11.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Mar 2024 11:11:20 -0800 (PST)
Message-ID: <0c089229-237a-43c3-a1ba-8900101aa849@linaro.org>
Date: Sun, 3 Mar 2024 20:11:18 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] misc: qualcomm: QRC driver for Robotic SDK MCU
Content-Language: en-US
To: Canfeng Zhuang <quic_czhuang@quicinc.com>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc: linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240304-qcom_qrc-v1-0-2a709f95fd61@quicinc.com>
 <20240304-qcom_qrc-v1-1-2a709f95fd61@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <20240304-qcom_qrc-v1-1-2a709f95fd61@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/03/2024 17:53, Canfeng Zhuang wrote:
> QRC Driver support functions:
> - Read data from serial device port.
> - Write data to serial device port.
> - Pin control reset robotic controller.
> 
> Signed-off-by: Canfeng Zhuang <quic_czhuang@quicinc.com>
> ---
>  drivers/misc/Kconfig        |   1 +
>  drivers/misc/Makefile       |   1 +
>  drivers/misc/qrc/Kconfig    |  16 ++
>  drivers/misc/qrc/Makefile   |   6 +
>  drivers/misc/qrc/qrc_core.c | 336 ++++++++++++++++++++++++++++++++++++++++++
>  drivers/misc/qrc/qrc_core.h | 143 ++++++++++++++++++
>  drivers/misc/qrc/qrc_uart.c | 345 ++++++++++++++++++++++++++++++++++++++++++++
>  7 files changed, 848 insertions(+)
> 
> diff --git a/drivers/misc/Kconfig b/drivers/misc/Kconfig
> index 4fb291f0bf7c..a43108af6fde 100644
> --- a/drivers/misc/Kconfig
> +++ b/drivers/misc/Kconfig
> @@ -591,4 +591,5 @@ source "drivers/misc/cardreader/Kconfig"
>  source "drivers/misc/uacce/Kconfig"
>  source "drivers/misc/pvpanic/Kconfig"
>  source "drivers/misc/mchp_pci1xxxx/Kconfig"
> +source "drivers/misc/qrc/Kconfig"
>  endmenu
> diff --git a/drivers/misc/Makefile b/drivers/misc/Makefile
> index ea6ea5bbbc9c..ab3b2c4d99fa 100644
> --- a/drivers/misc/Makefile
> +++ b/drivers/misc/Makefile
> @@ -68,3 +68,4 @@ obj-$(CONFIG_TMR_INJECT)	+= xilinx_tmr_inject.o
>  obj-$(CONFIG_TPS6594_ESM)	+= tps6594-esm.o
>  obj-$(CONFIG_TPS6594_PFSM)	+= tps6594-pfsm.o
>  obj-$(CONFIG_NSM)		+= nsm.o
> +obj-$(CONFIG_QCOM_QRC)		+= qrc/
> diff --git a/drivers/misc/qrc/Kconfig b/drivers/misc/qrc/Kconfig
> new file mode 100644
> index 000000000000..994985d7c320
> --- /dev/null
> +++ b/drivers/misc/qrc/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# QRC device driver configuration
> +#
> +
> +menu "QCOM QRC device driver"
> +
> +config QCOM_QRC
> +	tristate "QCOM QRC device driver for Robotic SDK MCU"
> +	help
> +	  This kernel configuration is used to enable robotic controller
> +	  device driver. Say M here if you want to enable robotic
> +	  controller device driver.
> +	  When in doubt, say N.
> +
> +endmenu
> diff --git a/drivers/misc/qrc/Makefile b/drivers/misc/qrc/Makefile
> new file mode 100644
> index 000000000000..da2cf81f3c59
> --- /dev/null
> +++ b/drivers/misc/qrc/Makefile
> @@ -0,0 +1,6 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +#
> +# Makefile for the QRC bus specific drivers.

QRC bus? Nothing anywhere suggested this is a bus.


Limited review because this really looks like some vendor code, not
cleaned for upstream submission.

> +
> +
> +obj-$(CONFIG_QCOM_QRC)		+= qrc_core.o qrc_uart.o


..

> +
> +static int qrcuart_config(struct qrc_dev *dev)
> +{
> +	/*baudrate,wordlength ... config*/
> +	return 0;
> +}
> +
> +static struct qrc_device_ops qrcuart_qrc_ops = {

What is this and why do you need it? Don't define your ops without need.
Just call functions directly.

> +	.qrcops_open = qrcuart_open,
> +	.qrcops_close = qrcuart_close,
> +	.qrcops_init = qrcuart_init,
> +	.qrcops_uninit = qrcuart_uninit,
> +	.qrcops_xmit = qrcuart_xmit,
> +	.qrcops_receive = qrcuart_receive,
> +	.qrcops_config = qrcuart_config,
> +	.qrcops_setup = qrcuart_setup,
> +	.qrcops_data_status = qrcuart_data_status,
> +	.qrcops_data_clean = qrcuart_data_clean,
> +};
> +
> +static int qrcuart_setup(struct qrc_dev *dev)
> +{
> +	dev->qrc_ops = &qrcuart_qrc_ops;
> +	return 0;
> +}
> +
> +static int qrc_uart_probe(struct serdev_device *serdev)
> +{
> +	struct qrc_dev *qdev;
> +	struct qrcuart *qrc;
> +	int ret = 0;
> +
> +	qrc = kmalloc(sizeof(*qrc), GFP_KERNEL);
> +	if (!qrc)
> +		return -ENOMEM;
> +	qdev = kmalloc(sizeof(*qdev), GFP_KERNEL);

Just use devm*. What is this code? Ancient vendor, 20 year old stuff?

> +	if (!qdev) {
> +		kfree(qrc);
> +		return -ENOMEM;
> +	}
> +	qdev->dev = &serdev->dev;
> +	qrc_set_data(qdev, qrc);
> +
> +	qrc->qrc_dev = qdev;
> +	qrc->serdev = serdev;
> +	spin_lock_init(&qrc->lock);
> +	INIT_WORK(&qrc->tx_work, qrcuart_transmit);
> +	qrcuart_setup(qdev);
> +	ret = qrcuart_init(qdev);
> +	if (ret) {
> +		dev_err(qdev->dev, "qrcuart: Fail to init qrc structure\n");
> +		kfree(qdev);
> +		kfree(qrc);
> +		return ret;
> +	}
> +	serdev_device_set_drvdata(serdev, qrc);
> +	serdev_device_set_client_ops(serdev, &qrc_serdev_ops);
> +
> +	ret = serdev_device_open(serdev);
> +	if (ret) {
> +		dev_err(qdev->dev, "qrcuart :Unable to open device\n");

Whitespace typos.

> +		goto free;
> +	}
> +	serdev_device_close(serdev);
> +	qrc->is_open = false;
> +
> +	ret = qrc_register_device(qdev, &serdev->dev);
> +
> +	if (ret) {
> +		dev_err(qdev->dev, "qrcuart: Unable to register qrc device\n");
> +		cancel_work_sync(&qrc->tx_work);
> +		goto free;
> +	}
> +
> +	return 0;
> +
> +free:

free or uninint? Your error handling is messy.

> +	qrcuart_uninit(qdev);
> +	kfree(qdev);
> +	kfree(qrc);
> +	return ret;
> +}
> +
> +static void qrc_uart_remove(struct serdev_device *serdev)
> +{
> +	struct qrcuart *qrc = serdev_device_get_drvdata(serdev);
> +
> +	if (qrc->is_open)
> +		serdev_device_close(serdev);
> +
> +	qrcuart_uninit(qrc->qrc_dev);
> +	cancel_work_sync(&qrc->tx_work);
> +	qrc_unregister(qrc->qrc_dev);
> +	kfree(qrc->qrc_dev);
> +	kfree(qrc);
> +	dev_info(&serdev->dev, "qrcuart drv removed\n");

Drop such simple function entry/exit messages. Not needed and not helpful.

> +}
> +
> +static const struct of_device_id qrc_uart_of_match[] = {
> +	{ .compatible = "qcom,qrc-uart", },
> +	{}
> +};
> +
> +MODULE_DEVICE_TABLE(of, qrc_uart_of_match);
> +
> +static struct serdev_device_driver qrc_uart_driver = {
> +	.probe = qrc_uart_probe,
> +	.remove = qrc_uart_remove,
> +	.driver = {
> +		.name = QRCUART_DRV_NAME,
> +		.of_match_table = of_match_ptr(qrc_uart_of_match),

Drop of_match_ptr. You have warnings here.

> +	},
> +};
> +
> +module_serdev_device_driver(qrc_uart_driver);
> +
> +/**********************************************/

Drop

> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. QRC Uart Driver");
> +MODULE_LICENSE("GPL");
> 

Best regards,
Krzysztof


