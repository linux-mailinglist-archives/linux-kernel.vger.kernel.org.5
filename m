Return-Path: <linux-kernel+bounces-91462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CC1418711DA
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 01:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 824B5283D68
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Mar 2024 00:41:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D742F5A;
	Tue,  5 Mar 2024 00:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FFGcKNMF"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 616017F;
	Tue,  5 Mar 2024 00:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709599283; cv=none; b=Y9CSUiY52E4o0Klrg4euih1NOPb3E4r6JeCnrDqQCWGb3bP3m39Xl0wL4CPswhqCpaSVwqdY+Vje3p+mXxc9LxqiyN0F27x3dVskxvONsqIxrcULAfvacE6BmG71BHKJgBIGm6OfZR1eLK3+DLLeA1N0Wr4tJMlHZV1ICkOfCJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709599283; c=relaxed/simple;
	bh=WXdRcQvhAnLWB3iJ4utyupY0gEAWeqCVdVte5oq3lE4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=GSgV02hnnG6qhFk/aszbL8jJoISaxW1J3s823/14TdiHTPyMwDahGPvSO8PQLlMtAkgPzIz9iT4GCUB4Phuxqy60m97ToZnNBRPYNlXddpQ4MEZ1OAcIt1S8ZuEoYbRvBzxnl0FL/2z3KKzfXdtz/Orp3zWieSr6fgTmojEskCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FFGcKNMF; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e627596554so1079659b3a.2;
        Mon, 04 Mar 2024 16:41:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709599280; x=1710204080; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zz2xv6mhSKvLucKQu9RSMSCv3DxQAkBwArgViXGMUcw=;
        b=FFGcKNMFFRF0gPKwwlTZiBRrWkVXbMc51AlnbRbdorTIjC7JpxXCpJJJxRnrpi06e0
         xYCKH2dvqzdATDiNFhsfueBDMNMkEdmKUxWigb0cPVMIWzpD2KuBoGEyOS0LkAft+YmZ
         5Wg6PgZAuZ//q7PGlgjaQrqacUjAekedgUddv0D+FqT0v39ahqOwHjXWhMQTHjPmoXN/
         KMUnkfc2hcsvgRGa0hq1tzClCaz5ecrpSE9QFLSF/JwmxfCfWi44b2jTSIpMICWB78VK
         BvxjtQBT3ZtP5gzTtwXmmUVXjfKNohVCX/hTzbLBlDNVbI+uYC+IUJRnmQBs66kE2Kg3
         bBDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709599280; x=1710204080;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zz2xv6mhSKvLucKQu9RSMSCv3DxQAkBwArgViXGMUcw=;
        b=HZBOrMope4+gN9SIRt7UQSeaZsHBLU3jZDs03RT1F4YaLfNfRkyD3CPkz4PFQ8N/TE
         b7j96qwuAvsVaVtaVXA4FMZxXn1XcMELEcudsMCZZwRnxi2qwMVGO/llAhTMbKoRj/ua
         FdRHguHZWdv47vAbwa/jBPG+HeB+Jg6mr0wpY48aUFZyKdHZIwKNS2yvS2H925NcrdRK
         WxMtJiU88yikkK2NRucVtzbM3yZGHH1o+wo8kTyZl1VzXR7+0Cw5M7mgGmkt2kcAFwJz
         m5HQa0S2OAX9P8zl3bPdgmdEDqH1SUujSrKN+X7lNDiEFW4LEa0RkxCMqVv2tOnUv1Hw
         DXSw==
X-Forwarded-Encrypted: i=1; AJvYcCVbi8Ol1zgXDEBcuya7UJTvGDdytkF7K5Bz14t0ejwSnfaNh7bBTPjkWqZC9jMnANcXJ+DNou8vQNPYcEMLvjuVVVewLmwiQBdR7VHMfv+LqG75/iYhorPODzZO9ffNpqMo+dwdTZ2JUzBadobznb1PH0U7ApyePAkSDOg5hdfrs9R646f24urhg2ndxIl9yHyLw+mcTSLNsdoiedYIp/da
X-Gm-Message-State: AOJu0YxqqIWHpGrB2uRnvOInHtXiYY4LXkVtaxU8X89wLq0eWvablifA
	ZO63/W8IK9tytcGpk25hhkP+Tf27mML7By2vY9CbFlXFysESbWbM
