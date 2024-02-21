Return-Path: <linux-kernel+bounces-74218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 28A2185D13F
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 08:24:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B9221C23752
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Feb 2024 07:24:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEC13A8F5;
	Wed, 21 Feb 2024 07:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RubxwRXr"
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49CBB39FEF
	for <linux-kernel@vger.kernel.org>; Wed, 21 Feb 2024 07:24:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708500272; cv=none; b=GhP2YaPXoj88InQqSKe/azqqHgeqcuOxXWcwB/kTKoQwM1Ho0n4zIGEd34LHqhTaCNQgMIHv288hk9s5Xv6ohhTRpFII/CY5XgUT4hrYKrLyeHfa8V386zlIWVjB/GzUL2lmMb812Yx+3q/xPi9FkwIGB41yHcSOddRwZ7LxkXE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708500272; c=relaxed/simple;
	bh=KM8TUDFkFdaV4IFO9KRdnz+hRjEOdtNqZk2rlhy85nA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZC1y1DMzJIPj3dti625criqoI2AS+ng/PrfuKkvrM3IHtOQIBaVbPdWd/CLwS99BSN6cqVG7W37vW9Lg6vaYDURgzHKlwNyP9j5Yo8SnnXJPOvNBROpmggljVhoVkZfVRMUM80k2xHj2FkEG7CKHhCBMkdvAMJQRga0LmZ8q79g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=RubxwRXr; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-563b7b3e3ecso7843184a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 23:24:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708500268; x=1709105068; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fg7UA2pgP6jgQm6h9UxtYlknGOnovxlEnNFLzHUpWNA=;
        b=RubxwRXrRiQ7hfD24+veTNINK7BzyIHy3qobGrrmXw7Qi8mBLpEUesVRGNO8kmY8QT
         ntnbGFgLelPwjumGiyPSXe3/tshrXf3CSFqpVS71n32Zg+9UAMZe6JKL6QMybNT+RHZL
         /t5KIo0/DRvg4TiXbLdRZ0Aew12sdwVbB369TAienOZnG/FBp/eu7k8rxDHrvR8BoKew
         gZIFp1XZ4D76LYeu0fBIpwfMJmc3ApiW2BvKTSc8KhPKaHXKOpix5FQZ0jDUJ/efjOFY
         2x53xlD+rO68lA+75iFz3LLWeki6sJTvBC7ER7ytvjQaxBw5KLgRT8alzGqDCR20zSwO
         YTSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708500268; x=1709105068;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fg7UA2pgP6jgQm6h9UxtYlknGOnovxlEnNFLzHUpWNA=;
        b=o8Jt6TnhpuEDG+clLBtOJuanR4YprkqGNWXk1Uw8llOG9nYVBlH0KB9gHOTRAac31w
         P3TpF42vL/+KX7J6TIYhq4sXlKKCM/ZoWFMfth7cY9Pa/mfR0H0cvV7lTgLqIcGVlDFv
         Zf0WNSsl4snwAI8ngAkKMMhV7j6vtvv2RZdUtWajjoPQalMrGfgGP8iXphHBksklfH2H
         lAJCxTlnVGkHYqK3Ppuqlu0e2tcfGzezCcyISg3gEuhkRMQrM+REUk1olhG3mYFPHZ0F
         w35uFvXnmjrzYjyjfByHQDOfdfvBldYYTHziwyuDk5ny5SUYM5Djc7oLJmaGBMHPrweD
         o0Bg==
X-Forwarded-Encrypted: i=1; AJvYcCWxohdbJsH5J16QN7+mF4HL9FeYENU4xAK1Zk826XKylhfEqpVyYSF3GR/7Ln9IA5BFheZllfu5w3UQL4j8V3A9Qqo7QwcRIPHIF1FE
X-Gm-Message-State: AOJu0YyqDQge4hMUSiTsDTuGAXkiamPH2M8SW1/jzrzKpkZvqe3tITod
	Rfgg+b1Mo6SfTAEURswhxCfHIt+3npDwsU86j1G0ubfVDVVo3U5Jhuqkxo2s3Nc=
X-Google-Smtp-Source: AGHT+IEPtwDbNlQcgwoArYWIPoLh6nol4vCWQ9AODZ3rdMyVSunRDo0eHxIHvncYo+zi9nQGEL6FrA==
X-Received: by 2002:a05:6402:214f:b0:563:c0f1:917b with SMTP id bq15-20020a056402214f00b00563c0f1917bmr11128011edb.0.1708500268681;
        Tue, 20 Feb 2024 23:24:28 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id g14-20020a056402428e00b005642bcfed99sm3856648edc.23.2024.02.20.23.24.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 23:24:28 -0800 (PST)
Message-ID: <cafccf8d-b8f7-44cb-bc41-3c7a908fd1e4@linaro.org>
Date: Wed, 21 Feb 2024 08:24:26 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v2 1/6] dt-bindings: pinctrl: starfive: Add JH8100
 pinctrl
Content-Language: en-US
To: Conor Dooley <conor@kernel.org>
Cc: Alex Soo <yuklin.soo@starfivetech.com>,
 Linus Walleij <linus.walleij@linaro.org>,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
 Hal Feng <hal.feng@starfivetech.com>,
 Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 Jianlong Huang <jianlong.huang@starfivetech.com>,
 Emil Renner Berthing <kernel@esmil.dk>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Drew Fustini <drew@beagleboard.org>,
 linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org, linux-riscv@lists.infradead.org,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>
References: <20240220064246.467216-1-yuklin.soo@starfivetech.com>
 <20240220064246.467216-2-yuklin.soo@starfivetech.com>
 <1a11cee2-2ef1-4ce0-8cc1-63c6cc97863f@linaro.org>
 <20240220-bottling-reverence-e0ee08f48ccc@spud>
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
In-Reply-To: <20240220-bottling-reverence-e0ee08f48ccc@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/02/2024 20:10, Conor Dooley wrote:
> On Tue, Feb 20, 2024 at 09:11:43AM +0100, Krzysztof Kozlowski wrote:
>> On 20/02/2024 07:42, Alex Soo wrote:
>>> Add documentation and header file for JH8100 pinctrl driver.
>>>
>>> Signed-off-by: Alex Soo <yuklin.soo@starfivetech.com>
>>> ---
>>
>>
>> RFC? Why isn't this patch ready for review?
> 
> The TL;DR is that Emil and I didn't want to apply the dts patches to
> support a platform that hadn't actually been taped out yet. 
> For an SoC in that state, at least the bindings for, clock and pinctrl
> could be subject to changes before tapeou. I think putting RFC on those
> patches is a good idea, but of course the rationale should be mentioned.

That would be useful information. We also could mark some bindings
unstable and accept breaking ABI under certain conditions, like that it
is early work without users for long time.

Best regards,
Krzysztof


