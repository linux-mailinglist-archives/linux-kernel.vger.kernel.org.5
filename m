Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89576766FC5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jul 2023 16:47:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbjG1Orf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jul 2023 10:47:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237156AbjG1Ora (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jul 2023 10:47:30 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEEE5421C;
        Fri, 28 Jul 2023 07:47:22 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-686b879f605so1543416b3a.1;
        Fri, 28 Jul 2023 07:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1690555642; x=1691160442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=QACIBEcV1r2Mkf1JqDfdoATefDObW7+anJzfPY99Gis=;
        b=GTGsF003YcxUNIrHANoxXK2ROnhxjXUsKCs9Z9jSXRl3noutQ3mFPnO1mL59Whzi/3
         NNbPiOPyKXVgl3uinHxK8Az3NdLeq0QfYk7i5eFVnm6K1GtTn8UZYj0XgtN55xXveVM6
         ZLz7JzyKLxaZLaxK27dq5yxuNHiezZ6UifRowCGPeIOKOGVWPV+RCvAK5ybbEagqRWH8
         1iIx+Q76u+QS+aXJV2pJb5tRmKwdEOkEUNWEnsoZQOR835/BYA5HullATumi57NzaAEM
         DNo2/gxJd84ZqDlnFMD50xuj+GdzRG3Py9CAqOHLBE4SRip/xBqj7ayBM8MS8sdQPiKs
         /tdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690555642; x=1691160442;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QACIBEcV1r2Mkf1JqDfdoATefDObW7+anJzfPY99Gis=;
        b=ibyqxJ9mZIF/xjVUuhqosWTG5CWyFthG6LuuMikeZaJxY1g6PwS9HvRKsiIpqxZnB2
         eFXA5/JE1e8uP/GgFxL0H5Sr46LxS9Qfl07DNB5p5QWt2HjYo6d+aM8l7Ph4pAK0tDTe
         VRmyAZTie2iwjUO9/AUFop3tcerODXEbeyi8TQndVc+toJLnCnT10zIy+Fhj3aD1VPWy
         iiPbro80A2SzYv36tKl7VQYS6lQzBgbE855tIfqfTRbUVgfkpmyLY/patvFgHPACN8+f
         sLm8B2SXnnskQpAqe4zFC4gZQeVky89w47DMlicJnibNlzTqsZjJeiPmT/O9wikQ+xhu
         AE+g==
X-Gm-Message-State: ABy/qLavjwVjEKYqgGhc6YTrGHUC3qOYRV9EtpDR2U0IhCYqaEn25JvH
        r7n6gzBmUxK5iehm88XlFmo=
X-Google-Smtp-Source: APBJJlHHOzMz4IVNTKgOdtU38ZVCABRqOaV+Z3PvDEbedYM+li2BTliHj7nOKFNighRtOxMW0COmKw==
X-Received: by 2002:a05:6a00:2d84:b0:66a:613f:87e1 with SMTP id fb4-20020a056a002d8400b0066a613f87e1mr2036078pfb.8.1690555642070;
        Fri, 28 Jul 2023 07:47:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id x1-20020aa784c1000000b006827c26f147sm3299575pfn.138.2023.07.28.07.47.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Jul 2023 07:47:21 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <849c86ac-6f24-828f-664b-a3c209056072@roeck-us.net>
Date:   Fri, 28 Jul 2023 07:47:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4 2/2] usb: typec: qcom-pmic-typec: register drm_bridge
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230728110942.485358-1-dmitry.baryshkov@linaro.org>
 <20230728110942.485358-3-dmitry.baryshkov@linaro.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230728110942.485358-3-dmitry.baryshkov@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/28/23 04:09, Dmitry Baryshkov wrote:
