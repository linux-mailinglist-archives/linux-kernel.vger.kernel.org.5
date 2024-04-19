Return-Path: <linux-kernel+bounces-151512-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 03F7F8AAFE4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 15:59:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFEFC2844F4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Apr 2024 13:59:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6E1012D1FE;
	Fri, 19 Apr 2024 13:59:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dmabJk0+"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9155185C62
	for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 13:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713535172; cv=none; b=MXODGT9uzR1MkDx70STbQReJ6iKiI2kDgqK27Rpl9KsF0/0YzNu5P3vK4diYLaG35+kfcf0W6wOCPbgZn7LhCN/It4upjG0IyBJsC055TjNUsQ00ZJwr+nz2EsmIPWhgEVJn4WUYUen8ChldZqyOx7/ehKtPoq3UJFzcdnqL5qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713535172; c=relaxed/simple;
	bh=Rtp6EomSg34QDnB/DO9vcNVeaEKrjGD9FUc81vnwyVA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=exIJBG7f8wmzMGB3m34CKk+FKaluKlufYurMyEvNuQAbrOKMdBMTY8k9QlFORh3kjdvD7CRgRxTyGvLcF2zRPp9TSzrfXXxfiPL+xyvI4j1i0DzvCvOUjFfzNsWV0TuUcfBW6LalEILfmwXzD6z7J87WYpx66Sd5jHEcTM++Lto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dmabJk0+; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e4266673bbso18963985ad.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 Apr 2024 06:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713535171; x=1714139971; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=swab0zSdw10hxMdYkqjuezBlmlNMMnw/lraai8RhlAo=;
        b=dmabJk0+5lFUokGCc4qCbQ/ccihrWYLfBrsQs8IS0NykLQJ0mH+QRLqRpHNbct5dcT
         IE1FvVaoZJmKrJj+kCxbEiDjg+9cCYRlKdI9U3h3Z04yw1ZAaSYlXtdxvch57ozB75/a
         y0lHotTooT59jeMzvJfRXSuV4LhEXBWVg2VaiJ8oq6JH1UUp5/3WBG/muHY+FpO4BUfh
         ZuGIQ2XjTlGZu7FAjL3MrKRMo2HQtD6TOTNHKg+zyOTgHHQuZZbc+VRecydYkTCdAhYG
         03BM7Po5JJ2ued/wxWT6QlzyU7lWuldHxtpqitgHrqpje+NR/qXqAY9Ufxpbp1FQVTrL
         ME3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713535171; x=1714139971;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=swab0zSdw10hxMdYkqjuezBlmlNMMnw/lraai8RhlAo=;
        b=PIs18niZjZfhly2n6oIbRP8WnzHC4UqcJdSR3VMXQJhyle2y6Taqer6iYb1F5gtEcg
         w/morptSS8ZyN9M6mlx9sPLfcft1XOrr+pWuZ/9QYoE+D35rYz084ko3z5+R7Ph7u6WJ
         Sn/Bg/bo5Ijn1Y0i19pCMufcH8jiVH0D3Sr+fquXVun2SN6Ot24eAo4KytrslWzHpQwQ
         FJSAqSChrTDQUBesKp1cFnTX1a6OyL0oNmlIVpOymQJb/XQ/LrRUTOL8xzy7dMyQsgK4
         Uw6S/WR/NhdFIBZMgK1kd6q066SgegQ/vX4kkM0EEB951BWhI5OxNIL6isZLdR1kUAYq
         HvpQ==
X-Forwarded-Encrypted: i=1; AJvYcCXNLW5l6aL1xCy+9Ew2IDtCDr8Bb0+CORUiV6nwGoqXp9fRbXvLsi39wtbx6Tea/EdB02L+t1KW3CpoGgkLOcMGNBb1EIAgcLaEfKuv
X-Gm-Message-State: AOJu0YzzcgsrJhvSUdyhHqaEjSE+6ttitQynUouO4ikgYSWQQiXMi+uv
	Zk6yDCJ72yl80PbBHV4qiR60HUVoLvTYKHtHoaOOs3QVkzaOFfG6/lRgrw7GBuU=
X-Google-Smtp-Source: AGHT+IG3+py0UfbBnoy0ezHsrM2EFqmJz0VDQPdZT+uHz0SWAzJ6CJLJ/xJVHGlRYI2kSIu49H2/zA==
X-Received: by 2002:a17:902:c40c:b0:1e3:e8e9:5f28 with SMTP id k12-20020a170902c40c00b001e3e8e95f28mr2487068plk.57.1713535170883;
        Fri, 19 Apr 2024 06:59:30 -0700 (PDT)
Received: from [172.20.9.36] ([209.37.221.130])
        by smtp.gmail.com with ESMTPSA id u8-20020a170902e80800b001e0b5d49fc7sm3366443plg.161.2024.04.19.06.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Apr 2024 06:59:30 -0700 (PDT)
Message-ID: <5f03207b-c29b-4d16-92b0-d14eef77bf17@linaro.org>
Date: Fri, 19 Apr 2024 15:59:29 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 6/6] arm64: defconfig: Set CONFIG_MFD_TPS6594_I2C=y
To: Judith Mendez <jm@ti.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Conor Dooley
 <conor+dt@kernel.org>, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Bhavya Kapoor <b-kapoor@ti.com>, Dasnavis Sabiya <sabiya.d@ti.com>
References: <20240416221648.3522201-1-jm@ti.com>
 <20240416221648.3522201-7-jm@ti.com>
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
In-Reply-To: <20240416221648.3522201-7-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/04/2024 00:16, Judith Mendez wrote:
> SK-AM62A-LP uses TPS6593x PMIC (interfaced over I2C) to power the SoC
> and various other peripherals on the board [1].
> 
> Booting SD with UHS modes have a dependency on TPS6593x PMIC driver so
> change to built in order to boot using SD boot at the higher speed modes.
> 
> Fixes: f9010eb938be ("arm64: defconfig: Enable TPS6593 PMIC for SK-AM62A")

No, that's not a fix. Fix is using proper initramfs, because bug is lack
of initramfs, not having it as module.

I don't agree, because I prefer to have this as module.

> Signed-off-by: Judith Mendez <jm@ti.com>


Best regards,
Krzysztof


