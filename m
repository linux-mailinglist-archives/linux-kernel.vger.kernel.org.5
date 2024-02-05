Return-Path: <linux-kernel+bounces-52219-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 728BC84958F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:40:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 979B61C232A7
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 08:40:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CDE31170A;
	Mon,  5 Feb 2024 08:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O5mNz/L1"
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EB3812B6B
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 08:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707122406; cv=none; b=lh/+IXpr+3MNq6NL/EHmHR8+1y6Q/V5zerwOwdjZIfFJlDCn2DgBW9R0qK7daO2ByU45EPwCnuPfQBbGNXER7o4HYfXpG7MnBLclLdQeFt9qh4IbBiwesXFlj0cjGr1E5HUdmdXnery1vTW2Y6HcrjBVJnNkoBcKOFgx0UZ0fRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707122406; c=relaxed/simple;
	bh=wpp/TUj6twPhR8eQks9mP3XVtJqAe58Io4jhmP85SgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oRfWllf9LNt55wSFvLY/OnjyOfcLPcecNGLTrwfUZu1qNkfYjDBPSdfXPJie+k72oo7iU9gqEkeC+7K49KvgDdaao9ITWI/w9uJUOL8UbdrFqRiTSPhX5dEN6IUJkS9NJYiulpgyI6XIZDm6v1o0LKu8H6PikBNlyorlliPX9FE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=O5mNz/L1; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2d066b82658so60752121fa.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 00:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707122403; x=1707727203; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OCecjuEuZTL+9EIdIHfh/9h9vAfTHL1wm39kflQDAdI=;
        b=O5mNz/L1PaRg4zU69QMQAZejf25stiAX0YkIcrHTmXkZX35KI/f69LrCWkbxWp11JN
         Gl/ZDKYiUpnMQ6QNmPy+cj6uaVlI5jH10sNmFjvU4ZxEHWWLygsvbW0YUOd0/d0wBHgI
         AgHDpdL3uZLT26xHEqQpFIZS8pE3bWE1yyNXQI5lBbUZVhpmAdCHdEWeNVz/tHMS01Qy
         QmP3xw6cArpr3N2vXRV2Nd1VTS4v8Yi3qRYGrTEwehXYWFTIlnyD+gxNBcv8xrCQbZ8V
         f+QMJrLP7TZClXHiuiONuT0Ocnuapbiu4OpFAGWkoW9Spwv7GOdbg8w12wXWIwYCp9nB
         ngXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707122403; x=1707727203;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OCecjuEuZTL+9EIdIHfh/9h9vAfTHL1wm39kflQDAdI=;
        b=ZLFjE8ifc6Gi9Z77BOjbH1n12/zmKYEpFePxRyGNaYrajJ0w+kuTNyLDYo/hXCZk5x
         o1vSNdRWCyLpNf/TWxYh5X/F18qvsL7o3HGjg76CmUESe5Fon9h/ConEeDgvgQSl/1/R
         Yd3EySYj55hUTu1r3IEytnwyv+yQdV4Rurn/BupKQfuigtTa0arYHxVdX0kI+MOw4cIr
         wwUWO/IcCuAfWMC+e9GVt6H7UsJyasspesRKEZ3X3l+SV5aUCeHTNHPpdGVpfj2bIfY7
         WIx9v1lmdZkcueU79OU43Rlz0fUiWVLFxV97JBWAhTkFuY/nfGmq25OxTRve9u/IONCW
         y3oQ==
X-Gm-Message-State: AOJu0YzTZTVFjOedmbe4UtgcEhP2Cji0J6fsSqtSgOX6qGmvb6wniC/6
	NJmyAl6cQsBFfakes3oJOJnC2sHYGxc30RXdb44cuShZQVmIjBPgMW05w0Wk0XY=
