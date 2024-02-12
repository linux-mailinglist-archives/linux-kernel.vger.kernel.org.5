Return-Path: <linux-kernel+bounces-61674-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F5AB85153B
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:33:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE75D1F21318
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 13:33:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 395B53DBBC;
	Mon, 12 Feb 2024 13:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eBdcQKlp"
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6B13B289
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707744057; cv=none; b=nMCJsd+Vh084Kiknw3e2iINfZVADeFapDB8xL+jfY78+zvzwSqvrHtH0gfZhEKeHFyAwCxiUuBT5Sl1TCSKuEPVGbOBnMUCaAbJI36eLcMZhFw0AuTQz36ujHW9nYeonod6QI4o00Kof41U/fsWadjqB6HpZBJXSlS0ZYooSfAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707744057; c=relaxed/simple;
	bh=CwagiQX0vtF/brg2LBqoHB97ypDZZDbujXgTqE/0KB0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=APdikmUaDdMXINf7cHOD/ZokaesyJFV7kq86T5M1Aq+d77oxXLaRUdfVxZE7EZD2klN8i8Mw+1YLVl0z0U643pwjkt9bue/JP0HF+ih5SzzdtUtC+bZ9n6AukSd/uqQ72br/SgLN0nHGb2vkIkw40Ojhrh6yq3HPa+TjS7W0Xyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eBdcQKlp; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-410980dfddeso13237085e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:20:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707744054; x=1708348854; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=GmLkYyLFTr5bJLK1oFTdEIMZTQyk1WHw7r7dqKQBBNk=;
        b=eBdcQKlpDXD0JyFZo1ECnAkV8iw8ftPdvuFMwBM+jOe/3HZnhLf7KCyhLs9yr1F0jI
         Cx+WeAYyujENRD4vkwn8pRvQYlSir9cb3t6XkWVrFI/pKC4ZHa8Z+M5G9hnqDR6JSPHI
         yIMcD/cg0S+2DSMpx17XIkrkl8DU+GuV1TRqK3M24cBTlPhWeOP7VbtVmO3P0fweLfnV
         5Upz25QcRpyn8VCjNORnGidfKbCxlczfc585QDoxk+/ySirYu7/Kc9TSSQAArDfGYV+v
         vzi+63lQ5CYR+mtZetDbDtnobH03SnZdcinR1geeH5adWWCPGfYXsqJYuyAjIkN6Fv+j
         ZHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707744054; x=1708348854;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GmLkYyLFTr5bJLK1oFTdEIMZTQyk1WHw7r7dqKQBBNk=;
        b=wTFzwmVDUDpSYNQsfTgbuiON9aqy98vvtNIcjNBZ63iPkDkCZMQoJPL+OaWux8LirF
         MPImMZmhfQYpmZGEzUNjsBLUAfJaVjiktjZbcIRpUDn8y9zxEpxynt7i4yOD73NjmJnJ
         VpFH2+XIqKxzIevLwncl9zJmA2nMvShHdTJbcKA/8aOTxioVrvX0isHBDHuVuSYbI/Qs
         ZT7DOz/kEUb/gWkme7YHPbBVifuIg5SelgBAk8T/wgExXRaHQvfYdD/+ky2uvR4mzX3Z
         36DL+0so/SGLxWppyBQncp9SzkQbrege7+huMn0yVi4X9MabAphRvlr/TLd352fnBKZs
         odtg==
X-Gm-Message-State: AOJu0YxhUcZ4NQSetLFPclADKEUn1mhR7+qCtCdcfNYwNU9TceTQqMQY
	YXwTCXdlc+z8TO8cJOrQmwGTAxfmQHUru3NdpCKtV2WlXM4Uj/7hZz5K1Kt9/ts=
