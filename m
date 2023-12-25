Return-Path: <linux-kernel+bounces-10975-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 490ED81DF88
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 10:37:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97019B20E28
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Dec 2023 09:37:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF839179BE;
	Mon, 25 Dec 2023 09:37:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xDTJVGjp"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8156154BA
	for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 09:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a235e394758so377046266b.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Dec 2023 01:37:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703497045; x=1704101845; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4axmPByVxOKuzdSXU1yz8CpPedh2630SAvkz4+h6BPs=;
        b=xDTJVGjpVeJy43VWoFjVEWvvCjYAuMkxI3MYBYoPuvKBnckM9HgeWfd1hCi3Cz0HOw
         h+jWOjSMjizHfLfSGnifDNzZ4hqi8EqpIqEGTTtciFwPWcVFsv2hua99eJOhqSUFghS+
         zzwmugblxtZtMh1nVHsaWqADx3UpYrslJ3+vK+zZ8Dcqg7j0X8zhWUY81aK3auyYBG3q
         7ZD259iAGLETGZl8Ae9Eki55W15tmV3k5kh/oP0COVouNvCFBen0/LPLktHU0hXBh5/S
         EJKDoTUOoE+/hCopisqcLkCuPdl3x5UUX9hxUJ/u3ckP7aZoidfx74YNI/HfqO54GIiD
         V6rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703497045; x=1704101845;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4axmPByVxOKuzdSXU1yz8CpPedh2630SAvkz4+h6BPs=;
        b=j20nqxyrVf+VooNZtt8mE2aPj8mLtRZQFHnkDzzmKqA7F6L+xBAtsyofOQ7VmoHag/
         5N/3bSmomsXIU/eSflK9waepKmSKhuIUaQqlAEWeJAngaJJEm60vmpVj/iGt3H7GtWZ7
         MZ4hYxXYSsBu+tF2586wkE6V0hK5j1jKNpm9EIL5If+W1kpgNs+dC8OEam2MrrPAVJxo
         GvFBoG7WLvt/S31JyV0s1KXq2+VlYyAdMUSwUUhf/WqQmmTFpSOfKoZXYN8H7cGH/8Rw
         3woKCArwL0QexbA7SbxN7+EEbaaZTns8V6+wQff5nmze77x3zlnaUTYDorYsVIgYpgFz
         /VfA==
X-Gm-Message-State: AOJu0YyCcyUb9XCwH0Nkv16TidsmsuHelUQzGg6r3IdYWLfQl7sxibrM
	t7OZVZE+fD8A8jcNQBWt+DGzCKzLoW8V5g==
X-Google-Smtp-Source: AGHT+IFg3FrwA80fx6td2rtwy5VWZLa1RWbvQ7fsCB1RJS2O50/dHiJQ0FVn4pzziKPZxNCwRUJuUQ==
X-Received: by 2002:a17:906:288:b0:a26:89fc:1904 with SMTP id 8-20020a170906028800b00a2689fc1904mr2394788ejf.5.1703497044929;
        Mon, 25 Dec 2023 01:37:24 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id wh14-20020a170906fd0e00b00a234907311asm4626097ejb.55.2023.12.25.01.37.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 Dec 2023 01:37:24 -0800 (PST)
Message-ID: <a2ad8b5c-9745-4401-9ab5-41616a5bdf44@linaro.org>
Date: Mon, 25 Dec 2023 10:37:23 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/2] dt-bindings: pinctrl: qcom: Add SM4450 pinctrl
Content-Language: en-US
To: Tengfei Fan <quic_tengfan@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>
Cc: agross@kernel.org, konrad.dybcio@linaro.org, linus.walleij@linaro.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-gpio@vger.kernel.org, devicetree@vger.kernel.org
References: <20231206020840.33228-1-quic_tengfan@quicinc.com>
 <20231206020840.33228-2-quic_tengfan@quicinc.com>
 <suy4rrpplvhsg2pfblg5amkvy7mrrkzsd3vzizhhpfj5xlog3q@i2n5wvsxb5wa>
 <8ea2e841-eb9d-47a8-b1ca-3597403a1bc6@quicinc.com>
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
In-Reply-To: <8ea2e841-eb9d-47a8-b1ca-3597403a1bc6@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 25/12/2023 07:50, Tengfei Fan wrote:
>>> +
>>> +        required:
>>> +          - pins
>>> +
>>> +required:
>>> +  - compatible
>>> +  - reg
>>> +
>>> +additionalProperties: false
>>> +
>>> +examples:
>>> +  - |
>>> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
>>> +    tlmm: pinctrl@f100000 {
>>> +        compatible = "qcom,sm4450-tlmm";
>>
>> Please feel free to ping me if you're having issues running
>> dt_binding_check and dtb_check. I believe the prior should complain
>> about this compatible being unknown.
> 
> There isn't any complain about this compatible when I run 
> dt_binding_check and dtb_check.
> 
> Here is the commands which I used:
> 
> 1. make ARCH=arm64  dtbs_check W=1
> 
> 2. make ARCH=arm64  CROSS_COMPILE=aarch64-linux-gnu- DT_CHECKER_FLAGS=-m 
> dt_binding_check 
> DT_SCHEMA_FILES=Documentation/devicetree/bindings/pinctrl/qcom,sm4450-tlmm.yaml 

Something got broken around -m flags for dtschema, so indeed no reports
are printed for unmatched compatibles.

Best regards,
Krzysztof


