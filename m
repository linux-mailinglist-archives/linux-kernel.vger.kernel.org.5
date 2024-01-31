Return-Path: <linux-kernel+bounces-46007-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 459AA84392B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 09:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6AC821C26EB0
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 08:35:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B275D8F7;
	Wed, 31 Jan 2024 08:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r4r+TztO"
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2A0560DCB
	for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 08:34:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706690101; cv=none; b=JQzyeXOfaLf6chz6y/jpdjxrakpYdHuxeJK4jSO+1HjaChHjpfdowQ2P7aM3sMFjB4gXzemcEKEYZztnKvG+FuhO26iwDXt5QPEO5iTtFhr2kw0PBZ3I98iDG+p1oA0C43dao37NV4D4lWZrvPsCdfCOeI/wDFOfePySfCpTA0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706690101; c=relaxed/simple;
	bh=PrY4WzNIJbCovvb984PFUCOR4gdyFVhWaow4/mF7UKg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LJ9/gUZQEoD5MqcWEwH0IrWeBVr/s2IagXm3ihsvF1Zc/2WSf5mwS3JRaDDP9QV53hC9oXlhBxjR23vap6OE9Q1gmW2lGJbuPJ3FIIHCAqJDyTKBAEBOWdHsFQP0oaNOkNQc2nDy68HUT+8rVvL8TNvj/G1FR71ePoBynss2jac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=r4r+TztO; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-55c2cf644f3so5028421a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 Jan 2024 00:34:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706690098; x=1707294898; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LlC6IKVQ1yRmrP5iUErlPGYOVXTRisa0xVDs/+U4q/E=;
        b=r4r+TztOvmFbxxypW40cX0h66wBa7Nix1pn0O0UiIB69m298zDmoZrVZliQeDAqQGO
         HV1dL+hqn5+KykK0tM95zZDgbk99+n8xHIutdqGbfgZvXubSK9L4yrEX73rst+6R4vOU
         t0n6pmL66nXZdjPvw9slARS6GxvoCBogSh8XzKAPd9Ui+lhu9ZVmqHlWbWfoW6Xy1Fm5
         j+3tybkiiFGUUky9xfBL6zGY5noaQqaCFk0MGsbsWjxIdnxUsP06pIj/Y50TXU1BUmJI
         PZg7DWZE+Re4Due+5vi6+vVm7DiY+v1p4HnC5n418o3UwnGa3RXv9bfyTKIgiK8egNH3
         71Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706690098; x=1707294898;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LlC6IKVQ1yRmrP5iUErlPGYOVXTRisa0xVDs/+U4q/E=;
        b=rj9d3E+0e+MXPnEfC9JcSbhumOJ/bV4KdvbeWzybh2SRI8td75qYTu9dJTZ9J83KZp
         FhtL4KTge2GoE+dcJWa8Er35pqttlnFFP2e7G+ooAbqD53W5e4iyulqu8ET3xZAv26ag
         RlhOqQBPpWK2bcaHu+KbLwlMgRF5qTj/Mt2AJxNlZzP+qEkLfs0/XH3MHS9Eq6WOu0IY
         rE870TJJIqc/ICVBTyP3kCESJpScppxBF9s2flZ2GUy4fsZJ+nDAD6ro0cHr0Vkk7z1L
         EOQ22CBWrNsiq43GW8z/dP7nm1PjgH06rSIBPf/BDsZCCyiTx3KvpmlpFklMepT+rGmA
         Do+Q==
X-Gm-Message-State: AOJu0YwBAqRdVGMqk0/nxdENtdekVSI5mWsJAdX9F3sH4ZAHzbnAxtVL
	BIlj1eY5wNjaPpj34ViCfuDHOsUwJWpYpE18QAwj1cGhFKIeHJr595bmVc8zDK8=
X-Google-Smtp-Source: AGHT+IHVBVzs8B5ZZkUzum3M6vrWPsI6KOFprHue7XSrJOxF/0z4HsiJQi7mc45TvQFOoZiAWwiGJA==
X-Received: by 2002:a17:906:c7c2:b0:a30:4618:80a0 with SMTP id dc2-20020a170906c7c200b00a30461880a0mr584484ejb.33.1706690097871;
        Wed, 31 Jan 2024 00:34:57 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVKjDsjHoqmBPPc4Wq+7GVuVCw/osGKy4HQF2L5IC9Kh8xUC0XoyZvEfhLtpIvRDYyfE+VYsGQhDK9+K2Rtj391jR22Sap+L92gDZ3DQBCJGEZ6eSaOlVyVjuLFBp84sf0J0nT3AlKJe4JXwHNr5JRdvYV6kg4APivsupWVSNA3O+tzcfVAqW6OmiXtbW7lnHhk9Qc67xa7OUaTxz2/SlYkkkZdRd5cnDp1iqNAYvxloebdHwE5PP09ndreeQtmLQ4IjMpM9a4yNh408EqglnNmr5TSNkQH4X1fJJZBSK6dqi0gwPJXIFCXUvmZOat1SbXJRcOBMjywD+j6BPQnKDHouPA2R4+ZX/ypIyjYfaxeeDWCDkhBt8AGZn9aPcLKbO+D0ayqaEGtm57pqYzkgw==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id d5-20020a1709064c4500b00a3677eee12bsm315719ejw.182.2024.01.31.00.34.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jan 2024 00:34:56 -0800 (PST)
Message-ID: <6fb7286c-8669-4f99-9bb7-3ef8dfa229c2@linaro.org>
Date: Wed, 31 Jan 2024 09:34:54 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] dt-bindings: pinctrl: qcom: consolidate functions
 to match with driver
Content-Language: en-US
To: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, linus.walleij@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@quicinc.com
References: <20240129092512.23602-1-quic_tengfan@quicinc.com>
 <20240129092512.23602-3-quic_tengfan@quicinc.com>
 <aa870f52-d956-4c3e-82a4-980a32f5f698@linaro.org>
 <8a3866ee-d70b-419c-bde4-7bf55415402e@quicinc.com>
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
In-Reply-To: <8a3866ee-d70b-419c-bde4-7bf55415402e@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2024 09:24, Tengfei Fan wrote:
> 
> 
> On 1/29/2024 7:24 PM, Krzysztof Kozlowski wrote:
>> On 29/01/2024 10:25, Tengfei Fan wrote:
>>> Consolidate functions to match with SM4450 pinctrl driver, because
>>> consolidate functions are being used in SM4450 pinctrl driver.
>>
>> It's very difficult to see what changed from the diff, so please explain
>> brieflyl changes here.
>>
>> What is that "consolidate functions" that you use in the driver?
>>
>> Best regards,
>> Krzysztof
>>
> 
> please help to comfirm that the following description as commit message 
> whether it covers your concerns:
> 
> Pin alternative functions are consolidated(like: atest_char, phase_flag, 
> qdss_gpio etc.) in SM4450 pinctrl driver while they are still split in 
> DeviceTree binding file. SM4450 pinctrl function is broken if current 
> binding doc is followed. Update SM4450 pinctrl DeviceTree binding doc to 
> align with driver.

Please list the functions which are being removed and added. I usually
do not expect such commit msg, but this is an exception: diff is tricky
to parse.

Best regards,
Krzysztof


