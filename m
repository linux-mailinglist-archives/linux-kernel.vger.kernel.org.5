Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CFC75929B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jul 2023 12:19:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230462AbjGSKS7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jul 2023 06:18:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230405AbjGSKSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jul 2023 06:18:33 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 586B426A4
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:18:22 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9928abc11deso919457766b.1
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jul 2023 03:18:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689761901; x=1692353901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mKO0TJLvmVWRaDSVCf4u46x2zB0AJ6CPfOrU5hIDQ3Y=;
        b=BR1hVXRSuD4ShJ+2shzyRVpPzUwQ2bQibyB4BYSlcbFc52vBeYKKg/3XruHheKP6DJ
         d7j0HvFPJ4HoSsD5G/+Tom6obrMBXJJRqvU0ZmzLFp/gai2NUuPxfgFMuwgM+AyxSAR8
         O6lEtq9tLcB8jy0kdcQU2+o4ky/YuaiOXtA1HRXi4HsmlsswiZykZ5Vuw3MI6psmBvc3
         qe2h68ytlnA4cPfEzFxzFTzXmazg4zch4j/NFM2KYuYTyOuCAczz7tC/0UyHyNrXS1Ab
         B6pNSW42fFtO5q/fNJEAjAa6LLCjhdt7iAHIiUpfuxmC384aMNgpY+AAJDTvo5Rebm8j
         M8nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689761901; x=1692353901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mKO0TJLvmVWRaDSVCf4u46x2zB0AJ6CPfOrU5hIDQ3Y=;
        b=goygtIVoN5IsM4/J3BIG1yqjn1Or2l6hfbVkdyY8TCdf0drl95H9Of/daegtA+eRBM
         HNlX1Z1iOWw27jM2groqZlOd3rqSM6nKR6sU3zK6xtKVZBaVXeYRCaOmP65884T0Rime
         HIueOmek7hY9DqvjIzaK2KhmP+PEjBnLdkaJ3C5ojsNCDYXQVsClvxl2NPPspWr8VUhp
         eis7aW6W9RB0nSLYlHtVF1F4h1X7VEOyAbaYhFEVajLbIyA99cjNFVlqAzQD5w/n3pXU
         XkwOHTcjGuZFeuoD0vzke6eBjvWUj6WR30wFYo24V6Wfrp9Im4K3JCmagJMMg+wZWUmk
         YntQ==
X-Gm-Message-State: ABy/qLZNSwuroCidQjACgQ6A4O8KAfReFnnuaGzXPQ/htWs0vZ/tSOaz
        Xfc1kPcZClwJAkbDLWnwuA3Kug==
X-Google-Smtp-Source: APBJJlGGiRnE6u8Sqrg1Q0TQNzDkrm36pjdp1JMjTh3lj/teWT2U5GviPaKCCOUI2izgODHqGrDgbw==
X-Received: by 2002:a17:907:3f28:b0:991:d9cb:247d with SMTP id hq40-20020a1709073f2800b00991d9cb247dmr2154650ejc.57.1689761900793;
        Wed, 19 Jul 2023 03:18:20 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id jt1-20020a170906dfc100b00992b66e54e9sm2111063ejc.214.2023.07.19.03.18.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Jul 2023 03:18:20 -0700 (PDT)
Message-ID: <ebc27dd7-93fe-4d8e-8b8c-4fc1d52cc275@linaro.org>
Date:   Wed, 19 Jul 2023 12:18:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3] arm64: dts: qcom: sdm630: Add support for modem
 remoteproc
Content-Language: en-US
To:     Alexey Minnekhanov <alexeymin@postmarketos.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org
References: <20230719093458.2668842-1-alexeymin@postmarketos.org>
 <2c1c69bf-3cd5-4d68-43db-696ce0f15197@linaro.org>
 <1f8cbc00-9602-486d-b3c9-9c82f3b6c8df@postmarketos.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1f8cbc00-9602-486d-b3c9-9c82f3b6c8df@postmarketos.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/07/2023 12:10, Alexey Minnekhanov wrote:
> On 19.07.2023 12:45, Krzysztof Kozlowski wrote:
>> On 19/07/2023 11:34, Alexey Minnekhanov wrote:
>>> Modem subsystem in SDM630/660 is similar to MSM8998 and
>>> device tree node for it is based on the one from msm8998.dtsi.
>>>
>>> Signed-off-by: Alexey Minnekhanov <alexeymin@postmarketos.org>
>>> ---
>>>
>>> V3: Use memory-region property to specify memory regions, instead
>>>      of using "mba" and "mpss" subnodes.
>>>
>>> V2 link: https://lore.kernel.org/lkml/20230621175046.61521-3-alexeymin@postmarketos.org/
>>>
>>>   arch/arm64/boot/dts/qcom/sdm630.dtsi | 59 ++++++++++++++++++++++++++++
>>>   1 file changed, 59 insertions(+)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/sdm630.dtsi b/arch/arm64/boot/dts/qcom/sdm630.dtsi
>>> index 2136ded22f7e..797625cf78ac 100644
>>> --- a/arch/arm64/boot/dts/qcom/sdm630.dtsi
>>> +++ b/arch/arm64/boot/dts/qcom/sdm630.dtsi
>>> @@ -1032,6 +1032,65 @@ data-pins {
>>>   			};
>>>   		};
>>>   
>>> +		remoteproc_mss: remoteproc@4080000 {
>>> +			compatible = "qcom,sdm660-mss-pil";
>>
>> Missing bindings so standard comment:
>>
>> It does not look like you tested the DTS against bindings. Please run
>> `make dtbs_check` (see
>> Documentation/devicetree/bindings/writing-schema.rst or
>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>> for instructions).
>>
>> Best regards,
>> Krzysztof
>>
> 
> Bindings are already in linux-next/master since 
> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=ed50ac266f67829d4732c8ca61ef1953c2cc63d0 

Hm, I checked a two days older next. Provide explanations or links if
you resend DTS in such case.

> .
> 
> And I did check DTS against bindings, it spat 2 warnings about new 
> remoteproc node, which do not make much sense to me:
> 
>    DTC_CHK arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb
>    .../arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb: 
> remoteproc@4080000: qcom,halt-regs:0: [43] is too short

That's ok.

>          From schema: 
> .../Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml
>    .../arch/arm64/boot/dts/qcom/sdm660-xiaomi-lavender.dtb: 
> remoteproc@4080000: memory-region: [[45], [46]] is too short
>          From schema: 
> .../Documentation/devicetree/bindings/remoteproc/qcom,msm8996-mss-pil.yaml

This needs fixes. The binding lists expected memory regions and you do
not have three of them.

Best regards,
Krzysztof

