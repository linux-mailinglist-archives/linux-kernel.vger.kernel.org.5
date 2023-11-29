Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A18C77FD177
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 09:57:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232064AbjK2I5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 03:57:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjK2I5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 03:57:05 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ED21F5
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:57:11 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-5098e423ba2so9384851e87.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Nov 2023 00:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701248229; x=1701853029; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ETCRngdPiNvXGaauG0PLv42XC3p5WNPMJSuI5cLKm0w=;
        b=pauNfesrv5ed0+oAmiLhqmHUsi+ATJu4tWiPHZFFHX1uWbB3xdRVuIMUx4eANhVU2V
         vhMC9yEGNBPVaZvo/VpIrxkopfZpLeEZRgHBvoy82tWXZWkCvJV00WI8QpVP2wUuuxSb
         WO++ig1XZmAuViNGl6oRMjyRlRxOClHQo5EuybfvQZsUHhgskIjQPc+q/V7TVYaqSF0I
         6pbta937EE5p/f4Q/3o0O4ysTqKCZ6vUnJctdJJrvAlDmUKNjOAkqFPzgZhsGblfeRwM
         ihKeNcM2aflOyTX06rwFB3bVOyJFLPI75YO+VjR3LGDoQVcSuTOpCgxTYJ/3uY+eYmj5
         8BQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701248229; x=1701853029;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ETCRngdPiNvXGaauG0PLv42XC3p5WNPMJSuI5cLKm0w=;
        b=ssQLhK8cHOXjbudhzxb0I0R2OGFIZxvtGYjX1l+u9eOUdjAIT8hOOfnhe9p1mL1DYk
         EqOG71imw9PSWvC2Q3XA4NncMsCc9Mi07AjQXZzKdk/8aFt361UTg82webc0zv6jBUzv
         NDIOI0LOoxtbUIU47D+CLTUyJdiRFtRihZ4A6XFFThHzzHxeb0Jm0I92LglxRI+xnAA+
         zahm+hjBSwAaS9A8qS7k7HI++l84uu5CPEioC7QOE8TqwF4ITBwEim9qmBGwS1jqlfdQ
         nxiUw4uE1a89FAXk7fOqT49LXnCNru92Xb1+YfO4QCyfcG/A6QRlxz1ryOJ+LvE0ctn0
         gIxA==
X-Gm-Message-State: AOJu0Yw4yd2H3rkz5yMklKYSgRWOB69KKt5RUMlqV3/DngilgETMmPSL
        moY/vnDpMDXX/4x3W1j4rmI6Cw==
X-Google-Smtp-Source: AGHT+IE2gnR9siVK+FBd9mRVSdRpYN1ReqM7jtb0cKx1aaW9GeMN8MjoVBmOWlKAhT4Mhj58WKvMcA==
X-Received: by 2002:ac2:5110:0:b0:50b:bdf2:884c with SMTP id q16-20020ac25110000000b0050bbdf2884cmr2343534lfb.37.1701248229366;
        Wed, 29 Nov 2023 00:57:09 -0800 (PST)
Received: from [192.168.1.20] ([178.197.223.109])
        by smtp.gmail.com with ESMTPSA id b4-20020a509f04000000b0054b3a6243b1sm4222578edf.71.2023.11.29.00.57.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Nov 2023 00:57:09 -0800 (PST)
Message-ID: <bc95ef35-7eab-4806-9cf8-4594156c9d98@linaro.org>
Date:   Wed, 29 Nov 2023 09:57:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] dt-bindings: interrupt-controller: Add support for
 Realtek DHC SoCs
Content-Language: en-US
To:     James Tai <james.tai@realtek.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        kernel test robot <lkp@intel.com>
References: <20231129054339.3054202-1-james.tai@realtek.com>
 <20231129054339.3054202-2-james.tai@realtek.com>
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
In-Reply-To: <20231129054339.3054202-2-james.tai@realtek.com>
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

On 29/11/2023 06:43, James Tai wrote:
> Add the YAML documentation for Realtek DHC (Digital Home Center) SoCs.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Closes: https://lore.kernel.org/oe-kbuild-all/202311180921.ayKhiFHL-lkp@intel.com/

Drop both. They are not applicable to this patch.

> CC: Thomas Gleixner <tglx@linutronix.de>
> CC: Marc Zyngier <maz@kernel.org>

> CC: Rob Herring <robh+dt@kernel.org>
> CC: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> CC: Conor Dooley <conor+dt@kernel.org>
> CC: linux-kernel@vger.kernel.org
> CC: devicetree@vger.kernel.org

Please drop the autogenerated scripts/get_maintainer.pl CC-entries from
commit msg. There is no single need to store automated output of
get_maintainers.pl in the git log. It can be easily re-created at any
given time, thus its presence in the git history is redundant and
obfuscates the log.

If you need it for your own patch management purposes, keep it under the
--- separator.

> Signed-off-by: James Tai <james.tai@realtek.com>
> ---
> v2 to v3 change:
> - Retested the bindings using the new version of the dtschema
> - Fixed the order of property items
> - Removed redundant files and replaced them with 'realtek,intc.yaml'
> - Replaced 'interrupts-extended' with 'interrupts'
> - Added a description for 'interrupts'
> - Reduced the example code
> 
> v1 to v2 change:
> - Tested the bindings using 'make dt_binding_check'
> - Fixed code style issues
> 
>  .../interrupt-controller/realtek,intc.yaml    | 76 +++++++++++++++++++
>  1 file changed, 76 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/interrupt-controller/realtek,intc.yaml
> 
> diff --git a/Documentation/devicetree/bindings/interrupt-controller/realtek,intc.yaml b/Documentation/devicetree/bindings/interrupt-controller/realtek,intc.yaml
> new file mode 100644
> index 000000000000..3aa863b1549d
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/interrupt-controller/realtek,intc.yaml
> @@ -0,0 +1,76 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/interrupt-controller/realtek,intc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Realtek DHC SoCs Interrupt Controller
> +
> +maintainers:
> +  - James Tai <james.tai@realtek.com>
> +
> +description:
> +  This interrupt controller is a component of Realtek DHC (Digital Home Center)
> +  SoCs and is designed to receive interrupts from peripheral devices.
> +
> +  Each DHC SoC has two sets of interrupt controllers, each capable of
> +  handling up to 32 interrupts.
> +
> +allOf:
> +  - $ref: /schemas/interrupt-controller.yaml#
> +
> +properties:
> +  compatible:
> +    enum:
> +      - realtek,rtd1319-intc-iso
> +      - realtek,rtd1319-intc-misc
> +      - realtek,rtd1319d-intc-iso
> +      - realtek,rtd1319d-intc-misc
> +      - realtek,rtd1325-intc-iso
> +      - realtek,rtd1325-intc-misc
> +      - realtek,rtd1619b-intc-iso
> +      - realtek,rtd1619b-intc-misc
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupt-controller: true
> +
> +  '#interrupt-cells':
> +    const: 1
> +
> +  '#address-cells':
> +    const: 0
> +
> +  interrupts:
> +    description: |
> +      Contains the GIC SPI IRQs mapped to the external interrupt lines.
> +    minItems: 2
> +    maxItems: 4

My previous comments were not addressed. Why lines are not described
(items: description:)? Are they all the same? Why you did not respond to
clarify this comment?

The rest of my comment here was also ignored. You cannot just ignore
comments, but must respond to them or implement them.

To clarify: I expect allOf: block after required: constraining the
interrupts per variant.



Best regards,
Krzysztof

