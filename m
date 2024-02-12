Return-Path: <linux-kernel+bounces-61812-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B248516D9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 15:17:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AB61281C51
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Feb 2024 14:17:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C2433B790;
	Mon, 12 Feb 2024 14:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cADnfjYW"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A842F3B2A4
	for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 14:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707747375; cv=none; b=HVnzDpJ/+tBr5Wia++iPtUU59+6rneRGfZEqF4JIrChHnsnJPqqsS5l3M1JdUCzJpBnLQQwpF9bSbGFycdjyyn82mgSVJrXfaJ2LjHxtstLjZfvU0kvy97pb9bPdsNxkgCzUwIIErH4VmZkBYztIYo9VvF6/SzQfrpukC2c/c/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707747375; c=relaxed/simple;
	bh=H4/04zivKVAFJVVs+E5Mftrh36HHEgeKNY0LNBAaZGA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XnluEwYC4w+OTGSoqu0XQI6PnzzJ9ygPq04ooCwcT+sY3gsDlnazOn9dnb5I0v0RargBnqhDGBFU77nBMSvpd4sSoE8lnH6Qji0gsIEyLT8jlfEGdGQVwMy7TkzLcdYTyN5pHJ+VuaT+l/7/ahf4dPQ/iYm6wLT9P3wWmq7+A/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cADnfjYW; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-410ee8ed659so3820285e9.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Feb 2024 06:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707747371; x=1708352171; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DQX3D7uSYgu1r4rqjqsVdtDZuOmWbLq20gw1bWo5TGM=;
        b=cADnfjYWENZ3F6mg8ATuMPcSYp2nsj3f7t5uNRP/M3zk74zGC+5VFYTHYY4DW5k3gL
         PmOJHMBGTYtHM5AmjYGRFKZVF25PYlb9xtFUPa9cH2x39TkfpS9hfLQ7lFasAosDm4a2
         CRMbLyDC25vyTmVsYDvVKgKLDevw1Rtexu/UJWJ+cPKVDEyus1DoBkoXQhmv1AO7j2t0
         3C2rPCc2l4/bY1WislhInsvVMgjEEohpUjhMzPoUwQyVD6AIOH855rdlRVQxaH0JC/r4
         tFqj/UCuVPNlMvbaCqTb3PNyeWwzi88i5UfvblUGvUgv8qwV83bZHTVWpyHWftrS15ya
         hEkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707747371; x=1708352171;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DQX3D7uSYgu1r4rqjqsVdtDZuOmWbLq20gw1bWo5TGM=;
        b=tFkG2rslvFvgQBhaUXJHoafsgH+Lpn1BiMLH3fEhPfb5Ln4r2Ur5FcsDxkSmOhV3f1
         pqKN4BuJxgGjOdmXRdmFmLhlwfECiw3b4wE6HehKj5MrnuGpt95YlHgqHco9eNP2q/qo
         TAApLcaglln/tuD7nPkXIUKrUjTlLE/IRYyuW/Ju6A2n63u/g2rdtDTPl1xvNpFZ6+jD
         dbhzBuVYEmg+urTZtC2LksMJRN0TvxKSMa38m3n8m9jSmtpq2bCteJCKPU0SsAQAr0XL
         0Lo/ceu3yMqWrU4IIxx+mrRpwbo9IQvegSEhklj0hDjguBSY1VSIhnHnn4WauWWmIA+d
         IX9w==
X-Gm-Message-State: AOJu0YwP2v2B8NAkfLcEwCoyqlUYldh699A5f79A4Ufsxn6Cb9zTC+Ub
	P8xsFz7+zJOAqzdAZxiKmS8PuVhbj6qxvV8is5ACU+e+Lue5bUX2pmFdNm29VgQ=
