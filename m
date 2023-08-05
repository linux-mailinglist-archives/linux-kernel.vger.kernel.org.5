Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B53A97711C2
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Aug 2023 21:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjHET3U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Aug 2023 15:29:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230055AbjHET3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Aug 2023 15:29:18 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEA331A5
        for <linux-kernel@vger.kernel.org>; Sat,  5 Aug 2023 12:29:15 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-99c1d03e124so417882866b.2
        for <linux-kernel@vger.kernel.org>; Sat, 05 Aug 2023 12:29:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691263754; x=1691868554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/eoTXNan9hfBAk2ItnV/fDUtgs5cEoo72FK2KNJihNY=;
        b=Uca7hOTLTk7euoSoTKTGOqfB4yjWqKMmMs4VO2gJI8oXhqZClqtXPcoT/F9QQ08R7H
         ccedeVD3vclOa2IzY9XWJ/LuxCmtnm96Dkxjwq6ZC44WE/B7sYCRhi81RjKlMDOLSisN
         MVJelXZ+6l26ceWKle3LeG+092nvf2l63+PyHcK2KqUXX+ZL3w8C45zWUvNA3dzmuc1d
         gfZg+0uq6yX8R32XBE5jhcrXRq9bSZoPYZyHOcT7iSJwqO9FRq7c5XZNzMh1IQDzG2Yc
         QUsvG9lSmDA9MeceK1Yw4wP2vPWHW2b3ngNqdk+JoV6F1REQUYH49lKCkUulj68HlOad
         7J+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691263754; x=1691868554;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/eoTXNan9hfBAk2ItnV/fDUtgs5cEoo72FK2KNJihNY=;
        b=l/6DIzHJoAZJx1PyGty/JPG7j63fFke9jJO1cjOiouHIxe+T1VZvYOcMnVwJIj30lj
         ha/Icp92ghnlQu8oz4OQj49W8do2ctAwExUO40Y1tEHlSedS9jD+aZ3NF5tClGmMqn5n
         IqGor+1Qt9PnkVPVcl4fsuj6kxE06XgZ5RD3TlJO4jdhOZTaeOSDL+9Kvhmyv8Eg5P6P
         +IMedwWlwcrVl3z4r2LK2RY7xB8FYUVq8jyXwJbrslZY1khiM54BYIDINJXqp4+3sbXr
         mKYOZFlNAWY7CqbjNcqMCeO/JiXS64YAJOcNnhJTfQv0teru7EcjgIuhBydJ8tvXG692
         oJOA==
X-Gm-Message-State: AOJu0Yx0U0F8jW2CTVIq6lP48wdUIrIseH7zBvd7byKHDePVzbJ8QJQB
        +CQjbfiKosk02EY472fRHfeO8Q==
X-Google-Smtp-Source: AGHT+IH5DaN+pUCthq7k0rScxSZtePibiRU16HS8B5XCsuNpeTErg++bLF9XrOuvbAdXrXQTS6HjqA==
X-Received: by 2002:a17:906:cc5a:b0:99b:cb7a:c164 with SMTP id mm26-20020a170906cc5a00b0099bcb7ac164mr3770450ejb.62.1691263754388;
        Sat, 05 Aug 2023 12:29:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.245])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090636cd00b0099bcf9c2ec6sm3059491ejc.75.2023.08.05.12.29.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Aug 2023 12:29:13 -0700 (PDT)
Message-ID: <84ab9380-2fb2-76f9-2eb9-71d9202718cc@linaro.org>
Date:   Sat, 5 Aug 2023 21:29:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 1/6] media: dt-bindings: Document SC8280XP/SM8350 Venus
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230731-topic-8280_venus-v1-0-8c8bbe1983a5@linaro.org>
 <20230731-topic-8280_venus-v1-1-8c8bbe1983a5@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230731-topic-8280_venus-v1-1-8c8bbe1983a5@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/08/2023 22:09, Konrad Dybcio wrote:
> Both of these SoCs implement an IRIS2 block, with SC8280XP being able
> to clock it a bit higher.
> 

...

> +
> +  iommus:
> +    maxItems: 1
> +
> +  video-decoder:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: venus-decoder

That's not how compatibles are constructed... missing vendor prefix, SoC
or IP block name.

> +
> +    required:
> +      - compatible
> +
> +    additionalProperties: false

Why do you need this child node? Child nodes without properties are
usually useless.

> +
> +  video-encoder:
> +    type: object
> +
> +    properties:
> +      compatible:
> +        const: venus-encoder
> +
> +    required:
> +      - compatible
> +
> +    additionalProperties: false
> +
> +required:
> +  - compatible
> +  - power-domain-names
> +  - iommus
> +  - video-decoder
> +  - video-encoder
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/qcom,gcc-sm8350.h>
> +    #include <dt-bindings/clock/qcom,sm8350-videocc.h>
> +    #include <dt-bindings/interconnect/qcom,sm8350.h>
> +    #include <dt-bindings/power/qcom-rpmpd.h>
> +
> +    venus: video-codec@aa00000 {
> +        compatible = "qcom,sm8350-venus";
> +        reg = <0x0aa00000 0x100000>;
> +        interrupts = <GIC_SPI 174 IRQ_TYPE_LEVEL_HIGH>;
> +
> +        clocks = <&gcc GCC_VIDEO_AXI0_CLK>,
> +                 <&videocc VIDEO_CC_MVS0C_CLK>,
> +                 <&videocc VIDEO_CC_MVS0_CLK>;
> +        clock-names = "iface",
> +                      "core",
> +                      "vcodec0_core";
> +
> +        resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
> +        reset-names = "core";
> +
> +        power-domains = <&videocc MVS0C_GDSC>,
> +                        <&videocc MVS0_GDSC>,
> +                        <&rpmhpd SM8350_MX>;
> +        power-domain-names = "venus",
> +                             "vcodec0",
> +                             "mx";
> +
> +        interconnects = <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_VENUS_CFG 0>,
> +                        <&mmss_noc MASTER_VIDEO_P0 0 &mc_virt SLAVE_EBI1 0>,
> +                        <&mmss_noc MASTER_VIDEO_P0 0 &gem_noc SLAVE_LLCC 0>;
> +        interconnect-names = "cpu-cfg",
> +                             "video-mem",
> +                             "video-llcc";
> +
> +        operating-points-v2 = <&venus_opp_table>;
> +        iommus = <&apps_smmu 0x2100 0x400>;
> +        memory-region = <&pil_video_mem>;
> +
> +        status = "disabled";

Drop status.

> +
> +        video-decoder {

Best regards,
Krzysztof

