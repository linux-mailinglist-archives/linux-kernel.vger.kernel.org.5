Return-Path: <linux-kernel+bounces-105502-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F00387DF64
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 19:53:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA0601F2129E
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Mar 2024 18:53:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A526F1D551;
	Sun, 17 Mar 2024 18:53:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L8Rid+Cv"
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDB5E1CF80
	for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 18:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710701621; cv=none; b=I00ks9KFHhku5ksipqrgkk2//HIPJAZcxgnpWRdNyFdPt0HBMfOVwl/9cgTayb2kh9R6zCcBInSwt5PNTzxHXU78quS501oCsIPtgfMSffivASHqBhDeBYSz4f2AUdaNjfmnk5id0xh06pkepIdKsuX8z4gd1vjoOfYK507G03U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710701621; c=relaxed/simple;
	bh=QbW1/yPgavwKBKIwn25YB1xvwzU5TY0oSwg7PdgGuoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PBDUnq7HrPZ9KMsyjPjCvsJb97IEVlHjlAtGrOMX17xaXEuqTeiGcmF1kOhNHrzPcaUQoaArjw6kT/1VVkygNn8enC7M5O4QA2H/jfpKxFoWrOJJZr/FO++VzVvKdnW9hoDyfczGt8Yef86B4pkKsRnoXdwkrsh/STWsc+uRZt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=L8Rid+Cv; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a44665605f3so403030666b.2
        for <linux-kernel@vger.kernel.org>; Sun, 17 Mar 2024 11:53:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710701618; x=1711306418; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KBdAvz6eCK2ZQJ5K3dkyN1YHXiIV5pwGENdhV0W8wZk=;
        b=L8Rid+CvqE6nHSq3YsJ9ajFOaGhyQ66VmUxgkxBa7bfVL8uUxG7uCEzr2VNjn6Wmdn
         Rmw5YwxbLvPhnRPcXUJ+mBUhbSwFRqqDR2rKAUg918WaLIl7UEmhAbBjzHLZgIjZohzE
         rcC/nbROZcVui8qe4q4PlmA6cim7fd36ABrPfclkKoapR4zkLZw+14tuz5rMdM3lF3Ob
         aiiVlmHIltqlV9m/TJLNgePcexG5rOKtvxsolp4HaR6CBkJFUujkjPncAMNwJ7+ZkH6E
         ihk+1zQDyd7JjHg/nfwtvd2b+D4RDl1RQCkeDZfOnVtsxzeemLUbXpe/WvSsNzBV6LtB
         9+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710701618; x=1711306418;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KBdAvz6eCK2ZQJ5K3dkyN1YHXiIV5pwGENdhV0W8wZk=;
        b=RSHslGknWbOK2aAcdY1M8LGaT73trROFcKhpvFOB23dDRYENBv10uXCYbmPBzIdudt
         4ZZDiRdzwgWgWqWqP5TLvDEc3OcvHP0K9cNd/ytvJufsHFab18p/NN/8vo9M7Ou9JETl
         QARjHe+ifNZs5mBKIUjYt77XE+pTQ3/jJ6sT7cG+hw0KXIPUPJlapogSgQjD2O/JBGIM
         yTU2HmhCVzyylTNuuYMckKZlcZ/p7aFfB/CqEsVPrm7peeCaQhneIrcfbfQSnGeT5/Gw
         zA+Ki6dKDJfZe4ZL9j8uestuasNSg3V5X4DFUAD/WayESC+nXLyHjFn/BfIVqkzyXo9c
         71XA==
X-Forwarded-Encrypted: i=1; AJvYcCW+VYHIRilnNeC1DqGkVwF/5p45xJxT1nZv5YrL7ZA6itumWmJl90BhO/3x5o8SZDoVQTAu2bwYji6vm7NDaV+Xm4xJlDnXus+y8WqB
X-Gm-Message-State: AOJu0Ywfw8vXyZfwPUlVTTFEAVBmo4LbTnkN5PORZh68EWjbBrYv16J0
	Df/6WJQOg6v9iwpLSwtlYOWr0/Y1qqUbWEyf8tcqE3Pn80R7d3AuTfzBUa5j+9c=
X-Google-Smtp-Source: AGHT+IH3cEAGS8z1AAB9YfW5ngjiqPq1pkCeukyPnzkD2SaocEGWL5AMib1cCOtc6Ke/m2Pq/T4Liw==
X-Received: by 2002:a17:906:d9b:b0:a46:a041:d1a with SMTP id m27-20020a1709060d9b00b00a46a0410d1amr2936982eji.70.1710701618132;
        Sun, 17 Mar 2024 11:53:38 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id r17-20020a1709067fd100b00a466782e438sm4004900ejs.139.2024.03.17.11.53.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 17 Mar 2024 11:53:37 -0700 (PDT)
