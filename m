Return-Path: <linux-kernel+bounces-104896-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F7DA87D51C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE188288973
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 344261F958;
	Fri, 15 Mar 2024 20:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CyJeFUKO"
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF2A4E1C1
	for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 20:40:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710535219; cv=none; b=buPjQ/pbHpbdRGvmHuuM9mTSexkjX0i1v44NcxFlcuOi/1LvpLvydFfE4Bc+ZWtQmPkzmZ05eUDQiBeX5MBXf8Pa4yADMW8KyOwbI5zZBMRvrjZZ0zYjshFTlyvtBGDajrBvPHBVTNpyw9Fskn185zIv+NBCwlMwMZk3jva7SL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710535219; c=relaxed/simple;
	bh=+QRMMAU8cktVKnUTZWjyaMuIexMvJotpw1TXCnrLLkI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UCEoup++2WTpKt69gysVtKVdwtgBPSvOaY2EbMTlju7jClrqglMV6XMxa4l5HjhBwSiicJ3FRl+/d0dw/qrzJc1ceHZw22JjC6eLH3mhFuvjH9YRTbwSRumB9+ov/UoKdvubGSMguvwDBPmR+1Fv/WBHSMVoExSVSuplYD+Oh3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=CyJeFUKO; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-a466a256726so418286666b.1
        for <linux-kernel@vger.kernel.org>; Fri, 15 Mar 2024 13:40:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710535216; x=1711140016; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GZGA5Ahl8JwT0YD+YfVJrQEJg9N0A5Xv5JcpBW3b6Oc=;
        b=CyJeFUKO5GtfFmWjEtFv63i3Xnd+IFQ6Tx/2PK0xiSySHjAD6HXidJDGi1GCbUQTtX
         LWTnQW6SL4i9B22cQqG0VPfOEQDHGFlGQenBlD2pDhInbzgI8/9VrE3wGWkX2v9P/s9U
         0R42wEC1OpGSitcj2kBKV0LsqMpvjY750/pvlXsf2GQuE2u5o0ZjDObF9UZODGfP+PfS
         5FZHfcWfGBYkqOE3V8/Oguy0Pn8OlIqyjTJozDbKydKWtKopfw+WusP21oGz0xueuZUy
         f2/SwgX6ohEHF1ndhqGkU5YkJ4l1iy5NsnFOwNly+/agkkRmd+NSFYBQO+BFcyhoGL0d
         4Hsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710535216; x=1711140016;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GZGA5Ahl8JwT0YD+YfVJrQEJg9N0A5Xv5JcpBW3b6Oc=;
        b=i3ZT+md7+owX6lVSBHIAdfATnE1PH8+AA7i1BPHi7yjzsD8L/py+5KYt38BUQ0wsJH
         tpLeDyP5cLnVopKxrPlkKvCabt2SpQSkv3QgXq7WqXj+IMQwEarYz/NBRbndqyuumV9C
         bY5ZQMeKz3v+vQ47h/u0XxmS1LSnGVQ8Fj2poRuWzvmd1Y+4DdTq+jLBYwCDB7riwe1O
         MqVnPq5VHorvpbAWeozw7hWeMsFvDanK11tnGDCYAN1XOlRAv8PvKEU289om4EfPyxu3
         pQwIMNbIP4kpFP9LtAIS/QVK/l6fKXt7rpKytOtiQUhUgtsOl9b0D/7tnsiOAdcucg/1
         BPwg==
X-Forwarded-Encrypted: i=1; AJvYcCVri6CUOgGEZgh2u3Ru7AbHGnt67d3/e+1EhrHpVZ7Bn4OSWoj3byYyHL7123X0WIuwqhJZk52oa5jmWZVr/Lj++3zf6OTYbca3DcNT
X-Gm-Message-State: AOJu0Yz95J+QtX3hw6suhNoWDBVxQYHy68enUnpp2OYCfqwRxaRz4g0/
	BAw4rVUVBl9NBXHmmwZfeYA53s/EW8E/t1tRBjmhWdnMgFpOnM24lOzSvMXkNb0=
