Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9388B784240
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 15:41:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbjHVNlS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 09:41:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233488AbjHVNlR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 09:41:17 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6965B1B9
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:41:14 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso69978861fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 06:41:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692711672; x=1693316472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XE6fL5so42vAmuYhJnyDEVwxlJSJ1dM95ROvnPRdClk=;
        b=KOGSwk7w1yUgaplSQljOf+Y8lwPKeenqZr5CRB0JHi7aWwwx0X+tYOza6V/+AOD0ar
         4jit31r4Grd85gHqx/FZpZUlZWRUPgkXgCBsHycv1TsC3WIZL1dNJBpuOXk89xZG0gx3
         ZKuilhP9YwU27wZGxKbR211TXqt93f6AZb2wZnh2rz/ZKNULWvOs+cDTHjLv3fd+gCU2
         O6AyVmCk2xSlrmLF4h35f2p1zMzf4BdJR3nfdR7CNXkxAf3P7jDtM1RfYzsdNmkIzEdY
         WfanuXMxAZoSfXmZlqm4kSawHlC2qfbdmUuoF7eipkhQ5n/Tcn4Gx2wtorXh0Rm4NgCB
         LVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692711672; x=1693316472;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XE6fL5so42vAmuYhJnyDEVwxlJSJ1dM95ROvnPRdClk=;
        b=PqYuVZORji16gFb4x4vp7HkwXKU6aa6uhdatdaJhQ9YSsDriSDZ/7/aguARy+sL9GI
         7OQ9q19scLcpLeRl+AHbqCIpOTujtJnkx28Q8a3gfXCDzVMnOwEQavKMMyRTquJ0Qa3p
         obcnsblDj0FQtqWD464DsLj+bfhaEFjPIBRI3xW27mRqPqBzCb82WKAMrwKI0Hf/HgrV
         OYySXbyAiBMBqPaumqS0fmt1AgFe/UaeI34eWt8V8p0z7e5L4WbQeoHpL5FIIvuur6T1
         cqi95Baey9f9QPoYUabrju2Fzv6fSV2DbcSSPPXRkZklZXosg1lmMrxs8wcr+Jl0BV52
         REIQ==
X-Gm-Message-State: AOJu0Yx/SQgQAnv+B7xc5sxHh0CjRCFCmPGHQOQBNKLsjbSBJKbif0v3
        aeATOM2hGvst7lNBjd1MX+10/Q==
X-Google-Smtp-Source: AGHT+IF+GeFqRLtq8ut7sP8c/gbBI50xnTS3R+m6Vnm1/uSF6FqClEE3sqlL3FI0xRMqNyzUXWbD5A==
X-Received: by 2002:ac2:4e85:0:b0:500:80af:e199 with SMTP id o5-20020ac24e85000000b0050080afe199mr4455190lfr.55.1692711671965;
        Tue, 22 Aug 2023 06:41:11 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id u17-20020a05640207d100b0052a198d8a4dsm1348760edy.52.2023.08.22.06.41.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 06:41:11 -0700 (PDT)
Message-ID: <71a9eaea-b9d1-69e6-c7b2-4e54f5160882@linaro.org>
Date:   Tue, 22 Aug 2023 14:41:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 1/1] soc: qcom: Add driver to read secondary
 bootloader (XBL) log
Content-Language: en-US
To:     Ninad Naik <quic_ninanaik@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org
Cc:     psodagud@quicinc.com, quic_ppareek@quicinc.com,
        quic_kprasan@quicinc.com, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, kernel@quicinc.com
References: <20230822121512.8631-1-quic_ninanaik@quicinc.com>
 <20230822121512.8631-2-quic_ninanaik@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230822121512.8631-2-quic_ninanaik@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 22/08/2023 13:15, Ninad Naik wrote:
