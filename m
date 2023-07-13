Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D3D7518F5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 08:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234071AbjGMGml (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 02:42:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234066AbjGMGmj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 02:42:39 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D231FC1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:42:37 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-992e22c09edso52467166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 23:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689230556; x=1691822556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BSt7u0Sc9Vem3CfN5X9xcaSpmhIk1PDLkSVMI4fwOPg=;
        b=TK3UqWtW5jy8LXh4zDby2NUmXALyN8cEkwC8Wbh/9zE1mngXnSB0fqgw1vlWxQ8tpu
         kMoOsUYxq4LGQMUUieG+Eu7AKY+uw7R4YEzqdRTxlHwYK3+TTvV7iJRidALeLz0dW42a
         T3lqbGfNHWdlJhpMdY8sMs7RuVxOw5o9Ppus/86gFHD2nLuBaOwVP48NUiObyqz1iUnF
         Nip8kQZ5QFtGxJm7/2D12HhT1/M8djNUCNzEywZBWV2SuHzMD26Bib3aMTCj3ZyeIxRv
         pOrke9IhbigptWfEba10QWUblSuUDO/i9MI9/aQPaV1FFJD6edChs3/p/crN8+iPBnDc
         EPaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689230556; x=1691822556;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BSt7u0Sc9Vem3CfN5X9xcaSpmhIk1PDLkSVMI4fwOPg=;
        b=cJJdorcAVfFgbk7cg7wcCDGHN9Q6xKM0ji4HL0QrgmLiGHErB5KmOVEc8++tXspDGG
         rEwLi0ID6sV9KnGM49GYYK6rcRud+kSanoVU6gwLk17z2FqISMnqx2+HeU6gTXI7fbaB
         ige6/nxXG8+1RjaQCY3hNxn+SAEnImZNq/t+GSlxUIxPEkumi6NVgDnF1uzL5IkmONMK
         34wp7Edcfm2IWiMobAS2u7cfCBG95GzAYdqry1avi9kMLfILyNwxGYPon5CEo28FBhHL
         1rF3H4ligGsuCKFcUmGdUS2xymo0dsyNIkufkOzV5VKtjRZIhEvA46GGG21TUdx6ywfh
         Klyg==
X-Gm-Message-State: ABy/qLbNngWSB53LVMZxfYucOUA1j9jG2qOEPi7FAHek9CDYq/bhZrJR
        KIh2W++TiFzT0F0VRHX18CLR0A==
X-Google-Smtp-Source: APBJJlEZJzW/Qw657V+8gEDjtbWsMydVs10Uuk56/6E0mi3aaxaq0vdrWaWQXy+wlOu5ERWJv8Q3Fw==
X-Received: by 2002:a17:906:280e:b0:992:7329:fe4f with SMTP id r14-20020a170906280e00b009927329fe4fmr602515ejc.73.1689230556409;
        Wed, 12 Jul 2023 23:42:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id p27-20020a170906141b00b00977eec7b7e8sm3539230ejc.68.2023.07.12.23.42.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 23:42:36 -0700 (PDT)
Message-ID: <7f0f8000-0e90-6414-44e0-6652b5f1c54f@linaro.org>
Date:   Thu, 13 Jul 2023 08:42:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 2/3] arm64: dts: imx8qm: add thermal zone and cooling map
Content-Language: en-US
To:     Frank Li <Frank.Li@nxp.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Pierre Gondois <pierre.gondois@arm.com>,
        Li Yang <leoyang.li@nxp.com>, Zhou Peng <eagle.zhou@nxp.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        open list <linux-kernel@vger.kernel.org>
Cc:     imx@lists.linux.dev
References: <20230712211755.1538847-1-Frank.Li@nxp.com>
 <20230712211755.1538847-2-Frank.Li@nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230712211755.1538847-2-Frank.Li@nxp.com>
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

On 12/07/2023 23:17, Frank Li wrote:
> Add thermal zone and cooling map for cpufreq.
> 
> Signed-off-by: Frank Li <Frank.Li@nxp.com>
> ---
>  arch/arm64/boot/dts/freescale/imx8qm.dtsi | 135 ++++++++++++++++++++++
>  1 file changed, 135 insertions(+)

...

>  
>  		A53_L2: l2-cache0 {
> @@ -284,6 +291,134 @@ iomuxc: pinctrl {
>  		rtc: rtc {
>  			compatible = "fsl,imx8qxp-sc-rtc";
>  		};
> +
> +		tsens: thermal-sensor {
> +			compatible = "fsl,imx-sc-thermal";
> +			#thermal-sensor-cells = <1>;
> +		};
> +	};
> +
> +	thermal-zones {
> +

Drop stray blank lines.

> +		cpu-thermal0 {

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).


Best regards,
Krzysztof