X-Google-Smtp-Source: AGHT+IG4AdbCCCco/zN8tNbaJ8l2nbv2xT0FoPaYC9RpV4qR8zcTHmfybDccbl+2SCcjL3Y414ONhQ==
X-Received: by 2002:a05:6a20:1447:b0:1a1:4f7c:2f6a with SMTP id a7-20020a056a20144700b001a14f7c2f6amr338400pzi.19.1709599280443;
        Mon, 04 Mar 2024 16:41:20 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id gk4-20020a17090b118400b0029b5f69830dsm587825pjb.22.2024.03.04.16.41.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Mar 2024 16:41:19 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e590e3ba-f446-4f20-9618-d4ff388586ad@roeck-us.net>
Date: Mon, 4 Mar 2024 16:41:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Content-Language: en-US
To: Zev Weiss <zev@bewilderbeest.net>, baneric926@gmail.com
Cc: jdelvare@suse.com, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
 conor+dt@kernel.org, corbet@lwn.net, linux-hwmon@vger.kernel.org,
 devicetree@vger.kernel.org, kcfeng0@nuvoton.com, kwliu@nuvoton.com,
 openbmc@lists.ozlabs.org, linux-doc@vger.kernel.org,
 linux-kernel@vger.kernel.org, DELPHINE_CHIU@wiwynn.com,
 naresh.solanki@9elements.com, billy_tsai@aspeedtech.com,
 Rob Herring <robh@kernel.org>
