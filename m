Return-Path: <linux-kernel+bounces-68682-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 255AF857E58
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 14:59:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A07F41F27DE8
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 13:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C99512C533;
	Fri, 16 Feb 2024 13:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JAX2HCzv"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5363012BF1D
	for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 13:59:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708091980; cv=none; b=brVhpJUyXkovRDYiw9sk7LmQ1vDfshhaAmCAPHXwla+6wVqm5HOYWvlK6yMcPW0e906+WihL69QHj8D7NTZ4ZMtuNWlyT8sUmR4GmitYDBesJa/RhXzng6NmTnGscq2cc1ciomT3eR+cG6LU4pY3vMcCxWxeV2w6p/cLkuFnabg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708091980; c=relaxed/simple;
	bh=nsn4WJyRYAoqJRBTL08AOljR5I6y9oPXYZMXhI3sWy8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=i/tZ6jSEFmHQmVyMKu/SI1WPfg3uRB1dinhBru6JGwm+Yn+Heyym8IpXh4bDTXOI0FLBN/dugoWDJyyauJPBYthvrZli7UFPvUXKQNPfmU/WR1m8b3ANBQMhmrhGNVUqMWJcx8p1jaAJmsq0JWCLRbTyedgj5H9YYIN8ppJNIvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JAX2HCzv; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-511a04c837bso2449947e87.0
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 05:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708091975; x=1708696775; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D71EMsChqgpWpjB7V99sJeSePiQX0x6TadQ9r4L5xnM=;
        b=JAX2HCzvMpgXCFxSvbEWfHeSHG/dTNpwzvKjjLs320eMrm8vpXlXmDOk9LRQ2HzFyv
         2BGtSjhiQWPZ7u3B8GKM1I2REQcr8tm+CWj45jeC/BmMUMXpzi2caVFc/2FC2K7kJJwM
         3unXqdQyMgYGB834zxLzh5/F2QrrwI7vLkH+m2KY9+sq0+uW5+qDIBP/TZQ+uXpgsr/b
         +Ac9z3D7B57Jg4elRjGcscFcVE9mRiTQomul8Jorl/tU1qNzl9VQE6gVmyE9lrypzz0s
         lCW+9rHLgvXJr/9Oyzo0f2SINUUHq/NkPlWI8eihIYMUpF8W/IlOxAbouKPhkRaSzdw1
         B9sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708091975; x=1708696775;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D71EMsChqgpWpjB7V99sJeSePiQX0x6TadQ9r4L5xnM=;
        b=BMZEBeqk0Ow4G3CQaOgiI6vBWaTM07K7yqwq1XzwA7qvimBdGJ0CVga7Vj4lxngsyu
         +iNZT16Owx0xIMyPzSdD2YImnmgp/U2zdz3fYLiMdPnGZgAE/HyKxkAHvIF4SSxbz90a
         fwEiJ13od+8ysxx5UxoLJmO6GHOA30gtpSDtBFZJAvan7p2Q9LfykC0b5ixvDT7aSMja
         JNyOle2hgN01qOQRIUaN50NQfCeSA3Gs6vUdb3XYpuMX7lXbqKLeB+TifSZLbveqSX1a
         y7VvWbibZkuePZpfs6tP0Fw+Hqy2tTH/ZNEOBXqdbGBk5MoT6stRXtEaUoF4vWNzghyX
         uDFA==
X-Forwarded-Encrypted: i=1; AJvYcCUn25BfO2r5gAVISXMzyVlxBVn6Lm7Zg7q5yXYKmvwP70YzBwwOSgnR3hfv+a3l4pmoE+klKBKFWBqjgRWu37MRMAiFpKncNIArDqh4
X-Gm-Message-State: AOJu0YzJyAi0McdPzNqQ1VagDJEpV2s7PjXjG3jAQ+hHHtCUpuJOvg/C
	yIr9HYEr1T2OK84aH8sVIEM/yP3UaYScdgx+NZW3fRg3zmOMbyoUomjt05cra1w=
X-Google-Smtp-Source: AGHT+IH4ptRMDqJC5CCka/JZVENyvQZCuvbn0+TGGHCLfiuBWb1kx7jW5WGPQuoncr9DcsPtbOvZdg==
X-Received: by 2002:a05:6512:1589:b0:511:a803:c952 with SMTP id bp9-20020a056512158900b00511a803c952mr4621043lfb.0.1708091975432;
        Fri, 16 Feb 2024 05:59:35 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id tj10-20020a170907c24a00b00a3dd52e7539sm644395ejc.60.2024.02.16.05.59.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 05:59:34 -0800 (PST)
Message-ID: <41e371f1-96f4-45c0-9f65-81ed6924b325@linaro.org>
Date: Fri, 16 Feb 2024 14:59:33 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] interconnect: constify of_phandle_args in xlate
Content-Language: en-US
To: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Linus Walleij <linus.walleij@linaro.org>, Bartosz Golaszewski
 <brgl@bgdev.pl>, Georgi Djakov <djakov@kernel.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Sylwester Nawrocki <s.nawrocki@samsung.com>,
 =?UTF-8?B?QXJ0dXIgxZp3aWdvxYQ=?= <a.swigon@samsung.com>,
 Alim Akhtar <alim.akhtar@samsung.com>,
 Thierry Reding <thierry.reding@gmail.com>,
 Jonathan Hunter <jonathanh@nvidia.com>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org
References: <20240216135236.129878-1-krzysztof.kozlowski@linaro.org>
 <488cc7dc-f45a-4c9e-b572-e4a6b3202e3e@linaro.org>
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
In-Reply-To: <488cc7dc-f45a-4c9e-b572-e4a6b3202e3e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2024 14:55, Konrad Dybcio wrote:
> On 16.02.2024 14:52, Krzysztof Kozlowski wrote:
>> The xlate callbacks are supposed to translate of_phandle_args to proper
>> provider without modifying the of_phandle_args.  Make the argument
>> pointer to const for code safety and readability.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> ---
>>  drivers/gpio/gpiolib-of.c              |  2 +-
>>  drivers/interconnect/core.c            |  4 ++--
>>  drivers/interconnect/qcom/icc-common.c |  3 ++-
>>  drivers/interconnect/qcom/icc-common.h |  3 ++-
>>  drivers/interconnect/samsung/exynos.c  |  2 +-
>>  drivers/memory/tegra/mc.c              |  2 +-
>>  drivers/memory/tegra/tegra124-emc.c    |  2 +-
>>  drivers/memory/tegra/tegra124.c        |  2 +-
>>  drivers/memory/tegra/tegra186-emc.c    |  2 +-
>>  drivers/memory/tegra/tegra20-emc.c     |  2 +-
>>  drivers/memory/tegra/tegra20.c         |  2 +-
>>  drivers/memory/tegra/tegra30-emc.c     |  2 +-
>>  drivers/memory/tegra/tegra30.c         |  2 +-
>>  include/linux/interconnect-provider.h  | 11 ++++++-----
>>  include/soc/tegra/mc.h                 |  7 ++++---
> 
> Ended up being a bit wider than just icc..
> 
> Looks sane apart from that

Tegra memory controllers are also interconnect providers, so two subsystems.

This patch should go via interconnect tree.

Best regards,
Krzysztof


