Return-Path: <linux-kernel+bounces-103328-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9660887BE27
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 14:57:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5C53B21B02
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Mar 2024 13:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32F466EB74;
	Thu, 14 Mar 2024 13:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QY6jPgIh"
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9102A6FBB8
	for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 13:56:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710424619; cv=none; b=gk3lBnagVDKXtD7Q19so16exyBG+lZSjd2U/sUbKsk26sRz94W9JLaVGqpvpFnheMfYsjlfMMI5NXPk3x6P8ehtMyn+KYAJDuY9V3THCsTj4CrX8vcwDUaKI0xsxWuZ68SJy7R/ZJuapu74V39QDp2S8JcRtHxXhIcRV2fJAx8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710424619; c=relaxed/simple;
	bh=97IREz6AQGN+Adg5OvgCHvuY7w7GBw1iUsPVAKP1GHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oI4R0vfVWwrmL7HgAbHWGcD87iJMgAD92vBhQiJ8IadROFKmPFmkBn8Vtjmz6gTLpR2tynbmqTT7Sw+Yk3eydqHZLWsDcp8kGTwUNS1hZd52kU0ckuayv2VzWDtUMRZH6ZnrQV2yTZvCH2mfjYVrTuy5mHENh7U/H7pkqLYdaSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QY6jPgIh; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-568a5e15ae8so406766a12.0
        for <linux-kernel@vger.kernel.org>; Thu, 14 Mar 2024 06:56:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710424616; x=1711029416; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=wU+5zjNt2rmyof5Fvve875MtX+yDLSiVmTgw1JG0my8=;
        b=QY6jPgIhY61D8feI2pHG+yrGZKV2PceAuZDLigNqCtg+NkdRP2vBQLCRU7oTnxz8nT
         xADUPRlX6Y9wiRwxjZl97IwSUUe+hnoGCUCU80GHYrVA1rEQDL6F8axkxBuQH6xN+tkL
         gc2mD8Vps5a1RtnSfuQHUGlXBddUNAQdLtJ+98uGQJXzJou/4FDmBd0G3K+msc3IiR4/
         3A2DV/GO4yIpZUMnflQRQeRIcC6L1SN8EcxXxf+/Bd0Gcp9IehAJmsIIQ5vRvES0+Alu
         UJHpmNw9LEfpz0cEsVb4PnSe0n6vQKeae7Ww5OjQ5I/uP+bCv4kHoE8vf1DHrkmwJF/v
         I78Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710424616; x=1711029416;
        h=content-transfer-encoding:in-reply-to:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wU+5zjNt2rmyof5Fvve875MtX+yDLSiVmTgw1JG0my8=;
        b=q5mEGBhtXninNbTyZcU0NcpcONmuNcNSMa6TdZOmTfMtKs7fu4c2G3MgeSywkhh+fW
         xLRL/hPu2a9VkNjkuPALTmBx/fKANHqYiEL++BliBQ7Fy9zgxyDhtMHHJBu1GFIyZDoE
         3RYNrj7x1NY18sFQAvAp9C/il+Zxr7Wc9Ljyic4GDr3L40rDM0rkI5XZ3XlnwJNh07o+
         qOkPbUVTEN9MIiBPFio/BxpFM1AT7K2cOnaPYjDaAX8EqnNb0oJwCB6Q8V4I/+go/mCN
         h6AHmEIYPmK6nCggeODNP5YJ0rGu1hCJd+UfWQsrQWZla82JsXZ1pbN6Q6eN7C9kHuvM
         mR7A==
X-Forwarded-Encrypted: i=1; AJvYcCUu/DhPna959edWy0QUl0QHggTX5ukKRN68hLrY0AD4XV9ZQEUJGzvVyaos45Pbebk7QNRupfNqtLfkpXd9W8Er7+3bflauCBymX/Xf
X-Gm-Message-State: AOJu0YyXaDozTPjnYxKtQkrd/2dWUNY+zjOeKZ62G24lctj+C3nqxG7j
	tvUBXkP3fpEhMxVytko/zImfhF/XcLorojC2zMA5iUMFKX4j0hFNzUaTw0O1FG4=