Message-ID: <3ca1c419-d185-4318-92ed-3c4e40dcf5bb@linaro.org>
Date: Sun, 17 Mar 2024 19:53:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] dt-bindings: remoteproc: add Versal-NET platform
Content-Language: en-US
To: Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
 mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240315211533.1996543-1-tanmay.shah@amd.com>
 <20240315211533.1996543-3-tanmay.shah@amd.com>
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
In-Reply-To: <20240315211533.1996543-3-tanmay.shah@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/03/2024 22:15, Tanmay Shah wrote:
> AMD-Xilinx Versal-NET platform is successor of Versal platform. It
> contains multiple clusters of cortex-R52 real-time processing units.
> Each cluster contains two cores of cortex-R52 processors. Each cluster
> can be configured in lockstep mode or split mode.
> 
> Each R52 core is assigned 128KB of TCM memory. ATCM memory is 64KB, BTCM
> and CTCM memoreis are 32KB each. Each TCM memory has its own dedicated
> power-domain that needs to be requested before using it.
> 
> Signed-off-by: Tanmay Shah <tanmay.shah@amd.com>
> ---
>  .../remoteproc/xlnx,zynqmp-r5fss.yaml         | 220 +++++++++++++++---
>  1 file changed, 184 insertions(+), 36 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> index 711da0272250..55654ee02eef 100644
> --- a/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/xlnx,zynqmp-r5fss.yaml
> @@ -18,7 +18,9 @@ description: |
>  
>  properties:
>    compatible:
> -    const: xlnx,zynqmp-r5fss
> +    enum:
> +      - xlnx,zynqmp-r5fss
> +      - xlnx,versal-net-r52fss
>  
>    "#address-cells":
>      const: 2
> @@ -64,7 +66,9 @@ patternProperties:
>  
>      properties:
>        compatible:
> -        const: xlnx,zynqmp-r5f
> +        enum:
> +          - xlnx,zynqmp-r5f
> +          - xlnx,versal-net-r52f
>  
>        reg:
>          minItems: 1
> @@ -135,9 +139,11 @@ required:
>  allOf:
>    - if:
>        properties:
> -        xlnx,cluster-mode:
> -          enum:
> -            - 1
> +        compatible:
> +          contains:
> +            enum:
> +              - xlnx,versal-net-r52fss

Why do you touch these lines?

> +
>      then:
>        patternProperties:
>          "^r5f@[0-9a-f]+$":
> @@ -149,16 +155,14 @@ allOf:
>                items:
>                  - description: ATCM internal memory
>                  - description: BTCM internal memory
> -                - description: extra ATCM memory in lockstep mode
> -                - description: extra BTCM memory in lockstep mode
> +                - description: CTCM internal memory
>  
>              reg-names:
>                minItems: 1
>                items:
> -                - const: atcm0
> -                - const: btcm0
> -                - const: atcm1
> -                - const: btcm1
> +                - const: atcm
> +                - const: btcm
> +                - const: ctcm
>  
>              power-domains:
>                minItems: 2
> @@ -166,33 +170,70 @@ allOf:
>                  - description: RPU core power domain
>                  - description: ATCM power domain
>                  - description: BTCM power domain
> -                - description: second ATCM power domain
> -                - description: second BTCM power domain
> +                - description: CTCM power domain
>  
>      else:
> -      patternProperties:
> -        "^r5f@[0-9a-f]+$":
> -          type: object
> -
> -          properties:
> -            reg:
> -              minItems: 1
> -              items:
> -                - description: ATCM internal memory
> -                - description: BTCM internal memory
> -
> -            reg-names:
> -              minItems: 1
> -              items:
> -                - const: atcm0
> -                - const: btcm0
> -
> -            power-domains:
> -              minItems: 2
> -              items:
> -                - description: RPU core power domain
> -                - description: ATCM power domain
> -                - description: BTCM power domain
> +      allOf:
> +        - if:
> +            properties:
> +              xlnx,cluster-mode:
> +                enum:
> +                  - 1

Whatever you did here, is not really readable. You have now multiple
if:then:if:then embedded.

> +          then:
> +            patternProperties:
> +              "^r5f@[0-9a-f]+$":
> +                type: object
> +
> +                properties:
> +                  reg:
> +                    minItems: 1
> +                    items:
> +                      - description: ATCM internal memory
> +                      - description: BTCM internal memory
> +                      - description: extra ATCM memory in lockstep mode
> +                      - description: extra BTCM memory in lockstep mode
> +
> +                  reg-names:
> +                    minItems: 1
> +                    items:
> +                      - const: atcm0
> +                      - const: btcm0
> +                      - const: atcm1
> +                      - const: btcm1
> +
> +                  power-domains:
> +                    minItems: 2
> +                    items:
> +                      - description: RPU core power domain
> +                      - description: ATCM power domain
> +                      - description: BTCM power domain
> +                      - description: second ATCM power domain
> +                      - description: second BTCM power domain
> +
> +          else:
> +            patternProperties:
> +              "^r5f@[0-9a-f]+$":
> +                type: object
> +
> +                properties:
> +                  reg:
> +                    minItems: 1
> +                    items:
> +                      - description: ATCM internal memory
> +                      - description: BTCM internal memory
> +
> +                  reg-names:
> +                    minItems: 1
> +                    items:
> +                      - const: atcm0
> +                      - const: btcm0
> +
> +                  power-domains:
> +                    minItems: 2
> +                    items:
> +                      - description: RPU core power domain
> +                      - description: ATCM power domain
> +                      - description: BTCM power domain
>  
>  additionalProperties: false
>  
> @@ -386,4 +427,111 @@ examples:
>              };
>          };
>      };
> +
> +  - |
> +    // Versal-NET split configuration
> +    soc {
> +        #address-cells = <2>;
> +        #size-cells = <2>;
> +

Don't add examples per each platform.

Best regards,
Krzysztof


