Return-Path: <linux-kernel+bounces-49364-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B27846934
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 08:24:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DC3FF1C24316
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Feb 2024 07:24:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 015F2179AD;
	Fri,  2 Feb 2024 07:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eCnUVXmH"
Received: from mail-lf1-f50.google.com (mail-lf1-f50.google.com [209.85.167.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 609E717995
	for <linux-kernel@vger.kernel.org>; Fri,  2 Feb 2024 07:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706858684; cv=none; b=jN7BF8oeiA3q0KuEC98wyLkB46FStuRZsv1MvytAEuGEIQeBbmNY73iF+8Ibqbs2vxu6/IzLVIc+kBKWE0S/z+5amks/M+1JGN3q1Cr5jrAlbVDlcnZRV/tpO2doLD03WHT9rUQKGWmsS6L4ZZP7SSwCa2TIhPvKs+BLIXFaDDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706858684; c=relaxed/simple;
	bh=jq7U+PrO9oxQCqUKYaG3avcDemAN+/LxsoMvgkBnnx0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=W0n/M6W717Tye6ex7Tg35ZVG/qaX5G6RCOkRbOaRQ4aSYKofu2zb9b/dBmAyXb4A58ndgUTdlHpFnkOZYCPo0MbDGSQGwoWG6FhnlBNcaeL3wdMPegotDHfX3TZDiY+I3XH4J96/DsNJ832p+NYr8zS8YcL0y96AW9Z5+NPwOOg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=eCnUVXmH; arc=none smtp.client-ip=209.85.167.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f50.google.com with SMTP id 2adb3069b0e04-51134755d9cso602614e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Feb 2024 23:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706858680; x=1707463480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FvWtHDZODSKY0IWZ9Z1fc5ZaZQuHu9ByW0K+Mdamz7g=;
        b=eCnUVXmHvUdzNTHVhAJe9cq6rRCPFlgrY6o1/bZ5Ub4q/485LMSaEvQpL26+RQkplD
         /2jxKM371hBhUrShvMjbMcAMd8mdoIeiRgzfT4yHW7Wj9vjePDvKSUOSIXCKvwYpdNEu
         btchrxvxRFotRJ42nzlUtDHofF17cBIlH8mfDWDYdjsYWDaFfJeWcmr+UJxUZWTrKooN
         IZyncxB9asiWZzu0jz02o8Us497qxyPEKm1xSegjYmULGGBTeEb1MxKHZ6uSOsMS0dYf
         h33xH0VIvYcVXtVU4IxACQwt0RS/ja6F33yH1r/CxxgnSHasxmN63/YEO4abC7uSOFau
         MMDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706858680; x=1707463480;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvWtHDZODSKY0IWZ9Z1fc5ZaZQuHu9ByW0K+Mdamz7g=;
        b=dg9TMz9Pw6Q15LXlhIricCFA4i9+SoP/KEfFaTBZMuS69L+ywGxH4rRxBbhK/wG8Mc
         voYfGjw3xeO7WWjttcbEGz1CJewOxfYConfN6z+JKyyx9Pwrpxs7c3XVnvSF+h0Yd5t5
         C3E7NPVchjW2/tEpQ9NJMil59DIkz/6wvOcLIGXHQXRe7CA+RfM9tsux+EN0qSpy5+CA
         603AkdsDv93dqDl0mljdi69XqGdCEedrkwzUnotAkiIAvEDWXZ/d5okxJ3NG3VAnkYZ8
         5tD7FmBZX3oJw7hw2c2DSLX+HBg1bmAAgHLsOae8W17s6nBYZWQM11UxicPPP50mVId3
         +n6A==
X-Gm-Message-State: AOJu0Yy7UK5sOeY2nS3zVZjgkP9eEpeFq+jwml2eulH9eyqx1I6MK8nh
	J4kLO/+Kki3UgeOHp0jmlF0aTiHZEllHKxTJuZwWtcxNWPy/jzW7Pm6CtG4Vw10=
X-Google-Smtp-Source: AGHT+IFdeLtEt4dVEu45mlqMDNUCo7biDQRP3f2ZPvP12HD1LdqSbmOVA87EfU4DgZPhPFb5/ewx9w==
X-Received: by 2002:a05:6512:48cd:b0:511:1e60:8157 with SMTP id er13-20020a05651248cd00b005111e608157mr707378lfb.10.1706858680395;
        Thu, 01 Feb 2024 23:24:40 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCUIqpwLM8bJ/ZGRcSIDgkeZafmfLtLkoOcA19xIzSHsvjPxYcHFC+HIaP5+xoiD5S1y4r8wmvozxHjn98757yI0+3Ztyk3JwDMhmK7eylB9Lnw0AHEOXMrMA3bi7jAz7TkQBFox0W5tpZqUMKjtVbHEhh65FyrvQJmjsOtj5SZxviu+a6TzVOa0WofgLd3wOY7J/7H0ZDr9pM/Md3gPLARjHA4ybrG8WOxilxao+RmZNyg3L6JQTAY=
Received: from [192.168.1.20] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id n13-20020a05600c3b8d00b0040eee852a3dsm6660620wms.10.2024.02.01.23.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 23:24:39 -0800 (PST)
Message-ID: <9a8819f1-5a28-4ecb-8094-89316366428f@linaro.org>
Date: Fri, 2 Feb 2024 08:24:38 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] memory: brcmstb_dpfe: introduce version-specific
 compatible strings
Content-Language: en-US
To: Markus Mayer <mmayer@broadcom.com>
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
 Device Tree Mailing List <devicetree@vger.kernel.org>,
 Linux Kernel <linux-kernel@vger.kernel.org>
References: <20240119215231.758844-1-mmayer@broadcom.com>
 <20240119215231.758844-5-mmayer@broadcom.com>
 <bc20da6e-bf97-415b-ba78-ae29311ae38f@linaro.org>
 <CAGt4E5uE1Ms8vJbw2tE7fgcxeE9=vPYsa8y2FsJtQt-7jrjE_Q@mail.gmail.com>
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
In-Reply-To: <CAGt4E5uE1Ms8vJbw2tE7fgcxeE9=vPYsa8y2FsJtQt-7jrjE_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 01/02/2024 23:40, Markus Mayer wrote:
> On Tue, 23 Jan 2024 at 13:28, Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
>>
>> On 19/01/2024 22:52, Markus Mayer wrote:
>>> Introduce compatible strings brcm,dpfe-cpu-v1 through brcm,dpfe-cpu-v3
>>> to the Broadcom DPFE driver.
>>
>> Nothing improved here. I think my last comment was pretty clear what I
>> expect.
> 
> You are correct. Nothing changed here. I did not get the impression
> that you were asking for changes to the actual driver code.

I think my concern was pretty obvious:
"No, why?"

Your commit msg is pointless. Says nothing. It says what you do, but it
is obvious and redundant. I see what you do from the patch diff.

What your commit msg is supposed to say, is explain why this is needed
and what problem are you solving.

This applies to all your commits, to all projects, downstream or
upstream. Repeating what the diff is doing is trivial and does not help
people to understand why this commit is there and what is the commit's
bigger impact.

So after I asked to provide rationale, you send exactly the same commit
without rationale.

And this is repeating in this entire patchset. Patch #1 only mentions
"no actual benefit", but it is discussible. It provides benefit in my
opinion and nothing in your commit msg gives arguments to support your
clause. Patch #2 does not need more explanations but it also does not
make sense in entire series - you want to drop the specific compatibles!
What's more patch #2 does not make any sense with combination of patch
#3 and it is not explained in the commit msg.

Patch #3 also brings zero explanations why you are doing it. From all
four patches, only one had some sort of explanation - patch #1.

Best regards,
Krzysztof


