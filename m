Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C4A07F9B7C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Nov 2023 09:17:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232369AbjK0IRj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Nov 2023 03:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjK0IRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Nov 2023 03:17:37 -0500
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57AC138
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:17:43 -0800 (PST)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-548ce28fd23so5143806a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Nov 2023 00:17:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701073062; x=1701677862; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xwogz74TVrwjUzkMeqQ40ZCgOgHK0fa8tbIJvLR1fg0=;
        b=WwuBrYig1oBAOz/Yn99PpTF4yI0WBVr/jyvBpFGD12i5xWn/OeVkVQrGCsqApFoiqn
         QYrtyVo9CwemaOZE3NkdTPfMZEgyzDkOCkwMdfW8NLVD/0ZU096sbEwmu5BA+cvEe/5u
         NKFY+zBSAJ8JdlCvkkIbRHGYbqE3gJQ8YdgZ+d6vzSI49PX2UFjs4CVmmS24wgxaJcw+
         2e8eVbnVZPbrM9kqze6gGfUheKq0p/OXMglz0nsr968E7wlnJJcH1uIf2bvj0DIiP5RY
         wN4cQYMZM8mThjCJnQrwAHAwl68luOh+2cXenNNrdrzQ42UuhsDOAC9A/fmHmZ4xec+b
         dzzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701073062; x=1701677862;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xwogz74TVrwjUzkMeqQ40ZCgOgHK0fa8tbIJvLR1fg0=;
        b=YUT1MadDQKhkMBnLU6OL8RcFWGCipLfihYfbkJCxYlNIGgaaED4Scp7NR5v7/Shr1g
         M5JpezEFCn2st2znClB+YnlQ9QnhhICiPWq42UTZv3IJgRS3/PN2XLl8ksTv8h5iuEFv
         A0cAzt/GEfYuoKfllry/qrsqECl8HcJGsAyJXHmptjpzmvpxY06zq79hsYaxgjWlrNZa
         nfQYC5//WTPjm90jrpCtIcLf68RdrC/+jtJ5jqsmx0YcDU6hE/83iIvOOzyylPWLVID5
         2BIYnnM25K7NiIgxqRvUbHNTRpjBT4gYcXL7S8fdw6ylygM0Ohy2G2pRRBmLI3u0y/bh
         8/5g==
X-Gm-Message-State: AOJu0YynOkPiHQ+W+TxYFghftotnNyGu927UoKApXdUQySOMUiANqBA8
        tDKXTSrd9s+HKvnRNNK6L4331A==
X-Google-Smtp-Source: AGHT+IF43LQPkBuIn6W1Z6uVUk1i+FRWlpVYdLYRswxN/UVMTHHOhMJyv92BWvR8fdfypPHM3AfFuQ==
X-Received: by 2002:a17:906:e99:b0:a04:7d85:fcc with SMTP id p25-20020a1709060e9900b00a047d850fccmr7513169ejf.51.1701073062258;
        Mon, 27 Nov 2023 00:17:42 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id m3-20020a170906160300b00a00b4d9df54sm5379634ejd.5.2023.11.27.00.17.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Nov 2023 00:17:41 -0800 (PST)
Message-ID: <8366b046-068e-41df-9dd6-9aa4beefc6ca@linaro.org>
Date:   Mon, 27 Nov 2023 09:17:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt-bindings: interconnect: Add Qualcomm SM6115 NoC
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        Konrad Dybcio <konradybcio@kernel.org>
References: <20231125-topic-6115icc-v1-0-fa51c0b556c9@linaro.org>
 <20231125-topic-6115icc-v1-1-fa51c0b556c9@linaro.org>
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
In-Reply-To: <20231125-topic-6115icc-v1-1-fa51c0b556c9@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/11/2023 16:59, Konrad Dybcio wrote:
> Add bindings for Qualcomm SM6115 Network-On-Chip interconnect.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  .../bindings/interconnect/qcom,sm6115.yaml         | 128 +++++++++++++++++++++
>  include/dt-bindings/interconnect/qcom,sm6115.h     | 111 ++++++++++++++++++
>  2 files changed, 239 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml b/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml
> new file mode 100644
> index 000000000000..8908946eb391
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interconnect/qcom,sm6115.yaml
> @@ -0,0 +1,128 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interconnect/qcom,sm6115.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm SM6115 Network-On-Chip interconnect
> +
> +maintainers:
> +  - Konrad Dybcio <konradybcio@kernel.org>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  The Qualcomm SM6115 interconnect providers support adjusting the
> +  bandwidth requirements between the various NoC fabrics.
> +
> +properties:
> +  reg:
> +    maxItems: 1
> +
> +  compatible:

