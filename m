Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5E577D8FF9
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Oct 2023 09:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345477AbjJ0Hgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 Oct 2023 03:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345458AbjJ0Hg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Oct 2023 03:36:29 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF855D40
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:36:25 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5079f9675c6so2712933e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 27 Oct 2023 00:36:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698392184; x=1698996984; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FKgxwW12cXvJbbJyaE54dQi3HeFLiwxHnNrbqUscsyw=;
        b=goG8P1A6H2ypq5vqm5Ei3c75UdWfo8F0g8RvmWTSZGrH6HBIRNrfuI3rFfWO5v5sMM
         bCyDiMj/jqdjy+9qXyac0N+XfIUrTkWC5CegtooR5gieOyOfbZnW1AjdhTYoh/bJajEs
         x8Xwep1tGwF3ZKqF0wz7M1UYZmaOtIsjBcdr/ZRRIbnr0YBQTf7oh/k5Z4RpDQg4Mn8Y
         F0YeiDJnOAhyleXN9FkUNuKcMt5agCPRRifig2QyapJtCRZT+BlayGLAKwawPBdH1LBT
         jOBM4FOvj03DcnTjO8LYr9CgLcES13SSSSs8gFqdpjYekIBVO+r+OJeQhw8rr3T7heXE
         mxjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698392184; x=1698996984;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FKgxwW12cXvJbbJyaE54dQi3HeFLiwxHnNrbqUscsyw=;
        b=tsVz2WzrTr1i3mcPmedv2EkdPAtZc0IdLHwSfD7UXj9YgURJX7iseqjNco+NeZlupQ
         annCG7IIYDI77mHVowDCBZxQZ/hcaDCz9R6BL7u13GaEICXd9sbl2Lp+QDDiD9uxKebp
         6tfTRHRzib6XsBg5V/ukz0IfEtRbVAOWOuK/bQ4xOLqRALacFnS+DpZ+x14LCgUhyh1S
         iNWJoUyUIdciuMgFZ7AQY2qNvgUiq2z3g0P3dt+IV13iSBsitGfkzN3mbg7kq2zReZRw
         L26JXIHIUUMQV+MXLKUDVD6HCA4zQqlzqvNrKbDqw1t2nzqtBsOzNHs5uE/NyUkEhqQR
         kiUw==
X-Gm-Message-State: AOJu0YyAdMzmB/8uNDiITly4Xa43X6576gYjZBJk+F4V5SnrMkZcLNZ6
        pM0tV5meRIDjxXSJE17B3UIKUQ==
X-Google-Smtp-Source: AGHT+IFqagUd0m8zM5GEs/QvCP49dXETv0iPLFRVr7vsc8eyNYMZsLQ/8t/1txgYTkEGuOrjv46TKA==
X-Received: by 2002:a05:6512:3b89:b0:503:36cb:5438 with SMTP id g9-20020a0565123b8900b0050336cb5438mr1484365lfv.21.1698392183994;
        Fri, 27 Oct 2023 00:36:23 -0700 (PDT)
Received: from [192.168.0.22] ([78.10.206.168])
        by smtp.gmail.com with ESMTPSA id a14-20020a194f4e000000b00505a20d070asm170385lfk.78.2023.10.27.00.36.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Oct 2023 00:36:23 -0700 (PDT)
Message-ID: <a1895327-b520-4f3a-a427-0947ac46495c@linaro.org>
Date:   Fri, 27 Oct 2023 09:36:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: remoteproc: qcom,sm8550-pas: document
 the SM8650 PAS
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20231025-topic-sm8650-upstream-remoteproc-v1-0-a8d20e4ce18c@linaro.org>
 <20231025-topic-sm8650-upstream-remoteproc-v1-1-a8d20e4ce18c@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20231025-topic-sm8650-upstream-remoteproc-v1-1-a8d20e4ce18c@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 09:35, Neil Armstrong wrote:
> Document the DSP Peripheral Authentication Service on the SM8650 Platform.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/remoteproc/qcom,sm8550-pas.yaml       | 41 +++++++++++++++++++++-
>  1 file changed, 40 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> index 58120829fb06..316371c8ee6e 100644
> --- a/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> +++ b/Documentation/devicetree/bindings/remoteproc/qcom,sm8550-pas.yaml
> @@ -19,6 +19,9 @@ properties:
>        - qcom,sm8550-adsp-pas
>        - qcom,sm8550-cdsp-pas
>        - qcom,sm8550-mpss-pas
> +      - qcom,sm8650-adsp-pas
> +      - qcom,sm8650-cdsp-pas
> +      - qcom,sm8650-mpss-pas
>  
>    reg:
>      maxItems: 1
> @@ -49,6 +52,7 @@ properties:
>        - description: Memory region for main Firmware authentication
>        - description: Memory region for Devicetree Firmware authentication
>        - description: DSM Memory region
> +      - description: DSM Memory region 2
>  
>  required:
>    - compatible
> @@ -63,6 +67,7 @@ allOf:
>            enum:
>              - qcom,sm8550-adsp-pas
>              - qcom,sm8550-cdsp-pas
> +            - qcom,sm8650-adsp-pas
>      then:
>        properties:
>          interrupts:
> @@ -71,7 +76,25 @@ allOf:
>            maxItems: 5
>          memory-region:
>            maxItems: 2
> -    else:
> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,sm8650-cdsp-pas
> +    then:
> +      properties:
> +        interrupts:
> +          minItems: 5

maxItems


> +        interrupt-names:
> +          minItems: 5

maxItems

> +        memory-region:
> +          minItems: 3

maxItems: 3

> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,sm8550-mpss-pas
> +    then:
>        properties:
>          interrupts:
>            minItems: 6
> @@ -79,12 +102,26 @@ allOf:
>            minItems: 6
>          memory-region:
>            minItems: 3

You need to add here maxItems.

> +  - if:
> +      properties:
> +        compatible:
> +          enum:
> +            - qcom,sm8650-mpss-pas
> +    then:

I am not sure if keeping it in the same binding as sm8550 avoids that
much duplication.

Best regards,
Krzysztof

