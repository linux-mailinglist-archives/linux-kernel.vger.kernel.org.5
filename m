Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EA517B410D
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Sep 2023 16:40:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234296AbjI3Ok1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Sep 2023 10:40:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234202AbjI3Ok0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Sep 2023 10:40:26 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27A1C5
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 07:40:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id 2adb3069b0e04-5048156976cso7430239e87.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Sep 2023 07:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696084818; x=1696689618; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=MOC1kXoNDe8pCL9laVhkufInyup8OMoO7BrVzpZVM80=;
        b=Hc9ViEzuqR2Hbei+8UdtYJbP7g16piff9nIle3uLSs+FZHDpPVrHqKxzQck0mJC5iz
         aY4JIt2oOPpRoJzRVH0e5lDft8O78NPxOS0HRuEPHYGDTlxjLl3L3wuxv5hWJjcpaMhv
         bpBHknXKnidoJLgjyNw/DsFWAqjt8gxtfZDi7kF/CMwFdGPt4a5t0ITe9b+lgGIk00ay
         Sw88pucwinEDK4baoxvf393iqazgdE1fGLtgbvMMCczYFXI1ck+JguoW2pxROGYyC20I
         T7J8doDOybcpsHnfCHPzg5XlpRS2e7x+XGYhyWYUoFm9bzyk4uwq0qHmRFXN6Dr3QsMU
         Q96Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696084818; x=1696689618;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MOC1kXoNDe8pCL9laVhkufInyup8OMoO7BrVzpZVM80=;
        b=BUgjkrjJrRlWrQLEaFSqonSENsfmrc46k/+pDUuG9ySZDN0GAjCxAUbMecyJCbo23b
         ol84MWVHVbns9HVWC0HbZBmVcYDU+DZL9ncON4DbtEEKupP4uJywvf2bVFnMCdjEmK9v
         XRENnGjQE9J2vrlo6vT+Pk9OqzElI2m9UKeaLIw63n4uxfzMo4BD06Dh/+SmN47Y6FHq
         ZfPtTve7+6gT4HmTGpQl7HBbSfWl5BHPpDMxsaFoCAH5HsEm6hsStXNZ9JR36nLNnMKJ
         3mUATF1yV0XKxxACWC8T6/xtJohBStHaSlM/SwFf7e/SakCAZorIkLUPRR/0ODTTohaz
         ZzXQ==
X-Gm-Message-State: AOJu0Yy6dyHJGVReIFeZKCHYACsXhYY7xNIWKGGBcBbpFD7IMTzKx0MV
        Co0fhGN3h7XWH56wKfjkc5gsuA==
X-Google-Smtp-Source: AGHT+IGFwcWf8r36UUQ5t39cu6pwQ0Y8jFneKWdzYiKz0HyzJJeYur6Czc5/J+kN9cWgPPCsKwxDcA==
X-Received: by 2002:a05:6512:1595:b0:500:b828:7a04 with SMTP id bp21-20020a056512159500b00500b8287a04mr6762639lfb.18.1696084817766;
        Sat, 30 Sep 2023 07:40:17 -0700 (PDT)
Received: from [192.168.8.76] ([88.154.47.206])
        by smtp.gmail.com with ESMTPSA id y22-20020a170906449600b009adc77fe165sm13881566ejo.118.2023.09.30.07.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Sep 2023 07:40:17 -0700 (PDT)
Message-ID: <80106a0b-87a6-47e2-93ed-5e19ac76ef45@linaro.org>
Date:   Sat, 30 Sep 2023 16:40:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign
 slot for imx jpeg encoder/decoder
To:     Ming Qian <ming.qian@nxp.com>,
        "Mirela Rabulea (OSS)" <mirela.rabulea@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>
