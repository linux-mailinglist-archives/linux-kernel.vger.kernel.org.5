Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D098E7DBAC9
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Oct 2023 14:31:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233473AbjJ3Nb7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Oct 2023 09:31:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233467AbjJ3Nb4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Oct 2023 09:31:56 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1C3EA
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 06:31:46 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-40806e4106dso26213645e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 30 Oct 2023 06:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698672705; x=1699277505; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5iBVIduJX5Kfi6GRQtob+W5jdhc7zjXnDk4PvajJvFM=;
        b=pbwmH1PigYzsyzw1zqZrgNTZ6ZaYq2luxAdd1uOhYhn0z8AihnIWQ2Cnv26tLnS0mU
         PQCSQzFKrF4cuDCf02p36s1Zj5ZhZ3XUPDqkA0pD+6nBHdATjra8pcAeXx446FrsxAxi
         IhXSNmJJVYT/3Ph9cesRLcxi4nGg8TB09/VeJjvx1MBqpqHt9kNlj9CkI4oUawk6BD0L
         Ia4uiaaPQfGO8q7m4ec+/qSHFWC1Nh3qRK5wislKTPSUGoDaUwe/taoXxwtX00P6dAcP
         kk+GEiFNQQnRPbPlq1OyNAnp/7IYCS9/lOMOctv+OH3n6Gah/UJt3RkdyHwxAy+j1Uhq
         K9YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698672705; x=1699277505;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5iBVIduJX5Kfi6GRQtob+W5jdhc7zjXnDk4PvajJvFM=;
        b=YeqlDIWIV4QcVuQEC5do6PnX5hiUMS4sqoNXuZ5gZvaI8meax4VUIvMKWMoeweiYEG
         ULnRWgCG7fJvNY8RDJiKjh3OG1MaXq6IjZ+AEVg6bQsyIb3PaXXAHVfXzumnDqsucTtI
         7iJCthkYJuTUeVxAN+NfX1WwFPv045UY9evS+wY01jZ+BHgS6jQ3b2dD7CCJGXhmWjCT
         JFVKEt5VQzPCBHelrDWNgfx3FAEkUpUCciTfEUtjS+Am++bLfway3Rurgdihs/Zj7cZ7
         P+hdIYPljFloT8fc34Pikw5zzclmWpOHkLuJfbTKtMU0iHq/wJ2ew3QTpSaMVIbN4896
         CR6w==
X-Gm-Message-State: AOJu0YzKUqPxe/Er7AYyntj/GqiyyC5gm0eNsJ5Q6cfdktLOHUbo4jIq
        lyXBzkLUr3NikfX680pNy3bG+Q==
X-Google-Smtp-Source: AGHT+IHf698iUk8+rK/GdvGulrlxhAI8TWrfJmuEGblijlvDRZ6Aw20X/PccNTb++4ld76SHEaf2uA==
X-Received: by 2002:a05:600c:4fc1:b0:406:51a0:17ea with SMTP id o1-20020a05600c4fc100b0040651a017eamr11246731wmq.10.1698672704689;
        Mon, 30 Oct 2023 06:31:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id ew11-20020a05600c808b00b004063c9f68f2sm9048498wmb.26.2023.10.30.06.31.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 30 Oct 2023 06:31:44 -0700 (PDT)
Message-ID: <02040f13-22ae-4ea5-9119-99bf778c27bf@linaro.org>
Date:   Mon, 30 Oct 2023 14:31:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] dt-bindings: arm64: dts: add dt-bindings for
 Marvell COM Express boards
Content-Language: en-US
To:     Elad Nachman <enachman@marvell.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        andrew@lunn.ch, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, pali@kernel.org,
        mrkiko.rs@gmail.com, chris.packham@alliedtelesis.co.nz,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     cyuval@marvell.com
References: <20231029174814.559583-1-enachman@marvell.com>
 <20231029174814.559583-3-enachman@marvell.com>
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
In-Reply-To: <20231029174814.559583-3-enachman@marvell.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/10/2023 18:48, Elad Nachman wrote:
> From: Elad Nachman <enachman@marvell.com>
> 

A nit, subject: drop second/last, redundant "dt-bindings for". The
"dt-bindings" prefix is already stating that these are bindings.

> Add dt bindings for:
> CN9130 COM Express CPU module
> CN9131 COM Express CPU module
> AC5X RD COM Express Type 7 carrier board.
> AC5X RD COM Express board with a CN9131 COM Express Type 7 CPU module.
> 
> Signed-off-by: Elad Nachman <enachman@marvell.com>
> ---
>  .../bindings/arm/marvell/armada-7k-8k.yaml        | 15 +++++++++++++++
>  .../bindings/arm/marvell/marvell,ac5.yaml         | 14 ++++++++++++++
>  2 files changed, 29 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
> index 52d78521e412..7e0ac5110eef 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
> +++ b/Documentation/devicetree/bindings/arm/marvell/armada-7k-8k.yaml
> @@ -60,4 +60,19 @@ properties:
>            - const: marvell,armada-ap807-quad
>            - const: marvell,armada-ap807
>  
> +      - description: Armada CN9130 SoC without external CP as COM Express CPU module
> +        items:
> +          - const: marvell,cn9130-cpu-module

How CPU module can be used alone?

> +          - const: marvell,cn9130
> +          - const: marvell,armada-ap807-quad
> +          - const: marvell,armada-ap807
> +
> +      - description: Armada CN9131 SoC with one external CP as COM Express CPU module
> +        items:
> +          - const: marvell,cn9131-cpu-module
> +          - const: marvell,cn9131
> +          - const: marvell,cn9130
> +          - const: marvell,armada-ap807-quad
> +          - const: marvell,armada-ap807
> +
>  additionalProperties: true
> diff --git a/Documentation/devicetree/bindings/arm/marvell/marvell,ac5.yaml b/Documentation/devicetree/bindings/arm/marvell/marvell,ac5.yaml
> index 8960fb8b2b2f..734e1716a3e9 100644
> --- a/Documentation/devicetree/bindings/arm/marvell/marvell,ac5.yaml
> +++ b/Documentation/devicetree/bindings/arm/marvell/marvell,ac5.yaml
> @@ -27,6 +27,20 @@ properties:
>            - const: marvell,ac5x
>            - const: marvell,ac5
>  
> +      - description: Alleycat5X (98DX35xx) Reference Design as COM Express Carrier
> +        items:
> +          - enum:
> +              - marvell,rd-ac5x-carrier
> +          - const: marvell,ac5x
> +
> +      - description:
> +           Alleycat5X (98DX35xx) Reference Design as COM Express Carrier plus
> +           Armada CN9131 COM Express CPU module
> +        items:
> +          - enum:
> +              - marvell,rd-ac5x-carrier-with-cn9131
> +          - const: marvell,ac5x

You never responded to me concerns, so I still do not know what's this.
This claims it has CN9131, but compatibles are missing.

Can anyone help us understand why AC5 has CN9130 but these are in
different files?

Best regards,
Krzysztof

