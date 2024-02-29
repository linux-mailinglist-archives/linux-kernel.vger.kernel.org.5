Return-Path: <linux-kernel+bounces-87218-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E516F86D13E
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:57:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C7CF1C21FAB
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:57:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 572587580C;
	Thu, 29 Feb 2024 17:57:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Vi8wFU3X"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDC66757ED
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709229437; cv=none; b=LhQtqdbQ89SAFseQYCgcFfy+i85ETkWEdFa+e7ct5iCemMEU4M3yCYMMU1lcAfovWw7S/ZqZB2euCQ2KWwx57GX8yNkiQv7pUafvaaApDcoKeZK2aJ59iPAMZ7HJ6IKp/g+OaJDfpEBWnOmdqgmavD6D96Z9PNVfem33xCG/iOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709229437; c=relaxed/simple;
	bh=P7nQhn3DAJ9i3Niab1QxHDxD6xtT6wxpVOwcDAJ4T58=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mBsOaXo4oztjYOia4ChH806UmRxGecN8l3U3kEwFiXSpUkM2f8oDM20Id0cxddrez6RSMcTlwxLu+eQCM3vRsN/PYARF+kTITjgVJdPx0lu8Axn+Pn26a6CtI5SSzajZ6plsC4iQP7fIjMLmdkaFB+qqWTOp9LA2bHKx7YNL8No=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Vi8wFU3X; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-563f675be29so1688605a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709229434; x=1709834234; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0VSCcHYawJXa1rt0x3Tg+kDAG9fenwtP0XfWlTJ01QI=;
        b=Vi8wFU3X9mfeDiWqnkf2FMfpyOir8W/ia2J0xq8WAeC15TLueN/V/c3nLHLBMz3BXH
         eW2msq5Pp5QRGfUX3cEqCUY9B1yKhMluxC8CUghbrDCHjycjfxTQ+Re4XxsKEhN13bf8
         xI8kJcim3LDgs0uQ+pvJoo4qA25/a31WOveCiE2IqyXvzBCHM8iqE1pwYWMsp+As8sqB
         UpDFdH2h5zavU5QbM+8KTOBTzPoz/rorkeu6VLbsO4JWcl3H9xGVSYxP8YPw2odGfu2t
         z7nrDnM8S0XfuVVy8sErYxY4nC1rwmGNiJ9dNWwYSGWW9Sg6cULedfJUXARKAFKXtAOm
         bvfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709229434; x=1709834234;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0VSCcHYawJXa1rt0x3Tg+kDAG9fenwtP0XfWlTJ01QI=;
        b=FDw2s9jwIy39GS0DIgsvB6sDu0+aN5XNbKa8Y2i46xs0kiKOFLPRnrySCqPbZ+kEYT
         1KB+dSN/bk8vDJ5fsJRxU4NSTlMVe3ZaQasObuKeRr3090m2QTdeV/o+KA12qeGvoOqJ
         vXxibtQHG2OWHuk0x/25bQ4QTk+h5LsTAgFmGyXxIIkR5bQqm/VVUAd/9vngS6G4cd2l
         PPTTXGX6UZusniY16JNrp+zt8zstaFpp4Ht9uw3GjdYeBuddQe84dE6GOEKbyqikrwd/
         IFyKaSdE4O9kT9rs82Xbx8//TYuHwYX2l9wueQr0tU9ItcugPtF2CG+Wy7RzTk/7kr+Z
         eJMw==
X-Forwarded-Encrypted: i=1; AJvYcCUhEQOsArQ7McZhIl1k+aPbYxvuKCbPJiCsQaTmN8Xnv8qF9RaySfSKxpAaFgBG2v+YnRXrWXONZuoSo39sBzvJ66vPEgjx/zdEMk7U
X-Gm-Message-State: AOJu0Yzc5HQxHniJlGoL9u2opOGoglZFMayUI7kjeC9jHzvwQavLHWEO
	Iy4YRHBK+PPHh6AOJB7v6x+cdyF9tK86cvkCrqPtskVuJXdOfGC1a4s7+NkHTgM=
X-Google-Smtp-Source: AGHT+IF56NSGBrEqJBOxqJHRaQaPzb3lTrNuWrOCeKIwLr0SE3ZZhoQ9MsCmRQWOrWsRdA+vWkACWQ==
X-Received: by 2002:a50:cbc1:0:b0:566:5897:b3ba with SMTP id l1-20020a50cbc1000000b005665897b3bamr1909598edi.3.1709229434246;
        Thu, 29 Feb 2024 09:57:14 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id s24-20020aa7c558000000b0056664063ca6sm815241edr.44.2024.02.29.09.57.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:57:13 -0800 (PST)
Message-ID: <6eb17b85-1b38-401d-84b6-4e995482d86f@linaro.org>
Date: Thu, 29 Feb 2024 18:57:11 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] iommu/arm-smmu-qcom: Fix use-after-free issue in
 qcom_smmu_create()
Content-Language: en-US
To: Pratyush Brahma <quic_pbrahma@quicinc.com>,
 Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc: quic_c_gdjako@quicinc.com, andersson@kernel.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, djakov@kernel.org, iommu@lists.linux.dev,
 joro@8bytes.org, konrad.dybcio@linaro.org,
 krzysztof.kozlowski+dt@linaro.org, linux-arm-kernel@lists.infradead.org,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 quic_cgoldswo@quicinc.com, quic_pdaly@quicinc.com,
 quic_sudaraja@quicinc.com, quic_sukadev@quicinc.com, robdclark@gmail.com,
 robh+dt@kernel.org, robin.murphy@arm.com, will@kernel.org
References: <20240201210529.7728-4-quic_c_gdjako@quicinc.com>
 <20240213062608.13018-1-quic_pbrahma@quicinc.com>
 <CAA8EJpoh-m_fzt9WcUXOkTxVZRQMDf-WrgqqoM0C_-qzjgDm1w@mail.gmail.com>
 <ccb6b2a2-040b-46cc-9b72-2e4bd4c75565@quicinc.com>
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
In-Reply-To: <ccb6b2a2-040b-46cc-9b72-2e4bd4c75565@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/02/2024 09:17, Pratyush Brahma wrote:
> 
> On 2/13/2024 1:36 PM, Dmitry Baryshkov wrote:
>> On Tue, 13 Feb 2024 at 08:27, Pratyush Brahma <quic_pbrahma@quicinc.com> wrote:
>>> Currently, during arm smmu probe, struct arm_smmu_device pointer
>>> is allocated. The pointer is reallocated to a new struct qcom_smmu in
>>> qcom_smmu_create() with devm_krealloc() which frees the smmu device
>>> after copying the data into the new pointer.
>>>
>>> The freed pointer is then passed again in devm_of_platform_populate()
>>> inside qcom_smmu_create() which causes a use-after-free issue.
>>>
>>> Fix the use-after-free issue by reassigning the old pointer to
>>> the new pointer where the struct was copied by devm_krealloc().
>>>
>>> Signed-off-by: Pratyush Brahma <quic_pbrahma@quicinc.com>
>> Missing Fixes tag.
> Haven't added as the patchset in-reply-to hasn't been merged to 
> linux-next. Please refer my next reply.

Why do you send patches for work being reviewed? Just perform the
review. It looks like you deliberately want to apply bad code just to
fix it a second later!

Best regards,
Krzysztof