X-Google-Smtp-Source: AGHT+IHJsw3asGO8YcwJxILcUjEQAitA3AUUKQG9r9DJuoKvr3OvYWZgJFk1jM+xs57zU/LvoQ7gdQ==
X-Received: by 2002:a05:6402:e10:b0:568:949b:e91f with SMTP id h16-20020a0564020e1000b00568949be91fmr1283422edh.36.1710424615889;
        Thu, 14 Mar 2024 06:56:55 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.222.97])
        by smtp.gmail.com with ESMTPSA id s15-20020a056402014f00b005664afd1185sm748738edu.17.2024.03.14.06.56.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Mar 2024 06:56:55 -0700 (PDT)
Message-ID: <d3b7fd09-76ef-42b3-aaf9-de0369a28e03@linaro.org>
Date: Thu, 14 Mar 2024 14:56:53 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] dt-bindings: remoteproc: Add Arm remoteproc
To: Abdellatif El Khlifi <abdellatif.elkhlifi@arm.com>,
 Robin Murphy <robin.murphy@arm.com>
Cc: Bjorn Andersson <andersson@kernel.org>,
 Mathieu Poirier <mathieu.poirier@linaro.org>,
 Rob Herring <robh+dt@kernel.org>, Liviu Dudau <liviu.dudau@arm.com>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
 Conor Dooley <conor+dt@kernel.org>, Drew.Reed@arm.com,
 Adam.Johnston@arm.com, linux-arm-kernel@lists.infradead.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-remoteproc@vger.kernel.org
References: <20240301164227.339208-1-abdellatif.elkhlifi@arm.com>
 <20240301164227.339208-4-abdellatif.elkhlifi@arm.com>
 <8c784016-9257-4d8a-b956-a0a406746c76@arm.com>
 <20240314134928.GA27077@e130802.arm.com>
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
In-Reply-To: <20240314134928.GA27077@e130802.arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 14/03/2024 14:49, Abdellatif El Khlifi wrote:
>> Frankly at the moment I'd be inclined to say it isn't even a remoteproc
>> binding (or driver) at all, it's a reset controller. Bindings are a contract
>> for describing the hardware, not the current state of Linux driver support -
>> if this thing still needs mailboxes, shared memory, a reset vector register,
>> or whatever else to actually be useful, those should be in the binding from
>> day 1 so that a) people can write and deploy correct DTs now, such that
>> functionality becomes available on their systems as soon as driver support
>> catches up, and b) the community has any hope of being able to review
>> whether the binding is appropriately designed and specified for the purpose
>> it intends to serve.
> 
> This is an initial patchset for allowing to turn on and off the remote processor.
> The FW is already loaded before the Corstone-1000 SoC is powered on and this
> is done through the FPGA board bootloader in case of the FPGA target.
> Or by the Corstone-1000 FVP model (emulator).
> 
> The plan for the driver is as follows:
> 
>     Step 1: provide a foundation driver capable of turning the core on/off
>     Step 2: provide mailbox support for comms
>     Step 3: provide FW reload capability
> 
> Steps 2 & 3 are waiting for a HW update so the Cortex-A35 (running Linux) can
> share memory with the remote core.
> 
> So, when memory sharing becomes available in the FPGA and FVP the
> DT binding will be upgraded with:
> 
>     - mboxes property specifying the RX/TX mailboxes (based on MHU v2)
>     - memory-region property describing the virtio vrings
> 
> Currently the mailbox controller does exist in the HW but is not
> usable via virtio (no memory sharing available).
> 
> Do you recommend I add the mboxes property even currently we can't do the comms ?

Bindings should be complete, regardless whether Linux driver supports it
or not. Please see writing bindings document for explanation on this and
other rules.

So yes: please describe as much as possible/reasonable.


Best regards,
Krzysztof


