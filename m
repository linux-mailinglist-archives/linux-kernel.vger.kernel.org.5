Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 859DE752019
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232841AbjGMLiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232461AbjGMLin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:38:43 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 299D3E5C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:38:42 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4fba8f2197bso1067393e87.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:38:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689248320; x=1691840320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gkxaOO+CHvkkNHNAedQF2pdgDoOPgApXqdl51IGfcu4=;
        b=s923okNqmRTL1o3NnbuwJ9dVf9F0FFkNU7AI7QAAPQmisbkv4iajKQU+/p4WgGSzbH
         chdSzQzm5i9GlGc3f2MUrXEggFZv7hwRGMxQvD5IDp6eUYPOPGYCbvNVtmEprjU9bbxc
         j5mM3vjUvvwUSYU5cQ3uL50UVNfNhkkf0Vh8IgWtX070Qe/v3dXUH+Wwy8emitQ7ag6j
         f+eQorXU7oZhmFa/wfsCgl4jy0P4oWmR5BXLMNLd1CNd6YAxnPyX2Oxg7VzjEZCo0UoT
         eskG3yGIE+VI7XrhT6ndu2CGRMFpaIzdEH4UAA2WDjGwEqJQ5wUFzFfFpjT+HDqRZ0cG
         qCtw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689248320; x=1691840320;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gkxaOO+CHvkkNHNAedQF2pdgDoOPgApXqdl51IGfcu4=;
        b=RBLQQB41y5SVQFXtz/y+gvBpRsLInVXnfapf1spmaZ2+SCtJ+XqJRE8fGJC7hflDYE
         1k9IbFuEcxt79rWfyfUboOo1oIn1tNjcsDmNm3rXzk3RqbmO5VkAAB4/1SxuvGduewkb
         Os+J5qZPFSaO2BM7HQiFtpWYqI7itgzlUwta06ILEZP1zFPMi9Bo9wIOKn1MwxOKkcjk
         B3CnB0kNnGuIeZvwJFlS8H2FEjvHpVZUxj+BUeL63QIz+Ug0ENOb5K/FuIDQV3nYEiUR
         79Aiv21V7nTcR332P3Igtz3IZNcydRFpeeYL++DAAVnR2A7ZbFQdccK7Dw/rqe3nuZ48
         9p/g==
X-Gm-Message-State: ABy/qLaTFCsorhrPGtzsaj8sLOr1J0+jJr17VMFF/X80Pu8OPogzsg2R
        mJ6pz74kV9Mqsogqrf9WB97JQg==
X-Google-Smtp-Source: APBJJlFbztQimcm1kAYwn6R3xa11Hk9ZS9hMlJ0qmtnR5prNqridycqQPgwm1uohXWe0zuYeCXgQsA==
X-Received: by 2002:a05:6512:b85:b0:4fb:9075:4fca with SMTP id b5-20020a0565120b8500b004fb90754fcamr1159049lfv.11.1689248320438;
        Thu, 13 Jul 2023 04:38:40 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id i16-20020adffdd0000000b0030fb4b55c13sm7738058wrs.96.2023.07.13.04.38.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Jul 2023 04:38:39 -0700 (PDT)
Message-ID: <684ce378-a697-a352-eba7-c8f3ad62d8e4@linaro.org>
Date:   Thu, 13 Jul 2023 13:38:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/6] dt-bindings: thermal: tsens: Add nvmem cells for
 calibration data
Content-Language: en-US
To:     Praveenkumar I <quic_ipkumar@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, amitk@kernel.org,
        thara.gopinath@gmail.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, rui.zhang@intel.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     quic_varada@quicinc.com
References: <20230710103735.1375847-1-quic_ipkumar@quicinc.com>
 <20230710103735.1375847-2-quic_ipkumar@quicinc.com>
 <09e33a89-c060-69b1-b94f-b21c45d1d249@linaro.org>
 <59ea653e-c5da-71cb-eb85-1aa3c72e2089@quicinc.com>
 <37aa7ae8-206e-3a48-b90d-22d49e86c675@linaro.org>
 <1b050086-07c5-add6-6002-d7368d532566@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1b050086-07c5-add6-6002-d7368d532566@quicinc.com>
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

On 11/07/2023 16:13, Praveenkumar I wrote:
>>>>>              - const: calib
>>>>> @@ -205,6 +209,24 @@ properties:
>>>>>              - const: s9_p2_backup
>>>>>              - const: s10_p1_backup
>>>>>              - const: s10_p2_backup
>>>>> +      - items:
>>>>> +          - const: mode
>>>>> +          - const: base0
>>>>> +          - const: base1
>>>>> +          - const: s0_offset
>>>>> +          - const: s3_offset
>>>>> +          - const: s4_offset
>>>>> +          - const: s5_offset
>>>>> +          - const: s6_offset
>>>>> +          - const: s7_offset
>>>>> +          - const: s8_offset
>>>>> +          - const: s9_offset
>>>>> +          - const: s10_offset
>>>>> +          - const: s11_offset
>>>>> +          - const: s12_offset
>>>>> +          - const: s13_offset
>>>>> +          - const: s14_offset
>>>>> +          - const: s15_offset
>>>> Don't introduce new naming style. Existing uses s[0-9]+, without offset
>>>> suffix. Why this should be different?
>>> As I mentioned above, s[0-9]+_p1 / s[0-9]+p2 is for TSENS V1. TSENS V2
>>> QFPROM layout is different from the existing one.
>> I know, I did not write about p1/p2.
>>
>>> I would like to add mode, base0, base1 and 16 patterns
>>> '^s[0-15]+_offset$'. But DT binding check is failing in oneOf/ anyOf
>>> condintion.
>> This does not explain why you need different style - this "offset" suffix.
> In QFPROM, the BIT field names are s0_offset, s3_offset to s15_offset. 
> s1_offset and s2_offset not present in IPQ5332.
> Hence used the same "offset" suffix here. May I know in this case, which 
> nvmem-cells-names you are suggesting to use?

"Existing uses s[0-9]+"

so s[0-9]+

Best regards,
Krzysztof

