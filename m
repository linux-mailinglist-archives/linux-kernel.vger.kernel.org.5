Return-Path: <linux-kernel+bounces-34835-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B59783881D
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 08:41:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ACC101F257C6
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Jan 2024 07:41:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91D353E35;
	Tue, 23 Jan 2024 07:41:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LbqAt1cg"
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A89B55E65
	for <linux-kernel@vger.kernel.org>; Tue, 23 Jan 2024 07:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705995666; cv=none; b=sTxDFOdjRBd9GPp+mX8bXirv4wi32Pm8E6o72U4JvCaq44DM3RHeIz8tJGye1RLQDFLpFX/IRsxN2hvybLnTKxkPQTZfCyZWYCg3eN3G4Tt/Bwad1UnORw+cHoi4FClQS72ORBzm2fr+hj+P9bLrp6PFpzHfExiKqw7M+EE67BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705995666; c=relaxed/simple;
	bh=TJnNdPCNRxQFntoPN6UvfEfNgTX7iW65qndfnCfw/Eg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=osOhGf0OU5RVEzDCXAZiOMMCPOHYhcr7KclRalD3Sl0uAoQsEkGoR0oHzqzhJx9YMclyVaW/fROV+Pd8zAjT2Do+WKJuJd3eqSOmoa2krSpqJw6N+XODPEMANSg/SMfeYWQx1DfYgyQKCigdPFtCfwEZO9b6UOjU6kkW/BLoXUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=LbqAt1cg; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-40e80046246so23472415e9.1
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jan 2024 23:41:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1705995663; x=1706600463; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UxLKBBc9F3PkpU3SIIcnNgxd/ozhcbYD4jwIjFtLw8c=;
        b=LbqAt1cgrSv1d9zcReP5vE1dlXTuy34inOS5dCiBdj1UhFCULxNAFjhmr7w4hcBfDF
         /v2fhnmnQ1UZB/b7KdRhY9+MtLrZeOL92IUUIlLvXeX/UOHmS6wkXTfKezpqI3DhuDzU
         l+U3Sxs2TfvAk8/AglguJX8i+SHyl7dlrrcJesHja31A28QyXZbMlG5HtdxFugUE0BBV
         ppdAjwWgoNH52j/jIdzYX0ZHxoETTA8IjQB3WNt0Tz1UVjxKBO3w1Be5ZybPxWudppMv
         nVAqYMYfqtgZaN1W6P1CWMMhHYa8uWnbriHuo5cM14vDivF58VoLUgBU0Ym1bNosei84
         4FbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705995663; x=1706600463;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UxLKBBc9F3PkpU3SIIcnNgxd/ozhcbYD4jwIjFtLw8c=;
        b=g5FNc29O9+zJ6SO2+IIP1lSm0BBy8DgCJnFXohBgMrttUWK7PH9DIfuz51KDwogOwA
         1b4p7MRPH0tKq3fJC3GQxuXfI88RcVc5p74ONuY7hPNQBNML9GWEIO5+8xhCKOwfA8kU
         0fhEEcGtagMh8D9p6vKMW9w5/7MuFEy7LxB9iT2tqK8cg26ztQYrzanH2jG+oX3P6nM5
         ApD2Ggf1CykBK3xXLfAPw6Up4zficLsDZR5IfeC5RlFH/GqewckslCh+FlVWPAFwSoRq
         sYdXQly10IgkvTjdDbDuqHu7OrkNmgsK5F8p2+//xCJ4h1MqlqKYD/3Ri96azPmsVfbK
         gmPA==
X-Gm-Message-State: AOJu0YwayPYokdKNhOD/XNCFgzr7b/uTabR4ncWCJPbua7sofkCADeP6
	d90w4VQLPJ+TeEeaKMLLgjxOq5qvkYA+8k0HG4xvfblba65T1/zdUnyD5TQG1YA=
X-Google-Smtp-Source: AGHT+IEsCVg/FQuApgYLqOtXW/axu4CEMCktxpTfxcvKU1uqnL9mTPLI9hKHxFufwOgTeVn6xlDV7g==
X-Received: by 2002:a05:600c:358c:b0:40d:9236:cd9e with SMTP id p12-20020a05600c358c00b0040d9236cd9emr222147wmq.35.1705995663474;
        Mon, 22 Jan 2024 23:41:03 -0800 (PST)
Received: from [192.168.1.20] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id o31-20020a05600c511f00b0040e703ad630sm32824385wms.22.2024.01.22.23.41.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Jan 2024 23:41:03 -0800 (PST)
Message-ID: <dc66e8ef-987e-48e2-890e-418cd582e7df@linaro.org>
Date: Tue, 23 Jan 2024 08:41:01 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 3/3] dt-bindings: rockchip: rk809: Document audio codec
 clock
Content-Language: en-US
To: Tim Lunn <tim@feathertop.org>, linux-rockchip@lists.infradead.org,
 conor.dooley@microchip.com, robh+dt@kernel.org, devicetree@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org, Chris Zhong <zyw@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, Heiko Stuebner <heiko@sntech.de>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Lee Jones <lee@kernel.org>, Zhang Qing <zhangqing@rock-chips.com>,
 linux-kernel@vger.kernel.org
References: <20240120135529.899403-1-tim@feathertop.org>
 <20240120135529.899403-4-tim@feathertop.org>
 <2e9ae099-18a3-4e22-8868-931d41c81f3f@linaro.org>
 <9e5cace9-8725-45a4-a55f-f996a561c9a4@feathertop.org>
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
In-Reply-To: <9e5cace9-8725-45a4-a55f-f996a561c9a4@feathertop.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/01/2024 05:25, Tim Lunn wrote:
> 
> On 1/22/24 19:16, Krzysztof Kozlowski wrote:
>> On 20/01/2024 14:55, Tim Lunn wrote:
>>> Rockchip RK809 shares the same audio codec block as the rk817 mfd, and
>> What rk817 has anything to do with this?
> 
> The existing codec driver in linux already is from the rk817 and thus 
> called rk817, however
> that driver is also compatible with the codec in rk809.

Sure, but how is this any related? Your commit msg says two independent
things:
1. Something shares same audio codec block
2. Add clocks

I don't see how they are anyhow related to each other, IOW, how from (1)
comes (2).

Best regards,
Krzysztof


