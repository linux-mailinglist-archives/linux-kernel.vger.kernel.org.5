Return-Path: <linux-kernel+bounces-106308-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 05DB687EC3B
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 16:32:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ADA61281967
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Mar 2024 15:32:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1BF5524B5;
	Mon, 18 Mar 2024 15:32:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD4IFQuO"
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8528A51C5D;
	Mon, 18 Mar 2024 15:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710775937; cv=none; b=p35AkBNZQAPpGm4U5kYcLBpnyrOgX9jIAyAHteV+XgEbHZ6+M8fSuyBoIuuxt+9SGz+6OldB89JgTKiThrkMXeGJLxsL6UNRHwX9+dv0rDMaN4ixy9o3399PRVA72RaA0JV+exKf81+ZZz9nbUoXKJshytaJ+3OJDOg/coBHwR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710775937; c=relaxed/simple;
	bh=yBaChVBN26OVyTrZJMYrc++M8ytlVQCQcgeinGTH8yw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=l4leCK9YIMKedDnMjY1jic3XUyVWMfKWmkHC/DMm0VW43D2+T4sfuNuH1cJcHhF5PbnyIZVLgoigjv41XnX+jzhDOl41Od1Hq/Ork3+Lf2TBCWQBtdlNDYQIKtzwbLKEi/MczuoFg75KXrb5xSUkc4gbc1kzKL/FDP6CPgo7/oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RD4IFQuO; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-6e709e0c123so1544440b3a.1;
        Mon, 18 Mar 2024 08:32:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710775935; x=1711380735; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=EfY/qiqxT4YwaL7SKZu6dl0J+rA9algw3GQFNprsafI=;
        b=RD4IFQuOWAINHr/SlirJ3yg9fJs4YGHVyplXRnii+65fGWUQVHKyd1oIMI3XFhZ6di
         0ESwPY1kneY/ObONB3qqF3OaUgFeBZWB7+4Q31dOEqCLFy96C0qpTuarCZdAnrDBOCTt
         CXtYXhAzwNGQUXbZxIlOoCd8nw0kEmp87FVvzIXzP4PKR6f35MCqGhj+Y/P39/AbJkwe
         fvfr+Y5lCo8YZlpwjBa01h/AvRQ6DG6xKv1pCfKUbBO3pxVRyNw5bWsqHw+kiw1G460f
         j488tq/61zRZZMBBkFdaCOl3el3NUg4PTGAPWXlfMoB57XBCz8umKk4WPkpJoKFZIO2X
         pu2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710775935; x=1711380735;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EfY/qiqxT4YwaL7SKZu6dl0J+rA9algw3GQFNprsafI=;
        b=BdgcUHDyNc8QGKVxxQKj7Dk3Pk8KjIzmswyCL74NXsK0sgB3epRqX6R078mBZu3Om8
         FzaA0XPB/pFotfbCYn5mVEYk06rHKV+7Rax2HY8aqjmXxI0oTMRaZoVZrq5MB0LO3eKl
         w4fDrUoOsqjCLF4JmeEAXlUSvgArzPFRB6+1/F8MOv3KjOCy9dmCPw2HBynxawLcXSFY
         EThZ5UE0qc+61tqnACE38XZ6tGfn8AiNTSiqFQbZfbZEGbQemwFVnpx/ZQvZvalaObIf
         QWm8M0ucEL+T+w2hwYK+Hvcfqeu2ZXvuot6gH6fD8iPjRE9fW+x+zsr//siogzjB0/1+
         +9Aw==
X-Forwarded-Encrypted: i=1; AJvYcCWtmQjlk6/iFf+YyrIjqjFuXRiEyv2ci9hXcafF2BgkTOpwtmRBKAJaJVKSSEtrTJa5fQNPlrrBJ0gbx7Z/SgzWHM0P33tzB5OufXFFC79JsbbkZdw1HoouMmQiPJ9qCJknM4eLmoE=
X-Gm-Message-State: AOJu0YywnYZXj1uu8R08dpCV4AMFPdzdydJew78IBRqSSXmRox5mLhny
	X0uZ6Lr1dHlqGIK6X2itlE6Yn71e75zP031J6DMWfaDrw1au5axg
X-Google-Smtp-Source: AGHT+IHy7cTYyxD4ekxt8FwUB/vQynTebQsg8xAvkWhqUtRSZrDnlwu48HcqVKnSJVZIruDgChZGZw==
X-Received: by 2002:a05:6a00:178e:b0:6e6:9552:cf33 with SMTP id s14-20020a056a00178e00b006e69552cf33mr23495pfg.31.1710775934773;
        Mon, 18 Mar 2024 08:32:14 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id p19-20020a62ab13000000b006e6c0f8ce1bsm8099015pff.47.2024.03.18.08.32.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Mar 2024 08:32:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <93ad802f-c152-4461-9f9f-c338f58a000d@roeck-us.net>
Date: Mon, 18 Mar 2024 08:32:12 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Problems with csum_partial with misaligned buffers on sh4
 platform
Content-Language: en-US
To: Linux regressions mailing list <regressions@lists.linux.dev>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
References: <65ed7c95-712c-410b-84f3-58496b0c9649@roeck-us.net>
 <351dfebd-c09f-470e-8b03-cc904753b136@roeck-us.net>
 <2b54a5d8-b317-4df7-ab2e-d63a352dd77d@leemhuis.info>
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
In-Reply-To: <2b54a5d8-b317-4df7-ab2e-d63a352dd77d@leemhuis.info>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/18/24 08:04, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 11.03.24 18:04, Guenter Roeck wrote:
>> On Sat, Feb 10, 2024 at 07:12:39AM -0800, Guenter Roeck wrote:
>>>
>>> when running checksum unit tests on sh4 qemu emulations, I get the following
>>> errors.
>>
>> Adding to regression tracker.
>>
>> #regzbot ^introduced cadc4e1a2b4d2
> 
> Hmmm, thx for that, but well, I'm a bit taken back and forth here. That
> commit afaics is from v3.0-rc1 and Linus iirc at least once said
> something along the lines of "a regression only reported after a long
> time at some point becomes just a bug". I'd say that applies there,
> which is why I'm wondering if tracking this really is worth it.
> 

Not my call to make. I'll keep in mind to not add "bugs" to the regression
tracker in the future. Feel free to drop.

For my understanding, what is "a long time" ?

Thanks,
Guenter