compatible is the first in properties (move it before reg).

> +    enum:
> +      - qcom,sm6115-bimc
> +      - qcom,sm6115-cnoc
> +      - qcom,sm6115-snoc
> +

Add clocks: with min/maxItems here. Same with clock-names.


> +# Child node's properties
> +patternProperties:
> +  '^interconnect-[a-z0-9]+$':
> +    type: object
> +    description:
> +      The interconnect providers do not have a separate QoS register space,
> +      but share parent's space.
> +
> +    allOf:

Drop allOf, just $ref.

> +      - $ref: qcom,rpm-common.yaml#
> +
> +    properties:
> +      compatible:
> +        enum:
> +          - qcom,sm6115-clk-virt
> +          - qcom,sm6115-mmrt-virt
> +          - qcom,sm6115-mmnrt-virt
> +
> +    required:
> +      - compatible
> +
> +    unevaluatedProperties: false
> +
> +required:
> +  - compatible
> +  - reg
> +
> +unevaluatedProperties: false

Put it after allOf: block.

> +
> +allOf:
> +  - $ref: qcom,rpm-common.yaml#
> +  - if:
> +      properties:
> +        compatible:
> +          const: qcom,sm6115-cnoc
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: USB-NoC AXI clock
> +
> +        clock-names:
> +          items:
> +            - const: usb_axi
> +
> +  - if:
> +      properties:
> +        compatible:
> +          const: qcom,sm6115-snoc
> +
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: CPU-NoC AXI clock.
> +            - description: UFS-NoC AXI clock.
> +            - description: USB-NoC AXI clock.
> +            - description: IPA clock.
> +
> +        clock-names:
> +          items:
> +            - const: cpu_axi
> +            - const: ufs_axi
> +            - const: usb_axi
> +            - const: ipa

Add if: for remaining variant disallowing clocks and clock-names.
(clocks: false)

> +
> +examples:
> +  - |
> +    #include <dt-bindings/clock/qcom,rpmcc.h>

Is it used?

> +
> +    snoc: interconnect@1880000 {
> +        compatible = "qcom,sm6115-snoc";
> +        reg = <0x01880000 0x60200>;
> +        #interconnect-cells = <1>;

Missing clocks.

> +
> +        qup_virt: interconnect-qup {
> +            compatible = "qcom,sm6115-qup-virt";
> +            #interconnect-cells = <1>;
> +        };
> +
> +        mmnrt_virt: interconnect-mmnrt {
> +            compatible = "qcom,sm6115-mmnrt-virt";
> +            #interconnect-cells = <1>;
> +        };
> +
> +        mmrt_virt: interconnect-mmrt {
> +            compatible = "qcom,sm6115-mmrt-virt";
> +            #interconnect-cells = <1>;
> +        };
> +    };
> +
> +    cnoc: interconnect@1900000 {
> +        compatible = "qcom,sm6115-cnoc";
> +        reg = <0x01900000 0x8200>;
> +        #interconnect-cells = <1>;
> +    };
> +
> +    bimc: interconnect@4480000 {
> +        compatible = "qcom,sm6115-bimc";
> +        reg = <0x04480000 0x80000>;
> +        #interconnect-cells = <1>;
> +    };

Drop this node, duplicates cnoc.

> diff --git a/include/dt-bindings/interconnect/qcom,sm6115.h b/include/dt-bindings/interconnect/qcom,sm6115.h
> new file mode 100644
> index 000000000000..21090e585f05



Best regards,
Krzysztof

