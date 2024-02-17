Return-Path: <linux-kernel+bounces-69907-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0369F85901E
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 15:32:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 314061C20D24
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 14:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E01F581E;
	Sat, 17 Feb 2024 14:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fMsdwxeF"
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40E1F1D55C
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 14:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708180337; cv=none; b=W4bAdMZGz+kiatEFQkYzMcLGzELOgNQL68qHbkKGhQqrTjokfbiYzyoMQVXTH6sA7TQgP5cNoyTOVa7llfioIDld5KA45mt6zt2mkWueICjCwOn/t9l8BfUhcQvLLsT3X98jgeRIGKthiRfmxSCQ0ksjATdXS4kYVXigvcmWoqU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708180337; c=relaxed/simple;
	bh=JH2BJbUC8p9rzyAfRaxkjJtIvKq+V+0O0YUQN2Wqnx8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=t0eXjusFLkBcg2XE1iSY+dkscM2Yo4upwrarKcMmHX58jThEomN1L+/cp9Gna4iVuCN01GU8k9ePsLMDg4U903K1lgII3+TX7n2uhoXU6WB3Ns4rdbACsoRUTp4Uryvv8JZWMKRU2eBTyLp96QBHUpqpIxqq2NHJwPi5UCKm+YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=fMsdwxeF; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a26f73732c5so266753366b.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 06:32:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708180333; x=1708785133; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RSNmyfW1+GrF91z+IHvlzjs+mSUvBVEEbhJ3txgTkRM=;
        b=fMsdwxeFrLPBPaeOAcDZnpMzSljFgpakqTYNlohkngX9fXsdRktyWYu/RXGXj1Sg//
         PQ5628L0Uv9iZ/u1V9bfLvtD+DeikiE65R5SulUy+gkuHZTUXSbI7cptOWWB2uv2n079
         aE0irlFNiPUJ0jXn+urOrwHdhKGOBNlFTTaPKggmZFuYgLtG6/+7nr3tPtBmiZXu/Dvz
         gsyIq0FRxM1dV9ygDCwkcUO2YaXGQcfijMYLnO/qfzp86CKlXfn0ei8ehKPje2TLKO8V
         Byov1WoTHRNnSPINNHRWVqrpL53E4WXEfD7lsuWXRiHWe9T1uLUhO5vUCtCxFI8stFZ+
         zRYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708180333; x=1708785133;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RSNmyfW1+GrF91z+IHvlzjs+mSUvBVEEbhJ3txgTkRM=;
        b=lkWzI9YnZQJ4kmyj/7Pjweh9eU2jtPm2ri4TbNlL5Mw6q60VqE1pNSdtDt55+CgEPO
         5WbM4iBV9qlZLwnFpda2D6ZRRpqrDCi/PY7JYcxnpGYgVdNMVKp1P9yl/kGBKlYHG8IY
         a1mLRVQaa6DdRD8yyBaiLY2VkJEFdPsp5MFMAyqFzWrs6DrQ7tcjhVdPZ262VWl9ag5m
         uVW/led4aa1HB32HiLDUtFeCDzHL10blhVzEwvz0HURiLbiNKwt+zWeKKnj9nX6Dv95U
         1yISQl++nuH7QEmBnXkncuxiolzkHDjfojCldu1TwGsWoHlvXVF1GInW4xdG6XBwCIq0
         v8LA==
X-Forwarded-Encrypted: i=1; AJvYcCVrhdecNsV4FEyfd8udBYvouXeCL6agwAO7/4JIqRq1nIHHCUFe7IDS0xWNUrVcCUihgCPC4uE/Kd94t2+ul72tHCW3eatmQJP6GO8J
X-Gm-Message-State: AOJu0Yz5imLiR5mPzIRAHF4ugOBK936MZV7NP5z9ZRmJ5/WHfvVIWETu
	6YsVyzX/f+y1NiF16VeEt9aH56jI2dIF1ZWq3OnLygq1H1oVTuEZr5E8PUqyU/s=
X-Google-Smtp-Source: AGHT+IEHTPTKY/XIeJkkRZAe1uiHoV3OVu9/bNG2euicSLCo47n2vzzbLFkKN/YU4XpKxxNmY73JvQ==
X-Received: by 2002:a17:907:bb8d:b0:a38:a6b2:b329 with SMTP id xo13-20020a170907bb8d00b00a38a6b2b329mr4507277ejc.8.1708180333463;
        Sat, 17 Feb 2024 06:32:13 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id y14-20020a170906448e00b00a379ef08ecbsm1028569ejo.74.2024.02.17.06.32.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 06:32:13 -0800 (PST)
Message-ID: <99df43cc-37fd-4f50-a086-2864a6545673@linaro.org>
Date: Sat, 17 Feb 2024 15:32:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: sophgo: Add top misc
 controller of CV18XX/SG200X series SoC
Content-Language: en-US
To: Inochi Amaoto <inochiama@outlook.com>, Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen Wang <unicorn_wang@outlook.com>,
 Paul Walmsley <paul.walmsley@sifive.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
 Jisheng Zhang <jszhang@kernel.org>, Liu Gui <kenneth.liu@sophgo.com>,
 Jingbao Qiu <qiujingbao.dlmu@gmail.com>, dlan@gentoo.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-riscv@lists.infradead.org
References: <20240215151316.GA89268-robh@kernel.org>
 <IA1PR20MB49533FE55F2A0D7FA0CD6949BB4D2@IA1PR20MB4953.namprd20.prod.outlook.com>
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
In-Reply-To: <IA1PR20MB49533FE55F2A0D7FA0CD6949BB4D2@IA1PR20MB4953.namprd20.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2024 00:56, Inochi Amaoto wrote:
>> On Wed, Feb 14, 2024 at 02:33:14PM +0800, Inochi Amaoto wrote:
>>> CV18XX/SG200X series SoCs have a special top misc system controller,
>>> which provides register access for several devices. In addition to
>>> register access, this system controller also contains some subdevices
>>> (such as dmamux).
>>>
>>> Add bindings for top misc controller of CV18XX/SG200X series SoC.
>>>
>>> Signed-off-by: Inochi Amaoto <inochiama@outlook.com>
>>> ---
>>>  .../soc/sophgo/sophgo,cv1800-top-syscon.yaml  | 40 +++++++++++++++++++
>>>  1 file changed, 40 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
>>> new file mode 100644
>>> index 000000000000..619237532801
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/soc/sophgo/sophgo,cv1800-top-syscon.yaml
>>> @@ -0,0 +1,40 @@
>>> +# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/soc/sophgo/sophgo,cv1800-top-syscon.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Sophgo CV1800/SG2000 SoC top system controller
>>> +
>>> +maintainers:
>>> +  - Inochi Amaoto <inochiama@outlook.com>
>>> +
>>> +description:
>>> +  The Sophgo CV1800/SG2000 SoC top misc system controller provides
>>> +  register access to configure related modules.
>>> +
>>> +properties:
>>> +  compatible:
>>> +    items:
>>> +      - const: sophgo,cv1800-top-syscon
>>> +      - const: syscon
>>> +      - const: simple-mfd
>>
>> You have to define child nodes to be a simple-mfd.
>>
>> You could drop it, but I now suspect your binding is incomplete.
>>
>> Rob
> 
> Hi Rob,
> 
> I have a small questions: Can I drop "simple-mfd" and just add it
> when the new subdevice is added? I know the binding is just a example,

No, because bindings should be complete.


Best regards,
Krzysztof


