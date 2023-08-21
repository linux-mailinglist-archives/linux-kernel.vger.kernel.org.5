Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59864782A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 15:13:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232614AbjHUNNJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 09:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235279AbjHUNM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 09:12:57 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DECCEE2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:12:50 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-99c1d03e124so419023566b.2
        for <linux-kernel@vger.kernel.org>; Mon, 21 Aug 2023 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1692623569; x=1693228369;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ph4bj2JE9yzl4L+Z7YlL2YAhIXL0uO8/2XI9ntDToVQ=;
        b=l3oOXCGGKIiNhVVOlEdUewd/pmvcytIseBPXpgOdpkQcQ8thjGggHgxO6SgeTjYdh/
         Egbmj8KyYS9b0Ml3zehz/FNy2ccVIBDmidw77jIUO3UxVNLyCFPqkg1TU6AVowYNaxbk
         7Re97yiggHYJLaVWGJtA/5XtTlOV+hOajq9MIpbJP9ouYdXIp2IB6OxybJSacgq70GLv
         nWXUXx1Lc4T/JOJAR/BZbsrm3K6ZaiyczBZUZC0r0PolzeSZY2pQiIzPJetJYNzYOsKC
         z5SZ0/NBdGoTFnqRfdv094jDhnmQvIDkn99/TqEE+MfHXSmpDflPXlDVQsbjvSyDwfoZ
         Qh3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692623569; x=1693228369;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ph4bj2JE9yzl4L+Z7YlL2YAhIXL0uO8/2XI9ntDToVQ=;
        b=U+f+Hf+IJ9Q/bWAh8PX+vC4lnZ6Jjn/iufF2v6vp/E+JoxEbzTtDoJ2haIUcR+If9K
         3/UOMAea73AxHbdQyzsdCbem9YfzN2MiZzGSX5366b85VM0CFOXmW/z1k57SkQzm23IY
         R2AJOBScVkZRTQUIYlMbJ11vNzfsJRedgO0WB/Hr3kldiuLT/9nty+PiL6X/9zpnZxgu
         uP4Jhetz0da/Ju+IL1bDyWCml8Getd4P+YSgONSQnu8JehXUVpmjjWlQKAClhiIQtJSV
         TtN7ENstfX5ZN5v1b9KbPuIk76s3qgtiSjfAaDeX/6MCe21vRD9v2gO3reejWruwjp2V
         8X6w==
X-Gm-Message-State: AOJu0Yx6s3TdKtqKKJ8WLxDsYwHz+5GXFcrFKmG9US1lCYbiT6cAR6ID
        ozdFHyEl9FjbY7uFHAaVsMeB2w==
X-Google-Smtp-Source: AGHT+IH+3SmODhee1b7JSmRuMG8rb8itCh0JRCEBqsSoEyQCgOdF9obSTVQzCaITVsL+R6gKVO4F1Q==
X-Received: by 2002:a17:906:21c:b0:99e:13f6:8a5a with SMTP id 28-20020a170906021c00b0099e13f68a5amr4759565ejd.20.1692623569387;
        Mon, 21 Aug 2023 06:12:49 -0700 (PDT)
Received: from [192.168.0.22] ([77.252.47.198])
        by smtp.gmail.com with ESMTPSA id lw26-20020a170906bcda00b00993a37aebc5sm6438076ejb.50.2023.08.21.06.12.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Aug 2023 06:12:48 -0700 (PDT)
Message-ID: <342de8f3-852f-9bfa-39c4-4d820f349305@linaro.org>
Date:   Mon, 21 Aug 2023 15:12:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.14.0
Subject: Re: [PATCH v3 11/50] dt-bindings: crypto: add sam9x7 in Atmel TDES
Content-Language: en-US
To:     Tudor Ambarus <tudor.ambarus@linaro.org>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Varshini.Rajendran@microchip.com, herbert@gondor.apana.org.au,
        davem@davemloft.net, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230728102442.265820-1-varshini.rajendran@microchip.com>
 <09bd1388-02aa-32c7-319e-d7150a0f3e9c@linaro.org>
 <1ec901d0-44c2-1d28-5976-d93abfffee67@microchip.com>
 <37782447-43c7-50f9-b9b4-5fbca94ce8c6@linaro.org>
 <96033a59-a2ea-c906-a033-84119c5783d7@linaro.org>
 <adeed0b2-e09b-78cf-ebfd-08d3949ca9ea@microchip.com>
 <57e9a9ff-26ed-62d1-91f8-cd5596f1c308@linaro.org>
 <5235260c-8fd6-2b2a-58b9-703191fff526@linaro.org>
 <697712da-bff9-4621-28ac-9c9f68a76e43@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <697712da-bff9-4621-28ac-9c9f68a76e43@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/08/2023 15:00, Tudor Ambarus wrote:
> 
> 
> On 8/21/23 13:10, Krzysztof Kozlowski wrote:
>> On 21/08/2023 11:54, Tudor Ambarus wrote:
>>>>>>> I am aware that there is no change in the crypto IP used. This patch is
>>>>
>>>> Actually, recent history showed us that it's not only the IP itself but
>>>> its integration into final product that could have an influence on the
>>>> behavior.
>>>>
>>>>>>> to add a SoC specific compatible as expected by writing-bindings
>>>>>>> guideline. Maybe a bit more explanation in the commit description might
>>>>>>> do the trick.
>>>>>>>
>>>>>>
>>>>>> So you add a compatible that will never be used just to comply with
>>>>>> the writing bindings guideline?
>>>>>
>>>>> How do you know that it is never going to be used? The guideline asks
>>>
>>> See
>>> https://git.kernel.org/pub/scm/linux/kernel/git/at91/linux.git/tree/drivers/crypto/atmel-tdes.c?h=at91-dt#n1120
>>
>> What's there? One compatible? How does it prove that it will not be
>> used? It only proves that currently it is not used... And anyway this is
> 
> Correct, as of now the compatible was not used to determine the hw caps,
> the capabilities were retrieved by checking at runtime a version
> register. I'm against adding a compatible that will not be used, in this
> particular case, defining "microchip,sam9x7-tdes" in the driver but
> still solely relying on the runtime version register interrogation.
> Unfortunately the commit message does not reveal any intention and from
> there these emails changed. Maybe it's just a matter of personal
> preference, so I'll stop commenting on this.

Hm, thanks for bringing this up, indeed it looks a bit redundant to have
additional compatible strings if HW can identify itself. In such case,
pretty often a generic compatible in the driver and DTS could do... but:

1. Adding specific compatibles for such case would have sense to be able
to validate differences between DTS (like clocks, resets and power domains).

2. Reading HW revision might require enabling clocks which might differ
per variant, thus driver still might need to match according to some
compatibles. After that matching, driver can get necessary clocks,
enable them and read the HW version/revision. There is an example for this:
Documentation/devicetree/bindings/cache/qcom,llcc.yaml
drivers/soc/qcom/llcc-qcom.c
We have there version of the block but clocks and register layout
differ, thus we must have device-specific compatibles.

> 
>> just one implementation in one system. How can you possibly know all
>> other possible implementations (other bootloaders/firmwares/systems)?
>> One cannot. The guideline is there for specific reason.
>>
> 
> I didn't say the guideline is wrong, I just tried to understand how this
> particular case is handled.
>>

Best regards,
Krzysztof

