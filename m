Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E4A2784117
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Aug 2023 14:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbjHVMoC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Aug 2023 08:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235763AbjHVMoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Aug 2023 08:44:02 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B977ACC1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:43:58 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 5b1f17b1804b1-3fee5ddc334so18134225e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 22 Aug 2023 05:43:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692708237; x=1693313037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=asFXeio4Q7KxDvORZNcBvXQNYxRi5kCfy3GURsBj434=;
        b=qZSqwF8UDYflQPjyMPj/86MOxnvyuiNlANd1ZVjXDb1iUhAB6vCuHB8nBsD6TqLK2w
         Lf/fU48Kp2KtllPq0VPDzDzYsGeODQ12C9IkbbiFgvdYTMhC4Qz9W8UCHoXOh/wxkjkR
         sGCgkNXEvQPiEH88b58c35MxkJKonu75v8kX1grteF4ZG1MlTPPoHfkDKSQidavpkzRH
         B1cbvx0IITIsnfThPWNUi5TPghF+DbAvjbsCq/E/mHGaCAqD/EnTYaNMijrQKZ5FnFGs
         1OfNaeIJ4p9PXIKiiDjECrcEaPKlX0R4CKUpIUrsrgJxm+ZuLagsZGegrhEeIk2reuWJ
         cciw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692708237; x=1693313037;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=asFXeio4Q7KxDvORZNcBvXQNYxRi5kCfy3GURsBj434=;
        b=CDRr0eZO0aQFlxsgBtUfkGY7CWi7rNEqycCRTQ3fpBxFb9yvXU1URjl8D8yyr2SdwU
         LGt8V4ks1kIJsgaFd+E686dvUUmKZbGzguvuy/Y1JcOUzowTrf4yJthDKBxWjN9JT2Q2
         wjlVVuz7B+053CDcv56bqg4aF6uzh0ycPz8+MomMH0m5KqtcV+FDjSnStmfhrjGUmFMp
         uFZctu9fCsqlbygivRF/95RCBTBMerbCKcc4lZPe6ZSKkrtegCON+VtQ3kUUSqNYddkh
         Zn4bsQJqjTQv9cbfC/FS/2s/kEQ2QMkSd4CFbsHtVHNQ9AsJa6oqmgPjT9DqLE31gUwZ
         jIlg==
X-Gm-Message-State: AOJu0YyaoyqBEXGYjvUQu3r2EiAt0/Isf/U/D2lvojE12YRFNvLKaewW
        Q6MmoPupTQ5pBddleYEL5c7O5g==
X-Google-Smtp-Source: AGHT+IF2A5ERxA2sXhFxPHH9CwfQrFW7ECH+rY2XCvEYA3zuAKW3D7enF19H4chNned813IzMHcbqA==
X-Received: by 2002:a7b:c459:0:b0:3fa:aeac:e978 with SMTP id l25-20020a7bc459000000b003faaeace978mr7330365wmi.0.1692708237172;
        Tue, 22 Aug 2023 05:43:57 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id c1-20020a7bc001000000b003fee567235bsm11643004wmb.1.2023.08.22.05.43.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Aug 2023 05:43:56 -0700 (PDT)
Message-ID: <39ce6d07-7692-7194-b153-e73ba7fb687c@linaro.org>
Date:   Tue, 22 Aug 2023 13:43:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
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
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230822121512.8631-2-quic_ninanaik@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
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

2023

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

It would be nice to alphetise this include list.

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
Is that indentation correct ?

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

---
bod
