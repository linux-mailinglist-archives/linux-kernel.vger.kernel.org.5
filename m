Return-Path: <linux-kernel+bounces-144168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92CDD8A42A4
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 15:34:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1406D1F2139D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Apr 2024 13:34:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D33F45036;
	Sun, 14 Apr 2024 13:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EdrBSSQF"
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04BA42D61B
	for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 13:34:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713101688; cv=none; b=euaz8S+Am7vugktKsGndVm3mubY+fi42sIPMaGMnmuVQHVK/pWDWbxxVlM4FzzbxEQJSkFv9PHGA42iQ2+Y5/jW81RYhi27X6qobMgaO6hLPV4ZuSpgu+5tSIFb3xWPBD4IvnGWeZSzuOsk6uopXnD9pL5m43GKONEMPu2faY44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713101688; c=relaxed/simple;
	bh=BFwpUNbDE8oHK5OuttChp0ixMoA0D43yEsMBZL1TZ6A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vcrak9/ZxWOSNfyqrKvolKW856Uc50ohsJhPQDbt28UZNcdta8WLqZVg34moSvM28ckZyKxWMo5ZFaU+Yogm/IddIDUDN0ZAB+cn/l4q9RxEOIZq84oVcQ0Cl+LfnwrF+dA8pH2eCARzQwsbW4LCBhURIwefeeMW3lVPYne+Z0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=EdrBSSQF; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a51a80b190bso149254366b.3
        for <linux-kernel@vger.kernel.org>; Sun, 14 Apr 2024 06:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1713101685; x=1713706485; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p9WRp/DXwTfjM7jCbPUfLIfu1BhKAQ/wCVJgQUHS27U=;
        b=EdrBSSQFrl18h7H15E400s7Jx1HQh4zIS6yb8JfJXRAWJRQNx7RV9fUcOLxyj4J91D
         FD3zuUo0khp5xkUAxi4LDyLhHCcgoZig03BWaemkDYHEZrtyoJURXGP2z6iJKGz02xYW
         LuGINCrsPGsM0F0xKQ8IhMDYbDwzxdHGGOG0L5NyAm8xjVvkGu84P2wb2TAnEPARHyWg
         QVPoDIpGBebsyHuA7UiWAB+q0WQyoxxPmENaudy4bHWckZ1+x1VqMydppBNCmohxVKuR
         ywwzzioJ58QJaOusRmfKIwsDJinLCzZD/YHQbejotpLBfBqLDKVn0D0HoNGN8YDU4WA6
         mnGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713101685; x=1713706485;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9WRp/DXwTfjM7jCbPUfLIfu1BhKAQ/wCVJgQUHS27U=;
        b=aPTJGp/0ioRLtIV/uRjyget8ALnbzGSIXFifQB5lmthyL/L+8qWHvFppJjrgMfonsP
         vBhYns6NM9E7PY/yX0R6sWZsvda/OTjKD2ZePGksznXToFAs95qnM1QVVmCRTYOTZrGZ
         jKhaR1Swq96bNpn4BHfosYQMtH3d1p4ncUK12LUH+gx7loliy4j3nR7khsPm2+j32pCP
         Y1nEXr/VKXR5hdGBBtcnmEfFi92mAaewDLb3mxZZLiGVFZURmPSAPT7Hf5cJkiJewFtR
         Xy2dXFoOAI5OHajw77Sw/ZOaJvc12if1sX3TD4ZKaYBIv8E8MNfc5XUOR1y5SUe2Xijh
         YwcA==
X-Gm-Message-State: AOJu0YwIqw+947k35OrFT6EeDO39lgx5iVMzR+hPYkA2K2GK/uAa0uxX
	9c/5ot2NdfQ9SEo1vmnQYjtSEcCei7L4OLkNFynCOk8XfY9LbnvXHXMLCRX3l5A=
X-Google-Smtp-Source: AGHT+IGJ1MQFIQeX8NdATiEbi+puC1QKsoQXOyV3VT7/QE62EmBSeo7VJtdKT3Gze8ggEIwsxL2C+g==
X-Received: by 2002:a50:8d1e:0:b0:56e:2e4d:884e with SMTP id s30-20020a508d1e000000b0056e2e4d884emr6906275eds.0.1713101685360;
        Sun, 14 Apr 2024 06:34:45 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.16])
        by smtp.gmail.com with ESMTPSA id ew14-20020a056402538e00b0056fe8f3eec6sm3491110edb.62.2024.04.14.06.34.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 14 Apr 2024 06:34:44 -0700 (PDT)
Message-ID: <17922367-b742-4474-9426-e8a0b27423db@linaro.org>
Date: Sun, 14 Apr 2024 15:34:42 +0200
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/4] DONOTMERGE: ep93xx-clk from ep93xx device tree
 conversion
To: nikita.shubin@maquefel.me, Michael Turquette <mturquette@baylibre.com>,
 Stephen Boyd <sboyd@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Alexander Sverdlin <alexander.sverdlin@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
 Linus Walleij <linus.walleij@linaro.org>
References: <20240408-ep93xx-clk-v2-0-9c5629dec2dd@maquefel.me>
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
In-Reply-To: <20240408-ep93xx-clk-v2-0-9c5629dec2dd@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/04/2024 12:03, Nikita Shubin via B4 Relay wrote:
> The goal is to recieve ACKs.
> 

Why? Entire point of previous discussion was that you split your patch
so it can be merged. Not "not merged".

Best regards,
Krzysztof


