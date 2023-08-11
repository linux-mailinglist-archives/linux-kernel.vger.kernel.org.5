Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76492779AE3
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 00:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236579AbjHKW6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Aug 2023 18:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234615AbjHKW62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Aug 2023 18:58:28 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19BB3268C
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 15:58:28 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4fe55d70973so2868859e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Aug 2023 15:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691794706; x=1692399506;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WE2ZDql8Tv4YXUVI5BnaQPvuG6YZuD41+7T1wuevdUw=;
        b=BFA8oC4+WAPHJ4k1Gu3oLw0M8W4p1i25J18crYf0Q0Hkbr735DdJad9KlMyITLv2ZW
         P+BTW54dsOkbLiexM3ioWZEqkdCzFzXtsptphQ1ML+jT6X/RcMOSQkCK52fdTlrK80hK
         lqN0ORmvOKGB/UTgl7XaeLicDTNTcNKZpEA8XKjelrjpWGNGRblKp1LBJ+ihGRZTKb2z
         jHMPdF/NIW5wdMq93MUIEw8breCWhA5lwHDMtg2M2hXyTKpCV9ASde0UL4KlM3Ph20Q+
         n34aoqcTXHGUMGAEHbYx5AeskrlyVwrv8gUIfME3NLuw5UEnla8pQwp1kBj4AmpAst3Z
         n2Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691794706; x=1692399506;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WE2ZDql8Tv4YXUVI5BnaQPvuG6YZuD41+7T1wuevdUw=;
        b=FiFEcVqLcojDp6k8zz6xKtqnHsGYzoz4EUGpYwH1u4H0CTbadcDcsz+JVrOczOLm4x
         BLm8GBAAz2kq9dsPfRoRgMUH7T9OTIo9wo4hB9bkIiIkOkDeHdwIKekdBzmu2tEUhM2m
         3cjNLEOFVNXejkhHH9gVQu02z5SQk6x0g1OEbMOzBqNGY63hv5FoQqv2rItgmF7vlEHY
         GN3b9H1ek0UDfsvLJ6dAyC8xxZdtWyNK+5fgJqdORmkwS4jUYHkzlP9Vw+eVDxBm5SDx
         3eA0V8YhuZ2s8ZUGt6JWdajrPVK2akS//NFg0f4jOZKl7UDqcVDEUhuRYdY+yakAqHGi
         0DUQ==
X-Gm-Message-State: AOJu0Yzy55EKT6tFhV6s6iaIdQpvStvgQoqzJpoD916OnMduspNXcZqj
        OhRWkC5Sg/7El6peVwDM1oMDXA==
X-Google-Smtp-Source: AGHT+IEIDdZHxnS3sHxLL29Jh74kHohifLvD8BK8S+vgg6zTpywrpSSxiz+UldOBc3D4SXCeJmggbg==
X-Received: by 2002:a05:6512:4029:b0:4f8:4b19:9533 with SMTP id br41-20020a056512402900b004f84b199533mr2356986lfb.19.1691794706282;
        Fri, 11 Aug 2023 15:58:26 -0700 (PDT)
Received: from [192.168.1.101] (abyj188.neoplus.adsl.tpnet.pl. [83.9.29.188])
        by smtp.gmail.com with ESMTPSA id w7-20020a05651204c700b004fbb610c354sm890107lfq.0.2023.08.11.15.58.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 15:58:25 -0700 (PDT)
Message-ID: <b0494557-5676-4157-bc3b-bacd189c38d9@linaro.org>
Date:   Sat, 12 Aug 2023 00:58:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/7] dt-bindings: arm: qcom: Document MSM8x26-based Lumia
 phones
Content-Language: en-US
To:     Rayyan Ansari <rayyan@ansari.sh>, linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>
References: <20230811213728.23726-1-rayyan@ansari.sh>
 <20230811213728.23726-2-rayyan@ansari.sh>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Autocrypt: addr=konrad.dybcio@linaro.org; keydata=
 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
 izWDgYvmBE8=
In-Reply-To: <20230811213728.23726-2-rayyan@ansari.sh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11.08.2023 23:35, Rayyan Ansari wrote:
> Document MSM8226 and MSM8926 Lumias.
> 
> Signed-off-by: Rayyan Ansari <rayyan@ansari.sh>
> ---
>  Documentation/devicetree/bindings/arm/qcom.yaml | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
> index 450f616774e0..ea4b1c530461 100644
> --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> @@ -181,9 +181,18 @@ properties:
>  
>        - items:
>            - enum:
> +              - microsoft,dempsey
> +              - microsoft,makepeace
> +              - microsoft,moneypenny
>                - samsung,s3ve3g
>            - const: qcom,msm8226
>  
> +      - items:
> +          - enum:
> +              - microsoft,superman-lte
The '9' in msm8926 means "LTE".. is there a non-LTE superman?

Konrad