Cc:     "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "mchehab@kernel.org" <mchehab@kernel.org>,
        "hverkuil-cisco@xs4all.nl" <hverkuil-cisco@xs4all.nl>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "X.H. Bao" <xiahong.bao@nxp.com>, Eagle Zhou <eagle.zhou@nxp.com>,
        Tao Jiang <tao.jiang_2@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230926101000.13392-1-ming.qian@nxp.com>
 <20230926101000.13392-2-ming.qian@nxp.com>
 <2c351ca0-cee4-4c1b-956b-6134ad101a9a@linaro.org>
 <AM6PR04MB63415CF2EDCF0AF33F778774E7C2A@AM6PR04MB6341.eurprd04.prod.outlook.com>
 <45abc9ec-1f7a-469c-bc0f-2a065499b0b4@linaro.org>
 <AM6PR04MB63412A27FDC244D1A8FB7CA0E7C1A@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <AM6PR04MB63412A27FDC244D1A8FB7CA0E7C1A@AM6PR04MB6341.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/09/2023 11:42, Ming Qian wrote:
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: 2023年9月28日 13:07
>> To: Ming Qian <ming.qian@nxp.com>; Mirela Rabulea (OSS)
>> <mirela.rabulea@oss.nxp.com>; robh+dt@kernel.org; shawnguo@kernel.org
>> Cc: krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>> mchehab@kernel.org; hverkuil-cisco@xs4all.nl; s.hauer@pengutronix.de;
>> kernel@pengutronix.de; festevam@gmail.com; X.H. Bao
>> <xiahong.bao@nxp.com>; Eagle Zhou <eagle.zhou@nxp.com>; Tao Jiang
>> <tao.jiang_2@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
>> devicetree@vger.kernel.org; linux-media@vger.kernel.org; linux-
>> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>> Subject: Re: [EXT] Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg: Assign slot
>> for imx jpeg encoder/decoder
>>
>> Caution: This is an external email. Please take care when clicking links or
>> opening attachments. When in doubt, report the message using the 'Report
>> this email' button
>>
>>
>> On 27/09/2023 11:10, Ming Qian wrote:
>>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Sent: 2023年9月27日 16:06
>>>> To: Ming Qian <ming.qian@nxp.com>; Mirela Rabulea (OSS)
>>>> <mirela.rabulea@oss.nxp.com>; robh+dt@kernel.org;
>> shawnguo@kernel.org
>>>> Cc: krzysztof.kozlowski+dt@linaro.org; conor+dt@kernel.org;
>>>> mchehab@kernel.org; hverkuil-cisco@xs4all.nl; s.hauer@pengutronix.de;
>>>> kernel@pengutronix.de; festevam@gmail.com; X.H. Bao
>>>> <xiahong.bao@nxp.com>; Eagle Zhou <eagle.zhou@nxp.com>; Tao Jiang
>>>> <tao.jiang_2@nxp.com>; dl-linux-imx <linux-imx@nxp.com>;
>>>> devicetree@vger.kernel.org; linux-media@vger.kernel.org; linux-
>>>> kernel@vger.kernel.org; linux-arm-kernel@lists.infradead.org
>>>> Subject: [EXT] Re: [PATCH v4 2/2] dt-bindings: media: imx-jpeg:
>>>> Assign slot for imx jpeg encoder/decoder
>>>>
>>>> Caution: This is an external email. Please take care when clicking
>>>> links or opening attachments. When in doubt, report the message using
>>>> the 'Report this email' button
>>>>
>>>>
>>>> On 26/09/2023 12:10, Ming Qian wrote:
>>>>> There are total 4 slots available in the IP, and we only need to use
>>>>> one slot in one os, assign a single slot, configure interrupt and
>>>>> power domain only for 1 slot, not for the all 4 slots.
>>>>>
>>>>> Signed-off-by: Ming Qian <ming.qian@nxp.com>
>>>>> ---
>>>>> v4
>>>>> - improve commit message
>>>>> - don't make an ABI break
>>>>> v3
>>>>> - add vender prefix, change property slot to nxp,slot
>>>>> - add type for property slot
>>>>>
>>>>>  .../bindings/media/nxp,imx8-jpeg.yaml         | 45 +++++++++----------
>>>>>  1 file changed, 21 insertions(+), 24 deletions(-)
>>>>>
>>>>> diff --git
>>>>> a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>>>>> b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>>>>> index 3d9d1db37040..4bcfc815c894 100644
>>>>> --- a/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>>>>> +++ b/Documentation/devicetree/bindings/media/nxp,imx8-jpeg.yaml
>>>>> @@ -32,19 +32,26 @@ properties:
>>>>>      maxItems: 1
>>>>>
>>>>>    interrupts:
>>>>> -    description: |
>>>>> -      There are 4 slots available in the IP, which the driver may use
>>>>> -      If a certain slot is used, it should have an associated interrupt
>>>>> -      The interrupt with index i is assumed to be for slot i
>>>>> -    minItems: 1               # At least one slot is needed by the driver
>>>>> -    maxItems: 4               # The IP has 4 slots available for use
>>>>> +    description:
>>>>> +      Interrupt number for slot
>>>>> +    maxItems: 1
>>>>>
>>>>>    power-domains:
>>>>>      description:
>>>>>        List of phandle and PM domain specifier as documented in
>>>>>        Documentation/devicetree/bindings/power/power_domain.txt
>>>>> -    minItems: 2               # Wrapper and 1 slot
>>>>> -    maxItems: 5               # Wrapper and 4 slots
>>>>> +    minItems: 1               # VPUMIX
>>>>> +    maxItems: 2               # Wrapper and 1 slot
>>>>> +
>>>>> +  nxp,slot:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    description:
>>>>> +      Integer number of slot index used. There are 4 slots available in the IP,
>>>>> +      and driver can use a certain slot, it should have an associated
>> interrupt
>>>>> +      and power-domain. In theory, it supports 4 os or vm. If not specified,
>> 0
>>>>> +      is used by default.
>>>>> +    minimum: 0
>>>>> +    maximum: 3
>>>>
>>>> NAK, you still did not answer concerns why this is needed and justified.
>>>> I keep asking and you keep ignoring...
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>
>>> Hi Krzysztof,
>>>
>>>> Nothing explains what is a slot and nothing explains why do you need this
>> property.
>>>
>>> I thought I had answered that question, but seems you don't agree with that
>> explanation.
>>> Would the following description be any better?
>>
>> No, you didn't. I don't see any explanation in the commit msg. You just say
>> you have "4 slots".
>>
>> Best regards,
>> Krzysztof
> 
> Hi Krzysztof,
> 
> I check the our document again, it does not give a standard definition too. I'll explain it as I understand it. This IP includes a jpeg wrapper, the wrapper is working on descriptor based manner. It support up to 4 slots, each slots can have its own chained descriptors. The purpose is to share the jpeg engine across multiple VMS and os, It's a bit like vm partitioning. We just want to assign 1 slot to linux, Then, theoretically, it can support up to 3 VMS.
> The slot index indicates which slot we choose, driver will use the slot index to configure. If not specified, 0 is used by default.
> Currently driver only use the slot 0 by default, but it enable the power-domain and request irq to all the 4 slots.  there has been no real negative impact, as we have no practical application to use other slots yet. But it does cause trouble when we want to use another slot in a vm.

Which parts of hardware are common and which are shared?

Best regards,
Krzysztof