X-Google-Smtp-Source: AGHT+IE3Vm/Ztnbl0AydJgGYmRakPJs1AkSrmM+AD33E4IENFkMpZ3f1ZYQ4gnNtHsJoBb+VAZHshQ==
X-Received: by 2002:a17:907:c783:b0:a46:7b92:f110 with SMTP id tz3-20020a170907c78300b00a467b92f110mr4496923ejc.31.1710535215862;
        Fri, 15 Mar 2024 13:40:15 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id pv27-20020a170907209b00b00a44fcdf20d1sm2018576ejb.189.2024.03.15.13.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 13:40:15 -0700 (PDT)
Message-ID: <5723478b-1717-4f83-959f-14bfce309bcf@linaro.org>
Date: Fri, 15 Mar 2024 21:40:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/8] dt-bindings: misc: Add mikrobus-connector
Content-Language: en-US
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Ayush Singh <ayushdevel1325@gmail.com>, linux-kernel@vger.kernel.org,
 jkridner@beagleboard.org, robertcnelson@beagleboard.org,
 Vaishnav M A <vaishnav@beagleboard.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>,
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>,
 Derek Kiernan <derek.kiernan@amd.com>, Dragan Cvetic
 <dragan.cvetic@amd.com>, Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Jiri Slaby <jirislaby@kernel.org>, Johan Hovold <johan@kernel.org>,
 Alex Elder <elder@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-spi@vger.kernel.org,
 linux-serial@vger.kernel.org, greybus-dev@lists.linaro.org
References: <20240315184908.500352-1-ayushdevel1325@gmail.com>
 <20240315184908.500352-2-ayushdevel1325@gmail.com>
 <314a88e0-19cd-4b95-9cf3-aef1c7579eec@linaro.org>
 <ZfSteEmeQX5IUJnU@shell.armlinux.org.uk>
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
In-Reply-To: <ZfSteEmeQX5IUJnU@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/03/2024 21:20, Russell King (Oracle) wrote:
> On Fri, Mar 15, 2024 at 09:09:11PM +0100, Krzysztof Kozlowski wrote:
>>> +properties:
>>> +  compatible:
>>> +    const: mikrobus-connector
>>
>> Hm, why do you create binding for the connector, not for some sort of
>> controller? Please provide some rationale for this in commit msg.
> 
> I think you have a distorted view. I refer you to the Mikroe mikroBUS
> specification - it's _just_ a connector which provides a fairly
> standardised purpose for each pin and the electrical specifications.
> For example of the pins: power, UART, SPIs, I2C, PWM, and analogue
> pins.

I refer to the commit msg or description in the binding and there is
nothing explained like this. Yeah, true, I could google every possible
bus specification, but I also expect some sort of help here by the patch
submitter.

The binding looks like binding for a connector, not for some sort of
controller, then are you saying the control part it is purely in
software? That's how DTS looks like, but then my question is are there
some sort of controller which would also perform this?

> 
>>> +  pinctrl-names:
>>> +    items:
>>> +      - const: default
>>> +      - const: pwm_default
>>> +      - const: pwm_gpio
>>> +      - const: uart_default
>>> +      - const: uart_gpio
>>> +      - const: i2c_default
>>> +      - const: i2c_gpio
>>> +      - const: spi_default
>>> +      - const: spi_gpio
>>
>> I fail to see why such choice is related to the connector itself.
> 
> This isn't a choice at all. Here's the list of pins:
> 
> Analog - AN
> Reset - RST
> SPI Chip Select - CS
> SPI Clock - SCK
> SPI Master Input Slave Output - MISO
> SPI Master Output Slave Input - MOSI
> VCC-3.3V power - +3.3V
> Reference Ground - GND
> PWM - PWM output
> INT - Hardware Interrupt
> RX - UART Receive
> TX - UART Transmit
> SCL - I2C Clock
> SDA - I2C Data
> +5V - VCC-5V power
> GND - Reference Ground
> 
> Any data pin can be a GPIO if e.g. a relay board is plugged in, even
> if some of the other pins are used for e.g. UART purposes. For example,
> a GPS board that provides the GPS data over the UART pins, and the
> PPS signal through a different pin.

And could you not have some certain features supported? Could have some
pins just pull down / not connected?

Best regards,
Krzysztof


