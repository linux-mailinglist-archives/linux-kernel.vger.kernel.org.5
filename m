Return-Path: <linux-kernel+bounces-57601-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D766F84DB41
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3986CB23826
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:20:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633F26A334;
	Thu,  8 Feb 2024 08:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x/v1NGfl"
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0387F6A320
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 08:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380413; cv=none; b=P22nSE75wIV/QTGtXgDNCqY1zwYR4ASjBtyBkrfd3aXbvOxlwQ0LfksbPXHISJHSWmQugfk+io8x1uNVxJUyb0TK9rfkfNs4XQJi5TD4F20nZ4EbXDTNEG4rak9Cu29yv9jPPAJN0hgqQptazKgvcZFAv5JYv11xxdjZ+uLrzHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380413; c=relaxed/simple;
	bh=DC8QwyYyPRHm/TlNRlGL0sH5e3TC/GILV1OYtK/te3o=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OeAFRGHKO4gudD0HdwLEqyPAUCHEheifn4fzChzOojvW8G2y2RJmXM5gRPJUMcouiYi5+9Jt0+uP09LgCQzPV4oK1u5YrKLUU7y1bM8nW6WCxmim8MBQL3fqC1XYD0WmWG6P/gnVU81NKAuTO+fWG0y0X3kjF4JV2OFWyXdW4cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=x/v1NGfl; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-33aea66a31cso930666f8f.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 00:20:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707380410; x=1707985210; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jIOIft8KnFzWtuRL8KYkbQwBLhkW8ybQTTPohMHfZ5Y=;
        b=x/v1NGfl9/rN0W82kIRNf5YUdt12E9U+G0hAml5KIO78dh9MHXXDuBR5oH5+tKoolI
         rf/pERhzFzx6y6Bk3jjoaEmxA/8JATFlaRJXdrOfWX3Skh8XCyKvtK4IXvEGRxleDk+D
         pDc6MCBQicye6xo0cxBJ9XmavrEuxP7AbidaEJDKeNcb/KdLKK6e5l4ed8Oa3jDjTBNi
         qgmsyWu/x0uTpY/Cup1LzDJAEyXxAZDohmv4XgxMIV/8vrtyuD1x334NSvGs/KQ2hsZV
         v9Eoos90tZT7tdmVp5Xsjur04ee5kQVSITsBpJ32bc5DC0ctPO75Eo6M3at5MKtX2/EM
         unjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707380410; x=1707985210;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jIOIft8KnFzWtuRL8KYkbQwBLhkW8ybQTTPohMHfZ5Y=;
        b=BY1J7jFljySMkAJJqrtvvRhUYUqijO+Tc9ZZrwnrOLeV/F/GPgQt1wltNsG4dcjbj2
         I23E5uFZVWMEvliMzJhGzIC4RsFg7/A0cEBy439hxlZKENdqNl0lsQkOr72ev5NI3Xxm
         YJhrFgFiEIb9skHxn7HVQR3BF/DHw6Uyf+wCu9PsMfON7gtTgvfWo2IxVUs84sGIAeBY
         zVlb/DANPaU8R6VytIQD/OPLjO+hk5nNoggLOa8xZEHcbjyldQ2gcTTzO7YTA52gemyQ
         soq8JObJwwS4lh5zFrpue3nBEWmL+jtg2LPQY4kFmoDA3pKCUvnpmGFhVS8ig2EaAuDS
         CZxQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+HgxP6cUtanzg946xB+CpFRdKtUauP8E77vlnmn/bGPqLNZAqJi/y/lXXfsOtFDrHPlqlxdobDREn2u/GtLyO0LsLnCRKuv3J0YCQ
X-Gm-Message-State: AOJu0YzoI9mzZPzEsi8A3b7jyI2Ythk2WRTZSNZVco1k4Bq8YBN7NPrs
	KA59bsSeIxQkRMBy1kj6BFphg5f7TUPbrVC/5X/aC0yZEgQlJLGJusBlY7DFoXI=
X-Google-Smtp-Source: AGHT+IFjGCO6+8oIO4SWmt/OcbsoaBOmdhytrRg/6oVRaCjbdzNyG32UGzNW60LUcBoIy2zAVl1yEA==
X-Received: by 2002:a05:6000:14d:b0:33b:178a:6715 with SMTP id r13-20020a056000014d00b0033b178a6715mr5741893wrx.24.1707380410340;
        Thu, 08 Feb 2024 00:20:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCU7vYRonzxMr2QzJL4uVagWPRNmkJmFjVP5H4EO2WrpMgi80T4FfqLzs+E+luacVTKvmUbrrgiF8M6XRlR0aErExN3Bb0x42dxia37PK+9EGXZmgBi7BOsA/p4eMNL1nypPsWwwp2VuKfcdsDXRM78KihzBhGNBBDL57NOCLtuxegMEI8twy9GcI4cT2aMc38/9iVDG4KqYgVE99jE18Ygn1TEboBhNgw9sUv3bcV1iGhY9vuAXOH2rTr5d1m8pMY7h1McMUCSBnvPCXAyKtdp8v3pFnBxLoghjbLmGTZ11wRPjgbEtppETkep0Brq77+lkqLLWlTncUfWS/YnzuTT9jC8ka+qrcvUtpu1+6VZPmlqseSIwhHxvGzacfCjbOLIJ8VlPxEwN5KscCEq0RltCemMSpgXiOLGPhskYH0bQ0eH3wzweihXNJyZoOygzbExm0avVs2QKKZ+efHDEHb4vMtIPFKAeImDnOu+MBOTeijnjQ63NFW6bUBU0QGfafR73AZypkjeXvt0Ezf6fg7gOaA==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id r20-20020adfb1d4000000b00337d6f0013esm3099374wra.107.2024.02.08.00.20.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 00:20:09 -0800 (PST)
Message-ID: <7546ebef-c616-440b-ac63-4864fab83838@linaro.org>
Date: Thu, 8 Feb 2024 09:20:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] dt-bindings: clock: qcom: Add SM8650 camera clock
 controller
Content-Language: en-US
To: Jagadeesh Kona <quic_jkona@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>,
 Michael Turquette <mturquette@baylibre.com>, Stephen Boyd
 <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
 Taniya Das <quic_tdas@quicinc.com>, linux-arm-msm@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Imran Shaik <quic_imrashai@quicinc.com>,
 Ajit Pandey <quic_ajipan@quicinc.com>
References: <20240206113145.31096-1-quic_jkona@quicinc.com>
 <20240206113145.31096-4-quic_jkona@quicinc.com>
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
In-Reply-To: <20240206113145.31096-4-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 12:31, Jagadeesh Kona wrote:
> Add device tree bindings for the camera clock controller on
> Qualcomm SM8650 platform.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> ---

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


