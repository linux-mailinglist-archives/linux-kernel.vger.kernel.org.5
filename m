Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C39D787814
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:36:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjHXSgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:36:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243159AbjHXSgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:36:10 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7632120
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:35:37 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id 38308e7fff4ca-2b9f0b7af65so1379861fa.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:35:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692902110; x=1693506910;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=63IMv05Wwo79pfsmf+e0wX0GK3Q1zRO0q/xIjyXo/aY=;
        b=ldzTAUlb5sUN3Sv9DwwPtFk+2of5oPdIhSVhXVYc5DE+6lYaUPvyCznSM6dVSOyTAr
         kOjajgVtM3d+YzqXAkC6avIJwnxd5+o0t4GPXIVNXB1Ihpt8017fmxJpG4zxkgJiHtPC
         IVqd6mK/65oRQwMJXOuUCxbZ5yz00gSG+ekSTrOczM+QBDi3Bnii6kus+V7xUDn2abdV
         GaFiKPgFzid2y68/Ipnurg1H9yYJez738+jC+CSoB/XkvmP5KGoKgyQJfMqfhhPqyPwG
         T6ZLsM9NcQbT4vg2+u3lZBNa38sixSE+le/Y/ke/xiUxfB5Mr7/s4w+ulrxmbhl94eM+
         p18Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692902110; x=1693506910;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=63IMv05Wwo79pfsmf+e0wX0GK3Q1zRO0q/xIjyXo/aY=;
        b=dTVRcausk5NYR+HZBrIhOgSkhlizYmU+QK5pq3D3F0APaBqdKwnHqWoIwpaASNbMlP
         tN7iSYoHhRbqn95g9fbEGw6TFu1BgXOO/shALHn+bweu2YilaLKgiUAKnNmFsRYVDfvG
         62ZW0CVDfuwZhNHA/No/pFIBGSa15nmQuVkfXca963VXnFdH1y8eLz2XewGrhWiiGfJx
         2QQdzKUIfqq2zVmc4eI+hScRrye4MV0WvUWKvkTMDrFki+6nyxZNmppkxDNBx53YcYSz
         TP6ociT23wPjKOtcKEFAE97iILBDFE4oJvvwNLYMUivhtjN+FwlDpxsq6It71VtmLML6
         1f2Q==
X-Gm-Message-State: AOJu0YxuOdSMBddfJzJXYO44vBlOBOTSLagluQ7DO8FNwmCf9ktx+fta
        PlGxjYqTo2yId+vxnYgJQ+LEuw==
X-Google-Smtp-Source: AGHT+IEtd5lEmEoTesgIafxH/9D8vmp8+ZH+cx9fliUkshNJAGljW11juAwI+hqOSe/uPDY/dPfXhA==
X-Received: by 2002:a2e:978c:0:b0:2bc:bb3e:1abe with SMTP id y12-20020a2e978c000000b002bcbb3e1abemr10525939lji.41.1692902110352;
        Thu, 24 Aug 2023 11:35:10 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id v18-20020a170906b01200b0098e78ff1a87sm11314650ejy.120.2023.08.24.11.35.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 11:35:09 -0700 (PDT)
Message-ID: <b20852ee-068f-5fd0-ad3d-c74e236c1f87@linaro.org>
Date:   Thu, 24 Aug 2023 20:35:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 07/11] firmware: imx: init-fw api exchange on imx93
Content-Language: en-US
To:     Pankaj Gupta <pankaj.gupta@nxp.com>, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, clin@suse.com,
        conor+dt@kernel.org, pierre.gondois@arm.com, ping.bai@nxp.com,
        xiaoning.wang@nxp.com, wei.fang@nxp.com, peng.fan@nxp.com,
        haibo.chen@nxp.com, festevam@gmail.com, linux-imx@nxp.com,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gaurav.jain@nxp.com,
        alexander.stein@ew.tq-group.com, sahil.malhotra@nxp.com,
        aisheng.dong@nxp.com, V.Sethi@nxp.com
References: <20230823073330.1712721-1-pankaj.gupta@nxp.com>
 <20230823073330.1712721-8-pankaj.gupta@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823073330.1712721-8-pankaj.gupta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 09:33, Pankaj Gupta wrote:
