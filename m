Return-Path: <linux-kernel+bounces-66414-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5076A855C66
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 756821C21DEF
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 08:24:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34AE134B1;
	Thu, 15 Feb 2024 08:24:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Nq3HHa8d"
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com [209.85.208.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E733C17
	for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 08:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707985460; cv=none; b=jcRuBj/slUjyHQTkNUgToMGFBq6kBvQGreF+BY9xfq8QPFFLd7vNE+5zkiDB+eRYuKZXBKiGU8X/5NG5VjpPa9VWeYVoMP3drpRpI1QEzf3O3xNpOezMyJ/u7bh6ooGZD5EvD3IlfDuspyPd258mP0VoRgZExxw56gFtRrm6p3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707985460; c=relaxed/simple;
	bh=wnUBH1VhNPx79Exig+hMwiYyDb0NRwe30R1lRnmUHvU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a5pyi1H8zm1Q95BwXWl8XktoEQlwtsnsiLy69IgyAw43sdLgwOxEcqlFt7T/o/SQCZTwb+HFhVcQsH+7uCfo6KBX9s50VHrmYyJscNevqIKvZ4Fbk55KbXGM0xY6tRd1J/2M87O5Tvj5vgWqeqwGkOHZiYwChBIgbyJ9NGz9QFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Nq3HHa8d; arc=none smtp.client-ip=209.85.208.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lj1-f180.google.com with SMTP id 38308e7fff4ca-2d0f7585d89so6688741fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Feb 2024 00:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707985456; x=1708590256; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=trfg4+xWum33uVUB6CG91+USLu/b7kuYi1txCb8DJCQ=;
        b=Nq3HHa8dYMZVIBkDryar8Noh33jV/D3gnUSDrskmJgblVFbdVXQumg+Z9tRmw86P4s
         +saqqTT3Eddz4T+2QnEtRSHYUQ7ivu8tP3e5FrzQNKX5lut7sQl19BgbCkSHRiPyyWkr
         QS1E+40j6n3nPN6c/5n9DDeHz9L0y9flh6zDBsESyBQm5uXGGrXJMj07hdJVExEP2wgo
         vVptsoAkcVh+MrN7zQ1Pa+49YgpU6EPnjHXy+CTgawl0CcSYermMgsi8cEc8VlVXWBrm
         AU2R9FKaGhZph48s1c1nZB85my2JDAH70SuNaLg6SSFUUuyYEiPS5egvEUZK9QW0w38N
         1Z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707985456; x=1708590256;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=trfg4+xWum33uVUB6CG91+USLu/b7kuYi1txCb8DJCQ=;
        b=tp+r2352wq9rle4wtIAKaAuA1zJ86xz7DiWeghBZzSzSgrEVWSDsHzNSgSJRqOXSIW
         iURtD4LNHFsMjd4QnsMymA689G2sPNS2QAP63BSYxPnbSiAiXOhD8cyZcy0Wj8CEwiM5
         y+Re8dSZldqZ3nQLKrcG3uy6hk1y7UUOcXtJXkLX1LiU5sILwLsxT4e2Tvlz9TGQpsjk
         juva9NQxlOvBBOCqdlInBp4/XgYm2wcZtbSLjk7MLcy3ymIfWSOv3ALMJqkQpX8lhWo8
         JWh/m+PGohFinx4uQJSUNZoptlvJXsyF8V+NuTf6v3aDFWR1SKaEUnNZR+FNzO8xkG9a
         thsw==
X-Forwarded-Encrypted: i=1; AJvYcCV4yZl/r9wtSyN4JEE5kzfNpAJxu9beXrOQ4nBx0N9i04GOH80HCvktTkf3Yc8LvN1Vk/WRncVrAjMQ6Z+swBM2E3OvVhdARiUDaNLz
X-Gm-Message-State: AOJu0YySqy1w2lw1xhdguI5zqrEWvn2OHBrU1CCBeuPtBTNsEyvO7SCC
	IXBq20qWPeph3fqAd32c6u2H9G1p0u2UElBrL8vN16O81wOSxX2X0ghJtck9mJI=
X-Google-Smtp-Source: AGHT+IFB/cl+K8o+EokXbjb+xzVBKV6VljmG+JW9bBjcsAbAP8MBZEpKH7wpdOVZvJhmVzdsaWPCbg==
X-Received: by 2002:a2e:9a86:0:b0:2d2:f50:5a04 with SMTP id p6-20020a2e9a86000000b002d20f505a04mr124384lji.32.1707985455725;
        Thu, 15 Feb 2024 00:24:15 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id f23-20020a2e9517000000b002d0f3c58e60sm177617ljh.117.2024.02.15.00.24.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Feb 2024 00:24:15 -0800 (PST)
Message-ID: <98c9d3ce-8a97-499f-b78a-b918a06ec779@linaro.org>
Date: Thu, 15 Feb 2024 09:24:13 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] dt-bindings: cpufreq: Add nvmem-cells for chip
 information
Content-Language: en-US
To: Markus Schneider-Pargmann <msp@baylibre.com>,
 Viresh Kumar <vireshk@kernel.org>, Nishanth Menon <nm@ti.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Vignesh Raghavendra <vigneshr@ti.com>,
 Tero Kristo <kristo@kernel.org>, "Rafael J . Wysocki" <rafael@kernel.org>
Cc: Andrew Davis <afd@ti.com>, Dhruva Gole <d-gole@ti.com>,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20240206145721.2418893-1-msp@baylibre.com>
 <20240206145721.2418893-2-msp@baylibre.com>
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
In-Reply-To: <20240206145721.2418893-2-msp@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 15:57, Markus Schneider-Pargmann wrote:
> Add nvmem-cells to describe chip information like chipvariant and
> chipspeed. If nvmem-cells are used, the syscon property is not necessary
> anymore.
> 
> Signed-off-by: Markus Schneider-Pargmann <msp@baylibre.com>
> Acked-by: Andrew Davis <afd@ti.com>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof


