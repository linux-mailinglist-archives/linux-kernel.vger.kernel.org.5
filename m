Return-Path: <linux-kernel+bounces-11516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A543481E790
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 14:19:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 05463B218F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Dec 2023 13:18:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D39C34EB50;
	Tue, 26 Dec 2023 13:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="twAAaFgJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 807A64F201
	for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 13:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-54c70c70952so5047999a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Dec 2023 05:18:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703596702; x=1704201502; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0hWC4ky6Oznmoj/OdV9qVAf2TSAyAo5GtDnUFoSENCY=;
        b=twAAaFgJ7qsEF8aWf7yDFKdWyDZVYnakR1TW1WfyChSNCjecJORjDPx4OA4O8Cqaas
         Ax8oPswfYglkGbAmtqYRBlOMEdXSRJKc9fWrXDuariYcRAiN5kr/N26+0YVCQI41RW0z
         cWJALQ3uK/5AON2U1l128ydOe3ZMzq81XMn2LAoU69PHQvISA3t4q3vDUTYNKJ4+llOO
         3iYpl8k5PZ/vxVdLcKKnu/NL3C+RLNr9oEAHvc2qYOR4puVMQHWYxHzlif4WZrjZxKSD
         DDPHkWjmQ+SPvr2+0BeFZwTKN12o1wtKyfxeXhzsXvSvOgkspLYtb+6vV6142lfZ5Yp1
         BvoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703596702; x=1704201502;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0hWC4ky6Oznmoj/OdV9qVAf2TSAyAo5GtDnUFoSENCY=;
        b=C3jE9/NodgDiYPJ7Zqo/J8aZdlOBQtPGf5qJmyIWxbxfQp7NFa2JrlyNrz4fp8ss+x
         RFJkThmn2tntL91mIGkdzJGJgA5QQlFasRkrz3WwWwQl6koEqb0QGwBBm2AdhwsXcQhk
         8Fteic/EUIRgx5/UX9pYyuXHHwD498xxnLTYuRMe1/bSbWGCuwVP4Ms8n/guUYF63I5E
         Es9Ac2ICIrWgXuGhrTQIwHBsGmQukNbUiPym4/lH+Q01PpQ7hkzr883RtV2DQ5Y/5vPw
         DVmuYENIa9CTcRWJPkldV+tjOB9rp0zoYqZwg+z4/FvPM1ViiwhhzYbZglm2bYtA+j2j
         jHMw==
X-Gm-Message-State: AOJu0Yzuld9UPJVdNDt9AWsQG1LESLEwyXtDRf3PPAy/2f28DaFEDmIR
	7QhO0Bf/e7Z76oI2gzN8QPgtTyELpH+6yw==
X-Google-Smtp-Source: AGHT+IF/GOTzszbFp2n8UNjcRVN+dZC++0Dbk6pOPGO5J9ruweDrWW8tFCcMYgC/iiT0GMjLUjVdlQ==
X-Received: by 2002:a50:d507:0:b0:553:3b48:473a with SMTP id u7-20020a50d507000000b005533b48473amr3218243edi.109.1703596701646;
        Tue, 26 Dec 2023 05:18:21 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id el13-20020a056402360d00b00552d03a17acsm7331459edb.61.2023.12.26.05.18.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Dec 2023 05:18:21 -0800 (PST)
Message-ID: <28c8b31c-8dcb-4a19-9084-22c77a74b9a1@linaro.org>
Date: Tue, 26 Dec 2023 14:18:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] dt-bindings: net: ipq4019-mdio: Document ipq5332
 platform
Content-Language: en-US
To: Jie Luo <quic_luoj@quicinc.com>, agross@kernel.org, andersson@kernel.org,
 konrad.dybcio@linaro.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, andrew@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, robert.marko@sartura.hr
