Return-Path: <linux-kernel+bounces-69793-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E2E1C858EA3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 11:18:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 139301C210A4
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 10:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A647B1DDEB;
	Sat, 17 Feb 2024 10:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wqqnTqQI"
Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2657E1DA3A
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 10:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708165093; cv=none; b=RUTmpwqbz/M52LunrZLdJ/QER77ojy1se7xlYg6/je5ix/KOlX2B+Y1cnc7QP/DfKsIglYRE04CIrhZ1iAmHmf9CKBsHfaZJsReXp/viM40b6Ladv9fUNMrhRv8T+/bjqVX6tUlSy4VxhwgkR11JGB30OIDOgmtbrQC22pOaLQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708165093; c=relaxed/simple;
	bh=ZAihcYyR2hiqYsP1ptzMDqCsff3CnvHyHqm6YGpJUsE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NVGLH+nR3GaHBqpzA0lBdgnTGI0VT7bKHZSoBZ82FfmgO5ZQNfAmzXnp4/FrThkRRs6S4CXe7+YRSpk/iQv8g3a2Z+JoYVxGWXuwBFdueoXO0duJvbtpWtn9+N3hK3oXpEb9Zpagm2UYpGS3qqKiCQ+nels9v09b3UiXt/hPrec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=wqqnTqQI; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-5118290fcd8so3549484e87.3
        for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 02:18:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708165090; x=1708769890; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G09/RC0saxXkfUZDfkgZ+GKUad7uMZWsR5uXIihK6mM=;
        b=wqqnTqQIPUzqtZMABx0Bhc5UPhu+gluI8s66ernP0+thgixrVCQMrzNF+C1V9IwpGU
         lhLXiM/3YArEzoBxe6vryUr2uVZMIL5c13yHuIjfO1ezDtXxp8MkgabvMkW3MztdPg5v
         u8vqPvnu33gViWbJhroCLQWfbZkmPJCAfRl0x8Y1PY86vnSW34D4mG/b0/I1g6xoKl1a
         mJan4yi3PkJcTvBywOmAo6g+2+T5LhHacXplHA3DqXi3oEGJiRrF6qTp6p9RTT5D8dmK
         Rh+e/SUxgEIcFbADL+9aI1/ynUQZAHYu+scuUclqugrSU/SVYYREBdKzt//Pdd2HJQgI
         F75Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708165090; x=1708769890;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G09/RC0saxXkfUZDfkgZ+GKUad7uMZWsR5uXIihK6mM=;
        b=En8RubZkuZ8uiuwCgrfIhiVJPXOa1VuS1Vb/NcGJjyP1ptNONJBTpv6SqMZpzsQgrG
         sDHc1COmkt+94GCBl6chQkxEBIykvqbaqg/3FVU5+iu4i9rGQ674OE3cnmq9lVkXUbW8
         LGpPHukvnYQEtX2ByaUbVu8uXLKr253YWYIdg4aY+ZFcoceD5y0w4nhox6FWsiM4QQuC
         NRbqvKjPxx2udCgt9Vafc9dGCIE5v3lvDhSP7HfT9E2RqOYAhf9GtI2cSxi9pr7XeGqq
         +ZYXDGD/tNKDRmlvVWeOahUQmaUM8dl4UghBtGYdE2EJTqDLT0EKYL/8PUrnBxuV/oyz
         xnDg==
X-Forwarded-Encrypted: i=1; AJvYcCX0IWNYgsdKn6Me2bMrxz3W2+D8pmgQyPs7UtlxNhRvu4TVIVjUqHyXkWfz6fKxmEpIvuIIs7Omw6GwkSw6wBX3x+6eetpCl6Gp5Mbu
X-Gm-Message-State: AOJu0Yx8yhg/TUcaVSIe87ot2RYg0L74OJsbtsA4WP2r87Ww3gl8mqhz
	Pv4nsxrPrUM2jKS+WyVUNenNEZtIJA707Gb2euPvF+jBCx2maq/cxbDX2dyGph4=
X-Google-Smtp-Source: AGHT+IHA1NlaZbjhGgFUPHrEffiPkB8WtxgE6fa0j0SxzFd5fz+hMv2qphs7IubwiFi34Wy6M+ZpCA==
X-Received: by 2002:ac2:41d5:0:b0:511:9fd3:b2d5 with SMTP id d21-20020ac241d5000000b005119fd3b2d5mr4695248lfi.67.1708165090255;
        Sat, 17 Feb 2024 02:18:10 -0800 (PST)
Received: from [192.168.0.22] ([78.10.207.130])
        by smtp.gmail.com with ESMTPSA id tj1-20020a170907c24100b00a3d35bccdf0sm853812ejc.139.2024.02.17.02.18.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 02:18:09 -0800 (PST)
Message-ID: <dd1f1b28-4bde-4d40-8022-b57d201c70ee@linaro.org>
Date: Sat, 17 Feb 2024 11:18:08 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC 0/4] phy: hisi-inno-phy: add support for
 hi3798mv200-usb2-phy
Content-Language: en-US
To: forbidden405@outlook.com, Vinod Koul <vkoul@kernel.org>,
 Kishon Vijay Abraham I <kishon@kernel.org>, Rob Herring
 <robh+dt@kernel.org>, Krzysztof Kozlowski
 <krzysztof.kozlowski+dt@linaro.org>, Conor Dooley <conor+dt@kernel.org>,
 Jiancheng Xue <xuejiancheng@hisilicon.com>,
 Pengcheng Li <lpc.li@hisilicon.com>, Shawn Guo <shawn.guo@linaro.org>
Cc: linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Kishon Vijay Abraham I <kishon@ti.com>,
 David Yang <mmyangfl@gmail.com>
References: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
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
In-Reply-To: <20240216-inno-phy-v1-0-1ab912f0533f@outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/02/2024 16:21, Yang Xiwen via B4 Relay wrote:
> This should be considered a dirty hack. The proper solution would be
> extracting write_reg logic to a separate regmap driver. Leaving only
> "write BIT(2) to address 0x6" to the PHY driver.
> 
> The initial commit is already doing things wrong. The following patches
> adding hi3798mv100 support is also very confusing. The name of the
> enumeration "PHY_TYPE_x" is very misleading as if it's the phy which is
> different across SoCs. But actually it's the bus (i.e. how to write to a
> given address) which is different, not the PHY.

I have many bounces from your emails. Please do not Cc unrelated,
non-working hisilicon emails.

Best regards,
Krzysztof


