Return-Path: <linux-kernel+bounces-87955-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2085A86DB77
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 07:30:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8E37F1F227B5
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Mar 2024 06:30:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08FDA604B5;
	Fri,  1 Mar 2024 06:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zP5w/qsL"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73DA460254
	for <linux-kernel@vger.kernel.org>; Fri,  1 Mar 2024 06:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709274651; cv=none; b=DCtuhHtEG404D7XP1pjSro63QrrfczFKBFvHFXKgTiniFHqKCJ2E50fuPUTDs9s7+5AKTQjZ5KDNnQh0+wi5z1PTydYdiBq7hOZHXT36Ge6/TjFU7EJGU81ugTlHBMcCsIiUDldW5zIVXibnRPZloKN1N3faHsGPl8TbHnUxkjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709274651; c=relaxed/simple;
	bh=k5V8vWbKOVu5rrnBCKAXa/253TOmV4ruxxbPCrXY1KM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKdpKZ326Ozy/o41nCa6U0hgD3aktD2F/rPkadX+VbLHx72mVyIApiCn7AUbrLRVNRL2T/LUpwKGbKFpHhJLx01P/VtEQsWeW9PgJu1D3X5EbFu+9N06hW05rHeki03JKRIJUeKuxvMe3bXYJHjvDfjnCdIXSGO5QsZ4FAYQ8A8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zP5w/qsL; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-563f675be29so2352061a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 22:30:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709274647; x=1709879447; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=aQcieXKF9GCrmMdAMMXGeMlTjz7NiZHPsZQNigcQEYE=;
        b=zP5w/qsLRzUI5DlgZmVaPyYDUZ86888MRYxPxiihrKus2xzCTxNalLXFW2jhQo6MSV
         AAaKpGKSsfr+cT4GmIpY0vkx7El7JRQ/JXgCQNd0dTpeW/ly4S8I9OfUBvXdg9/hMIoo
         McV4BWFSsNzVgM5fv9eds4ypWcvUMf2ZZ5w4wnDm2NXXvw2BbH/ybYJ6aazkj+VI9kxg
         faC2V0xxRdpQHmgHSADdL5ooSLEeAZJ6gen7Za91NuWXRjLAc/bZoGxngUJtEniihrNi
         Re31JCr4ZrEMqmfjd+TuKKhqdySNO7OmE8JNlwLa29BSYcg1Zr6nZVyhtNbkT0rY4mc4
         RRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709274647; x=1709879447;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aQcieXKF9GCrmMdAMMXGeMlTjz7NiZHPsZQNigcQEYE=;
        b=UgLdPm/ojZXv2I1Tc8sa80ItSGJyb6uSc32AAOMe/aDg+fVJHh5CGPgKaEcT0sU2av
         Zj1pExto16myjthAHyZZE7CagsoxT4/uu6w7BTb7hvts6tuUFfTLmAK1h6PNfElkuxC/
         KXym/OaT2fl4ZIwQddSWoM07DTyz3EccMccvWlAG0hw8HSW5XUAXaqf81y2yopM0jG5X
         UERvxPJriBEH/mYuK6SnY/1LygQtyHF7BjVSa3fewefHZhFPz/6ngsDVI0j8BGbDZUHZ
         mhXnuoI6p6zGr1DX4+QbjNLP0akuwVlGPONyMn/apyzbrRgY6n5ofYiFI3hpd6I/9cTK
         uJlQ==
X-Forwarded-Encrypted: i=1; AJvYcCUi+jkE1VQeu0U9RChdIyK/aKj5o18ll9CiyPMsdzqEhuCpQC/GZgpS4yxZWqYEyGwExGUZT8aKAgP2hnOAyBasugGGp3zV/Bg5OITn
X-Gm-Message-State: AOJu0Yyvm1kA4XXu7/kv2jjbwxwTWIpnLIGOIurrctx+49BOzNxtBQ2V
	XTmVLlf0VW1uKKrjn9BkmRIuSjnLYnz9fk8QROtEbEc+T9dyw5a0JPn0T946TxY=
X-Google-Smtp-Source: AGHT+IGSNoAmpYgNPAtqvUYUD4eCOtLsMfV3o/9sM6pyzlMN2Qlq4pj7F3rZftORbzbgCQ7xE0a3KQ==
X-Received: by 2002:a05:6402:5245:b0:566:dede:1f82 with SMTP id t5-20020a056402524500b00566dede1f82mr116248edd.29.1709274647520;
        Thu, 29 Feb 2024 22:30:47 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id o20-20020aa7c514000000b005663e9bd8c1sm1258757edq.38.2024.02.29.22.30.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 22:30:46 -0800 (PST)
Message-ID: <a1861d70-80e2-4f42-b99a-f2b8c8efe042@linaro.org>
Date: Fri, 1 Mar 2024 07:30:45 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/4] ASoC: dt-bindings: fsl,imx-asrc: update max
 interrupt numbers
Content-Language: en-US
To: Frank Li <Frank.li@nxp.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Shengjiu Wang <shengjiu.wang@nxp.com>,
 linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20240228-asrc_8qxp-v3-0-d4d5935fd3aa@nxp.com>
 <20240228-asrc_8qxp-v3-2-d4d5935fd3aa@nxp.com>
 <3460ecc8-d7d7-4d1c-ad0c-b32efc3b9049@linaro.org>
 <ZeFTqM8o/eozl+MS@lizhi-Precision-Tower-5810>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <ZeFTqM8o/eozl+MS@lizhi-Precision-Tower-5810>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/03/2024 05:03, Frank Li wrote:
> On Thu, Feb 29, 2024 at 10:44:42AM +0100, Krzysztof Kozlowski wrote:
>> On 28/02/2024 20:14, Frank Li wrote:
>>> fsl,imx8qxp-spdif and fsl,imx8qm-spdif have 2 interrupts. Other platforms
>>> have 1 interrupt.
>>>
>>> Increase max interrupt number to 2 and add restriction for platforms except
>>> i.MX8QXP and i.MX8QM.
>>>
>>> Signed-off-by: Frank Li <Frank.Li@nxp.com>
>>> ---
>>>  .../devicetree/bindings/sound/fsl,spdif.yaml         | 20 +++++++++++++++++++-
>>>  1 file changed, 19 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
>>> index 82430f1d5e5a2..785f7997eea82 100644
>>> --- a/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
>>> +++ b/Documentation/devicetree/bindings/sound/fsl,spdif.yaml
>>> @@ -31,7 +31,8 @@ properties:
>>>      maxItems: 1
>>>  
>>>    interrupts:
>>> -    maxItems: 1
>>> +    minItems: 1
>>> +    maxItems: 2
>>>  
>>>    dmas:
>>>      items:
>>> @@ -100,6 +101,23 @@ required:
>>>  
>>>  additionalProperties: false
>>>  
>>> +allOf:
>>> +  - if:
>>> +      properties:
>>> +        compatible:
>>> +          enum:
>>> +            - fsl,imx35-spdif
>>> +            - fsl,vf610-spdif
>>> +            - fsl,imx6sx-spdif
>>> +            - fsl,imx8mq-spdif
>>> +            - fsl,imx8mm-spdif
>>> +            - fsl,imx8mn-spdif
>>> +            - fsl,imx8ulp-spdif
>>> +    then:
>>> +      properties:
>>> +        interrupts:
>>> +          maxItems: 1
>>
>> else:
>> minItems: 2
> 
> I think needn't 'else' here. Top have set to maxItems is 2. 

So explain why one item is correct here.


Best regards,
Krzysztof


