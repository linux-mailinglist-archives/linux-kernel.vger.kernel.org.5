Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 710D37877BE
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 20:25:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243008AbjHXSYb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 14:24:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242922AbjHXSYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 14:24:05 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD04DE58
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:24:02 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-51bece5d935so250722a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 11:24:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692901441; x=1693506241;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=973UgM2tzR/G8NExNMzGXq0EzRi09qe9/9zNN6E8lMI=;
        b=PgFZjIqOeTYZaIqnkdWJN0JpGsLz6pds74ERM6kipziYTraXLxac82r18VqDdgZTrR
         4IyJSJ1+ZjHqBrOJKSXZb4gs7MCpn9JSQemvYdWeIJDBj93G5/sc+0vbZkriQQ+Q6qpU
         YgKB4AwaDuhJjtapZ4DkZLDGvmykBevbyMj+sCnjQuBCkN8/yUtPym5lJ2w5dV7QtIEC
         FXAXLPci/dGvQCAbTyPJ9iDw2y78tfq7+aagKsrN8XBGqjYD1SeeXdDXGXOr1ciza3Ku
         XDVK3EcLAgU0v5PiFUrbRwdMpWpZcPyqleXpa6oisrSdYdFuq4c039djjOys8IGvUcnO
         kcSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692901441; x=1693506241;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=973UgM2tzR/G8NExNMzGXq0EzRi09qe9/9zNN6E8lMI=;
        b=fiX+OXcDeedG2rPJO+WJFu/J/kzmK8J1zYEqKc/5yHvWkojgiRUbQRM4mfu4KEiyST
         smWRVUaS2tPBUdv8Ow2/9oNX3+DxOWbWiaUzkjnLKD3G+l5PgEKRsNAwkIfCJxeEdqau
         kB5os4v9Ssao1nGkySp3eywy5Y75ZiAsykzVwX+/rgs3vOZymRU1nWELIPXiIeMtjTv3
         QWkveQpWO8/ECjgBcXpnxBjk1uCrbXR2MbCXZzPkEUE4fyzRcD9lyqEIOFkwlENW54YV
         p/c4ajsON1R1Dp2rytSgOkuoP8QJ6NoK/AKrOJguWeKN1M6g/m+XXk7Kc7ezbcHd27YJ
         zicA==
X-Gm-Message-State: AOJu0YxMfMvIROeaQ65UnPCQy2DQQRzSTIiWBG/oip8KWJ3n8uV+Qqtd
        iM4t4QxblSZpBaG9ScYoMgnRMQ==
X-Google-Smtp-Source: AGHT+IHysWAOwXtctQ35hBuhVVjnyCtdz9zXSYsBKT7gP4iLcIu+DWaCtsznh/M+WApmQvx33ZugEA==
X-Received: by 2002:aa7:ccc9:0:b0:525:7cd4:34da with SMTP id y9-20020aa7ccc9000000b005257cd434damr11971151edt.40.1692901441126;
        Thu, 24 Aug 2023 11:24:01 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id u8-20020aa7d0c8000000b00525503fac84sm36880edo.25.2023.08.24.11.23.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 11:24:00 -0700 (PDT)
Message-ID: <caf8ca09-9436-2d9d-6d7d-d23093572ad3@linaro.org>
Date:   Thu, 24 Aug 2023 20:23:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v5 08/11] firmware: imx: enable trng
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
 <20230823073330.1712721-9-pankaj.gupta@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230823073330.1712721-9-pankaj.gupta@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/08/2023 09:33, Pankaj Gupta wrote:
> Enabled trng on imx93 platform through enclave fw.
> 
> Signed-off-by: Gaurav Jain <gaurav.jain@nxp.com>
> Signed-off-by: Pankaj Gupta <pankaj.gupta@nxp.com>
> ---
>  drivers/firmware/imx/Kconfig              |  9 +++
>  drivers/firmware/imx/Makefile             |  3 +-
>  drivers/firmware/imx/ele_base_msg.c       | 88 +++++++++++++++++++++++
>  drivers/firmware/imx/ele_common.c         | 44 +++++++++++-
>  drivers/firmware/imx/ele_common.h         |  2 +
>  drivers/firmware/imx/ele_fw_api.c         | 54 ++++++++++++++
>  drivers/firmware/imx/ele_trng.c           | 48 +++++++++++++
>  drivers/firmware/imx/se_fw.c              | 23 +++++-
>  include/linux/firmware/imx/ele_base_msg.h | 11 +++
>  include/linux/firmware/imx/ele_fw_api.h   |  5 ++
>  10 files changed, 283 insertions(+), 4 deletions(-)
>  create mode 100644 drivers/firmware/imx/ele_trng.c
> 

