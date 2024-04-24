Return-Path: <linux-kernel+bounces-156276-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FF4C8B00A5
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 06:42:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6CD2AB22D54
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Apr 2024 04:42:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2893815442D;
	Wed, 24 Apr 2024 04:42:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="XeNGPjLz"
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B128D152DEF
	for <linux-kernel@vger.kernel.org>; Wed, 24 Apr 2024 04:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713933722; cv=none; b=sKal0fIH1j/5sgx9UwbbVQhn6+2ZSqemu/rLxryfwmh7ZWttWontC3ONSCDgNRnf+vr2qbdClkWDG7vZiwRMyaXuymxTLPU4hBCRYEHbl4nwNVvJ9Zof9rj2sBCr8sKp/KhY4ZmPBY2AJriDK8hnJJK8KB4RvqYFmnVaM2nsf/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713933722; c=relaxed/simple;
	bh=JM2B4kYxrGaJc2NKMceh1oRnw+RaynWIsgZzr48AKAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BRV5KOKJDksyq/Wz4sOJXs1OtZEUM+f1FjsqB3qGMuTiqmawEueicGMwtmj1lle/ZslSxo8m1ue1vktjD1tHG+k+0ymx1QQIdIRTXbhUgQZn3ulvVlTvMOBWLgump8yS0t2Uwfw7hN5scAqbfiVgDcOz8Jd7N5MRbAUaEwHGWl8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=XeNGPjLz; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-565c6cf4819so924430a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 23 Apr 2024 21:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713933719; x=1714538519; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=T612ryKrlD1lLpjfSdxqiGKjKbEdGbmwSDBv0V/5m2o=;
        b=XeNGPjLzK67DOMpWaZbqEl91TlqlBSHDvlZCjUra1lP8hkghdCKvswdK/asksspNSA
         Bc+9uLiLvDkZuYjNUnMYsng7IwAMx7901nRM0PmnraOLKE+WoyN9zpmaQ1kpKeeFBQfE
         qxg9KYVzlCcK+f/CyfJi3s/Xq/lJHqAhsKg2iqe9YukvJ07YPhbMeya51nqmRJg5bnuT
         TBHkRCUxiCl0Q0MGa+wDD4xeRDQ7Nxxl4kNobmCgjOLaP3Zt0C2PVz/oBY4biFQdVHJy
         AzvqJCmuoOcQo1LlOBYeOiJ1PL/XBCNnbsSWAusZsrMT/dWIWX8cbkKcG1F6qGtE7U0C
         SNRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713933719; x=1714538519;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T612ryKrlD1lLpjfSdxqiGKjKbEdGbmwSDBv0V/5m2o=;
        b=Kh0zfxJazAsAqoD0xVUlQBQe9bijaYfUMwfXB6XJW9Ark4Rt4P4exTDNEFTF9IYaKO
         a266WtXghPn11iHYrG43IDRp2CMBwbEokcSCu7NcpBmOono46zJRAU8aUSKCPF6VXNGA
         JyK2qypWuqNJyOjT5drqpj+oShR8ADvTgxa62/OEgoFg2i7RQ3oXPxzx8T/qm4bPAGQu
         Lu38TVGyIXT3xdVESoaNhnzFg6EOr7AVvnJLF3Bdc2BJzQGgVPUDnBlU8iPzmbc0VZUo
         sTl+yhz7FUkFa/2uGVDKFNugaUeVZ9PfpBOuWfyWuHYzXq45Pg4k46mB7vX1zq8LXSdM
         h46A==
X-Forwarded-Encrypted: i=1; AJvYcCUo/sU+LdHHexF1soX1MZBqDCSF4aJUZgF0ehyI+KvdUQniKOdDfVGLTemSFwExYY17z8e+HXL511ZK5m7bnG158s1KTwUG9rZ5tWQs
X-Gm-Message-State: AOJu0YxiTfC5XjjenXeKKQgTZTBfeyOwt7sbjIgpvxyYlH49ZjfIRvzB
	UTLEQdfv8rfm6kDDCDsmzqzwDs/XAgmvHeJ682us9HAPnKTjwMjXPdP52cKDqXY=
X-Google-Smtp-Source: AGHT+IEWv2JsYX9rqRAcHeowDL82ULxOjn8wnAPDfjrZp9nCUz2OxSDSf4uSTZAXJ6WLLd6R3+ndew==
X-Received: by 2002:a05:6402:c05:b0:570:1fc5:72f6 with SMTP id co5-20020a0564020c0500b005701fc572f6mr4650224edb.0.1713933718812;
        Tue, 23 Apr 2024 21:41:58 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id g1-20020aa7c841000000b0056e718795f8sm7351315edt.36.2024.04.23.21.41.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Apr 2024 21:41:58 -0700 (PDT)
Message-ID: <1d2412d5-a05d-4d1e-8d50-53a068b90931@linaro.org>
Date: Wed, 24 Apr 2024 06:41:56 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] arm: dts: allwinner: drop underscore in node names
To: Rob Herring <robh@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Samuel Holland <samuel@sholland.org>, Corentin Labbe <clabbe@baylibre.com>,
 Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20240317184130.157695-1-krzysztof.kozlowski@linaro.org>
 <20240317184130.157695-4-krzysztof.kozlowski@linaro.org>
 <CAL_JsqJfT-jui5P56CO4Fr37kr5iNN8dpxt8ecKeFmdVGnRYbA@mail.gmail.com>
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
In-Reply-To: <CAL_JsqJfT-jui5P56CO4Fr37kr5iNN8dpxt8ecKeFmdVGnRYbA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 23/04/2024 23:23, Rob Herring wrote:
> On Sun, Mar 17, 2024 at 1:41 PM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> Underscores should not be used in node names (dtc with W=2 warns about
>> them), so replace them with hyphens.  Use also generic name for pwrseq
>> node, because generic naming is favored by Devicetree spec.  All the
>> clocks affected by this change use clock-output-names, so resulting
>> clock name should not change.  Functional impact checked with comparing
>> before/after DTBs with dtx_diff and fdtdump.
>>
>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> This adds warnings:
> 
> 13  prcm@1f01400: 'ahb0-clk', 'apb0-clk', 'apb0-gates-clk',
> 'apb0-rst', 'ar100-clk', 'ir-clk' do not match any of the regexes:
> '^.*_(clk|rst)$', 'pinctrl-[0-9]+'
> 
> Since we documented it with underscores, I'd say just leave these at
> least until if/when we define some standard names. I'd prefer we spend
> time reducing warnings from the common schema. I'm looking at
> root-node.yaml. simple-bus.yaml generates a lot too.

Uh, this was already picked up. I will send patch for schema, thanks for
the report.

Best regards,
Krzysztof


