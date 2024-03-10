Return-Path: <linux-kernel+bounces-98226-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2D6E8776EF
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 14:07:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E37821C20887
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Mar 2024 13:07:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FB02B9B9;
	Sun, 10 Mar 2024 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Y8favrYa"
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 813E8219E9
	for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 13:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710076049; cv=none; b=CCke5mkNVVqslK54jNLZI6kTPikbx1thRG8q3st9m7w3EwTFVDAzXWLtPYmO4RK13Gc/nfU8UCN2sOmohrzoE/TUOB5Vm+O2FVSxtwsIbJVaQCw/SCKUrmUsdbX/U9sEKsC5Sy1nV6FD2naOsz67PQu4oUWs2TZwhRpUiTSrdsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710076049; c=relaxed/simple;
	bh=1uPlPrEVKUnt7HqYHuTJSJiyIgPybhRS2G7y+bBZzIU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWrXE3cky6fbVwBgmddRuzfVpYRuuTGUpioL5+Vf/vo0IGg363c6jpe2DeYZcGJLPvlYRJ4wVG4dj5Uq1yHaYn/W1eaOrpsKeVpZTdlIShqpZjeE+1LAUsbuVOC9Jh8jDRhN2o3DFBQ4hI1KqskntR1Xpu1Wi+Y3+iRLnSyQA8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Y8favrYa; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5684ea117a3so869151a12.0
        for <linux-kernel@vger.kernel.org>; Sun, 10 Mar 2024 06:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710076046; x=1710680846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ABvZnWn9tZjq5i+rgSN4YDv2QcfnVQwhLHVdYpDlTAY=;
        b=Y8favrYaKBEDTEHyS8jcjlIqL3i9OpAeNMknQCFtRfDvofw1FhfwspBR/6fcui6A4/
         UH/PuFQQyQ/Up5zb6pVjSJa0BxAQRwc/kWMrv/unRVbpx1VdFYbI13Z6QTIUxF/eY5xa
         FJFLYUJg/kQTLocr1zfL/WYZ9cEUqkOtfUAXAN1qneiNjMcYcPxe50fvsf4TNyuCv0yu
         WFwKwFbeJKRYkkv4YFWZX3uNGOsNQ37Z0ZyxG8eW+IL6L4Vq7Z9MGu6zECreloWmsBOM
         QVkYUSc/+EQHYSENg74fE1NM+Alhq5Ot5tLxjwTeS6v7iDRZ8KxRaUpkpnORzO8JGZtE
         Xmjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710076046; x=1710680846;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABvZnWn9tZjq5i+rgSN4YDv2QcfnVQwhLHVdYpDlTAY=;
        b=F1yArLNK/Aqxsc1j2QASU0i/vgdc2JE286yHr73t4r4s3EafrO3SSMLDWj2OCgBb8b
         LQEAhTnKE830vcQHOPs8/s9UNwZFr3cp1fLCaYM9JsvtKV40Bc8fPhYX6BZBWDwf9sAM
         U/HxbnE3x3eWgqOt33avivw5vGYh6HZI7wrNl7sTqkiwlZ4zGJ5xi4t6CzVeSWOT0w7p
         5LNV0kKSKx8clx+H44DzXcsrOUyXi2hGvDia7CSSFbO6ceQkWfVnUheinp5w7Th5LvrS
         JNVtScUL8zLwfAGO1kuopvGfHVtjSaHjyZnhzwoz5Skx1JlBiXP2XXbzFJZ7rAFz66sp
         j1ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWcarb0wbQ8hN+07zyxgLVSL2Nesl5KRXvxH86xaaPjsWs4a5I6HPTU3dZvKgplyuM1MMb78S26sh/ppFvutkgN6rI7rQCEO80Gk75S
X-Gm-Message-State: AOJu0Yzw/8K7uEY9B6T0+jW2n7fj5goqgWCjGQ1ps+tqWRQYP9NBeimN
	G0VLKdbxRm1tmP/EUEJC2gKHSIdHOmsAsgdPqrq7oUrrXznDp4Blxf9H7wL+L50=
