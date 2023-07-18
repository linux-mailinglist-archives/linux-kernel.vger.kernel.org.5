Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B958C757435
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jul 2023 08:32:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231215AbjGRGcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jul 2023 02:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230195AbjGRGb7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jul 2023 02:31:59 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDDE4136
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:31:56 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-992b27e1c55so689064566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 23:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689661915; x=1692253915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6/hoyrn/wbGIYhczZbohLc08mPQz2c//diCGmR1SNCs=;
        b=cCmezODa1Zjk5YSZs21FFtyeirFpNuGyUodWN+5TlWZsJa+qY5zs9WlubMvpARwvZY
         bzLaAqqioBCuU+IlEAPAlI+vMZ+zl2wdk0ro+1dDnRORUSUljNJFsd6HcPTCt9k/SnKT
         LxUc9/eWkFkfcIYUhva3oixOyjezyOHJh5buJqjwk07gRvfr1UwQf1ndI37EBoAC2D/8
         /c714FVYY5ZrUa4V4SsDaiuOBV4shvtV4K1/Psd37zoYBp8UFTF0M2PrqtQ8Ykiv8V5P
         QfzvViNO3lcgseWuEW2LaZ2f5wdIOENnphA0WuCbClPvlCGzjIk02sS3ouxropnl6xT6
         wuOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689661915; x=1692253915;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/hoyrn/wbGIYhczZbohLc08mPQz2c//diCGmR1SNCs=;
        b=DvGA8hxZSg5kzSRXbJ2ap5Vy2z0PPhKHLAliaD7T12xjM1Si4tHmb+HGT7fXD4Rr/4
         7ILsWQNBs/77Sjby6rPyVnTVrF9TizzTJuU0QQkYJ1ECdDnLkXZSWIo61jL/9QeMD3wX
         6tBny2y0kBEvKUXj4yaqTpsf6rOJvcw1gCKAD0N3idLSlMkx1jlyZz1PSlGHUs1lbN76
         CJksURKjUBZQaBBpRxmtdLkV+eGgikW7QgoVxfjvCwODJQspObHGOKKH6pAEB+5MekEQ
         KcgAUkARpnOmfBhmWtDcLUpV0kyxRNHBQ3HdZm4LMAlPk23JC9dcJO3+MAVmH4/cKemX
         qqpg==
X-Gm-Message-State: ABy/qLYivrCKA/1+BLUZAMZGDNUHSWVHg65HCDepPs27juWLYThVSvYR
        +BgkXSVmt7gFEjCMrtF6GULdgw==
X-Google-Smtp-Source: APBJJlHURaF/a0OqM8YRJRdaBe/gIR6bagjx9zEXyeMpdO5aKCJG+sg2VCR+Gp+Fl7AXhUigQq4zOg==
X-Received: by 2002:a05:6402:7c4:b0:51e:5cab:feb9 with SMTP id u4-20020a05640207c400b0051e5cabfeb9mr12767227edy.33.1689661915337;
        Mon, 17 Jul 2023 23:31:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id ca17-20020aa7cd71000000b0051e249f3dc6sm704832edb.72.2023.07.17.23.31.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 23:31:54 -0700 (PDT)
Message-ID: <1f400879-03e4-9a36-b6db-91f53f70a866@linaro.org>
Date:   Tue, 18 Jul 2023 08:31:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v9 4/7] usb: misc: eud: Add driver support for SM6115 /
 SM4250
Content-Language: en-US
To:     Bhupesh Sharma <bhupesh.sharma@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linux-kernel@vger.kernel.org, bhupesh.linux@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        quic_schowdhu@quicinc.com, gregkh@linuxfoundation.org,
        stephan@gerhold.net
References: <20230718061052.1332993-1-bhupesh.sharma@linaro.org>
 <20230718061052.1332993-5-bhupesh.sharma@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230718061052.1332993-5-bhupesh.sharma@linaro.org>
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

