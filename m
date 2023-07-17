Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A3F756DE2
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jul 2023 21:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231352AbjGQT7m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jul 2023 15:59:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229844AbjGQT7k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jul 2023 15:59:40 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC960D8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:59:38 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b700e85950so71813131fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jul 2023 12:59:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689623977; x=1692215977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GvxfVjwQCk1tS/oslTGgVT+uAnXvEyTLoAROKgew5sE=;
        b=M/3X+A8jovHdNAXQEux4zoUGZNz7ogggZLsVe7M2Nx/OFI0I9RvpFZSYOJCoFZmgGj
         m2aKVDMFvWmWex104EZkKqM4tKCC/vg4w7GcsoHJgayGYn72cNyWUOCAJtyK/bb1Z0FP
         CX68lfcgb/Ncncjks7En+K3Q+zM1PtT1Ka0/EkQKwsqex5Vt+AsictC4voEk5WAi3aet
         8jMEEDf/5PCT7M2ajf8GQSN2NX/nc0q16/Zw4QTQxuLU6uHtc+HukY5QdqztFJzKjIjM
         cfGPuSC+Ae+clZs4XUMg9/s4IgY9Se/TqkH9a71tuq+gJc2dMHjy9+10YQW3OGtACFYW
         CV8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689623977; x=1692215977;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GvxfVjwQCk1tS/oslTGgVT+uAnXvEyTLoAROKgew5sE=;
        b=UjmNsH+fLbczAo5AatHJWTlOcMQSUXDbymhiW5iEWxoskNaDEeiYKimqEerNhs3f7G
         ZSFZhaNvbEFaX9NYCUlH+tfgqa8jzE3XTbwXsMfyXw6nRusjo32BwM+X2TkjUMt81L/h
         kwDZrxqqRU5alV5xwUcLaTWG8m4fGKhRtErFyJbqTWzsovk9o+/wX3w2aVhRSH3YZq4m
         7l5w4sTbkuTqcbXMG9NRIPuHU7ljfGQdkI0p4I+YajS/uqN5yw9mT6Lle+8zHwC5YjOv
         BhrpCqZvB2aUAoelU1sqmKHzvCIbvEbPGUquHcN44LQ4hiCgbwwbk2z2ezvQEybIty/R
         GGSw==
X-Gm-Message-State: ABy/qLa0hdqtOBR7gNAM36qMXnloLRi8Df8uD0ft16vCxX8PEmavKtE8
        e90mFsUTgj+K+iert0kfl9TKiA==
X-Google-Smtp-Source: APBJJlHVBwe/J945YiJIdTO2oS6H9TlT4HIVSlpbPkVmkktYvSkLL2/0tr27q6IkeV4DOmf9+oEX3g==
X-Received: by 2002:a05:6512:40b:b0:4fb:79b5:5512 with SMTP id u11-20020a056512040b00b004fb79b55512mr165033lfk.66.1689623976938;
        Mon, 17 Jul 2023 12:59:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id j9-20020aa7c409000000b0051e362db186sm68110edq.60.2023.07.17.12.59.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 12:59:36 -0700 (PDT)
Message-ID: <6338cc75-e3fe-ba19-3df7-727b63fec245@linaro.org>
Date:   Mon, 17 Jul 2023 21:59:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v1 1/2] dt-bindings: input: qcom,pm8xxx-vib: add more PMIC
 support
Content-Language: en-US
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_kamalw@quicinc.com, jestar@qti.qualcomm.com
References: <20230717062547.2086869-1-quic_fenglinw@quicinc.com>
 <20230717062547.2086869-2-quic_fenglinw@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230717062547.2086869-2-quic_fenglinw@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/07/2023 08:25, Fenglin Wu wrote:
> Add support for vibrator module inside Qualcomm PMI632, PM7250B, PM7325B
> and PM7550BA PMICs.
> 
> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
> ---
>  Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
> index c8832cd0d7da..642408e2b35f 100644
> --- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
> +++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
> @@ -15,6 +15,10 @@ properties:
>        - qcom,pm8058-vib
>        - qcom,pm8916-vib
>        - qcom,pm8921-vib
> +      - qcom,pmi632-vib
> +      - qcom,pm7250b-vib
> +      - qcom,pm7325b-vib
> +      - qcom,pm7550ba-vib

Aren't the last two compatible?

Best regards,
Krzysztof

