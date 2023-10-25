Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BEAA7D64C6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Oct 2023 10:20:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233862AbjJYIUT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Oct 2023 04:20:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233692AbjJYIUR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Oct 2023 04:20:17 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 414E1129
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:20:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9ada2e6e75fso815761166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 25 Oct 2023 01:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1698222013; x=1698826813; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mGyiHTf9h3E03+lmKUwJehfcVviZh7AZQ8Zot4O6MlY=;
        b=R07pScq0hwtOS5DW2hc5Xb/TmNEHbUMk0teCMiLXJCqKDwIeBAGZzZHqP7og7GSWZV
         6kvV/TNyS/IsDHvL0No++MWTbcBVTKUyMafThydArL080Ih+zp9Bo8ISnLoSm9TJUqmR
         5vPtfjJl/4UTsAIBt/ciyXWq8eSOHCdpiJEUUVaQgE165BTw1q2r1RKAROCAHIeFqkJX
         E0E4PKFvgauVdUOGflX3tZTuWWJMTjc+23tGlZ03yq4jd5xti7WUcNi2zwAhcWM+L1hB
         YmPGSoXdwa8jY5i18lMvw3cK4WiDkmiyGCsKoluCQzJ6TVIp+wJw1xfdYelo0rUffvew
         74Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698222013; x=1698826813;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mGyiHTf9h3E03+lmKUwJehfcVviZh7AZQ8Zot4O6MlY=;
        b=NZYcw13U10VVWCWhOaARswu/MEjhYDYf0eWq1VDXG2zN21WJJb1Io3wXZ0ejZ3rATQ
         YcIzfQUfRmTS929ktK/VeNvQLebOslGckm4VWSW8THFdOGP2pBmkMlK7sKCWuc2UKyvR
         O1loegY6fRwLIhneGzbtPTaUyZoQSJ2uUpm1NPrjA8GXjRqnb33evOchoa5N7o2iJ3dp
         1iO73q6ZCn9H1BkqeQhLyC2H+5erB63g8GTrbmd04N2jJNpmvrshmPeogEuQBzTifmY+
         jFbmtoQ2oaITnAOSZthwyiaaIfkqeISGkwIqxfw266jEWv9vOXNkVFq9WT2LM/mHRBwB
         Jzgw==
X-Gm-Message-State: AOJu0YxwCezTzZY/iDdEks7xijmjY7+Sv2xTiwZHpXIdgTwl0iJNagkV
        s4SBuS9jiYgwzC1Qhjx4EU/KRQ==
X-Google-Smtp-Source: AGHT+IEAfSNLL1co6iHd1mFwS1BoytfPi1VstYidY2T+LrndLMHTAuZd0GJ4TdVeIPayVrfBlsulRA==
X-Received: by 2002:a17:906:fe4c:b0:9ba:a38:f2b2 with SMTP id wz12-20020a170906fe4c00b009ba0a38f2b2mr12214189ejb.41.1698222012647;
        Wed, 25 Oct 2023 01:20:12 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.218.126])
        by smtp.gmail.com with ESMTPSA id dx22-20020a170906a85600b00991d54db2acsm9292600ejb.44.2023.10.25.01.20.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Oct 2023 01:20:12 -0700 (PDT)
Message-ID: <b0e2a2c5-67e5-487e-9023-2fac5ce3ba47@linaro.org>
Date:   Wed, 25 Oct 2023 10:20:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: mtd-partitions: Export special values
Content-Language: en-US
To:     Edward Chow <equu@openmail.cc>, Rob Herring <robh+dt@kernel.org>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20231025052937.830813-1-equu@openmail.cc>
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
In-Reply-To: <20231025052937.830813-1-equu@openmail.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/10/2023 07:29, Edward Chow wrote:
> There are special "offset" and "size" values defined and documented in
> linux/mtd/partitions.h:
> 
> // consume as much as possible, leaving size after the end of partition.
> 
> // the partition will start at the next erase block.
> 
> // the partition will start where the previous one ended.
> 
> (Though not explicitly, they are compared against variables in uint64_t
> in drivers/mtd/mtdpart.c, so they had better be considered as such.)
> 
> // the partition will extend to the end of the master MTD device.
> 
> These special values could be used to define partitions automatically
> fitting to the size of the master MTD device at runtime.
> 
> However, these values used not to be exported to dt-bindings, thus
> seldom used before, since they might have been only used in numeric form,
> such as "(-1) (-3)" for MTDPART_OFS_RETAIN.
> 
> Now, they are exported in dt-bindings/mtd/partitions.h as 32-bit cell
> values, so 2-cell addressed should be defined to use special offset values,
> such as "MTDPART_OFS_SPECIAL MTDPART_OFS_RETAIN" for MTDPART_OFS_RETAIN in
> linux/mtd/partitions.h. An example is added to fixed-partitions.yaml.
> 
> Signed-off-by: Edward Chow <equu@openmail.cc>
> ---
>  .../mtd/partitions/fixed-partitions.yaml      | 29 +++++++++++++++++++
>  MAINTAINERS                                   |  2 ++
>  include/dt-bindings/mtd/partitions.h          | 15 ++++++++++
>  3 files changed, 46 insertions(+)
>  create mode 100644 include/dt-bindings/mtd/partitions.h
> 
> diff --git a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
> index 331e564f29dc..a939fb52ef76 100644
> --- a/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
> +++ b/Documentation/devicetree/bindings/mtd/partitions/fixed-partitions.yaml
> @@ -164,3 +164,32 @@ examples:
>              read-only;
>          };
>      };
> +
> +  - |
> +    partitions {
> +        compatible = "fixed-partitions";
> +        #address-cells = <2>;
> +        #size-cells = <1>;
> +
> +        partition@0 {
> +            label = "bootloader";
> +            reg = <0 0x000000 0x020000>;
> +            read-only;
> +        };
> +
> +        firmware@1 {
> +            label = "firmware";
> +            /* From the end of the last partition, occupying as mush

Use Linux coding style comments.

> +             * as possible, retaining 0x010000 after it,
> +             * "MTDPART_OFS_SPECIAL MTDPART_OFS_NXTBLK" similar to
> +             * this, but always beginning at erase block boundary. */
> +            reg = <MTDPART_OFS_SPECIAL MTDPART_OFS_RETAIN 0x010000>;
> +        };
> +
> +        calibration@2 {
> +            compatible = "fixed-partitions";
> +            label = "calibration";
> +            /* Appending to the last partition, occupying 0x010000 */
> +            reg = <MTDPART_OFS_SPECIAL MTDPART_OFS_APPEND 0x010000>;

And where is any user of this? Example in the bindings is not user. I
would expect that you will change at least one other DTS.

> +        };
> +    };
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 668d1e24452d..7d6beadc8b36 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13771,9 +13771,11 @@ T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes
>  T:	git git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/next
>  F:	Documentation/devicetree/bindings/mtd/
>  F:	drivers/mtd/
> +F:	include/dt-bindings/mtd/
>  F:	include/linux/mtd/
>  F:	include/uapi/mtd/
>  
> +

Drop.

>  MEMSENSING MICROSYSTEMS MSA311 DRIVER
>  M:	Dmitry Rokosov <ddrokosov@sberdevices.ru>
>  L:	linux-iio@vger.kernel.org
> diff --git a/include/dt-bindings/mtd/partitions.h b/include/dt-bindings/mtd/partitions.h
> new file mode 100644
> index 000000000000..456a54a1259a
> --- /dev/null
> +++ b/include/dt-bindings/mtd/partitions.h
> @@ -0,0 +1,15 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Dual license, as asked by checkpatch.

Best regards,
Krzysztof