Cc: linux-arm-msm@vger.kernel.org, netdev@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_srichara@quicinc.com
References: <20231225084424.30986-1-quic_luoj@quicinc.com>
 <20231225084424.30986-6-quic_luoj@quicinc.com>
 <dee72ce8-b24e-467a-b265-1b965588807f@linaro.org>
 <aeb364a3-6c05-4a1b-ba32-e687a89f20f8@quicinc.com>
 <58dde1a7-ed4a-442c-bb5c-c3f6d926fb7e@linaro.org>
 <06ddbae8-1502-41fb-8cf8-9a3390dad557@quicinc.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <06ddbae8-1502-41fb-8cf8-9a3390dad557@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/12/2023 14:06, Jie Luo wrote:
> 
>>
>>
>>>
>>>>
>>>>> +      the platform IPQ50xx/IPQ5332.
>>>>
>>>> So these are valid for all platforms or not? Looks not, but nothing
>>>> narrows the list for other boards.
>>>
>>> i add the limitation on the reg usage for the ipq5332 platform on the
>>> following part "if condition" of this patch, i will update the patch
>>> to narrow down for the other compatibles.
>>>
>>>>
>>>> Anyway, why do you add entries in the middle? LDO was the second, so it
>>>> cannot be now fifth.
>>>
>>> As Rob's suggestion, i move the cmn_blk to second location for
>>> simplifying the limitation description, i checked the upstream dts code,
>>> the LDO is not used currently, so we can move cmn_blk to the second
>>> location here.
>>
>> I cannot find his suggestion in the previous thread. Where did he
>> propose it?
> 
> Rob suggested this on the V2 as below.
> "
> Perhaps cmn_blk should come 2nd, so all the variants have the same entry
> indices. Then you can move this to the top level and just say 'minItems:
> 4' here.

Wasn't this for new devices? What about all existing which have LDO as
the second entry?

>>>>> +  qcom,cmn-ref-clock-frequency:
>>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>>> +    enum:
>>>>> +      - 25000000
>>>>> +      - 31250000
>>>>> +      - 40000000
>>>>> +      - 48000000
>>>>> +      - 50000000
>>>>> +      - 96000000
>>>>> +    default: 48000000
>>>>> +    description: |
>>>>> +      The reference clock source of CMN PLL block is selectable, the
>>>>> +      reference clock source can be from wifi module or the external
>>>>> +      xtal, the reference clock frequency 48MHZ can be from internal
>>>>> +      wifi or the external xtal, if absent, the internal 48MHZ is used,
>>>>> +      if the 48MHZ is specified, which means the external 48Mhz is used.
>>>>
>>>> This does not resolve mine and Conor's concerns from previous version.
>>>> External clocks are defined as clock inputs.
>>>
>>> No matter the external or internal reference clock, they are the clock
>>> source selection for CMN, there are only 48MHZ can be external or
>>> internal, other clocks have the different clock rate, so the internal
>>> 48MHZ reference clock can be implied when the
>>> "qcom,cmn-ref-clock-frequency" is not defined, which is suggested by
>>> Conor in the previous
>>> comments.
>>
>> I don't think he proposed it, but maybe I missed some message (care to
>> point me to his message where he agreed on usage of
>> qcom,cmn-ref-clock-frequency?). I am pretty sure we both stayed on the
>> same page, that the presence of clocks defines choice of internal clock.
>> This property should go away.
> 
> Sorry for this confusion.
> Rob said the internal reference source can be decided by the absence of
> the property combined with compatible string, because i said the

So all your three DT maintainers agree that lack of property for
choosing clock, defines the usage of interrupt source.

Now we had huge amount of arguments that you do not represent properly
the clock relationships. Still.

> internal 96MHZ is used on ipq5018 currently in the previous message.
> 
> per double checked the current IPQ platforms, the internal 96MHZ is also
> possible on ipq9574, and the reference clock source should be kept as
> configurable instead of limited by the compatible string, maybe the
> different reference clock source is acquired in the future, even
> currently it is not used on the special platform for now.
> 
> so i update the solution with a little bit of changes.

You still do not want to implement our suggestions and I don't
understand your arguments. Nothing in above paragraph explains me why
you cannot use clock provider/consumer relationships.


Best regards,
Krzysztof