X-Google-Smtp-Source: AGHT+IHBNzgzVJG64iRD6HyjjEvHDaia2pqj+0FrY5DYd9WSkmbsRvrWf7kZ91Xv/bUce9tOwQv87w==
X-Received: by 2002:a05:600c:19d3:b0:410:2b93:4908 with SMTP id u19-20020a05600c19d300b004102b934908mr5920183wmq.4.1707747370880;
        Mon, 12 Feb 2024 06:16:10 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCUeBs4qyXfYqxAm+ZVzlkcKDbAMLq+dtw8laFxEaT+UmhQ1yoWgcDydGlnI7B3AzVd1oRlMylYAPF2dwvnY6I3OhiZtXRb6/ao0TBv9Ie/escMhqONrkwmCzniJGd/KpbSasnGsZKEkxasVBqQSIQRcudqVXZIO8fN2HCUvqGz47xJT9W0qqIOWFYJ12e3bu+UscyuxSqeSpy84g0bhlPIOUdEuLAgZrgLsPPrNUk9qRpSz4TnsbsJQrf6+Ps4DainoGvzo8PrKEwGpwMYmeKhvWBSZ1QTmdqbL3NpAza0+S2QI2M6NsEc3QYLVWWGtKFFAxfm0Qmj4o7ax4LIqcNk584aQ4cO+iIHNFyYX/RZ8gkq5uKRC588S6dBiSUP2mk5LBPVDkp3f0rMP//YyHI6LOSsus9vdrlOCQ2v6wngIjQDSHQIubMbF5LoAt7QeSm+BrT823yw2VpjjiGmUEJyqgFNi/yRzQ2LIDwzLsBOT3ptqX1ZNfRjJC3tYY0byGOrqT0oD+L/mHoXhyKpgCQIeaeBpRFbYPY6zEtUCI1+QsxudVayqYoAjRQVJIUBxGYdzS1b17pLN/9ENb5hAnFOHyTGiFCefQwl1B9hmNxwHaXcDu1pNvWhECVrIPTfkMslib8oqBMsW/PBj/z1HOHhdA7r+Jg/JdXkob22BDMziAVXleo9oN/Y+qj11Hh0s1qkN4SfjSD3+PNn0409xkO9wqYKrnV7NP2/CgwrcxXhjGi828lzfupHwPjuM7ZL8I1Y7AtXEkuicTZIEEytS+Rn57gfQhG4Ocx+oFPxd55Sjq4/Bw5U02pg=
Received: from [192.168.1.20] ([178.197.223.6])
        by smtp.gmail.com with ESMTPSA id y19-20020a05600c20d300b00410e8ef51cbsm1789757wmm.31.2024.02.12.06.16.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Feb 2024 06:16:10 -0800 (PST)
Message-ID: <58e45922-5d84-457a-9fe2-ccb5dcda0fd4@linaro.org>
Date: Mon, 12 Feb 2024 15:16:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/6] reset: Instantiate reset GPIO controller for
 shared reset-gpios
Content-Language: en-US
To: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
 Banajit Goswami <bgoswami@quicinc.com>,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konrad.dybcio@linaro.org>, Liam Girdwood
 <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, Frank Rowand
 <frowand.list@gmail.com>, Jaroslav Kysela <perex@perex.cz>,
 Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
 linux-arm-msm@vger.kernel.org, linux-sound@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
Cc: Bartosz Golaszewski <brgl@bgdev.pl>,
 Chris Packham <chris.packham@alliedtelesis.co.nz>,
 Sean Anderson <sean.anderson@seco.com>
References: <20240129115216.96479-1-krzysztof.kozlowski@linaro.org>
 <20240129115216.96479-5-krzysztof.kozlowski@linaro.org>
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
In-Reply-To: <20240129115216.96479-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2024 12:52, Krzysztof Kozlowski wrote:
> Devices sharing a reset GPIO could use the reset framework for
> coordinated handling of that shared GPIO line.  We have several cases of
> such needs, at least for Devicetree-based platforms.
> 
> If Devicetree-based device requests a reset line, while "resets"
> Devicetree property is missing but there is a "reset-gpios" one,
> instantiate a new "reset-gpio" platform device which will handle such
> reset line.  This allows seamless handling of such shared reset-gpios
> without need of changing Devicetree binding [1].
> 
> To avoid creating multiple "reset-gpio" platform devices, store the
> Devicetree "reset-gpios" GPIO specifiers used for new devices on a
> linked list.  Later such Devicetree GPIO specifier (phandle to GPIO
> controller, GPIO number and GPIO flags) is used to check if reset
> controller for given GPIO was already registered.
> 
> If two devices have conflicting "reset-gpios" property, e.g. with
> different ACTIVE_xxx flags, this would allow to spawn two separate
> "reset-gpio" devices, where the second would fail probing on busy GPIO
> request.
> 
> Link: https://lore.kernel.org/all/YXi5CUCEi7YmNxXM@robh.at.kernel.org/ [1]
> Cc: Bartosz Golaszewski <brgl@bgdev.pl>
> Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
> Cc: Sean Anderson <sean.anderson@seco.com>
> Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Are any reviewers comments unresolved or unsatisfied with the
discussion? I have impression that discussion bikeschedded a bit towards
NONEXCLUSIVE, which was later clarified that NONEXCLUSIVE is not the
solution for this problem, but maybe we miss some final Ack?

Anyone is here unhappy with this solution?

To remind: this is a generic solution solving at least two people's
problems, probably more. It does not solve all people's problem, but I
doubt anyone has enough of time to satisfy all people...

Best regards,
Krzysztof


