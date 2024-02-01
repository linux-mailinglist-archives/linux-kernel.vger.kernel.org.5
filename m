Return-Path: <linux-kernel+bounces-48061-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F06CD8456C8
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:03:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1A49E1C281A0
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 12:03:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719C015DBCB;
	Thu,  1 Feb 2024 12:03:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zAsRh9Mx"
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 027F415DBA9
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 12:03:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706789008; cv=none; b=NlIK+rdxeWr5Z929KQVPi43Ima3uh4kPHpBGApmelRsle/HrSNYwlLroQ8Mnj58RDSyWwRwLGJAlUDRTUNcofo6IWD2f+x5kYXtnMi+fI6Bo1zMHJ47n/p8Bjg4en34iVpYcPt9TiULLG/YREIzZ39QtluuaPHuy1vHrnC4HC/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706789008; c=relaxed/simple;
	bh=TiprOwt7tUEf7EeXjFc++Q44zN30BsJWpw76yapmUZE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pJflalr5Ivb0RV4amiHoa8pPZHQwBlf6xGtUjbE2LsLwAzd96A1ANHH4l+JosQrZtJk04n6Gymad+Wwf8xHzPi4J+byR3UO5/kF0IwdFjS27TxJC+B9EJ7oJhDY7ipcs0gsqCb0pGQNO2Tkzgz5pWnM0qKsxVEFyr/eLSzE7ARk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=zAsRh9Mx; arc=none smtp.client-ip=209.85.160.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-42a8be32041so6964951cf.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 04:03:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706789006; x=1707393806; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NNs2+h3cA2GnTmXa5rdXvMXKwDcixW8pQGoHn2GARQ0=;
        b=zAsRh9Mx3L3sf3oM7FfBZV1rHQqytq5zXxaoOp02Ciwld0YMvkIXmC+k25FXE1eTx4
         Zsq8pBMZFcC0el/nCi4Zcc5IqLigW++ox9SE0hO3kDoQ7GklTuLu/NPU2Mi3W3jlhjhX
         kS2A4B5lAj5tAfVIkshP56OFHzVmWYmfSQVD/LRepv7eSm3rMEz2/TxbVx9yphXXjaa6
         31mWWQ4r1wpdGZPgP1wqcwrnYhCylDo1abNCxBR6sz8EY4kMzKEfnYfjeXFYtK04uowx
         ZgKB67jrVc/juCcWwHd9irp70mpPvHas3+XQv90Xg6gUlOpr1qhce2W0fVMbwi2AippI
         QV/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706789006; x=1707393806;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NNs2+h3cA2GnTmXa5rdXvMXKwDcixW8pQGoHn2GARQ0=;
        b=FwHXdtrXrGzL5SbST8fsNSRceaZE8cePnODEjDaUeLc1zMJqVTooy/n3+kZXJ13bG7
         4RMI6qNd7MBV1LGc9SK7pZvM+j5etNNFrNn4BQLIjEmE8E6o6YMB0zgNIukuIG7Nta4x
         xRTqN/m6y75lWpoSLhA6K7n7B4XonYwwZzgvZLctq+eg3uG1NHPtcmIPWQN8xg9E+id9
         bpbZo+Y/QHuVhqczeqp3WUnDVk/fr+DBLtYsMoYSkUMVasE0dd1UXdDNAk4Y6I8IzCqJ
         lk5Zk65LlddLZmIVzYxqb+k0TT7pl2+OT0eDT2naoYvSuSo3AJFvjR+soe/TuDWDooua
         zbSg==
X-Gm-Message-State: AOJu0YwmZ3QogVIvVE+7lUM0I6+BqddBQ2qTCTbM83CfB9PTVOG3Y0FN
	SqXzCTnZJGBGNsrmgps6wX4c1FRpZJye2ufpgv3+wecn86t7MLhR7Esznd1tAtQ=
X-Google-Smtp-Source: AGHT+IGZda1VhxfPL0IwzjXB6TeemP/lFytJpuYNCwevemyLU6Z5ZQXgPaly3QcPtreJ8fUXEqzK3A==
X-Received: by 2002:a05:622a:199b:b0:42b:f01e:d9d5 with SMTP id u27-20020a05622a199b00b0042bf01ed9d5mr3395562qtc.62.1706789005827;
        Thu, 01 Feb 2024 04:03:25 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXi9u6H9dvaGIMz+DLiw4Cp1PCvKdNCgRoiiYPApWq5hmokUfmBdhmLDFLXhYP7i3M8MeP9NgLyiNE6QPVUA28ORxdh2Fr0Dp7Sd/Cv2T9ESE7p8zlmvhlHp5Ghu3UiIBx6R8gLgsz4a+I6rv9Y/BH2aXK5UbF3Dyv0ukH2fKhJKUDDkajdyN6QPTnv3XOQVIyrybwfGDhDvVAY61I89AK+eveWXSj5AeebS5dNhWWjfUwr1nwSRCBFSmxUkzdKXS7tTdtzbD/aQy1cC5IQf68T1/hrA4hj79hXLtVBCto5Erqx1pWHw3q7EiR5ehEoZpNkF+JFQBt+Yi1sXoa8DvXsAQOyAe7DVfa+PWxTsC5Q96IE/xrOZNdv5FUTpYccC4IkQwCkyVbuCDJl/CAleir3jdKkL2ZZPzCUDdBz57Yc4kP45TfypG9CZQ==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id cf5-20020a05622a400500b0042aab8ca417sm3488466qtb.3.2024.02.01.04.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 04:03:25 -0800 (PST)
Message-ID: <3e3cbc36-2f3f-4295-9325-90757f0d77ce@linaro.org>
Date: Thu, 1 Feb 2024 13:03:20 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/6] arm64: dts: qcom: aim300: add AIM300 AIoT
Content-Language: en-US
To: Tengfei Fan <quic_tengfan@quicinc.com>, andersson@kernel.org,
 konrad.dybcio@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 dmitry.baryshkov@linaro.org
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, kernel@quicinc.com,
 Qiang Yu <quic_qianyu@quicinc.com>, Ziyue Zhang <quic_ziyuzhan@quicinc.com>
References: <20240119100621.11788-1-quic_tengfan@quicinc.com>
 <20240119100621.11788-7-quic_tengfan@quicinc.com>
 <d3ef45cf-2de8-4f5b-8857-62d1996f3f58@linaro.org>
 <842bf6ad-46e1-43d8-86be-79ab0f49710b@quicinc.com>
 <c17dafd2-db89-4fe2-8e98-2a031f7237c2@quicinc.com>
 <b28904a6-c1ef-44b5-96ca-313a9a2a3f8b@quicinc.com>
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
In-Reply-To: <b28904a6-c1ef-44b5-96ca-313a9a2a3f8b@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 12:49, Tengfei Fan wrote:
>>>> This should be probably TX SWR_INPUT1.
>>>>
>>>> Best regards,
>>>> Krzysztof
>>>>
>>>
>>> I will double check this with related team and I will update this.
>>>
>>
>> I will apply "TX SWR_INPUT1" on audio-routing node in the next patch 
>> series.
>>
> 
> This patch series has been sent for nearly two weeks. do you think it is 
> better to modify the patch series acording to the current comments and 
> submit a new patch series, or continue to wait for your review comments 
> on the current path series?

Hi,

Whom do you ask?

Best regards,
Krzysztof


