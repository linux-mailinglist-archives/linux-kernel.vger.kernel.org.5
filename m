Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCE9275DB73
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jul 2023 11:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229610AbjGVJiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jul 2023 05:38:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229609AbjGVJir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jul 2023 05:38:47 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8858FE
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 02:38:44 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id 5b1f17b1804b1-3fbc5d5742bso24641015e9.2
        for <linux-kernel@vger.kernel.org>; Sat, 22 Jul 2023 02:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690018723; x=1690623523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mw4QNU0Dy0LwRM/C4Jb4PNJqZ3D5sQkLesoMFPJDwHY=;
        b=opZFmkwwy1LYo6pspaQvJ4bBS8jGaR273Wf1H7K20dyZAEX1+wMioX6/fllm7/oRQK
         cAuhDPRiSNdNCtgAkfo7eT1HbOqz48Ct71W1gmwKPmBC0seb4SawRFxqoyGJi+cjP9rj
         yKh2M4GGN4+z8Cd1u8LgvLRJs0Mf/kC0KzNEtoO7SsTNg/z6cKyXUB/kMev+H3rMKoqO
         wDIQkw4ScgdokVFqrrk15YTFoVWzi3dGom/U/6RhSHtjMOv4cpZ2U7FR/UoDQXvteJYc
         EtQtIN2xpvhW+XpB+zZg+Foy9sTStiSwK9ahtzuhYEooWnd2h12jSs0BfmXYa1z25Fe0
         blcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690018723; x=1690623523;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mw4QNU0Dy0LwRM/C4Jb4PNJqZ3D5sQkLesoMFPJDwHY=;
        b=F2kIVxW1H2E/YFE5RFmZEvFSMOzmau5MYfEheg8UU33efN/WLVh3Ucm5m6lAaN8YM+
         AM7GGsT5UFtY4UAdK9VCLKi4w2przKPnc6Ho9ybtOAdCdMcVvVi1JCVunKCgbxHA8YE/
         LvnMa+iBLGaR/5ZuVzWTkpRZcZrGVmcSC17knPDdtKZeoz16FBMH0rk2GOjIWUXmY+ls
         5XL6vJlOXzFOxZg9t5xtpnoSuENnkcfHoZw2+2234i83lsERkoYEZI6ZrQ9jLq2EJ82T
         sVr+TVNe5CWk+7CsnTM7AUdOMVagp/5N/NFYkOnv5J/jYuzDN7jF2J6fpbyFL9jCmr2F
         LgVQ==
X-Gm-Message-State: ABy/qLZXbaitZuWnpmReIVssiIMyBmkyC5hVsLJ35OiYtY5A1pw8nofO
        fEjbo1R2MqBCeCeCzT6A7OTVpw==
X-Google-Smtp-Source: APBJJlEzP3JnL5bTndXSwUna/jN3GVy3L3AIwIXEgq/cl5l61CA79T+EeQwsQktv82A79NG8r4LCOg==
X-Received: by 2002:a05:600c:2116:b0:3fa:8fb1:50fe with SMTP id u22-20020a05600c211600b003fa8fb150femr3435236wml.15.1690018723259;
        Sat, 22 Jul 2023 02:38:43 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id t10-20020a1c770a000000b003faef96ee78sm7826954wmi.33.2023.07.22.02.38.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 22 Jul 2023 02:38:42 -0700 (PDT)
Message-ID: <992b69a5-3fa9-ada3-a7bd-1c596cac9487@linaro.org>
Date:   Sat, 22 Jul 2023 11:38:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 3/7] dt-bindings: interconnect: qcom: Fix and separate out
 MSM8916
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230721-topic-icc_bindings-v1-0-93e2bc728fb7@linaro.org>
 <20230721-topic-icc_bindings-v1-3-93e2bc728fb7@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230721-topic-icc_bindings-v1-3-93e2bc728fb7@linaro.org>
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

On 21/07/2023 15:54, Konrad Dybcio wrote:
> Separate out MSM8916 icc bindings and fix the clocks description by
> removing the wrong internal RPM bus clock representation that we've
> been carrying for years.
> 
> Replace the example in qcom,rpm.yaml with MSM8939 to keep it relevant
> to the file.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/interconnect/qcom,msm8916.yaml        | 52 ++++++++++++++++++++++
>  .../devicetree/bindings/interconnect/qcom,rpm.yaml | 24 +++++-----
>  2 files changed, 65 insertions(+), 11 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml b/Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml
> new file mode 100644
> index 000000000000..49baf808c087
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,msm8916.yaml
> @@ -0,0 +1,52 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,msm8916.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm MSM8916 Network-On-Chip interconnect
> +
> +maintainers:
> +  - Konrad Dybcio <konradybcio@kernel.org>
> +
> +description: |
> +  The Qualcomm MSM8916 interconnect providers support adjusting the
> +  bandwidth requirements between the various NoC fabrics.
> +
> +allOf:
> +  - $ref: qcom,rpm-common.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,msm8916-bimc
> +      - qcom,msm8916-pcnoc
> +      - qcom,msm8916-snoc
> +

Keeping reg here also makes it nicely aligned with required: (property
and required are both in one file)

> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmcc.h>
> +
> +    snoc: interconnect@580000 {
> +        compatible = "qcom,msm8916-snoc";
> +        reg = <0x00580000 0x14000>;
> +        #interconnect-cells = <1>;
> +    };
> +
> +    pcnoc: interconnect@500000 {
> +        compatible = "qcom,msm8916-pcnoc";
> +        reg = <0x00500000 0x11000>;
> +        #interconnect-cells = <1>;
> +    };
> +
> +    bimc: interconnect@400000 {
> +        compatible = "qcom,msm8916-bimc";
> +        reg = <0x00400000 0x62000>;
> +        #interconnect-cells = <1>;
> +    };

Just keep one example.

> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> index 4f95d512012a..788c5e88445a 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,rpm.yaml
> @@ -20,9 +20,6 @@ properties:
>  
>    compatible:
>      enum:
> -      - qcom,msm8916-bimc
> -      - qcom,msm8916-pcnoc
> -      - qcom,msm8916-snoc
>        - qcom,msm8939-bimc
>        - qcom,msm8939-pcnoc
>        - qcom,msm8939-snoc
> @@ -109,9 +106,6 @@ allOf:
>          compatible:
>            contains:
>              enum:
> -              - qcom,msm8916-bimc
> -              - qcom,msm8916-pcnoc
> -              - qcom,msm8916-snoc
>                - qcom,msm8939-bimc
>                - qcom,msm8939-pcnoc
>                - qcom,msm8939-snoc
> @@ -254,7 +248,7 @@ examples:
>        #include <dt-bindings/clock/qcom,rpmcc.h>
>  
>        bimc: interconnect@400000 {
> -              compatible = "qcom,msm8916-bimc";
> +              compatible = "qcom,msm8939-bimc";
>                reg = <0x00400000 0x62000>;
>                #interconnect-cells = <1>;
>                clock-names = "bus", "bus_a";
> @@ -263,7 +257,7 @@ examples:
>        };
>  
>        pcnoc: interconnect@500000 {
> -              compatible = "qcom,msm8916-pcnoc";
> +              compatible = "qcom,msm8939-pcnoc";
>                reg = <0x00500000 0x11000>;
>                #interconnect-cells = <1>;
>                clock-names = "bus", "bus_a";

This part makes little sense since you remove the file few patches
later. I suggest reverse the order of patches. Split out first the oones
without examples (like 8939), so the last step is kind of rename.


Best regards,
Krzysztof

