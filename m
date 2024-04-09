Return-Path: <linux-kernel+bounces-136385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D752689D37F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 09:44:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 662841F22589
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 07:44:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302BD7D3E3;
	Tue,  9 Apr 2024 07:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IdUSsKSD"
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A390D7D094
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 07:44:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712648646; cv=none; b=agy87v74d84IY1lfHhw1YvEJo3dQBKnWvEuqXkeQn9HLOhyt9iQgo1WLPQcyYHLIJpgVdwSmcjorHXvvonWZe/d8g4OBnWSRknQFotwVNA80/66V+muMN1j3snVReodedB6ua61/YbBO/ivEl5wfGJsIY9XNrw9R1npRDH5/7P4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712648646; c=relaxed/simple;
	bh=smxO9NYgQ1UBtEJHcl+6GP9YQdUA1xqRhRyhjE6lrcs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=popqnwv7kEkW6jOlk3YXARq73OrVSwSEnIeTeke7o2hw1/4smIkroskw9inmezD9ibXu6AB4oGHshqfoI08sp8frvlMUzv6h5z7BlQBOZviKj8ODFPNwswQWVpDl2iIW3FDhigkuVQvWcqkMJLamTX6e1k9a1uASoggnQnYgI5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=IdUSsKSD; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4169e385984so4968045e9.3
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 00:44:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1712648643; x=1713253443; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qXgPxuM6xZyebW7QlxGXy7PFDPoUiv9xjffDVJT+MBI=;
        b=IdUSsKSDALUzP0PpGXTQIMZisDHm+hXXP4QGonVFX6iImSJghdjoOaEg9ODWikE8Om
         K/T5RnRHrmip5c1cjW6H3k218Qc5nQg6T/xdRv+gS+p+VHlm71mdqC693H+ooXM2fTU7
         038KpeUA1PoYkQc1j+Jw3LXzxue2darbue74KTBAirkKFWYk+JoPZeOxwhRkq+54Sy/E
         2JKEu7dVDqw1tXKRHXyzwzfgCGPiHlp7TjkHoM/wsK6LNMLbvC0RxnJ5ZA10Iy9LvtHG
         OnAsdKQqyHPIG31D+LbhCWtv97JvnKK08tJXWl6rVoaRXTHpXR8QCcJ7eclmidyOiPDo
         oXug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712648643; x=1713253443;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qXgPxuM6xZyebW7QlxGXy7PFDPoUiv9xjffDVJT+MBI=;
        b=iDkd3AAN/pxIBMAIfGAYjDiFLyt5fqiPM0HJvqbrt4cRYrN/iGXPgEyEe1vyB9xsfe
         sUrf01sTk5PqjJHvm+lR4ba/SlcWIFEXSBX+3outKaVHuh+r9PWuLM7DUwDZoBgXmWxI
         eYPuM+0R5/lrIu0AvOQA3TjKGtYIT08roPc/J5LlWhwaD0Q1rFxCTq9EbRot9Iy1gVQT
         YgiQAP9fKd1z5D9BDtoM0K4ZUyLfYFkjMpU8aqzIJVa/OZNK8/YU7WwwcOoM8eWbg6Rt
         CrZVskGZb5aJsok4/DWwie70LRvOX9iMEr06yJBLxf0VSh8uQe8yFMhwBvD5G0UNLgX3
         gQUw==
X-Forwarded-Encrypted: i=1; AJvYcCX3pHSVCJ/GZ6ulssIaTjsGesanxiCYDOvp9RoQawIKLp++QBoiGU80y8AKzkSUKKIzObG71Gx0VOhcJHzCt6bxnGXRcYi+fv+CmVe1
X-Gm-Message-State: AOJu0Yzr4RCdz0kvpKj+KGJai1Qu/shtLejbKKxQpl/RfGgnVwxAuI8m
	xorbLAnm0g6SVpHmPoFxQ38x9wr1IlogBS/B7rrVKVrtCVLt7/ZgQppH+bFjYoALd0loURS7FiG
	a
X-Google-Smtp-Source: AGHT+IE5DPymhuCZLiHQIT1ha7ENdCcfbrI9zxy91ovTsShOMPsERmH86DlbwQZq/FcKp+UaPWD0Jw==
X-Received: by 2002:a05:600c:1e03:b0:416:a0a9:213e with SMTP id ay3-20020a05600c1e0300b00416a0a9213emr904528wmb.13.1712648642877;
        Tue, 09 Apr 2024 00:44:02 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d6606000000b0033e745b8bcfsm10728986wru.88.2024.04.09.00.44.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Apr 2024 00:44:02 -0700 (PDT)
Message-ID: <bc841a30-57d7-44c6-92e2-9a84e856e733@linaro.org>
Date: Tue, 9 Apr 2024 09:44:00 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] dt-bindings: mailbox: arm,mhuv3: Add bindings
To: Cristian Marussi <cristian.marussi@arm.com>,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org
Cc: sudeep.holla@arm.com, jassisinghbrar@gmail.com, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
References: <20240404062347.3219795-1-cristian.marussi@arm.com>
 <20240404062347.3219795-2-cristian.marussi@arm.com>
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
In-Reply-To: <20240404062347.3219795-2-cristian.marussi@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/04/2024 08:23, Cristian Marussi wrote:
> Add bindings for the ARM MHUv3 Mailbox controller.
> 
> Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>

..

> +        mailbox@2aaa0000 {
> +            compatible = "arm,mhuv3";
> +            #mbox-cells = <3>;
> +            reg = <0 0x2aaa0000 0 0x10000>;
> +            clocks = <&clock 0>;
> +            interrupt-names = "combined", "pbx-dbch-xfer-ack-1",
> +                               "ffch-high-tide-0";
> +            interrupts = <0 36 4>, <0 37 4>;
> +        };
> +
> +        mailbox@2ab00000 {
> +            compatible = "arm,mhuv3";
> +            #mbox-cells = <3>;
> +            reg = <0 0x2aab0000 0 0x10000>;
> +            clocks = <&clock 0>;
> +            interrupt-names = "combined", "mbx-dbch-xfer-1", "ffch-low-tide-0";
> +            interrupts = <0 35 4>, <0 38 4>, <0 39 4>;

Use defines for GIC and level flags.

With this fixed:

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


