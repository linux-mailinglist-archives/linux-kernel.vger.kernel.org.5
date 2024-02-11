Return-Path: <linux-kernel+bounces-60773-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BCCD5850944
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 13:46:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 47D221F21B1A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Feb 2024 12:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CCD559B45;
	Sun, 11 Feb 2024 12:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PT2WVs5l"
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD82A23761
	for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 12:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707655592; cv=none; b=ODxKQ/Avvn+vke1sTfBc9lYV+oMKAwbbbpXdwwNrmadpyrG4Yk5HQZjd/IOxU6ZgNPHBR1RYAW46rwRxtoSo11B0GPbVYmbtmtNy657oxkLdvZcHQ3flnA+7s07zF7fCUXFNkHm6Bj1/x0gmyhwtqh4F8KZaHVlO3kTupP3RnAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707655592; c=relaxed/simple;
	bh=VI+0SRVypq2HyI1O5SnaEoWk6lfEy8PO1nyerHcdjUk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JvvcQot8+aKIki1rBss+4RK6JD9ubS0zn3IwaN5FelnQC1FUV3uPWnxeE4Bceg6paiaPVOxg7V6oIhLDLD4qOnnbJRUfPnTDDmnCHx5gh/xB6Ba7pk2BQOIw4v5KsmhD/e7VwNrzsE39J+DxgAZS6ykUiIMPS8h0bj5WrcUYkGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=PT2WVs5l; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3394b892691so1500303f8f.1
        for <linux-kernel@vger.kernel.org>; Sun, 11 Feb 2024 04:46:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707655589; x=1708260389; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=z0nuXyLnGkRM+aE42c9HMhwu3xQ7zs2sqRHsDfqObl8=;
        b=PT2WVs5lGuPayPb0ee0sFBQZZAQR/PS8aj+d1lJPgYXp6ca3paz3QFqEqiTZuqwF8/
         PScagKCP6WiCaGQnF59t0aUIhyLIEpSvmxexU7yKzmaa7q47DqDrgL03PaMeChYAdLzG
         xITqmrPRuT/dsJO3oAj2Bwc9vr+Unt5etsaGO4O5aRumLlpE7qHF0qzIUlYAhBv2hyCO
         nValELiTyRwkE6fGxp9tChd+oYz+4Py7OPTLcQVDOjKduk4+6PaUWyLPOOhbSJPORnfF
         tyX6yKk8pfBBJOapsmFGCEm0v1dLY4Ea3+vQ8zFKmn4iyI8W3gvK7jP5mckqvKsFzOS5
         NnQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707655589; x=1708260389;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z0nuXyLnGkRM+aE42c9HMhwu3xQ7zs2sqRHsDfqObl8=;
        b=oEiQ9jDE3pxdQgJ38+I9mIh1A0FSPJKm7Odruufu64RuKBUqbvtV5BFmnUAAIxuG/N
         VyzkYlFKdD6a8uHvYV2EOBhjudjAKax6Mhhk6WH2YfgjOy27r/Q07ULIwLmKPmf3hZvt
         NF+KhaYzunsob/VxExw3AHBWxrdTQbq7inPydoA5hwefU9J6fAH+MglGAMT2J++4uuNP
         Oa5vtZPt4WIMTlVwbCSEJFjIoaIGOCXjI2tGPncPEj7AY3iY5ldUyDgrFyZD4HQ2qdYg
         6QzP3W4HBV5LRoVpkq+CkU++fGrcJ/84a6dnQwd5hYiK6TGlWWC1pzRYrp7kZ8BQkhgy
         LxfQ==
X-Forwarded-Encrypted: i=1; AJvYcCWsYco9g1QyQjnTsqMwD05Q/O++M9jJoLh0Rb0iAMieZojAUhrvYc47KivZvSpUE+TMUDGPsdCaFS5VCCzUcT7z2XKxWPsaNqa8eUIG
X-Gm-Message-State: AOJu0Yy0OhyEnbY2PNEV6RwGR0eQaaxv3xct8al4z43w3xreckcNjRUk
	U4/yPuOK/fwI/B7vhBgVpDzppaXjURG28zIJ/cq7dUAXVGoVR4ayaLeCKq5Wk1Y=
