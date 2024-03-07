Return-Path: <linux-kernel+bounces-95095-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77A8687492B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 08:59:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9B9D51C2169D
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Mar 2024 07:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D77063136;
	Thu,  7 Mar 2024 07:59:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="iGzsl/Kw"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B02BF6311B
	for <linux-kernel@vger.kernel.org>; Thu,  7 Mar 2024 07:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709798377; cv=none; b=AUu3IUk6ySQevb89OChKheCmSdKsFu+EixPMHpqw5sgXftZGEjSgX05CjRb+3+Dw7xCWTk5KxnZ/Sx4gRjp8y6EPeVfR5kzfa9aWXrtV9DhWp3ks4PyDoJEVmg/d27IVrvAbQ3Zv0w633n2V42k40UOkc3Q33aS1Brj8YIHUKfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709798377; c=relaxed/simple;
	bh=oJYwvebPSxy6YxXO/DvKCCgPQHIT9wOAIrN7jlew0mM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BiEYfTyaeYykKiL/BwYJ4euerzh3MXH9Qw4Zvm7vzKaBnX1/5dLQo2ybJPTmlBSf2rDmmVvCYqmVvtSqc4cMzWR/AtkwfB4dBSpgvEIaIlh7PVXgIrJO5Zkoqj4Qr+o9HShpdMBqcMx/9+zXtqOSB+cia9rY41N96rvt2H81xpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=iGzsl/Kw; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a44cdb2d3a6so85341766b.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Mar 2024 23:59:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709798374; x=1710403174; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=msrSbyxYEEwE738VHVTMGn05YADYFgEKkR5Gx/mGJkQ=;
        b=iGzsl/KwRfxZLamxH4mYUEhwPA3gPGvJTu2r+n4dFIV+vNh36kyADzTU7bsElvJMK4
         VyzYTU5RZmschd7x3HXNixQzXTF1WCd/YDnQepFAcw0x/C2r5N+TGwI4PM0U4I3F6jxD
         1qGyRgz2/1ouIj3qXCexl/q7LB+89u4rCr4Kldd0mnJCxI8wpEr27qH+VoJRVk29+q9G
         OiG3V/jzK9EIkHWb5JXSHnRSyLQ5cxUAidbDSGley7p8LXppb5JJoWnznXA0uBubXIba
         KII2lUWcJMDUtpBbllFyprAn10wpj34DZKF81iActtWu1CUxkMwpJA6xa/5aWzqx1nie
         WNdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709798374; x=1710403174;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=msrSbyxYEEwE738VHVTMGn05YADYFgEKkR5Gx/mGJkQ=;
        b=FgOR3d+5ok1miJSMfRx2gsjmoz6yRsEDEBf5+itAcZWcYpQDGjFopxVDhBcF4Fhz3K
         r2TUWy88DiUSkgTmGio1IeK9J4zFef5SeE4PjLkn0qFbTa3epqmnCd30DWCgvJx0ViXR
         r67Cuc4O/zhDq12yuc8sO6v54gZ9MhEIEssMGlb1g+5Juh33JX20ZaWWm307wnFrwDwe
         EtMmYpEE+T5Ytuyi/9Ega++15LNTbG02XaIli4iV3TAMoCLo6U8W1bekS8Gaakk1hjZB
         CYxxwIdNjR0Jkj7WHeHrBhn9krZ+JALfgUuFDGCTNOj0CANvrY11KO8zqa4J6QdKZapj
         jYtQ==
X-Forwarded-Encrypted: i=1; AJvYcCVseRH3h2rScMK0kZviGtiXNDNYZAFSFMUqiQHKItHEt39oerDFIAcK0dMqXO2ERvsbb2tJxeSQw9WWoe8El8zmCZeyPxq7hlxLQwCm
X-Gm-Message-State: AOJu0Yzf/Nk5D6kQ0dDWH6/XnubLWowkkYOP2GPpmEuLJCQveMtrKKb4
	j+Yi8iFO6DbpoCWla8KUth9yat7Q5hudDDsWmbIIVmjgtw66P4arMKR2ndVG8HzbuImeqAawh6u
	n
X-Google-Smtp-Source: AGHT+IHmAuMmL8+JDhVaYmwIN0yPYo2zccHsl0AqXOJzba3Y+FejC+8+XdTU05lulAfln4DYxlD4ww==
X-Received: by 2002:a17:906:a3cf:b0:a45:16af:bda1 with SMTP id ca15-20020a170906a3cf00b00a4516afbda1mr8310947ejb.12.1709798373914;
        Wed, 06 Mar 2024 23:59:33 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id j22-20020a170906475600b00a449d6184dasm6663851ejs.6.2024.03.06.23.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Mar 2024 23:59:33 -0800 (PST)
