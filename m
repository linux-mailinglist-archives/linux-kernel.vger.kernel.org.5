Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B696755BEC
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 08:42:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229723AbjGQGmW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 02:42:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjGQGmT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 02:42:19 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2788BE9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:42:18 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id a640c23a62f3a-992af8b3b1bso589071266b.1
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jul 2023 23:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689576136; x=1692168136;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PEdIruOcJDsncB8g/cr28wY8s4d8mWPOw/5cBn7GAk8=;
        b=FbLNDLcRkUilKetuPaGaqG2bK4Nj+7NJVpXmO7ekzwM0EndEOy1t6UDB3w2ZDUaHuZ
         5qpR5yojaV5EXsg2uQHW3oaGPYOE5UMnwAElJaSoJvdMu8HCCWOZNTIYtnAow8EYoRDc
         zLzTJhB1KuO58NAG0evIQLllBeqiX+5bDzUbUAm57GFFC8AyoxWvMwuy5Y7XEDHZDCRs
         Vkt15gwmhG+OH3CSx5MrzRWEYSIOPfMhJTH8JKo6RaT1wocBDg+MkTQcJFwiyCKx8i19
         cIGzwD0dRWgTpe5BcVXtOaPzc2xAhsfEvtA2keAD73Qzq6lG5zzNxJG4drkyX5iXWp+O
         iwsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689576136; x=1692168136;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PEdIruOcJDsncB8g/cr28wY8s4d8mWPOw/5cBn7GAk8=;
        b=LH1U5PNZzjeIVuadqPScVf0gr1gQn4dnfgoWvK4LzAo1lfg+AupjaPmPukSvahr/WV
         GiFJ+b13N+AehiB3tchFStOfcsYEfva8GVUZ/Npqn7/O9rKhLifuUaApDZH5iuW6SWs5
         0RIQd+080wFzkVtrk30Upc8Bcm8GwqrRZ+uAzhnSCZW+7toT/NFlAe+sw3eNl2xZ4Dlk
         2ebac1GOuZdmJdNdw3xXj0zV+Zr09GeWHZ+aGCDSWFzPDKMimV5OiJZ8bQOl5U/Y8VQX
         meoSnfeA0D7f3ALR/uM55+njP+LrRdMTsgqXbWEDG4DtdwCgMzxOnzJVHNU8TxxrWaif
         bFdA==
X-Gm-Message-State: ABy/qLb4yz9MZFFKfIQtNv0HaVpcwdfhFn2sRZmj/GxqJiJmr1qoymAj
        tqMpfk8v7P+8eMT6ZBJVJyfcLw==
X-Google-Smtp-Source: APBJJlGm2i9HqSmfDXPyydX+fQKn5BA+rsGZKTYySHXz4VdhiAJFCFzF0bHROuhr15zIqR6T5Qo5dQ==
X-Received: by 2002:a17:906:20a:b0:993:fba5:cdf1 with SMTP id 10-20020a170906020a00b00993fba5cdf1mr11783261ejd.22.1689576136579;
        Sun, 16 Jul 2023 23:42:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id ss25-20020a170907039900b0098921e1b064sm8748519ejb.181.2023.07.16.23.42.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Jul 2023 23:42:16 -0700 (PDT)
Message-ID: <67e61d59-ae53-c1ec-3325-1ea952a950e9@linaro.org>
Date:   Mon, 17 Jul 2023 08:42:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] arm64: dts: exynos: add pwm node for exynosautov9-sadk
Content-Language: en-US
To:     Jaewon Kim <jaewon02.kim@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <CGME20230717063837epcas2p3780fbf0f8c12ca070aa296766d0eb5e8@epcas2p3.samsung.com>
 <20230717063319.19974-1-jaewon02.kim@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717063319.19974-1-jaewon02.kim@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 08:33, Jaewon Kim wrote:
> Add pwm node to support fan on exynosautov9-sadk board.
> PWM channel 3 of ExynosAutov9 is connected to fan for SoC cooling
> in SADK board.
> 
> Signed-off-by: Jaewon Kim <jaewon02.kim@samsung.com>
> ---
> Changes in v3:
>  - removed adding compatible to driver.
> 
> Changes in v2:
>  - add compatible string to driver.
> ---
>  arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts |  6 ++++++
>  arch/arm64/boot/dts/exynos/exynosautov9.dtsi     | 10 ++++++++++
>  2 files changed, 16 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
> index 898c2fc345ed..e717bb1cad81 100644
> --- a/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
> +++ b/arch/arm64/boot/dts/exynos/exynosautov9-sadk.dts
> @@ -50,6 +50,12 @@
>  	};
>  };
>  
> +&pwm {
> +	pinctrl-names = "default";
> +	pinctrl-0 = <&pwm_tout3>;
> +	status = "okay";
> +};
> +
>  &serial_0 {
>  	pinctrl-0 = <&uart0_bus_dual>;
>  	status = "okay";
> diff --git a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
> index d3c5cdeff47f..3b906f4db907 100644
> --- a/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
> +++ b/arch/arm64/boot/dts/exynos/exynosautov9.dtsi
> @@ -1560,6 +1560,16 @@
>  			samsung,syscon-phandle = <&pmu_system_controller>;
>  			samsung,cluster-index = <1>;
>  		};
> +
> +		pwm: pwm@103f0000 {
> +			compatible = "samsung,exynosautov9-pwm",
> +				     "samsung,exynos4210-pwm";

It does not look like you tested the DTS against bindings. Please run
`make dtbs_check` (see
Documentation/devicetree/bindings/writing-schema.rst or
https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
for instructions).

Full DT schema compliance is a requirement for Samsung (since some time).

Best regards,
Krzysztof

