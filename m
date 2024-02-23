Return-Path: <linux-kernel+bounces-79096-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C9CE2861D85
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 21:23:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EC9411C2401A
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Feb 2024 20:23:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65546148311;
	Fri, 23 Feb 2024 20:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kqtq+/yP"
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91E9C145B38;
	Fri, 23 Feb 2024 20:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708719716; cv=none; b=qykbTUC5AONgM5c8n5AH2XUm89lz6y319w444mN7GUp8Ja7aBPWiE1foNkWDuWe4b8Xb7/C8UT0YO1j8i45n7wJpX+/2wAl5ZxZyJEvW71YXzimTSGOlai/BD+EqLdru/1V3XjuRGlwZvr9PR20XCQybBTaFJkWJhadD1obXX+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708719716; c=relaxed/simple;
	bh=1YzjXm9btVp503L+Fxr6KekHdqM9vLvxbytGbEFSYvc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SKAfr5mRv729ntBqYq7+8Ey7iUv4ILgPv/LUjtVg6cFZRojwH+YA2VLnUR/OM1d8NXcryETKd9hQyLdtP6VisMVRsMLDnO0hnh/paXVl9aghejMFH5wHsWsaoUF2kHF6uYy/p5mFzYA4hgEZko0A38a2ei7KccVD0MHO9ecygaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kqtq+/yP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-6e34d12404eso562233b3a.2;
        Fri, 23 Feb 2024 12:21:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708719714; x=1709324514; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Li9I2Yt9RtfaQAU22rlxM67oiSTa36OTVFH39NacEkw=;
        b=kqtq+/yPe0uWhsaq+Q0Tq4aNPkaXTDwzVxF0hPKTQbHALFiDi9Zw+n4EJZI4ZESUrO
         1ntgUQmuOBxWtYkd8x1q33JhO5EjqtWsAT7AHn/ciWa/R5sf3Y68TLBAWLKTve9K0ObV
         Sk+4cbw7mwUqw+WICTEJH44ia30zgMcfQvCnRxL9Thy5sWVfOu++vZ9tIYH/ENITS+QT
         gfj+UFSPTULnDnpzd28dS15TOok0X/FE+sHFNq2Kot8MYc44ZILhxlOb11AtLcJkyUni
         J7s3vjHvJaJI01fc/0N8pFzgrOtsmdEu2+iKjizbMlto9R55KdjlfFBXxadUKFNMSDcF
         E+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708719714; x=1709324514;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Li9I2Yt9RtfaQAU22rlxM67oiSTa36OTVFH39NacEkw=;
        b=K5FSUJTNaJKhvlnRHgY+5WgEDPlOZX58nH6RFak67D8+oeT5siPt3c6QwRtS+md4qv
         v/Sv7/c0QuoHh3mFfw2rtD4RpWWr8DyD+4kDy6KByJPz6NB/NNoFG9InVnAhnrMsCVMq
         oYA44ON4nOvxXqsYHIXVGQOmgeUkqLI7xPl4LK0LzWJsMkcLJyBqtpZK3RJtlNAGiUp6
         Dd+pK2FqFJsEyVucMu8LjlagCSOd+nsYlO4kWbiu8StT5+R7ElWVGoNHNE+XKAg3zGYQ
         PHiPlcAZuNQhsASlbH0ig2SaZQaVchaSqpm4P34w2WJ6NvACDHLNWKTtXufjTKGlkJMh
         wFVQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoEo4z5Xy4QQ49rUOr8dvMt//xk2QQUqv8A0CeRMelQ5WPAAIgOOGqxxDzQZrS00JLp5ddO4/L73UjxdRuTeFG5zmq5TeK9T/nGAQnURQ=
X-Gm-Message-State: AOJu0YyjP03jTHsj8u0LIzrtmoMfY67dIQpPtU5WzKGEK/nXifLrQvq7
	+LyB9GIDPVnpeXHjCMlO5RQ7EvsPrTFnNBXnjOli75MCzMtHitAJdDVfrR9b
X-Google-Smtp-Source: AGHT+IEz4dEDbkqzb2rrSE7dBD5bDa7YwaKKmw2h7+JKSgg2dvk5i0aZPkJpPx7vUK4tHSza+XFKsg==
X-Received: by 2002:aa7:814e:0:b0:6e3:90c5:17ec with SMTP id d14-20020aa7814e000000b006e390c517ecmr845116pfn.18.1708719713763;
        Fri, 23 Feb 2024 12:21:53 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e15-20020aa7980f000000b006e4d336c420sm3094895pfl.69.2024.02.23.12.21.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Feb 2024 12:21:53 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <6b0373a2-7750-4d57-8839-95c6fa30c6b8@roeck-us.net>
Date: Fri, 23 Feb 2024 12:21:51 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] Watchdog: New module for ITE 5632 watchdog
Content-Language: en-US
To: Mark Pearson <mpearson@squebb.ca>, David Ober <dober6023@gmail.com>,
 wim@linux-watchdog.org
Cc: linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
 David Ober <dober@lenovo.com>
References: <20230721122931.505957-1-dober6023@gmail.com>
 <a361ce91-beba-43d8-b969-285063658da5@app.fastmail.com>
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
In-Reply-To: <a361ce91-beba-43d8-b969-285063658da5@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/23/24 11:58, Mark Pearson wrote:
> On Fri, Jul 21, 2023, at 8:29 AM, David Ober wrote:
>> This modules is to allow for the new ITE 5632 EC chip
>> to support the watchdog for initial use in the Lenovo SE10
>>
>> Signed-off-by: David Ober <dober6023@gmail.com>
>>
>> V2 Fix stop to deactivate wdog on unload of module
>> V2 Remove extra logging that is not needed
>> V2 change udelays to usleep_range
>> V2 Changed to now request region on start and release on stop instead
>>     of for every ping and read/write
>> V3 add counter to while loops so it will not hang
>> V3 rework code to use platform_device_register_simple
>> V3 rework getting the Chip ID to remove duplicate code and close IO
>> V3 change some extra logging to be debug only
>> ---
[ ... ]
>> +config ITE5632_WDT
>> +        tristate "ITE 5632"
>> +        select WATCHDOG_CORE
>> +        help
>> +          If you say yes here you get support for the watchdog
>> +          functionality of the ITE 5632 eSIO chip.
>> +
>> +          This driver can also be built as a module. If so, the module
>> +          will be called ite5632_wdt.
>> +

[ ... ]

>
> 
> Please let us know if there is anything else needed to get this accepted. Happy to address any feedback.
> 

I am sure I commented on this before. The fact that the Lenovo SE10 uses an
ITE 5632 controller is completely irrelevant. Lenovo could decide tomorrow to
replace the ITE chip with a Nuvoton chip, use the same API to talk with it,
and the watchdog would work perfectly fine.

This is a driver for the watchdog implemented in the embedded controller
on Lenovo SE10. It is not a watchdog driver for ITE5632. Again, the EC chip
used in that Lenovo system is completely irrelevant, even more so since
this seems to be one of those undocumented ITE chips which officially
don't even exist. Claiming that this would be a watchdog driver for ITE5632
would be not only misleading but simply wrong.

It seems that we can not agree on this. That means that, from my perspective,
there is no real path to move forward. Wim will have to decide if and how
to proceed.

Thanks,
Guenter


