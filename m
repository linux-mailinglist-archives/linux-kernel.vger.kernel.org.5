Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06169806DD8
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Dec 2023 12:26:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377528AbjLFL0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Dec 2023 06:26:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378242AbjLFLZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Dec 2023 06:25:46 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60631DC
        for <linux-kernel@vger.kernel.org>; Wed,  6 Dec 2023 03:25:52 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-a06e59384b6so88390066b.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 Dec 2023 03:25:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701861951; x=1702466751; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7iFHTH9alWkglkkF8qs/MSlvKU4xNsLsdZ29PoySgFA=;
        b=VRZm7OZYUUzL1jESq7XrucLwznkuSbr/tpFFY+smIDySmfYpHrWOMz4AwyTNzZrykq
         o2I/fnBioWznMinDvXxN0S2xtd4MGRZPReI7NCbsvQbKCrACWSKGH0xUEVgQ9FTusfJc
         y9dYLr5YI1g24oTmmbjucvVYspgPZKqhknAKNuX7eGZjs1FnSpNwsfFlP8ZzCcnMNuQP
         7WjYKm7LGOrVmpoMwTPrqGH0HJxgh9U5grLbKt4iTHlFElguSm4iJA7rzW/waHFwCxsa
         xf4cRd5khiGrWpWCNd6yRHgPqYR4FN52MqDULm+1nIV2BmVlC7QYeXj4Q/OlCST4Q1AM
         G7mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701861951; x=1702466751;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7iFHTH9alWkglkkF8qs/MSlvKU4xNsLsdZ29PoySgFA=;
        b=HgXo0UTbgjMuJRD8MW4YIfbzYOvji+d0CtxEoDneZFePlAA9GdD02/TmbPaISsiClp
         wc2BwOm0otjhFuppyjfSLo7WY8PlOid8ipzf5BgdpUbXzBAevDUGZlfQ3O1v+V4JAGsz
         BLDPW51gZpb+vseVCZZlHCu4n4JaFN47kEXxgWKkzTZcNTDVJoRXiSqycwAT7AvfoN/n
         EBlHrYtXAMQcdguJ8XcPJXPOUx2d46JC0e0L07wKJ+ONwSHW2v/Y8ofGgH1YCDzXerTz
         lPIK/hz3SP3215YyhDDC+tICH6jy0wiC0EHXG3xYDJXTk8WaO5ioNTXfaQ0HmHuPFvVd
         XwtQ==
X-Gm-Message-State: AOJu0YyNK0wEX2dS+X83tuWWtbLiEg9KdGdG/dK/GOmusBa6zu9HCdiq
        36/x26nfX3JfGJShogDzDa1YAg==
X-Google-Smtp-Source: AGHT+IGuH68c9ySP/svaW642ByNKdVCZSeCEYtoee4Pl2NOU6l8yChU6e8x6+kWikBShJ4r7Lz2fOw==
X-Received: by 2002:a17:906:3654:b0:a19:a19b:c722 with SMTP id r20-20020a170906365400b00a19a19bc722mr386713ejb.114.1701861950832;
        Wed, 06 Dec 2023 03:25:50 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id 14-20020a170906318e00b00a0d672bfbb0sm8277262ejy.142.2023.12.06.03.25.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Dec 2023 03:25:50 -0800 (PST)
Message-ID: <cb41490a-72f8-4eb4-b9ff-3823fa452a39@linaro.org>
Date:   Wed, 6 Dec 2023 12:25:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] dt-bindings: arm: Add remote etm dt-binding
Content-Language: en-US
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>
References: <20231205082922.32149-1-quic_jinlmao@quicinc.com>
 <20231205082922.32149-2-quic_jinlmao@quicinc.com>
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
In-Reply-To: <20231205082922.32149-2-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/12/2023 09:29, Mao Jinlong wrote:
> Remote ETM(Embedded Trace Macrocell) is to capture information of
> the executed processor instructions of remote processors like modem.
> Add new coresight-remote-etm.yaml file describing the bindings
> required to define coresight remote etm in the device trees.
> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>


> +description:
> +  Support for ETM trace collection on remote processor using coresight
> +  framework. Enabling this will allow turning on ETM tracing on remote
> +  processor like modem processor via sysfs and collecting the trace
> +  via coresight TMC sinks.
> +
> +properties:
> +  compatible:
> +    const: qcom,coresight-remote-etm
> +
> +  qcom,inst-id:

I did not receive my answer about this property one month ago, so:
NAK, drop this property.

> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Each kind of remote ETM has its unique instance id. The remote etm will
> +      be enabled/disabled on remote processor based on the id send from
> +      ap processor.
> +
> +  out-ports:
> +    $ref: /schemas/graph.yaml#/properties/ports
> +    additionalProperties: false
> +
> +    properties:
> +      port:
> +        description: Output connection to the CoreSight Trace bus.
> +        $ref: /schemas/graph.yaml#/properties/port
> +
> +required:
> +  - compatible
> +  - qcom,inst-id
> +  - out-ports
> +
> +additionalProperties: false
> +
> +examples:
> +  - |
> +    modem-etm0 {

etm {

> +          compatible = "qcom,coresight-remote-etm";
> +          qcom,inst-id = <2>;
> +
> +          out-ports {
> +              port {
> +                  modem_etm0_out_funnel_modem: endpoint {
> +                  remote-endpoint = <&funnel_modem_in_modem_etm0>;

Missing indentation level

> +                  };
> +              };
> +          };
> +    };
> +...

Best regards,
Krzysztof

