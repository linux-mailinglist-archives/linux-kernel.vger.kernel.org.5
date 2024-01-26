Return-Path: <linux-kernel+bounces-40077-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C37A83D9CC
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 12:56:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 30D071C21D21
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:56:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5B3018E1F;
	Fri, 26 Jan 2024 11:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="E4i8Of7c"
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D3B91B963
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 11:56:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706270185; cv=none; b=fjlmZKLO7uk7PwXY2cQ67chdukbpbWRoDWEpeI7xPPoCOweizLgcNwwgiDOJc+cOyfdqKNaahNVpdYK/yzlHfrx3IkWfTe/qICaKBChNn+HGugDt3hqZmQontJlkOwmlFVdvqIjClzvvUxVpjZiTIiM20ui9XmH/5pxyGNZfmzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706270185; c=relaxed/simple;
	bh=RmGbAEvyMyBmZPV9rMtVayM5gvBAINtVmRS710SV+sM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mLYA8dkvfLG9h8RQpyN/amjnqEYs7F3F9s4KWCSmsCtOlL4VycuWGL0Y5qVlSCIlYJ/esCN26mNY5NREbHGPdc6ol6fXIhQIwps3ZgWML4c10zprTKu/vpE5s3/5W/0tLsUa0Ylkg/TDndoTfv87bg4Pxkbljv4uh2nAghh0WI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=E4i8Of7c; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-40ee6ff0c7dso2612555e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 03:56:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706270182; x=1706874982; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DO5Cw99+U4E+0Nt0Wph/a1bGBWtbN/z5sxXuqQozhd8=;
        b=E4i8Of7cpOA7zx9jqf89I9uAa1fdpjBU/e5zqku8N7CEnUWrepwJJsthyWVkXFWNLB
         1lccH3QzM4z3onDLTQMWKhbDDvtVb8iEfrVnkic2eC1jWc9fsMXdSRy7zLoxMluiYg+0
         mxEHN9Rx3W9jGOJYqf0l+nlOi3/UKoxHs5rNpQ+0tzfJ+Xi2MWCmeZoWCH+giIun3+u4
         xZex1Zp1HysV8HsCmmxW2ypDHUEKpH+7tnFXwdisQlbLPgQWjpNxcIIYm44fKkwIKBBL
         7Rdol7PBjJWsLfwrJLuSQH37jbOQVi9e5au48st2e1XIKWS3fM6eq+c7zFDTpx8dpDJp
         Wj5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706270182; x=1706874982;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DO5Cw99+U4E+0Nt0Wph/a1bGBWtbN/z5sxXuqQozhd8=;
        b=BN/MPTPeQrKTt+C9C4MHgYCFX6VqwZcbPcJsfFPH0R1lIDv/CJgIfxrrOWOj2Kiry4
         I0RDVswqP9oMriXiWXtodkc0u/KcYaPZjpl854wsgRkz7P7fUkjIDHY3j1uulUvdl9mX
         hB90jiweSPMAOsyVaUFaBeoo8J/YgO4lNUtay+LdNfDjgyITIZH/+418MCJPuDOhHT7Z
         CSW7ldT8rm2IXmBXwYlA6c7aj/NEzIW48aOrKkBElkkAc2+oC88shL7GXA7qQsAoQU85
         IALa+icvz5FtOWWtiyH42umicGH8SGzWKiyN/ozh8njSuE+/H82YvTGk9xjxapFRehDE
         xUcg==
X-Gm-Message-State: AOJu0YwpBMjBHBlEPJTBv92YLVigbmtYTxMTqbs/cZG7+C+HnSmRmimy
	4D9FH0vcmxrkvRjQFtLP1sWVNoYxG89Zxm1KcCQlFjH8vc76dkKFU5353vBq2pk=
X-Google-Smtp-Source: AGHT+IHmdKLzey2QUAfoaZyCALkG/ipXSmR5+Ufuq+v1N1QQdVg3ypQp3xdsFV2v37UQKEtWI2DvjA==
X-Received: by 2002:a05:600c:5191:b0:40e:8799:7348 with SMTP id fa17-20020a05600c519100b0040e87997348mr596666wmb.68.1706270182598;
        Fri, 26 Jan 2024 03:56:22 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id vo1-20020a170907a80100b00a2c11a438a8sm556451ejc.25.2024.01.26.03.56.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 Jan 2024 03:56:21 -0800 (PST)
