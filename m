Return-Path: <linux-kernel+bounces-8760-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D4FD581BBE0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 17:22:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F0E771C24ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 16:22:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F6755E7B;
	Thu, 21 Dec 2023 16:22:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sF5pEYQz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com [209.85.208.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C56D55E56
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 16:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2cb21afa6c1so12833121fa.0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 08:22:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1703175746; x=1703780546; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VjZrOu1vNy6ETyMv+NRF/EhX3hI9S08Tn7D6q6+ilbE=;
        b=sF5pEYQznktHnD11Rbw5ZeKT24rdzfdBLlbRYxH0Ku3XLehdSNPjRVq1IEdk4dw5qO
         7Xs0QMP9+2vMao8oqO/UcpsPM5/VLDs59XWtF6y2XAY2+NpD06GsD0y8svZ/0n9sBJap
         TGnKvYjegUDDbuLlXq8yLrzlV2pBXHm3Ps8R6NSSTWb80uvUu79n81g2EWdb7kyg5FIz
         ROn42wM/x9qZBJJsReerzQfZqbsoJgexHQMTp6lowQ4vX/zPz+4TnoOqFaoZXgdQecri
         wFAdpWm3oj37Tc/9ZW9hvhKZUYYU5Bdwruub0CZM1FMj16CuTQne90llG4Omq549bohh
         Jvew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703175746; x=1703780546;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VjZrOu1vNy6ETyMv+NRF/EhX3hI9S08Tn7D6q6+ilbE=;
        b=wRAXjhDZSwRq1l9+g9BGEf+VDNqohDopc6E/r2kEfKPsMzWAEfsAzgNcGZTjkHqD3N
         xY+LW40r15JYwYlqn0A+kEqpWPa/KQNJSbWkTKwTLad3MCrqOb4uP+BkCRfJqYSlO/vi
         VnJVxa0UN4HLyRl/dpBBO4EXrE7EpI8F9H7OKWlMzAo0XeX/MyO+Jox/NzLQ+6I4qsCa
         q1CHpPkgKYENxBRWhE92pYPi5emMRmgsi0L0jFjGoMpTG/38EINK0P55fMKHVcJ3BgTA
         UD22AIyXnhEcPSmOoNty485lWhL2G+XPdde6Ii+hX2HAgysgj1jmx02j7mlSgssfcVTD
         KQCQ==
X-Gm-Message-State: AOJu0YwQTih15xvzD50a8lCdgp5rC7IUuvQ+JJyw1fEeZMuLUs+Gyjsb
	enp9RFRNCduCJX089JDZHuGMjQ==
X-Google-Smtp-Source: AGHT+IFoA3k+Gf7BVhk0WsuCRWcAwD+M66ow89F4MDHhJB54KvoTpdZvgc9+9G0jxR/9RK3LQBA7Pw==
X-Received: by 2002:a2e:97d2:0:b0:2cc:a583:e0b6 with SMTP id m18-20020a2e97d2000000b002cca583e0b6mr273376ljj.82.1703175745685;
        Thu, 21 Dec 2023 08:22:25 -0800 (PST)
Received: from [192.168.0.22] ([78.10.206.178])
        by smtp.gmail.com with ESMTPSA id j13-20020a170906254d00b009fea232316bsm1109245ejb.193.2023.12.21.08.22.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Dec 2023 08:22:25 -0800 (PST)
Message-ID: <2c54c808-fa46-48fe-82d4-7628f5c799c5@linaro.org>
Date: Thu, 21 Dec 2023 17:22:24 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 4/7] dt-bindings: reserved-memory: Support osdump
 module
Content-Language: en-US
To: Ruipeng Qi <ruipengqi7@gmail.com>, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: qiruipeng@lixiang.com, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20231221133158.729-1-ruipengqi7@gmail.com>
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
In-Reply-To: <20231221133158.729-1-ruipengqi7@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/12/2023 14:31, Ruipeng Qi wrote:
> From: qiruipeng <qiruipeng@lixiang.com>
> 
> Add bindings to allow osdump module to store dump in reserved-memory
> region named "osdump".
> 
> Signed-off-by: qiruipeng <qiruipeng@lixiang.com>

I have some doubts whether you used your name or just email address as
name...

> ---
>  .../bindings/reserved-memory/osdump.yaml      | 45 +++++++++++++++++++
>  1 file changed, 45 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/reserved-memory/osdump.yaml
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/osdump.yaml b/Documentation/devicetree/bindings/reserved-memory/osdump.yaml
> new file mode 100644
> index 000000000000..149bf0204e68
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/reserved-memory/osdump.yaml
> @@ -0,0 +1,45 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/reserved-memory/osdump.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: OS minidump module
> +
> +description: |
> +  Specifies that the reserved memory region can be used for OS minidump
> +  module.

I don't see any explanation why this is needed and what you are
describing here. Use simply reserved memory.

If you need any osdump, then work with minidump series. Some time ago we
were asking people to come with their needs. I did not get any other
series, so no clue what you are doing, but just in case:
NAK for second "minidump" clone.


Best regards,
Krzysztof


