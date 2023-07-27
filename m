Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F3D76489A
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jul 2023 09:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233367AbjG0H1d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jul 2023 03:27:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233412AbjG0H1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jul 2023 03:27:02 -0400
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2878D7289
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:16:15 -0700 (PDT)
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-992e22c09edso73116766b.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jul 2023 00:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1690441761; x=1691046561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WuVS/PZjONA9J7GPCgyKbonCUah/ze6kISBj9WngEoY=;
        b=PMAgtuZU7frCtMUucTUCYT52+A2H3nvrcEGxZjDPb/mxMtYlKoM6N7T2nC9zCRuNLg
         dIRnaGNsAmhvkOJqwt9Y7j5Pjbhkx02aSNJAPzBbmmwb0X3v2J0I+M7/weDYoI0uuU6N
         L6AnTBd3+SmJ0nT8jWH6kEuc5UVIyr2ZH50binbN6WeKqVub8I1YQXTdObrv4B6H8gqT
         qgWXrbW6nRK/do1AwxeU/BKIT6+ndzBiAWcTYTcR36ry/ZBiC3zWzCL7nLDqu42K3kV0
         8sat3BCH8medfAIhGmH7QP5ex48suAqtsL81+aqKJ1X3gvYByL3ycK8jPdwBvoVNvmQ2
         q/eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690441761; x=1691046561;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WuVS/PZjONA9J7GPCgyKbonCUah/ze6kISBj9WngEoY=;
        b=T+qT2Mc7UDkHr0iCu4PGv77ZrQ4laP3Btj56hvEOsSrtzHnMlRMLYVRgG69TOzSjMh
         AS/gEuUH4HPaRSNjA7SxL5tqDxdFZXaAC04Pm02hyKvRB+zLlqjYcHGIFLb2HL1691uc
         Mj+o5T3kqZqMjxF2d/ZRp4F2XD7tf0LeB6ir7hhmpwD4lbp6NHKFkUNC/b7sVEXjAdRm
         RSEF1N4OB7o+suGAVMECnJhGnIC4K4rf0kAFd13EO8163H5hWXCeC3EIdv87KMWTUOY6
         9R3lkrIVL1VWAicn7oFvVyBgk1DkB5rk+5hmTPasfHvkre7RNp2GPOGT4/iaH5nB/fg2
         ZhZg==
X-Gm-Message-State: ABy/qLYuNx7k1wuUDvedoeIhsc+TBhtD0d4CGdQ28oy0bSOP+yuF8pgp
        oEgPG2EXPzSWXYno9ZigEHzAng==
X-Google-Smtp-Source: APBJJlFJIj7/F/D7BtlaJMilOmWF/dsdVZqc9G8XApKG5blYrDY+P8zOKCY5IsODaeIQP4IGI9dhbA==
X-Received: by 2002:a17:907:9051:b0:993:eef2:5d5d with SMTP id az17-20020a170907905100b00993eef25d5dmr1149153ejc.27.1690441761612;
        Thu, 27 Jul 2023 00:09:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id i10-20020a170906250a00b0099304c10fd3sm401382ejb.196.2023.07.27.00.09.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jul 2023 00:09:21 -0700 (PDT)
Message-ID: <0185a53f-b3c4-6ec7-95ae-e74f0998d6c6@linaro.org>
Date:   Thu, 27 Jul 2023 09:09:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/3] dt-bindings: input: qcom,pm8xxx-vib: add new SPMI
 vibrator module
Content-Language: en-US
To:     Fenglin Wu <quic_fenglinw@quicinc.com>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        agross@kernel.org, andersson@kernel.org,
        dmitry.baryshkov@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org
Cc:     quic_collinsd@quicinc.com, quic_subbaram@quicinc.com,
        quic_kamalw@quicinc.com, jestar@qti.qualcomm.com
References: <20230725054138.129497-1-quic_fenglinw@quicinc.com>
 <20230725054138.129497-3-quic_fenglinw@quicinc.com>
 <b2ad4863-a38b-7fb6-65b1-ea336c4fc876@linaro.org>
 <3aaccc94-59b3-31d3-eac7-f8926f8c88ff@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <3aaccc94-59b3-31d3-eac7-f8926f8c88ff@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/07/2023 08:26, Fenglin Wu wrote:
> 
> 
> On 7/25/2023 1:53 PM, Krzysztof Kozlowski wrote:
>> On 25/07/2023 07:41, Fenglin Wu wrote:
>>> Add compatible string 'qcom,spmi-vib-gen2' for vibrator module inside
>>> PMI632, PMI7250B, PM7325B, PM7550BA. Also, add 'qcom,spmi-vib-gen1'
>>> string for the SPMI vibrator inside PM8916 to maintain the completeness
>>> of the hardware version history for SPMI vibrators.
>>>
>>> Signed-off-by: Fenglin Wu <quic_fenglinw@quicinc.com>
>>> ---
>>>   .../bindings/input/qcom,pm8xxx-vib.yaml        | 18 ++++++++++++++----
>>>   1 file changed, 14 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
>>> index c8832cd0d7da..ab778714ad29 100644
>>> --- a/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
>>> +++ b/Documentation/devicetree/bindings/input/qcom,pm8xxx-vib.yaml
>>> @@ -11,10 +11,20 @@ maintainers:
>>>   
>>>   properties:
>>>     compatible:
>>> -    enum:
>>> -      - qcom,pm8058-vib
>>> -      - qcom,pm8916-vib
>>> -      - qcom,pm8921-vib
>>> +    oneOf:
>>> +      - enum:
>>> +          - qcom,pm8058-vib
>>> +          - qcom,pm8916-vib
>>> +          - qcom,pm8921-vib
>>> +          - qcom,spmi-vib-gen1
>>> +          - qcom,spmi-vib-gen2
>>
>> Generic compatibles should not be alone. Drop both lines.
> 
> Sure. I will remove 'qcom,spmi-vib-gen2'.
> Should I also keep 'qcom,spmi-vib-gen1' as generic compatible and move 
> 'qcom,pm8916-vib' as its fallback as following?

I would drop all of generic ones. Entirely remove qcom,spmi-vib-gen2 and
qcom,spmi-vib-gen1.

Use device specific compatibles names only. As fallback and as first
compatible.

Best regards,
Krzysztof

