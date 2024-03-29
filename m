Return-Path: <linux-kernel+bounces-124462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DEEDB891864
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 13:10:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2391A2848AE
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Mar 2024 12:10:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0D085656;
	Fri, 29 Mar 2024 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="arDsjhrv"
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D6A985299
	for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711714210; cv=none; b=YrSU6UVT5DBpD/iRiWhT+ikJd6Bv8fWQyuu0YsFqwphK4RS7hYPwaW9H2yOILIAJtiribRRT082puJKwsW1yo1fgHlownloEe48opdxEusvawtRTxtqRIS20OLKunACCyTUPHENMmsbSGIyfmnswdDDo26lkiwfQtP9nfmDkTfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711714210; c=relaxed/simple;
	bh=90VA0QRkzFCHjjzptHhuCk6ko7WZh1MGGqvVdOqYNOs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVlofG0JLR4WffGPBzRHKYi9oZSLU/ctIenGswsFhqaD1Pkr7rNiI9I1gBFbN+d6iAwI7/5jBmKBgkPJxn0nk9jLwbgDY7UeCKJF4wBExg6j/JTCHJZuX/706k/dfchQJ9Gl5qSUuNacwnL9mXLqqtsxq3ZOi8Gxz3CS7QAvMmw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=arDsjhrv; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-414a2679222so11616095e9.1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Mar 2024 05:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711714207; x=1712319007; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=Mx53Ho+h705KudOYprlwABkMXqM2QEFDHzS3aw4XkWw=;
        b=arDsjhrvE5RqbQzdv6XELMnqzj8VC3DgRWYKDzacIhDAR12qM/BD+svNXoc5qFJzfp
         AtUYEeKRzk4krEYjxlxDb2jRSb3Y5lrgS0lmXvkWBbYC/9U9pOO+byHbD6t2/Dz2M6pw
         2SZEgHtTto6f5G+oiiFKXG8hGx6+1AewbSJQs1chhE3u7fIZab4NAKdK06Pm+SK9HGGb
         H3jNzT2JbicdZL5VS8g+dxwGLg9mIoMHGP7jT1NLtnt52gI38sxlqgLVQKuY2MNKRXzy
         GjYwT5VSCIn4SXbtx+fahRzroe1t8YtFS4WCm8OLEwvzORd2g5C+RjFAShD+hIdVLb0T
         CCCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711714207; x=1712319007;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mx53Ho+h705KudOYprlwABkMXqM2QEFDHzS3aw4XkWw=;
        b=lXHv0ngWOENWNVGn2nB3bOYl6TMDDgbzsEdtszbIabk00X0uQpgYY82FLATinETxPr
         gG0B1HHeKwTO9hCym/A0yUJXyz1GDon2Hai/13y4CUO52be2DtV0wxLY3QqZR37aX/7U
         1YBnD+0LrcWWNcsN7eKJLCmYzCiXCeeAzrznAC/DJesggclY0wPnevTwZQIIza24IlKy
         y90UARscpdQi4JJSjYFC/OXwzv/yhMu3It6NnKo7P4hoRr5bjETqW1yZ9vnA24ts8AOs
         2Yhrbf0KlzGrUGxV35zHU3gPpj6GojNfGB6fRFYSl1zxUChNwpd1CZ20c3LUGwwT05lc
         edfw==
X-Forwarded-Encrypted: i=1; AJvYcCVT+ccvRj8TW3nP7kmVJyO2SamELWlbzLQnqqF9VeSlpc7VarfPTJTKMnDUbTGWKHzMPJhmz41PZqw2d5aDkIHnqGxcZsNO2jzT/vh4
X-Gm-Message-State: AOJu0YzW9VHEFl8LB5OsB/vP3PdxPaVf4nw19k2WfJIvvTIJoZym2QgC
	8HXuymy5fdd9VdjmZk0sLAH2mgG9D0CvGnsYEkWoim8QAZM5BcWpGecD99vH3c0=
X-Google-Smtp-Source: AGHT+IGdkUJHuyGcvFRg8PxzTiztlFrx/8w5tyad1ZYe4AJ+FrbuWcSdMKz+VAm+mVo5ZrWdNoqQRw==
X-Received: by 2002:adf:fa50:0:b0:33e:6056:6b8b with SMTP id y16-20020adffa50000000b0033e60566b8bmr1386402wrr.7.1711714205279;
        Fri, 29 Mar 2024 05:10:05 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.50])
        by smtp.gmail.com with ESMTPSA id d14-20020adff84e000000b0033b66c2d61esm4010336wrq.48.2024.03.29.05.10.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Mar 2024 05:10:04 -0700 (PDT)
Message-ID: <031d0a35-b192-4161-beef-97b89d5d1da6@linaro.org>
Date: Fri, 29 Mar 2024 13:10:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 4/5] clk: qcom: ipq9574: Use icc-clk for enabling NoC
 related clocks
To: Varadarajan Narayanan <quic_varada@quicinc.com>,
 Stephen Boyd <sboyd@kernel.org>
Cc: andersson@kernel.org, conor+dt@kernel.org, devicetree@vger.kernel.org,
 djakov@kernel.org, dmitry.baryshkov@linaro.org, konrad.dybcio@linaro.org,
 krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, mturquette@baylibre.com, quic_anusha@quicinc.com,
 robh@kernel.org
References: <20240328075936.223461-1-quic_varada@quicinc.com>
 <20240328075936.223461-5-quic_varada@quicinc.com>
 <95f4e99a60cc97770fc3cee850b62faf.sboyd@kernel.org>
 <ZgaeGZL7QXh75aSA@hu-varada-blr.qualcomm.com>
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
In-Reply-To: <ZgaeGZL7QXh75aSA@hu-varada-blr.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/03/2024 11:55, Varadarajan Narayanan wrote:
>>> +
>>> +enum {
>>> +       ICC_ANOC_PCIE0,
>>> +       ICC_SNOC_PCIE0,
>>> +       ICC_ANOC_PCIE1,
>>> +       ICC_SNOC_PCIE1,
>>> +       ICC_ANOC_PCIE2,
>>> +       ICC_SNOC_PCIE2,
>>> +       ICC_ANOC_PCIE3,
>>> +       ICC_SNOC_PCIE3,
>>> +       ICC_SNOC_USB,
>>> +       ICC_ANOC_USB_AXI,
>>> +       ICC_NSSNOC_NSSCC,
>>> +       ICC_NSSNOC_SNOC_0,
>>> +       ICC_NSSNOC_SNOC_1,
>>> +       ICC_NSSNOC_PCNOC_1,
>>> +       ICC_NSSNOC_QOSGEN_REF,
>>> +       ICC_NSSNOC_TIMEOUT_REF,
>>> +       ICC_NSSNOC_XO_DCD,
>>> +       ICC_NSSNOC_ATB,
>>> +       ICC_MEM_NOC_NSSNOC,
>>> +       ICC_NSSNOC_MEMNOC,
>>> +       ICC_NSSNOC_MEM_NOC_1,
>>> +};
>>
>> Are these supposed to be in a dt-binding header?
> 
> Since these don't directly relate to the ids in the dt-bindings
> not sure if they will be permitted there. Will move and post a
> new version and get feedback.

You can answer this by yourself by looking at your DTS. Do you use them
as well in the DTS?

It's a pity we see here only parts of DTS, instead of full interconnect
usage.

Best regards,
Krzysztof


