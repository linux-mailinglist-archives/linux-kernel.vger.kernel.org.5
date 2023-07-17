Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B32D755F9C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 11:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjGQJnP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 05:43:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230348AbjGQJmf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 05:42:35 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D6471BE3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:42:23 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id 4fb4d7f45d1cf-51e344efd75so8839972a12.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 02:42:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689586941; x=1692178941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jCDAGW2zq1t7/jPzA/fgOnsdSvQf00Y9+7qWRffe9fk=;
        b=YQpq3KyVlRs3zZwrdMaJspv9qlA3D8BuY+DwXmoIKajt5fTqGLf+QSAZZyyhs82RSN
         xEgdgoyKHay1QMqkPiG0Ugqgjmm8DSrier9hFO/t83+QPaVQqQupS/dsQQUT5LPiG0mi
         r4GR6mbRKhyocW0NdKhgNk/6Ub+AHt0nEsrHBvmW4wLwIuvcZmQjL98Sgvo2hZ2B+b5B
         pe4eRZ9rKcWQTKdNPVWGNOndXXzjW1GrMM5GBDicW8JEZ58fKPfm8H6NyuqSDpymc0Q9
         UNUWMGlyR+s9MC34KF1v9kDhCTVWZEFQ1X0OGsRo2x9Wy8e6mlK8spIPuGkIIiL7R1db
         MiAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689586941; x=1692178941;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jCDAGW2zq1t7/jPzA/fgOnsdSvQf00Y9+7qWRffe9fk=;
        b=Z8S/6agOLHSdKM/hTor12v/40xOSz7gVN/r3Mk8L6PkVqSw3Va4ADESylVrLFPDuMa
         ZWLCwmO50R/rdatnS+kP0LJLYdmV8xDcujYLBjLizOh8oKKXAB+73IqFh4JEtBStTrso
         FNKQGfibtNQdpqB8BJLcDtP6nHAQ78V7GQ8w93PXaEpTcQaBxitnr/ClbZCMoYHH9Exd
         58dYorHNOW1TDwizT1HZHVnb0I7ttuo38cQ3eKP0Resifv7RKOeQhmz0SZLsSg22QwJz
         QAaE6uqT7Z13ThlTHzquiOXomscDUl8f4oAu5pyDvR1MWFXgLpanlDakNF2V9hZI5Gsr
         UCUg==
X-Gm-Message-State: ABy/qLZqVh5FA9MXmGk9a9t0LfIU89lIWG/GR6BZZE/yQI0HMWjdVfei
        hTr4Rm9DH41X5KwfuKlIlKolQQUqLROd7Usuf6jmTA==
X-Google-Smtp-Source: APBJJlHbgWepWBWj84txt0/Slx87FDXphJzB1ZHPwKsQE0Dqov00G0ZBqyHLIMdatfRuuxL4VcSOoQ==
X-Received: by 2002:a05:6402:524e:b0:51d:cf7b:c9f0 with SMTP id t14-20020a056402524e00b0051dcf7bc9f0mr12003216edd.12.1689586941388;
        Mon, 17 Jul 2023 02:42:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id j4-20020a50ed04000000b0051e2a6cef4fsm9734491eds.36.2023.07.17.02.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 02:42:20 -0700 (PDT)
Message-ID: <9a3dc092-7278-cda1-cd4e-c157e0e2c431@linaro.org>
Date:   Mon, 17 Jul 2023 11:42:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH] usb: dwc2: combine platform specific data for Intel
 Agilex and Stratix10
Content-Language: en-US
To:     Meng Li <Meng.Li@windriver.com>, gregkh@linuxfoundation.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dinguyen@kernel.org, hminas@synopsys.com,
        linux-usb@vger.kernel.org, devicetree@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org
References: <20230717085053.1075077-1-Meng.Li@windriver.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717085053.1075077-1-Meng.Li@windriver.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 10:50, Meng Li wrote:
> Intel Stratix10 is very the same with Agilex platform, the DWC2 IP on
> the Stratix platform also does not support clock-gating. So, based on
> commit 3d8d3504d233("usb: dwc2: Add platform specific data for
> Intel's Agilex"), combine platform specific data for Intel Agilex and
> Stratix10 together. In additional, in order to avoid breaking the old
> device tree, keep compatible string "intel,socfpga-agilex-hsotg" unchanged.
> 
> Signed-off-by: Meng Li <Meng.Li@windriver.com>
> ---
>  Documentation/devicetree/bindings/usb/dwc2.yaml   | 2 ++

Bindings are always separate patch.

>  arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi | 4 ++--

As DTS is.

>  drivers/usb/dwc2/params.c                         | 6 ++++--
>  3 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/usb/dwc2.yaml b/Documentation/devicetree/bindings/usb/dwc2.yaml
> index dc4988c0009c..c98ca98d5033 100644
> --- a/Documentation/devicetree/bindings/usb/dwc2.yaml
> +++ b/Documentation/devicetree/bindings/usb/dwc2.yaml
> @@ -51,6 +51,7 @@ properties:
>                - amlogic,meson-gxbb-usb
>                - amlogic,meson-g12a-usb
>                - intel,socfpga-agilex-hsotg
> +              - intel,socfpga-hsotg

Where is SoC specific compatible?

>            - const: snps,dwc2
>        - const: amcc,dwc-otg
>        - const: apm,apm82181-dwc-otg
> @@ -64,6 +65,7 @@ properties:
>            - const: snps,dwc2
>        - const: samsung,s3c6400-hsotg
>        - const: intel,socfpga-agilex-hsotg
> +      - const: intel,socfpga-hsotg
>  
>    reg:
>      maxItems: 1
> diff --git a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> index ea788a920eab..c5a51636f657 100644
> --- a/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi
> +++ b/arch/arm64/boot/dts/altera/socfpga_stratix10.dtsi

...

> diff --git a/drivers/usb/dwc2/params.c b/drivers/usb/dwc2/params.c
> index 8eab5f38b110..6bb27a24e9e1 100644
> --- a/drivers/usb/dwc2/params.c
> +++ b/drivers/usb/dwc2/params.c
> @@ -93,7 +93,7 @@ static void dwc2_set_s3c6400_params(struct dwc2_hsotg *hsotg)
>  	p->phy_utmi_width = 8;
>  }
>  
> -static void dwc2_set_socfpga_agilex_params(struct dwc2_hsotg *hsotg)
> +static void dwc2_set_socfpga_params(struct dwc2_hsotg *hsotg)

Why? Old name was ok...

>  {
>  	struct dwc2_core_params *p = &hsotg->params;
>  
> @@ -266,7 +266,9 @@ const struct of_device_id dwc2_of_match_table[] = {
>  	{ .compatible = "st,stm32mp15-hsotg",
>  	  .data = dwc2_set_stm32mp15_hsotg_params },
>  	{ .compatible = "intel,socfpga-agilex-hsotg",
> -	  .data = dwc2_set_socfpga_agilex_params },
> +	  .data = dwc2_set_socfpga_params },
> +	{ .compatible = "intel,socfpga-hsotg",
> +	  .data = dwc2_set_socfpga_params },

Aren't they compatible? Why do you need new entry for compatible devices?

Best regards,
Krzysztof