> Qualcomm secondary bootloader (XBL) boot log holds information to
> identify various firmware configuration currently set on the SoC.
> The XBL log is stored in a predefined reserved memory region.
> 
> This drivers provides a way to print XBL logs on the console. To
> do so, it provides a debugfs entry which captures the logs stored
> in this reserved memory region. This entry can now be used to read
> and print the XBL logs to console.
> 
> User can use the below command to print XBL log to console:
>          cat /sys/kernel/debug/xbl_log
> 
> Signed-off-by: Ninad Naik <quic_ninanaik@quicinc.com>
> ---
>   drivers/soc/qcom/Kconfig        |  13 +++
>   drivers/soc/qcom/Makefile       |   1 +
>   drivers/soc/qcom/dump_xbl_log.c | 139 ++++++++++++++++++++++++++++++++
>   3 files changed, 153 insertions(+)
>   create mode 100644 drivers/soc/qcom/dump_xbl_log.c
> 
> diff --git a/drivers/soc/qcom/Kconfig b/drivers/soc/qcom/Kconfig
> index 715348869d04..4489d37e924d 100644
> --- a/drivers/soc/qcom/Kconfig
> +++ b/drivers/soc/qcom/Kconfig
> @@ -291,4 +291,17 @@ config QCOM_INLINE_CRYPTO_ENGINE
>   	tristate
>   	select QCOM_SCM
>   
> +config QCOM_DUMP_XBL_LOG
> +	tristate "Qualcomm driver to print XBL logs on console from debugfs"
> +	help
> +	  This driver is used to capture secondary bootloader (xbl) log
> +	  from a reserved memory region and provide a debugfs entry to read
> +	  logs captured from this memory region and print them on console.
> +	  User can use below command to print the xbl log on console:
> +
> +                cat /sys/kernel/debug/xbl_log
> +
> +	  These logs help to identify firmware configuration information on
> +	  the SoC. The name of the built module will be dump_xbl_log
> +
>   endmenu
> diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> index bbca2e1e55bb..aac088a1a0b6 100644
> --- a/drivers/soc/qcom/Makefile
> +++ b/drivers/soc/qcom/Makefile
> @@ -32,3 +32,4 @@ obj-$(CONFIG_QCOM_KRYO_L2_ACCESSORS) +=	kryo-l2-accessors.o
>   obj-$(CONFIG_QCOM_ICC_BWMON)	+= icc-bwmon.o
>   qcom_ice-objs			+= ice.o
>   obj-$(CONFIG_QCOM_INLINE_CRYPTO_ENGINE)	+= qcom_ice.o
> +obj-$(CONFIG_QCOM_DUMP_XBL_LOG)	+= dump_xbl_log.o
> diff --git a/drivers/soc/qcom/dump_xbl_log.c b/drivers/soc/qcom/dump_xbl_log.c
> new file mode 100644
> index 000000000000..ea335a5e660b
> --- /dev/null
> +++ b/drivers/soc/qcom/dump_xbl_log.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copyright (c) 2021, The Linux Foundation. All rights reserved.
> + */
> +
> +#include <linux/init.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/device.h>
> +#include <linux/platform_device.h>
> +#include <linux/memblock.h>
> +#include <linux/of_address.h>
> +#include <linux/err.h>
> +#include <linux/debugfs.h>
> +
> +struct xbl_log_data {
> +	struct device *dev;
> +	size_t buf_size;
> +	void __iomem *xbl_buf;
> +	struct dentry *dbg_file;
> +	struct debugfs_blob_wrapper dbg_data;
> +};
> +
> +static int map_addr_range(struct device_node **parent, const char *name,
> +			  struct xbl_log_data *xbl_data)
> +{
> +	struct device_node *node;
> +	struct resource res;
> +	int ret;
> +
> +	node = of_find_node_by_name(*parent, name);
> +	if (!node)
> +		return -ENODEV;
> +
> +	ret = of_address_to_resource(node, 0, &res);
> +	if (ret) {
> +		dev_err(xbl_data->dev, "Failed to parse memory region\n");
> +		return ret;
> +	}
> +	of_node_put(node);
> +
> +	if (!resource_size(&res)) {
> +		dev_err(xbl_data->dev, "Failed to parse memory region size\n");
> +		return -ENODEV;
> +	}
> +
> +	xbl_data->buf_size = resource_size(&res) - 1;
> +	xbl_data->xbl_buf = devm_memremap(xbl_data->dev, res.start,
> +					  xbl_data->buf_size, MEMREMAP_WB);
> +	if (!xbl_data->xbl_buf) {
> +		dev_err(xbl_data->dev, "%s: memory remap failed\n", name);
> +		return -ENOMEM;
> +	}
> +
> +	return 0;
> +}
> +
> +static int xbl_log_probe(struct platform_device *pdev)
> +{
> +	struct device *dev = &pdev->dev;
> +	struct xbl_log_data *xbl_data;
> +	struct device_node *parent;
> +	int ret;
> +
> +	xbl_data = devm_kzalloc(dev, sizeof(*xbl_data), GFP_KERNEL);
> +	if (!xbl_data)
> +		return -ENOMEM;
> +
> +	xbl_data->dev = &pdev->dev;
> +	platform_set_drvdata(pdev, xbl_data);
> +
> +	parent = of_find_node_by_path("/reserved-memory");
> +	if (!parent) {
> +		dev_err(xbl_data->dev, "reserved-memory node missing\n");
> +		return -ENODEV;
> +	}
> +
> +	ret = map_addr_range(&parent, "uefi-log", xbl_data);

This driver really needs a proper device tree bindings, rather than 
parsing the device tree manually here in the driver.

Pl look at ./Documentation/devicetree/bindings/reserved-memory/qcom*

This should also help you getting rid of all these parsing code.

--srini



> +	if (ret)
> +		goto put_node;
> +
> +	xbl_data->dbg_data.data = xbl_data->xbl_buf;
> +	xbl_data->dbg_data.size = xbl_data->buf_size;
> +	xbl_data->dbg_file = debugfs_create_blob("xbl_log", 0400, NULL,
> +						 &xbl_data->dbg_data);
> +	if (IS_ERR(xbl_data->dbg_file)) {
> +		dev_err(xbl_data->dev, "failed to create debugfs entry\n");
> +		ret = PTR_ERR(xbl_data->dbg_file);
> +	}
> +
> +put_node:
> +	of_node_put(parent);
> +	return ret;
> +}
> +
> +static int xbl_log_remove(struct platform_device *pdev)
> +{
> +	struct xbl_log_data *xbl_data = platform_get_drvdata(pdev);
> +
> +	debugfs_remove_recursive(xbl_data->dbg_file);
> +	return 0;
> +}
> +
> +static struct platform_driver xbl_log_driver = {
> +	.probe = xbl_log_probe,
> +	.remove = xbl_log_remove,
> +	.driver = {
> +		   .name = "xbl-log",
> +		   },
> +};
> +
> +static struct platform_device xbl_log_device = {
> +	.name = "xbl-log",
> +};
> +
> +static int __init xbl_log_init(void)
> +{
> +	int ret = 0;
> +
> +	ret = platform_driver_register(&xbl_log_driver);
> +	if (!ret) {
> +		ret = platform_device_register(&xbl_log_device);
> +		if (ret)
> +			platform_driver_unregister(&xbl_log_driver);
> +	}
> +	return ret;
> +}
> +
> +static void __exit xbl_log_exit(void)
> +{
> +	platform_device_unregister(&xbl_log_device);
> +	platform_driver_unregister(&xbl_log_driver);
> +}
> +
> +module_init(xbl_log_init);
> +module_exit(xbl_log_exit);
> +
> +MODULE_DESCRIPTION("Qualcomm Technologies, Inc. (QTI) XBL log driver");
> +MODULE_LICENSE("GPL");
