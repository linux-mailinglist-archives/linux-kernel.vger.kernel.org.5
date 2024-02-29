Return-Path: <linux-kernel+bounces-87183-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A992586D0CE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 18:36:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD4731C21724
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Feb 2024 17:36:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 417CE78272;
	Thu, 29 Feb 2024 17:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QTohasf4"
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64AAF70AE7
	for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709228176; cv=none; b=g9WcciouH+TpjwxeRK7o6+dlV1tP3eqKC9C/zhDt2sTqr8eMFj3GkODKsaRGAVFZiDvRBS6nGyRnH3NiCunv96eAH/nMWV2qBsGqlGMQWXjOPCgOU4wOK0t2FoO49IWNoiYHk7kJSvgcAIPb2o2VcqKgHo7nAaGTp+XgrjS4dfg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709228176; c=relaxed/simple;
	bh=iLSby/jlmJK3uljHnqc3l6N1Z82nXJjM+dUciAyqBwA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=O51d3eMt7il+SRr5xRcyIUmIszvRkmo3obDuCjyLUVy1xvP9q0bUrXj7RkxwrcnYoPlzmiScVVH9pXDZVUY3tjHdz6I9+aqy80wo7WPF2CHoo+zEOgCroFFoaWt1qqZwfWW8OW5QhOwEzDJ8hbmUnfFWN8RbHWshDYqSPI0kuqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QTohasf4; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5648d92919dso2237152a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Feb 2024 09:36:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709228173; x=1709832973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iLSby/jlmJK3uljHnqc3l6N1Z82nXJjM+dUciAyqBwA=;
        b=QTohasf4jtS6SpGH0Q+ZAApYCgobPr1UkD7faho4JHQqsaagedolIUwvfGM7b1l11X
         NzEfdiVJcCdaptSCZEEuoMstLTGZLx/llOQj/Wd2oaVV/0jzW8cKl7xLYBj0wDNZ8uFT
         faeFzuyuyINzUQbpQCO2ofMP5N2b6hAxQrlyb6cqCb8fhEPoop8Y9qkjaRdvmCwmKFWU
         VWO3JwiZQx3QJQgbffFr6wtsxM8ximwbSNBBwjZJs33KBVcDDRUhpPJDva7OP3WA2w7q
         yLOpXacaUA/Slm+9KZ1jfxzQr402q0GdYZaJ/kNndYc89XPczW3K2KbR23JqYWC/6I9x
         qQng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709228173; x=1709832973;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iLSby/jlmJK3uljHnqc3l6N1Z82nXJjM+dUciAyqBwA=;
        b=Gve4kEMDyhxAsIO6J5fNAHPPNjAdM78hGy5nBrrxxLReXSnacEcGxqRmg14WPKhwKY
         nw23Iv/k79Jp6FC+mkI6oURXrsuT86tDaEQikzjYStdQZrGXoJF47DPPEW2QMFxJbkOY
         EZ6C3vTFAv4ZuWdq9OnCbLowWCCe0eKoRtt7WbL25sbGAFi2NlN6uuqwMNy0qB0x5C2z
         dwed73whMT7ugdx2kv3Dun+58V3frgJU6XOGgvj6RNgwCInul4ILfw2teb4tbo5CKRLp
         oUwm4Pq4kfW8b/dd+K6OKN7+dTliaFuZRKPv7W6y+li7EeZtHoe5NXgHLEjTAEzZjxNa
         v89Q==
X-Forwarded-Encrypted: i=1; AJvYcCXoHHHLgzWMsKL7cq16rwpRA8waKrpgnWrv8hydE2eDznwvREAvXf9N0hGykyr1pGnK4C4INl+RgMxzcaN2exZMxfNsHjmD+17HNq88
X-Gm-Message-State: AOJu0YwhL3q+3JCHM9sPRJBJuOvDBQdP7N4IfeqIdC87moyXjAAmHlWb
	d/aCYa6vyyBWU5Rdomy9PQDC1RZc65poIspYDJZfwEoak0acHZ/T6j47ncoO1Wo=
X-Google-Smtp-Source: AGHT+IFywM80eZIH8bIonSuktJ0UT/SAH3nkxmpcNS14qHNuZsAbBE+CbYtErcaJ8+IkhLeN10YZcw==
X-Received: by 2002:a05:6402:5202:b0:566:49f4:c538 with SMTP id s2-20020a056402520200b0056649f4c538mr2158771edd.34.1709228172842;
        Thu, 29 Feb 2024 09:36:12 -0800 (PST)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id m13-20020aa7d34d000000b0056486eaa669sm790762edr.50.2024.02.29.09.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 Feb 2024 09:36:12 -0800 (PST)
Message-ID: <64b15740-901e-4561-b42c-5fd3a0997ace@linaro.org>
Date: Thu, 29 Feb 2024 18:36:09 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] dt-bindings: net: add new property st,ext-phyclk in
 documentation for stm32
Content-Language: en-US
To: Christophe Roullier <christophe.roullier@foss.st.com>,
 "David S . Miller" <davem@davemloft.net>, Eric Dumazet
 <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Richard Cochran <richardcochran@gmail.com>, Jose Abreu
 <joabreu@synopsys.com>, Liam Girdwood <lgirdwood@gmail.com>,
 Mark Brown <broonie@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org,
 linux-stm32@st-md-mailman.stormreply.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20240229134724.1353903-1-christophe.roullier@foss.st.com>
 <20240229134724.1353903-3-christophe.roullier@foss.st.com>
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
In-Reply-To: <20240229134724.1353903-3-christophe.roullier@foss.st.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/02/2024 14:47, Christophe Roullier wrote:
> Add property st,ext-phyclk to manage cases when PHY have no cristal/quartz
> This property can be used with RMII phy without cristal 50Mhz and when we
> want to select RCC clock instead of ETH_REF_CLK
> Can be used also with RGMII phy with no cristal and we select RCC clock
> instead of ETH_CLK125
> This new property replace st,eth-clk-sel and st,eth-ref-clk-sel

You miss full stops everywhere. What I don't get is why you decided to
deprecate above - no explanation why. Also no implementation and nothing
here mentions that you document existing property, but commit msg
actually suggests adding new property. If new, then where is any user of
this in following patch?


Best regards,
Krzysztof