References: <20240227005606.1107203-1-kcfeng0@nuvoton.com>
 <20240227005606.1107203-2-kcfeng0@nuvoton.com>
 <1cf69d3e-a8b4-49f6-ac4d-550b525e45e2@hatter.bewilderbeest.net>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 xsFNBE6H1WcBEACu6jIcw5kZ5dGeJ7E7B2uweQR/4FGxH10/H1O1+ApmcQ9i87XdZQiB9cpN
 RYHA7RCEK2dh6dDccykQk3bC90xXMPg+O3R+C/SkwcnUak1UZaeK/SwQbq/t0tkMzYDRxfJ7
 nyFiKxUehbNF3r9qlJgPqONwX5vJy4/GvDHdddSCxV41P/ejsZ8PykxyJs98UWhF54tGRWFl
 7i1xvaDB9lN5WTLRKSO7wICuLiSz5WZHXMkyF4d+/O5ll7yz/o/JxK5vO/sduYDIlFTvBZDh
 gzaEtNf5tQjsjG4io8E0Yq0ViobLkS2RTNZT8ICq/Jmvl0SpbHRvYwa2DhNsK0YjHFQBB0FX
 IdhdUEzNefcNcYvqigJpdICoP2e4yJSyflHFO4dr0OrdnGLe1Zi/8Xo/2+M1dSSEt196rXaC
 kwu2KgIgmkRBb3cp2vIBBIIowU8W3qC1+w+RdMUrZxKGWJ3juwcgveJlzMpMZNyM1jobSXZ0
 VHGMNJ3MwXlrEFPXaYJgibcg6brM6wGfX/LBvc/haWw4yO24lT5eitm4UBdIy9pKkKmHHh7s
 jfZJkB5fWKVdoCv/omy6UyH6ykLOPFugl+hVL2Prf8xrXuZe1CMS7ID9Lc8FaL1ROIN/W8Vk
 BIsJMaWOhks//7d92Uf3EArDlDShwR2+D+AMon8NULuLBHiEUQARAQABzTJHdWVudGVyIFJv
 ZWNrIChMaW51eCBhY2NvdW50KSA8bGludXhAcm9lY2stdXMubmV0PsLBgQQTAQIAKwIbAwYL
 CQgHAwIGFQgCCQoLBBYCAwECHgECF4ACGQEFAlVcphcFCRmg06EACgkQyx8mb86fmYFg0RAA
 nzXJzuPkLJaOmSIzPAqqnutACchT/meCOgMEpS5oLf6xn5ySZkl23OxuhpMZTVX+49c9pvBx
 hpvl5bCWFu5qC1jC2eWRYU+aZZE4sxMaAGeWenQJsiG9lP8wkfCJP3ockNu0ZXXAXwIbY1O1
 c+l11zQkZw89zNgWgKobKzrDMBFOYtAh0pAInZ9TSn7oA4Ctejouo5wUugmk8MrDtUVXmEA9
 7f9fgKYSwl/H7dfKKsS1bDOpyJlqhEAH94BHJdK/b1tzwJCFAXFhMlmlbYEk8kWjcxQgDWMu
 GAthQzSuAyhqyZwFcOlMCNbAcTSQawSo3B9yM9mHJne5RrAbVz4TWLnEaX8gA5xK3uCNCeyI
 sqYuzA4OzcMwnnTASvzsGZoYHTFP3DQwf2nzxD6yBGCfwNGIYfS0i8YN8XcBgEcDFMWpOQhT
 Pu3HeztMnF3HXrc0t7e5rDW9zCh3k2PA6D2NV4fews9KDFhLlTfCVzf0PS1dRVVWM+4jVl6l
 HRIAgWp+2/f8dx5vPc4Ycp4IsZN0l1h9uT7qm1KTwz+sSl1zOqKD/BpfGNZfLRRxrXthvvY8
 BltcuZ4+PGFTcRkMytUbMDFMF9Cjd2W9dXD35PEtvj8wnEyzIos8bbgtLrGTv/SYhmPpahJA
 l8hPhYvmAvpOmusUUyB30StsHIU2LLccUPPOwU0ETofVZwEQALlLbQeBDTDbwQYrj0gbx3bq
 7kpKABxN2MqeuqGr02DpS9883d/t7ontxasXoEz2GTioevvRmllJlPQERVxM8gQoNg22twF7
 pB/zsrIjxkE9heE4wYfN1AyzT+AxgYN6f8hVQ7Nrc9XgZZe+8IkuW/Nf64KzNJXnSH4u6nJM
 J2+Dt274YoFcXR1nG76Q259mKwzbCukKbd6piL+VsT/qBrLhZe9Ivbjq5WMdkQKnP7gYKCAi
 pNVJC4enWfivZsYupMd9qn7Uv/oCZDYoBTdMSBUblaLMwlcjnPpOYK5rfHvC4opxl+P/Vzyz
 6WC2TLkPtKvYvXmdsI6rnEI4Uucg0Au/Ulg7aqqKhzGPIbVaL+U0Wk82nz6hz+WP2ggTrY1w
 ZlPlRt8WM9w6WfLf2j+PuGklj37m+KvaOEfLsF1v464dSpy1tQVHhhp8LFTxh/6RWkRIR2uF
 I4v3Xu/k5D0LhaZHpQ4C+xKsQxpTGuYh2tnRaRL14YMW1dlI3HfeB2gj7Yc8XdHh9vkpPyuT
 nY/ZsFbnvBtiw7GchKKri2gDhRb2QNNDyBnQn5mRFw7CyuFclAksOdV/sdpQnYlYcRQWOUGY
 HhQ5eqTRZjm9z+qQe/T0HQpmiPTqQcIaG/edgKVTUjITfA7AJMKLQHgp04Vylb+G6jocnQQX
 JqvvP09whbqrABEBAAHCwWUEGAECAA8CGwwFAlVcpi8FCRmg08MACgkQyx8mb86fmYHNRQ/+
 J0OZsBYP4leJvQF8lx9zif+v4ZY/6C9tTcUv/KNAE5leyrD4IKbnV4PnbrVhjq861it/zRQW
 cFpWQszZyWRwNPWUUz7ejmm9lAwPbr8xWT4qMSA43VKQ7ZCeTQJ4TC8kjqtcbw41SjkjrcTG
 wF52zFO4bOWyovVAPncvV9eGA/vtnd3xEZXQiSt91kBSqK28yjxAqK/c3G6i7IX2rg6pzgqh
 hiH3/1qM2M/LSuqAv0Rwrt/k+pZXE+B4Ud42hwmMr0TfhNxG+X7YKvjKC+SjPjqp0CaztQ0H
 nsDLSLElVROxCd9m8CAUuHplgmR3seYCOrT4jriMFBtKNPtj2EE4DNV4s7k0Zy+6iRQ8G8ng
 QjsSqYJx8iAR8JRB7Gm2rQOMv8lSRdjva++GT0VLXtHULdlzg8VjDnFZ3lfz5PWEOeIMk7Rj
 trjv82EZtrhLuLjHRCaG50OOm0hwPSk1J64R8O3HjSLdertmw7eyAYOo4RuWJguYMg5DRnBk
 WkRwrSuCn7UG+qVWZeKEsFKFOkynOs3pVbcbq1pxbhk3TRWCGRU5JolI4ohy/7JV1TVbjiDI
 HP/aVnm6NC8of26P40Pg8EdAhajZnHHjA7FrJXsy3cyIGqvg9os4rNkUWmrCfLLsZDHD8FnU
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <1cf69d3e-a8b4-49f6-ac4d-550b525e45e2@hatter.bewilderbeest.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/4/24 16:22, Zev Weiss wrote:
> On Mon, Feb 26, 2024 at 04:56:04PM PST, baneric926@gmail.com wrote:
>> From: Naresh Solanki <naresh.solanki@9elements.com>
>>
>> Add common fan properties bindings to a schema.
>>
>> Bindings for fan controllers can reference the common schema for the
>> fan
>>
>> child nodes:
>>
>>  patternProperties:
>>    "^fan@[0-2]":
>>      type: object
>>      $ref: fan-common.yaml#
>>      unevaluatedProperties: false
>>
>> Reviewed-by: Rob Herring <robh@kernel.org>
>> Signed-off-by: Naresh Solanki <naresh.solanki@9elements.com>
>> Signed-off-by: Billy Tsai <billy_tsai@aspeedtech.com>
>> Signed-off-by: Ban Feng <kcfeng0@nuvoton.com>
>> ---
>> .../devicetree/bindings/hwmon/fan-common.yaml | 78 +++++++++++++++++++
>> 1 file changed, 78 insertions(+)
>> create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
>>
>> diff --git a/Documentation/devicetree/bindings/hwmon/fan-common.yaml b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
>> new file mode 100644
>> index 000000000000..15c591c74545
>> --- /dev/null
>> +++ b/Documentation/devicetree/bindings/hwmon/fan-common.yaml
>> @@ -0,0 +1,78 @@
>> +# SPDX-License-Identifier: GPL-2.0-only OR BSD-2-Clause
>> +%YAML 1.2
>> +---
>> +$id: http://devicetree.org/schemas/hwmon/fan-common.yaml#
>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>> +
>> +title: Common Fan Properties
>> +
>> +maintainers:
>> +  - Naresh Solanki <naresh.solanki@9elements.com>
>> +  - Billy Tsai <billy_tsai@aspeedtech.com>
>> +
>> +properties:
>> +  max-rpm:
>> +    description:
>> +      Max RPM supported by fan.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    maximum: 100000
>> +
>> +  min-rpm:
>> +    description:
>> +      Min RPM supported by fan.
>> +    $ref: /schemas/types.yaml#/definitions/uint32
>> +    maximum: 1000
> 
> I can't say with certainty that it's not, but are we sure 1000 is low enough?  Looking at just what I've got on hand, an 80mm fan I have will run steadily at about 1500RPM, and I'd assume larger ones (e.g. 120mm) could potentially go significantly lower...
> 

I have seen fans which run stable at < 400rpm.
One of my systems right now has:

fan1:              732 RPM  (min =    0 RPM)
fan2:                0 RPM  (min =    0 RPM)
fan3:              586 RPM  (min =    0 RPM)
fan4:              472 RPM  (min =    0 RPM)
fan5:              480 RPM  (min =    0 RPM)

Those are 80mm fans. A quick check shows that various Noctua fans have a
minimum speed of 300 rpm. So 1000 is indeed a bit high for the minimum speed.

Guenter