X-Google-Smtp-Source: AGHT+IFGUvnLEsnyaaP5/jCzVug8KtRNENCov3Mn/RvvWw50/SLHWr6B1GUyYStvfl+8qZGHe4XTeQ==
X-Received: by 2002:a50:934a:0:b0:567:ef00:bdbe with SMTP id n10-20020a50934a000000b00567ef00bdbemr2812909eda.33.1710076045775;
        Sun, 10 Mar 2024 06:07:25 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id b20-20020aa7dc14000000b005684fa1c4dbsm778676edu.52.2024.03.10.06.07.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Mar 2024 06:07:25 -0700 (PDT)
Message-ID: <6b065dce-5271-4ea0-b291-a7aae8e71d20@linaro.org>
Date: Sun, 10 Mar 2024 14:07:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] dt-bindings: imx-pata: Convert to dtschema
Content-Language: en-US
To: Animesh Agarwal <animeshagarwal28@gmail.com>
Cc: Damien Le Moal <dlemoal@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>,
 linux-ide@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240309160741.54096-1-animeshagarwal28@gmail.com>
 <a26689a4-1c8c-4458-bb82-137cd1ac21d0@linaro.org>
 <CAE3Oz80TByuu6=U4PTOHO6k1=KjjRKtPPf7ayhSMZareXP8vdw@mail.gmail.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <CAE3Oz80TByuu6=U4PTOHO6k1=KjjRKtPPf7ayhSMZareXP8vdw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/03/2024 12:52, Animesh Agarwal wrote:
> Ok noted,
> 
> I have now included the explanation.
> 
> Added imx31 in the next patch and tested. Changes of the conversion are now
> mentioned in the next patch.

Please respond inline, instead of top-posting, because it makes your
emails hard to follow.
https://elixir.bootlin.com/linux/v6.8-rc7/source/Documentation/process/submitting-patches.rst#L340


> 
> On Sat, Mar 9, 2024 at 11:38 PM Krzysztof Kozlowski <
> krzysztof.kozlowski@linaro.org> wrote:
> 
>> On 09/03/2024 17:07, Animesh Agarwal wrote:
>>> Convert the imx-pata bindings to DT schema.
>>>
>>> Signed-off-by: Animesh Agarwal <animeshagarwal28@gmail.com>
>>> ---
>>> Changes in v3:
>>> - added fsl,imx51-pata in compatible property
>>
>> Please explain the differences done during conversion in the commit msg.

How did you solve this?

>> There was no imx51 compatible in the binding before.
>>
>>>
>>> Changes in v2:
>>> - fixed style issues
>>> - compatible property now matches the examples
>>> - fixed yamllint warnings/errors
>>> ---
>>>  .../devicetree/bindings/ata/fsl,imx-pata.yaml | 40 +++++++++++++++++++
>>>  .../devicetree/bindings/ata/imx-pata.txt      | 16 --------
>>>  2 files changed, 40 insertions(+), 16 deletions(-)
>>>  create mode 100644
>> Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/ata/imx-pata.txt
>>>
>>> diff --git a/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
>> b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
>>> new file mode 100644
>>> index 000000000000..265ea80434e1
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/ata/fsl,imx-pata.yaml
>>> @@ -0,0 +1,40 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/ata/fsl,imx-pata.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Freescale i.MX PATA Controller
>>> +
>>> +maintainers:
>>> +  - Animesh Agarwal <animeshagarwal28@gmail.com>
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - enum:
>>> +          - fsl,imx51-pata
>>> +      - const: fsl,imx27-pata
>>
>> This allows only imx51 and disallows imx27 alone, which is not what old
------------------------------^^^^^^^^^^^^^^^^^^^^^
How did you solve this?

>> bindings were saying.


>>
>> The best if you just test it on DTS. Please run `make dtbs_check W=1`
>> (see Documentation/devicetree/bindings/writing-schema.rst or
>>
>> https://www.linaro.org/blog/tips-and-tricks-for-validating-devicetree-sources-with-the-devicetree-schema/
>> for instructions).
>>
>> You should see two warnings for imx31 and imx51. You need imx31 as well
>> (and changes against pure conversion should be mentioned in commit msg).

----------------------------------------^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

How did you solve this?


Best regards,
Krzysztof


