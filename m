Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1415E77426F
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Aug 2023 19:45:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234817AbjHHRpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 13:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234794AbjHHRon (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 13:44:43 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF6DAA160
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 09:20:09 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b9b50be31aso90297151fa.3
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 09:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1691511569; x=1692116369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wkxbaJE1w03H/idk1NWqMQgLO1L7biBsn5GEkh/lQVQ=;
        b=Xg9H8BokBsPvFnwisvUUpVeRniDMXGxdedCKX5FDXl4/v9pG2nuZuh+JW1Nd0zt9CY
         sf95RxRHqFSJndO9HOzNCRopWw1hqzNc+YwnZ05fxwSjC8ymTkJSFusSSEDSaHO/gWtM
         s9N72uBmczHHWidqh0gHq9N+LrvQN/5fUzLg9CEXrLPcV0H45IML4NW51iGIsZOVy5mP
         2U2lRQKJBpCr3aIYA68drYW5YNdjH9+d6Q0Qly68nbP5uXaZb4HQHX1qim2TLc0Oin7Z
         szlitUl8oZh2/7cj1aCBADruyWd7KwqILlf/hRZr+iOyAbLbbAy20Ta6Ff4gEXN4m1lp
         1pyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691511569; x=1692116369;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wkxbaJE1w03H/idk1NWqMQgLO1L7biBsn5GEkh/lQVQ=;
        b=fFZhLyML7IriTwJtm7Rs/Slj1CGkVuE/nKV/tdOE0OW0NmxKNc0r/J5nFHdfupVV38
         ewAE4suTXxKGi9f33yf/3DuESki+TasdxsOw1tGlgr4ujj5DN9893o9Ty8qrOVtEcxbZ
         KTctsW9WUV/3xGI52ORKi+46oLFsJcS6V+BPcKExewU7AXAM8vAqslv/B2wIKDI3xUlB
         WU5lilWL+pqM5oHp7pFhfOW9XRc1KztcYK/mhC/nxS/oFvZEYqiOioIhuKJVjiDD3mtf
         fu4GCOpULrd6BE7OQak0jaqHWTOu+H2npapnpNJcd7mSV6ag98ayvGYsaZwZlV8968/g
         B5LA==
X-Gm-Message-State: AOJu0Yyir2b5ttoKP3jGGTdmArnz7oN3oNNcOiITEq7JTbuerM8ovzZ5
        EBoQPmhaQBdDhd/y9dTe1Fex/FkNv7cp/SvIEDI=
X-Google-Smtp-Source: AGHT+IGd2EkYnVmcbGVqenoYmJMzDW0/GB/8EFYGT8j/Y3vIO8hIfyRd/OSu9mbr2kbuJOvTwsbF3g==
X-Received: by 2002:a17:906:cc0f:b0:99b:d440:bf0b with SMTP id ml15-20020a170906cc0f00b0099bd440bf0bmr8097863ejb.67.1691477192381;
        Mon, 07 Aug 2023 23:46:32 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.113])
        by smtp.gmail.com with ESMTPSA id c24-20020a170906155800b00993004239a4sm6147808ejd.215.2023.08.07.23.46.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Aug 2023 23:46:31 -0700 (PDT)
Message-ID: <1f20d778-cdae-d6d9-ac86-744dd45176d3@linaro.org>
Date:   Tue, 8 Aug 2023 08:46:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH 2/3] dt-bindings: clock: add qca8386/qca8084 clock and
 reset definitions
Content-Language: en-US
To:     Jie Luo <quic_luoj@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        p.zabel@pengutronix.de
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_srichara@quicinc.com
References: <20230801085352.22873-1-quic_luoj@quicinc.com>
 <20230801085352.22873-3-quic_luoj@quicinc.com>
 <ef996a7e-6eba-4366-c3ea-0d08f2768e98@linaro.org>
 <cf9788f0-a115-5ff9-1195-f4f302551e04@quicinc.com>
 <d1172ed6-ee3b-83b6-1656-c91e35fbc2df@linaro.org>
 <f25e1043-6dfa-2dcc-2948-88025f4881d8@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <f25e1043-6dfa-2dcc-2948-88025f4881d8@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/08/2023 08:31, Jie Luo wrote:
> 
> 
> On 8/8/2023 1:57 PM, Krzysztof Kozlowski wrote:
>> On 08/08/2023 07:19, Jie Luo wrote:
>>>>> +properties:
>>>>> +  compatible:
>>>>> +    const: qcom,nsscc-qca8k
>>>>
>>>> SoC name is before IP block names. See:
>>>> Documentation/devicetree/bindings/arm/qcom-soc.yaml
>>>>
>>>> qca8k is not SoC specific. I don't know what you are documenting here,
>>>> but if this is a SoC, then follow SoC rules.
>>>>
>>>> If this is not SoC, it confuses me a bit to use GCC binding.
>>>>
>>>> Anyway, this was not tested, as pointed out by bot... Please test the
>>>> code before sending.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> Hi Krzysztof,
>>>
>>> Thanks for the review comments.
>>> qca8383/qca8084 is a network chip that support switch mode and PHY mode,
>>> the hardware register is accessed by MDIO bus, which is not a SOC.
>>>
>>> But it has the self-contained clock controller system, the clock
>>> framework of qca8386/qca8084 is same as the GCC of ipq platform such as
>>> ipq9574.
>>
>> OK
>>
>>>
>>> would you help advise whether we can document it with the compatible
>>> "qcom,qca8k-nsscc"?
>>
>> For example:
>> qcom,qca8084-nsscc
>>
>> Best regards,
>> Krzysztof
>>
> Thanks Krzysztof for the suggestion.
> 
> i will document the compatible below.
> "qcom,qca8084-nsscc" for the PHY mode of device.
> "qcom,qca8386-nsscc" for the switch mode of device.

The clocks seem to be exactly the same for both, so use only one
compatible in the driver (the fallback) and oneOf in the bindings like:

https://elixir.bootlin.com/linux/v6.3-rc6/source/Documentation/devicetree/bindings/sound/nvidia,tegra210-ope.yaml#L31

Best regards,
Krzysztof

