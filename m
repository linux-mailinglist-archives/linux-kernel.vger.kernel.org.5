Return-Path: <linux-kernel+bounces-67030-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 94EDC856509
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 14:56:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E94E81F2128B
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 13:56:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF30A131E52;
	Thu, 15 Feb 2024 13:55:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="n2eU6RR3"
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FD5131E2E
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708005299; cv=none; b=iLKslCnMF5p3oaP/M5YH1uJviw6EehaLmQxwTCrJNf1za5HhvupXpSraQGlI9h1jc9A7nVqBIq22f01KQmREUIz0IqMAvwd/JraTen5q6CtAn1lbIQUOV0hgNM4HwwzNcC3zxrTX7GqJ+I65LNTKUoZJH9PV70Ta8OxGmbu/WZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708005299; c=relaxed/simple;
	bh=duS7hsGi562khyPMFx5/42rndZW46fwuTTC+QGKO4os=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LWhkSKoyh+LFX/9ROZFnw1MxfGjg1KqWzSb/C59gHYuhSEf/iuHZlsyEx4M6eYpcxS9741nPPAKugY/MMAEdnzrF7O6+65zmRhcC06t5A8PJLJT4GZc8Y0AWNxhN1kVtjWxdpstr5Mof1VrjBDalXo9OyqNor+OiC5csIq3hfvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=n2eU6RR3; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-51167e470f7so1001781e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 05:54:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708005296; x=1708610096; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=CA2y7YzHfutfNzxJnRBTaXam15k5LlrgXz6W6aQTYgw=;
        b=n2eU6RR3NkgOfxL2Qp/68FvjZKqIJTmcJDURcQp7GTI8hKvSp9geRlamIbr5RsIbKn
         zcJifSigZ1gPl2XMd1X5SJ5rXoTvdDCFQupEfEWwirsQDCeK4+ZHLWcxKjvEL73gEbi/
         EpZmfEENO2M4qWxxids68tUfEwGUTBxqSHK2nYCz+gauUfAOulDsxlR7xC7smLSH74PC
         G9WOFfnJOG3uU4nFnJPKYjrPtUpJc2+//ZvTOlBFzL+6JzRvxGKUzrW8GfnzSgfZP3Zw
         H/9pi2y76IfPMXOVhwwZTsFlXDCxvPdnbGYkWoBRSRGYQbpSxFo/BNGlVgFop7YqPaPm
         Yd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708005296; x=1708610096;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CA2y7YzHfutfNzxJnRBTaXam15k5LlrgXz6W6aQTYgw=;
        b=epxowYDCfiqYjtX3U/Kb6yJemlN9rs0a6SSX8ZNOta1C7fF7yRRHrjciRPsVJaJIit
         3R5iyHogBgnYN6KlCsaHrJ2nU3dgWs1WgIijefiNXVDUzXDUVw/7QnLW1lXfDpl/W+1V
         YCGQuRTTA4YAJKsf/4j85i4LVskGh8+hnPmye3LMOI4iFJjwwHIt0yfs2BnbwZpVVfIQ
         u64weMwWI89OmOnH/Pj3zDZB2AFTenALJZeilMbRPew76F85PDMTQsiUWCXIdX7uzqUI
         7x/QlTDgdLQcSFPJnyPeWCzXzT5pqApFG8FfNvv3FF9qS3Cqla9nGZZWK9z5P4ka3RZV
         K7iQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+xp+cMDxqxQ4JSgpMIJq2Ik2TLbe3tNRC/yzHkua3eLFFx2yyf7miJIt2BDebk7MDy10WYMQQjCUCo0YTLbzWeSAY64qqlztn4P6T
X-Gm-Message-State: AOJu0Yy3Z46eHzdbOQXx2NFGSXoiKo3bvKl/0NkXkoovhdee4ZJ62Xt6
	SupHuuM+LWx9nrfrbRRgMkFIwLRmQHf8Bw00AaZCoZ3q48MZpIa2pdIRMfGc0lkMrdP8WWvOcFE
	b
