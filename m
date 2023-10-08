Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A4E57BCE20
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Oct 2023 13:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344701AbjJHLVP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Oct 2023 07:21:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344667AbjJHLVN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Oct 2023 07:21:13 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94481B6
        for <linux-kernel@vger.kernel.org>; Sun,  8 Oct 2023 04:21:11 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id ffacd0b85a97d-317c3ac7339so3252437f8f.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 Oct 2023 04:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1696764070; x=1697368870; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zIPn5VQi1c+EtebjnSSWcNAMZWK8/L+GcOspWUyENTY=;
        b=zPK0F/r9IElcIwdJn1oET7VkPNbChj/8wAgAlrCMKu/uE6YENBlkfgsR6lhH+/Go+4
         mAUP2aI/VOb5HdonNZc/4L/Rvs4p5F7RGVt+OjFPgcsjaRyappRnps5dd5umtM5FrGQV
         QJKf+ml6cB67fRax7cWWBIW3E9nRPTqkuuhucphGHkDXWKHSw3I7VJs2nIbl35HbvSsG
         stjWqrcFn7dcmklWncIdDmryRxme8QNslofQPucRV5QALw9i3qGDgLO2MI9gjvrHCN/W
         L1tlzlIyMlxmvPTYtgZ+itgkN0lAwjh9EnRCOxEIMSeDf6HS3qbIxh1S5dIPxF5y7OLw
         6qFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1696764070; x=1697368870;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zIPn5VQi1c+EtebjnSSWcNAMZWK8/L+GcOspWUyENTY=;
        b=JZHv0zDHbc+u60CzlbXYBnFnF+us78RznMQ5REHvBN4Tl3gV9Gx3zFKAGz1dZ81kh6
         7KXvRrqBAhK/KftDUkNrQpAetKtJ8cYEQxkm9sjK8fG+WMB+RyAqfJO+vclvU3uEeAd/
         lN4YwDq/dzDIk6pt2on1TqZOr5FSSCc/t96u6RjMPrBx9ng791xw79Iwx92zvewDao2+
         3y8OKs1bMVY9SJyD8hpBUOTEmhzqWZK9JMHVVml+/7JAm+jMlWIlHU0OZGkTbdmMl/33
         u97/0FmOV6yhE0GpaoqGiaTVbM8opZmr05qvpRT7QyvPBHrhHyNWz2M4x/sSCw0cpRoN
         +vTQ==
X-Gm-Message-State: AOJu0Yy3T7VoaRyzxku7KvN8FbLeK/EgUFxX4ScU47jhM0rbyrZLAQUd
        5Sdi7XbAUQklQeglg+7A86Qfhg==
X-Google-Smtp-Source: AGHT+IEejtaLBCXy+4kvz38IEJwIJ/A5rbXuPt+tftaDWEoZTMvoQi14FIa1asOzH38XRrltbe61Kw==
X-Received: by 2002:adf:db50:0:b0:31f:6524:2de1 with SMTP id f16-20020adfdb50000000b0031f65242de1mr11043270wrj.32.1696764069351;
        Sun, 08 Oct 2023 04:21:09 -0700 (PDT)
Received: from [192.168.1.197] (5-157-101-10.dyn.eolo.it. [5.157.101.10])
        by smtp.gmail.com with ESMTPSA id h9-20020a5d5489000000b003179d5aee67sm6581049wrv.94.2023.10.08.04.21.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Oct 2023 04:21:08 -0700 (PDT)
Message-ID: <d1a24162-74e1-4a99-ab0f-b3976cd000d6@linaro.org>
Date:   Sun, 8 Oct 2023 13:21:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] dt-bindings: mtd: cadence: convert
 cadence-nand-controller.txt to yaml
Content-Language: en-US
To:     niravkumar.l.rabara@intel.com,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231005051548.55122-1-niravkumar.l.rabara@intel.com>
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
In-Reply-To: <20231005051548.55122-1-niravkumar.l.rabara@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/10/2023 07:15, niravkumar.l.rabara@intel.com wrote:
> From: Niravkumar L Rabara <niravkumar.l.rabara@intel.com>
> 
> Convert cadence-nand-controller.txt to yaml format.
> Update cadence-nand-controller.txt to cadence,nand.yaml in MAINTAINER file.
> 


> +allOf:
> +  - $ref: nand-controller.yaml
> +
> +properties:
> +  compatible:
> +    items:
> +      - const: cdns,hp-nfc
> +
> +  reg:
> +    items:
> +      - description: Address and length of the controller register set

Just "Controller register set"

> +      - description: Address and length of the Slave DMA data port

"Slave DMA data port"
or
"Slave DMA data port register set"

> +
> +  reg-names:
> +    items:
> +      - const: reg
> +      - const: sdma
> +
> +  interrupts:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 1
> +
> +  dmas:
> +    maxItems: 1
> +
> +  cdns,board-delay-ps:
> +    description: |
> +      Estimated Board delay. The value includes the total round trip
> +      delay for the signals and is used for deciding on values associated
> +      with data read capture. The example formula for SDR mode is the
> +      following.
> +      board delay = RE#PAD delay + PCB trace to device + PCB trace from device
> +      + DQ PAD delay
> +
> +required:
> +  - compatible
> +  - reg
> +  - reg-names
> +  - interrupts
> +  - clocks
> +
> +unevaluatedProperties: false
> +
> +examples:
> +  - |
> +      nand-controller@10b80000 {

This does not look properly indented. Should start at | before. IOW:
Use 4 spaces for example indentation.

> +        compatible = "cdns,hp-nfc";
> +        reg = <0x10b80000 0x10000>,
> +            <0x10840000 0x10000>;

Please align it properly with opening <

> +        reg-names = "reg", "sdma";
> +        #address-cells = <1>;
> +        #size-cells = <0>;
> +        interrupts = <0 97 4>;

Use defines for interrupt flags.

> +        clocks = <&nf_clk>;
> +        cdns,board-delay-ps = <4830>;
> +
> +        nand@0 {
> +            reg = <0>;
> +        };
> +      };

Best regards,
Krzysztof

