Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 682057CE530
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Oct 2023 19:44:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231879AbjJRRoy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Oct 2023 13:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232032AbjJRRon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Oct 2023 13:44:43 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0BC410DD
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:44:21 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id 2adb3069b0e04-507a3b8b113so6036222e87.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Oct 2023 10:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1697651060; x=1698255860; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YSjGpLh46b5iKDUK/TbTUkbxdrxFCdobLrJFcW9LwtE=;
        b=SsJab72bA5lMF4oZHoL68uqcIzfhqPdAsbDWu/NqPboAGgDaiICt+HyTRf+SnD511a
         7TSQv4NhXz4ff4lZqhlrKLB7r5SNCsqd50ca2YaDFf9YSw6tqMhXdfBwjI5skp7TC3y3
         IZo1pIQnk5SCwGVMur4t+rsrjP6BOUf72uKGJkvbYZadoNYcFa5WDkYGM8lQp/RIPw9x
         3K+xhAhIgyi4q+l7VORLnD0A9EXHxcYGp4XJHxXTf6rxMXvNZcI6nNid37oEVcKqc/R7
         ZJZcbRAODPXFsW6pjCjcL7CdnbTtT76dbMkcHU0eQyjMr2yq3FI+tPPZNX5GJFF74b6x
         hdLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1697651060; x=1698255860;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YSjGpLh46b5iKDUK/TbTUkbxdrxFCdobLrJFcW9LwtE=;
        b=mPFjYw6VNHh44VTTJ0X6nbc2/53Yj9ENHB4vtRPPUJq70fUZvAusTLd9eCtO5O4G3W
         AlPk3GakvYtiVJOE+UCjE1PCOjN1oOgNirSsZvm0wYq+rjro0RVXBnvCMq1MBSwIc4B7
         cPLoz3DS1mcOW5woJlTGJWC/IuLQXaTM4b4vm5zMnZVqTkrV53yOWbkYrYRdpxxjCQvo
         +xdHcWAMNpW7fRXxlnSgOhDXf821cbo7of6waUpPdEpXICUzif4qZ146Bt8z+Hht/0x+
         bvi0Dqy8OeOkZs1QzLjz22TGSlTDQhVW3SNj6zoRBYGO2IIXkT85IsYKvwMKtKYR+8e8
         8l1Q==
X-Gm-Message-State: AOJu0YwVNI2WLHRgK2UgEFcL/VN4vUKCPtNP0A2n0dQNWaP7iAIl/6ZK
        M9Xkp0QYiD1NYasmh9+rWabvYA==
X-Google-Smtp-Source: AGHT+IE3783iU1dnjkiPm2xolvCZbstnb7FsjsJDnjEBXm8/qAYzcn7KDeGomfE0PIigmE4UV7xHkw==
X-Received: by 2002:a05:6512:60f:b0:4f9:5426:6622 with SMTP id b15-20020a056512060f00b004f954266622mr4400621lfe.69.1697651060022;
        Wed, 18 Oct 2023 10:44:20 -0700 (PDT)
Received: from [172.30.205.86] (UNUSED.212-182-62-129.lubman.net.pl. [212.182.62.129])
        by smtp.gmail.com with ESMTPSA id o15-20020ac24e8f000000b00502ae6b8ebcsm781411lfr.304.2023.10.18.10.44.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Oct 2023 10:44:19 -0700 (PDT)
Message-ID: <25185346-2d5d-469c-8a88-0f0f9f02a739@linaro.org>
Date:   Wed, 18 Oct 2023 19:44:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,sa8775p-tlmm: add missing
 wakeup-parent
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231018145750.429385-1-krzysztof.kozlowski@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20231018145750.429385-1-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/18/23 16:57, Krzysztof Kozlowski wrote:
> Add missing wakeup-parent property, already used by DTS to indicate that
> pins are wakeup capable:
> 
>    sa8775p-ride.dtb: pinctrl@f000000: 'wakeup-parent' does not match any of the regexes: '-state$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
> index e119a226a4b1..2173c5255638 100644
> --- a/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,sa8775p-tlmm.yaml
> @@ -28,6 +28,7 @@ properties:
>     gpio-controller: true
>     "#gpio-cells": true
>     gpio-ranges: true
> +  wakeup-parent: true
>   
>     gpio-reserved-ranges:
>       minItems: 1
All the properties visiable in this diff sound reasonable to
put in the common yaml, no?

Konrad
