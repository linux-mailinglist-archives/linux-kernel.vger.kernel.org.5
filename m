Return-Path: <linux-kernel+bounces-44608-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B2D518424FC
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 13:34:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3DD1F26F65
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Jan 2024 12:34:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019A46A006;
	Tue, 30 Jan 2024 12:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nfOtJwPm"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19DA46A018
	for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 12:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706618056; cv=none; b=OD4hjakSsz+LtvKlBoZl1MdjBNj0A8leb0nRPdQDVN70TbkAdWRW1968apwwz3w44sA8wd5p1GonrpZ7lm/bn+h+SofvRNCah+cMVK7oH0X+XiJyQNMZvc7p+XCzokZrH5FiIZx1Pjg5ZWaMi/bLpJduc4tZLE1YZ18AiB4DAjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706618056; c=relaxed/simple;
	bh=7sqNd76pq3reMpBKDdu1mJSEYiMR3Y6iEp0a0zT1Pvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZI8hyORClMbH1eV3Ve+Xb/yLfXnYWCaANK+OtohM42encT3uNLmXEiJ6sESUbahzhFpUgp5OBOKEObDowi7JuUC2GyD5Z9h+Q1Fe2zXGB63x6R6CBLz2ABURJ6KynKaDm4bYrwB7tSggy4XWxaUJetz9zaps6avpjNTNpECB/Ls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nfOtJwPm; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a35385da5bbso473912966b.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Jan 2024 04:34:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706618052; x=1707222852; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MHQ3pnv0wAh+xN/qHc64cUVCTkn/qXer3T0a5F6JrZo=;
        b=nfOtJwPmwGZNnwmZzDpAtwt45y30y/46Y6zy/oG5Eu47EUIUsFdlz6YBqiWnFrpc6n
         JRxUbsOGWsg3wDR/h4NdShSXvB9aQx/4j2jTJfOxeIIpDep4+Z4FIx7TpZ4vbHxTfmQZ
         PnyGiZK41uRDNMyeOtP0vvBxgNqD52PiyQx8xtBP16F5EsrkxcyjxeX31cGJvVJ3LpP8
         iT8728mMF3Ewf9LWHWeaLrxdoJpFa+6Ok4VSXy5k1KyFWehKmIhZMAfmR7h03tod4bjv
         Yc2CtzrDp6uRT63y30JgO5YEBvKMJYZprvyEw5jkHSCHJO81svYG6UDdi7p9GniJZXZC
         KwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706618052; x=1707222852;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MHQ3pnv0wAh+xN/qHc64cUVCTkn/qXer3T0a5F6JrZo=;
        b=ZyOe/V17VheWy6O/hKR6AljwpieYHoNHfqWyRdr3ZI6m/D84hHXKrkWZgKUugqlbFY
         5bMkVYmN3dYcsGey5N4wj5tvoVLLm1uRWS20MN4w05E2PjlwKMp9CZJtH6BJQDukZFiw
         kCUwStQ6rSMeZFO3bIdmdDOeXs7kB4/p8dnzxr/EK6o0lHbA5/UVfMABDLtapIgkCpJJ
         p1y3VnFzJzi2sp+a6ZvpVEjI9wKxkeiXmVRxaY0qNMsPC5AGEeyzDBtC0BTi9gE9bMmy
         0oh+NXqMBzi1eYU5jP3rIj1toHTb/Uo4kCsZjsEkKMDknx1Ona2mL8QbfFgL6EQxM3Fg
         x2SQ==
X-Gm-Message-State: AOJu0Yw65+DTo5YAuF+5VJZslFtWrsNNnOZxdfSKiEBLelIUMNtnlGdC
	FjNHXgG9Z1bDhyVJuINeX0VPO8e5p1KrABD+3JT+zkK19sP+ORZn6W6/OY9+2qI=
