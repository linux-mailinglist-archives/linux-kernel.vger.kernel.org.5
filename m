Return-Path: <linux-kernel+bounces-72928-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B7D685BAD1
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 12:44:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B3117B2348A
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 11:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8152967756;
	Tue, 20 Feb 2024 11:43:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="td1/kRKS"
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F5B664D5
	for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 11:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708429438; cv=none; b=DfPporHg3OdM1EsiHb7pIkZV2TpdlVGB2fRB4QoJDx/M+1uxEnnLVYc9cJ1okbDzAamxOIJviDB9Ob7+6TCEpvNtKyfCc3Bm/6dpyryD0xGBINjpNZacE6+K2VurZdG3DTlBSJcDWl+R122pjaBFOHt18ddc40LAml3fLIu+f90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708429438; c=relaxed/simple;
	bh=l8WXt+TP2bSIW1p+u1vJd9fYDCI10/lnO4GBG6lTqYc=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=GLN7AB8BY10wYuElxoYgWq44O1srMfTQnTD1BknVwRmRHl3dNIMeIae6B0L0M8MXGv8lzjrt1Hb+7tTsM9Ie4X3tJsDUE4VOmoVF1x0WOTWOnVo+jVodn3lG9nHCk1EZ0SX1ZtRtAiLSlvhM4o0qjrDxUeg6ao24JHO9shD0t2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=td1/kRKS; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-512be9194b7so1577363e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 20 Feb 2024 03:43:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708429435; x=1709034235; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3WB8nJ0ANh5/S89R2NJWyma4JryWfBwWIGoZsHtEYts=;
        b=td1/kRKS+zwtfLwzoyeJ+ORwOGUIp3WSLY3EO2LatUTNKGpVkj8UUvyaYJGCUyRhcb
         XhIKfcswd+znTeyc2yxh2kIbSL314dMkkYeO6mEgGkUqGnmyyr5wfuVu4Vz1FfyFC7p+
         kMjNFiLC9He/hCmwFSP2yjFViWUeCeTKh4T7kR3oiZzTulk7RDthYJdO2Yal3Xyi0T+I
         KhcBnlvzTz6RUTaoVlq16qbDmcNtcSt2o7wtOozeJOzJ6d0BYU5kxwBL2EdccpNp5Y1l
         KEKsdll1Bc5aPNkkQ6ypeGpvLsGllywc0loh+Fp79wHMLAOy7vKvfx4tAoDGq8gDgzsl
         FiEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708429435; x=1709034235;
        h=content-transfer-encoding:in-reply-to:autocrypt:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3WB8nJ0ANh5/S89R2NJWyma4JryWfBwWIGoZsHtEYts=;
        b=NYXTy+4EgGfJ3S31Uxn+hey2m3C+SIKhmD5LGgZ/bw/IJfvVJdaFZwdJMHM/GVRoiw
         Sp9+i/s8u8lQ49zcoRu5CbOJjJ0E7VX7VMAPW3eW3KhO0RecZAi2M8cFZCIdyMcrL3y7
         SnAzMvvT66HtYcjJZkFsjxswrCdxOdqRFgA+j+ZCypXGzfsFz2BDZF+eyWIis+l7B/om
         i7yodEAShDT7rN56QQIQ8GW2vUECBZb3Z4BiO5y2HWVkeQmodfYOR+vPuTjfcxbyEESr
         VYyIbkdqIMMRZdxpp7N+sBg1p0uL2b1B6PocArmarxr1tOu26CM5KMDqTnErVtB1ctfb
         Cf+w==
X-Forwarded-Encrypted: i=1; AJvYcCWXdMbtTicfc3ezkybd3ikfTODrNBiybvjilJquERbUoItm1igSCGAuBOEvJOCrO1hEDAhhEtoyEpqBtgBZomXcEUYJkgJV/qkoV89Q
X-Gm-Message-State: AOJu0Yym/2ZD9IC7XEbtqczUPp0ky5tFmMl7z09u87R+EiIAZmERJQF0
	pidJhfSmFllMMbxJihCzNhgyOchkQfODky4c2b8gVSiK0K9AZrh2o1ecm5nIHo0=
X-Google-Smtp-Source: AGHT+IHc9hjoE2WPKUCli5b6ilv8V304tk7I2FhBXp0JPabrp3Rvqxtce9GJa0qWfjk3k+jmysjx9A==
X-Received: by 2002:ac2:59dd:0:b0:512:a95a:8308 with SMTP id x29-20020ac259dd000000b00512a95a8308mr4671660lfn.2.1708429434778;
        Tue, 20 Feb 2024 03:43:54 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id e26-20020a50d4da000000b00564024b7845sm3836613edj.38.2024.02.20.03.43.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 03:43:54 -0800 (PST)
Message-ID: <b4fe5565-9378-4786-8c55-113f9088f34a@linaro.org>
Date: Tue, 20 Feb 2024 12:43:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 1/5] dt-bindings: phy: hisi-inno-usb2: convert to
 YAML
