Return-Path: <linux-kernel+bounces-65253-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B6B1854A2C
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 14:12:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13E15282D59
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 13:12:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688C3535C5;
	Wed, 14 Feb 2024 13:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NdtwXRxc"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE51952F99
	for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 13:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707916337; cv=none; b=knG61vAX5CiSAi4XvC6gvCkpSvnYQpzzytsLgWSoJeVk3MLkCQ5+DNNbXvKX/VyU1DxzB8Vfwuo0OoBPMWkO3G05WgaPdDuZGOWLnLlMBso1NFpcb6UovJtssjJAiTjEe656Z1SOjBpoU9C1mg9Q4sObUSdV2NGZ9hMfbM/rbpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707916337; c=relaxed/simple;
	bh=txRxtI5DOq8gRoywZK8QluUGKbYWBDu2W93K3wTNRb4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=G8rBRcqUCF7Cwes7X6s/YN/2fPOHvGxJkiBTMpxa2lPXIdKypJC50wxITyUDIiajnF+I7rKxLBsEVXCD207bJr82mT5Z6a9wz5bcCk5XadCkULfJadForEM0PbdWcza996LjGWtzqsB76ZFZUsp2rv8WBja6rA6OT+rt1OuX3kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=NdtwXRxc; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5638d0b93cfso399237a12.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Feb 2024 05:12:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707916334; x=1708521134; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GTWbhbIxDXzwVaB1hSRJ03m4Y+JlUq3Z8S38vjsPVCs=;
        b=NdtwXRxcxJlUhYV5jystmdleFz3a4JwlylnnfKqtIug/eSE66Mg0FF3Fhf5QLH0Nbr
         ZcwbVRGKg2/c06d/jj3Jv+GqZdWTjdqjj4LTB2Nkfu34jM6GeU2wpZ2SrDsdj9yN9TE3
         W0+3+s9qpsFd5CLT9+N09RUbX1pnZpYMUzqPg6EtFCIUtOAsqENxPtzR6SOxEVtOY6ci
         7TLMSe50fNNY1QqMlvjwVEItLL9LUNheAEzQ+bQr6tXC0cpEWPeePk9XMmgD4S9GHGuE
         HxKNjQGyNKyo9cHlAKQDu7Cq+oW50HO3VFCyvE9I5ZLj8yWXJhR8Cuc+QqLd6bOOkbr4
         idoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707916334; x=1708521134;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GTWbhbIxDXzwVaB1hSRJ03m4Y+JlUq3Z8S38vjsPVCs=;
        b=cDnUKBwzofMHH6Ysdsjeabxy3cZ2D2rQ5aUaqPHTMC9ZE5lEzNpC/YjI3WTvLqZeaH
         KRzcaGJKe08uUjBlCOFZMSCphf+ORB5cmBqcUQH0Zk4UoX3Q/J8CborIlYmqrbsplvfI
         a0KhMu2KmuJ4SPZj7H62b65ZQQbZooiok0Lxvc3OxknLvnEqAsPtSDOX+VjtqOlf0yRy
         n1j+IhkQmLPCBGw3N7Xqpgx/yw2feHH2ho+DkJDBuUQahNbO/Q5nWLmHwxNmWgET8ht4
         C45IzSI5JQy81DNOxdFZnSFlLFivR58pHOa59qiq3U7F0LTOEZVmkY2rP/tzmJREnIrJ
         giPA==
X-Forwarded-Encrypted: i=1; AJvYcCXzi/fkZ21t/PFFEKfZd7aRvF+NDs5s0IeQUKtR7Tub52kJGu8XfHyidWx1kuqBq0S9RJpGdkhTLIoXJhjZagsZSVMDA4lifvLRXr4r
X-Gm-Message-State: AOJu0YykG+FBNDamf2CW01ZVXBpjzwWddFmZQPGquXXUiAkwRf+ZTguj
	cV8dI09VdWhEIYB2Pa8wrRoSNs5xycQZhacFT9mF1CmMumxonDhA349ess3cZnM=