X-Google-Smtp-Source: AGHT+IGdom73dgZKyuLHj5qBrrPW3Oe8BkHCzT1iWTTKS1oQ9EW3kK1UgkzHWSVS3zzPwZzLSKPnjg==
X-Received: by 2002:a7b:c445:0:b0:410:5876:63bf with SMTP id l5-20020a7bc445000000b00410587663bfmr6016802wmi.17.1707744053788;
        Mon, 12 Feb 2024 05:20:53 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWs6X67cnMZgF64ETjIRxhpDYnqCYpBRwI9MX56adWYMRsiuZl4k8AJ7MFVbkX2WMJQV1Hhm6DaY+Ei/iOGg7WSq5Xyz38miafs2/bBuds3Z3HntGUiS79QG7iMOMNeohEpBymEi0LHo+hgz9kr2/C/OXLueQS6Ge/dXxZYi+nQG+4l+kSH1mBpBgqUvz7rBOZGS26tRY1Lzl/LP5rRElvi657wK3lW8nDQaJwnGDdSg3C9ZG9MvIKt7chEiZtNK8Kk1AQjNWuHvYNzxuzQTWm1oLGaeUF7pYq6eKqZq4vW0tQ0LrLm5BX9JST1zgLzqItY0boQyf8xnuOJf0ii3tkalFJgooeoTpWcK2XASsKtneYQXT5nRs0OFOgJRaAiSeTwIo4Bl7PrlqFja6wN/R4Fa47WbgIyh/Swr2gi9IEUv8fVQ4JnA3fIaGX1UvXdyyhWTaZphG3c74Ua7kCRZ6qAiREcePi6Y5xoVMVNY5vGLxaGw6dN/VVY/A4=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id z19-20020a1c4c13000000b00410bc0cbdfasm4227505wmf.18.2024.02.12.05.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:20:52 -0800 (PST)
Message-ID: <38ba0c8c-8d82-4bff-bf80-ce30ba04c5ef@linaro.org>
Date: Mon, 12 Feb 2024 14:20:50 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] arm64: dts: exynos: gs101: add stable i2c aliases for
 gs101-oriole
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 peter.griffin@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 tudor.ambarus@linaro.org, willmcvicker@google.com,
 semen.protsenko@linaro.org, alim.akhtar@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240130233700.2287442-1-andre.draszik@linaro.org>
 <170737972037.52344.9107022607101399076.b4-ty@linaro.org>
 <5972b6a4ae8669e2a9e872278b740b182217906b.camel@linaro.org>
 <dce39e15-32a8-482c-8751-af4a133f82d2@linaro.org>
 <c16c1f18a8c6f33a608618d4ccf7d8c8dbb6f88b.camel@linaro.org>
 <67a6564a-00bb-461d-b7eb-ca169df6d251@linaro.org>
 <0ad3082c50e21a74de41ca9908bd53b72e1f1a9c.camel@linaro.org>
 <b6ec1d0e-e35c-4917-871b-049efcb2ea22@linaro.org>
 <fbd335e81928c1c3cd63ee44514cf95a23dafb6f.camel@linaro.org>
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
In-Reply-To: <fbd335e81928c1c3cd63ee44514cf95a23dafb6f.camel@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/02/2024 13:38, André Draszik wrote:
> On Mon, 2024-02-12 at 13:07 +0100, Krzysztof Kozlowski wrote:
>> On 12/02/2024 12:52, André Draszik wrote:
>>> As I said above, we won't care if downstream changes again at that stage, so
>>> no, I wouldn't plan on changing again.
>>
>> Then I am lost. What stage are you thinking? What differs between now
>> and let's say 1 month for the GS101 which was released more than three
>> years ago?
> 
> The idea was to make the initial transition to using upstream easier,
> hence we added the same aliases as downstream (at the time).
> Given the transition is not happening right now, we might as well hold
> off with the aliases and add them later, with whatever downstream will
> be using at that time.

Hm ok, I just did not understand what are the criteria of choosing point
in time when you take the aliases from dowstream.

> 
> If in the future somebody downstream decides 'I want this' (changed again),
> why should upstream care at that stage?
> 
> Again, this patch was just trying to make initial transition easier, do you
> have a better recommendation?
> 
>> BTW, the aliases I see in downstream DTS (gs101-usi.dtsi) - since
>> beginning up to Android 14 are:
>>
>>                 hsi2c8 = &hsi2c_8;
>>                 hsi2c9 = &hsi2c_9;
>>                 hsi2c10 = &hsi2c_10;
>>                 hsi2c11 = &hsi2c_11;
>>                 hsi2c12 = &hsi2c_12;
>>
>> They were set like this in 2020 and never changed afterwards.
> 
> Those were incorrect and didn't actually work as intended, here's a
> better place to look:
> 
> https://android.googlesource.com/kernel/google-modules/raviole-device/+log/refs/heads/android-gs-raviole-mainline
> and
> https://android.googlesource.com/kernel/google-modules/raviole-device/+/9864593c894da90cd8b631ab57f15c25f4e11465%5E%21/

Thanks, so it's like Qualcomm - DTS separate from the kernel, although
here a bit confusing because partially overlapping.


Best regards,
Krzysztof


