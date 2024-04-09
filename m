Return-Path: <linux-kernel+bounces-136477-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EA6889D47A
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 10:35:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3EB19282134
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E926130A43;
	Tue,  9 Apr 2024 08:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="srs9Hpyk"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FBE27E591
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 08:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712651271; cv=none; b=Txg9vMU9ijnJpHG8Fl3cs2gj+P2Sn8rkvkyOTJvR+kVAi1mxCAxsGshHUQ3pg52cVNxwKwqUlxG3ei7aACCBsKa2U62nDoQCRRFuzRQOcmRXohONwFL6vm5Vo9dMcfFy+XWPbCItpvljKCUVUPXmynPxnHscRoHb8eA1T1MqSjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712651271; c=relaxed/simple;
	bh=ThxYTuWnIjROrsvIfsqbP8USRVfszGLqnVNSOTkj9Hk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Sfhy9G5baT/Y6T5oJJ+1MpycBvBzJYQtYzO0ZFmXTQe7sZXDGPdEgzhqUcEi+eDVobNVczAn0sQBxMc5S5JedWdIh7J2geSfReJ8mNEu0LLM8Pw+nZHQ8PFNTws+R9wDW7HNxJL7DDn3ObxFtEDi/Do0ehilVSGQM0e6LObgNIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=srs9Hpyk; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a47385a4379so1166316166b.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 01:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712651267; x=1713256067; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1hY3mD/N+ezYOSt5b+q4lZKBMQJtYzKundCKG+ygE0A=;
        b=srs9HpykNafbAjPnA+SJcihhimUW8mBOxQ2ScSbZB1+1okxw7NJvBts9g8umo2vTKL
         YROt57dBBioTGQtdpezG6r4EUtmRyemXjfLL3+dgIhXebs5CFWobQIJIBPiizy/N8d/W
         P0gqzX0+AZIKmnfLwp0ViKLzv48wbEDMuxMxfiqPX4PO4GWgi6CR8OtpMW+5LvDWqNK0
         9PAPyYY/R0HdUSSt0ZcV4FoFywLckB7cu5VJoseQkBgZ5oqLTlYBY4jwx91JdfkPg3xZ
         u73TcTTOD337BuJ8dQLsyFDNC8P2cC4hNwPqP0a1uZfmMcI6VxNsTdyAmBY/yyVe1EmG
         7lhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712651267; x=1713256067;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1hY3mD/N+ezYOSt5b+q4lZKBMQJtYzKundCKG+ygE0A=;
        b=fsclg/sk0lsb4j+seCrrWu+p2zddzh0fEPm8WJeZsgTDCXDvxSPkMyc48cqkBo999t
         r4dsDpHV+EnjSERmzEj1oA93BD9IYg3HrOqvhTXjtO3w7vJ2PnGw4BR4+UX2AjkWWOgg
         +mEdycHhLsL/l1rQy6P0yg8uiw7Af0iLKbx7iMlSvJ6EbJxBxSoV8RfJPp06FBdx2AhE
         V+s43CFIJ5z25AzcvpAMXi7cNm/ACNRwEtZBVunzjHjyJhyvlFcbuWwYPbuSNeUaVqX2
         WMHxy+Zh9Ds43tBWabduz+lzmkmgwM5nJuQDfW6K2mo7uPkk+hGJ9vzf1Ttf58I5+4aC
         Y6lw==
X-Forwarded-Encrypted: i=1; AJvYcCXwkSJvAoVE1R2ITMKI0tvez0q9RYd3poIKCJNJnt3bWtKJkvGoonJSg/sc31TWSnA+QZWAt8QiXfAIXmK0hdclYV/57jKMA3RGFO63
X-Gm-Message-State: AOJu0YxnkzIkgcA28s3mUfB1SGXoGDmuQ6nG8x3JwwMsE12c1aiNZc7z
	GK0PAeP4lZou8nL4E6nP76th6Y8FAQnImeKO7x2Z5BoDGznVgaM9xxUeL9w1D6YG+WG4ppm95p1
	o
X-Google-Smtp-Source: AGHT+IHB3JBHXp6mRDWOLskJLzBW7WW2Fz5xasNv8dUHchBogLoItvLbEMWQ+zcmtAvh6JmNLgq4Kg==
X-Received: by 2002:a17:906:37d2:b0:a51:e157:4dca with SMTP id o18-20020a17090637d200b00a51e1574dcamr1867427ejc.0.1712651266796;
        Tue, 09 Apr 2024 01:27:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id jg29-20020a170907971d00b00a518bcb41c1sm5356152ejc.126.2024.04.09.01.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 01:27:46 -0700 (PDT)
Message-ID: <a4a9f949-ecc7-4603-8c8b-90a1e309570a@linaro.org>
Date: Tue, 9 Apr 2024 10:27:44 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: power: supply: ltc3350-charger: Add
 bindings
To: Mike Looijmans <mike.looijmans@topic.nl>, linux-pm@vger.kernel.org
Cc: Conor Dooley <conor+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Rob Herring <robh@kernel.org>, Sebastian Reichel <sre@kernel.org>,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.3bc97c8f-843d-4e46-84f9-469b7ba2489d@emailsignatures365.codetwo.com>
 <20240408064905.20298-1-mike.looijmans@topic.nl>
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
In-Reply-To: <20240408064905.20298-1-mike.looijmans@topic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/04/2024 08:49, Mike Looijmans wrote:
> The LTC3350 is a backup power controller that can charge and monitor
> a series stack of one to four supercapacitors.
> 
> Signed-off-by: Mike Looijmans <mike.looijmans@topic.nl>
> ---
> 
>  .../bindings/power/supply/ltc3350.yaml        | 55 +++++++++++++++++++


Missing vendor prefix, use compatible as filename.

>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/power/supply/ltc3350.yaml
> 
> diff --git a/Documentation/devicetree/bindings/power/supply/ltc3350.yaml b/Documentation/devicetree/bindings/power/supply/ltc3350.yaml
> new file mode 100644
> index 000000000000..607a62fd25ba
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/power/supply/ltc3350.yaml
> @@ -0,0 +1,55 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +# Copyright (C) 2024 Topic Embedded Products
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/power/supply/ltc3350.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Linear Technology (Analog Devices) LTC3350 Supercap Charger
> +
> +maintainers:
> +  - Mike Looijmans <mike.looijmans@topic.nl>
> +
> +description: |
> +  The LTC3350 is a  High Current Supercapacitor Backup Controller and System

Just one space after 'a'.

> +  Monitor.
> +  Specifications about the charger can be found at:
> +    https://www.analog.com/en/products/ltc3350.html
> +
> +properties:
> +  compatible:
> +    enum:
> +      - lltc,ltc3350
> +
> +  reg:
> +    maxItems: 1
> +    description: I2C address of the charger.

Drop description, it is obvious.

> +
> +  lltc,rsnsc-micro-ohms:
> +    description: Capacitor charger sense resistor in microohm.
> +    minimum: 1000
> +
> +  lltc,rsnsi-micro-ohms:
> +    description: Input current sense resistor in microohm.
> +    minimum: 1000

Looks like it is shunt-resistor-micro-ohms. Unless it is something
different?

> +
> +required:
> +  - compatible
> +  - reg
> +  - lltc,rsnsc-micro-ohms
> +  - lltc,rsnsi-micro-ohms
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    i2c {
> +      #address-cells = <1>;
> +      #size-cells = <0>;
> +      charger: battery-charger@9 {
> +              compatible = "lltc,ltc3350";

Messed indentation. Keep it consistent.

Best regards,
Krzysztof