X-Google-Smtp-Source: AGHT+IHTxs1NP8qVpwblRWcIQgYBN6fj9eanF0c88Q6FlLP0TJvwWCPQh7H0TPkj3hJ4dXGt2xw2xQ==
X-Received: by 2002:aa7:d752:0:b0:55f:ffb2:75ca with SMTP id a18-20020aa7d752000000b0055fffb275camr1939323eds.18.1707916334015;
        Wed, 14 Feb 2024 05:12:14 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWFHaNIPftCer4neyycqA7iGDVOR2bzUH9B/JjxJXZUG2XXhFYc6eiO+qM3VtxTa3sVcEdCP2HpJECPzZMV+4inQ/rgiLDF3kLB8RGWiSUG8+nuxiZfFrze3GAamFDV7KL265jx0TL8aIMZE8kBfeDgfGLFePs4Q6NJmeOK4M0+Jpcb6kUjn1hCi7NPFKLhN56iBERbvOCgSzc6B7DPki59lGWD91ltwrHPx2Wf8X1UJdVp1GeDiyH7XdXSrbqIymzy4JX7gC6fc+ZMaMNAMpkeUThZ5hTROziptW953sWiXiVNDANf9sIF6YevPQIS4rj0TVPEDSckPsU9XRkQrvwT1h2cDA==
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id p10-20020aa7d30a000000b00561ee313634sm1622036edq.51.2024.02.14.05.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Feb 2024 05:12:13 -0800 (PST)
Message-ID: <e2cba92d-ae82-47b7-ab28-959115c05a14@linaro.org>
Date: Wed, 14 Feb 2024 14:12:12 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/2] Add board-id support for multiple DT selection
Content-Language: en-US
To: Amrit Anand <quic_amrianan@quicinc.com>, Rob Herring <robh@kernel.org>
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, kernel@quicinc.com
References: <1705749649-4708-1-git-send-email-quic_amrianan@quicinc.com>
 <20240124145631.GA873781-robh@kernel.org>
 <b929f0cd-89b6-c48d-d466-db6bbed621b5@quicinc.com>
 <a930a3d6-0846-a709-8fe9-44335fec92ca@quicinc.com>
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
In-Reply-To: <a930a3d6-0846-a709-8fe9-44335fec92ca@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/02/2024 13:56, Amrit Anand wrote:
> On 2/2/2024 10:30 AM, Amrit Anand wrote:
> <snip>
>>> There's a similar issue for EFI boot with how to select an OS installed
>>> DTB[1]. You might not care now, but users may later on (like we have
>>> already with QCom devices with fixed bootloaders). If you do this
>>> board-id route, then no doubt that compatible values won't be specific
>>> enough or have suitable fallbacks to be used. Then EFI boot can't use
>>> compatible either and needs to use this QCom specific logic. It may be a
>>> common property name, but all the types you defined are QCom specific
>>> and the matching logic is pretty much undocumented. I'm not saying we
>>> have to use compatible. There wasn't even agreement to use it for EFI
>>> boot case. This does need to work for multiple vendors and multiple boot
>>> scenarios.
>>>
>> Agree, given so many hardware identifiers Qcom uses to find the DT 
>> based on a best and exact match algorithm, it may not work as is for 
>> other vendors/users outside the scope of Qcom.
>> Since we have none to very limited visibility into complete set of DT 
>> selection identifiers being used by other users or into their 
>> selection algorithms since it is mostly undocumented,
>> designing a perfectly generic solution (one-size-fits-all) could be 
>> far-fetched. The number of board files in Qcom DT selection software 
>> package often reaches over 100 DT files due to multiple SoCs and
>> board types being supported out of a single software package and these 
>> multiple hardware identifiers helps to pick the closest best match DT 
>> within a very large pool of DTs.
>> Not to affect other users/vendors who would be using their own set of 
>> identifiers and an entirely different algorithm for DT selection, 
>> would it make more sense to define these Qcom specific
>> identifiers within Qcom specific bindings (qcom.yaml), along with 
>> detailed documentation on our DT selection algorithm?
> 
> 
> I have written a patch for defining Qcom specific identifiers within 
> Qcom specific bindings (qcom.yaml) along with documentation on DT 
> selection algorithm, would it be okay to send for review?

New ideas and patches in good-faith are always welcomed for review, so
go ahead.

What's still missing here is involvement of other SoC vendors: at least
their maintainers and mailing lists.

Best regards,
Krzysztof


