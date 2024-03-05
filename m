Return-Path: <linux-kernel+bounces-91794-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49BEA8716BA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 08:27:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C902A1F21DE5
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 07:27:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE47E7E590;
	Tue,  5 Mar 2024 07:27:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YRwKKu/H"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3F177E56C
	for <linux-kernel@vger.kernel.org>; Tue,  5 Mar 2024 07:27:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709623637; cv=none; b=umZodAgq4XOlkK+USLRpnMuOcL+pIXvPUbOmKIE2NrHy1putVAF7zXAJ8vWcLrSlj10MTwagTj9DRuGnzNbcdR/QUo9TKzYb5Rtk4gCJQvTEGWd36G9aBScPYtTGK0twXGEXeMbf2+FbY66bYctGL1eicr0joPTCOCnESUYcLlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709623637; c=relaxed/simple;
	bh=8xbQubmTkmOMARbW6qzD862TVY9WNT6kp3iuJqHTedc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rW3M28xrzcirAYwR+RmN/UZN9GoaXIWjkIRqPNlqqTxiUHh2GcfIQVhjxk0kclDkzzsW5n6EmmyEHJUOrwXPqMHdAJp4apO7QJxVRo8uVE2bz5WDnPxvyBBwQkGDkGfsLZxMDQTjIB2oOqWqgicWReJ4ImQaU/Sh4sHm0BN5Kwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YRwKKu/H; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3f893ad5f4so787651966b.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Mar 2024 23:27:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709623634; x=1710228434; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t7918pNESgYbkctrxIFY/hP+YnpgasO4NnyXNJkgeMQ=;
        b=YRwKKu/H+d4DRqx6nT/OMF0qLSYKrTE0DC85E+ZBXrSmxdjJgW0BCVRGzpQjqmrzib
         /8cx2sJzd7+fhDnihcmkBnuZcCrqrmjQq7dQ1jubrK8597k+cJmyAiqE66JTfhw7bpkO
         udAEIWGems714FuIbITUtKRpjhU5WeE5NzdEjifYcYVht5Sv/a7dfdkTFMVJreyLz70m
         9zGcrwLr5ukppKXYvp1C4EDX7F0ks7SJVavPfEvpd9RAsvbhD1R5iW2aNZLAHC0b+7WK
         Lq8g3pvj+9iQf3kKw5SkS3JZBXUrDiNtdoUTxBOyuAmwsYrlP2loT4UFwRWDfN6Vr4KM
         jwag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709623634; x=1710228434;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t7918pNESgYbkctrxIFY/hP+YnpgasO4NnyXNJkgeMQ=;
        b=CWz8UUL75aOq+hvLoLdRU8y1NEg1HcFXaa2eFXQRMKIGkd6WxSecuuvbnYt7PPStxy
         9st5yASjVUAKf/uDcnPZRWoqlMIGWREt28nHrRKI3fxppkLuz/ByQUBgf+rFrCyM8Hkg
         nzpFpk0IkSARMnT9EhcfN8rvv55B05ntu/43kAkyf9tsXrQmiI5/Q1XU20ySXhx/SN7a
         dW/00b3Vlh2X5KA+TAEpu1Junu6BrWx9w+Ce+MbSKDpgge6F9bC3noVKNoLuoOI+aHBA
         GXX4knshWv2hhooKlj5+QzIuG+wUa+oXq0Nt4zReRiXUPYGLC5pzeK9JFrIwYK57nQ6R
         aufw==
X-Forwarded-Encrypted: i=1; AJvYcCVokRZZ8z3NVC4jh9bR0oruHAjLFFqWY1FNHKqKqrk2wmxljWbhBHHD/m9iB/JDeXRxY64+vQS+PQmZD7MY3+c/sXi9kNIY8P5fLTcp
X-Gm-Message-State: AOJu0Yym17hCpIzoXx9ejb91hRnSQAuImJYf2EeCNrSPrxKXhP5ZRMkW
	uU8HlatUMA4Lqp7YpTzFoCDTztniL5CRaIop6y5eB1gJo/YuIU7PtJP0o0z3arg=