> The current approach to handling DP on bridge-enabled platforms requires
> a chain of DP bridges up to the USB-C connector. Register a last DRM
> bridge for such chain.
> 
> Acked-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
> Signed-off-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> ---
>   drivers/usb/typec/tcpm/Kconfig                |  1 +
>   drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c | 35 +++++++++++++++++++
>   2 files changed, 36 insertions(+)
> 
> diff --git a/drivers/usb/typec/tcpm/Kconfig b/drivers/usb/typec/tcpm/Kconfig
> index 5d393f520fc2..0b2993fef564 100644
> --- a/drivers/usb/typec/tcpm/Kconfig
> +++ b/drivers/usb/typec/tcpm/Kconfig
> @@ -79,6 +79,7 @@ config TYPEC_WCOVE
>   config TYPEC_QCOM_PMIC
>   	tristate "Qualcomm PMIC USB Type-C Port Controller Manager driver"
>   	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on DRM || DRM=n
>   	help
>   	  A Type-C port and Power Delivery driver which aggregates two
>   	  discrete pieces of silicon in the PM8150b PMIC block: the
> diff --git a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> index af44ee4e6e86..0ea7cc656089 100644
> --- a/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> +++ b/drivers/usb/typec/tcpm/qcom/qcom_pmic_typec.c
> @@ -17,6 +17,9 @@
>   #include <linux/usb/role.h>
>   #include <linux/usb/tcpm.h>
>   #include <linux/usb/typec_mux.h>
> +
> +#include <drm/drm_bridge.h>
> +
>   #include "qcom_pmic_typec_pdphy.h"
>   #include "qcom_pmic_typec_port.h"
>   
> @@ -33,6 +36,7 @@ struct pmic_typec {
>   	struct pmic_typec_port	*pmic_typec_port;
>   	bool			vbus_enabled;
>   	struct mutex		lock;		/* VBUS state serialization */
> +	struct drm_bridge	bridge;
>   };
>   
>   #define tcpc_to_tcpm(_tcpc_) container_of(_tcpc_, struct pmic_typec, tcpc)
> @@ -146,6 +150,33 @@ static int qcom_pmic_typec_init(struct tcpc_dev *tcpc)
>   	return 0;
>   }
>   
> +#ifdef CONFIG_DRM

Sorry for not noticing earlier. This needs to be "#if IS_ENABLED(CONFIG_DRM)"
or otherwise would not catch DRM=m situations.

> +static int qcom_pmic_typec_attach(struct drm_bridge *bridge,
> +				     enum drm_bridge_attach_flags flags)
> +{
> +	return flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR ? 0 : -EINVAL;
> +}
> +
> +static const struct drm_bridge_funcs qcom_pmic_typec_bridge_funcs = {
> +	.attach = qcom_pmic_typec_attach,
> +};
> +
> +static int qcom_pmic_typec_init_drm(struct pmic_typec *tcpm)
> +{
> +	tcpm->bridge.funcs = &qcom_pmic_typec_bridge_funcs;
> +	tcpm->bridge.of_node = of_get_child_by_name(tcpm->dev->of_node, "connector");
> +	tcpm->bridge.ops = DRM_BRIDGE_OP_HPD;
> +	tcpm->bridge.type = DRM_MODE_CONNECTOR_DisplayPort;
> +
> +	return devm_drm_bridge_add(tcpm->dev, &tcpm->bridge);
> +}
> +#else
> +static int qcom_pmic_typec_init_drm(struct pmic_typec *tcpm)
> +{
> +	return 0;
> +}
> +#endif
> +
>   static int qcom_pmic_typec_probe(struct platform_device *pdev)
>   {
>   	struct pmic_typec *tcpm;
> @@ -208,6 +239,10 @@ static int qcom_pmic_typec_probe(struct platform_device *pdev)
>   	mutex_init(&tcpm->lock);
>   	platform_set_drvdata(pdev, tcpm);
>   
> +	ret = qcom_pmic_typec_init_drm(tcpm);
> +	if (ret)
> +		return ret;
> +
>   	tcpm->tcpc.fwnode = device_get_named_child_node(tcpm->dev, "connector");
>   	if (!tcpm->tcpc.fwnode)
>   		return -EINVAL;

