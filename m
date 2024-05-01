Return-Path: <linux-kernel+bounces-165112-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C828B8837
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 11:45:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4C071F23531
	for <lists+linux-kernel@lfdr.de>; Wed,  1 May 2024 09:45:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CACA550285;
	Wed,  1 May 2024 09:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uqQRXpAN"
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94649645
	for <linux-kernel@vger.kernel.org>; Wed,  1 May 2024 09:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714556707; cv=none; b=nE+HrHervhbDBDysc/v9L0eD//DQ7gmml0wKlWW7VfDHepObmnsCFN3h3d1WSHxRhvfL7aSZptGQCScqcoUKYDz0UFOaomCKpUouPorAlzNJAT4uGo/45CYkOMdpA5L3GT7tS+sbfVg+8jWXC5m8P2gsgJMuipQb/8jCzYVN/JA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714556707; c=relaxed/simple;
	bh=pry+PQ7L3VsSddwQ20gj4XnNTiFrnFQyGjhMreF2cys=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KhFLWMmlSi9vmrET2sSoo5cFudIfpOGmx21D96m1IDfs2unVZ4d5LZhNAd5KmhLDIbzF7jbDfU270/5PJOuo4nHaIq//LpypK+F+4Tj/nwBoxHV1mv3bdy8AQdnyxeiPCyiLA6LnrXEYFfder7aY/mzYPxbj1/+LK19JPCMPRS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uqQRXpAN; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2db6f5977e1so78001841fa.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 May 2024 02:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714556704; x=1715161504; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=xnObvPwiieYwnQInszTH7mfu0PtHsqWytCTqPKrebKU=;
        b=uqQRXpANmzC0ZUuxn6qeNzy6qpUNCUlh4MYpqBO/USeL4ehKaYxGwl3JCs3iMIrrsS
         XqLfMgDyZ1Hh1XZWn91xi0/GgTaq9GpIn2Ql1gu/sihbn5f7eCFYZjX06FpzQwbwo2ms
         /Hhcgb1Rz3cBN1Ll1zWoXBDIjTStrBVg5mGHFo5iPK+it8jJBZgKNceeyjrIpF/PjJNp
         6wXJG3fsNz+qI+4HKLJDzoeZsY+dmQw49Ak7dsrWD5dQpJPz3sIPWUQubIqNkAM/yrqn
         xgZUDjeOcOQ1Q7yPaBXGguql0tCSTvq1kNuVzb6P3UFZxhA7iR2sz+0BwAiiYBJFycSl
         BMGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714556704; x=1715161504;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xnObvPwiieYwnQInszTH7mfu0PtHsqWytCTqPKrebKU=;
        b=r+4MvZox5T8j8mLYe3eC8PjRWh908KfATX8gVo9HRGnw4AjdU3e1WdikFm9ppIa9vJ
         Obt99MLahd8yJ7w3dXGbHbmQr+s9LwXpy+eQjj5+J8oYntVxRkv+Kl7gYPU47mAeTcAS
         qK8NELk+NXpx0A733Kp+Rgw7StD7qibNIWk1SZaDnGcFrfU0gOkbPqsO/xqa4IFe7R9z
         9gpU0pifyXzWQSjYzbS2rGCZIkNm0NB6JL5bBCAEQL06rGmWm0HJfgiEJuSkbNqfpmkG
         NpeASwrYHNFe/7xuzH9cy7WQqDcE6W3QTRmYfR0susD3LGwfiXP51Kz6or67dXXVRiDN
         KZQA==
X-Forwarded-Encrypted: i=1; AJvYcCURmrCJ8AZNuJyu1+yG1OI19bmgHFxUIw0wHOQSUoUL6PlhbEeFUWHNXE/aWdrlXEC47NDc6CwTdfijDg7O2zECo6QE6JW9dKvIi9FN
X-Gm-Message-State: AOJu0Ywdr/VX7D3Yu1ZKUpP5zeQu57SjJrowZbMHrxZEpY/WInhxYgbc
	aRd2aWkcEXqt2YKJoA3xqWyP+xePalSDXUj2D4vRQVcc6E7scmm4smmpKdaia2c=
X-Google-Smtp-Source: AGHT+IEiHGFsYiETxtdbiTTE6FVJmSJEATiezAy2M+TLp1Kda1XmZdBwe5r9aL4qvSyu9yN0MHLvSQ==
X-Received: by 2002:a2e:2286:0:b0:2da:aa0:f948 with SMTP id i128-20020a2e2286000000b002da0aa0f948mr1402233lji.8.1714556703906;
        Wed, 01 May 2024 02:45:03 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id f12-20020a2eb38c000000b002e0f0372923sm443596lje.116.2024.05.01.02.45.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 May 2024 02:45:03 -0700 (PDT)
Message-ID: <eb9538fe-1d1a-40e0-a46f-3b4b5da3e8d7@linaro.org>
Date: Wed, 1 May 2024 11:45:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] Add support for Sensirion SDP500
To: Petar Stoykov <pd.pstoykov@gmail.com>, linux-iio@vger.kernel.org
Cc: Jonathan Cameron <jic23@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lars-Peter Clausen <lars@metafoo.de>, Rob Herring <robh+dt@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Angel Iglesias <ang.iglesiasg@gmail.com>, Conor Dooley
 <conor+dt@kernel.org>, linux-kernel@vger.kernel.org,
 devicetree@vger.kernel.org
References: <CADFWO8EZWkXeAMcURgGGEmzVjiSxFTVAbKpsb2Qmv66EZiTc+A@mail.gmail.com>
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
In-Reply-To: <CADFWO8EZWkXeAMcURgGGEmzVjiSxFTVAbKpsb2Qmv66EZiTc+A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/04/2024 17:27, Petar Stoykov wrote:
> functions in use so it should be fine here too.
> 
> All feedback is appreciated! Thank you for taking the time to review this.
> 
> v1->v2:
> Many fixes suggested by Jonathan Cameron and Krzysztof Kozlowsk.

No, be specific. What EXACTLY changed. This is way too generic.
Considering entire indentation is broken, I could assume you actually
did not implement feedback.

Best regards,
Krzysztof


