Return-Path: <linux-kernel+bounces-111027-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D3FC88671E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 07:50:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 390221C238CE
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 06:50:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CA1210A17;
	Fri, 22 Mar 2024 06:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FTyHSnrZ"
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8903B101C1
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 06:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711090203; cv=none; b=ho16ibuRsP4yRCjXfXJr5U1VHE8Ulh7dEiw+i3imKZFjTN1HxoB76SNSyRj7+dLvZQkOQU2SYBTwSRO/8YNU3sM852LeoIS2/YnO+gUhBnYFYeUEJHzS3x4p/jxxUBzFijV9e6XAm4JbX2pMwAjZ4TxNk+DqJ9EnikPlWD7YBZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711090203; c=relaxed/simple;
	bh=hztYgNnzlR152Q63wYFJZiUp6doejgjvGN/l4pW2yDQ=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=QPSDiMhShMEO2ZQe8ynRpZv4qYPATEnGKGGt4iFuON1aci0w7KTjVMiX/TdMYlwURxey+zEmDpdkaGzTH/qHot2K453OHVRTu7zeRtDLcwN9Mjvs5qQ3rVbg1SFlCKs6B8D9NtTMxAYWCP/t6Sj/A5mxQWTzP1j1hnA+3UBK1GA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FTyHSnrZ; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5684db9147dso1994293a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Mar 2024 23:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711090200; x=1711695000; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=I5sXdHzq2mmZcnR2eOCseDkPnOJfe4dMIq6Nx93VsWs=;
        b=FTyHSnrZhDy+83Bfolh44ZqzCpJXV8y6p4crt6V67gpmEIcCG0d543cA9beHz2dW8V
         da2ESaAkVD34BzVi4OQS/GVmNpAOIpBlI0SrcxgLgVd0pslzB4bl0jRfTMY/8MU0KlkQ
         YwalxWfODwlbfNSPKnl/Q8Q+yHTwI8CQHTFXAWFtxjRpOqN7nNL3b0SomaExbbjkq63P
         5ksJUidLuv3h1Dx8xJJFs98Xs4I5DQ5p10JOQas2Lc4DPtxWXANbzTPJcvWvVMXXQr7K
         vH6YPJ7pB6QneHIfT9ZQy9dyAXK/CRpBOP9D5hdSxQz7rHWEjuk7yOVtrP+TME2LErge
         Sk3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711090200; x=1711695000;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :references:cc:to:from:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=I5sXdHzq2mmZcnR2eOCseDkPnOJfe4dMIq6Nx93VsWs=;
        b=Y5GBgQ28kMr51to5Gu2c0eLDOwFHyiq/8Y6QHy/oj/pEZKSYK48NPx4g19M5M4VkKm
         VpQhN70aiOHuj/0jSlYfBHHyYjAxYY9NrsA4Fn8q0Jnyaz1+1gt15WxG7NvlaFZE//eD
         czvgf/LDYPE+mW2fT55ZUHCwZJvRd7C4GIHTiALDtXzuVbeRhbJjFRY1DgXQ0EENrvzC
         sqjaGRk8pVSwjbJSzsJoS2meepeIJsvBzSsNh6GO0DMkuZY3bZoS2wagamWY4fzSxCKF
         qO2KmdLDX290IR0XVBypH9eoYJVASKQeA/RSrfNM9OhOU4oCIPEpQIxnA2BSIiaFXNUo
         SQXQ==
X-Gm-Message-State: AOJu0YyCKwUZtoYFJgRt42304KoPzl3n/DUZTTG/gj7IZtdOwbIFVbn7
	7pOMshxPhlocaARfw0CrPh4O7cQ28YDTvhrGOGNsZeGxCw/KUygzxlc5wE/EyLw=
X-Google-Smtp-Source: AGHT+IE3YrB9dGa6c/3rZ7XZG81Ue+YmKn0StgDF4kORTuR77P423KY9HDLM/D5HN28VPadJWIfavA==
X-Received: by 2002:a17:906:a84d:b0:a46:930c:b793 with SMTP id dx13-20020a170906a84d00b00a46930cb793mr958073ejb.9.1711090199863;
        Thu, 21 Mar 2024 23:49:59 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id rp20-20020a170906d97400b00a46a2779475sm683399ejb.101.2024.03.21.23.49.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 23:49:59 -0700 (PDT)
Message-ID: <6552bcb8-e046-4882-91da-1094fff3d239@linaro.org>
Date: Fri, 22 Mar 2024 07:49:57 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] spi: dt-bindings: jcore,spi: convert spi-jcore to
 dtschema
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
 linux-spi@vger.kernel.org, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Mark Brown <broonie@kernel.org>, Shuah Khan <skhan@linuxfoundation.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>,
 Daniel Baluta <daniel.baluta@nxp.com>
References: <20240321180617.35390-1-five231003@gmail.com>
 <affc1b03-7a23-4fd8-bf85-4155bcd41df1@linaro.org>
 <CAN19-EfCOWFqFCrF0iCaxhfZuteWawQoH0d6pTN3cgQ7p-CK6w@mail.gmail.com>
 <5dd3237f-e0a2-4214-a63f-233e89a26b8d@linaro.org>
Content-Language: en-US
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
In-Reply-To: <5dd3237f-e0a2-4214-a63f-233e89a26b8d@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/2024 07:34, Krzysztof Kozlowski wrote:
> On 22/03/2024 07:23, Kousik Sanagavarapu wrote:
>> On Fri, 22 Mar 2024, 11:33 Krzysztof Kozlowski, <
>> krzysztof.kozlowski@linaro.org> wrote:
>>
>>> On 21/03/2024 19:02, Kousik Sanagavarapu wrote:
>>>
>>>> +  spi-max-frequency:
>>>> +    $ref: /schemas/types.yaml#/definitions/uint32
>>>
>>> No, drop. From which other SPI binding did you take it? I asked you to
>>> look at existing code.
>>>
>>
>> Without this, "make dt_binding_check" would break though, right at the
>> position in the example where "spi-max-frequency" is used.  That was
>> also the reason why additionalProperties was set to true in the last
>> iteration, but after reading the doc more carefully I realized that was
>> wrong after you pointed it out.
>>
>> I followed along bindings/spi/nvidia,tegra114-spi.yaml.
> 
> OK, you are right, the property is used here in controller node, however
> Linux driver never parsed it. It was never used, so I propose to drop it
> from the binding and example. You can mention in commit msg that
> spi-max-frequency was not documented thus you drop it from the example.
> 
> DTS should be fixed as well. I'll send a patch for it.

Cc Daniel,

BTW, J2 core is rather odd platform to work on... Even cross compiling
and building that DTB is tricky. If I failed, I have doubts that you
tested the DTS with your binding.

This applies to all GSoC or some Linux Mentorship programs: I suggest to
choose for conversion bindings with more users and bigger possible
impact. So first I would look at ARM64 and ARMv7 platforms. We still
have around 1000 and 3500 unique warnings about undocumented compatibles
for ARM64 defconfig and ARM multi_v7! That's the platforms you should
choose.

Not SuperH, ARC, or whatever with only one DTS which is difficult to
build for regular developer.

Best regards,
Krzysztof