Message-ID: <0b92700a-cf79-4f1c-986a-d18fe0151bb8@linaro.org>
Date: Thu, 7 Mar 2024 08:59:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 1/2] dt-bindings: ASoC: Add PDM controller for the
 StarFive JH8100 SoC
Content-Language: en-US
To: Xingyu Wu <xingyu.wu@starfivetech.com>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Takashi Iwai <tiwai@suse.com>, Jaroslav Kysela <perex@perex.cz>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor.dooley@microchip.com>
Cc: Walker Chen <walker.chen@starfivetech.com>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
 linux-sound@vger.kernel.org
References: <20240307033708.139535-1-xingyu.wu@starfivetech.com>
 <20240307033708.139535-2-xingyu.wu@starfivetech.com>
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
In-Reply-To: <20240307033708.139535-2-xingyu.wu@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/03/2024 04:37, Xingyu Wu wrote:
> Add bindings for the PDM controller for the StarFive JH8100 SoC.

Please use subject prefixes matching the subsystem. You can get them for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching.

> 
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> ---
>  .../bindings/sound/starfive,jh8100-pdm.yaml   | 84 +++++++++++++++++++
>  1 file changed, 84 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/sound/starfive,jh8100-pdm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/sound/starfive,jh8100-pdm.yaml b/Documentation/devicetree/bindings/sound/starfive,jh8100-pdm.yaml
> new file mode 100644
> index 000000000000..a91b47d39ad3
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/sound/starfive,jh8100-pdm.yaml
> @@ -0,0 +1,84 @@
> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/sound/starfive,jh8100-pdm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: StarFive JH8100 PDM controller
> +
> +description: |
> +  The Pulse Density Modulation (PDM) controller is a digital PDM out
> +  microphone interface controller and decoder that supports both
> +  mono/stereo PDM format, and an Inter-IC Sound (I2S) transmitter that
> +  outputs standard stereo audio data to another device. The I2S transmitter
> +  can be configured to operate either a master or a slave (default mode).
> +  The PDM controller includes two PDM modules, each PDM module can drive
> +  one bitstream sampling clock and two bitstream coming data with sampling
> +  clock rising and falling edge.
> +
> +maintainers:
> +  - Xingyu Wu <xingyu.wu@starfivetech.com>
> +  - Walker Chen <walker.chen@starfivetech.com>
> +
> +properties:
> +  compatible:
> +    const: starfive,jh8100-pdm
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: DMIC output clock
> +      - description: Main ICG clock
> +
> +  clock-names:
> +    items:
> +      - const: dmic
> +      - const: icg
> +
> +  resets:
> +    maxItems: 1
> +
> +  starfive,syscon:
> +    $ref: /schemas/types.yaml#/definitions/phandle-array
> +    items:
> +      - items:
> +          - description: phandle to System Register Controller sys_syscon_ne node.
> +          - description: PDM source enabled control offset of SYS_SYSCON_NE register.
> +          - description: PDM source enabled control mask
> +    description:
> +      The phandle to System Register Controller syscon node and the PDM source
> +      from I2S enabled control offset and mask of SYS_SYSCON_NE register.
> +
> +  starfive,pdm-modulex:
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1]
> +    description:
> +      The module x will be using in PDM controller. Default use module 0.

This is an index of the block instance? If so, then it's not allowed.
Otherwise I don't understand the description.

Anyway, don't repeat constraints in free form text. default: 0, if this
is going to stay.

> +
> +  "#sound-dai-cells":
> +    const: 0
> +
> +required:
> +  - compatible
> +  - reg
> +  - clocks
> +  - clock-names
> +  - resets
> +  - starfive,syscon
> +
> +unevaluatedProperties: false

This is wrong without $ref, which points you to missing $ref to dai-common.

> +
> +examples:
> +  - |
> +    pdm@12250000 {
> +      compatible = "starfive,jh8100-pdm";
> +      reg = <0x12250000 0x1000>;
> +      clocks = <&syscrg_ne 142>,
> +               <&syscrg_ne 171>;
> +      clock-names = "dmic", "icg";
> +      resets = <&syscrg_ne 44>;
> +      starfive,syscon = <&sys_syscon_ne 0xC 0xFF>;

Lowercase hex only.

> +      #sound-dai-cells = <0>;
> +    };

Best regards,
Krzysztof


