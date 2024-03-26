Return-Path: <linux-kernel+bounces-118905-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6150E88C0F2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 12:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E091C3CB3C
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Mar 2024 11:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E174C59150;
	Tue, 26 Mar 2024 11:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="owojbr2o"
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7162D5475D
	for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 11:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711453154; cv=none; b=QyG+hPDteiQY7s4R3TEB8MV1XtPuVC4JqXbrNVt6VHKSfLpRUv4RbACJ9xx+oiNGiRZyi6IAvD2GbZg0MjxQVMGmGKLzOsui7AsGooAfAgviL4p7bjGkP6u+I3nfYhQ16N0w0jMKblbol/7WddONndJmYdBZfMYUXuAb5hnDbzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711453154; c=relaxed/simple;
	bh=4ck/6gqR5mckA9o0La+CDDYSsBr91LDBBwYLt82H1ww=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Z86BRy7WRZCQg8Gl5W1fzA16oAWDiJ6CBlPlUmbo6wyANRVwNihy4wDki4YpgTza1eBiWB1znlHgunFs8TcWLuMNYXmDBhx20MYiIXPzh9FQk66K5Wawxxs14slg5nzn+JpqYycYDG5XIT1MN4KMcehp1oAgRnwNwQdXFEMY2vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=owojbr2o; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a470d7f77eeso683794766b.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Mar 2024 04:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711453151; x=1712057951; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d1Q5QgxbARJF+JHP2BJShFIUe5IajvFjJe+6m/Xo/mg=;
        b=owojbr2obs/yTh3KXMm1LxLk5eIF6TN85ovFPc2PPVVcEgtrPZlEDNhfWm3a6YRBXQ
         t7qAB/Hz1VHeWR/N608z6oicfGUx7Xogw3gKCS+WPnEK3G4ErwEEFRPaWKy5CXtOJvux
         YqbDR4BSeDI0DKPa7tfnwEMK55MTKnwBc1wQiil99JP2pYfuWbvDld/2INBABYB3zgYS
         zd06wXlwfFjJbOQh/QkePUEdIclW1bT7CRzfRhDFWq79kH6JeSVQKd9ZigOronRERJFn
         EUoieHfnARZw6/qc0fAVC5LMdPDokBTZt5QHg3VAH3iTiphFA0BHQZm+FNpK9FhswxyM
         fRbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711453151; x=1712057951;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d1Q5QgxbARJF+JHP2BJShFIUe5IajvFjJe+6m/Xo/mg=;
        b=bPoIFbslMTmWRzAY8HCH6T1bGYdwkpukDUSGbxPHnMLMQmODLlpTtpch/OW0pBsXTR
         Bir+7w8sc1syzMioUfPybXZdC9PmtwMwFQuyMPwpbRj8ZpFkxvpYuL/dxBv5194s148/
         JGqvSWmzHwwoOenaMip/8rD1ftvdkNfLzeerYgCy30zW88EWrMFWxwEce8eQnYPfylh+
         nqB581rIIIScdeGdDQyB6HaUueuN8dCoCppXv/SCKtIymcTZL6ZsXspyqpi00T3pVRao
         F5fKef78mfdMb+XnJ9xal/18osYc/OGyHkvcD82VZKthmfdPnuEWwSdpsTQX1mYpV01S
         sOKQ==
X-Forwarded-Encrypted: i=1; AJvYcCVHn4NQFs5yrwd3pjuvnu0VDYQT9a9qtYOI8HEWmk5U/6pz6yR7jKho7HKHELKrNgz8LFPQqCHWSTP971nTCjYK0nGO53kbCFF29hZk
X-Gm-Message-State: AOJu0YyWFf7LbilgDIVLk/gIMXocbmwukS5h8D4SluepM/HDEbdNbEdC
	XYBVWeOZDfr5o1YNTtVdlpm+x7+kti2IN79wXQ9cag9HbT1f0sM06lITL0YVt/Y=
X-Google-Smtp-Source: AGHT+IEa2Un7kY9XZeTWpXUi5moO74Uk0Nkpf5fzgte8eD1i5gZwTX5dTQH5elrRUtqyDHio98LcyQ==
X-Received: by 2002:a17:907:7d8e:b0:a4d:f901:477d with SMTP id oz14-20020a1709077d8e00b00a4df901477dmr767810ejc.19.1711453150719;
        Tue, 26 Mar 2024 04:39:10 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.44])
        by smtp.gmail.com with ESMTPSA id xj8-20020a170906db0800b00a4a33a9f077sm2344211ejb.11.2024.03.26.04.39.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 04:39:10 -0700 (PDT)
Message-ID: <79ba66c5-a564-416d-b7bf-747422803aa6@linaro.org>
Date: Tue, 26 Mar 2024 12:39:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/2] ARM: dts: aspeed: x4tf: Add dts for asus x4tf
 project
To: Kelly Hung <ppighouse@gmail.com>, robh+dt@kernel.org
Cc: krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org, joel@jms.id.au,
 andrew@codeconstruct.com.au, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-aspeed@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, openbmc@lists.ozlabs.org, kelly_hung@asus.com,
 Allenyy_Hsu@asus.com
References: <20240326103549.2413515-1-Kelly_Hung@asus.com>
 <20240326103549.2413515-3-Kelly_Hung@asus.com>
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
In-Reply-To: <20240326103549.2413515-3-Kelly_Hung@asus.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/03/2024 11:35, Kelly Hung wrote:
> Base on aspeed-g6.dtsi and can boot into BMC console.
> 
> Signed-off-by: Kelly Hung <Kelly_Hung@asus.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

That's not true.

Please provide a link to lore.kernel.org which will prove that you
received this tag.

> Reviewed-by: Andrew Jeffery <andrew@codeconstruct.com.au>

Please provide a link to lore.kernel.org which will prove that you
received this tag.

Did you read the documentation I was sharing with you?

Best regards,
Krzysztof


