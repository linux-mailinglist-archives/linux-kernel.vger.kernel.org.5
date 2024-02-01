Return-Path: <linux-kernel+bounces-47925-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C04F38454B9
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 11:02:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D82E2877BA
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 10:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 745C91586E4;
	Thu,  1 Feb 2024 10:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uMPyJfY+"
Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5854DA0B
	for <linux-kernel@vger.kernel.org>; Thu,  1 Feb 2024 10:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706781754; cv=none; b=l7VDtebFq12WEx2Qs5FDhCpyqgdohYGx7qzp8XNF+wIC8FF4TOyxaXDTbcGOlcaa5vhwOOG7G+UisTlSZJlbXRWnxV24GPLOAT304rKPNo9hvB56AXRWti2e8aBSvWG/CnhdsU0RP2l8Txes/uLQK+h3fb3GYkdCM7zwYNDHWeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706781754; c=relaxed/simple;
	bh=TfD0ZtGAxTwefO1+esgJy6t8W0W6ae6MMnO1dJKq7SM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=OdwVn9YwEWnofTyeiroUB88gsNadHHoeLwcCZckG6HaFWJZlZ9pREciTprqLGslXDbP6LQVDs8gybbXZM+dUEo+JU8ncxi3gl1QxM0FVy6JZyIszJrL9Obi5pMNHEuRSCCoGDtQc3S+nsnMZ59qDlKytDcpGycCBMb0MqtBRivM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uMPyJfY+; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-51120e285f6so857384e87.2
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 02:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706781750; x=1707386550; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=audBvoFkalwLQ9LWdr0sINMEzBT/FVF2oLSjXFkFXBk=;
        b=uMPyJfY+JUdoFdM6T4gHqLo26KJ2PXNFfVasllFxiWj8X7dchasALvbTYe7GKwMTqB
         ehEVQxdS9m6tiuFB7bpugFBIcuvKbP6mMygspMy3om02TFkbU6RsTSHIiKnE4er0xBgw
         rKWhNuePDahxTbBcts/jyPy67Y19/nogAOOE1T2dn0LiozNICrJWN956ibB5lQaMaKI1
         +j6PzacViQan57fb0u6otL9mslFMcGCpFlpmo3X3IbH5AhzjnlhxvN0YS8umQ+WrHYqo
         QgETkLejyFmYT/OizVIRf6t4YvU8kOmThHC2HLh/Qind1Ctu5mDw+kvhSN397NY0uQGH
         q5vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706781750; x=1707386550;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=audBvoFkalwLQ9LWdr0sINMEzBT/FVF2oLSjXFkFXBk=;
        b=i3nrSZ+OqlWITIVd61jSyz5p96UFFy+mFexdRG4Vwj62BWBsC/kFLijlieHTCrv9S6
         FKyeVus9v4l9Fa3izZjnNvluEzeKI1zxXYHLsuNPcF+GU9LGUmow1305M3rEomM4BsRc
         MgzmJvYffE1F15jB3TabghQYOW4V8ijD27cZJC2CNqyzYx12M85n5bXfex7MpnV50wuy
         OAyZzq9f1pTyPpsx+20JLNNFd+DobTO5klNW7IDQB2VmFPyZOGekdUx/DYe2QGjTxjzB
         YDVED8GgDnikyQGMexr1ges0y1rPlVdxMb6UYA8SxKHN1t3sFy5YQOW/UPAm/zbhKyk3
         eksQ==
X-Gm-Message-State: AOJu0YwswZVYvbD1oatgcdYCyah3u5AuMchfrAlyJGPfVxHR9L1bEGuB
	ElOUHgq67TJFi0AGrSHsQ6tVUGmolbc2QP6x2iyhVhl7nSDDb1OyVsTvH+rsnLc=