X-Google-Smtp-Source: AGHT+IFIZen38tixZpfoWegGGN93QZ8Y76YdO9Piu75kPzriUYv/29df7wou7zKEEan5Oy1jMFEmHg==
X-Received: by 2002:a17:906:649:b0:a45:8b6d:9c92 with SMTP id t9-20020a170906064900b00a458b6d9c92mr1630769ejb.31.1709623633899;
        Mon, 04 Mar 2024 23:27:13 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id k6-20020a17090646c600b00a44bbd08371sm4007373ejs.155.2024.03.04.23.27.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 23:27:13 -0800 (PST)
Message-ID: <96db9f65-115e-4da3-84fa-fac52b35af50@linaro.org>
Date: Tue, 5 Mar 2024 08:27:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: fpga: xlnx,fpga-selectmap: add DT
 schema
Content-Language: en-US
To: Charles Perry <charles.perry@savoirfairelinux.com>,
 yilun xu <yilun.xu@intel.com>
Cc: Rob Herring <robh+dt@kernel.org>, mdf <mdf@kernel.org>,
 Allen VANDIVER <avandiver@markem-imaje.com>,
 Brian CODY <bcody@markem-imaje.com>, hao wu <hao.wu@intel.com>,
 Tom Rix <trix@redhat.com>,
 krzysztof kozlowski+dt <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Michal Simek <michal.simek@amd.com>,
 linux-fpga <linux-fpga@vger.kernel.org>,
 devicetree <devicetree@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
References: <20240221195058.1281973-1-charles.perry@savoirfairelinux.com>
 <20240221195058.1281973-3-charles.perry@savoirfairelinux.com>
 <4a9f0eef-590b-45df-92bc-b63ad9282e18@linaro.org>
 <1012793477.1508198.1709486517581.JavaMail.zimbra@savoirfairelinux.com>
 <cb51aadd-c350-42e2-9684-ac4f7dbf864c@linaro.org>
 <d377f0ea-2df2-4d4e-b1bc-8a4ca55eec15@linaro.org>
 <23887452.1534761.1709605624728.JavaMail.zimbra@savoirfairelinux.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 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
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <23887452.1534761.1709605624728.JavaMail.zimbra@savoirfairelinux.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/03/2024 03:27, Charles Perry wrote:
> 
> 
> On Mar 4, 2024, at 12:31 AM, Krzysztof Kozlowski krzysztof.kozlowski@linaro.org wrote:
> 
>> On 04/03/2024 08:30, Krzysztof Kozlowski wrote:
>>> On 03/03/2024 18:21, Charles Perry wrote:
>>>> On Feb 27, 2024, at 3:10 AM, Krzysztof Kozlowski krzysztof.kozlowski@linaro.org
>>>> wrote:
>>>>
>>>>> On 21/02/2024 20:50, Charles Perry wrote:
>>>>>> Document the SelectMAP interface of Xilinx 7 series FPGA.
>>>>>>
>>>>>> Signed-off-by: Charles Perry <charles.perry@savoirfairelinux.com>
>>>>>> ---
>>>>>>  .../bindings/fpga/xlnx,fpga-selectmap.yaml    | 86 +++++++++++++++++++
>>>>>>  1 file changed, 86 insertions(+)
>>>>>>  create mode 100644
>>>>>>  Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>>>>>
>>>>>> diff --git a/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>>>>> b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>>>>> new file mode 100644
>>>>>> index 0000000000000..08a5e92781657
>>>>>> --- /dev/null
>>>>>> +++ b/Documentation/devicetree/bindings/fpga/xlnx,fpga-selectmap.yaml
>>>>>> @@ -0,0 +1,86 @@
>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>> +%YAML 1.2
>>>>>> +---
>>>>>> +$id: http://devicetree.org/schemas/fpga/xlnx,fpga-selectmap.yaml#
>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>> +
>>>>>> +title: Xilinx SelectMAP FPGA interface
>>>>>> +
>>>>>> +maintainers:
>>>>>> +  - Charles Perry <charles.perry@savoirfairelinux.com>
>>>>>> +
>>>>>> +description: |
>>>>>> +  Xilinx 7 Series FPGAs support a method of loading the bitstream over a
>>>>>> +  parallel port named the SelectMAP interface in the documentation. Only
>>>>>> +  the x8 mode is supported where data is loaded at one byte per rising edge of
>>>>>> +  the clock, with the MSB of each byte presented to the D0 pin.
>>>>>> +
>>>>>> +  Datasheets:
>>>>>> +
>>>>>> https://www.xilinx.com/support/documentation/user_guides/ug470_7Series_Config.pdf
>>>>>> +
>>>>>> +allOf:
>>>>>> +  - $ref: /schemas/memory-controllers/mc-peripheral-props.yaml#
>>>>>> +
>>>>>> +properties:
>>>>>> +  compatible:
>>>>>> +    enum:
>>>>>> +      - xlnx,fpga-xc7s-selectmap
>>>>>> +      - xlnx,fpga-xc7a-selectmap
>>>>>> +      - xlnx,fpga-xc7k-selectmap
>>>>>> +      - xlnx,fpga-xc7v-selectmap
>>>>>> +
>>>>>> +  reg:
>>>>>> +    description:
>>>>>> +      At least 1 byte of memory mapped IO
>>>>>> +    maxItems: 1
>>>>>> +
>>>>>> +  prog_b-gpios:
>>>>>
>>>>> I commented on this and still see underscore. Nothing in commit msg
>>>>> explains why this should have underscore. Changelog is also vague -
>>>>> describes that you brought back underscores, instead of explaining why
>>>>> you did it.
>>>>>
>>>>> So the same comments as usual:
>>>>>
>>>>> No underscores in names.
>>>>>
>>>>> Best regards,
>>>>> Krzysztof
>>>>
>>>> Hello Krzysztof,
>>>>
>>>> Yes, I've gone full circle on that issue. Here's what I tried so far:
>>>
>>> And what part of the commit description allows me to understand this?
>>>
> 
> I have a changelog in the cover letter:
> https://lore.kernel.org/all/20240221195058.1281973-1-charles.perry@savoirfairelinux.com/

