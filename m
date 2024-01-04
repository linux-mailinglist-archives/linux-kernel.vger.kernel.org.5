Return-Path: <linux-kernel+bounces-16656-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BBB8241F8
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 13:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69B5C1F2105A
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Jan 2024 12:40:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E9A222305;
	Thu,  4 Jan 2024 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fAz4Z6e+"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 495A721A0C
	for <linux-kernel@vger.kernel.org>; Thu,  4 Jan 2024 12:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a28ec136715so40923666b.1
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jan 2024 04:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704372038; x=1704976838; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6jNtxELLgfpOWYn4MICeyzZOft0fofykQYkjMnNx1JA=;
        b=fAz4Z6e+sE46S/Vek+yOdcmdqhpQLoUkSEuqRaoemBDay7IJkYmcs4zl0vJVfbzqNU
         A6RL+dc7bU4O8ROJxGcdZShdlulDLsMnNYBkc7eLQysI+Je2sdrcGHnahzchffNwMFbt
         XHSaaNYz5sVal8iT5mJR1z7hCGusztRdtDSbOCNqpppUpXMaczbyuzbNJyOo3vNGHrUA
         4T2gC6jgjz6fFxpX2lj337UAHo4+6cbwCZzzbanVrixSa3md4u56dW/ALQLVrBjptqD2
         8B3NJQ8n45d3pp1bqiZ+GHdcXqutBtdOJC2YlEIoW7jTwA8WzQI/KB0yZ8MwXeiuJ+/U
         iwYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704372038; x=1704976838;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6jNtxELLgfpOWYn4MICeyzZOft0fofykQYkjMnNx1JA=;
        b=quOR0RPlthM/8aN5lFYL69vIG5loBqGR1oWWQh0vAM+ovxiZpOo6oOHT35Xh+DYYo0
         8fLdDdCQj/5eUqeci9OnIgGqAxu0Ya6Qo57Mkmy2GwWj9/ZudGLR7r43fwY+CwnM8fli
         1ZUmA2er+A4nPr9l1Y6zRNDaADCtxYvWq+1z1eaFF6H7oBCojQg3GUV3SCzum+GxNEgc
         W2m+Py0mBIhI5Mavu9b0NjSSFgOJjbyOZw/deKIlQoltCKhOpxrvbLWMb8Ok9DxUkvMd
         rF3pSPjmluJGLK+tDRyiHeWOD4niz61yh32lw6mh5NdM25oPZzLn7eFSuUz2lyp5EIc6
         U3NA==
X-Gm-Message-State: AOJu0YzZUNokWUBnc2+6BAMXYvKwU7y4NjezETaYM0ePzZTZZUjpqfMM
	MgYqUx3BK8x4tmdhXl5au1FCrHBVvT961A==
X-Google-Smtp-Source: AGHT+IHPtNw72DKPtOGHEUpFS4ATo+uF/hn/sbTEeie8QfvlK3Bb+oal+limIA9d0Obdlr9Hv65x/A==
X-Received: by 2002:a17:906:33c7:b0:a27:4217:b22b with SMTP id w7-20020a17090633c700b00a274217b22bmr319652eja.18.1704372038526;
        Thu, 04 Jan 2024 04:40:38 -0800 (PST)
Received: from [192.168.1.20] ([178.197.218.27])
        by smtp.gmail.com with ESMTPSA id e2-20020a170906374200b00a1d2b0d4500sm13791500ejc.168.2024.01.04.04.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Jan 2024 04:40:38 -0800 (PST)
Message-ID: <36dfbb05-d538-4f83-9e0d-898e3d35f3dc@linaro.org>
Date: Thu, 4 Jan 2024 13:40:36 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] media: dt-bindings: media: camss: Add
 qcom,sc8280xp-camss binding
Content-Language: en-US
To: Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
 Rob Herring <robh@kernel.org>,
 Bryan O'Donoghue <pure.logic@nexus-software.ie>
Cc: Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Mauro Carvalho Chehab <mchehab@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, linux-media@vger.kernel.org,
 linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240103-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v1-0-abacaa63a961@linaro.org>
 <20240103-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v1-1-abacaa63a961@linaro.org>
 <87bcff40-b5ff-41c9-a33f-95f5e80a2f22@linaro.org>
 <62995a12-e835-40ff-966f-8522f2ab53dc@nexus-software.ie>
 <20240103175424.GA1440392-robh@kernel.org>
 <3627b156-a4e4-458e-9cf0-ca6c62366e7e@linaro.org>
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
In-Reply-To: <3627b156-a4e4-458e-9cf0-ca6c62366e7e@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/01/2024 12:33, Bryan O'Donoghue wrote:
> On 03/01/2024 17:54, Rob Herring wrote:
>> On Wed, Jan 03, 2024 at 09:40:02AM +0000, Bryan O'Donoghue wrote:
>>> On 03/01/2024 07:40, Krzysztof Kozlowski wrote:
>>>> On 03/01/2024 03:18, Bryan O'Donoghue wrote:
>>>>> Add bindings for qcom,sc8280xp-camss in order to support the camera
>>>>> subsystem for sc8280xp as found in the Lenovo x13s Laptop.
>>>>>
>>>>> Signed-off-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
>>>>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>> ---
>>>>>    .../bindings/media/qcom,sc8280xp-camss.yaml        | 512 +++++++++++++++++++++
>>>>>    1 file changed, 512 insertions(+)
>>>>>
>>>>
>>>> This patch fails, as pointed out by Robot.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>>
>>>
>>> Ah its in Bjorn's 6.8 clock pull tree.
>>>
>>> I will repost when it hits -next
>>
>> How is that helpful? It will still fail, and the media maintainers still
>> can't apply this. If you work on linux-next, you'd better be
>> aware of and explain the dependencies.
>>
>> Rob
> 
> Well, it actually is in -next as at the time I posted this patch

linux-next is not a tree of one maintainer. Maintainer's cannot base
their trees on linux-next.

> 
> https://git.codelinaro.org/bryan.odonoghue/kernel/-/blob/linux-next-24-01-02-sc8280xp-camss-core-dtsi/include/dt-bindings/clock/qcom,sc8280xp-camcc.h
> 
> per the branch referenced in the cover letter

Cover letter does not say anything about this depending on the patch in
linux-next or in any other tree.


> 
> https://git.codelinaro.org/bryan.odonoghue/kernel/-/tree/linux-next-24-01-02-sc8280xp-camss-core-dtsi
> 
> Looking at the name of the branch for your bot
> 
> 20240103-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v1-1-abacaa63a961@linaro.org

That's your message ID.

> 
> Does this branch name in the bot output 
> "linux-next-24-01-02-sc8280xp-camss-core-dtsi-v1" imply it built from 
> the branch I referenced in the cover letter 
> "linux-next-24-01-02-sc8280xp-camss-core-dtsi" ?
> 
> Am I getting the base of the build right ?
> 
> https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20240103-linux-next-24-01-02-sc8280xp-camss-core-dtsi-v1-1-abacaa63a961@linaro.org/
> 
> If not - what is the base of the build ?

master

Anyway, the base of the build matters less. The main problem is that you
have dependency which is nowhere explained. This cannot go via media
tree, because of that dependency.

Best regards,
Krzysztof


