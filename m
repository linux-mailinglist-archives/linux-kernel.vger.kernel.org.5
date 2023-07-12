Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 724087511FA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 22:43:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjGLUnj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 16:43:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231309AbjGLUnh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 16:43:37 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F9FD1FE4
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:43:34 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9926623e367so11188066b.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jul 2023 13:43:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689194613; x=1691786613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v6N+Ae3mBR4aL+DalZoKmTkKzJdxiTj/UQDG0eFaxKo=;
        b=d8R5GR/h7XXPMcaWDSLDm6UWoSMc46mXpfu1F7ke0UxSImyERv3FbMoWcxTIlD+p4E
         9MCS/xm8C/LXvygWAnQjY/fqEO32ATO+IDVgXwhMoTbq7cQDQO3+owv1/U39+sbRWSZi
         xFIzVu+tbdZVNvwPNBeY8PSjF0k/mwyHGIxFByZhhDjQg5x4HrMNFsy7pv3dKOUz0NBR
         Mmnpu+BncVWZTi1rFgaDgWkCNmUz9q/o4S1fcc66h/FMvZR4zrIKa2hoJYCMEJ1eP7aB
         AXMxeluoOjiXlXRIQIS01BP1MUBCHLZqF0LTfPCf4syXlJnqcise5IUDSsY2ytMKKQSh
         43pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689194613; x=1691786613;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v6N+Ae3mBR4aL+DalZoKmTkKzJdxiTj/UQDG0eFaxKo=;
        b=N1XA/rZz1VVnYx5FF8qRU/ZXc1ivXvQYyZ7OgD/OLIr/XJwuxEoctfEURPkN82wAzN
         H9YdYYbxZW9codsCT6pVQVoNNa3EkQ5UttfwA0QOn2HRIIpUDqv5OTRor0D6FMjof+kO
         WjApWw4GzWrTLsNRgdxJwB6+6yoji0H7yom+3KEbEXPhGfB37sH2q4uu9S6gN1Ba27Om
         ObNa9R+CRJ/YmAtV9HDBjosJVIkjMBZomy0S0f7EyYNmcrUtSNzgtIHSFQKJGYgHw/5E
         F2bWh8AGr+dKaQC27n4KOH8drdC8a9qODRcX0ZlN52h7lPklnqLgKhWMEzYNVSJA1Zhl
         g9qg==
X-Gm-Message-State: ABy/qLYRVOyB55imnXaqjpDCqBEaDX2YwPGR5VFlc+5uIVGOQ7enm0sk
        TRNNp9+hhYStoxkFTjG547QHbQ==
X-Google-Smtp-Source: APBJJlELIbRR9I5vzdI0GjzAWmtVJuPF4UfkNTyIUKlDlzag0/kYhncbmPZoG96sEuemBLdGICUbTA==
X-Received: by 2002:a17:906:b41:b0:991:f6d0:9bc1 with SMTP id v1-20020a1709060b4100b00991f6d09bc1mr16929675ejg.66.1689194612876;
        Wed, 12 Jul 2023 13:43:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id ov15-20020a170906fc0f00b0099364d9f0e6sm3012100ejb.117.2023.07.12.13.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Jul 2023 13:43:32 -0700 (PDT)
Message-ID: <68fb8e22-dd23-d4bf-eda0-444039fd8e26@linaro.org>
Date:   Wed, 12 Jul 2023 22:43:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 02/53] dt-bindings: interconnect: qcom,bcm-voter: Add
 qcom,bcm-voter-idx
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230708-topic-rpmh_icc_rsc-v1-0-b223bd2ac8dd@linaro.org>
 <20230708-topic-rpmh_icc_rsc-v1-2-b223bd2ac8dd@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230708-topic-rpmh_icc_rsc-v1-2-b223bd2ac8dd@linaro.org>
Content-Type: text/plain; charset=UTF-8
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

On 11/07/2023 14:18, Konrad Dybcio wrote:
> In order to (at least partially) untangle the global BCM voter lookup
> (as again, they are shared throughout the entire system and not bound to
> individual buses/providers), introduce a new required property to assign
> a unique identifier to each BCM voter.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../devicetree/bindings/interconnect/qcom,bcm-voter.yaml       | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
> index eec987640b37..09321c1918bf 100644
> --- a/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,bcm-voter.yaml
> @@ -38,8 +38,14 @@ properties:
>  
>      $ref: /schemas/types.yaml#/definitions/uint32
>  
> +  qcom,bcm-voter-idx:
> +    $ref: /schemas/types.yaml#/definitions/uint32-array
> +    description:
> +      A globally unique predefined discrimnator, identifying each BCM voter.

s/each/this/ ?
If I understand correctly, there might be more than one instance. The
problem is that I cannot find such case in upstream sources.


> +
>  required:
>    - compatible
> +  - qcom,bcm-voter-idx

This should not be really required, because it affects the ABI. You also
need to fix the reported warning.

Best regards,
Krzysztof