Content-Language: en-US
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To: Yang Xiwen <forbidden405@outlook.com>, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>, Shawn Guo
 <shawn.guo@linaro.org>, Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240220-inno-phy-v3-0-893cdf8633b4@outlook.com>
 <20240220-inno-phy-v3-1-893cdf8633b4@outlook.com>
 <62221084-247c-4a0b-a030-e12cb2931411@linaro.org>
 <SEZPR06MB6959AAB6B43F3E1F5E1C526596512@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <6f3f22f6-f659-494d-963c-544cf5f44adc@linaro.org>
 <SEZPR06MB69592FACB1EF1B9FEDA89E5996512@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <9a5e9363-79eb-416c-89ae-c826062350b5@linaro.org>
 <SEZPR06MB69594A5036F122CE6C14043C96502@SEZPR06MB6959.apcprd06.prod.outlook.com>
 <bf4ce87a-51ab-49e1-ac70-c463d8008a62@linaro.org>
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
In-Reply-To: <bf4ce87a-51ab-49e1-ac70-c463d8008a62@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/02/2024 12:41, Krzysztof Kozlowski wrote:
> On 20/02/2024 11:40, Yang Xiwen wrote:
>> On 2/20/2024 4:16 PM, Krzysztof Kozlowski wrote:
>>> On 19/02/2024 22:49, Yang Xiwen wrote:
>>>> On 2/20/2024 5:37 AM, Krzysztof Kozlowski wrote:
>>>>> On 19/02/2024 22:35, Yang Xiwen wrote:
>>>>>> On 2/20/2024 5:32 AM, Krzysztof Kozlowski wrote:
>>>>>>> On 19/02/2024 22:27, Yang Xiwen via B4 Relay wrote:
>>>>>>>> From: Yang Xiwen <forbidden405@outlook.com>
>>>>>>>>
>>>>>>>> Add missing compatible "hisilicon,hi3798mv100-usb2-phy" to compatible
>>>>>>>> list due to prior driver change.
>>>>>>>>
>>>>>>>> Also rename to hisilicon,inno-usb2-phy.yaml and add this name to
>>>>>>>> compatible lists.
>>>>>>>>
>>>>>>>> Fixes: 3940ffc65492 ("phy: hisilicon: Add inno-usb2-phy driver for Hi3798MV100")
>>>>>>>> Signed-off-by: Yang Xiwen <forbidden405@outlook.com>
>>>>>>>> ---
>>>>>>>>     .../bindings/phy/hisilicon,inno-usb2-phy.yaml      | 95 ++++++++++++++++++++++
>>>>>>>>     .../devicetree/bindings/phy/phy-hisi-inno-usb2.txt | 71 ----------------
>>>>>>>>     2 files changed, 95 insertions(+), 71 deletions(-)
>>>>>>>>
>>>>>>>> diff --git a/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>>>>>>> new file mode 100644
>>>>>>>> index 000000000000..1b57e0396209
>>>>>>>> --- /dev/null
>>>>>>>> +++ b/Documentation/devicetree/bindings/phy/hisilicon,inno-usb2-phy.yaml
>>>>>>>> @@ -0,0 +1,95 @@
>>>>>>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>>>>>>> +%YAML 1.2
>>>>>>>> +---
>>>>>>>> +$id: http://devicetree.org/schemas/phy/hisilicon,inno-usb2-phy.yaml#
>>>>>>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>>>>>>> +
>>>>>>>> +title: HiSilicon HiSTB SoCs INNO USB2 PHY device
>>>>>>>> +
>>>>>>>> +maintainers:
>>>>>>>> +  - Yang Xiwen <forbidden405@outlook.com>
>>>>>>>> +
>>>>>>>> +properties:
>>>>>>>> +  compatible:
>>>>>>>> +    items:
>>>>>>>> +      - enum:
>>>>>>>> +          - hisilicon,hi3798cv200-usb2-phy
>>>>>>>> +          - hisilicon,hi3798mv100-usb2-phy
>>>>>>>> +      - const: hisilicon,inno-usb2-phy
>>>>>>> According to your driver hisilicon,hi3798mv100-usb2-phy and
>>>>>>> hisilicon,inno-usb2-phy are not compatible.
>>>>>> Ah, i didn't pay too much attention to that. I should remove the entry
>>>>>> for hisilicon,inno-usb2-phy in the driver. Sorry for that.
>>>>> We don't talk here about driver, although I used the driver as proof or
>>>>> argument, because I don't have access to hardware datasheet (and no
>>>>> intention to look there).
>>>>>
>>>>> What I claim is these are not compatible, so respond to this argument,
>>>>> not some other one.
>>>> Why not? Of course they are compatible. All 3 SoCs are using
>>> Why? Because...
>>>
>>>> inno-usb2-phy. The only difference here is the method to access the
>>> ... here! Different programming interface means not compatible.
>>>
>>> Please provide instead any argument that they are compatible, in the
>>> meaning of Devicetree of course. You are claiming inno-usb2-phy  can be
>>> used for hi3798mv100 and it will work fine?
>>>
>>>> registers. They are all enabled by `writing BIT(2) to address 0x6`. In
>>>> the cover letter, I said the driver is actually doing things wrong.
>>> Cover letter does not matter, I don't even read them. Your commits matter.
>>>
>>>> Especially the commit adding PHY_TYPE enums, the name is confusing and
>>>> conveys the wrong info. It's not PHY which are not compatible, it's the
>>>> bus. I'll fix the driver, but still the PHY hardwares are compatible
>>>> between these 3 SoCs.
>>> Provide any argument.
>>
>> Just take a look at the driver. hisi_inno_phy_write_reg() is the 
>> function that differs between different models. But for all of them, 
>> hisi_inno_phy_setup() is the same.
>>
>>
>> hisi_inno_phy_write_reg() should be moved to a separate bus driver. It's 
>> bus-related, not phy. PHY driver should not care how to access the bus, 
> 
> So drivers are compatible or hardware? We talk about hardware, not
> drivers...
> 
>> but the bus driver should. The PHY driver only needs to use regmap_* 
>> APIs to "write BIT(2) to addr 6".
> 
> Different programming interface, so not compatible.

Although maybe I jumped to conclusions too fast. Do you claim that all
registers are the same? All the values, offsets, fields and masks?

Best regards,
Krzysztof


