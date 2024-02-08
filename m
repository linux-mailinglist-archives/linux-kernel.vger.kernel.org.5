Return-Path: <linux-kernel+bounces-57599-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A66E84DB39
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 09:18:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B63FE287B75
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Feb 2024 08:18:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1EB6A32D;
	Thu,  8 Feb 2024 08:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uMAv1Rqo"
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB7466A02B
	for <linux-kernel@vger.kernel.org>; Thu,  8 Feb 2024 08:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707380317; cv=none; b=C/K83j1EAxTV27Jot0n522BA5svxguupFBg0VCVeQ8T8SgMr4VFTVDghKYE3X30T2ZuoAtdep77FQdqgPbfrkfbaewdoaGlUVweZnm9aXMXNs6aQ5TbfvBpLDkD4v4gEeHmOU/pTl7KuQpih8+wyuU3F6wzy+IjIyShP4oHC640=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707380317; c=relaxed/simple;
	bh=In4a4vrqLX9sCFsY5nVTISbjfWTc0Bpdsfw7e93b3CM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CRTB06+ykNhybUzzQJ4lUM5kymeaf4E2vyVtndGgKb6ZT5RjmgHVNDFfkavSveHB9+Cs3+XuQXCbLf1ON7/LF08mMNK10uov9lXWjcid5oBUU8dzgfbr2SuN4qF42iN6Vd3i+fA0hG+d8Xd+FqcrG5m6oZgvhMuZXW6DGKbMVmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=uMAv1Rqo; arc=none smtp.client-ip=209.85.221.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-33b5978de44so114878f8f.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Feb 2024 00:18:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707380314; x=1707985114; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=U5IeGmr/BRHYFwHhkR4WYY9RzFaPQIgoWY2Efc4LYsA=;
        b=uMAv1RqoVlwBQtbKDeY2BGttIGyvHg8Eq+9g8aOjCdxxNh4Fr7dIHunyRmcATeFl+y
         xNMDrNjn7n8aTwpKoeKhCegKSieuivupyEdOfEdeoRI7gOOkaEad1NClwuj1yuaFzHQn
         0qeOiJaPB3PKyqHVUXn/rM1QcV2uvcqaEo5ANX5oMkWu2BoQBbeZeh1DGT3PLNvN7PDy
         kGSswZ0v3bfuVaPYGkPKO7XHnbrnw7BzhFOlA1XBqH+ZmGkmkWkuckjUle/ILRw97SW+
         5pXt69CaqY82vjRFtzOiwabAOIkhryXc96aBSmV44Lk1NLFCU6vS/IBD0EobAxAWdUeD
         2THw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707380314; x=1707985114;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=U5IeGmr/BRHYFwHhkR4WYY9RzFaPQIgoWY2Efc4LYsA=;
        b=eUSauPhOsJhb07Q6Iu6+ZWEIcVyUpl+FNbU66H+A/k2Dg/xhspWQnAs2fq3xGQwtCB
         iVLjL4M8C7ntvsYWpVTa1fZj1wSUTHdVIq5kCBEXp/McgSW0TjCEzWuf4yfiXNqPfwF4
         38pDQk2P87lp+VNIFMYHmR0GsNfEhQXCJRCOH3J90O0iNkhNV3X1DOmfIR4FeTxVZysS
         4sz646jrgaip3UWmpowiMNHL/c+3sZwvo/qHJCWP/bVHPMIEL+v1NvQQyahdsm2ZeidL
         uPcLOBU4HPXHdKbubmjob9bjmTyFwYdEBGEJBVdBzlNEOHWN4rncpOukxjUGKxN7vdxj
         +mTg==
X-Gm-Message-State: AOJu0YxcyVArU5faqdzcpjHqwI4utapR9XVRgcuwxsJ2nY2eQBbjXGAg
	FETYAaZUJK5Rx4UFU3X0rUx9HjgCK+17A0l3GI7kB3gl9vDyeITtI7R+Y+hU/SI=
X-Google-Smtp-Source: AGHT+IFBtnwgPZJyq4CqRVsjAsUa5LK67uJ0erXAqzftv6XYITinx9759RnNP+xk29D+8XwDJmDagg==
X-Received: by 2002:a5d:540d:0:b0:33b:266f:3505 with SMTP id g13-20020a5d540d000000b0033b266f3505mr5129606wrv.63.1707380314346;
        Thu, 08 Feb 2024 00:18:34 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWWvv6MeQC68YJsWv9TCvYQA4dd16RY2Iz8ZoA4OFu1RZqbxoEkUkkirLd6RWCqEx6m0VqOMRzkI/XRtAS8DbHbW886F/FRldVyA8D8apA78YaIMq5p0jtGCTviblWhroTJbltlpLBB447E4xTJLCXj9DzzzfTJNDnYM4YkwomSql5BLkt8/1cQDEdDcAAwJMiS8r14tNqaPg/GYXG3uS7tNTnrCWUQ2VoQm+PufKMOKwHSwnBaSE12IfkzwUs3+eoCnxSH4B5ftP0BgKZGpjsPvtUa6mE+cShy9KRO/5gcCmZI/qnGfSW3+Zl5Cpwj0S37dDxNVveQW6uqSjM/t0citKvOyE5QyMH5sHnsvaKU5ocG98iW7y1J+2XD0P8bt4cFu6qLIoBywRIMmW2QIivE8HOXWa/9adgpKoEKv+dfRqh90hyIFmX8AYKc5qwyHPTZwZr2OZ7g+0VbsHIXTBXbzrU3lzEcrgxAKAHvQsw1wYShomu360ZCAWbGLjkrCmJHcdVpimYoYDrnI9Vu+ZRcVCC1AQ==
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id r20-20020adfb1d4000000b00337d6f0013esm3099374wra.107.2024.02.08.00.18.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Feb 2024 00:18:33 -0800 (PST)
Message-ID: <80e58f2f-b98b-46de-bcd4-fccbab11422a@linaro.org>
Date: Thu, 8 Feb 2024 09:18:32 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 4/5] dt-bindings: iio: light: Avago APDS9306
Content-Language: en-US
To: Subhajit Ghosh <subhajit.ghosh@tweaklogic.com>,
 Jonathan Cameron <jic23@kernel.org>, Lars-Peter Clausen <lars@metafoo.de>,
 Rob Herring <robh+dt@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Matti Vaittinen <mazziesaccount@gmail.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Marek Vasut <marex@denx.de>, Anshul Dalal <anshulusr@gmail.com>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
Cc: Matt Ranostay <matt@ranostay.sg>,
 Stefan Windfeldt-Prytz <stefan.windfeldt-prytz@axis.com>,
 linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20240206130017.7839-1-subhajit.ghosh@tweaklogic.com>
 <20240206130017.7839-5-subhajit.ghosh@tweaklogic.com>
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
In-Reply-To: <20240206130017.7839-5-subhajit.ghosh@tweaklogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 06/02/2024 14:00, Subhajit Ghosh wrote:
> Driver support for Avago (Broadcom) APDS9306 Ambient Light Sensor.
> Extend avago,apds9300.yaml schema file to support apds9306 device.
> 
> this patch depends on patch:
> "dt-bindings: iio: light: adps9300: Update interrupt definitions"

Drop the paragraph, not helping. There is no dependency here.

Best regards,
Krzysztof


