Return-Path: <linux-kernel+bounces-69750-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12865858E0D
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 09:22:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7D5DEB20E5F
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 08:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7E241CF9A;
	Sat, 17 Feb 2024 08:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YHwZCuTb"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 533811CD32
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 08:21:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708158111; cv=none; b=lfHBeBVk0x+gu+VYtWierOO0CdwBy4k8VadhcFw07tHpf9ASlIQ6G2wlTjzUU/JpJJNA5YZYrJ18g8tytNkVZDcNUvZyVFeJWq5/7OdJ1LpeCrUwjhEvv/sSA6NCdeJEr9rVW5s23qxVBZhLRmOoEhktjRSvOZUyYSpn97EKwfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708158111; c=relaxed/simple;
	bh=+8tIJu/W6W8+SHTt6dYQlZODfyzp0yZovd2VchAdKs8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lWb61bEm7A8iWC+iu7hAkM/vdx+qHMmW7QZoEVGYW6ugLYw/ahjPKY4l8fbd5zfl48LUJ61ZKMaNFKvPXapWHKbMzeDFUlqf6/4EHnT6bsqvcv6jb1ztaEigq46pQWnawfyAmS8nfsx4FvRMcNnXf7moCTTZsgjyuxzp8+ZmHQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=YHwZCuTb; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a30f7c9574eso374352566b.0
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 00:21:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708158107; x=1708762907; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uQ8qUM7TW828c6lJYuqFoH4ycgiD3nGAtO0l0ReIXyA=;
        b=YHwZCuTb+/uKMqyTL46ViV/xDyiColSXaBQnZaFff8L4PaXhBMxGBeUH0ifBTEyJGO
         BbfsQTBULsah+o6fCznKFqYIAr0zwPRzgq1rj3N8d2O9LBLKx59omXjHSxnmCtnnkeoO
         L86Qmd9g5F3FGrVQwK7ihVfZUCibB1opx+KUne0Ri0uFQ3gvk73HzPRU5vsbU2fU8zR0
         1Pm/VPMRoMhMx7lHXR8VT0syoyQo00fAPmoGW5+xPclDwmBdD0SjUeQK+25UF38HkgPc
         bZe3ghSmjl0l99xkcyfEQ0fhEeLs95JlGDYwJuAKKh3TA+e8qczVlF58K7XCNh0hIYhZ
         4jJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708158107; x=1708762907;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uQ8qUM7TW828c6lJYuqFoH4ycgiD3nGAtO0l0ReIXyA=;
        b=UyQHNxeuoVso8Fe/DEYlhUxMsHbQvZkjrQAzPZStvBerhTtmrX97BymlaAnECOlm2o
         /bIP5agU+YiCXRJWMfsgwcCptdw3aN9EHvZTgau0m6+LIBWaYsYAiusbLz7fy7mQLtom
         ew4xFX2+GwPKpRB+4BsoORn4fBc0oJFSg4svuAeXppHrUXi3/g6U/S/6IY/IA4fkSw9M
         ijkQ79gg/y5FFn7jfZV8fzv4RfbsAbGTzDtAhzT18T3K62FYLTZgeZEyIfM2kfIpr9c9
         BzQsYiTb1D+hUXwJjh0uecELGSDv6n1I0Ba6q8ICOnSAm+VLU9oMFtTnlnGTSZspLq4n
         t95Q==
X-Forwarded-Encrypted: i=1; AJvYcCXlSgwW2ykjZTcoxoRYZ8mCS8mV9Ua4oOiHkYqdhK5GbfiLQPMZr1nAkV3KEsBf77ikRmTijn6NcYtR3/vM0nAI2oNK+lmnaEoNYIdt
X-Gm-Message-State: AOJu0YxoI0Z1mJV0/u12JiLuEoaQgjqw8ejB6eD6VsQrznvjR3Uf+DuK
	HyGe3Ap8ljJE/aWDFRBy7U063rDDPvcilYvDJf0jVetJkU2SUdxk1YZids0tFtc=
X-Google-Smtp-Source: AGHT+IFw0x90GqWPiYNblbzWp4eOaon/5Yuz23fJD+5iWuRy3pDvzLZNdcNebapJdhDnso+00t7Reg==
X-Received: by 2002:a17:906:2450:b0:a3c:168f:8d12 with SMTP id a16-20020a170906245000b00a3c168f8d12mr4707542ejb.18.1708158107670;
        Sat, 17 Feb 2024 00:21:47 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id s16-20020a17090699d000b00a36f9941d6dsm754950ejn.112.2024.02.17.00.21.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 00:21:47 -0800 (PST)
Message-ID: <b21d351f-68be-4bca-a327-c35591c55610@linaro.org>
Date: Sat, 17 Feb 2024 09:21:46 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: hwmon: add common properties with label
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, Jean Delvare <jdelvare@suse.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Krzysztof Kozlowski <krzk@kernel.org>
References: <20240216-dt-bindings-hwmon-common-v1-0-3c2c24ff1260@linaro.org>
 <20240216-dt-bindings-hwmon-common-v1-1-3c2c24ff1260@linaro.org>
 <f0f523c3-7b1c-404a-89c3-0c7345001676@roeck-us.net>
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
In-Reply-To: <f0f523c3-7b1c-404a-89c3-0c7345001676@roeck-us.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2024 18:11, Guenter Roeck wrote:
> On 2/15/24 23:55, Krzysztof Kozlowski wrote:
>> Linux hwmon core code parses "label" property for each device, so add a
>> common schema for that.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
>  From hwmon perspective:
> 
> Acked-by: Guenter Roeck <linux@roeck-us.net>
> 
>> ---
>>   .../devicetree/bindings/hwmon/hwmon-common.yaml          | 16 ++++++++++++++++
>>   1 file changed, 16 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/hwmon-common.yaml b/Documentation/devicetree/bindings/hwmon/hwmon-common.yaml
>> new file mode 100644
>> index 000000000000..d83f4180f622
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/hwmon-common.yaml
>> @@ -0,0 +1,16 @@
>> +# SPDX-License-Identifier: GPL-2.0 OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/hwmon-common.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Hardware Monitoring Devices Common Properties
>> +
>> +maintainers:
>> +  - Guenter Roeck <linux@roeck-us.net>
>> +
>> +properties:
>> +  label:
>> +    description: A descriptive name for this device.
>> +
> 
> Would it make sense to also add shunt-resistor-micro-ohms ?

It's not present on many devices, I think, so it is also not parsed by
hwmon core. I plan to add above $ref to hwmon-common to each hwmon
binding, so this would mean all of them will get shunt-resistor. I would
not add it, but I also don't mind if I am overruled.

Best regards,
Krzysztof


