Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41B2D759283
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:16:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjGSKQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjGSKQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:16:03 -0400
Received: from mail-lj1-x22d.google.com (mail-lj1-x22d.google.com [IPv6:2a00:1450:4864:20::22d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8791FEC
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:16:01 -0700 (PDT)
Received: by mail-lj1-x22d.google.com with SMTP id 38308e7fff4ca-2b74310566cso105521641fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:16:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689761760; x=1690366560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0A/R+Tlnm19cuiqeuEoTLUrD1KlI6hBJ7e0CeBXS09o=;
        b=M15WeAmzbVGHPzyX+P4c6yqHp5azZ4flzRxp7F4jdFeCuQRJn0n4DR1DtJoeGzuVTl
         nMGAMWOKZSZWIAVv5biuPs814ffih46g1Und+WfYBF4cL3LWTo3omOivwr/AfSNVVIIC
         iV/ldpMgo/QHSx7Ammzods1dDGf1DHxvv7OX7hp04WXdkTwL7BHDbBPnx8Xwa7wKXYO4
         4LfMFjXEgKvY3x1946yoswnf5CIfrrdiAPTbnfeqYI5i8cUySmbQBf8St0jTZ0BN33dQ
         i6WCrDg4iSK9EzX3MuwUfopeVoqx4EYDmcC6rjJaOPh8kdfpL5WwjxqJ1+KK4JGiQBfg
         BfHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689761760; x=1690366560;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0A/R+Tlnm19cuiqeuEoTLUrD1KlI6hBJ7e0CeBXS09o=;
        b=P/Yes3PlSvYuDmkbVWJXqbLSPp1jPw+cOJNg2bs0duHj5H/N1WtTJVEcQjcKMtqXX9
         WT4Z//B4BUEbc1S5x/Wyc+WM9mQyAqj0/y6TOtpitIYqH7z8z9BXpH0tJUfriufzf8wp
         4IntsV1wro3Cal0HaTzDTMtimAHgZpfXV1RND0bHaMwMrUG37fKM7tZXNZbCSnIkD24F
         n8gDq6qk8EjyYAUdbnH6DHosYJVUu3VroRbUVwdNpy/JKstlauVhmsfHSPxokHeN8fGa
         2SUnEnVwiPoh4LbfnBcbGUeIS4yvy2vsvdkEjvchSttSdfrO+wWUkzBzLKdCOU0On5Mj
         aJjw==
X-Gm-Message-State: ABy/qLbaLtCzOgyBQzVpljoJ6ujxVgUmYg8C93rV9h59yeYH4HXVPFrL
        3BENHc/zdGC+aox42+UKaftfEw==
X-Google-Smtp-Source: APBJJlHRZO3uzRnsaSi07Gufa61FD5mxqFZwUKhOZam1n9f8mi6/2WV6H+hAOiuyozDc3JoMUiMtlQ==
X-Received: by 2002:a2e:9d45:0:b0:2b9:40c7:f5ed with SMTP id y5-20020a2e9d45000000b002b940c7f5edmr5527919ljj.17.1689761760056;
        Wed, 19 Jul 2023 03:16:00 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id a14-20020a2e860e000000b002b6d7682050sm956682lji.89.2023.07.19.03.15.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:15:59 -0700 (PDT)
Message-ID: <c7642d4e-85a1-0934-c155-6636a86ec3bc@linaro.org>
Date:   Wed, 19 Jul 2023 13:15:59 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 4/5] dt-bindings: arm: qcom: Document SM4450 SoC and
 boards
Content-Language: en-GB
To:     Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
        konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc:     quic_tsoni@quicinc.com, quic_shashim@quicinc.com,
        quic_kaushalk@quicinc.com, quic_tdas@quicinc.com,
        quic_tingweiz@quicinc.com, quic_aiquny@quicinc.com,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230719100135.21325-1-quic_tengfan@quicinc.com>
 <20230719100135.21325-5-quic_tengfan@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230719100135.21325-5-quic_tengfan@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 13:01, Tengfei Fan wrote:
> Document the SM8450 SoC binding and also the boards using it.
> 
> Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
> ---
>   Documentation/devicetree/bindings/arm/qcom.yaml | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 450f616774e0..691e66612872 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -83,6 +83,7 @@ description: |
>           sm8350
>           sm8450
>           sm8550
> +        sm4450

Please sort properly

>   
>     The 'board' element must be one of the following strings:
>   
> @@ -976,6 +977,11 @@ properties:
>                 - qcom,sm8550-qrd
>             - const: qcom,sm8550
>   
> +      - items:
> +          - enum:
> +              - qcom,sm4450-qrd
> +          - const: qcom,sm4450
> +

And here

>     # Board compatibles go above
>   
>     qcom,msm-id:

-- 
With best wishes
Dmitry