firmware is not a place for RNG driver. You did not even CC RNG folks...

> +
> +int ele_trng_init(struct device *dev)
> +{
> +	struct ele_trng *trng;
> +	int ret;
> +
> +	trng = devm_kzalloc(dev, sizeof(*trng), GFP_KERNEL);
> +	if (!trng)
> +		return -ENOMEM;
> +
> +	trng->dev         = dev;
> +	trng->rng.name    = "ele-trng";
> +	trng->rng.read    = ele_get_hwrng;
> +	trng->rng.priv    = (unsigned long)trng;
> +	trng->rng.quality = 1024;
> +
> +	dev_dbg(dev, "registering ele-trng\n");
> +
> +	ret = devm_hwrng_register(dev, &trng->rng);
> +	if (ret)
> +		return ret;
> +
> +	dev_info(dev, "Successfully registered ele-trng\n");

Drop all simple trace replacements. Use tracing.

> +	return 0;
> +}
> +
> +int ele_get_hwrng(struct hwrng *rng,
> +		  void *data, size_t len, bool wait)
> +{
> +	struct ele_trng *trng = (struct ele_trng *)rng->priv;
> +
> +	return ele_get_random(trng->dev, data, len);
> +}
> diff --git a/drivers/firmware/imx/se_fw.c b/drivers/firmware/imx/se_fw.c
> index 88300c41d62b..6083c42dcda3 100644
> --- a/drivers/firmware/imx/se_fw.c
> +++ b/drivers/firmware/imx/se_fw.c
> @@ -21,10 +21,10 @@
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
> -#include <linux/delay.h>
>  #include <linux/sys_soc.h>
>  
>  #include "se_fw.h"
> +#include "ele_common.h"
>  
>  #define SOC_ID_OF_IMX8ULP		0x084D
>  #define SOC_ID_OF_IMX93			0x9300
> @@ -43,6 +43,9 @@ struct imx_info {
>  	uint8_t *pool_name;
>  	bool reserved_dma_ranges;
>  	bool init_fw;
> +	/* platform specific flag to enable/disable the ELE True RNG */
> +	bool start_rng;
> +	bool enable_ele_trng;
>  };
>  
>  static LIST_HEAD(priv_data_list);
> @@ -58,6 +61,8 @@ static const struct imx_info imx8ulp_info = {
>  	.pool_name = "sram-pool",
>  	.reserved_dma_ranges = true,
>  	.init_fw = false,
> +	.start_rng = true,
> +	.enable_ele_trng = false,
>  };
>  
>  static const struct imx_info imx93_info = {
> @@ -71,6 +76,8 @@ static const struct imx_info imx93_info = {
>  	.pool_name = NULL,
>  	.reserved_dma_ranges = true,
>  	.init_fw = true,
> +	.start_rng = true,
> +	.enable_ele_trng = true,
>  };
>  
>  static const struct of_device_id se_fw_match[] = {
> @@ -1140,9 +1147,23 @@ static int se_fw_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	/* start ele rng */
> +	if (info->start_rng) {
> +		ret = ele_do_start_rng(dev);
> +		if (ret)
> +			dev_err(dev, "Failed to start ele rng\n");
> +	}
> +
> +	if (!ret && info->enable_ele_trng) {
> +		ret = ele_trng_init(dev);
> +		if (ret)
> +			dev_err(dev, "Failed to init ele-trng\n");
> +	}
> +
>  	pr_info("i.MX secure-enclave: %s's mu#%d interface to firmware, configured.\n",

dev_info

>  		info->se_name,
>  		priv->ele_mu_id);
> +

Not related.

>  	return devm_of_platform_populate(dev);
>  



Best regards,
Krzysztof