X-Google-Smtp-Source: AGHT+IEMKjDhCV+GSvZ3TlYu96f0BQ6XxbcaCDQ/TTR6ZmkpgoIZjIMEVaLMOIHRA3uxpg8Mnm599Q==
X-Received: by 2002:ac2:5a51:0:b0:511:8dbe:4339 with SMTP id r17-20020ac25a51000000b005118dbe4339mr1297350lfn.27.1708005295809;
        Thu, 15 Feb 2024 05:54:55 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id t6-20020a199106000000b005117c1ee90csm253415lfd.206.2024.02.15.05.54.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 05:54:55 -0800 (PST)
Message-ID: <e40cbd31-268a-4f83-9e45-34912c8d9e51@linaro.org>
Date: Thu, 15 Feb 2024 14:54:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-next: build failure after merge of the w1 tree
To: Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 Christoph Winklhofer <cj.winklhofer@gmail.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20240215132952.6c83ab23@canb.auug.org.au>
 <2024021506-probiotic-wasp-9439@gregkh>
Content-Language: en-US
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
In-Reply-To: <2024021506-probiotic-wasp-9439@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/02/2024 09:05, Greg KH wrote:
> On Thu, Feb 15, 2024 at 01:29:52PM +1100, Stephen Rothwell wrote:
>> Hi all,
>>
>> After merging the w1 tree, today's linux-next build (x86_64 allmodconfig)
>> failed like this:
>>
>> drivers/w1/masters/w1-uart.c:314:24: error: initialization of 'size_t (*)(struct serdev_device *, const u8 *, size_t)' {aka 'long unsigned int (*)(struct serdev_device *, const unsigned char *, long unsigned int)'} from incompatible pointer type 'ssize_t (*)(struct serdev_device *, const u8 *, size_t)' {aka 'long int (*)(struct serdev_device *, const unsigned char *, long unsigned int)'} [-Werror=incompatible-pointer-types]
>>   314 |         .receive_buf = w1_uart_serdev_receive_buf,
>>       |                        ^~~~~~~~~~~~~~~~~~~~~~~~~~
>> drivers/w1/masters/w1-uart.c:314:24: note: (near initialization for 'w1_uart_serdev_ops.receive_buf')
>>
>> Caused by commit
>>
>>   178cf9db9e6d ("w1: add UART w1 bus driver")
>>
>> interacting with commit
>>
>>   fed99212acae ("treewide, serdev: change receive_buf() return type to size_t")
>>
>> from the tty tree.
>>
>> I have applied the following merge resolution patch:
>>
>> From: Stephen Rothwell <sfr@canb.auug.org.au>
>> Date: Thu, 15 Feb 2024 13:23:35 +1100
>> Subject: [PATCH] fixup for "w1: add UART w1 bus driver"
>>
>> interacting with "treewide, serdev: change receive_buf() return type to size_t"
>>
>> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
>> ---
>>  drivers/w1/masters/w1-uart.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/w1/masters/w1-uart.c b/drivers/w1/masters/w1-uart.c
>> index 6950d29d7dac..a31782e56ba7 100644
>> --- a/drivers/w1/masters/w1-uart.c
>> +++ b/drivers/w1/masters/w1-uart.c
>> @@ -289,7 +289,7 @@ static int w1_uart_serdev_tx_rx(struct w1_uart_device *w1dev,
>>  	return ret;
>>  }
>>  
>> -static ssize_t w1_uart_serdev_receive_buf(struct serdev_device *serdev,
>> +static size_t w1_uart_serdev_receive_buf(struct serdev_device *serdev,
>>  					  const u8 *buf, size_t count)
>>  {
>>  	struct w1_uart_device *w1dev = serdev_device_get_drvdata(serdev);
> 
> Looks good to me.
> 
> Krzysztof, want to pull in the w1 changes to my tty tree and make this
> change on top of it so that everything works properly going forward?

Sure, I will base my branch on top of your tty-next. Currently the HEAD
is: 6cc3028f797a ("tty: vt: decrypt magic constants in vc_is_control()")


Best regards,
Krzysztof