Commit should stand on its own. Many reviewers do not read cover letter,
I mostly ignore it and only check the changelog part.

> 
>>>>
>>>>  1) Reuse the same gpio names: Duplicates errors of the past, Krzysztof
>>>>     doesn't like it.
>>>>  2) Different gpio names for new driver only: Makes the driver code
>>>>     overly complicated, Yilun doesn't like it.
>>>
>>> That's a new driver, right? So what is complicated here? You have new
>>> code and you take prog-b or prog_b?
>>>
>>>>  3) Change gpio names for both drivers, deprecate the old names: Makes
>>>>     the DT binding and the driver code overly complicated, Rob doesn't
>>>>     like it.
>>>
>>> I don't think I proposed changing existing bindings.
>>>
>>>>
>>>> I think that while the driver code shouldn't be the driving force for
>>>> the DT spec, it can be a good indication that the spec is unpractical to
>>>> implement.
>>>
>>> What is impractical in implementing this? You just pass either A or B to
>>> function requesting GPIO. Just choose proper name.
>>>
> 
> It's not complicated but it requires more code than if "prog_b" had been
> used. 
>  
>>>>
>>>> In this case, there are two interfaces on a chip that uses the same GPIO
>>>> protocol, it would only make sense that they use the same names, this
>>>> discards solution #2.
>>>
>>> I don't understand this. You have devm_gpiod_get() in your new code. Why
>>> is it difficult to use different name?
> 
> Yilun asked to avoid changing the names between the two drivers.
> First comment in this mail:
> https://lore.kernel.org/all/Zb9GkY6cMtR+4xOX@yilunxu-OptiPlex-7050/
> 
> Yilun, let me know if this is something you'd accept as this is a concern
> for the device tree maintainers.
> 
>>
>> And I forgot to emphasize: none of these is mentioned in commit msg, so
>> for v5 you will get exactly the same complains. And for every other
>> patch which repeats the same and does not clarify caveats or exceptions.
>>
>> Best regards,
>> Krzysztof
> 
> Should I keep my changelog in the individual commits? I thought the norm
> was to put this the cover letter.

I speak about the commit msg, not changelog. According to this commit,
there is absolutely no reason to keep prog_b name. This goes to git
stays there and later someone will check the history and will have the
same concerns: why the hell new binding was allowed to use underscore?
Why DT maintainers gave here exception? If they gave here exception, I
deserve exception as well. Such arguments are brought at least once per
month.

Your commit must stand on its own.

Best regards,
Krzysztof