X-Google-Smtp-Source: AGHT+IHc30rIQzrJeRx1I1zG/F6xmVeTCNa5yGXUDdCcyUBME0PByW8GR29oUQCgOqKDRr2yO/RVQQ==
X-Received: by 2002:adf:a39d:0:b0:33b:1b10:7ea3 with SMTP id l29-20020adfa39d000000b0033b1b107ea3mr3394857wrb.9.1707655589014;
        Sun, 11 Feb 2024 04:46:29 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUJehZhZ2OoRyGPn9yMYdawia/a5igtcb4HzsTDEVn8pkj5Y+j9fNk0pzD0j/H/WifrnZNdwu00/yLUPJaJFjarLM7ttvwea3iTXCZG5hXPMI+XTFhUFksiDs56pFrfBllub5iZX1w8dpWnDdrAe2vSUwvDzZeqy4XFPcxncnG51WRcAQsK/D/u7dbRZx+FPhAh6mykdKB4aL698l4Prw+iMx6nQaxkcM12uPN+Q4HNZIn1fWjiDMjw2dMHqhfB/VX499YLq76zGb1s+Wu374RBm6RC8oZF+dVeetVANUUPxcAdYQfStmzQ/qFsE2zQEJBYEl3lk1q34n5jsRU46S2OdmPa4NHDoJ+LuarmETjnErYloIM9sTv13GpZbRXxKPbtzFIo47XEMEYS9cq4uXTXWsWUvC7xByK31yPT2hQovhWhhn9gblvFkkw7/1Uqm0RtJf3DWolrdYDrqEDBvSUW7EcviicEjBKarDexzsTz56hrUrrdieQWcyvSOxzo2fzkV1Rt+hBaPaBRG949/Q==
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id a14-20020adff7ce000000b0033b2276e71csm4192345wrq.62.2024.02.11.04.46.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Feb 2024 04:46:28 -0800 (PST)
Message-ID: <2c2d8bee-e9c6-45db-a166-d344f7890e06@linaro.org>
Date: Sun, 11 Feb 2024 13:46:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 04/14] dt-bindings: input: touchscreen: fsl,imx6ul-tsc
 convert to YAML
Content-Language: en-US
To: Sebastian Reichel <sre@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Shawn Guo <shawnguo@kernel.org>,
 Sascha Hauer <s.hauer@pengutronix.de>, Fabio Estevam <festevam@gmail.com>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 NXP Linux Team <linux-imx@nxp.com>
Cc: Dong Aisheng <aisheng.dong@nxp.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Dmitry Torokhov <dmitry.torokhov@gmail.com>, Mark Brown
 <broonie@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240210012114.489102-1-sre@kernel.org>
 <20240210012114.489102-5-sre@kernel.org>
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
In-Reply-To: <20240210012114.489102-5-sre@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/02/2024 02:18, Sebastian Reichel wrote:
> Convert the i.MX6UL touchscreen DT binding to YAML.
> 
> Signed-off-by: Sebastian Reichel <sre@kernel.org>
> ---

..

> +
> +  interrupts:
> +    items:
> +      - description: touch controller address
> +      - description: ADC2 address
> +
> +  clocks:
> +    maxItems: 2
> +
> +  clock-names:
> +    items:
> +      - const: tsc
> +      - const: adc
> +
> +  xnur-gpio:

xnur-gpios:

Also you need:
maxItems: 1

> +    description:
> +      The X- gpio this controller connect to. This xnur-gpio returns to
> +      low once the finger leave the touch screen (The last touch event
> +      the touch controller capture).
> +
> +  measure-delay-time:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The value of measure delay time. Before X-axis or Y-axis measurement,
> +      the screen need some time before even potential distribution ready.
> +    default: 0xffff
> +    minimum: 0
> +    maximum: 0xffffff

Time seems like something humans can grasp, so why using hexadecimal
numbers? Same question for pre-charge-time.


> +
> +  pre-charge-time:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      The touch screen need some time to precharge.
> +    default: 0xfff
> +    minimum: 0
> +    maximum: 0xffffffff
> +
> +  touchscreen-average-samples:
> +    description: Number of data samples which are averaged for each read.

This should fail the testing - judging by Rob's reports, you did not
test it. You don't have type for this property. Missing allOf: to
touchscreen.

> +    enum: [ 1, 4, 8, 16, 32 ]
> +
> +required:
> +  - compatible
> +  - reg
> +  - interrupts
> +  - clocks
> +  - clock-names
> +  - xnur-gpio
> +


allOf: with $ref to touchscreen.

> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/interrupt-controller/arm-gic.h>
> +    #include <dt-bindings/clock/imx6ul-clock.h>
> +    #include <dt-bindings/gpio/gpio.h>
> +    tsc: tsc@2040000 {

Drop label and just "touchscreen@2040000"


Best regards,
Krzysztof


