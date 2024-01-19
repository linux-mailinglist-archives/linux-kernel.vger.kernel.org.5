Return-Path: <linux-kernel+bounces-31148-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E89FB8329C6
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 13:53:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 541D5B2287B
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Jan 2024 12:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488D551C3D;
	Fri, 19 Jan 2024 12:53:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IsY3ET4a"
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7F794F1F6;
	Fri, 19 Jan 2024 12:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705668804; cv=none; b=P9z4IisjmZ4hMPtKTb8e6mXBkRIYWXjB1Hhbjbn20UKTPzGiehY2+Qhv+X+gRJz2Yo0IRmE2r62Z2vPX8F27frPdBhxhDG6IoInbwHkcUtO+fwAgom3EbGk9AqI0ILlm4ldK302LRLu8nkkAl16tdxrZKlu+iPpOX6ZthjoR5Xw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705668804; c=relaxed/simple;
	bh=0y4BSC04otWxDZZPtwZGIu7dgXANcBq9sE7P3QKEXmU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=L5aS1EgnJ/p8Ys0VntJjHDrkZv4iFvGNPluxgW22/cxKRtJ62EBk9HBI+iflrhcokGIgHKop25P1INz5g6oYkZYWv0MkxxtZ1jmOh1qqPjGa3a7Rr2fYiIr/yNFijwk7DoEruBsb2QfGc95o4tuaSTrS+96p2ZmSXQNY8NpePJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IsY3ET4a; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-6da9c834646so772435b3a.3;
        Fri, 19 Jan 2024 04:53:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705668802; x=1706273602; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=sQQbktNOdg7q6Z2j6gpx1q2IJTHA1r1uVxnrDVfNaTc=;
        b=IsY3ET4aFxJ71U7q8T3ww/n/WzwQdXfiWplhrU46SNLVoIAWnkCF7nFnPf9/DbMtuK
         7ZxrxrfvNoZV2bppYFwhelkfnStO7RhOa3wRFlv+72eD1HRw53vGc07IxLO1vBA8LzOR
         lKa6X+erqyXdc8bV1jgg1gH7emmKQtZdAQ/vrK9jls0EGk7uGE6zd4vohnmaKAxIFlNN
         O4Y+PYXqgnXU+GLDb17TBbwxxV8G9ZPlJaIVMClhODDCL8S33MeWJoU+LdYNMlsj4THi
         N2WhbDlOIN0p22O75JLt70p7GHrzJJihrmtCEpg6eLI7WAVoauVGr73uK4fV12Xd4jYM
         3UnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705668802; x=1706273602;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sQQbktNOdg7q6Z2j6gpx1q2IJTHA1r1uVxnrDVfNaTc=;
        b=SRM3NkPSiaobNq2kttTWxyLaJ+b8Ti93nbOYCChhUHYwv+2WN2yPhBndKxr44m/aR2
         JPdZQz0rD+JV+ezCbL+YZ+XSyNgvDzioQ9+qlkd+EGtGUgkl2GJ8cCc8HP/VVPidxfZu
         JOHEe/vfsJBckeIWDMHPUV/WxvGq2qykftQVHDirEwFCw9/OA8k6W1eTHPgq1YnEypc9
         2r4N4fPfyKRghDI3Ip4Q56KML0qo3IUPkNp/uz0I04ftDxg/zKtyo/fs/gIjgG0flEor
         5CsfSAM3diYq1Q5yz/vXQ0VvmeDubN5pEapQ9T+c7A0ALjgwEcBrZw6loDmQIBxwfETx
         7LYQ==
X-Gm-Message-State: AOJu0YwWGwFBerhkj5jXa6qhpYGH42zh7gYiQiOlmf5vh+AulIioprek
	J7R18cXQgtO4L7tjQSzOng4YD1lIYD94W+kMwazNipxhN2cblW/QbCiVCzhg
X-Google-Smtp-Source: AGHT+IHGojORXxOYxVl6qe5Xa6DukkMDmiVYFbw44fXXKTU/DcgQo3QIKKY3smQNIVLWry0C7guHYg==
X-Received: by 2002:a05:6a00:c90:b0:6db:af46:c8af with SMTP id a16-20020a056a000c9000b006dbaf46c8afmr2314864pfv.40.1705668801846;
        Fri, 19 Jan 2024 04:53:21 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id ks11-20020a056a004b8b00b006d6b91c6eb6sm5135977pfb.13.2024.01.19.04.53.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Jan 2024 04:53:21 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <dd5a33f7-96b7-4f10-941e-3a597c7537de@roeck-us.net>
Date: Fri, 19 Jan 2024 04:53:19 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: starfive: Check pm_runtime_enabled() before
 decrementing usage counter
Content-Language: en-US
To: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
 Xingyu Wu <xingyu.wu@starfivetech.com>,
 Samin Guo <samin.guo@starfivetech.com>,
 Wim Van Sebroeck <wim@linux-watchdog.org>,
 Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc: Ley Foon Tan <leyfoon.tan@starfivetech.com>,
 linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240119082722.1133024-1-jisheng.teoh@starfivetech.com>
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
In-Reply-To: <20240119082722.1133024-1-jisheng.teoh@starfivetech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 1/19/24 00:27, Ji Sheng Teoh wrote:
> In the probe function, pm_runtime_put_sync() will fail on platform with
> runtime PM disabled.
> Check if runtime PM is enabled before calling pm_runtime_put_sync() to
> fix it.
> 
> Fixes: db728ea9c7be ("drivers: watchdog: Add StarFive Watchdog driver")
> Signed-off-by: Xingyu Wu <xingyu.wu@starfivetech.com>
> Signed-off-by: Ley Foon Tan <leyfoon.tan@starfivetech.com>
> Signed-off-by: Ji Sheng Teoh <jisheng.teoh@starfivetech.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> ---
>   drivers/watchdog/starfive-wdt.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/watchdog/starfive-wdt.c b/drivers/watchdog/starfive-wdt.c
> index e28ead24c520..df68ae4acbd7 100644
> --- a/drivers/watchdog/starfive-wdt.c
> +++ b/drivers/watchdog/starfive-wdt.c
> @@ -494,8 +494,13 @@ static int starfive_wdt_probe(struct platform_device *pdev)
>   	if (ret)
>   		goto err_exit;
>   
> -	if (!early_enable)
> -		pm_runtime_put_sync(&pdev->dev);
> +	if (!early_enable) {
> +		if (pm_runtime_enabled(&pdev->dev)) {
> +			ret = pm_runtime_put_sync(&pdev->dev);
> +			if (ret)
> +				goto err_exit;
> +		}
> +	}
>   
>   	return 0;
>   


