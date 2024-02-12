Return-Path: <linux-kernel+bounces-61778-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F282F851671
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:06:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 236341C21E63
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:06:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEEFE405F4;
	Mon, 12 Feb 2024 13:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T2NifXJW"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE72405D4
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 13:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707746209; cv=none; b=aLwwRVAlZPxkOBB/7kqDDNpff1L1bfRc2Z2iuXtrGvsoZpWjCbTM4clg8hYmUr2Uaz3Qr6Kwsk8CCwLs8Pwp0PNy0LjbprYpePdFwhIj9rBdHsaWyd5oNMQG0eCXXZbQW+mAGCiSES/Vyf0rWeYvpj87G8kgm08cn4xW7a7Xedw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707746209; c=relaxed/simple;
	bh=JyU3kmbr2jnfFu7zf9O+pIol2Kcozf0ejIGMum2s8uw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pVIxzEWmJeB7Kk39lGero3nA6MyaKsFvJUMVl4ReGIptGZ9sqsVSKVgn7r10Ef0ANkuEDjEVRsvbsYlC/fwq1iUadBDfxmSXheZTnTd8ejvw+D/r8W6QncqTKnN08a44lX/RgJV2mYRZREw9oxDteBbN98E1PkqMxGqXEmtG9u0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T2NifXJW; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51168addef1so5958803e87.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 05:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707746206; x=1708351006; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3E7segTRl+4d7bV09SnbopswTZ5UOf7CNImwX0udeR0=;
        b=T2NifXJWMWiMmCIwHxAXzjqaUYSGiwpuT2vaBN0kqY4yNc2hQgJl/XzGgXFP/OT5Ci
         0UlumqynV6aK4OY+rYC7cLUWqcaX6c/J1fdf0odX4I997/pB2QirqokK1fjXrBFwEZp6
         hRbtc8aRUh98TzBmCMlyeg+R6N2uErb7pR05g2CgCY1UpqvRpKjEqCkPI9Lv8kHGgMhi
         5gcVU8MEhDWFgIuSkI3GBjkhXzzoNm1XmBsIh5wbhvLi4lfx+IH9EAHygO1quRTMbZFo
         /6ayhdYMlFnPRtXSG5pEZv1CzUxloXVXrXdNWKVI+odSdZtPoXIArPhaHZvIB2/OU8P/
         A9og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707746206; x=1708351006;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3E7segTRl+4d7bV09SnbopswTZ5UOf7CNImwX0udeR0=;
        b=L4dvny1sL36QJmv07fQKNc1ezrBxFCtHUt2iivfnua8qcJBmdv1amVb5d1WNgjW8w2
         +/0yYDFd/qevhGHh6cFWLqSp3hMLkDuwH5DBf0uw75pGbHCyLQe3ItATafkMbqxB244K
         kmuktY8C7OZ7ej21TPhNauvBr99nqpnBwSjjFhg0p5D2Q/D+S37x0DZLmrNweQFrB5OJ
         vlFW6V+TUoEuiHAX359k01v3c6Dq43IRuMjQCqG7jegh9FYhvNeCBEaBjq3CqtUR1uRT
         ut97k5f7gRhuhZzkuh82aLoJ61F1qozHHbvdkSpub0t41tC6mT05fWw6D8hjr3+eDouG
         lkZg==
X-Forwarded-Encrypted: i=1; AJvYcCXY3OSNcEjq7zKFaUQzjuA9sMj/7XF8jIKOoi0/Z7+/pekXVMUv4YyGu5AFce2v5ytUmcekdFmhejpH+W7lUgEMpSdaGWr8uq8xY0q/
X-Gm-Message-State: AOJu0Yw6dWqa3WCRbtiU5WHTihSJaVJcCpgAb9tteUvmi6HWg91gVdF4
	uKe0Tu0IAh1XZEidDnpuBHEbOkFxl6nb/TWBOAk1y0IanjrmkxIvediFReUWiao=
X-Google-Smtp-Source: AGHT+IE+qlI0J2LkYhL9BFcmlclTopqMe6lnVFPQJDQt4unFy6HNzzoCMq5UgHonRywUOcJXwhzyNw==
X-Received: by 2002:a05:6512:3b06:b0:511:83b3:a9aa with SMTP id f6-20020a0565123b0600b0051183b3a9aamr4403923lfv.6.1707746206317;
        Mon, 12 Feb 2024 05:56:46 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUDWakoZkcS2jHf9Ze6mBlcE8IllIxyE1KY3N1H4akVzVOoVSLG/XkywV0JtS87ag2tbfTVfXjT2XsL9p2z6njyn2GT8UqrjJUbxbDNvogd1HmRwGQv58RWyZaHCTsadrQhM81KfuGO9b8mQjf6VWBjCBvCHxJBq71frWUZEFPHAzcMd70as8/6iUVELUV9BeqyKdJQgYGnBzg8C7hBhXGJkfOgWvdFY6fPxlSvugf03HKzE8jESYo64pRydXw/zsgNv4ts4wkGjhejLy0eNS8UXWfwsJULNMldwIObPlVnc3btwDcHyiFnQz6ZZiKsktyeGa9gIUTaUvPn5qq4c27KUTkbHbm02ZwFDlAFdUvi+uSJ+0IgZHgHa2ETyhxeo4s6wcMTtqbDULdLkTo=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id m5-20020a05600c280500b00410b0ce91b1sm4941885wmb.25.2024.02.12.05.56.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 05:56:45 -0800 (PST)
Message-ID: <906db6a6-48ba-41e5-be23-1dea0ecf96ee@linaro.org>
Date: Mon, 12 Feb 2024 14:56:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: auxdisplay: hit,hd44780: drop redundant
 GPIO node
Content-Language: en-US
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Linus Walleij <linus.walleij@linaro.org>, Miguel Ojeda
 <ojeda@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Robin van der Gracht
 <robin@protonic.nl>, Paul Burton <paulburton@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240212083426.26757-1-krzysztof.kozlowski@linaro.org>
 <ZcofhWb8stiddmru@smile.fi.intel.com>
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
In-Reply-To: <ZcofhWb8stiddmru@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/02/2024 14:39, Andy Shevchenko wrote:
> On Mon, Feb 12, 2024 at 09:34:24AM +0100, Krzysztof Kozlowski wrote:
>> Examples of other nodes, like GPIO controller, are redundant and not
>> really needed in device bindings.
> 
> ...
> 
>> -    i2c {
>> -            #address-cells = <1>;
>> -            #size-cells = <0>;
>>  
>> -            pcf8574: pcf8574@27 {
>> -                    compatible = "nxp,pcf8574";
>> -                    reg = <0x27>;
>> -                    gpio-controller;
>> -                    #gpio-cells = <2>;
>> -            };
>> -    };
> 
> In patch 3 you updated the lines that have lost their sense due to this one.

How did they lose it?


> And I agree with others, please leave this example in place.

What for? Why this binding is special and 99% of others do not need GPIO
expander in the example?

Best regards,
Krzysztof


