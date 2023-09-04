Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E015791198
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Sep 2023 08:43:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231300AbjIDGnB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Sep 2023 02:43:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351852AbjIDGnA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Sep 2023 02:43:00 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49A341A7
        for <linux-kernel@vger.kernel.org>; Sun,  3 Sep 2023 23:42:34 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5230a22cfd1so1416741a12.1
        for <linux-kernel@vger.kernel.org>; Sun, 03 Sep 2023 23:42:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693809753; x=1694414553; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SFckxZovG8hERZczdTqOPoyLhqCtfVRQH4CiHaOqB78=;
        b=IonUCen/rFOojAKQBKV6SHCqEr4ArA7QcR3aSjRzB6FtO0oIKIPMYEsutsYoHcUFGL
         wiNsVkV/ykjNGUQ5y8TJnujaaz+aTDwvM+zuz3pPgtZcJV/jweajMoC7zDhBdAeCRnm/
         IvY/ZXyc9DJFcq7HXJ/iuin4fE118uUu+OETeeLKNCBICIivcPP9xV6+u5Kq5I+lTSaH
         RbGksDw9jYRpj8RwWxb42Hus4hWjr4BrmEWSOEYAZfL+iejE+ATgGYLTsnTaUNc+rGya
         eKY6Vr4QGC3jVQrNtfCuIRF7eAreZyt2xey5tYJasvZYFs9i9xjIx/E2iT3tEQtm11HX
         bOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693809753; x=1694414553;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SFckxZovG8hERZczdTqOPoyLhqCtfVRQH4CiHaOqB78=;
        b=jvt9NaEruWm5RDmc0K3gWN3KA/INCABw8xumhV+fJaW2GgDnKlNODQfF6vMSe3sVeH
         pVZevooag8lkMx2C7/MfNSe3Eh4YeS+T+3pLjxIyQ1CizY2Hbs90FFhSxKB1fcpmEt/e
         Ob98648SceRn2USul9v/Zw8bxTIPWJ/TJEkLsvc0q6wyP/fgf5Pn4QZOireSjAs/Oltb
         S6DpRx62O9woFiEeMJiuAX6H1TB6YBRLRrhuODdnKMd+Bai/HB6Q6ooPkOvc4LHtO3rw
         uBj4PZfb6q7O/LCUwumvGN1p6d/W7h02iRVJV+mAuwXaWw4jgntZz5DFZZgpIBwWNoMx
         8QhA==
X-Gm-Message-State: AOJu0YysSUPfo/kckjht51pIobWJFSLIXF1GGgaTPQjQfy841n8pac+l
        w+MIVFHxwhqzEBDYwSLKXtSV9A==
X-Google-Smtp-Source: AGHT+IEuNvN4d3PTnjOQ2RILNCS2fZinvtPKWXogUUEa2JKDXSOuIksDgmvT3W2lRw1o88Z0VvPDrg==
X-Received: by 2002:a05:6402:5170:b0:522:ab06:7213 with SMTP id d16-20020a056402517000b00522ab067213mr5669004ede.27.1693809752773;
        Sun, 03 Sep 2023 23:42:32 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id r7-20020aa7cb87000000b0052996528b81sm5300883edt.45.2023.09.03.23.42.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Sep 2023 23:42:32 -0700 (PDT)
Message-ID: <b53d89a4-1024-1961-f95a-c9fcd97aaf79@linaro.org>
Date:   Mon, 4 Sep 2023 08:42:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 3/3] dt-bindings: hwlock: Drop unused
 qcom,ipq6018-tcsr-mutex
Content-Language: en-US
To:     Vignesh Viswanathan <quic_viswanat@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ohad@wizery.com,
        baolin.wang@linux.alibaba.com, linux-remoteproc@vger.kernel.org
Cc:     quic_kathirav@quicinc.com, quic_anusha@quicinc.com,
        quic_sjaganat@quicinc.com, quic_srichara@quicinc.com,
        quic_varada@quicinc.com
References: <20230904055010.4118982-1-quic_viswanat@quicinc.com>
 <20230904055010.4118982-4-quic_viswanat@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230904055010.4118982-4-quic_viswanat@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/09/2023 07:50, Vignesh Viswanathan wrote:
> Drop qcom,ipq6018-tcsr-mutex enum as this is does not map to the correct
> config for IPQ6018. IPQ6018 will use qcom,tcsr-mutex compatible string.
> 
> Signed-off-by: Vignesh Viswanathan <quic_viswanat@quicinc.com>
> ---
>  Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml b/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
> index ee2726149cf3..a595396fd3f9 100644
> --- a/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
> +++ b/Documentation/devicetree/bindings/hwlock/qcom-hwspinlock.yaml
> @@ -22,7 +22,6 @@ properties:
>        - items:
>            - enum:
>                - qcom,apq8084-tcsr-mutex
> -              - qcom,ipq6018-tcsr-mutex

NAK, this is a correct compatible for IPQ6018.

Best regards,
Krzysztof