X-Google-Smtp-Source: AGHT+IHvIkLmoKMtoeG4prp2Xi4x4BoKH7EU1u7QssGMe36kEVMchFOfNJil5oAv3Pfurkqm/kl5Jg==
X-Received: by 2002:a2e:9081:0:b0:2d0:643c:c2aa with SMTP id l1-20020a2e9081000000b002d0643cc2aamr5818509ljg.20.1707122402317;
        Mon, 05 Feb 2024 00:40:02 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUKYtPIYBB27cxssLG0IVAZV5Hkfa5To2UebO23HFtPMTpXje9BP36zgBNpg1NQI/Too0K923iQFG+6mTWV9aowzkJZiZAGWU4STMA4B05WzuyiJgXyQBANyssIT/T40y9wfvjxDSNrVSco8EYLGcoM9OBxyOs9X/+vv9Sdomv92y2ss3/xgm2G7w3aj0iLt4+VmX/uNRsmEPZEZBgTCCLZbTjBpDzqvLF4Z2Y9FtxOjq5AaZvzpugqWeTquoU9bYv4sCQKPtgEN00VW7ACxGJjtOArjBrZ4dCUpWLTzyXK2jIZZQLospFAmXNemARYVgn6hfQDmrKY88i9M/2c+McOvPpgak6VwOnHwfqMF3qq54u7Dl+s3u85dCAFYqE+X6PnOmCYkBjr1cApDliMhe/rQTKNOuvz+LfFJOwqHeUwZkxPBfp0dt3/zgatGRiSSsasmbnv3TAe/vlKG7IlBqnpqcI1sGi789Gy4qPWKfmQB3TuYN2X
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id eo15-20020a056402530f00b00560651808a6sm864844edb.67.2024.02.05.00.40.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 00:40:01 -0800 (PST)
Message-ID: <abe2930b-8fd0-4fa7-8abe-a036525a21ce@linaro.org>
Date: Mon, 5 Feb 2024 09:39:59 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] dt: bindings: leds: Add NCP5623 multi-LED Controller
Content-Language: en-US
To: Abdel Alkuor <alkuor@gmail.com>, Pavel Machek <pavel@ucw.cz>,
 Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Jean-Jacques Hiblot <jjhiblot@traphandler.com>,
 Jacek Anaszewski <jacek.anaszewski@gmail.com>,
 Alice Chen <alice_chen@richtek.com>, ChiaEn Wu <chiaen_wu@richtek.com>,
 ChiYuan Huang <cy_huang@richtek.com>, =?UTF-8?Q?Andr=C3=A9_Apitzsch?=
 <git@apitzsch.eu>, Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org
References: <20240203175910.301099-1-alkuor@gmail.com>
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
In-Reply-To: <20240203175910.301099-1-alkuor@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/02/2024 18:58, Abdel Alkuor wrote:
> NCP5623 is DC-DC multi-LED controller which can be used for
> RGB illumination or backlight LCD display. NCP5623
> provides 94% peak efficiency.

Drop marketing.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

It's dt-bindings.

> 
> Signed-off-by: Abdel Alkuor <alkuor@gmail.com>
> ---
>  .../bindings/leds/onnn,ncp5623.yaml           | 98 +++++++++++++++++++
>  1 file changed, 98 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/leds/onnn,ncp5623.yaml
> 
> diff --git a/Documentation/devicetree/bindings/leds/onnn,ncp5623.yaml b/Documentation/devicetree/bindings/leds/onnn,ncp5623.yaml
> new file mode 100644
> index 000000000000..696bc7d8c8f9
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/leds/onnn,ncp5623.yaml
> @@ -0,0 +1,98 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/leds/onnn,ncp5623.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: ON Semiconductor NCP5623 multi-LED Driver
> +
> +maintainers:
> +  - Abdel Alkuor <alkuor@gmail.com>
> +
> +description: |

Do not need '|' unless you need to preserve formatting.

> +  NCP5623 Triple Output I2C Controlled LED Driver.
> +  https://www.onsemi.com/pdf/datasheet/ncp5623-d.pdf
> +
> +properties:
> +  compatible:
> +    enum:
> +      - onnn,ncp5623
> +
> +  reg:
> +    enum:

Instead "const", or just maxItems: 1


> +      - 0x38
> +
> +  multi-led:
> +    type: object
> +    $ref: leds-class-multicolor.yaml#
> +    unevaluatedProperties: false
> +
> +    properties:
> +      "#address-cells":
> +        const: 1
> +
> +      "#size-cells":
> +        const: 0
> +
> +    patternProperties:
> +      "^led@[0-2]$":
> +        type: object
> +        $ref: common.yaml#
> +        unevaluatedProperties: false
> +
> +        properties:
> +          reg:
> +            description: Index of the LED.

Drop description, it is obvious.

> +            minimum: 0
> +            maximum: 2
> +
> +        required:
> +          - reg
> +          - color
> +
> +    required:
> +      - "#address-cells"
> +      - "#size-cells"



Best regards,
Krzysztof


