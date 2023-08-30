Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2237578DE64
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Aug 2023 21:03:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241155AbjH3TCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Aug 2023 15:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243161AbjH3KNz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Aug 2023 06:13:55 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B6A1BE
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:13:52 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id 2adb3069b0e04-50079d148aeso8399260e87.3
        for <linux-kernel@vger.kernel.org>; Wed, 30 Aug 2023 03:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693390430; x=1693995230; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YdAPmJ+gUCFqNSlanjBx/+9HxsVUQV3sb8g3UYCYJfk=;
        b=jkV3xeRJlewnXct52aNYJpzjmw4cFDi4p3oTYRvEzt3bXDuNVwla4ZejY9sda/iYdk
         o1TP9xeNodUiAv/U3LajLR7ClWDryeyTowfrSLhSWd6HgsMZDLWByisxrHU0XEki2izH
         bsWhPXhQxaEdWKVE2mzT6iIKzFQp1Dk0nnm1pToi1GU6H4MIWURhkz/jCnthcKem2AvL
         4fiXUdmaVAMmswQ8b8smlj0G5wMzK259KOnOlty1V1Mn4Pr10mAMK2JJn6s/tqJ+G272
         6EtdBwwRSxUyt9Zw6qE0JBmb1P+Pul8u2b+XHbCclg78uxBinDVfxQwRlxPcY0YLOei7
         oFDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693390430; x=1693995230;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YdAPmJ+gUCFqNSlanjBx/+9HxsVUQV3sb8g3UYCYJfk=;
        b=e6W3ObUYWUxYuKhlUqD0PnF/40jcGoz5qM9FAJXDBpn/FKWRSxTU3xczEuDre2NAYm
         p1ncIFFJAYc1W8TiLow5ajNl0YGO70zr8L71w+VV7fQNVtbJgI9++7Qn3v81JYOZsKwJ
         PXCBs5QVuq9y6i+Zu+xqOGy3v5non1sK/VBSh7N01PGhaY+Rz8k2mVOlZTP2bPHvOXoI
         FbpQKGLA/+iFCGXsclz5RG5OCNpijT79NaaaHQEGCX6VE9n7rfg1DT34fvuKmnzUkomo
         3KK7J8YaLnWa3QGLAKi521OrRFOVJ7zfvYWXCbMmyh05DXVvcl7HdxyCLt1EYRV/5UBn
         1QBA==
X-Gm-Message-State: AOJu0YxAZELbQT4ySRwLzqcOqZh8CdU0cVgfA3bA2Hv14V/X6n/e5LyT
        EL/6O2vaCZVXUfQWiXgo7TSMew==
X-Google-Smtp-Source: AGHT+IFJtk5Io3NBnwgkN84+Cks6hSjcbc5Vmyu0QUtojJEiaUDOob7VHlmB1I3uo77civ/lNb4vcw==
X-Received: by 2002:a05:6512:3eb:b0:4fe:1f27:8856 with SMTP id n11-20020a05651203eb00b004fe1f278856mr1028718lfq.7.1693390430643;
        Wed, 30 Aug 2023 03:13:50 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id v18-20020aa7cd52000000b0052545dbfdbasm6594172edw.48.2023.08.30.03.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Aug 2023 03:13:50 -0700 (PDT)
Message-ID: <b1c1b06c-7d7a-e4a9-0fb9-9ba1d0cf8346@linaro.org>
Date:   Wed, 30 Aug 2023 12:13:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 10/11] dt-bindings: arm: qcom: Add QCM6490 Fairphone 5
Content-Language: en-US
To:     Luca Weiss <luca.weiss@fairphone.com>,
        cros-qcom-dts-watchers@chromium.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Viresh Kumar <viresh.kumar@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-pm@vger.kernel.org
References: <20230830-fp5-initial-v1-0-5a954519bbad@fairphone.com>
 <20230830-fp5-initial-v1-10-5a954519bbad@fairphone.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230830-fp5-initial-v1-10-5a954519bbad@fairphone.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/08/2023 11:58, Luca Weiss wrote:
> Fairphone 5 is a smartphone based on the QCM6490 SoC.
> 
> Also allow qcom,board-id and qcom,msm-id for QCM6490 since it's required
> by the bootloader.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index adbfaea32343..b09a41812cf0 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -391,6 +391,11 @@ properties:
>            - const: qcom,qrb2210
>            - const: qcom,qcm2290
>  
> +      - items:
> +          - enum:
> +              - fairphone,fp5
> +          - const: qcom,qcm6490

You miss update to first list of SoCs for bootloader.

> +
>        - description: Qualcomm Technologies, Inc. Distributed Unit 1000 platform
>          items:
>            - enum:
> @@ -1074,6 +1079,7 @@ allOf:
>                - qcom,msm8994
>                - qcom,msm8996
>                - qcom,msm8998
> +              - qcom,qcm6490

This is not a legacy SoC (released in 2022). Not allowed.

Best regards,
Krzysztof

