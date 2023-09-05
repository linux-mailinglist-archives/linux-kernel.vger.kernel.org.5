Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F051579314B
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 23:51:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244503AbjIEVvz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 17:51:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235780AbjIEVvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 17:51:55 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70EC6D2
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 14:51:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c3d3c3db9so468213866b.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 14:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693950710; x=1694555510; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0OrctXb9Gdtz0cB8/n70YML24BhIkm3BFJxz1y6sw0Y=;
        b=jGWmE3u5JnYz5jiEqiYUnLmSDFiMaZnKC0yUyRwJR76x52RWn5jV+QMOeTjP2PvtwT
         8OmgaQk386iTsif/3MqPuFvgrFRKCWj2dMbODH4VDYtNfIM6u+tjts0+HO65xsXJNAwl
         /Kn2eR3lhQCti+WB/WQTGP9f5rJ9OYfSUd9apmT+TrH2I9ceE7ikQrrBjJTPNuouybfk
         Tja7UaRbxEdptJFQUy9PlTa3VgUJ6bwbetpRgtXmDxJpFtRgq7sPSFZ30twsiAeBh1fL
         vLK8fFp+FZ4oW8r14RhtsLm8Va9LlYA51+SnmTdz0dtxWz3CnkYmR7sqJLBbIGfPUJzO
         5ilg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693950710; x=1694555510;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0OrctXb9Gdtz0cB8/n70YML24BhIkm3BFJxz1y6sw0Y=;
        b=NUco6BvLv6H8uDGfeuqubzkyYOjYLdhPGY5Oea8OPUZ+K1b4c1I0GeQSoEFGS6Qqia
         /v/1I0SIMSLNNsmlG573r5wW/uLsH9FkwQNLRFDn00qupQGVnKDYs+1VLA2560piNd1b
         qpKXd6EEQ8xvBBRrlldarLfDpNcVLhBUurGnx+dEDIFof81v3KJFhQQl5/v6zj+7CME4
         hwF1H2iA5BG0lS3kMdI12GfI31sUNdQYXh4qIuISdtMz4lnQp5ObWEIJs2AvC6ZjEMf+
         omvjbdKJh7kh4TuKvge+4PD4v2VgE3MkD/J8Ei+kEJilafTVZbYxtVTmyc4h1yv3rwkb
         bZlQ==
X-Gm-Message-State: AOJu0YwXRGbik280RMgjYsrvdfAa8KhIYbwWfHY/8ms6ohwzVi7QgOWz
        +uKOek7JFZlQ6swiCYJIkmDR5w==
X-Google-Smtp-Source: AGHT+IEsSpGnTmRfvDXcXMsh7LM1We7XMU5Lh3WnJl8OoxoWQxCh/H7nzym9Zh14uIMLsBMKPPQ6+Q==
X-Received: by 2002:a17:907:2be2:b0:9a1:f96c:4bb2 with SMTP id gv34-20020a1709072be200b009a1f96c4bb2mr750393ejc.50.1693950709409;
        Tue, 05 Sep 2023 14:51:49 -0700 (PDT)
Received: from [10.10.15.130] ([192.130.178.91])
        by smtp.gmail.com with ESMTPSA id gf16-20020a170906e21000b0098669cc16b2sm8050192ejb.83.2023.09.05.14.51.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 14:51:48 -0700 (PDT)
Message-ID: <59918472-9093-48e7-81a9-0bc10501584f@linaro.org>
Date:   Wed, 6 Sep 2023 00:51:47 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFT PATCH 1/2] arm64: dts: qcom: apq8096-db820c: fix missing
 clock populate
Content-Language: en-GB
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     stable@vger.kernel.org
References: <20230901081812.19121-1-krzysztof.kozlowski@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230901081812.19121-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/09/2023 11:18, Krzysztof Kozlowski wrote:
> Commit 704e26678c8d ("arm64: dts: qcom: apq8096-db820c: drop simple-bus
> from clocks") removed "simple-bus" compatible from "clocks" node, but
> one of the clocks - divclk1 - is a gpio-gate-clock, which does not have
> CLK_OF_DECLARE.  This means it will not be instantiated if placed in
> some subnode.  Move the clocks to the root node, so regular devices will
> be populated.
> 
> Reported-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Closes: https://lore.kernel.org/all/CAA8EJprF==p87oN+RiwAiNeURF1JcHGfL2Ez5zxqYPRRbN-hhg@mail.gmail.com/
> Cc: <stable@vger.kernel.org>
> Fixes: 704e26678c8d ("arm64: dts: qcom: apq8096-db820c: drop simple-bus from clocks")
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Stephen Boyd pointed out that this is a proper way to go (and we should 
unpack remaining /clocks nodes).

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Tested-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

> ---
>   arch/arm64/boot/dts/qcom/apq8096-db820c.dts | 32 ++++++++++-----------
>   1 file changed, 15 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> index 385b178314db..3067a4091a7a 100644
> --- a/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> +++ b/arch/arm64/boot/dts/qcom/apq8096-db820c.dts
> @@ -62,25 +62,23 @@ chosen {
>   		stdout-path = "serial0:115200n8";
>   	};
>   
> -	clocks {
> -		divclk4: divclk4 {
> -			compatible = "fixed-clock";
> -			#clock-cells = <0>;
> -			clock-frequency = <32768>;
> -			clock-output-names = "divclk4";
> +	div1_mclk: divclk1 {
> +		compatible = "gpio-gate-clock";
> +		pinctrl-0 = <&audio_mclk>;
> +		pinctrl-names = "default";
> +		clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
> +		#clock-cells = <0>;
> +		enable-gpios = <&pm8994_gpios 15 0>;
> +	};
>   
> -			pinctrl-names = "default";
> -			pinctrl-0 = <&divclk4_pin_a>;
> -		};
> +	divclk4: divclk4 {
> +		compatible = "fixed-clock";
> +		#clock-cells = <0>;
> +		clock-frequency = <32768>;
> +		clock-output-names = "divclk4";
>   
> -		div1_mclk: divclk1 {
> -			compatible = "gpio-gate-clock";
> -			pinctrl-0 = <&audio_mclk>;
> -			pinctrl-names = "default";
> -			clocks = <&rpmcc RPM_SMD_DIV_CLK1>;
> -			#clock-cells = <0>;
> -			enable-gpios = <&pm8994_gpios 15 0>;
> -		};
> +		pinctrl-names = "default";
> +		pinctrl-0 = <&divclk4_pin_a>;
>   	};
>   
>   	gpio-keys {

-- 
With best wishes
Dmitry

