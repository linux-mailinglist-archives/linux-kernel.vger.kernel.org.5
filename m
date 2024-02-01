Return-Path: <linux-kernel+bounces-47790-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D55CF8452ED
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 09:41:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3BF94B281BE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 08:41:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74CE815A4B9;
	Thu,  1 Feb 2024 08:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yStJSx4p"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5DBB13DBB4
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 08:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706776864; cv=none; b=G7GRlijDcn9x2BUurm220N3SQHdkU4ZD4b5SZD9V3VgQUNq4Te7ERpsjnjcZkntngu9AVB3O60ltAAGOwrQ2BN1QnWXJHn3jGnN8kY+fYq+9xk1YlGqbFmq97TuL1uUBE9uP+OVJ5noPGP6mB+6xQ3V+krK0jlSHA105Bu8k92s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706776864; c=relaxed/simple;
	bh=umRIpvPyNH9O85vkk0z6XBfbYSF0D8Mx3qKu6sC3iIE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FOuyoJ665qNwLZPAXybJq4qti7yuMIPrhCWPOyq/t2ortm/lCivEvspUc6TrTDvsyWd6o8ATeCskCltRkrtdOestESO67xJthsXTcK1V7G7OB48P91nYCdnD8wfgQPJYmZeWT4Y/Xd9JiyDLLw2CJFCjVXMdY+aMtoR/76B0C0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=yStJSx4p; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a354fc17f24so77479766b.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 00:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706776861; x=1707381661; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0ouw3WtRTv8eNwYiY6iJNSF9tS/eZ1iXZdVr4vWPSSQ=;
        b=yStJSx4pdzvIy0DZ+o/ikjGh++ru65XXRKNH81RkNRmDHxvlS5z5zukbUub4XRSlJ+
         6hIyrbBfhVjS6ogSvGxQ2oQ5w67h3l6RN1cW85kfRGPNRVohTxiU2IOw6FjbTso2SERK
         LZKQx01bheM0zPvP1sUJWH/o9OIEIItTg0kJL7M7oyGNoxURjxEPfoHH/oHwY8hVJ3ZU
         ZwG+a+HTrqoZpRFnC8dyJ/mYqGd0R38+ZzFo59i7BOP3jfxlx1N82rj2Nc5Yew8t56lL
         Y2coTEjkBmTxe5JACk1AGtPPXI8J6cgCvI8DYjePBbijERjC9nL7C5sqlMz+Y/+rrSF6
         MTng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706776861; x=1707381661;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0ouw3WtRTv8eNwYiY6iJNSF9tS/eZ1iXZdVr4vWPSSQ=;
        b=vuVG7LYsAlW6L07Y3zK0+A6cusejL24CRMwfJ4UMaGi8pCXuPaGThoUGYV5sd7KTmo
         ehTi9qIDdzmFxtqeimp2QKSFfuAVyRjP/8z+rjiq4kT+nNY0iR5ovZVQL8IFbxdj28JL
         AeHa35d0OXXvT/j7p8j1dRU1yogE0PMPK/HQlPhXwSgkLp00f+cIfNz3Rl2OTuehe7WS
         gt1nwFZj09zrLLIwp6f27QZ0b7WEc2YN5m3RhwfDRNavOyXVOoQg1PTR7Wj5SGTOttwP
         49Fmn24kKJ/dbEMTESyVqgHZkcZhGdVhOldmmrn6G15ToB1f0RShyiTgNWyNBmD4Ue5F
         BIFg==
X-Gm-Message-State: AOJu0Yzyw7NRuEJ0JY3eOC/eC/sWtbV36sX1RV3G9F95fd2FVa6eUwAX
	yzCtO3aWYchPCiCxAX2rFEibFY2hoEKEi7sNp1P2KwKomT3K6FyMD4YGTUdaEVo=
X-Google-Smtp-Source: AGHT+IHEvYeMbKVPikbgqlwTeuhvAQcDFMvVMvcdmNOOHQlVStw7iOs2pJLA4NksV6mvzlLjlLgm4A==
X-Received: by 2002:a17:906:ad92:b0:a35:69c3:8af5 with SMTP id la18-20020a170906ad9200b00a3569c38af5mr1147719ejb.36.1706776860926;
        Thu, 01 Feb 2024 00:41:00 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUa1bCDhyMbt+fsGdfaL82UCwkfhxXDHdDefw2g//PZMMUxrC5PXmQsfOb5fAIG3/NE4DeaXKVlh1oE+iPb9U7+2zlgortAHjBm8o7FoRcqnDuOKH9FW9dQ0m8QanG+JK1k8ReimBMQNjeNnQQiRNeZZYA0O9ZREKqpnkmK9WY4jDVpGmj3Fyx3bKqqV8VQc80cuK8A4Y9kFOHWSivNTjrytvBivZvcux1vW3JbZB2POyzI2eYpDCeFKGBPH+PqAzKVfMX8J4rTABe8d9KsjM1GHKkaGgVEU+MurHxtYvxAVZPvxZtGw7WkKJTdf5495D1RHQeGnPoP
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id ll5-20020a170907190500b00a36c7a7b4f7sm234612ejc.207.2024.02.01.00.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 00:41:00 -0800 (PST)
Message-ID: <d2c0c5dd-e1a2-4607-9177-f3855cb5601e@linaro.org>
Date: Thu, 1 Feb 2024 09:40:58 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] regulator: dt-bindings: microchip,mcp16502: convert to
 YAML
Content-Language: en-US
To: Andrei Simion <andrei.simion@microchip.com>,
 krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org, conor+dt@kernel.org,
 claudiu.beznea@tuxon.dev, lgirdwood@gmail.com, broonie@kernel.org
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240131130727.447738-1-andrei.simion@microchip.com>
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
In-Reply-To: <20240131130727.447738-1-andrei.simion@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 31/01/2024 14:07, Andrei Simion wrote:
> Convert devicetree binding mcp16502-regulator.txt to YAML format.
> 
> Signed-off-by: Andrei Simion <andrei.simion@microchip.com>
> ---
> Changes v2 -> v3:
> - keep one line of regulators description
> - add additionalProperties: false for regulators
> - "description:" at the end for each properties
> 
> Changes v1 -> v2:
> - reverse subject prefixes
> - line break after file "description:"
> - drop description for reg
> - drop regulator-name
> - add regulator-initial-mode
> - unevaluatedProperties just after $ref: regulator.yaml#
> - additionalProperties  just before "required"

I missed it before, why did you move it? Previous placement was what we
expect. I did not comment about it.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


---

This is an automated instruction, just in case, because many review tags
are being ignored. If you know the process, you can skip it (please do
not feel offended by me posting it here - no bad intentions intended).
If you do not know the process, here is a short explanation:

Please add Acked-by/Reviewed-by/Tested-by tags when posting new
versions, under or above your Signed-off-by tag. Tag is "received", when
provided in a message replied to you on the mailing list. Tools like b4
can help here. However, there's no need to repost patches *only* to add
the tags. The upstream maintainer will do that for tags received on the
version they apply.

https://elixir.bootlin.com/linux/v6.5-rc3/source/Documentation/process/submitting-patches.rst#L577

Best regards,
Krzysztof