X-Google-Smtp-Source: AGHT+IGgMq2S2Vy1yRdQCZfE+pr+7lfyUr/Gq0DGu5wfWj/3OWStSU3825vPwCPURjfrS5K7ihHUXg==
X-Received: by 2002:ac2:4550:0:b0:50e:7b5e:b64b with SMTP id j16-20020ac24550000000b0050e7b5eb64bmr1482363lfm.49.1706781750026;
        Thu, 01 Feb 2024 02:02:30 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCW2rTl/r7uee6Gdmq2iQhsXo5+v8iwVnr0vr8YYP85o24/aHbh/fMD+GHz7mld38EuEXrBeg++DPbaLNUpdVOm/bn1VI+I13AFjaVonBFllRatZZR2E1nnJ8SMF77ngjJRoyyQ9FOrk4oX5EBXhH+42jLXS9j7q39iZI9cj82AevoUfI8yLMIQ+Koh2RCtM9dm75gSaHbr9EQUCohOoGocK2a4/tjFpBF4lfqcM1ssryXCvinrBH4CIzx/N7DpOFDOMqoDNH5+YM23L2Wa0xIwOt1J5/UTq2MI4IZAuQXJWOfcKaG5YPsn4XVfvYEe1CFGvPlV7LgSuK3bOoGcPCyT50/pPztzxvfxShrQhF+D6sHsJ2cydUN+/BL+XxlesletaPlLxVzf3vzTvdtnKO+DVxhXg0AacVnYOGOldfvkCgFaewG6FYSfVK4AVB2PDkeHA0w8NN0KfmV3T17Vr93WmKWr7CNlhVLZIWK6WlskjugTJTVKagn7WQNNbJXpbdd6cstu7pW8Cw/RCQwshI+C0TKnjJc1EoajHEmaYOQP9JY8oM6OGrTLmLOis7KRxNo9Uuq6HeOnmq001UqdsTFYDf3X1C9wpSTXouk3UwDN0zJextw+9YisL27EV2TJnDp/xZ4XT2OyIlvnc1PIPSpQ3t8ojcq4etEmE9MdhThglar0dzmuwqw==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id vs3-20020a170907a58300b00a3550c56127sm5675339ejc.9.2024.02.01.02.02.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 02:02:29 -0800 (PST)
Message-ID: <8dfab6a9-f9d1-46c2-8bd1-6ead4b26fbe1@linaro.org>
Date: Thu, 1 Feb 2024 11:02:27 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] clk: samsung: gs101: don't mark non-essential
 clocks as critical
Content-Language: en-US
To: =?UTF-8?Q?Andr=C3=A9_Draszik?= <andre.draszik@linaro.org>,
 peter.griffin@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org
Cc: linux-kernel@vger.kernel.org, kernel-team@android.com,
 tudor.ambarus@linaro.org, willmcvicker@google.com,
 semen.protsenko@linaro.org, alim.akhtar@samsung.com, s.nawrocki@samsung.com,
 tomasz.figa@gmail.com, cw00.choi@samsung.com,
 linux-arm-kernel@lists.infradead.org, linux-samsung-soc@vger.kernel.org,
 linux-clk@vger.kernel.org, devicetree@vger.kernel.org
References: <20240130093812.1746512-1-andre.draszik@linaro.org>
 <20240130093812.1746512-6-andre.draszik@linaro.org>
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
In-Reply-To: <20240130093812.1746512-6-andre.draszik@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 30/01/2024 10:36, André Draszik wrote:
> The peric0_top1_ipclk_0 and peric0_top1_pclk_0 are the clocks going to
> peric0/uart_usi, with pclk being the bus clock. Without pclk running,
> any bus access will hang.
> Unfortunately, in commit d97b6c902a40 ("arm64: dts: exynos: gs101:
> update USI UART to use peric0 clocks") the gs101 DT ended up specifying
> an incorrect pclk in the respective node and instead the two clocks
> here were marked as critical.
> 
> We have fixed the gs101 DT and can therefore drop this incorrect
> work-around here, the uart driver will claim these clocks as needed.

How did you fixed the DTS? Which commit did it? Are we going back to
basics of driver changes depending on DTS?

Best regards,
Krzysztof


