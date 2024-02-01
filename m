Return-Path: <linux-kernel+bounces-48247-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 404EC845916
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 14:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECC112932BE
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Feb 2024 13:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A1D25CDF0;
	Thu,  1 Feb 2024 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QyRPSTw1"
Received: from mail-oo1-f42.google.com (mail-oo1-f42.google.com [209.85.161.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D71C5CDD6;
	Thu,  1 Feb 2024 13:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706794769; cv=none; b=flnBeL6MFg3Pw/AdAJEneAwOGdiUTp3RHTEikIY6dPkkdqJ82grVeJedr4hcxNBuQ6AOPnCtiF1bvR/nvd6UPI26hAgQOQg1u6pu3jDE1cx/zzXOtKv3aU5gSiWDOoG0tCrs1TaPNlJfu5PiTtgNuGTzpNK2MHZmhJhfx1VllBg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706794769; c=relaxed/simple;
	bh=fLTfzeQXcuPEP3zlDMMHeW16ZF2oHJoLj1WYoy1frXE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pS6njk72zs+s9MECO5zPVLUm4e1WBiMK0gXp46n7pCN2Dw+IvfKCsuGRaWZ3u+VrXNzUuy3shnLe6d7tx7JGYmcId5jvJuGsYx3wauJ34p7srNPtTt4Ov88HZ4wXS0YsnNNQ/2xH1UcJ24GthHl8hXpPlpeX33SX11byq9I9k5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QyRPSTw1; arc=none smtp.client-ip=209.85.161.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f42.google.com with SMTP id 006d021491bc7-59a87156cb8so413220eaf.2;
        Thu, 01 Feb 2024 05:39:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706794767; x=1707399567; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=GeKESK9rOJ3c7laLRAM6oOR+NZov6ycIq+xUbqPybZc=;
        b=QyRPSTw1EjEREJ0ASuD9jDEE60v2brbBaFl4No9UDPWToeiYLzuD0/2o5irTZOhil2
         VnC3Q7Ncb3GaFLuc8eZOL6nlFfUZ5B0uN5q6SBjHKw2rSR/VGbBQ6hFzRRSSCNNL0UiV
         klq45kNMUY+tUtGFFtBgrg/YsuQKHcqzQwed0E16NVUuBB4jxohWsWSEQ2BaizqtqJBg
         o9JQ7Ezs77L2MIduTYrFZQlGNMskm9JmHDIgQK/yF6ex5NHbWMyX1DxPi8LiIpX19HCs
         B1ttDxbRZ+ULjNfHHfqWPvrh+eO2irSwWz2JhY49K65Gcw6OBweXjnitMeNMhHz0nst5
         tifQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706794767; x=1707399567;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GeKESK9rOJ3c7laLRAM6oOR+NZov6ycIq+xUbqPybZc=;
        b=BLvssRYgGqYMLBRv/KoA3lRkmUQKRyeyT9ztr8rY/MnG6Rv94MNAZnr2z0AWDNCozf
         S/3UEz/Q0bDD0kJz0QrmQYwEiubM1eWPaa4xel7MjgNhRtHxoxouM6QRYv5g35zD0mEw
         7lOETR2qd57+4dYotJAjLVrWzDuJSGEatqhWXfe5DjWpT1q1so6eMhHgjSHyhiQO4JcF
         BxfSxStN/P4w4bOoiUFM51pcpPz09jh7Ppnu3ekeQnaHhuV3vkDqPfpn/t6STRrJCfkT
         t/feJuTAjFZ6b3S3Lia++JommcVNd4ULwk+Z66C+1N+VfZgHhKX5RDfweMFC9OmKfstW
         os4w==
X-Gm-Message-State: AOJu0YzGv0tfT5zL/0SrVsK610ZCr00t35hvpyMncnqMzBWyYlfHdDpJ
	24dfKQW+FW0PbRqb+GeTQLQdgk7e1iAKbNqXUqK2tQX4Zb3wBmRl
X-Google-Smtp-Source: AGHT+IGo1p2N9ELKeF8QVl63eQlGkEZUhd+Y3coD3jKOM+5Q45h/mj5/DTP+4WcFVdUDqspqaCMR8Q==
X-Received: by 2002:a05:6358:5d83:b0:178:7542:1a58 with SMTP id s3-20020a0563585d8300b0017875421a58mr5741160rwm.7.1706794767198;
        Thu, 01 Feb 2024 05:39:27 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCVpREtw309XCG2fzpQUnjss4Iud7bSrkZGoGvqlr9Iz4GXOMTJn4qHrumVrZ+v17u1410IqHxbUIui1y+lM1HTuUxqJj0bAK5JoqlSZqW8t4YmtP3fQI4P89WjhN/Yfkj4GHAF8bm6GCZCAUYVSWNIQDuzsBnleZZyouxy4CGifofNOGg7R1ZkQfy4P6xKJwFupArLLZgQtRJN8kDxZV2NGnfNaC9qT9Mm0UviGux+PXyd7zaSLWPdl4xu84Pe2z36O8IKNQBB27wEcz3jeDZijd+unWeTxpClVJ6NUYpaEturT5s785ppSS3UnqHu4voGBMbDyDzbRKBAh+XFkXpoIWJ3rU5EGuHWUGDDQty6NF9M4OxK3Gh1wx5/8KAwyVHIcDQ==
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m1-20020a634c41000000b005cfd70edc1bsm12471762pgl.7.2024.02.01.05.39.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Feb 2024 05:39:26 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <a02c7451-8515-45d4-ae7b-9e64b03b5b38@roeck-us.net>
Date: Thu, 1 Feb 2024 05:39:25 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 net-next 08/13] net: phy: marvell-88q2xxx: add support
 for temperature sensor
Content-Language: en-US
To: Andrew Lunn <andrew@lunn.ch>
Cc: Dimitri Fedrau <dima.fedrau@gmail.com>,
 Heiner Kallweit <hkallweit1@gmail.com>, Russell King
 <linux@armlinux.org.uk>, "David S. Miller" <davem@davemloft.net>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Jean Delvare <jdelvare@suse.com>,
 Stefan Eichenberger <eichest@gmail.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org
References: <20240122212848.3645785-1-dima.fedrau@gmail.com>
 <20240122212848.3645785-9-dima.fedrau@gmail.com>
 <88a60be9-083b-4618-845c-6983bcad3540@roeck-us.net>
 <c9866a56-d82e-4a3d-b335-db22c0413416@lunn.ch>
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
In-Reply-To: <c9866a56-d82e-4a3d-b335-db22c0413416@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/1/24 05:27, Andrew Lunn wrote:
>>> +#ifdef CONFIG_HWMON
>>
>> HWMON is tristate, so this may be problematic if the driver is built
>> into the kernel and hwmon is built as module.
> 
> There should be Kconfig in addition to this, e.g.
> 
> config MAXLINEAR_GPHY
>          tristate "Maxlinear Ethernet PHYs"
>          select POLYNOMIAL if HWMON
>          depends on HWMON || HWMON=n
>          help
>            Support for the Maxlinear GPY115, GPY211, GPY212, GPY215,
>            GPY241, GPY245 PHYs.
> 
> So its forced to being built in, or not built at all.
> 

Even then it should be "#if IS_ENABLED(HWMON)" in the code.

Thanks,
Guenter


