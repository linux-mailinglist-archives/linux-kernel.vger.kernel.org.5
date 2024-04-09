Return-Path: <linux-kernel+bounces-137572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FC0989E41F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 22:04:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E42972874AF
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 20:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6D8F1581FC;
	Tue,  9 Apr 2024 20:04:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OqiPkjxn"
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2EC157E9E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 20:04:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712693058; cv=none; b=LI+JF01xZSdUHv1tMbNmwoepSRVVENUkYi+DQFlinJzZT+u9f3vvWGGS2rUTY0PogbF6jMyCt/D6cUErYxpDyrPnbgK1fAtfCRJ/UzbRNsZviokltLdDl5RfTDA5u/HY8cPKUQeW9qhp/Ofnc5roOxzmIPqF4NZeEwb7bNVPZBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712693058; c=relaxed/simple;
	bh=Q44mIiHGB2SfM8sXwIihv698PyFrDixi0uzK9Vki860=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=on4YvhRJOVJowiwah9I4Fx1h6rZGx7mPj08mfLANtFiLBEma2UIvuRkZRa3OMNgXTO8P4JU6cMuFAwhUPBmENcmHYqTW6IS4kBa64UtyUh8ZR4dG7msXVjPRdKv1uO9yN9v/FJIBuRGB8Cq5r+Dppj+sEp+whU466MOt58q+fyk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OqiPkjxn; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a519ef3054bso558252966b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 13:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712693055; x=1713297855; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T8fyR0UmRbd6AGuEBfuPsRWhfNBjyYyin79wmktpm1s=;
        b=OqiPkjxn4Sz354I8OS+vESNwQCwDxlEJDwHPuaiAHGqzwy0M0RRUCKC2Cldqdnrw9A
         BeVIw+uePe1xxu9aCBI2kBj/5ZKnsGBi5g5V/5muS2pVnXtlAkzzDvVR5M+5/P1vRfo5
         tHXi2Gstz4Be8R2t1eOwvg/yw3m36bpYYicIksFHRjfMdeBpSE7+/pepv3tB76rrBmmy
         JgTrHLloYopBMKyv84F+Ai1b7B9ltmdKUJeAWJxDKsgUiMkmabvog0iYdFHEtIL++1u7
         AQTu8furK6HfvRzWPfuZcJcY3mdDTbgG/m5ZL0gjKfDCJH8zlC+C6RrWvVIEUg6LxTfr
         bBcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712693055; x=1713297855;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T8fyR0UmRbd6AGuEBfuPsRWhfNBjyYyin79wmktpm1s=;
        b=L6WCp/2RGnwGterbbB2/Gr+17gN7CyVaYWKJOTWzEEqE7is95bnCN8z9VM2GEWxBv4
         HHmejcX8mksN8MZ/WaBxoIFgZLcYLv7JhbxhiNFjzr53QdRKzPwWxHXN43C96RpRQB59
         bQ6wqZYg9wyKm8PryDV2Wa2IICiQQTQA3/Cqd1/fVm6uByXmnje8cb50MuntoaRP+jCq
         rvEy9McJzSWumoSlQ1dcl8xhRQAIKRi7mYi7YCYblZ6QGF9PgL5rUzwiyNIp1mafhpzT
         qU16TGg9OrBmFaVdZH4xnX6+9jElEbLiSKtw3CYN1fyRp0ucsVhCOUrL5b+0H0dC+187
         pD+Q==
X-Forwarded-Encrypted: i=1; AJvYcCWp8KBiBH3oVPzdK0ybPB6spDGSxh1Ev6/57/HABBvAWvjOePmu2HVPSd2RnLZZ0hN1WSd3sXwa6KwJG2EYJtjDfne4KYH3cV8QGk5t
X-Gm-Message-State: AOJu0YwHcPe4xu9oyWX/iYY6J6Hcu9zNJNmw5kU00c+QkmxVek8OSBQz
	UNGep47VKSq3ZkBsu5gnYR18hwqd/0o0YPmMLJ5b/d0o9WLeEJCUTS1h0QQBd+E=
X-Google-Smtp-Source: AGHT+IGyMizT+OvK8DSGQKaj2yw8idcT4JVhxXcsQMIEJ6ZFY71mOUBuJtHQDUJlzZ2VML391lz4Iw==
X-Received: by 2002:a17:907:968b:b0:a51:d235:74cf with SMTP id hd11-20020a170907968b00b00a51d23574cfmr455113ejc.38.1712693054516;
        Tue, 09 Apr 2024 13:04:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id va12-20020a17090711cc00b00a4eeb5ff4ddsm6031030ejb.152.2024.04.09.13.04.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 13:04:13 -0700 (PDT)
Message-ID: <63fc911e-8906-43d0-a4bf-80ceac83d178@linaro.org>
Date: Tue, 9 Apr 2024 22:04:12 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: (subset) [PATCH 1/2] arm64: dts: ti: k3-am62p5-sk: minor
 whitespace cleanup
To: Nishanth Menon <nm@ti.com>, =?UTF-8?Q?Beno=C3=AEt_Cousson?=
 <bcousson@baylibre.com>, Tony Lindgren <tony@atomide.com>,
 Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, linux-omap@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20240208105146.128645-1-krzysztof.kozlowski@linaro.org>
 <171269138685.642844.11136653326464585397.b4-ty@ti.com>
Content-Language: en-US
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
In-Reply-To: <171269138685.642844.11136653326464585397.b4-ty@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 09/04/2024 21:36, Nishanth Menon wrote:
> Hi Krzysztof Kozlowski,
> 
> On Thu, 08 Feb 2024 11:51:45 +0100, Krzysztof Kozlowski wrote:
>> The DTS code coding style expects exactly one space before '{'
>> character.
>>
>>
> As discussed offline, I am picking this patch up.
> 
> I have applied the following to branch ti-k3-dts-next on [1].
> Thank you!
> 
> [1/2] arm64: dts: ti: k3-am62p5-sk: minor whitespace cleanup
>       commit: 45ab8daed512258c07fd14536a3633440dabfe84

What about the omap one (second in the series)? Shall I take it?

Best regards,
Krzysztof


