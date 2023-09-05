Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12AB0792516
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Sep 2023 18:01:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234160AbjIEQBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Sep 2023 12:01:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353651AbjIEHEb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Sep 2023 03:04:31 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2971B4
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 00:04:27 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-52a39a1c4d5so2875779a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 00:04:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1693897466; x=1694502266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8lkXuqfO1xkz/2/Im1hSKYTizJrPGxRl/maVMva9P+4=;
        b=vpJUMDB0tHp3eBmQQVL/yqUFiwIdWYTa2wk0icdGhpdcbwNdjgGl4DgITVcicH7uxD
         qO1nx45zRKNLGIZUGinPYxYMxf0VpH/KgDCCDJzUFWDqROqp6efmbQnFhSE7678VrLXZ
         JZ0O7poyKBiKWs8mKoYAMrXDUHBxmliUz9BOwgE7uQLK3kC0OYRv/A0kaytIRsWPhcGa
         yLd6mZ6TX1qNfATu3ZJWfWjWUL+5PDqbNIk7qWtnrvuYH72+IWF+jjFW28kMl7MF3+Em
         kSRsTpa62lfkWwQOImCBO5aclxhdXiv2uq7if/+ORoJBPpmBDnzM/MtjWstPCycIn5xZ
         r7cA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693897466; x=1694502266;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8lkXuqfO1xkz/2/Im1hSKYTizJrPGxRl/maVMva9P+4=;
        b=PNMjgVbfLDsZ/kE8i+t6XYW4IxCcpQkotJEdk+RU7A1YrkZrSmc/boiw47/zJMwhuj
         r7SAyRkBF2FqnbBlVicd/Ofwwg/lAU2nIAgeaYzbb+oYZUKme3/CdaeIZtpSMsgzjBaC
         07gRBHMHhbZARfTgYfSyY85JTGBzWzILo5DotXPbMrK+CqNnLJ/ZqqAHqBJHtUmJJP6H
         4N33Bhy5IcgCObpeRMVIakEjRU4/t8gfpLOHETEfMYeACDheCWhcaLLSAUEkdnGQ/0ex
         jXQmaFl4e89m3AmHMIqZs9Y2T/3s5UkebL3Qn13UJH2+tce8FAPg5DgRRaH7f7xyZcgw
         KIIw==
X-Gm-Message-State: AOJu0Yw3t1ghJ7exOfKurI8RBSXLzWKejTkaxTE5YVGazvN+u024gl6z
        wQGhzp/ENZoZxSnvG8ZaSKi3Ew==
X-Google-Smtp-Source: AGHT+IHk/WAZvhsnC0iX7pXrYpIVTAKMo1ffK6DfcP3VeZRIFCnGb2x5cW1amJ6qFheBhVDkY49z+A==
X-Received: by 2002:aa7:cd11:0:b0:52a:1c3c:2ecf with SMTP id b17-20020aa7cd11000000b0052a1c3c2ecfmr9201251edw.28.1693897465732;
        Tue, 05 Sep 2023 00:04:25 -0700 (PDT)
Received: from [192.168.0.22] (77-252-46-238.static.ip.netia.com.pl. [77.252.46.238])
        by smtp.gmail.com with ESMTPSA id l21-20020aa7d955000000b0052338f5b2a4sm6690521eds.86.2023.09.05.00.04.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Sep 2023 00:04:25 -0700 (PDT)
Message-ID: <692a1a69-b022-6bd9-c9d9-5f8ae4939461@linaro.org>
Date:   Tue, 5 Sep 2023 09:04:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.0
Subject: Re: [PATCH 1/4] dt-bindings: remoteproc: qcom: sc7180-pas: Add ADSP
 compatible
Content-Language: en-US
To:     Nikita Travkin <nikita@trvn.ru>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>,
        cros-qcom-dts-watchers@chromium.org
Cc:     David Wronek <davidwronek@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230905-sc7180-adsp-rproc-v1-0-dfea7699da7b@trvn.ru>
 <20230905-sc7180-adsp-rproc-v1-1-dfea7699da7b@trvn.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230905-sc7180-adsp-rproc-v1-1-dfea7699da7b@trvn.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/09/2023 07:47, Nikita Travkin wrote:
> SC7180 has an ADSP remoteproc. Add it's compatible to the bindings.
> 
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> ---
>  .../devicetree/bindings/remoteproc/qcom,sc7180-pas.yaml      | 12 ++++++++++++
>  1 file changed, 12

>  
> @@ -88,6 +89,17 @@ allOf:
>            maxItems: 2
>          power-domain-names:
>            maxItems: 2

Blank line

> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,sc7180-adsp-pas
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 5

This is supposed to be maxItems

> +        interrupt-names:
> +          minItems: 5

Ditto

>  
>  unevaluatedProperties: false
>  
> 

Best regards,
Krzysztof

