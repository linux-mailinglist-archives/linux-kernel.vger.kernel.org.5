Return-Path: <linux-kernel+bounces-82759-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A521C868929
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 07:48:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5909A28485A
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Feb 2024 06:48:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28517535BB;
	Tue, 27 Feb 2024 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LQxJDU2r"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9B7F53391
	for <linux-kernel@vger.kernel.org>; Tue, 27 Feb 2024 06:48:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709016496; cv=none; b=egrxtiu3jx+nEyBhwj2GhtyGSe4jXXBPXC7hh7oFGs9I7x31ERvMJEqmEb77sN3Cj12V8r8bDyzrV2yWyrW3vBl7QrTmS513pDyTgjJFKMWtMfE8MreBeAikQQ8OM4pX2rCkPyk+Gyw9dn/lv92I/3sOuBfnrJRUnd7nF0J9mro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709016496; c=relaxed/simple;
	bh=WDrshlQ5Hw+q3estbrUolGjadT9Hxm4Npoj95g/m+VE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=EulJIlACtPZCdC64Fo4zNzTjUS5kUatWn4XXcaKZOXDFpI9WUaEBTaKp+2pKhjmcp5fx4xQr3LWpyvts6mZdEUXDVSHsiyh+3ftUusgMLIexvwzl2uivInXOld6IzlLyoAsRq0ayxA2+9Ixb3fbYJ+qc6Tm15vB8fH2aAOb7lsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LQxJDU2r; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a36126ee41eso458620466b.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:48:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709016493; x=1709621293; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6ktYYYMONtRVVQa7SJDqB66UXKwf6+poGY0Qtf1sr/U=;
        b=LQxJDU2r3+A336eT+mEY0mm/mKqPACV18A9z/41i3X8DKLznccvx8p5wj7ziVWCgxi
         uh/eWV2LK7KnQkY9xvmU8q8DadU5WRwJ8uJ1Ug25Uzjh4Qyvj8o7LVVf0Zl+2uuyHoG6
         f35d8UvmeB1SJN98rhz1H0vPGODOpAKzlHSkuRIz/F5KTfNYZ+4ESByFrTZv/hNYOC1c
         tTHZkr2Sw7OGSKs1M3DeAus3C9jYtmjGpUR6r4rrVcOCZzqWfh48iPTSeyTxGbQ1ZJMA
         2DCMKdvFXewGzJZn9jlWHk9iZT4h9fCpqJaUH8F8Rfoi7tbM+wEmqxyCTKTEd4VdNjQa
         v16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709016493; x=1709621293;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6ktYYYMONtRVVQa7SJDqB66UXKwf6+poGY0Qtf1sr/U=;
        b=slpZFeI77I7mJSPQVupmdBqes+/jjl2SPA7gZPrk2SRo9KdUNEhTdpHDjne5XVtyE4
         Z3h5Rwky+bQVkXsBr1XFAzfYXEPlI5rGB2iAOdCFoTOsF0wTECNRXe2dhlIgIujVns0Z
         1AtHSAl4E3RfpG4OYl5EbYHwOqO2TH3PmXDroAJBHkQmkYnotxuNLs/R64Lbf07gETNN
         O7GF92U68nbEmtz6qEkXdcYPR+B53vk1ro2IPU57gXgKiTu/f9GGiIjN7Dp0mPoxm57e
         Vn2LQxRNZMLTRUtAqjYG1JuAOWogTX93FLrvUsBml8+6KIEnCbWBGQdvepwfmm7Qj50I
         A/Ew==
X-Forwarded-Encrypted: i=1; AJvYcCUfUbQoQEv+IEs95uo8tlLo8fVR+a5851mGjuolMG1Jnud3aSGG4NMeZQWzehx/yBBiJu+RiDsBEv5kC+5UpWP6a8ljuVrjOtfJaWM6
X-Gm-Message-State: AOJu0YxWqpeFjQvKDjhfOHxV3Qvc26HNHvUS4F2AOJFlWnuUCr0gHgFG
	uvTpch6Q7fn0ChXIQm4sDNIeSkR/fEN1cKBgde4OAz8iUqMIEiURv6MgHIJMI/EdDSYhUzGZINh
	x
X-Google-Smtp-Source: AGHT+IGxihfmi3Htq+yOoVnA1LlZVRzU7DI9SGryIyI8T5nCYsUonLz81eHRfceoSMhQgl3eT4X2qg==
X-Received: by 2002:a17:906:c196:b0:a3e:8300:1af3 with SMTP id g22-20020a170906c19600b00a3e83001af3mr5914011ejz.30.1709016493314;
        Mon, 26 Feb 2024 22:48:13 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id q24-20020a1709060e5800b00a4335edcfd1sm447578eji.189.2024.02.26.22.48.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Feb 2024 22:48:12 -0800 (PST)
Message-ID: <907d61f3-4c9e-42b6-b314-927fd77e0b94@linaro.org>
Date: Tue, 27 Feb 2024 07:48:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: input: allwinner,sun4i-a10-lrad: drop
 redundant type from label
Content-Language: en-US
To: =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
 Hans de Goede <hdegoede@redhat.com>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Samuel Holland <samuel@sholland.org>, Maxime Ripard <mripard@kernel.org>,
 linux-input@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240226122934.89257-1-krzysztof.kozlowski@linaro.org>
 <3207352.5fSG56mABF@jernej-laptop>
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
In-Reply-To: <3207352.5fSG56mABF@jernej-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 26/02/2024 18:31, Jernej Škrabec wrote:
> Dne ponedeljek, 26. februar 2024 ob 13:29:34 CET je Krzysztof Kozlowski napisal(a):
>> dtschema defines label as string, so $ref in other bindings is
>> redundant.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Acked-by: Jernej Skrabec <jernej.skrabec@gmail.com>
> 
> I already send PR for 6.9. Do you mind if it waits on next cycle?

Yes.

Best regards,
Krzysztof