Message-ID: <3e8dfaf3-85a4-42bf-829c-4835f3de2d35@linaro.org>
Date: Fri, 26 Jan 2024 12:56:19 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/17] clk: eyeq5: add platform driver
Content-Language: en-US
To: =?UTF-8?Q?Th=C3=A9o_Lebrun?= <theo.lebrun@bootlin.com>,
 Gregory CLEMENT <gregory.clement@bootlin.com>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 Linus Walleij <linus.walleij@linaro.org>, =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=
 <rafal@milecki.pl>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: Vladimir Kondratiev <vladimir.kondratiev@mobileye.com>,
 linux-mips@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Tawfik Bayouk <tawfik.bayouk@mobileye.com>, linux-gpio@vger.kernel.org
References: <20240123-mbly-clk-v3-0-392b010b8281@bootlin.com>
 <20240123-mbly-clk-v3-8-392b010b8281@bootlin.com>
 <127fd51b-cd64-4e00-99d6-7be9b79f2dcc@linaro.org>
 <CYN33YJ10HYS.2YDXB158LFZPL@bootlin.com>
 <001993b9-ea0c-49c3-a4e5-4cea10c54082@linaro.org>
 <CYNRLZ2XTOGY.3ANWB33IDCN2W@bootlin.com>
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
In-Reply-To: <CYNRLZ2XTOGY.3ANWB33IDCN2W@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/01/2024 12:53, Théo Lebrun wrote:
> Hi,
> 
> On Thu Jan 25, 2024 at 8:46 AM CET, Krzysztof Kozlowski wrote:
>> On 24/01/2024 17:41, Théo Lebrun wrote:
>>> Hello,
>>>
>>> On Wed Jan 24, 2024 at 8:05 AM CET, Krzysztof Kozlowski wrote:
>>>> On 23/01/2024 19:46, Théo Lebrun wrote:
>>>>> Add the Mobileye EyeQ5 clock controller driver. It might grow to add
>>>>> support for other platforms from Mobileye.
>>>>>
>>>>> It handles 10 read-only PLLs derived from the main crystal on board. It
>>>>> exposes a table-based divider clock used for OSPI. Other platform
>>>>> clocks are not configurable and therefore kept as fixed-factor
>>>>> devicetree nodes.
>>>>>
>>>>> Two PLLs are required early on and are therefore registered at
>>>>> of_clk_init(). Those are pll-cpu for the GIC timer and pll-per for the
>>>>> UARTs.
>>>>>
>>>>
>>>>
>>>>> +#define OLB_PCSR1_RESET				BIT(0)
>>>>> +#define OLB_PCSR1_SSGC_DIV			GENMASK(4, 1)
>>>>> +/* Spread amplitude (% = 0.1 * SPREAD[4:0]) */
>>>>> +#define OLB_PCSR1_SPREAD			GENMASK(9, 5)
>>>>> +#define OLB_PCSR1_DIS_SSCG			BIT(10)
>>>>> +/* Down-spread or center-spread */
>>>>> +#define OLB_PCSR1_DOWN_SPREAD			BIT(11)
>>>>> +#define OLB_PCSR1_FRAC_IN			GENMASK(31, 12)
>>>>> +
>>>>> +static struct clk_hw_onecell_data *eq5c_clk_data;
>>>>> +static struct regmap *eq5c_olb;
>>>>
>>>> Drop these two. No file-scope regmaps for drivers. Use private container
>>>> structures.
>>>
>>> I wouldn't know how to handle the two steps then. Two clocks and the clk
>>> provider are registered at of_clk_init() using CLK_OF_DECLARE_DRIVER().
>>
>> Right, if some clocks have to be early, CLK_OF_DECLARE_DRIVER needs
>> static ones. But your commit subject says it is a platform driver and
>> all other pieces of this code is rather incompatible with this approach.
> 
> That is my bad on the commit subject. What do you refer to by "all other
> pieces of this code is rather incompatible with this approach"?

That you depend on syscon.

If it was regular MMIO block in SoC space, then no problem.
If you depend on anything else providing you regmap, then any initcall
ordering is fragile and error-prone. Avoid.


> 
> I've tried to minimise the use of static variables. Therefore as soon as
> the probe is started, we switch to the usual way of using a private
> struct that contains our info.
> 
>>
>> Do not use CLK_OF_DECLARE_DRIVER for cases where you have dependencies
>> because it forces you to manually order initcalls, which is exactly what
>> we do not want.
> 
> What should I be using? I got confirmation from Stephen that this
> mixture of CLK_OF_DECLARE_DRIVER() + platform driver is what I should
> be using as review in my V1.
> 
> https://lore.kernel.org/lkml/fa32e6fae168e10d42051b89197855e9.sboyd@kernel.org/

I see. In such case I believe it is error on relying on syscon.

Best regards,
Krzysztof


