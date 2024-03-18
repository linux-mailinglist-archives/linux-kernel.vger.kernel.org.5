Return-Path: <linux-kernel+bounces-106533-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8AA87EFFF
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 19:55:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 11556B211B3
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 18:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC7BD55C1E;
	Mon, 18 Mar 2024 18:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RU5HYDJA"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B906381C8;
	Mon, 18 Mar 2024 18:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710788134; cv=none; b=aPWDd14Ga7/hgi3DFuFDIu0aWmtYQ9EJ/YH19WHqaUJ9PFBPUHHhP7XKsGnOz7CNyZVfrnWetTpsYmO25cZzO+NHq/t4fIh5wZspOfUrhYDz8tj+G5BpRl9Fd1RyAQFeRup6ijSbmIKJau1hs7lp6v25TmyTScfFXjZ6YXhYNGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710788134; c=relaxed/simple;
	bh=8CeVOAWTzJXaXVDdynIC1lemvdgogAf3GoI6f1Fv7gk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=R8n+4u3N61LHkkijNICloCDyVbherE5uNlQDaoL4Fq2iYMqhVcLwAelYMVVxVgIoB4ne0sDm0kbVXLLAWEVEhSZC1FwGiqfWMggTi6ukc4bAbC3PUIi0KIg14aB42tYpLjejT9n8CKLNQtvFcupXixOcJYdYGMnJaXVq/XuhANI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RU5HYDJA; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-5a1aa46c975so1506144eaf.3;
        Mon, 18 Mar 2024 11:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710788130; x=1711392930; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=BaMOsD/NbGTbHJ6PeZOa+txaanGtHXW11Pvaw2MUUo8=;
        b=RU5HYDJAAe7X25BRTZdPAamijp0uOTpfOG/swWPGfM2ry5iGiRjpPWQQc9TLEewzHr
         A+ui2k8MQ3BGk2A/IGOBBglL16bvP45SexaManJ9vJjrxZv6+0CrIqaNp9LYzvWxS7WZ
         zpNqLiA+ql9n/kIw4UyzvgUung0gPMx4gumeYQY23mfMMHqg0F5yD2Eb1LwxjJlzdz3u
         lfbc4IksHpbmPvSLUa3+vbn6NVqgWIggxeroWuzBKBCERkOsReZfFeOmuaFLgCFYjp/f
         yPKgPbd0yyhi17RH9cXAvgLYETW2cnZ6WjsFvyroKhR042xCQ8ySkMpykWusHkUECv8t
         yjDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710788130; x=1711392930;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BaMOsD/NbGTbHJ6PeZOa+txaanGtHXW11Pvaw2MUUo8=;
        b=efkx2uNzVecH8rgsCv2ly+Rbw99B+dKQwhMANWITscU4DmCDHAckZM9AbpH66N6xvl
         uYsT0JeBEdvETlQv8rJ5wVDJcYZhpGikRs5CDdkshRK4sraWZcsglNqNDi6HLrf87Xf3
         IVUO6utt7YRur1iJ4Vf8TpLK1vFzChhbhYjhPWAvHzzw/ECZTnLBPPT49aDfXKuNY+km
         +v4xTv8h196NQlM3Mr5Cll0YmHLmbKv8ZhyFGX4GEkR0sST3xCZQbIQ8rMvPzDza7o/3
         6j5zlX+M9agNrxIxfBA6AZmDVBvQAdao2t2vdaGBPuZZ0kan1UHqRSMvqrvvYbm8k58m
         Wu1A==
X-Forwarded-Encrypted: i=1; AJvYcCWQf+OhVJsAw8wRrY7jp5ZBJRZ0qb0Qz6VUD3Ml9e9Mlu1wOLSjRz59TNDEL1xz0RNfWx3Udy2HVhQdtchHfiKxZeRiA/BeHVYI4cEyn1rBg+KP52alOfdFONfySszpHVxDSUyTEOc=
X-Gm-Message-State: AOJu0YzbL+jw2FiZajV8pNjn3kXyFSgl+Id2VjMIjOdGhCaPXvSMC864
	0wHYJD/Azy/0x6I9vjyhEuWklQvAxXkmdQ7wQRSDlItsz11Ln7vxqemKlO7k
X-Google-Smtp-Source: AGHT+IFGVsQW1mxjNiqE50SQNCnzka6grzdsqh/P1xRzdXVngYaKwklZx18mXAyDONS2j8go9CSt1Q==
X-Received: by 2002:a05:6358:7f02:b0:17b:c797:8a08 with SMTP id p2-20020a0563587f0200b0017bc7978a08mr15486928rwn.20.1710788130389;
        Mon, 18 Mar 2024 11:55:30 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id a26-20020a62e21a000000b006e6ae26625asm8181976pfi.68.2024.03.18.11.55.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 11:55:29 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <09445559-9dcd-4512-a8cb-5476639b1774@roeck-us.net>
Date: Mon, 18 Mar 2024 11:55:28 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hwmon: lm70: fix links in doc and comments
Content-Language: en-US
To: Kousik Sanagavarapu <five231003@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org,
 linux-hwmon@vger.kernel.org, Mark Brown <broonie@kernel.org>,
 Jean Delvare <jdelvare@suse.com>, Shuah Khan <skhan@linuxfoundation.org>,
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
References: <20240318130840.74589-1-five231003@gmail.com>
 <20240318154540.90613-1-five231003@gmail.com>
 <20240318154540.90613-3-five231003@gmail.com>
 <6c8b2699-5488-4ae0-8d78-59bcb2030a2e@roeck-us.net>
 <ZfiII_4xMnemzWqi@five231003>
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
In-Reply-To: <ZfiII_4xMnemzWqi@five231003>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/24 11:29, Kousik Sanagavarapu wrote:
> On Mon, Mar 18, 2024 at 11:11:29AM -0700, Guenter Roeck wrote:
>> On Mon, Mar 18, 2024 at 09:08:35PM +0530, Kousik Sanagavarapu wrote:
>>> Update links in the documentation and in-code comments which point to
>>> the datasheet.
>>>
>>> The current links don't work because National Semiconductor (which is
>>> the manufacturer of this board and lm70) has been a part of Texas
>>                        ^^^^^^^^^^
>>
>> Is this a leftover from the other patch ? The lm70 driver supports
>> the LM70 chip, not a specific board.
> 
> Yeah, it should be "the manufacturer of lm70".  Thanks for spotting.
> 
> Should I fix and resend this specific patch as v3 or would you edit it
> while pulling?
> 

I'll edit it.

Thanks,
Guenter