> On imx93 platforms, exchange init-fw message with enclave's firmware
> is to be done.
> 
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  drivers/firmware/imx/Makefile           |  2 +-
>  drivers/firmware/imx/ele_fw_api.c       | 56 +++++++++++++++++++++++++
>  drivers/firmware/imx/se_fw.c            | 11 +++++
>  include/linux/firmware/imx/ele_fw_api.h | 19 +++++++++
>  4 files changed, 87 insertions(+), 1 deletion(-)
>  create mode 100644 drivers/firmware/imx/ele_fw_api.c
>  create mode 100644 include/linux/firmware/imx/ele_fw_api.h
> 
> diff --git a/drivers/firmware/imx/Makefile b/drivers/firmware/imx/Makefile
> index eab3f03e2e5e..bc6ed5514a19 100644
> --- a/drivers/firmware/imx/Makefile
> +++ b/drivers/firmware/imx/Makefile
> @@ -2,5 +2,5 @@
>  obj-$(CONFIG_IMX_DSP)		+= imx-dsp.o
>  obj-$(CONFIG_IMX_SCU)		+= imx-scu.o misc.o imx-scu-irq.o rm.o imx-scu-soc.o
>  obj-$(CONFIG_IMX_SCU_PD)	+= scu-pd.o
> -sec_enclave-objs		= se_fw.o ele_common.o ele_base_msg.o
> +sec_enclave-objs		= se_fw.o ele_common.o ele_base_msg.o ele_fw_api.o
>  obj-${CONFIG_IMX_SEC_ENCLAVE}	+= sec_enclave.o
> diff --git a/drivers/firmware/imx/ele_fw_api.c b/drivers/firmware/imx/ele_fw_api.c
> new file mode 100644
> index 000000000000..1df1fbcb6d9e
> --- /dev/null
> +++ b/drivers/firmware/imx/ele_fw_api.c
> @@ -0,0 +1,56 @@
> +// SPDX-License-Identifier: GPL-2.0-or-later
> +/*
> + * Copyright 2023 NXP
> + */
> +
> +#include <linux/dma-mapping.h>
> +#include <linux/firmware/imx/ele_fw_api.h>
> +
> +#include "ele_common.h"
> +
> +/* Fill a command message header with a given command ID and length in bytes. */
> +static int plat_fill_cmd_msg_hdr(struct ele_mu_priv *priv,
> +				 struct mu_hdr *hdr,
> +				 uint8_t cmd, uint32_t len)
> +{
> +	int err = 0;
> +
> +	hdr->tag = priv->cmd_tag;
> +	hdr->ver = MESSAGING_VERSION_7;
> +	hdr->command = cmd;
> +	hdr->size = (uint8_t)(len / sizeof(uint32_t));
> +
> +	return err;
> +}
> +
> +int ele_init_fw(struct device *dev)
> +{
> +	struct ele_mu_priv *priv = dev_get_drvdata(dev);
> +	int ret;
> +	unsigned int tag, command, size, ver, status;
> +
> +	ret = plat_fill_cmd_msg_hdr(priv,
> +				    (struct mu_hdr *)&priv->tx_msg.header,
> +				    ELE_INIT_FW_REQ, 4);

This is some weird code. Why do you store TX and RX messages in state
container? This should be local to the function.

> +	if (ret)
> +		return ret;
> +
> +	ret = imx_ele_msg_send_rcv(priv);
> +	if (ret < 0)
> +		return ret;
> +
> +	tag = MSG_TAG(priv->rx_msg.header);
> +	command = MSG_COMMAND(priv->rx_msg.header);
> +	size = MSG_SIZE(priv->rx_msg.header);
> +	ver = MSG_VER(priv->rx_msg.header);
> +	status = RES_STATUS(priv->rx_msg.data[0]);
> +
> +	if (tag == priv->rsp_tag
> +		&& command == ELE_INIT_FW_REQ
> +		&& size == ELE_INIT_FW_RSP_SZ
> +		&& ver == MESSAGING_VERSION_7
> +		&& status == priv->success_tag)
> +		return 0;

Your coding style here and in all other places like this is unreadable.
Fix alignment.

> +
> +	return -EINVAL;
> +}
> diff --git a/drivers/firmware/imx/se_fw.c b/drivers/firmware/imx/se_fw.c
> index 2c97b2adf18b..88300c41d62b 100644
> --- a/drivers/firmware/imx/se_fw.c
> +++ b/drivers/firmware/imx/se_fw.c
> @@ -8,6 +8,7 @@
>  #include <linux/dev_printk.h>
>  #include <linux/errno.h>
>  #include <linux/export.h>
> +#include <linux/firmware/imx/ele_fw_api.h>
>  #include <linux/firmware/imx/ele_base_msg.h>
>  #include <linux/firmware/imx/ele_mu_ioctl.h>
>  #include <linux/genalloc.h>
> @@ -41,6 +42,7 @@ struct imx_info {
>  	uint8_t *se_name;
>  	uint8_t *pool_name;
>  	bool reserved_dma_ranges;
> +	bool init_fw;
>  };
>  
>  static LIST_HEAD(priv_data_list);
> @@ -55,6 +57,7 @@ static const struct imx_info imx8ulp_info = {
>  	.se_name = "ele",
>  	.pool_name = "sram-pool",
>  	.reserved_dma_ranges = true,
> +	.init_fw = false,
>  };
>  
>  static const struct imx_info imx93_info = {
> @@ -67,6 +70,7 @@ static const struct imx_info imx93_info = {
>  	.se_name = "ele",
>  	.pool_name = NULL,
>  	.reserved_dma_ranges = true,
> +	.init_fw = true,
>  };
>  
>  static const struct of_device_id se_fw_match[] = {
> @@ -1120,6 +1124,13 @@ static int se_fw_probe(struct platform_device *pdev)
>  		priv->flags |= RESERVED_DMA_POOL;
>  	}
>  
> +	if (info->init_fw) {
> +		/* start initializing ele fw */
> +		ret = ele_init_fw(dev);
> +		if (ret)
> +			dev_err(dev, "Failed to initialize ele fw.\n");
> +	}
> +
>  	if (info->socdev) {
>  		ret = imx_soc_device_register(dev, info);
>  		if (ret) {
> diff --git a/include/linux/firmware/imx/ele_fw_api.h b/include/linux/firmware/imx/ele_fw_api.h
> new file mode 100644
> index 000000000000..36c3f743cb38
> --- /dev/null
> +++ b/include/linux/firmware/imx/ele_fw_api.h

There is no need this to be Linux-wide. Keep it next to the driver.


Best regards,
Krzysztof

