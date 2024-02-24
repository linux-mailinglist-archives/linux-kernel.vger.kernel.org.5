Return-Path: <linux-kernel+bounces-79560-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B8FC862427
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 11:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2000F2832C2
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Feb 2024 10:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0269219E2;
	Sat, 24 Feb 2024 10:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x1S1Cv2K"
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F1F1C2AE
	for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 10:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708770008; cv=none; b=D0BG2yusXkJPeXhOdNhuAvgtwSsAJTKMUaqNueFaXAmMpY8R/x6usrbeIfyuWkw5ErHOhhp4AHcCpWz93qAeg3bwvqZrWqsdsSL2l4Fw0Ju+1fUgFBf9qQ+G39X0WDQf12r+yTxrAJOhcyUBJelH0lnqrTxMvsAugG04lXfL6SQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708770008; c=relaxed/simple;
	bh=XFdFq4GlDxk/3FhYtaG3goGA8xDbbWERqDLONWkuRZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=bb5Ds2xG0AbImVaETzJf33Vi6lrGHARFpm/9nhVV3dAG28wdhDOUnqnVzTKbHagEJQnxJB6E5mMv97JGZbmWrRk+3WS0jMePyIun1F4t/7O5CsJWMT7cgyME+3fLfx/rEauBsDg6vCmmQ8xa1V5kxlk7P3CDoxY/U66fy2aisZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x1S1Cv2K; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a3e891b5e4eso182030066b.0
        for <linux-kernel@vger.kernel.org>; Sat, 24 Feb 2024 02:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708770005; x=1709374805; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ApU6AfFvWi/q790wOpN8O82HdElurnEssuBxhU9cyfg=;
        b=x1S1Cv2KeaRMCinKOXUhucHSPvjolHP90h9XM9qmMwIPEaAxdaQ8ZjfYFgZilRy64a
         ykM/WQPAD3HfAkBzU2VgfQQ6CE7EyB2XaCcsFPyNCaztDB5+JB3+N/IsHBakeMfaAkdI
         13xm3GVhvQTgmKzOA0nA7Ziue5AGqc7g/Lb0Zt1B8ZGZgLuibmR2FbPsoJWnQa/vIUaf
         oOw13bscqdc6+j7Ba2kOr63nCOQdZT5HFs8uq602ZsdIV2DuaBL0R+McR+DvZBxuHFxI
         hbMjKIG7bQagXK6t8GDg1VfNHZQZbdxCBOvwGNSkKMl/dfRAGSuH7uq5mdvzDpFvwhZx
         Oefg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708770005; x=1709374805;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ApU6AfFvWi/q790wOpN8O82HdElurnEssuBxhU9cyfg=;
        b=bXFDbhTRcCNx4XjzKvhHJyN9EpsqdQAO8uDgE7ub3J3R/sC5/HCJcYzX+1j3gXIjL4
         EZi0NvgWPZCDioPh1SpebP9tBOLVGQISnzZMJxRwn7MXSuMtPhzeQLweX04VyaGk0MW5
         5IWlt4oeu43Sh9xU76LrBGtkhFV0WepXtYwZylKuJUaOM2afqCXAQSFRi0HyTtTI7Aa5
         i/AVZ2nLNiGY1Mfhs+Qc4T9DwgwkKV/Oz8gNj1EhYU05TM+kC+gqVtktFqH3I4awh5MJ
         UlySJqiiQzUT2yT1It18FWi8oc6aB4a3lzIlfu33QKgW4bA8xz0TrMn2gQ1gouTgkeeh
         I/aA==
X-Forwarded-Encrypted: i=1; AJvYcCWV8gcpgP5LIRSd9g+sCz/zTe6xEznNA5vDnevofuCpuolqImLgBgZqMenrF08CuhLyrz3jRxahZXp+gnMqIZ8EW6CtoZHiHRqsR6Zi
X-Gm-Message-State: AOJu0YyLC4j6dQE4o4NGE+AHLFNl/6ophNczZ+onxOdBKN+pFoLD6oBG
	8bi7hDyr9T9Njy0vzj886f8OwbDJOvTRcKhgkh2HJCpfx02Pad1okUuUXtAO6x4=
X-Google-Smtp-Source: AGHT+IFilsIOfNZqlUkt6rYbnUuRbauKrIwciMrlLjUXuZY8aQ6ePcLUA51RbhyxdGK+Rc8mNwiMTQ==
X-Received: by 2002:a17:906:c448:b0:a3e:9e4d:dafb with SMTP id ck8-20020a170906c44800b00a3e9e4ddafbmr1244293ejb.29.1708770005163;
        Sat, 24 Feb 2024 02:20:05 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.116])
        by smtp.gmail.com with ESMTPSA id k10-20020a17090646ca00b00a3d004237ebsm447339ejs.212.2024.02.24.02.20.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 24 Feb 2024 02:20:04 -0800 (PST)
Message-ID: <16a8884a-c67b-42d3-bd9e-8bfca3786a8f@linaro.org>
Date: Sat, 24 Feb 2024 11:20:03 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] dt-bindings: nvmem: qcom,spmi-sdam: update maintainer
Content-Language: en-US
To: David Collins <quic_collinsd@quicinc.com>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>
Cc: devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Subbaraman Narayanamurthy <quic_subbaram@quicinc.com>
References: <20240223232955.1907552-1-quic_collinsd@quicinc.com>
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
In-Reply-To: <20240223232955.1907552-1-quic_collinsd@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 24/02/2024 00:29, David Collins wrote:
> Emails to Shyam bounce (reason: 585 5.1.1 <sthella@codeaurora.org>:
> Recipient address rejected: undeliverable address: No such user here.)
> so change the maintainer to be me.  I work on qcom,spmi-sdam as well
> as other PMIC peripheral devices.
> 
> Signed-off-by: David Collins <quic_collinsd@quicinc.com>
> ---

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


