Return-Path: <linux-kernel+bounces-73607-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA8D85C503
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 20:43:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A1DF11C2214E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Feb 2024 19:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605B814A4C3;
	Tue, 20 Feb 2024 19:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrWcchgX"
Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B18512AAE8;
	Tue, 20 Feb 2024 19:42:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708458143; cv=none; b=Cv4MLmSzOY4DSb0QrGAKkpBMdXCHK8Dl9Pv59qQrF0nEDoHU/mPXsWMwWlgNGbQp+zoUekaExEZ7R+1MKnCRlV4GFKylcNmFRstrKkXDAJwSXy8HfNpm5ukk1JjpMlAE9ZPTtZJ39hoWysKDSbbyLXwso3m6EMpm6oxuV3+oRKw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708458143; c=relaxed/simple;
	bh=1cexSrrC6JM6zvMkG59oGblaaOAYt0D+VD/7Sb1v8Rk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Y5p6kvwkHC/0pQVvrA8huZdPW1SUAm+tfcmAnqELKCuWg7PVvbsqn53D+D9dfFcbln4LGgNH1TZwwqCVb1NL1zchLCKK3I4+2sQAz+DTSDR1qKgSqEupCpy5twVXKQRu4qfDmqVYdE1ctjyR6LazMq7FyQEZ6cejyK4txQV27LY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LrWcchgX; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-1dc0d11d1b7so15028715ad.2;
        Tue, 20 Feb 2024 11:42:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708458141; x=1709062941; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HR5Nv2iYJ7WuKkVogoE27NqRFkPYMrWQ+OOPIl5QYtg=;
        b=LrWcchgX/olgn0yLW4ZKnXM75iF/4LOr7bnkYi9L8Dtxedhmptr91BZkOr1Vg5qkp1
         iyuYCAwELcNkUQmj8STE9feqvLGqoQh0SgUpaQPuuZOAHAZcGn3q0MjxMhC4x4Rk9T/t
         +XYQey1lPSea+Cf5Z3ykCjOTOAoNMHAsOvG5WjqDLoOf9AiqAbi2rU+/aqJFqee6XApz
         6n+oXTt2GlO4Qck3Zx0Jp4iRSBMqR0TqK5PE2Q4lAlJkZrCIYFjVHvEcdw6oL0LpCVEB
         46EEVnCrDtyB73tGPwSQgmq+zxhzkSRt6UZVWSIj/FR0ML/J0buOnvBJjEVNf65FEfe2
         SOEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708458141; x=1709062941;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HR5Nv2iYJ7WuKkVogoE27NqRFkPYMrWQ+OOPIl5QYtg=;
        b=kujyRg4GPp21B+fsx9yzDLM/Z87hTBCDfNuWdhkUWhDyIACbMtQPyO+Jaa9aSZQ0cH
         ppSAI6vvV8JTCxGFZOIVp/31G6idMGflnvawiNlAyfDW5jKX54ZO0y5lBXznOr0v3gVO
         edEhXrWfYexW8O6U50f3Yj68lSBiengYwzGv93NQ/C/FKL8cgFtI1Z7Z+eSCej3pPe7/
         5rn6XgBP/Adn4EYfUXL5jyOwr3UT7yvopJlo41Y/dYAymsba5b+LPBysdK73zUOzH0eD
         EundWmr26SaXxbwSsnKqphq9mogQTfVoGChJhUjc4V+su7cX4qN6tugzs501kg7pM0pn
         iiEg==
X-Forwarded-Encrypted: i=1; AJvYcCXLalk3+ZFfEn2BZnqAvYqPKYv7dCdRLGQewUcuaXM8+JIktYbtKK/3mTAvVj+4HAVUvPRJmjcyiVgPlCwFWHsV74HrH9lpKY6YoVWsRF8JknBRLXZuz2/rOzFOs0OrEgkCiC/3K5EfX0Z5Qa3tAgjfmhALklTh4MeK5tFtDrcztqstkA11
X-Gm-Message-State: AOJu0YwjJMALaE7q+jqNwcdGBwjO7qVJe2b993BKNXLTQkvlw22afNIX
	z8EX7/t2GEuUJv53llVxIyHdUSoQgw7t4SCpss3sy6LUi/uvC0mM
X-Google-Smtp-Source: AGHT+IH8BE20vX1PW6ZDAkEgaFvJS3VtqvcBuXqDBmEHOnDOuBZo5S57FCwLLAAuApJg6ctaulNv1A==
X-Received: by 2002:a17:902:e846:b0:1db:ff7b:d203 with SMTP id t6-20020a170902e84600b001dbff7bd203mr5923269plg.31.1708458141301;
        Tue, 20 Feb 2024 11:42:21 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g18-20020a170902c99200b001db5241804csm6648751plc.20.2024.02.20.11.42.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Feb 2024 11:42:20 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <9281dd01-d20e-4eed-96ae-6aa63c9eb678@roeck-us.net>
Date: Tue, 20 Feb 2024 11:42:18 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] drivers: rtc: add max313xx series rtc driver
Content-Language: en-US
To: Chris Packham <chris.packham@alliedtelesis.co.nz>,
 antoniu.miclaus@analog.com, alexandre.belloni@bootlin.com,
 robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
 jdelvare@suse.com
Cc: linux-rtc@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
 Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
 Zeynep Arslanbenzer <Zeynep.Arslanbenzer@analog.com>
References: <20240219221827.3821415-1-chris.packham@alliedtelesis.co.nz>
 <20240219221827.3821415-2-chris.packham@alliedtelesis.co.nz>
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
In-Reply-To: <20240219221827.3821415-2-chris.packham@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/19/24 14:18, Chris Packham wrote:
> From: Ibrahim Tilki <Ibrahim.Tilki@analog.com>
> 
> Adding support for Analog Devices MAX313XX series RTCs.
> 

Adding -> Add

The subject should really be something like "rtc: max31335: Add support
for additional chips", with details in the patch description.

All those (in my opinion unnecessary) function, data structure,
and variable renames makes it really difficult to review the code.
I don't see the point of that, so please don't expect any further
feedback about the hwmon changes from me.

Thanks,
Guenter


