Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18ED07609DA
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jul 2023 07:54:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231873AbjGYFyH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jul 2023 01:54:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231953AbjGYFxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jul 2023 01:53:51 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D601FDF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:53:40 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2b6fdaf6eefso75118031fa.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Jul 2023 22:53:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690264418; x=1690869218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yGtjY2I6IJJ57ajiFTOVXjH7nBwULBGZDd/HJCAdG7c=;
        b=nPlzFgRdvGYkC6362bgv18FBpP4eBTQE/J3iNMHDYXTJ86+Gw2Af9cgcYP4zDcXKZc
         J0f+J5vLvxNN1uijkdROMOclFVgjcxOGOfzoiWtp64fAy3Dao6lZyMlouKjUx15aECi2
         smxSI7YO0B7PcTTsVn++SYfqGPDNlc25fR1cTo9x5cpGrLiTHC3dXmdB7WGLYMscz3UL
         Fid0hYeZnjlcwEHRbbgMUbCiDSBefZmFNyNs7YdC0lok8dLIOq/rJOSX+JBqelILTUv4
         lAxQHVTEuDtPcwFg5ZaId3BnRSenE+/7zagsArP6D+CHu22Btwf8l7ZzLkAQcNOk/ep9
         Kp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690264418; x=1690869218;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yGtjY2I6IJJ57ajiFTOVXjH7nBwULBGZDd/HJCAdG7c=;
        b=EAIUbdiCTge42WBBtkifr3aGY1sQFpW5mYxDThPVlFm7yBGvGN0Hf5p0/zPjaIgq2t
         JpyUZFmWgKw3Vi2RiXDJakrBN9MKfzf14UkXqmTbyhFuEfpaI49eoQQ2tX7VwCIkUBXi
         dlGGlyCFMf5sMw6a7u8oFNGX3/yF3JBvxUF+jQPxAKhKEccIomQAw97Nnu+88DX+aYGL
         TJiByk3a7G2S7EmB8XpLeGnD8zNItkoN7lwGYfT/mWteoEi9Ih+KWWbsAywPHmh1XNbf
         QlSDrpYNOHfzQhhKD5c2b+2oXVtKplYYp90D3RP9X0lfgoB+oE3GWzwwU9eXOUBMmnee
         N7fw==
X-Gm-Message-State: ABy/qLbbfzCYVm87QvEfEXb63yWI7LBnX8IncsBH6OuZ+aRKuyqrT3Uq
        yvZK5UGNGr9Wa0moSC3KJRaUIQ==
X-Google-Smtp-Source: APBJJlE6aL0qKjjw/dnLiqEek1XnS/5MAywE2WBCtv90rs+MfwAQzpO22Pb9BsLgwbwCq5d8WtP02w==
X-Received: by 2002:a2e:9f09:0:b0:2b9:4ac9:6071 with SMTP id u9-20020a2e9f09000000b002b94ac96071mr7086785ljk.10.1690264418421;
        Mon, 24 Jul 2023 22:53:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id lx26-20020a170906af1a00b0099b76c3041csm5352044ejb.7.2023.07.24.22.53.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Jul 2023 22:53:27 -0700 (PDT)
Message-ID: <b2ad4863-a38b-7fb6-65b1-ea336c4fc876@linaro.org>
Date:   Tue, 25 Jul 2023 07:53:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/3] dt-bindings: input: qcom,pm8xxx-vib: add new SPMI
 vibrator module
Content-Language: en-US
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org,
        dmitry.baryshkov@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_kamalw@quicinc.com, jestar@qti.qualcomm.com
References: <20230725054138.129497-1-quic_fenglinw@quicinc.com>
 <20230725054138.129497-3-quic_fenglinw@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230725054138.129497-3-quic_fenglinw@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 07:41, Fenglin Wu wrote:
> Add compatible string 'qcom,spmi-vib-gen2' for vibrator module inside
> PMI632, PMI7250B, PM7325B, PM7550BA. Also, add 'qcom,spmi-vib-gen1'
> string for the SPMI vibrator inside PM8916 to maintain the completeness
> of the hardware version history for SPMI vibrators.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  .../bindings/input/qcom,pm8xxx-vib.yaml        | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
> index c8832cd0d7da..ab778714ad29 100644
> --- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
> +++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
> @@ -11,10 +11,20 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - qcom,pm8058-vib
> -      - qcom,pm8916-vib
> -      - qcom,pm8921-vib
> +    oneOf:
> +      - enum:
> +          - qcom,pm8058-vib
> +          - qcom,pm8916-vib
> +          - qcom,pm8921-vib
> +          - qcom,spmi-vib-gen1
> +          - qcom,spmi-vib-gen2

Generic compatibles should not be alone. Drop both lines.

> +      - items:
> +          - enum:
> +              - qcom,pmi632-vib
> +              - qcom,pm7250b-vib
> +              - qcom,pm7325b-vib
> +              - qcom,pm7550b-vib
> +          - const: qcom,spmi-vib-gen2


Best regards,
Krzysztof