On 18/07/2023 08:10, Bhupesh Sharma wrote:
> Add SM6115 / SM4250 SoC EUD support in qcom_eud driver.
> 
> On some SoCs (like the SM6115 / SM4250 SoC), the mode manager
> needs to be accessed only via the secure world (through 'scm'
> calls).
> 
> Also, the enable bit inside 'tcsr_check_reg' needs to be set
> first to set the eud in 'enable' mode on these SoCs.
> 
> Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> ---
>  drivers/usb/misc/Kconfig    |  2 +-
>  drivers/usb/misc/qcom_eud.c | 76 ++++++++++++++++++++++++++++++++++---
>  2 files changed, 72 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/usb/misc/Kconfig b/drivers/usb/misc/Kconfig
> index 99b15b77dfd57..51eb5140caa14 100644
> --- a/drivers/usb/misc/Kconfig
> +++ b/drivers/usb/misc/Kconfig
> @@ -146,7 +146,7 @@ config USB_APPLEDISPLAY
>  
>  config USB_QCOM_EUD
>  	tristate "QCOM Embedded USB Debugger(EUD) Driver"
> -	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on (ARCH_QCOM && QCOM_SCM) || COMPILE_TEST
>  	select USB_ROLE_SWITCH
>  	help
>  	  This module enables support for Qualcomm Technologies, Inc.
> diff --git a/drivers/usb/misc/qcom_eud.c b/drivers/usb/misc/qcom_eud.c
> index 7f371ea1248c3..a5b28fc24116a 100644
> --- a/drivers/usb/misc/qcom_eud.c
> +++ b/drivers/usb/misc/qcom_eud.c
> @@ -11,9 +11,12 @@
>  #include <linux/kernel.h>
>  #include <linux/module.h>
>  #include <linux/of.h>
> +#include <linux/of_address.h>
> +#include <linux/of_device.h>
>  #include <linux/platform_device.h>
>  #include <linux/slab.h>
>  #include <linux/sysfs.h>
> +#include <linux/firmware/qcom/qcom_scm.h>
>  #include <linux/usb/role.h>
>  
>  #define EUD_REG_INT1_EN_MASK	0x0024
> @@ -30,6 +33,10 @@
>  #define EUD_INT_SAFE_MODE	BIT(4)
>  #define EUD_INT_ALL		(EUD_INT_VBUS | EUD_INT_SAFE_MODE)
>  
> +#define EUD_EN2_EN		BIT(0)
> +#define EUD_EN2_DISABLE		(0)
> +#define TCSR_CHECK_EN		BIT(0)
> +
>  struct eud_chip {
>  	struct device			*dev;
>  	struct usb_role_switch		*role_sw;
> @@ -39,6 +46,7 @@ struct eud_chip {
>  	int				irq;
>  	bool				enabled;
>  	bool				usb_attached;
> +	phys_addr_t			secure_mode_mgr;
>  };
>  
>  static int enable_eud(struct eud_chip *priv)
> @@ -46,7 +54,11 @@ static int enable_eud(struct eud_chip *priv)
>  	writel(EUD_ENABLE, priv->base + EUD_REG_CSR_EUD_EN);
>  	writel(EUD_INT_VBUS | EUD_INT_SAFE_MODE,
>  			priv->base + EUD_REG_INT1_EN_MASK);
> -	writel(1, priv->mode_mgr + EUD_REG_EUD_EN2);
> +
> +	if (priv->secure_mode_mgr)
> +		qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, EUD_EN2_EN);
> +	else
> +		writel(EUD_EN2_EN, priv->mode_mgr + EUD_REG_EUD_EN2);
>  
>  	return usb_role_switch_set_role(priv->role_sw, USB_ROLE_DEVICE);
>  }
> @@ -54,7 +66,11 @@ static int enable_eud(struct eud_chip *priv)
>  static void disable_eud(struct eud_chip *priv)
>  {
>  	writel(0, priv->base + EUD_REG_CSR_EUD_EN);
> -	writel(0, priv->mode_mgr + EUD_REG_EUD_EN2);
> +
> +	if (priv->secure_mode_mgr)
> +		qcom_scm_io_writel(priv->secure_mode_mgr + EUD_REG_EUD_EN2, EUD_EN2_DISABLE);
> +	else
> +		writel(EUD_EN2_DISABLE, priv->mode_mgr + EUD_REG_EUD_EN2);
>  }
>  
>  static ssize_t enable_show(struct device *dev,
> @@ -175,9 +191,37 @@ static void eud_role_switch_release(void *data)
>  	usb_role_switch_put(chip->role_sw);
>  }
>  
> +static int eud_find_secure_reg_addr(struct device *dev, u64 *addr)
> +{
> +	struct device_node *tcsr;
> +	struct device_node *np = dev->of_node;
> +	struct resource res;
> +	u32 offset;
> +	int ret;
> +
> +	tcsr = of_parse_phandle(np, "qcom,secure-eud-reg", 0);
> +	if (!tcsr)
> +		return 0;
> +
> +	ret = of_address_to_resource(tcsr, 0, &res);
> +	of_node_put(tcsr);
> +	if (ret)
> +		return ret;
> +
> +	ret = of_property_read_u32_index(np, "qcom,secure-eud-reg", 1, &offset);
> +	if (ret < 0)
> +		return ret;
> +
> +	*addr = res.start + offset;
> +
> +	return 0;
> +}
> +
>  static int eud_probe(struct platform_device *pdev)
>  {
>  	struct eud_chip *chip;
> +	struct resource *res;
> +	phys_addr_t tcsr_check = 0;
>  	int ret;
>  
>  	chip = devm_kzalloc(&pdev->dev, sizeof(*chip), GFP_KERNEL);
> @@ -200,9 +244,30 @@ static int eud_probe(struct platform_device *pdev)
>  	if (IS_ERR(chip->base))
>  		return PTR_ERR(chip->base);
>  
> -	chip->mode_mgr = devm_platform_ioremap_resource(pdev, 1);
> -	if (IS_ERR(chip->mode_mgr))
> -		return PTR_ERR(chip->mode_mgr);
> +	/*
> +	 * EUD block on a few Qualcomm SoCs needs secure register access.
> +	 * Check for the same via vendor-specific dt property.
> +	 */
> +	ret = eud_find_secure_reg_addr(&pdev->dev, &tcsr_check);
> +	if (ret < 0)
> +		return ret;
> +
> +	if (tcsr_check) {
> +		res = platform_get_resource(pdev, IORESOURCE_MEM, 1);

I don't understand this code. If you have syscon to eud reg, then why
you are not using it, but instead map again second address space?

> +		if (!res)
> +			return dev_err_probe(chip->dev, -ENODEV,
> +					     "failed to get secure_mode_mgr reg base\n");
> +
> +		chip->secure_mode_mgr = res->start;
> +
> +		ret = qcom_scm_io_writel(tcsr_check, TCSR_CHECK_EN);

That's not how syscon is used. Your bindings defined it as syscon, so
are you sure you are using it correctly?



Best regards,
Krzysztof

