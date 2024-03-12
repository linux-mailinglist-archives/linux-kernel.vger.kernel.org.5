Return-Path: <linux-kernel+bounces-100235-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E843E8793D7
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 13:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9D0B1283C71
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Mar 2024 12:10:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8925E79DCA;
	Tue, 12 Mar 2024 12:10:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C+hKml1X"
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FD6D79DBB
	for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 12:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710245447; cv=none; b=PZ6NumrzlgmrBkEnPfR44cGmXeVC2rN9RBP0YSN3IfLFD8dr7D8JiKug8Gp9qpdZDJQF75/ZgSIwGJqLXASVUTD9Czg4RZN+QiFLG1uH6C6sLJieD07bHaSBgD73yzlSvMNoGocADoTTQPHMD0DMpG8suulg8taA01+EPDdiCVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710245447; c=relaxed/simple;
	bh=PyBGji7l7FI7brDGl4t7hJ1vrfvni7rDqwS5suVvrs4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NdnqD9IPGuMiQuS9r+QIm8GmwjbKIFtBLsmWjM39UUyg3uguOurcdrHtt2pcKcCjDfSo6YgkazMzNwE26BrlUqSVbsQjWHcRS88m3G8BHGqqkY2bYJ6VJymJcaDd2+MPYdXlCMH/td3zAty5XC/JWiht3V7LC2sz1HZSOpBCfTE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=C+hKml1X; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4132f780ee2so9337895e9.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Mar 2024 05:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710245444; x=1710850244; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8rYihkVs9Zh9xGQ3HTA59y2k+odcsTvCnrT1AkFjmbA=;
        b=C+hKml1Xy1rsiaMuFXmkoP5hmGLH1BaglR/2AHJB7cxOoSXtrcrwJlI1WwkP5e7HKU
         TkV+hrqs+ofWiyrWhLTQHuxzNKtbQaHmQhcrEZ1UlLpkYVPJx7RjG3cTqpLS8Sqfv/pq
         9h4zq8Xwe4V3i9OTK5Mt3U1TEjRqdKKWJuqQyvj6uSOo5X0LMuuwx3cyuhvGEFwIGdx9
         extRlnyaGEI91YyLt17ot8ESO4G0BEyuZ4tMY4Ocy1OSvG7N8HqpE/dBVwE7tsJSPNW6
         ST3fZz2A8Uo38Nd0wr963XCkzYsh6YCRGvIl0wYMuv9cqSy23CmVSH1DfBcqzaYBg71l
         b7wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710245444; x=1710850244;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rYihkVs9Zh9xGQ3HTA59y2k+odcsTvCnrT1AkFjmbA=;
        b=bQNjPz1JcprHQnPbkmURJLmo8M2Uqp/9n0HDk8cRK0YU89THZVeJwba/ijQ1K4V1PP
         bCOe6SI2jbpZLgfNCRqNQVFhNsZ8bm+TgYqECtOx9Fn2wgNS+Ocwcd2mkOJiFJtwCeXA
         1o/oKuCCKXT7vajF5rxjAc+OI50ZzdSmYgPTybLw/n/nPIl2iUsOsFXSlHsDdgHvT4pB
         rtxig3SBUTsiuwNnlCMerhBxOmLPGczw0Att0m8obrl56XwrcJqaP0BgpH0RXG7WjERY
         eGENTodFVDF68/1ejMuSb/Z9C9NGV1wuDTIXlh4fFp11adhizs+YwRXy+6XH/9yONfjo
         9EOA==
X-Forwarded-Encrypted: i=1; AJvYcCUemFlrffKpFeLDWGlKJT77RJQ5It+jCgu9l3h1v6GNyAGmD31kYij5EfkW2KzeKvz6UeBJa2DI9NnEtVvZ+vzoYlEDiV099o+CSX1T
X-Gm-Message-State: AOJu0Yxmhj1WCXPmM1NX5T8YWZbMtuE9rPpxy6xrchuQq1DKuk8MmvR6
	CTFVJKICgoaYrNbDgVQ1kTPfX4R+ixC00rhOVgSn1jVsCRlM+UruS7t9tCOEGx0=
X-Google-Smtp-Source: AGHT+IHv496nHXyZhpEXIQR50uU5RPKd7kp+yl+ngA0rkiqjzciedtEC6obZ7CvBVhtshMovRX0y/g==
X-Received: by 2002:a05:600c:3514:b0:413:28ae:ebcb with SMTP id h20-20020a05600c351400b0041328aeebcbmr6301353wmq.3.1710245444558;
        Tue, 12 Mar 2024 05:10:44 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id u15-20020a05600c138f00b00412706c3ddasm18794203wmf.18.2024.03.12.05.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Mar 2024 05:10:44 -0700 (PDT)
Message-ID: <cc06e895-e0f5-40da-8c29-0e4bf62bcacf@linaro.org>
Date: Tue, 12 Mar 2024 13:10:43 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 2/4] dt-bindings: remoteproc: add Tightly Coupled
 Memory (TCM) bindings
Content-Language: en-US
To: Tanmay Shah <tanmay.shah@amd.com>, andersson@kernel.org,
 mathieu.poirier@linaro.org, robh+dt@kernel.org,
 krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 michal.simek@amd.com, ben.levinsky@amd.com
Cc: linux-remoteproc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
References: <20240301181638.814215-1-tanmay.shah@amd.com>
 <20240301181638.814215-3-tanmay.shah@amd.com>
 <fb78bdda-2ec7-4fcc-888e-233905a9386c@linaro.org>
 <17d58a39-7d56-4513-8d5f-7c18809c6cfb@amd.com>
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
In-Reply-To: <17d58a39-7d56-4513-8d5f-7c18809c6cfb@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 11/03/2024 19:39, Tanmay Shah wrote:
>>> +
>>> +    else:
>>> +      patternProperties:
>>> +        "^r5f@[0-9a-f]+$":
>>> +          type: object
>>> +
>>> +          properties:
>>> +            reg:
>>> +              minItems: 1
>>> +              items:
>>> +                - description: ATCM internal memory
>>> +                - description: BTCM internal memory
>>> +
>>> +            reg-names:
>>> +              minItems: 1
>>> +              items:
>>> +                - const: atcm0
>>> +                - const: btcm0
>>> +
>>> +            power-domains:
>>> +              maxItems: 3
>>
>> Please list power domains.
> 
> Hello,
> 
> Sent v13 addressing both comments.
> 

And gave me exactly two hours to disagree?

Best regards,
Krzysztof


