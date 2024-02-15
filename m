Return-Path: <linux-kernel+bounces-66412-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E51855C5F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4704828DB19
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:23:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDA9D1B95A;
	Thu, 15 Feb 2024 08:21:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fb+ADIvM"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 520D9BA37
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:21:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985275; cv=none; b=al9I1HbP25DBKa08bEN6HDreKvbbtjdPeKx0GEr22S1hutmN5B8WT+E2G6iepz/2ZlwVqsUw1gPmne01ayLC9FiMyDx0+UJuKtW4Apg+ivY4FrTsbJH1a5bTGkyfvVJSw/NjU4+FwEWxM/lRcmh8DwBQC9wJzC2F169n+qkImEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985275; c=relaxed/simple;
	bh=p0rW9PHSjls5IMBOSFlbxJHTFDsIja4DXqJ0rRyATWA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jkzPkIDxO/JMosDqGWQLoIz/HfjebfnWyMu+0r8vL2vzr4biZPl/w8CTjr/X67WFQZbY5Cttnx8Ojd08cLVbE6gHiLPY4vMzyDrMvLka6zqmmPxAwJeIYcitkt+fCAKkt6mFWw9Pk472kEM7BBny249RZfP9mhd5CPBY9nldQoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fb+ADIvM; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-563bb51c36eso211189a12.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:21:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707985271; x=1708590071; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QvT/wcQc5j++kaaqRgB4CtTRwkDywujES22YaF5pKPM=;
        b=Fb+ADIvMIt6tEOBvhs57VHE9vQuSc7HWS2nBez6XNVSJXqSxFBYIlDwh+qteF5sKlF
         9M8vzZbljQyh+Zpm+zq7QvkcpPA0QykIuukr5Wgtq4FjEB/fhy3jfkdlH3obezHEYQIA
         HKp4zzBYy/dA4v9StHuHKcJY+0NDlX1WeJnyct+Oy8XKljHjAYf8IcBBU4aD1ZS2p2jv
         k0/kBUro9AF/NSp0Yu0CA2dVv23SgJknROMTQEeIw7l1cxY8QVhPbq/GJxYywM7uACUC
         pfYMl52VovYAbfwYzcYP18JkS5A2ad04a5uk6F6aQHrLOiRR1Ttwl0WeBhyQ+YvGMkUv
         nGBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707985271; x=1708590071;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QvT/wcQc5j++kaaqRgB4CtTRwkDywujES22YaF5pKPM=;
        b=jXMOJ8/luvPjyu4if3Ulb+eIQWR3rfLBdMJW0bMPzBK4eoT2oMuXMDplQvN8cg+ZvW
         bKabXM6DJv3WfMYjDyQYHvVo7WO3dhaomq64YkRYWq7KKpEmxXMyhsPHzmAY87504xz5
         Uc2H986GmghOf1hcojhmluoaUZ2vDFjbrTMIMssjG+3wO9Rc/34MDusAJHzE35im6U6D
         8lLIsNSlSbcHcvAtVNxcTZLSdDEIW79mJACGCZTAJsCpyYUz2AY9GS+qzl1AhuwU/idm
         rvD74Sl1Fg2enPtCLMalGK2teXnVbnFBiw8DeC4ufhoqYhC1EdjlKDzkqh8rl2r1T3nh
         pk5g==
X-Forwarded-Encrypted: i=1; AJvYcCVZOOhWcQWY887gMA1uZhtTSIqGivSeSSOqR+K9SH4EN8Qvc3E2nGXXwEZUNNuLWNUNiqal4CABb/akmywQ5jVhNEMJVDhF6FBFYkIq
X-Gm-Message-State: AOJu0Yzl2CAFIE+Yk+9yAXJyi35oqlJ6susU69hrCGKZtrppxKCVNZ4N
	cO9mgcJ3RhN94OQm62Hz2zMgv05aPnO5OaAfNh2bV9NErKGI6YdEEyxjFz8juRs=
X-Google-Smtp-Source: AGHT+IFlDzBvcBLha/q5mXvwtJ3F3GH7APScXRBIR+Jqt+zAVCMF0GCuPOg6q9mbFUg69ane1ipUyw==
X-Received: by 2002:aa7:c88e:0:b0:560:3a3:0 with SMTP id p14-20020aa7c88e000000b0056003a30000mr951071eds.30.1707985271538;
        Thu, 15 Feb 2024 00:21:11 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id v12-20020aa7d64c000000b00562156c563esm316898edr.33.2024.02.15.00.21.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 00:21:11 -0800 (PST)
Message-ID: <fc325835-6fcb-4fac-b907-93a95d8d6d7d@linaro.org>
Date: Thu, 15 Feb 2024 09:21:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 14/15] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Robin van der Gracht
 <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>
References: <20240212170423.2860895-1-andriy.shevchenko@linux.intel.com>
 <20240212170423.2860895-15-andriy.shevchenko@linux.intel.com>
 <ZcpSDOk-IQVasHud@smile.fi.intel.com> <ZcpSaHW-RQ3dzywP@smile.fi.intel.com>
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
In-Reply-To: <ZcpSaHW-RQ3dzywP@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 18:16, Andy Shevchenko wrote:
> On Mon, Feb 12, 2024 at 07:14:53PM +0200, Andy Shevchenko wrote:
>> On Mon, Feb 12, 2024 at 07:01:47PM +0200, Andy Shevchenko wrote:
>>> Add initial device tree documentation for Maxim MAX6958/6959.
>>
>> Oh, this is an old version :-(
> 
> Here is a new one:
> 
> From d8c826e06cf9237cd5fc6b2bb0b1cac5aff4fd8a Mon Sep 17 00:00:00 2001
> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> Date: Thu, 8 Feb 2024 17:23:38 +0200
> Subject: [PATCH 1/1] dt-bindings: auxdisplay: Add Maxim MAX6958/6959
> 
> Add initial device tree documentation for Maxim MAX6958/6959.
> 

Anyway you need to send the new version to the list, so the bot will
test it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


