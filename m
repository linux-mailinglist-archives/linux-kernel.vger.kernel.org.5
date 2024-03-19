Return-Path: <linux-kernel+bounces-107012-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5084B87F6B5
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 06:30:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D15F51F21E0D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 05:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C83DE446A9;
	Tue, 19 Mar 2024 05:30:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XPMhBWoc"
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F05BC44365
	for <linux-kernel@vger.kernel.org>; Tue, 19 Mar 2024 05:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710826240; cv=none; b=Chovkj+6N8dEruoSQOVPoxCIPAQ3kO0jsctNZik3PDIkQzqQ4bLXUa4C0Btrz+cOm09XVOp9K3bcYzQ57PgwbNwXikBCQD+VQ+a72jIykbJEwl6tXb5fBpih28iLsohGG08ihbCJIY9PgVOVK6OH3YEuXOINp2isxv//i6Tl0FA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710826240; c=relaxed/simple;
	bh=RfEc/luL7JDA8RW87dcmPKTD650XxoLylD7CjjTiPJY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=celWMKgffBmUb6Vx2cmg1H9whb4rf6PJw2Z/rRym2edyFVv7oFoR6PHrvBSIzhaIyUYll5wdcTM1ZXJKOXgqU5lx4RCdSJrEzDQaquWXN+88ET2V9hl1Cmg+Aek26oPcW+Os4DaVlidHL6kKJXOEu8AAkJB0tEjPWOuNsa8VG+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XPMhBWoc; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2d475b6609eso66065911fa.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 Mar 2024 22:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710826237; x=1711431037; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eRzIF3VX9/YiymB/e90DSmrDOxTtEe9gGzUl7xfZsK0=;
        b=XPMhBWocmP35hk37oNVIvfukFttJ/0DJ2afkWjlJ8GTRYadbrsshrBa7hK4kb5IWdU
         2qt/cHjjcOW0a7bgDyWQm+h3qu57OECeeGkvlPchEMWdE/OZ+JA7S7uXFplql+B2oDUb
         35GVGkuqXiENyrdBruQQBp9g1SKaVcF0j/hHKpHPCBo42MoTKu8JPvWv2E2INAfmfrGI
         vcPQ35x5Gg1E8/m+HMa7c4L14gGEUz0szQSjQWb4NxKOzdop65elPbwmu/Fc5cC6dz6a
         tWaRvDhLQOs9J2UtMNy+34a4Q4NYmayWgJdN9/Kb5uj2K8NaPt2pu9WEgpJJj3Hv5nkP
         3mMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710826237; x=1711431037;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eRzIF3VX9/YiymB/e90DSmrDOxTtEe9gGzUl7xfZsK0=;
        b=Vc0xErw2eaAfD0e7WUwV2h7FCfVEXmJHOxLDfUylcZ8YCbqDk60h521VNwBTpjjIIh
         WoTsmi6C4Q69o1QH9PFx8WQgpLqo2u2GJfIeBtN4PlPQrQ+6LqEPr3LYG5gD+21SSXzC
         w5lN25qIwtU+UGG6d+YkYReWYvE2UWhe7RKS+YUQxl6CfJHntpj/1ddIL7ZA2U0IUAjr
         SJpqUHBwyX/GwJjCO2r9K523aiusVmDNBqnJjaXoVw6XVlme9HWc2ImaBrOJCbXkQXJK
         yjl1vAlzKj1NoTi1sRmo84QwYX8WytSGDFfwX03Pyx9RRahOA5Ik8SCZiWasfOA6KfyX
         GOog==
X-Forwarded-Encrypted: i=1; AJvYcCU69dPmF43QpEtZH4g8FT+IMbXU3eMjU6gM9TXvuaM6MRqmMZ9rA+RV58RZHu4tz9SMc1xBS0TIi791VoVxpM7feLtLBaLMelmHRpsd
X-Gm-Message-State: AOJu0YzcHmtNWvUIp+2/j34cGepquUjV80woniCnTedHqZy40tUAXzBo
	3oxGhS0m1EIDQLAYkzl8JD66bYDMR5sifaIg+5ZRHqtjFJx52JJFKYImzH5FUTg=
X-Google-Smtp-Source: AGHT+IFAaJ96CGpRs9kBRA+34bYALF8Kr/5WSh6SsgsmA4qv2B+uh91qtVFR8vZphEp0FhcxTVcfbQ==
X-Received: by 2002:a2e:7401:0:b0:2d4:62b7:4c7b with SMTP id p1-20020a2e7401000000b002d462b74c7bmr882913ljc.51.1710826236920;
        Mon, 18 Mar 2024 22:30:36 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id ev19-20020a056402541300b005689c2c6508sm5330103edb.70.2024.03.18.22.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 22:30:36 -0700 (PDT)
