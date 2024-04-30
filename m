Return-Path: <linux-kernel+bounces-163509-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F33178B6C4D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 09:57:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AADF7283E51
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Apr 2024 07:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B89DD40BE5;
	Tue, 30 Apr 2024 07:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ibq7wA/x"
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 631553FE51
	for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714463812; cv=none; b=ECHEzE7rq/Wct6FGs7SV+VhppksWcF9NhhA3sN+gjNae81V6bFJ6A1+D6Hcpd0vSHfoe7hxhsJdU52Nfa8yFvTNaXyu8n86PZqu9rhr1HLxMqweELzyl0t1YBiKa69oLkHGaOGhbC0OND40+CDNhAGdPcgRi18780yrDRd/oi50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714463812; c=relaxed/simple;
	bh=PcaXhDvxLLTkfk407anVdJT3Akqt50K/hZKVXLLmpl0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CXdYbsf622hZKPCwedsnigLQ7qOSjXzpmAIE2CkJ7zkhUiYSSeYgY0CNChFPqIjbfcDljVh3gQ9MDyi8genWNezBCBjVxVhQoviDK7EUWtJrbiR5sqsyu2z69oMpGAJ4jqU33LkjhvSYAlRSM8ADlhTM7It4yFF3DJBvi3HGr3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ibq7wA/x; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-51abd9fcbf6so8909784e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 Apr 2024 00:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714463810; x=1715068610; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=KArDFBHj2K7Rv6IgAh6+qe6uqz0BJOoQlTHtZUsTg04=;
        b=ibq7wA/xvu5MjXvpLW+T3t1WhN2DQla6qpzC//frpVUam0FD5wzFd0/b6K/CLqXteq
         0ZpjoQWODQkikSCdjVe1Oez5zqoMNd+CIcZGlJiqGoeH47/EOjG/QhKAaSr/Md99w1Bu
         /obphp0hvCWlE/z1BPZ9imcJPARFFSejy4HRBQS8cYAlcSphbEJmuPKWuEjFzx74o12j
         4x3CbE5HMqvYtJLZOz9Y3Os8r5stSS4B2jKswj7WrJ1+gzlTumRlu5HHOEJpdsOfgcqQ
         tbZpJhveZWSJE1BKKTDMm/l+rJpKXxY2ZVLNv2W+M1XPPZ43BjPumc1lj8LpTF13C1cQ
         B3MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714463810; x=1715068610;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KArDFBHj2K7Rv6IgAh6+qe6uqz0BJOoQlTHtZUsTg04=;
        b=G3+kCzzlFhnSNMFxBAhNGZHE2FMV9uHHfw73xE9S1LARIRlPpyvkaK/7BBuxkJIXnu
         8/G2hFIEtag0oYyyvSQy9xDgg+QbXeMPRObliyv2LKr9QrMDbyxdPcnljTw3f5kZ0rOc
         72GkKXhQD+3YD9xYNZUlkK+slPlPrcYAZhlAKRa+hUDyXyGBu9ppTVSQOBO0qK7u5oUj
         I99hon0s3d6gst4qGEFQLRhlcqvaFu8Zl/rAK0KLgPosTagq79yvUOkj44x8BuX94ZWx
         b23oyh+l5VmqryFVjGRhqePB6EqOoDCKJcL1P4xiJDd81ehAHAlQLi1uyQhxKz1WHHnK
         UQ2Q==
X-Forwarded-Encrypted: i=1; AJvYcCWHxRnp4YUnYikHMyC4/5uFGDXUxopS5odWwk/cand0m8epDBY1rHPKrnaT7+6SpDQP8anxraVW9wMDG17t1IKOOcXJmPSuPCF7UIp0
X-Gm-Message-State: AOJu0YzNzKBsM55rwWqSgrzLodvu3vgduGGYjDdpU7MUZ9DL1hSz9uPW
	xC0Pc+S/cWJVj8AIJ6Giggbi7lbzXK8qMbK6V8YFatVMK7tNsKFL3sSnGcRQliI=
X-Google-Smtp-Source: AGHT+IEz4WuZ81Sf4WVyPvh/ffK2uIzS248oDIkryL7qv6DNpzKCs7VRUafDp1D9psnvaxHRc1wX1w==
X-Received: by 2002:a05:6512:4003:b0:51d:4383:9e59 with SMTP id br3-20020a056512400300b0051d43839e59mr7568415lfb.0.1714463809537;
        Tue, 30 Apr 2024 00:56:49 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id c19-20020a170906155300b00a526a99ccecsm14692918ejd.42.2024.04.30.00.56.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 Apr 2024 00:56:49 -0700 (PDT)
Message-ID: <95b95cde-c93c-404a-a520-4bf77c62a03a@linaro.org>
Date: Tue, 30 Apr 2024 09:56:47 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXTERNAL] Re: [PATCH 2/5] spi: cadence: Add Marvell IP
 modification changes
To: Witold Sadowski <wsadowski@marvell.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-spi@vger.kernel.org" <linux-spi@vger.kernel.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Cc: "broonie@kernel.org" <broonie@kernel.org>,
 "robh@kernel.org" <robh@kernel.org>,
 "krzysztof.kozlowski+dt@linaro.org" <krzysztof.kozlowski+dt@linaro.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "pthombar@cadence.com" <pthombar@cadence.com>
References: <20240329194849.25554-1-wsadowski@marvell.com>
 <20240329194849.25554-3-wsadowski@marvell.com>
 <7bd584b0-46e1-4dcb-a402-80784f7d11b7@linaro.org>
 <CO6PR18MB40984F6DAC8B8B2FA9C68477B01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Language: en-US
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
In-Reply-To: <CO6PR18MB40984F6DAC8B8B2FA9C68477B01B2@CO6PR18MB4098.namprd18.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/04/2024 16:55, Witold Sadowski wrote:
>>
>>> +
>>> +static bool cdns_xspi_get_hw_overlay(struct platform_device *pdev) {
>>> +	int err;
>>> +
>>> +	err = device_property_match_string(&pdev->dev,
>>> +					   "compatible", "mrvl,xspi-nor");
>>
>> No, do not add matching in some random parts of the code, but use driver
>> match/data from ID table.
> 
> Ok. As I have written in different mail, a little bit of manual matching
> Will be necessary to handle both ACPI and device-tree case.

ACPI also handle variants with match data.

> 
>>
>> ....
>>
>>>
>>> +	cdns_xspi_print_phy_config(cdns_xspi);
>>>  	ret = cdns_xspi_controller_init(cdns_xspi);
>>>  	if (ret) {
>>>  		dev_err(dev, "Failed to initialize controller\n"); @@ -613,6
>> +911,9
>>> @@ static const struct of_device_id cdns_xspi_of_match[] = {
>>>  	{
>>>  		.compatible = "cdns,xspi-nor",
>>>  	},
>>> +	{
>>> +		.compatible = "mrvl,xspi-nor",
>>
>> This falsely suggest they are compatible :/
> 
> I'm not sure if I understand what do you mean.
> cdns, xspi will be compatible with overlay, as it won't touch any
> additional HW. It possibly fail in second direction, as overlay
> handling code will not see expected values.

That's clear rule for almost every driver: if you do not have any match
data, it suggests entry is redundant, because devices are compatible.
There is no different treatment for SPI. As seen in other pieces of this
code, devices are not compatible, so it points to missing match data to
handle variants.

Best regards,
Krzysztof


