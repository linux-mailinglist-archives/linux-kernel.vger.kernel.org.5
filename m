Return-Path: <linux-kernel+bounces-36515-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AF7D83A229
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 07:40:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B886B24133
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 06:40:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 415F1FBEE;
	Wed, 24 Jan 2024 06:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CAGUEqA5"
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C95D275
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 06:40:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706078440; cv=none; b=KivKldMdkmsahAnhGLZy4ae9KQsJDJi2dDM0qp2jbYPCsOws9E6SawAcIIFeQkuZ0bosK/0BFLrsy5jlc4ep4kJhNlyawRx+B5gO9rCE8+oGQMJUpfjeNnHAzvMxC4wJIMwJ1rQOvaP0boUwNI/tOX/Gq5zUVdsMnMJo3NRTZzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706078440; c=relaxed/simple;
	bh=TCM9EKOHZ1A+j+dV4+sPQt4dAd22tkksnqAPnUD8NDU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hsP8NFWUry94JMqtQsv1v2FtaRyIV75v84zQsnrh9cB1/GRmAwnCMZZlYaA+tpNyeD/WedUfnAc/twxLldbI9rW5g6jIJhVuXjPAcKeI5c8/5K2PDYsUMgcOxTCwqwJvbK2ZY2JUgVDsSN2EZqQX3K5IOYeqtUaN6ZwpovkRn4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CAGUEqA5; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-40eb033c1b0so29601825e9.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 22:40:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706078437; x=1706683237; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=44msgdfsDi9KgcHt0rb9Du97WTo6b/GmEsSOMdomPKo=;
        b=CAGUEqA5UlYvX8KmKYvtKZ5XIjsmG5uclFffO1LQ3z0O9PjtKYEVCUBHRlTjnEXf8b
         yemC032VmXNm4XluEVhFphZCaUGkYKIHgp5+Gnzlo03djmQjkcR7tPgjigOPJvmg9heK
         b83XSg7FI+ymmQtugOryhdAn7x0W3WvOt7jIzzuci6y4jPLfZrZB3EOmQiSFSG1lkDkz
         kM7QzzN/GtJ/MkeTmEMT9zope7QlZqpGDz2mKRNaJBMb0xqm/PFgGhgcZKDivmTWKzUN
         +IIMrWMQ2SfL+18IlaLT4b/bTzZGGhMTlSeHj3iBTJsuSUdZlya3D3z9i40Yo03+2qrA
         5YfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706078437; x=1706683237;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=44msgdfsDi9KgcHt0rb9Du97WTo6b/GmEsSOMdomPKo=;
        b=MX+pEASNOMl6dIau8TGWakFhKL+rh1xrxVJs3zJkPj7tGvM3HFaKfdD9l7xC2Hdtlo
         8HGbzHknp9b0Abwlhqcak6lkt6LG4lLGuhGowdk2inuxyryZvICKm90PTSveCA/cuWLv
         aQ8hmftJ6GretA0DCXeNYmEIicP2ilp0rigAJoWQvL4pj756rR+s4B63h40Nq0OokpYn
         xgZF01g4u8m5j7wwVePfYlKAQI3/qHj5g7BQpjx55Ciu6fGTxQdDcP/U28QPjm9yEmgO
         JC+DrUWo8MkJU4IaS0uTqaYLZMdFMgkWE5LZ6pSCeqZtMvpuWz47x9JSiVO4ZrLLIcYK
         vIWQ==
X-Gm-Message-State: AOJu0YxwPAhn01qtxN856+q8G5smEol1PWslxfNaWCFKT/xlZsIUL4wC
	RwRwi/AkDpX2ctBMbi0Zjh14txO0ff/t6rHZK1GdghZIIVZTnHXWyf2Zy7Srhh8=
X-Google-Smtp-Source: AGHT+IGYp9JbaBGyUwFSgkFY+sspFNf3t3SULzbNXf82pEYGIRFJ6X7UUJFDilMVTFgSZNZRsGYWYw==
X-Received: by 2002:a05:600c:4487:b0:40e:6703:8a46 with SMTP id e7-20020a05600c448700b0040e67038a46mr850503wmo.142.1706078437240;
        Tue, 23 Jan 2024 22:40:37 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id bw12-20020a0560001f8c00b00337cef427f8sm15589455wrb.70.2024.01.23.22.40.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Jan 2024 22:40:36 -0800 (PST)
Message-ID: <35789ed3-ca17-4de0-bb4f-85f44fa9e25f@linaro.org>
Date: Wed, 24 Jan 2024 07:40:35 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2 v2] dt-bindings: pwm: Add AXI PWM generator
Content-Language: en-US
To: Trevor Gamblin <tgamblin@baylibre.com>, linux-pwm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, u.kleine-koenig@pengutronix.de,
 michael.hennerich@analog.com, nuno.sa@analog.com,
 devicetree@vger.kernel.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 Drew Fustini <dfustini@baylibre.com>
References: <20240123220515.279439-1-tgamblin@baylibre.com>
 <20240123220515.279439-2-tgamblin@baylibre.com>
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
In-Reply-To: <20240123220515.279439-2-tgamblin@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2024 23:05, Trevor Gamblin wrote:
> From: Drew Fustini <dfustini@baylibre.com>
> 
> Add Analog Devices AXI PWM generator.
> 
> Link: https://wiki.analog.com/resources/fpga/docs/axi_pwm_gen
> Signed-off-by: Drew Fustini <dfustini@baylibre.com>
> Co-developed-by: Trevor Gamblin <tgamblin@baylibre.com>
> Signed-off-by: Trevor Gamblin <tgamblin@baylibre.com>
> 
> ---
> v2 changes:
> * Address feedback for driver and device tree in v1:
>   * Relocate "unevaluatedProperties" in device tree binding
>   * Remove redundant "bindings for" in description
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