X-Google-Smtp-Source: AGHT+IGuOuwrOslv6LcI8W+lbVXnzAUjSBbJdMn6JRCAB8TGJGQ6b8Knxbp6sFlJVP1u5cT3iGnIJA==
X-Received: by 2002:a17:906:6d44:b0:a35:4664:8830 with SMTP id a4-20020a1709066d4400b00a3546648830mr5780431ejt.0.1706618052262;
        Tue, 30 Jan 2024 04:34:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCWGJkYLYm4+Mj//wJAtjMTopfESkWs3TcXiPPDyfk/mBB3X9AK5H8CvYBWYVJJkwyFNYKVOLzzWbZv7QuPdXuDsmrv0mTH2NGbE2YkOZh6JRgguZyAvfqGRottXI16/YMMDkYcnzE6X068vSRusvZsGLJzmgHPoUwcnnFTCRh0Bggw+RsrCcsquu5GnLh5jrHvBj66R7u6Q1KLDXIBk1I/z2pxnVBWzVtl40+/XVah48ih4C4kUv5RNZQ45TjYcLwrUaDTE+1Ztp7uUylac+rveYc5yHrOLPDN4tQB+y1n6/1ubGQWLkami9z+U99mQpJrFZ2HRF/nDyPyLzcsdsxat8ifZa6iohC2q78Xqj0HyVHOacFgh+5RyYjTmpF5ydPXg30gAgxk=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id rs28-20020a170907037c00b00a2ceaf80bcbsm5052347ejb.204.2024.01.30.04.34.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Jan 2024 04:34:11 -0800 (PST)
Message-ID: <ceb75d84-3e6f-40cd-97cb-ee6ccb14e7a6@linaro.org>
Date: Tue, 30 Jan 2024 13:34:10 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] ASoC: dt-bindings: xmos,xvf3500: add XMOS XVF3500
 voice processor
Content-Language: en-US
To: Javier Carrasco <javier.carrasco@wolfvision.net>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Matthias Kaehlcke <mka@chromium.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-sound@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
References: <20240130-onboard_xvf3500-v1-0-51b5398406cb@wolfvision.net>
 <20240130-onboard_xvf3500-v1-1-51b5398406cb@wolfvision.net>
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
In-Reply-To: <20240130-onboard_xvf3500-v1-1-51b5398406cb@wolfvision.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/01/2024 13:26, Javier Carrasco wrote:
> The XMOS XVF3500 VocalFusion Voice Processor[1] is a low-latency, 32-bit
> multicore controller for voice processing.
> 
> Add new bindings to define the device properties.
> 
> [1] https://www.xmos.com/xvf3500/
> 
> Signed-off-by: Javier Carrasco <javier.carrasco@wolfvision.net>
> ---

This should be v2. Also, please provide changelog either here or in
cover letter.

>  .../devicetree/bindings/sound/xmos,xvf3500.yaml    | 51 ++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml b/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml
> new file mode 100644
> index 000000000000..d7d5bda23b1b
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/xmos,xvf3500.yaml
> @@ -0,0 +1,51 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/xmos,xvf3500.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: XMOS XVF3500 VocalFusion Voice Processor
> +
> +maintainers:
> +  - Javier Carrasco <javier.carrasco@wolfvision.net>
> +
> +description:
> +  The XMOS XVF3500 VocalFusion Voice Processor is a low-latency, 32-bit
> +  multicore controller for voice processing.
> +  https://www.xmos.com/xvf3500/
> +
> +properties:
> +  compatible:
> +    const: usb20b1,0013
> +
> +  reset-gpios:
> +    maxItems: 1
> +
> +  vdd-supply:
> +    description:
> +      Regulator for the 1V0 supply.
> +
> +  vdd2-supply:
> +    description:
> +      Regulator for the 3V3 supply.
> +
> +required:
> +  - compatible
> +  - reset-gpios
> +  - vdd-supply
> +  - vdd2-supply
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    xvf3500 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Previous version had different code here, so I don't understand why this
became model number.

Best regards,
Krzysztof