Message-ID: <b1320ddf-bacb-41e3-9709-e90df18cc1e3@linaro.org>
Date: Tue, 19 Mar 2024 06:30:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: remoteproc: add Versal-NET platform
Content-Language: en-US
To: Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
 mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240315211533.1996543-1-tanmay.shah@amd.com>
 <20240315211533.1996543-3-tanmay.shah@amd.com>
 <3ca1c419-d185-4318-92ed-3c4e40dcf5bb@linaro.org>
 <14be0aa6-49b7-4342-9ca6-750c30c8e1e9@amd.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Autocrypt: addr=krzysztof.kozlowski@linaro.org; keydata=
 xsFNBFVDQq4BEAC6KeLOfFsAvFMBsrCrJ2bCalhPv5+KQF2PS2+iwZI8BpRZoV+Bd5kWvN79
 cFgcqTTuNHjAvxtUG8pQgGTHAObYs6xeYJtjUH0ZX6ndJ33FJYf5V3yXqqjcZ30FgHzJCFUu
 JMp7PSyMPzpUXfU12yfcRYVEMQrmplNZssmYhiTeVicuOOypWugZKVLGNm0IweVCaZ/DJDIH
 gNbpvVwjcKYrx85m9cBVEBUGaQP6AT7qlVCkrf50v8bofSIyVa2xmubbAwwFA1oxoOusjPIE
 J3iadrwpFvsZjF5uHAKS+7wHLoW9hVzOnLbX6ajk5Hf8Pb1m+VH/E8bPBNNYKkfTtypTDUCj
 NYcd27tjnXfG+SDs/EXNUAIRefCyvaRG7oRYF3Ec+2RgQDRnmmjCjoQNbFrJvJkFHlPeHaeS
 BosGY+XWKydnmsfY7SSnjAzLUGAFhLd/XDVpb1Een2XucPpKvt9ORF+48gy12FA5GduRLhQU
 vK4tU7ojoem/G23PcowM1CwPurC8sAVsQb9KmwTGh7rVz3ks3w/zfGBy3+WmLg++C2Wct6nM
 Pd8/6CBVjEWqD06/RjI2AnjIq5fSEH/BIfXXfC68nMp9BZoy3So4ZsbOlBmtAPvMYX6U8VwD
 TNeBxJu5Ex0Izf1NV9CzC3nNaFUYOY8KfN01X5SExAoVTr09ewARAQABzTRLcnp5c3p0b2Yg
 S296bG93c2tpIDxrcnp5c3p0b2Yua296bG93c2tpQGxpbmFyby5vcmc+wsGUBBMBCgA+FiEE
 m9B+DgxR+NWWd7dUG5NDfTtBYpsFAmI+BxMCGwMFCRRfreEFCwkIBwIGFQoJCAsCBBYCAwEC
 HgECF4AACgkQG5NDfTtBYptgbhAAjAGunRoOTduBeC7V6GGOQMYIT5n3OuDSzG1oZyM4kyvO
 XeodvvYv49/ng473E8ZFhXfrre+c1olbr1A8pnz9vKVQs9JGVa6wwr/6ddH7/yvcaCQnHRPK
 mnXyP2BViBlyDWQ71UC3N12YCoHE2cVmfrn4JeyK/gHCvcW3hUW4i5rMd5M5WZAeiJj3rvYh
 v8WMKDJOtZFXxwaYGbvFJNDdvdTHc2x2fGaWwmXMJn2xs1ZyFAeHQvrp49mS6PBQZzcx0XL5
 cU9ZjhzOZDn6Apv45/C/lUJvPc3lo/pr5cmlOvPq1AsP6/xRXsEFX/SdvdxJ8w9KtGaxdJuf
 rpzLQ8Ht+H0lY2On1duYhmro8WglOypHy+TusYrDEry2qDNlc/bApQKtd9uqyDZ+rx8bGxyY
 qBP6bvsQx5YACI4p8R0J43tSqWwJTP/R5oPRQW2O1Ye1DEcdeyzZfifrQz58aoZrVQq+innR
 aDwu8qDB5UgmMQ7cjDSeAQABdghq7pqrA4P8lkA7qTG+aw8Z21OoAyZdUNm8NWJoQy8m4nUP
 gmeeQPRc0vjp5JkYPgTqwf08cluqO6vQuYL2YmwVBIbO7cE7LNGkPDA3RYMu+zPY9UUi/ln5
 dcKuEStFZ5eqVyqVoZ9eu3RTCGIXAHe1NcfcMT9HT0DPp3+ieTxFx6RjY3kYTGLOwU0EVUNc
 NAEQAM2StBhJERQvgPcbCzjokShn0cRA4q2SvCOvOXD+0KapXMRFE+/PZeDyfv4dEKuCqeh0
 hihSHlaxTzg3TcqUu54w2xYskG8Fq5tg3gm4kh1Gvh1LijIXX99ABA8eHxOGmLPRIBkXHqJY
 oHtCvPc6sYKNM9xbp6I4yF56xVLmHGJ61KaWKf5KKWYgA9kfHufbja7qR0c6H79LIsiYqf92
 H1HNq1WlQpu/fh4/XAAaV1axHFt/dY/2kU05tLMj8GjeQDz1fHas7augL4argt4e+jum3Nwt
 yupodQBxncKAUbzwKcDrPqUFmfRbJ7ARw8491xQHZDsP82JRj4cOJX32sBg8nO2N5OsFJOcd
 5IE9v6qfllkZDAh1Rb1h6DFYq9dcdPAHl4zOj9EHq99/CpyccOh7SrtWDNFFknCmLpowhct9
 5ZnlavBrDbOV0W47gO33WkXMFI4il4y1+Bv89979rVYn8aBohEgET41SpyQz7fMkcaZU+ok/
 +HYjC/qfDxT7tjKXqBQEscVODaFicsUkjheOD4BfWEcVUqa+XdUEciwG/SgNyxBZepj41oVq
 FPSVE+Ni2tNrW/e16b8mgXNngHSnbsr6pAIXZH3qFW+4TKPMGZ2rZ6zITrMip+12jgw4mGjy
 5y06JZvA02rZT2k9aa7i9dUUFggaanI09jNGbRA/ABEBAAHCwXwEGAEKACYCGwwWIQSb0H4O
 DFH41ZZ3t1Qbk0N9O0FimwUCYDzvagUJFF+UtgAKCRAbk0N9O0Fim9JzD/0auoGtUu4mgnna
 oEEpQEOjgT7l9TVuO3Qa/SeH+E0m55y5Fjpp6ZToc481za3xAcxK/BtIX5Wn1mQ6+szfrJQ6
 59y2io437BeuWIRjQniSxHz1kgtFECiV30yHRgOoQlzUea7FgsnuWdstgfWi6LxstswEzxLZ
 Sj1EqpXYZE4uLjh6dW292sO+j4LEqPYr53hyV4I2LPmptPE9Rb9yCTAbSUlzgjiyyjuXhcwM
 qf3lzsm02y7Ooq+ERVKiJzlvLd9tSe4jRx6Z6LMXhB21fa5DGs/tHAcUF35hSJrvMJzPT/+u
 /oVmYDFZkbLlqs2XpWaVCo2jv8+iHxZZ9FL7F6AHFzqEFdqGnJQqmEApiRqH6b4jRBOgJ+cY
 qc+rJggwMQcJL9F+oDm3wX47nr6jIsEB5ZftdybIzpMZ5V9v45lUwmdnMrSzZVgC4jRGXzsU
 EViBQt2CopXtHtYfPAO5nAkIvKSNp3jmGxZw4aTc5xoAZBLo0OV+Ezo71pg3AYvq0a3/oGRG
 KQ06ztUMRrj8eVtpImjsWCd0bDWRaaR4vqhCHvAG9iWXZu4qh3ipie2Y0oSJygcZT7H3UZxq
 fyYKiqEmRuqsvv6dcbblD8ZLkz1EVZL6djImH5zc5x8qpVxlA0A0i23v5QvN00m6G9NFF0Le
 D2GYIS41Kv4Isx2dEFh+/Q==
