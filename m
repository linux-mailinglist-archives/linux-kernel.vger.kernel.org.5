Return-Path: <linux-kernel+bounces-27535-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 232C982F1BE
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 16:44:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3524C285CA9
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 15:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA9DC1C2BB;
	Tue, 16 Jan 2024 15:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="efNoSlQz"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 654711C2A8
	for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 15:44:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a28cc85e6b5so1189201066b.1
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jan 2024 07:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705419872; x=1706024672; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rik98Wypelg/iFUeapRB60xFxi9oGl9rWiTrFyc7vzA=;
        b=efNoSlQzrfB7jCDE/Z2ZrgNNfzB1HF/ybR9rVoRa0wmfvpYEyK3gs9rAuWb0VeNVrt
         UgpAEsfyyKB4GutWVeJkrCABZnMPcEGrW8W0AkLS83uu16ixq4HRBY1zNUmXX3YjXS5V
         Rhrphr08Ngk4JQROMUZrZAPO2YFGQF2eDBfIrV6vj8IOP8liFK++o+iPgwTagDs7E/Lj
         nenmqwHIxYvASWZ8++oTEahes5eeq7OxmYyDi4TDWf4HFz81YKDECd1kbsnCKzsK/tZN
         Nbuuv+Akzz7q8EyPicwdAkwegNvDYIt/3pvEC/HG7Uep70RMyLks8QPXheWFxba5M89D
         UoUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705419872; x=1706024672;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rik98Wypelg/iFUeapRB60xFxi9oGl9rWiTrFyc7vzA=;
        b=Vtb56OHlzZ+2VlqiDDSwDNY4MsKyPqDi8vTLkArBYoOtkTgK1JfyBKfdEGhz17GAjJ
         1Q3t1ZzpAFZFye+qOzx+3+mRc6PhjEvX49H+jdyFqdvocaRPnYC3H0Z+LTsdomybds82
         FdKcDZL2h2pVgFaYN8mEDtn9C+VDvPgM32fOAstuZcFIBauyhknLfLWRtpbBJRgDXg/+
         WQIXb+zGrEOwGsMgpHJM2aOaNUQoLxdtvN2qpL5x3V3SVMqKnqsGR/+OYIfFqZTOWDLr
         xH7JifVr5UOMncNbqtl4wX24Len8PD6CiSY6mz50k+UJBiNEB2MlXbLgjyVFkMoUT1aR
         mGqg==
X-Gm-Message-State: AOJu0Yz6jStpL13ftgvuU+ZQUzFRXjQfCcdwivFtUNkYcElmoD1nRDxv
	jIPWdpiajGWa/AcgsWWDtppuyXg9NNDvXG3aajY2c27leig=
X-Google-Smtp-Source: AGHT+IGkCnW2ZMoOUk1SXehRKpWkgXFjFJAq8lJ8k4Ku2uNP/50UESdVONXfRCEPBjT32jDgukBNRA==
X-Received: by 2002:a17:906:4741:b0:a23:7576:3552 with SMTP id j1-20020a170906474100b00a2375763552mr2335553ejs.45.1705419872631;
        Tue, 16 Jan 2024 07:44:32 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id ap3-20020a17090735c300b00a2c879e89a8sm6186366ejc.188.2024.01.16.07.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 07:44:32 -0800 (PST)
Message-ID: <f3d7d02e-dec3-4292-b00a-d90c8b614642@linaro.org>
Date: Tue, 16 Jan 2024 16:44:30 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: misc: xlnx,sd-fec: convert bindings to
 yaml
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, arnd@arndb.de, gregkh@linuxfoundation.org,
 michal.simek@xilinx.com, linux-arm-kernel@lists.infradead.org,
 robh+dt@kernel.org, mark.rutland@arm.com, devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, git@amd.com
References: <20240116111135.3059-1-dragan.cvetic@amd.com>
 <20240116111135.3059-2-dragan.cvetic@amd.com>
 <107e9496-8b2f-4de2-9396-945a7c822493@linaro.org>
 <7c76ac86-40d3-4c55-a0a8-0b83fe971bd0@amd.com>
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
In-Reply-To: <7c76ac86-40d3-4c55-a0a8-0b83fe971bd0@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/01/2024 16:36, Michal Simek wrote:
>>> +  clock-names:
>>> +    additionalItems: true
>>
>> Nope
>>
>>> +    minItems: 2
>>> +    maxItems: 8
>>
>> Nope
>>
>>> +    items:
>>> +      - const: core_clk
>>> +      - const: s_axi_aclk
>>> +      - enum:
>>> +          - s_axis_ctrl_aclk
>>> +          - s_axis_din_aclk
>>> +          - m_axis_status_aclk
>>> +          - m_axis_dout_aclk
>>> +          - s_axis_din_words_aclk
>>> +          - m_axis_dout_words_aclk
>>
>> Why order is not enforced?
> 
> Let me comment this one. Based on my discussion with Dragan IP itself is 
> configurable and only the first two clocks are in all combinations. But based on 
> his description that last 6 clocks can be present in some of them.
> It means order is not really fixed and any combination is possible.
> That's why I have suggested him to use this description because I didn't find 
> any better one.
> I actually tested this schema here but didn't get a feedback on it yet.
> https://lore.kernel.org/r/3e86244a840a45c970289ba6d2fa700a74f5b259.1705051222.git.michal.simek@amd.com
> 
> It means not sure about not defining maxItems but when I don't do it it is not 
> passing dtbs_check.


This would explain why you want additionalItems:true, but it should be
also explained in commit msg. Old code did not have such relaxed
statement, at least not explicitly written, and commit msg explicitly
says it is 1-to-1 conversion.

Anyway, current solution won't work, because additional items can be
anything. Try it. Put as fourth clock "yellow_duck" and see what happens.

I don't find such names as useful and maybe the drivers should just get
by index. Especially that Linux driver does not care. It would be a ABI
change, though, so up to you.

If you want to keep the names, then:
1. Look at snps,dwmac.yaml
2. or just list 6 enums with all possibilities.


Best regards,
Krzysztof


