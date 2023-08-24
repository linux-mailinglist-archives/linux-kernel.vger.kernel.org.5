Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1936E7875C3
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Aug 2023 18:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242680AbjHXQn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Aug 2023 12:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242738AbjHXQnM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Aug 2023 12:43:12 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2BE199E
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:42:46 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-99bcfe28909so881820066b.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Aug 2023 09:42:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692895360; x=1693500160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FRVTXGz++H59+3nilaNeFjWdjJ3kSI1rYdkOaYMbR6Q=;
        b=OWz1mxqSKTG4Ws2n2ob+Ev6MkMfo5kvPd3Rs+GO1KhxPkDJOulx9VXNWBvJLPLkCsU
         vf1r9HBJ5D759cqH5P8/XIaC5Zi3iLuWfNwj/3paWaicMP2kH6PMY7W67o6LOtJqnrq3
         fjYrHJ1/LnQveippW69F7alZZqB/5sBGxBtgV8NPsMGumtmU1IDbT1TPwfeLmfYBAZdg
         YVpbR9YS0hP4SwlX/ygDqBrEJCOEfBy3pqdNdEZXaTVVX/BH5ZLvxHqwSItHJF4Dy1KD
         0xNjyXq7JDoPFVnY10J1oUSTaZlPfFTn399TpLVCBNwssIRB5a2zX78ZRbjmRPz/EEWD
         qy9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692895360; x=1693500160;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FRVTXGz++H59+3nilaNeFjWdjJ3kSI1rYdkOaYMbR6Q=;
        b=PQQaKx1RUpjealfzw3l1XeVdNK1jeFNiFYQbOtYgmhBu6xgEf0CDniIQG/+r/HVaNQ
         akCk6clrsOSdvOF0Mno/t2Q2uzI7fGzYs68b0mFiu6/uiVnQEd19vsOh+ZDbIvafrxDF
         fdBU0obhHdPlOD5j6f6ePDQwQ2khRMyRWJ2IE4aU8CEYg7uWZCRV8EkA9CFLGfCzbpBU
         XOE9nz10CzcvO4QDeIyKhMcT5leKDRDj4f0VV+EppW0SzaMDO1p/A2do8KkZ7nRkURZu
         2e0MuDkz3UQtxitjPwoFElvledExhMNJbsNGO0yQynJcAvkAvBbQwKp6CIGd7GJYJ9pF
         R4VA==
X-Gm-Message-State: AOJu0Yy4msYq2iD6IgRIGvU8rSbvF/kRGgHk2sjJj3IZd8FsjWLq1n9U
        NYPmIAT+dyBLKnKijVi8Wpgsbw==
X-Google-Smtp-Source: AGHT+IF6dqWQ4k0Xod7n5CRdbTReJzNMx54la11pA1FVG0NFk2R7/E+0l/ShfQPPpCjJ/TVSTT1tSw==
X-Received: by 2002:a17:907:77c4:b0:993:d536:3cb7 with SMTP id kz4-20020a17090777c400b00993d5363cb7mr12802741ejc.11.1692895360669;
        Thu, 24 Aug 2023 09:42:40 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id o15-20020a1709061b0f00b00985ed2f1584sm11172780ejg.187.2023.08.24.09.42.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Aug 2023 09:42:40 -0700 (PDT)
Message-ID: <78007d9e-99ef-0922-2198-83e8c674b82c@linaro.org>
Date:   Thu, 24 Aug 2023 18:42:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v2 2/3] arm64: dts: imx93: add dma support for
 lpuart[1..9]
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, festevam@gmail.com
Cc:     clin@suse.com, conor+dt@kernel.org, devicetree@vger.kernel.org,
        eagle.zhou@nxp.com, imx@lists.linux.dev, joy.zou@nxp.com,
        kernel@pengutronix.de, krzysztof.kozlowski+dt@linaro.org,
        leoyang.li@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-imx@nxp.com, linux-kernel@vger.kernel.org,
        pierre.gondois@arm.com, robh+dt@kernel.org, s.hauer@pengutronix.de,
        shawnguo@kernel.org, shenwei.wang@nxp.com, sherry.sun@nxp.com
References: <20230824163922.2952403-1-Frank.Li@nxp.com>
 <20230824163922.2952403-5-Frank.Li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230824163922.2952403-5-Frank.Li@nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/08/2023 18:39, Frank Li wrote:
> Add dma support for lpuart[1..9].
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx93.dtsi | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/freescale/imx93.dtsi b/arch/arm64/boot/dts/freescale/imx93.dtsi
> index acdca18673b7..849543d35ed7 100644
> --- a/arch/arm64/boot/dts/freescale/imx93.dtsi
> +++ b/arch/arm64/boot/dts/freescale/imx93.dtsi
> @@ -336,6 +336,8 @@ lpuart1: serial@44380000 {
>  				interrupts = <GIC_SPI 19 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX93_CLK_LPUART1_GATE>;
>  				clock-names = "ipg";
> +				dmas = <&edma1 16 0 0>, <&edma1 17 0 1>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -345,6 +347,8 @@ lpuart2: serial@44390000 {
>  				interrupts = <GIC_SPI 20 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX93_CLK_LPUART2_GATE>;
>  				clock-names = "ipg";
> +				dmas = <&edma1 18 0 0>, <&edma1 19 0 1>;
> +				dma-names = "tx", "rx";
>  				status = "disabled";
>  			};
>  
> @@ -666,6 +670,8 @@ lpuart3: serial@42570000 {
>  				interrupts = <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>;
>  				clocks = <&clk IMX93_CLK_LPUART3_GATE>;
>  				clock-names = "ipg";
> +				dmas = <&edma2 17 0 0>, <&edma2 18 0 1>;
> +				dma-names = "tx","rx";

Missing space after ,

Best regards,
Krzysztof

