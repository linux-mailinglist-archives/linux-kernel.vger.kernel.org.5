Return-Path: <linux-kernel+bounces-70011-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D4538591B3
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 19:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 097A72827C5
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 18:25:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8257E0FC;
	Sat, 17 Feb 2024 18:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7oYL8QK"
Received: from mail-oo1-f51.google.com (mail-oo1-f51.google.com [209.85.161.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCBD18020;
	Sat, 17 Feb 2024 18:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708194295; cv=none; b=ads6MVebHcnjB3F1gHhKgyJ6KToIrKPiT8ryBvA0wSwvXN95v5fHhF6V8LeydC8S6W5muQSgUNuRY9u0nXTU4Y6X7wAIeF9z8qnCTE06MbwEOBq6ihZLzFVQXx/U+eZ8STxUOxmRMFmUkD1mJg5452BTDBmyT+ufwhHf2kY3DcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708194295; c=relaxed/simple;
	bh=a5WT5IeOuUFaQli0pcNNQu3rMzv2/AxArXbYGvAi414=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=S6NJCQwKkUPdqxX0YtndgTE8XC0WHtuGqYCBdQZWYs/NlxO+7DVYFsC333cUUnViPxDglDZpPyY0ajGwEY8BGM4SjxAAY2V9ue95qQLpfksI2f6BhBvF0ofpNoKGcBgYOGaK8nAE8T9RPQ1vBF0CEh/akL3hXJnRxiD480bwT7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W7oYL8QK; arc=none smtp.client-ip=209.85.161.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f51.google.com with SMTP id 006d021491bc7-59a8b9b327aso1053878eaf.2;
        Sat, 17 Feb 2024 10:24:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708194292; x=1708799092; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=pLC9zRflijwVfQm/uk7oxrDMVV/Oz+zmQyj9vEq5EFA=;
        b=W7oYL8QKKlqUmHa4ej4ddDi0WPTyRajRO+1RerOTUVFooQddFHQxC7oD++9E3OTtJF
         eEOqohDTTSMi+/0lz7Gc4UwIRCUn9lwdL1HtzuTPApuvSZ3/FO6coXSLs5w1JrNL8Jp/
         pRGan91ttcyVZp1ugAq974FI13C7QnevjHfYGFatn6qqEtIp2SmtME4onx7rMa+rGv1r
         3IkFTX72YrrSzptFG/ckrpmNvNtJKcipF5N1v4HMq8QoWXzwlQXVjs98552cVynW9g9N
         GvOW04GCXNJfIZDR5YKQp9h4T0Oy4qWWajnVpL62GPuvGkky8WsSRavdkMqTnIfnkIjr
         HvdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708194292; x=1708799092;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pLC9zRflijwVfQm/uk7oxrDMVV/Oz+zmQyj9vEq5EFA=;
        b=fTsAw+Uu+dGq6NXul9OdGgb5jF3WA5tVLEpi4y0ytC75f+SGRtfIhJi5VnqnpAd+lU
         2Hg90678zFSr0nTnD9wLWI0K3IwSo7J0UFI8hfBdMlm/vTyJ8n8+MU2WI9eg6py11Q/Y
         lst3E8l/zeGlycbPwe/L6Qhn+SxLAFh/gymEzLdKfIRG4J8rQEzYZpfAY5Up+8rGZ2Ev
         TLnKp7htph68spkRllPzk7Xtowssuo3BCjSb3ubgZoMQ7Icsgane7xuP9iLA3vD0aG2/
         F426zwil4Vylyh7T0hbGkN8hV1eL76juuM/a+a87Re4IWCd1JR4zqC/g9awDX6ufaLlX
         6fdw==
X-Forwarded-Encrypted: i=1; AJvYcCW1aVn5QjNgV396X3yuAf83IINyUDvGbrFID3BgtNeinqPG/DL7FKSt93mnK6TS1/90HRXKaYRPHl8jl0DU9IPuYz3UnFZScXsbv9N0T1EVnBqlcIYGMz7fQmMYf7SK4m4oEgwWP0bWe+8=
X-Gm-Message-State: AOJu0YwdYN/4RxkyC19/bSal45CTUcDs1J44qmB9Ee/V9yEbJ3bd+qhV
	KC9W5qZUvT3hMGoJGSIHIXSAuTDlSIXk2ZituktBkPp7cNiLu7vg
X-Google-Smtp-Source: AGHT+IHV62nHA3tDgJ+tJsmk8h6u9uo7pOzTcAcpbR3XQjFBnhXLWh8fNK2kWQvL1a797/zgPLXpCg==
X-Received: by 2002:a05:6358:8087:b0:178:7986:a586 with SMTP id a7-20020a056358808700b001787986a586mr10183644rwk.5.1708194292499;
        Sat, 17 Feb 2024 10:24:52 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id fd3-20020a056a002e8300b006e0dd50b0d0sm1959349pfb.8.2024.02.17.10.24.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Feb 2024 10:24:51 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <718f0dd9-121a-4885-8976-aaafa7c44f2d@roeck-us.net>
Date: Sat, 17 Feb 2024 10:24:50 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hwmon: (aquacomputer_d5next) Set fan to direct PWM mode
 when writing value
Content-Language: en-US
To: Aleksa Savic <savicaleksa83@gmail.com>, linux-hwmon@vger.kernel.org
Cc: Jack Doan <me@jackdoan.com>, Jean Delvare <jdelvare@suse.com>,
 linux-kernel@vger.kernel.org
References: <20240217181536.344386-1-savicaleksa83@gmail.com>
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
In-Reply-To: <20240217181536.344386-1-savicaleksa83@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/17/24 10:15, Aleksa Savic wrote:
> When setting a PWM value for a fan channel, ensure that the device
> is actually in direct PWM value mode, as it could be in PID, curve or
> fan following mode from previous user configurations. The byte
> signifying the channel mode is just behind the offset for the value.
> Otherwise, setting PWM speed might result in a no-op from the point
> of the user.
> 

You can require that a device is in manual mode when setting pwm
modes, and return an error if it isn't. However, changing the mode
to manual automatically when a pwm value is written is not acceptable.

Guenter


