Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB00B764DF9
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 10:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233754AbjG0Iqk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 04:46:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233175AbjG0IqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 04:46:13 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A928A69
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:29:06 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id a640c23a62f3a-992dcae74e0so87675966b.3
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 01:29:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690446543; x=1691051343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Vqiw6r+PHEVT+EztfpBhphT+HL4dVYUe7akOolTO95E=;
        b=WB43hr/c+d+z9E1dr3O2n9Zrk01bgQhVrkcBz0BXQqEIXbQ1+GpUeBUpJF41KFf5Tf
         lNm4rdRmMREzcf3LvomOfI21YpbvM6rACW4qqCaREo4hE9yZVqNV07X0NRrbSwuz/Off
         egSFoZU1aXCiBuVzWNAUurp8glWLA6xEfQudURruUH1gBHIdxawSOyfxGL5Ck1I2okdP
         1JEbf8n5QIkdeImRZLBDq54nXlEyFyEm5PgeYjggQPBUMMAaYCpvAz7nfz+b6F8205Y0
         YudRzdIN6RPjy2EbEcLaYpmmMhFPTkcjZB/G7W3F9eI6T4CWb894X7wzJwyhIYdJnxcJ
         MAGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690446543; x=1691051343;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vqiw6r+PHEVT+EztfpBhphT+HL4dVYUe7akOolTO95E=;
        b=YMx2HNL7vv1cC2DOTVXGwMuCKKuiljTji//xn2PEu8o9bpq0+/kkFULuqx24y7hQEh
         sgXLfz8NyHnSUX0XhOHM3gWVXxjuuttsuA+ZMJC/tkvaaXHCo3rSFk57mv/DeofHQCvY
         Qa8ndIPNXNSAHBcrydYI2tD/yRm4CjG8fES5GXSNIh7zXZyz3ewHFoW5J2Abd7Z8rq8o
         RH9iAs90Ma0j5VNA9jX/D28/fXAzuWIw7Vx5+IWKjBlWLZeFl+WCIKCiKoS7YT8Y8U8X
         ijJ7A+bnZCJUBsb2mqsYkxtHdjVH46Kcfqj67cunqLumn5xppTyUVUj2uZtKjGqBZqF7
         M+4g==
X-Gm-Message-State: ABy/qLbQEdCjlU9sFKg41URzn6DxtFS8AD+ac1Csb+8K0KKe9S5aVUTP
        otTHdhHooJ3DCyxy9n8j+pXCxg==
X-Google-Smtp-Source: APBJJlEePlD/dAhfTCyMhSnx6fASNBNWb1h9K0gW1jyicnQaTG11W03to93lZljkXpeSk7Uf1M9P1A==
X-Received: by 2002:a17:906:5356:b0:99b:d5fd:c924 with SMTP id j22-20020a170906535600b0099bd5fdc924mr1511323ejo.66.1690446542830;
        Thu, 27 Jul 2023 01:29:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id cw25-20020a170906c79900b0098d2d219649sm488322ejb.174.2023.07.27.01.29.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 01:29:02 -0700 (PDT)
Message-ID: <b0999940-8cd1-349d-9bf4-d6494145254c@linaro.org>
Date:   Thu, 27 Jul 2023 10:29:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 1/2] dt-bindings: input: qcom,pm8xxx-vib: add more PMIC
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
        quic_kamalw@quicinc.com, jestar@qti.qualcomm.com,
        quic_huliu@quicinc.com
References: <20230718062639.2339589-1-quic_fenglinw@quicinc.com>
 <20230718062639.2339589-2-quic_fenglinw@quicinc.com>
 <cb534cdb-508e-b03e-4e39-50cd6654377a@linaro.org>
 <4cb9f443-bdea-695a-f1b7-3963747e9a17@quicinc.com>
 <5b7e624b-5d06-826d-92d1-2a721b7c83b7@quicinc.com>
 <fec38f3a-f103-ff0f-138c-cffa3a808001@linaro.org>
 <4210b137-2d5d-a467-ea8c-d047701fdcc2@quicinc.com>
 <dd5864ee-7df2-eb64-c7f2-0fb234900d6a@linaro.org>
 <2fa3f27d-ff08-b923-2fb1-cf7cc888e5d5@linaro.org>
 <f1286da7-05a6-c8aa-d13b-075c0fd45b77@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f1286da7-05a6-c8aa-d13b-075c0fd45b77@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/2023 09:54, Fenglin Wu wrote:
>>>> +          - enum:
>>>> +              - qcom,pm7550ba-vib
>>>> +          - const: qcom,pm7325b-vib
>>>>
>>>
>>> Yes
>>
>> I wonder why this approved change turned out to something incorrect in
>> your v3 patch...
>>
> Since I got review comments in the driver change and I was told to 
> refactor the driver before adding new HW support. I added the HW type 
> logic in the driver and I was thinking it might be good to add some 
> generic compatible strings to match with the HW type introduced in the 
> driver change.
> 
> Anyway, I will update it to what you suggested in next patch.

Drivers are not really related to bindings, so whatever HW type you add
in driver, is not a reason to change bindings. Reason to change bindings
could be for example: because hardware is like that.

Best regards,
Krzysztof

