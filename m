Return-Path: <linux-kernel+bounces-68885-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E018B858163
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 16:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1075A1C20CC5
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Feb 2024 15:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA9D214831D;
	Fri, 16 Feb 2024 15:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lncGKNKy"
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2812412FF9D;
	Fri, 16 Feb 2024 15:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708097481; cv=none; b=fZAxdLbvlWCTYXdUl5qbn9KUabpTZziZJ1ry/9WYpMQPEPyPMHRVKFrUuehsSOBiNeMQeWtxVJE55B0Dz7bzv810itmKd1wq+K5Ycj8wRIrj1EdXEe0b6KrZDozbiJGgWoUCuCo2SBDO2EHPuBlbCDk5EO3jAJ6S/QSLdv12FxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708097481; c=relaxed/simple;
	bh=mif72V8l/dSsiv6I0YfNK2dgtGn+e1Zy7iPOPLaS4YY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gxV6mHalXBmH+9ODB2NIV4LSyePbRV0rFa6lfOsR1xG7lhy0r3km7O9Hqna3p9PVxs7jhO6Lc+L/64zYz9+RcQhJjhFbw98XW/LEdUoxmLCOhsatrJRqOLB7wGxiFS2AcxyBJgvqidf0NwpiUGzonj1SH4unyDWesZr2GkXqYho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lncGKNKy; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-1d94b222a3aso21128915ad.2;
        Fri, 16 Feb 2024 07:31:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708097479; x=1708702279; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=NRwKtIc0y4D6uspDgYCDd40JBvF9+g5Ek0KwR8dpm74=;
        b=lncGKNKy2e7HA8pJFZB0Nmw3ZYmf8EXhCuOSShMEw1ArIAifFghK7eydMCZaBlNJXn
         1FSgh3W62+o04Mz23pYXWg8gR4jumX40YsC6vbOY+Ywpzw+NQ7/59WZp8QWMxZ2O0znS
         svvLSjspoRIX7COTD0XF51+L9zp3yeiDZs+QdNrYmwv+RJBXnIdTuwCMy7UiWs2Wjx3s
         Pzb67rZJimjpwvDMBiERdE3Zim+GIzGU1cv4L/IOEBiTeia7FDFigUcm1Z1Of+uyAYwz
         78V4RNwondQiv1gVqvb4kf3H7b3b1IduVIr68tP+NsxUMKQjPewci65ur6f031+0Q6p4
         CHow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708097479; x=1708702279;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NRwKtIc0y4D6uspDgYCDd40JBvF9+g5Ek0KwR8dpm74=;
        b=pnJCi7wjS+yl/HKDvRXq2kHaB6yDoV8JlUZ053gw23IGJ1CP2Uh2ZtAHrK+VZjvELd
         OHJZzuLg8GDEk+r5zWIy86tulNriYF/AugO34RHsFSK9Iabmsr5W+fm5XO1/ldfz7GFg
         yG6nUXtiNwc2dxyjfwjw4U/0vKVMC8EEgjfbEhzzNiMG54L0rruZShTgj2WtM1TnvtCO
         I70cdPs3pRkShvQdHOBzaA60Lt039dlG6bGolZp7qHzEYlPC85igNZ3bqD1JSgk2gxxK
         N5OA0kRjs646LuoBwj/sUysy1IiVzbIIo63ZMsAm5sLQib2Aj0uSAS/JH0uYOABEByDb
         Kcxg==
X-Forwarded-Encrypted: i=1; AJvYcCWnAeo7CsvksPMn+DLMItFSYtr/KbgzXsSSxD1gyHVB7Mwaoo5LH0LLoJocDLfIDd4H9tpnDr8Ph0E8owHRCAHzRBJuxw0zRn3X0tmy16qFIM44Fi1XKvh1VRr796dxC0CiQ7K7GQAHgHZT
X-Gm-Message-State: AOJu0YzRkdQ1/kLgVounlstw77ZdusJ8J4SLVqaO57gQg/bVQiBms7O+
	CrQfJsmluF5Ln7TDdl5Y7U1qsnGm6uvS9VkXUEtszmX0ta22ShAFx2jSg7OF
X-Google-Smtp-Source: AGHT+IG/pksW0COuE0jcrM9Af/K2y47/KhMU43KJXItaKlsLkRic5Ua4GBXvlZZfY3z79j5bN4forg==
X-Received: by 2002:a17:902:da92:b0:1db:80d3:1af8 with SMTP id j18-20020a170902da9200b001db80d31af8mr7320104plx.19.1708097479228;
        Fri, 16 Feb 2024 07:31:19 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id u6-20020a170902b28600b001d88f8f574esm4373plr.303.2024.02.16.07.31.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 07:31:18 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <2b09c136-20d8-4fef-bad3-6dbc88362318@roeck-us.net>
Date: Fri, 16 Feb 2024 07:31:17 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] parisc: Fix csum_ipv6_magic on 64-bit systems
Content-Language: en-US
To: Helge Deller <deller@kernel.org>
Cc: Helge Deller <deller@gmx.de>,
 "James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>,
 linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Charlie Jenkins <charlie@rivosinc.com>, Palmer Dabbelt <palmer@rivosinc.com>
References: <20240213234631.940055-1-linux@roeck-us.net>
 <Zc9XW-TxQKp84vMt@p100>
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
In-Reply-To: <Zc9XW-TxQKp84vMt@p100>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Helge,

On 2/16/24 04:38, Helge Deller wrote:
> * Guenter Roeck <linux@roeck-us.net>:
>> hppa 64-bit systems calculates the IPv6 checksum using 64-bit add
>> operations. The last add folds protocol and length fields into the 64-bit
>> result. While unlikely, this operation can overflow. The overflow can be
>> triggered with a code sequence such as the following.
>>
>> 	/* try to trigger massive overflows */
>> 	memset(tmp_buf, 0xff, sizeof(struct in6_addr));
>> 	csum_result = csum_ipv6_magic((struct in6_addr *)tmp_buf,
>> 				      (struct in6_addr *)tmp_buf,
>> 				      0xffff, 0xff, 0xffffffff);
>>
>> Fix the problem by adding any overflows from the final add operation into
>> the calculated checksum. Fortunately, we can do this without additional
>> cost by replacing the add operation used to fold the checksum into 32 bit
>> with "add,dc" to add in the missing carry.
> 
> 
> Gunter,
> 
> Thanks for your patch for 32- and 64-bit systems.
> But I think it's time to sunset the parisc inline assembly for ipv4/ipv6
> checksumming.
> The patch below converts the code to use standard C-coding (taken from the
> s390 header file) and it survives the v8 lib/checksum patch.
> 
> Opinions?
> 

Works for me.

> Helge
> 
> Subject: [PATCH] parisc: Fix csum_ipv6_magic on 32- and 64-bit machines
> 
> Guenter noticed that the 32- and 64-bit checksum functions may calculate
> wrong values under certain circumstances. He fixed it by usining

using

> corrected carry-flags added, but overall I think it's better to convert
> away from inline assembly to generic C-coding.  That way the code is
> much cleaner and the compiler can do much better optimizations based on
> the target architecture (32- vs. 64-bit). Furthermore, the compiler
> generates nowadays much better code, so inline assembly usually won't
> give any benefit any longer.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Noticed-by: Guenter Roeck <linux@roeck-us.net>

That would be a new tag. Maybe use "Reported-by:", or just drop it.

Maybe also consider adding

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")

Other than that,

Tested-by: Guenter Roeck <linux@roeck-us.net>

Thanks,
Guenter


