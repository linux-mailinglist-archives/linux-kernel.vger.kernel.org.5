Return-Path: <linux-kernel+bounces-104868-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4605F87D4CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 21:05:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 514FE1C22621
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 20:05:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 876E8535AC;
	Fri, 15 Mar 2024 20:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OfTIfm/d"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A921EB2C;
	Fri, 15 Mar 2024 20:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710533118; cv=none; b=U5u6jVxRIhe1hJzRBzndJ2ok7c/1haRWqz4cWH8qMjg9PpLufq83RP3vQ/UfxZANgEfTMeCoNYHn5oSm1KMrKpwfqbRRzRv2JNfhh6Wh+R4NA76bsrldQr9b5VBvNDxYiMKvP7F0NtW5nwgiPLRujd4BjEBvf9CHyhu1fITE4cI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710533118; c=relaxed/simple;
	bh=JDikYGdvhgQ6ce6r8cfx1Umv0FK2QT3O6pY3JDKp72g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PuHKp6kOxEsXVwm+dFVcgaPC5/ntZk6HRD9UxaFvPq+c8Lai6vgnZzE8ThE9lO54XA/UgLAqbPJmF5BxYATeMzLw1QIfvAiaNx0rwGXuFtlMdreWblJ2q5omFR+8eSYfPbYegvswZDD5M+Zp743hnDpW+q6/YmICuxz7Xq57qpA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OfTIfm/d; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1de0f92e649so16924135ad.0;
        Fri, 15 Mar 2024 13:05:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710533115; x=1711137915; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=zNciN6yAfU6EO0nRalDFI22wSuWZGXtIWHjKTBGtV6w=;
        b=OfTIfm/dZh6i+sNQgQ8cjEW4KZR4i8nQSuiIwwe7KswgGuFDSbYFd+MU0xPP4gkYjy
         4C1wSeZFSLdY87QbdvTecLmIEdzwCGzz7q4yhCfRm6snt1OuW+7uFEwzYnvGsTjxGXWX
         1Qt1UMVuoSF2WDAM2IdO3r7kBCibr1e13Uj3cSam7VZcabtAy8/rXWM4noaqVSMQcdrx
         ehw5TMFHgVX8DmUeeS+9IC+HDoJTzvxdHZOxGhoF3CGq0JsbGrhBgMe/6Nz25TKsyjnp
         pkx0UwedAAK3YwbP1Om10CaXAEV/QpI1IkPW97s5L3815pZhwguOQhxd9+HjZ9EYI6MU
         F+Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710533115; x=1711137915;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zNciN6yAfU6EO0nRalDFI22wSuWZGXtIWHjKTBGtV6w=;
        b=KL5a0XYrfqW3nbcBWZ4CHBr1sJTKohoBKdjkEnprk3mxknJT1/ASOtZFsyhZPbo32A
         eXJhiQsGMM7m2ACrHiCiLLOhW4krWJZN7ljpnlWc8BSukmQpYOK/A5Brj428+b4zwiWF
         uFgxcduxmesFhTfAzfLjBZ78xF1uWNZKMeP2uIQOxXENl3kLvE9iezA5tvGLPq4WGj/Z
         l5knWfmHEJW6UzWY5/jcTtqz+rtHR+hBRMCFzYKFeiO/V7oOfMFmoy2K1krlBUWspmif
         5FReIQ6LDEc/9BVPqcsKG/6QSiJS2NrURYsYWGdDSVKeGlB968Sa4RAknDJonpdjNAsh
         LAng==
X-Forwarded-Encrypted: i=1; AJvYcCWC7v8nAKUG2l/kPqZZ2mvU6WhI1is++0SfCXNuq4jNJIedbdCmcEAS/r2fLTYdGs3mycud2eGjUvVAUGdaFb0G6c9LXveJPkDvx64my+7nMsbhmtkDMon+C0jtn7IKSBJUJGwU6V564vZdhQk=
X-Gm-Message-State: AOJu0YxM28zyqREsHiu8UmUSEMogQqe4Z5pB8nDor6WjQgGKAkxt2pfv
	bDPIJWx4zjczVUAJiMAlPT5wcCl2QbOtmI80rzMfL1sq+5V9C8aN
X-Google-Smtp-Source: AGHT+IFDsHznpfjSrkKC30e32SUxLPzAFEXgiAYhhhxPbGyTfgGBJcXCy+p7JCZQNbFXuzg3tJo02Q==
X-Received: by 2002:a17:902:e549:b0:1de:fdbd:9324 with SMTP id n9-20020a170902e54900b001defdbd9324mr1574180plf.10.1710533114949;
        Fri, 15 Mar 2024 13:05:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b12-20020a170902650c00b001dc96292774sm4342139plk.296.2024.03.15.13.05.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 13:05:13 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <75b89923-f78b-4661-bc6a-fee6c15367da@roeck-us.net>
Date: Fri, 15 Mar 2024 13:05:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] watchdog: lenovo_se10_wdt: Watchdog driver for Lenovo
 SE10 platform
Content-Language: en-US
To: Mark Pearson <mpearson-lenovo@squebb.ca>
Cc: wim@linux-watchdog.org, linux-watchdog@vger.kernel.org,
 linux-kernel@vger.kernel.org, David Ober <dober@lenovo.com>
References: <mpearson-lenovo@squebb.ca>
 <20240315195227.91282-1-mpearson-lenovo@squebb.ca>
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
In-Reply-To: <20240315195227.91282-1-mpearson-lenovo@squebb.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/15/24 12:52, Mark Pearson wrote:
> Watchdog driver implementation for Lenovo SE10 platform.
> 
> Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
> Signed-off-by: David Ober <dober@lenovo.com>

I don't like the "Found Lenovo SE10" noise in the probe function,
but that isn't worth arguing about.

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

Guenter


