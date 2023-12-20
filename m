Return-Path: <linux-kernel+bounces-6555-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A55E819A4D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 09:18:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AF6F1F26069
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Dec 2023 08:18:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B19FA19BCD;
	Wed, 20 Dec 2023 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jcW6hNgJ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78BC118E3C
	for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 08:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-40c31f18274so68311825e9.0
        for <linux-kernel@vger.kernel.org>; Wed, 20 Dec 2023 00:18:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703060312; x=1703665112; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KFx+4cYYZZyuj/TbSksWbQ0odlf5Gkpf1BfzDhsfY78=;
        b=jcW6hNgJstaBH053IBKs5Ikp64c3qoDl8gH2APe4VmcQAjBU6u3d6WmIMapKQS4bbh
         HZ4xtOX6XEB/tIyfmzJTjwtmW4HO3j7YwjBbT6Oms36X+XLyKu9QqOigaO3R/12BpjYj
         4ZV5IYYgk/+hMEhHK5knhaklz/fikLKyaL15hmNQiDxIgzemO4lGUAJM6Ho0Uo1Wm2Eu
         3REPwU/7yHJOML5/I1+R3GZOFkuSOzNXLCGJe74YjEPbAeM4CxBXmus7Ia1naYuVPT5y
         PI4fMIf8WL199cg7cwVgyLGQTu8jxFSuissBWQnf4DfGPBLggGLv7jQK6tcWd9U0rhR0
         em6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703060312; x=1703665112;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KFx+4cYYZZyuj/TbSksWbQ0odlf5Gkpf1BfzDhsfY78=;
        b=aXkTfpE/kc9OJl/BduCw7EuPNgQ0EFu8pQ6tmQS4TDzJdhHQ7HiwQ7xEISFxbyZ+l3
         HD+kElRZBEW1ki3rTYg/xmiebzAzcnL4ipzl+0QIyhb5pdkCPqUfNASsBvn8KHPzl9bd
         gNrJbje5fcDp7G+gQ4pnTB+t2ny0uIspofRpP8SFS0cbfDnqykVSwECIzZK9FiAB1i5T
         RMuZQb3wrES9BPkQ0AjhbqEEJv7AkNOvqxSamEmNlo94mMrkQfvhgtyqvHZ39ukg60DO
         fDmo9eMn+c0eVuQ7Agtqumt377sWwpSE+KWyDIVNTtrMFvqvf1oyIXIAO2trAKo89zLz
         7FmQ==
X-Gm-Message-State: AOJu0Yz5FEAXboyeiAPCZM9F3Tez9tyFATOeGlCI4J9xopOq4pfgMBrl
	lV02CwRmNeW9JQXQ3/IEgH/rfw==
X-Google-Smtp-Source: AGHT+IHEvKhppihFZH+YMFsL92asJI8U5hrxVQXJ29aNTXCAtYMicV20O0jJERUSuLv9+WBXoV7lHg==
X-Received: by 2002:a05:600c:219a:b0:40c:20d9:f003 with SMTP id e26-20020a05600c219a00b0040c20d9f003mr9060358wme.242.1703060311708;
        Wed, 20 Dec 2023 00:18:31 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id f17-20020a05600c4e9100b0040c310abc4bsm6237316wmq.43.2023.12.20.00.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Dec 2023 00:18:30 -0800 (PST)
Message-ID: <5be15b6f-ac6e-4cab-bd83-ef3fa50e1886@linaro.org>
Date: Wed, 20 Dec 2023 09:18:28 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: firmware: xilinx: Describe missing child
 nodes
Content-Language: en-US
To: Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
 monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc: Conor Dooley <conor+dt@kernel.org>, Guenter Roeck <linux@roeck-us.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Naman Trivedi Manojbhai <naman.trivedimanojbhai@amd.com>,
 Rob Herring <robh+dt@kernel.org>,
 Sebastian Reichel <sebastian.reichel@collabora.com>,
 Shubhrajyoti Datta <shubhrajyoti.datta@amd.com>, devicetree@vger.kernel.org,
 kishore Manne <nava.kishore.manne@amd.com>,
 linux-arm-kernel@lists.infradead.org
References: <5bb16305a05692de29ee2aa2accc793e23b68dec.1702997680.git.michal.simek@amd.com>
 <fc7863a2-d3c5-47c8-9484-ef9cd6d7dd5d@linaro.org>
 <bcc3a802-70cd-425e-bb33-3ced81c038fd@amd.com>
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
In-Reply-To: <bcc3a802-70cd-425e-bb33-3ced81c038fd@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/12/2023 08:57, Michal Simek wrote:
> 
> 
> On 12/20/23 08:53, Krzysztof Kozlowski wrote:
>> On 19/12/2023 15:54, Michal Simek wrote:
>>> Firmware node has more than fpga, aes and clock child nodes but also power,
>>> reset, gpio, pinctrl and pcap which are not described yet.
>>> All of them have binding in separate files but there is missing connection
>>> to firmware node that's why describe it.
>>>
>>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>>> ---
>>>
>>>   .../firmware/xilinx/xlnx,zynqmp-firmware.yaml | 31 +++++++++++++++++++
>>>   1 file changed, 31 insertions(+)
>>>
>>> diff --git a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
>>> index 3d578f98ae2c..0662544f86f0 100644
>>> --- a/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
>>> +++ b/Documentation/devicetree/bindings/firmware/xilinx/xlnx,zynqmp-firmware.yaml
>>> @@ -53,6 +53,37 @@ properties:
>>>         vector.
>>>       type: object
>>>   
>>> +  zynqmp-power:
>>
>> Can we rename it to "power-management" or if it is a power-domain
>> provider to "power-controller"? Assuming nothing requires the old name?
> 
> I don't think there is any name dependency and node name can be renamed.
> 
>>
>> Also, all these nodes/properties look like not ordered by name, so maybe
>> it is possible to add new nodes in some order?
> 
> I am fine with it. Do you want to sort it before adding new one or add new one 
> and sort of all them?

Maybe the new properties can be added not in one chunk but
as-ordered-as-possible?

Best regards,
Krzysztof


