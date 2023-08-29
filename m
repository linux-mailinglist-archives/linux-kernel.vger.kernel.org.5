Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4176F78BE90
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Aug 2023 08:38:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231787AbjH2Ghn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Aug 2023 02:37:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232785AbjH2Ghi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Aug 2023 02:37:38 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4A8A18D
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:37:34 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-99bc9e3cbf1so834854966b.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Aug 2023 23:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693291053; x=1693895853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=y0puB13UyD4kzqL+3mBao37E2WRSNSR7Tz2UTX+4Scs=;
        b=hKCLNOkq919dmCixZrrOlQha+50XTKpTzWAVB0LsRKkfGnxjgR3oGAn3ndI54GOY0x
         bqpnViO+/txnORT2TmzOStwgg0HgaWaZKo/ui7uJ3AEG9IszGf5N2ojghAAu8f5RUmd1
         1/urN7XJ29RpcsVpKkHbN5k6FYCl8+sXeVFWK0WQuc7hY272oQdCQK+obUfgXH+jecoj
         J7JO2xFpLw2VFdzheHt/GUk5LMJna8Tt9eOGMaOakl8E+bs1oL+mVLY4qTnOYbrG8EQg
         knYIV02PWDCM/eYslnRwgvr3daC+gPMaPO2Ngv4zwQBwkXC4ZawGSkS7jYY3oULwsG3S
         UXqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693291053; x=1693895853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=y0puB13UyD4kzqL+3mBao37E2WRSNSR7Tz2UTX+4Scs=;
        b=PixroWFgHXblIinNd/a03ObdpAmOwb+7pSXU6ff7Mxv4durMJezyo1YG0fk872xpjz
         YjmlcBT3QgD6bUpDKC6yqJYofCkRM+cy9GB0xWaR81gfG/Sj6Vj24bbncEWalB/fJJAC
         pBaGDbeij9FDEMqt2QaTLh84PKS+H0toTgKVcaemmjgr6DxXHR4BljW56Z1oz75tAuf+
         ehzvDTBUjEiYExjGRRGjBpT65gqfmZJIFURJbVyDiGwrmzzjiux50Cmmvv88ulnvscGr
         mD0haFaxB8VD1aOwAvSVLzAooAFvVJ/R0r33RFzvs8MRmqpSgeSGZpdnt5ln1NGtdVVb
         HTlw==
X-Gm-Message-State: AOJu0YxgYFi+1ncyAkRrGqnWc6YI2ec27atu6/BoUtd7KTy5V0CpLGnG
        cHqEikqt6ZNrtS9IbaUYrL/LPg==
X-Google-Smtp-Source: AGHT+IHoEva2euud2rfWH/kt7uWvlJ42vQDHi6QlyIIMty4DKAF1r3SzMGu2uUGqR2iWULkVr4t5+g==
X-Received: by 2002:a17:906:2095:b0:99e:afd:f2ba with SMTP id 21-20020a170906209500b0099e0afdf2bamr1808532ejq.35.1693291053179;
        Mon, 28 Aug 2023 23:37:33 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.196])
        by smtp.gmail.com with ESMTPSA id u5-20020a17090626c500b009929d998abcsm5554594ejc.209.2023.08.28.23.37.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Aug 2023 23:37:32 -0700 (PDT)
Message-ID: <44fa6910-c21b-977a-4d2a-72e149085de7@linaro.org>
Date:   Tue, 29 Aug 2023 08:37:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 2/6] dt-bindings: crypto: qcom,prng: document that RNG
 on SM8450 is a TRNG
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-crypto@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Om Prakash Singh <quic_omprsing@quicinc.com>
References: <20230828-topic-sm8550-rng-v3-0-7a0678ca7988@linaro.org>
 <20230828-topic-sm8550-rng-v3-2-7a0678ca7988@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230828-topic-sm8550-rng-v3-2-7a0678ca7988@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/08/2023 10:04, Neil Armstrong wrote:
> It has been reported at [1] the RNG HW on SM8450 is in fact a True Random
> Number Generator and no more Pseudo, document this by adding
> a new qcom,trng and the corresponding SoC specific sm8450 compatible.
> 
> [1] https://lore.kernel.org/all/20230818161720.3644424-1-quic_omprsing@quicinc.com/
> 
> Suggested-by: Om Prakash Singh <quic_omprsing@quicinc.com>
> Suggested-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> Reviewed-by: Om Prakash Singh <quic_omprsing@quicinc.com>
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../devicetree/bindings/crypto/qcom,prng.yaml      | 24 +++++++++++++++++-----
>  1 file changed, 19 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> index bb42f4588b40..4245c9e424a3 100644
> --- a/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> +++ b/Documentation/devicetree/bindings/crypto/qcom,prng.yaml
> @@ -11,9 +11,13 @@ maintainers:
>  
>  properties:
>    compatible:
> -    enum:
> -      - qcom,prng  # 8916 etc.
> -      - qcom,prng-ee  # 8996 and later using EE
> +    oneOf:
> +      - enum:
> +          - qcom,prng  # 8916 etc.
> +          - qcom,prng-ee  # 8996 and later using EE
> +      - items:
> +          - const: qcom,sm8450-trng

Make it already an enum, so you won't have to change same lines twice.


Best regards,
Krzysztof

