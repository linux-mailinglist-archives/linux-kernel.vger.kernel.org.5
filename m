Return-Path: <linux-kernel+bounces-129433-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BAB0896AC4
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 11:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 876271F2A795
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Apr 2024 09:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F426136E3F;
	Wed,  3 Apr 2024 09:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fBnc7xId"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9A9137762
	for <linux-kernel@vger.kernel.org>; Wed,  3 Apr 2024 09:31:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712136714; cv=none; b=pOa+PMnqwyfakVqJKnPM809TRARCEKCuaOiV+V2uMWxvNd0mb2U4DEzGOfy6oG4VvJnf7jYWYI3vzwPy2zsibK2BkD0CKLE3/I02C8vIxWPXWw3Ek5r4lewSnI2rSNm5WyL0qtHV0n2rGrPAd44OEaEY/QZinvaGa2duCqg93LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712136714; c=relaxed/simple;
	bh=ko/qYKJKD5DoQqCWzLJYXeEesdl0eMtrpDc1TNW8JiU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BfrEtuxtg5WVoIIRnUtRjg+UDlxTrMNJMragV4f4AqxDZbBXwSXc7UfixacsMhCP3kBpWZkgE/lt6/OW5UPjWhlOCx5W1V0R2Izu8qChxQ4Dgd4DdAjYVAmQ1zPZXf32Hyo5B7wVyIb1mowDajY00LELgNczBjp/tUSvmOSegeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fBnc7xId; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a472f8c6a55so791371566b.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 Apr 2024 02:31:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712136711; x=1712741511; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=nkPrFPLlzXsKFMFxEqrE2fZn6GiDoCde4n8aZdUS1Ps=;
        b=fBnc7xIdYUGxvDF3+6GJ+sGGL1pp8N1Gqk+WoR5E8/MG5gmtauRIz2DOO+QjJfZOOJ
         G7zFZnk32PTzMPhq2uTM2MrlcuXmrU8bc3po3aThZpLo/taO7ktitCSElzz7Lp7/ugIQ
         wKtIrqAm6frCkTfVrVMPRZl7qNS7z77xwd2pdr9UjfYkFAbNOa5weJdg/aCij/7UVcHv
         dXMHSV4ZZot2sGzxNUAffFjrty2eEQuVJ7CR35e5ow6YXEcfVIVF6yQYfuTLaInwG0KP
         dcu9tIafQKLoImxBwBHbCRaYaEUGr10AtvNPcVcdItlmG8A1bYtyZfFmQsr9DccF3eZP
         HYHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712136711; x=1712741511;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nkPrFPLlzXsKFMFxEqrE2fZn6GiDoCde4n8aZdUS1Ps=;
        b=vLRfvKgRng9rleMrKGT6Z7Cb4xpKOeleLTfD2UOK4+WcgXvwEXud8jlH1AtUqZKtic
         zZaWuZyc+kqBexD9ouOhi9QGBf1jNT8M7e3ynJfngl9LU6V135zaiHEhb6ZRhDR8guOK
         dehkj01VaptihcWAY90XZ+CcjPKWZY2Z8wZeHzyK7KM4+Ly9CICso46HbrwJ8wCRYT8b
         qDOHXPRkO2S4vJAkAT21QI67r5yI7gF71FeohSmzE4Xvida/6i4U+Hl98xJaMbQ3H+aQ
         RvgNi9F1pvLzsvPyze4+iIh1VzJ0IwqYTOJY76ouD1H/HW6XDBfAfLpM/+9XXHH4mfvE
         3YZg==
X-Forwarded-Encrypted: i=1; AJvYcCVJCaNFKjNd4ShuRIq8+MBe9n96xWsJP6T9yAYX8kaqhDzQljpw3H5yh87bonN+4VP5CISDT+6FQ7gukUBI/PUkdTFUkMWmiahtU4oP
X-Gm-Message-State: AOJu0YzYAPjO5Jq9Wa0x0ho6vwRfhNSkcQx9+YkFmowlsHETWSAm4Ner
	2owVJztarcYsZn01m642Z+F2+RzudpxySuQeK3MoCA8c/rxxhiRWuGnrvCflvhs=
X-Google-Smtp-Source: AGHT+IE3PWB4vp7hQvlJSx3urmU4rfs0pPx51QnRTdDTN53vA2sWV35QnnRTB7AdghQYP1+Oi6FfxA==
X-Received: by 2002:a17:906:b06:b0:a4e:7cab:9e76 with SMTP id u6-20020a1709060b0600b00a4e7cab9e76mr4093843ejg.33.1712136711088;
        Wed, 03 Apr 2024 02:31:51 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id u23-20020a170906125700b00a47522c193asm7546772eja.196.2024.04.03.02.31.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Apr 2024 02:31:50 -0700 (PDT)
Message-ID: <cb46f9bb-3ce9-4327-8019-4dd4346c715c@linaro.org>
Date: Wed, 3 Apr 2024 11:31:48 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/34] firmware: qcom_scm: mark qcom_scm_qseecom_allowlist
 as __maybe_unused
To: Arnd Bergmann <arnd@kernel.org>, linux-kernel@vger.kernel.org,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Maximilian Luz <luzmaximilian@gmail.com>,
 Johan Hovold <johan+linaro@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>,
 Guru Das Srinagesh <quic_gurus@quicinc.com>,
 Robert Marko <robimarko@gmail.com>, linux-arm-msm@vger.kernel.org
References: <20240403080702.3509288-1-arnd@kernel.org>
 <20240403080702.3509288-24-arnd@kernel.org>
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
In-Reply-To: <20240403080702.3509288-24-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/04/2024 10:06, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_OF is disabled, there is no reference to this variable:
> 
> drivers/firmware/qcom/qcom_scm.c:1655:34: error: unused variable 'qcom_scm_qseecom_allowlist' [-Werror,-Wunused-const-variable]
> static const struct of_device_id qcom_scm_qseecom_allowlist[] = {
> 
> Mark it as __maybe_unused to hide this warning.
> 
> Fixes: 00b1248606ba ("firmware: qcom_scm: Add support for Qualcomm Secure Execution Environment SCM interface")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---

I already fixed this and have an Ack:
https://lore.kernel.org/all/20231120185623.338608-1-krzysztof.kozlowski@linaro.org/

Can anyone pick up that one? Why these trivial and obvious fixes take so
much effort...

Just like Arnd, I keep fixing many little things which takes
considerable amount of time. This is not a problem. You know what is the
problem? Chasing maintainers, keeping track of my own patches, resending
and pinging. All this takes considerable amount of time which is a
*wasted* time which I could spend on developing new code. Then finding
out that Arnd spent his time to fix this again!

Same simple issue being fixed by two people. Considering effort spent on
tracking/resending patches (or even writing this stupid rant), simple
patch which should take 1h of developers time takes 3 or four times more!

Best regards,
Krzysztof


