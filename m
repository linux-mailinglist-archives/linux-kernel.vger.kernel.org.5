Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351787E4372
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Nov 2023 16:30:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343848AbjKGPak (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Nov 2023 10:30:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbjKGPai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Nov 2023 10:30:38 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A345113
        for <linux-kernel@vger.kernel.org>; Tue,  7 Nov 2023 07:30:36 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-53de8fc1ad8so9815084a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Nov 2023 07:30:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1699371034; x=1699975834; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=X533tTgWb1eLSTyAkSIxe6pqYTgEk5kDQ0hSy0Z6A+g=;
        b=vF6r8eb8FPJqc4JsQhpM68hdN64k8qev5hseB1tCWmS+BgehaT8vqGtxLmFKNKMTPc
         s8QrmZSlsosD+c9FjMs6byZMePPNd4Z32f/ItATsKMhZUZsVA4lB4SiIib3AKjSmsFlq
         aIVZXzjek52pnSan+L0JQDP+rOsgIrL2e88vjuTkF6YcWrBVkbSS6IJh9Y6g/7ZGfgB9
         laxnnUBSpp2e85JzF3+/mldsfy8hY9Qt7xuIcLl2dXHu54L7ZI9NBebOiupKnaCPagfJ
         vCCD3404oG6cbiMFf5eIb+RjVOxOhcVqpM9aCz2xqm6OdCaFy1vPZlOunfkDPj0em3Hk
         KddA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699371034; x=1699975834;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=X533tTgWb1eLSTyAkSIxe6pqYTgEk5kDQ0hSy0Z6A+g=;
        b=ga0ghhwduzVJS1QnCLrw9aNqq3gxyU1Ps9MgmaGnv2JeKFdEZa+0zNPJhJIgYglVbI
         CyEV6Tv7FhCTq+uy3LszmqnIm2UtzdLSYS/bbSUC4nMwhfmdTp+KcvdEZrLqDeOYOfzg
         i5ufRK4Ul4Cb26r+lnLQ50fvaEzbY6y/7EvQHdgRWWu31fwvp4l4TDbrp2/cnhkdVYl0
         rUQevAsieVZlSdg8GS+l5Ap1H72Rb1yOhCPgwbUiWOF247OcexbjfH/cRqK+vjDoSWYM
         iGNJbO3BbDL4Hsh1cxar8+cHdVLuZToYcCwlBbZG+E8YNu3ywvi+4p05Ca83dBTbS04j
         1gZA==
X-Gm-Message-State: AOJu0YxCFt922VWlxEIWSu4RrnmGAKemgc/2GyhJN5XZMUOsyMZhf75D
        0TPjOFTMNCtffvRe2NYiqPq8Bg==
X-Google-Smtp-Source: AGHT+IHqRzlMQW1322zEZU++nyEQZu6GAp3fMN+6lhVBpMx1K3kqRuYNwaOZb8vjH8JBTiw5Npdhcw==
X-Received: by 2002:a17:907:9815:b0:9b2:b152:b0f2 with SMTP id ji21-20020a170907981500b009b2b152b0f2mr17810273ejc.10.1699371034593;
        Tue, 07 Nov 2023 07:30:34 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id i20-20020a17090671d400b009ddf38056f8sm1163639ejk.118.2023.11.07.07.30.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Nov 2023 07:30:34 -0800 (PST)
Message-ID: <d2c4e571-fbc4-4c3b-b382-1dabb88fbcb9@linaro.org>
Date:   Tue, 7 Nov 2023 16:30:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] dt-bindings: arm: Add remote etm driver
Content-Language: en-US
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        James Clark <james.clark@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>
References: <20231107060939.13449-1-quic_jinlmao@quicinc.com>
 <20231107060939.13449-3-quic_jinlmao@quicinc.com>
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
In-Reply-To: <20231107060939.13449-3-quic_jinlmao@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2023 07:09, Mao Jinlong wrote:
> Add new coresight-remote-etm.yaml file describing the bindings required
> to define coresight remote etm in the device trees.

Subject: drop driver. Bindings are about hardware, not drivers.

> 
> Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> ---
>  .../arm/qcom,coresight-remote-etm.yaml        | 59 +++++++++++++++++++
>  1 file changed, 59 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/arm/qcom,coresight-remote-etm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/arm/qcom,coresight-remote-etm.yaml b/Documentation/devicetree/bindings/arm/qcom,coresight-remote-etm.yaml
> new file mode 100644
> index 000000000000..04bb57b48d96
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/arm/qcom,coresight-remote-etm.yaml
> @@ -0,0 +1,59 @@
> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/arm/qcom,coresight-remote-etm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Coresight Remote ETM

What is ETM?

> +
> +maintainers:
> +  - Jinlong Mao <quic_jinlmao@quicinc.com>
> +  - Tao Zhang <quic_taozha@quicinc.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  Support for ETM trace collection on remote processor using coresight
> +  framework. Enabling this will allow turning on ETM tracing on remote
> +  processor via sysfs and collecting the trace via TMC sinks.
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: qcom,coresight-remote-etm
> +
> +  qcom,inst-id:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    description:
> +      Instance id of remote etm.

It's the first time this property appears... Why do you need to
hard-code it and why would it differ between each board? If you want to
use existing, accepted property, then you must use exactly the same.

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
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +    modem_etm0 {

Node names should be generic. See also an explanation and list of
examples (not exhaustive) in DT specification:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#generic-names-recommendation

Underscores are not allowed.

> +        compatible = "qcom,coresight-remote-etm";
> +        qcom,inst-id = <2>;
> +
> +        out-ports {
> +            port {
> +                modem_etm0_out_funnel_modem: endpoint {
> +                remote-endpoint =
> +                    <&funnel_modem_in_modem_etm0>;

Fix wrapping.

> +                };
> +            };
> +        };
> +    };
> +...

Best regards,
Krzysztof

