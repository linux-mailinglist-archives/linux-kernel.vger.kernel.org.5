Return-Path: <linux-kernel+bounces-52298-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AA11084967A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 10:29:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DCDB280F67
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Feb 2024 09:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1918312B90;
	Mon,  5 Feb 2024 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rczwzuBZ"
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 900F912B7C
	for <linux-kernel@vger.kernel.org>; Mon,  5 Feb 2024 09:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707125376; cv=none; b=R1GIEbeAN3dZEG4MGI1IhWN0dW9f7eqql3n9hXUg/XD4XqzHpmeeoWxkQSSFryeYygFxF+2gQOwZnHfh3OcOwTp/BB/woz6DFi7UKxpv6eGxmdX2W/GS7Jw/dcR8TZeaiyT8+E+GRY6y5vaXd1g7WAnpdslc4YXroTjhEOP9azs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707125376; c=relaxed/simple;
	bh=BcBrkBjOlp/N0RICWdSvQQb9NGAcghUUYnVONwBq1pQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qufpdMAZn7awoTmwiD366QEvfSU1e5f8DLqwQqtSiS6d4Bk/EZ9GYl5rPXxh9sYVQRkWNFXVeVoWbMRxgOxo90B4a4bjFEizA9aHHVUSResYkUK5h/VA78EXaM9HLa+NLMsjiBOtRvTGrxlzE00lDx36e8cFT4lEkSh5RLB0DtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=rczwzuBZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-55ff5f6a610so2886540a12.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Feb 2024 01:29:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707125373; x=1707730173; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IRxDNCuF6ovWdCXsD5Syvb2oVe40obg45byynnuBYXE=;
        b=rczwzuBZ46ofWnAGphWkwsyykDyx7hnLBlEYiI8HcXnQNst48xdtGqCb5QBfthew0w
         QJBotyiboAm6n8SVGHhU8HkYQV96d0XlWAscC3qbbkyRXFIsY7TdIwVtStjI6HRwPyFS
         YpT8GmSW+q4kAw33VDyHxsM2yOXcYv8zKubAaL8gZKyXtIhL5nWn6jyxp/UEPXzGuEDb
         3JqNGuokKeP3hh2ZvYe+DCntSg7Ipj96/AxSPJYYWcpbfQqtkrScHyj0SJDE9yiMxo5H
         QH3xQ+Ws1WPwgov6EvKxI7Ya/0dn3/ojEX8V/Js5UPzZu/MPMKlMANpcHk2nPcium/Iz
         stUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707125373; x=1707730173;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IRxDNCuF6ovWdCXsD5Syvb2oVe40obg45byynnuBYXE=;
        b=iPZ+nc/dks3C1KJ8u7YgFW/nIHmiBFcNirmfiWZuBy8UpVOmyNw0rgeqOyeH93o2Rj
         4Dr9SEqiS8e909cNGBvjC6ftH7X2dSdvoPcsHrkyCgo4q1xmOi/f+mC8tGikl39Q8y9n
         WPtEC2L+AlmEGnXQWd/1rDutHEj9zgBXI2WLCYofi4KGEWgrBW5n3cYfYgHzLLIyRLXk
         EvRLB1vepdZq4UaaEDDxG7e6xGPsFrFpFzckir+OqonhUjTV9kCEP5DINUSeRUilur/t
         nGkQyd+VoOduvVGM08YSbSoCbUYHdYabqCXoVVo3OFSw63P9SxA+lcvEnJVnlYXi9LCU
         G43g==
X-Gm-Message-State: AOJu0YweE3FxMtWLdLTiYfulklmfk7egVrYF4IaAyew3ObwRjEpCOkX9
	PjGic4H+wB2yHAM4z7Lq94uhWNFkmIlb0+K9Zco7SS/GZGRshC8lS6fnNyV3BOc=
X-Google-Smtp-Source: AGHT+IFJgCGPsEox0bH92bla3zuhuuw86RHVlccl4Kt3yHjsVQw7Nq/pklPwBYwdIQg2JLJRTQjQzw==
X-Received: by 2002:aa7:d895:0:b0:560:1c3:e23d with SMTP id u21-20020aa7d895000000b0056001c3e23dmr5001623edq.16.1707125372928;
        Mon, 05 Feb 2024 01:29:32 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCU8NsQvQ1w71kMJ4N83dVg5OFUXcWWNY0MEefCtb7aiZAvM9UGqmds/m7U5s9deOGSMtJN7LZXL74IlfaYwsopZd2qWCsvUBaoA0oY7EycfEh2O8kt5ItHJcrX+U/ERW9BQrZ8Z5lAcfKxGJ5rYxfOWHt23Hq1r9d/auecOedfitL9EOL3sBtXo1YI0spY7jo8KS5sBrHv6DC57WE13Jwq0HAoPPTR8uXLyAaXzy9skNaMOVI4Xd0wjclcsWywdhAVpP071aNToml2inCNkBmTZclHudnmtII/4aYzrIGaOYSSAevc=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id a27-20020a509b5b000000b0056036fd311dsm1905337edj.93.2024.02.05.01.29.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Feb 2024 01:29:32 -0800 (PST)
Message-ID: <0e0bddf8-0ea6-4900-8af8-24cf9d247cf3@linaro.org>
Date: Mon, 5 Feb 2024 10:29:31 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: trivial-devices: sort entries
 alphanumerically
Content-Language: en-US
To: Rob Herring <robh@kernel.org>, Conor Dooley <conor@kernel.org>
Cc: Guenter Roeck <linux@roeck-us.net>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Charles Hsu <ythsu0511@gmail.com>,
 linux-hwmon@vger.kernel.org
References: <20240201075805.7492-1-krzysztof.kozlowski@linaro.org>
 <5461a237-1df4-4077-86ef-e9ff6ff17e27@roeck-us.net>
 <20240201-silliness-unfair-265a0d896377@spud>
 <20240202202158.GA1007609-robh@kernel.org>
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
In-Reply-To: <20240202202158.GA1007609-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 02/02/2024 21:21, Rob Herring wrote:
> On Thu, Feb 01, 2024 at 06:32:09PM +0000, Conor Dooley wrote:
>> On Thu, Feb 01, 2024 at 05:25:13AM -0800, Guenter Roeck wrote:
>>> On 1/31/24 23:58, Krzysztof Kozlowski wrote:
>>>> Sort entries alphanumerically.  This was a semi manual job with help of:
>>>>
>>>>    cat Documentation/devicetree/bindings/trivial-devices.yaml | grep '    - ' > old
>>>>    cat old | sort -n > new
>>>>    diff -ubB old new
>>>>
>>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>>
>>>
>>> Acked-by: Guenter Roeck <linux@roeck-us.net>
>>
>> z sorts before a, please fix in the whole file.
> 
> I don't follow this comment.

I think this was just poetry :)

Best regards,
Krzysztof