In-Reply-To: <14be0aa6-49b7-4342-9ca6-750c30c8e1e9@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 01:51, Tanmay Shah wrote:
> Hello Krzysztof,
> 
> Thanks for reviews. Please find my comments below.
> 
> On 3/17/24 1:53 PM, Krzysztof Kozlowski wrote:
>> On 15/03/2024 22:15, Tanmay Shah wrote:
>>> AMD-Xilinx Versal-NET platform is successor of Versal platform. It
>>> contains multiple clusters of cortex-R52 real-time processing units.
>>> Each cluster contains two cores of cortex-R52 processors. Each cluster
>>> can be configured in lockstep mode or split mode.
>>>
>>> Each R52 core is assigned 128KB of TCM memory. ATCM memory is 64KB, BTCM
>>> and CTCM memoreis are 32KB each. Each TCM memory has its own dedicated
>>> power-domain that needs to be requested before using it.
>>>
>>> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
>>> ---
>>>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 220 +++++++++++++++---
>>>  1 file changed, 184 insertions(+), 36 deletions(-)
>>>
>>> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>>> index 711da0272250..55654ee02eef 100644
>>> --- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>>> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
>>> @@ -18,7 +18,9 @@ description: |
>>>  
>>>  properties:
>>>    compatible:
>>> -    const: xlnx,zynqmp-r5fss
>>> +    enum:
>>> +      - xlnx,zynqmp-r5fss
>>> +      - xlnx,versal-net-r52fss
>>>  
>>>    "#address-cells":
>>>      const: 2
>>> @@ -64,7 +66,9 @@ patternProperties:
>>>  
>>>      properties:
>>>        compatible:
>>> -        const: xlnx,zynqmp-r5f
>>> +        enum:
>>> +          - xlnx,zynqmp-r5f
>>> +          - xlnx,versal-net-r52f
>>>  
>>>        reg:
>>>          minItems: 1
>>> @@ -135,9 +139,11 @@ required:
>>>  allOf:
>>>    - if:
>>>        properties:
>>> -        xlnx,cluster-mode:
>>> -          enum:
>>> -            - 1
>>> +        compatible:
>>> +          contains:
>>> +            enum:
>>> +              - xlnx,versal-net-r52fss
>>
>> Why do you touch these lines?
>>
>>> +
>>>      then:
>>>        patternProperties:
>>>          "^r5f@[0-9a-f]+$":
>>> @@ -149,16 +155,14 @@ allOf:
>>>                items:
>>>                  - description: ATCM internal memory
>>>                  - description: BTCM internal memory
>>> -                - description: extra ATCM memory in lockstep mode
>>> -                - description: extra BTCM memory in lockstep mode
>>> +                - description: CTCM internal memory
>>>  
>>>              reg-names:
>>>                minItems: 1
>>>                items:
>>> -                - const: atcm0
>>> -                - const: btcm0
>>> -                - const: atcm1
>>> -                - const: btcm1
>>> +                - const: atcm
>>> +                - const: btcm
>>> +                - const: ctcm
>>>  
>>>              power-domains:
>>>                minItems: 2
>>> @@ -166,33 +170,70 @@ allOf:
>>>                  - description: RPU core power domain
>>>                  - description: ATCM power domain
>>>                  - description: BTCM power domain
>>> -                - description: second ATCM power domain
>>> -                - description: second BTCM power domain
>>> +                - description: CTCM power domain
>>>  
>>>      else:
>>> -      patternProperties:
>>> -        "^r5f@[0-9a-f]+$":
>>> -          type: object
>>> -
>>> -          properties:
>>> -            reg:
>>> -              minItems: 1
>>> -              items:
>>> -                - description: ATCM internal memory
>>> -                - description: BTCM internal memory
>>> -
>>> -            reg-names:
>>> -              minItems: 1
>>> -              items:
>>> -                - const: atcm0
>>> -                - const: btcm0
>>> -
>>> -            power-domains:
>>> -              minItems: 2
>>> -              items:
>>> -                - description: RPU core power domain
>>> -                - description: ATCM power domain
>>> -                - description: BTCM power domain
>>> +      allOf:
>>> +        - if:
>>> +            properties:
>>> +              xlnx,cluster-mode:
>>> +                enum:
>>> +                  - 1
>>
>> Whatever you did here, is not really readable. You have now multiple
>> if:then:if:then embedded.
> 
> For ZynqMP platform, TCM can be configured differently in lockstep mode
> and split mode.
> 
> For Versal-NET no such configuration is available, but new CTCM memory
> is added.
> 
> So, I am trying to achieve following representation of TCM for both:
> 
> if: versal-net compatible
> then:
>   ATCM - 64KB
>   BTCM - 32KB
>   CTCM - 32KB
> 
> else: (ZynqMP compatible)
>   if:
>     xlnx,cluster-mode (lockstep mode)
>   then:
>     ATCM0 - 64KB
>     BTCM0 - 64KB
>     ATCM1 - 64KB
>     BTCM1 - 64KB
>   else: (split mode)
>     ATCM0 - 64KB
>     BTCM0 - 64KB
> 
> 
> If bindings are getting complicated, does it make sense to introduce
> new file for Versal-NET bindings? Let me know how you would like me
> to proceed.

All this is broken in your previous patchset, but now we nicely see.

No, this does not work like this. You do not have entirely different
programming models in one device, don't you?


Best regards,
Krzysztof


