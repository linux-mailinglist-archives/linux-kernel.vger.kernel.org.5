Return-Path: <linux-kernel+bounces-28355-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D00E582FD35
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 23:45:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78150294B84
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Jan 2024 22:45:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A5F208AB;
	Tue, 16 Jan 2024 22:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwPDuRJX"
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 580081D6BD;
	Tue, 16 Jan 2024 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705444500; cv=none; b=sqA3c37nmpakeo3M8pZAd4kULBceqm6fxubR/nvesZScCBIjuVGKDm52Px9H0g6EKTjVzgBSR2E71TfOLqkzqxxEoQW0JKcn24ailEPfSJOseWTY+FAXpC2Mr4dcfF3HBjI5oFHagUlD2/3hyfXOE0rCCqcHFVyCy58qEJFBvYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705444500; c=relaxed/simple;
	bh=dmGaxNFM9Z9co81GnDP7HWWiN/PTrKhRDUIvIXynA4s=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Received:Sender:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:Content-Language:
	 To:Cc:References:From:Autocrypt:In-Reply-To:Content-Type:
	 Content-Transfer-Encoding; b=FJMnl7V4xYvBnIGnppKiLolCJrF5AQhUVdesbxxI6Vo9CQ2BAZDXoeDGDplaILuOqUwgr4GqT9UsKq9An/wneVNdcdWClUd1Udayyc1aLEXuZ78jacCguep+PqkROXJ5Ka9ejvHLa9v+HtWT5lOph8uvAj5b0gc9q9Q4UKkf3OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwPDuRJX; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1d5cdb4a444so20436995ad.1;
        Tue, 16 Jan 2024 14:34:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705444498; x=1706049298; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2ObGmy+ZDmOiEep2qeMUG0WYfwliEG3p7QfyY5yhTY4=;
        b=mwPDuRJXim4Ua3Zs6+7bOgYaXDoe0gYPLQghRv7IDFcL+h5vSmZ5xHA2Y+ve2YJu8n
         sD79/KJFIHmptMMxCqs6BXtKl7Kw4JPZvtB/3HdloR1S9KAVViiXH2KOATV1QVpFRah9
         FWwzpSpHooVlpBwo1eQI/ZH6A/nco4FoW2bKawNJxKAtmJVaeaY701hmD978KHCwHevJ
         4oAePACXQF3t3++F4O2AwUtSphL5OwwHunhXpXgPQSPwvv80imWdlf/xedQNFSJYuB6D
         aawGoFpUTVXOA7iKZQR2WzhK2D55OqrMDClbv1ubSJ4ozX4S0Ier5oT1H3wfwHCZgV48
         +2bA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705444498; x=1706049298;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2ObGmy+ZDmOiEep2qeMUG0WYfwliEG3p7QfyY5yhTY4=;
        b=tLNAQy/xicxsQWo9l+lIWKVcTEr0qvKQk66yyrw9jc/CAMXK0OoNE5tvCGwRJa9cOZ
         domn8zz51CQ3XN6a7/8ZlPhLWxlcNirURDiyJbPAOlyBCgAVbtJe3wY/CiqU9h56RLaW
         k7+2QA1JvfHF32odOkcQRvMbOKs/2YMNoOHwP5FlAopQoP0Z1mwqam4QiljeXYeN6SRr
         tJBhp+pxZh34OJ4E8eoXcTP2nqWO6XQI+2s23yS2r4WNCLmS7QtpifKuC3a8Yv0kLnQX
         FDdG5N4Q+q7H0/lpj/Ou1XF9A3sOugLOwVWHSIJL9z9WCppFxMIPF2q7fPRRuhS6Cb++
         ud1A==
X-Gm-Message-State: AOJu0YxeqNF5VfCntEPlk6RFrGoJC2rjmFpp4L0XiV76MIfle0gNFm3O
	YLTVDJfgQNnFFnsdHA9Xovg=
X-Google-Smtp-Source: AGHT+IHG40a+VKrD24POnkYqTIt2iPkXDYVFzDIDWgt1ELxJ8FjRFnc3CRw8IGOT2riwJGQ8jbur7g==
X-Received: by 2002:a17:902:aa44:b0:1d4:c445:c705 with SMTP id c4-20020a170902aa4400b001d4c445c705mr8257678plr.26.1705444497618;
        Tue, 16 Jan 2024 14:34:57 -0800 (PST)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id v2-20020a17090331c200b001d54c615e09sm9782856ple.252.2024.01.16.14.34.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Jan 2024 14:34:57 -0800 (PST)
Sender: groeck7 <groeck7@gmail.com>
Message-ID: <76bd483b-e48c-4697-8cbd-05a0346090b7@roeck-us.net>
Date: Tue, 16 Jan 2024 14:34:55 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] gpiolib: remove extra_checks
Content-Language: en-US
To: Bartosz Golaszewski <brgl@bgdev.pl>
Cc: Linus Walleij <linus.walleij@linaro.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Kent Gibson <warthog618@gmail.com>, linux-gpio@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
References: <20231219201102.41639-1-brgl@bgdev.pl>
 <19dca2a9-36e1-4a6b-9b65-db4c0a163d56@roeck-us.net>
 <CAMRc=McueRLdFJ_p-QPKPwFJatVXOG8hyeZKniAPGDBrNo2xFg@mail.gmail.com>
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
In-Reply-To: <CAMRc=McueRLdFJ_p-QPKPwFJatVXOG8hyeZKniAPGDBrNo2xFg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 1/16/24 13:41, Bartosz Golaszewski wrote:
> On Tue, Jan 16, 2024 at 7:23 PM Guenter Roeck <linux@roeck-us.net> wrote:
>>
>> Hi,
>>
>> On Tue, Dec 19, 2023 at 09:11:02PM +0100, Bartosz Golaszewski wrote:
>>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>>
>>> extra_checks is only used in a few places. It also depends on
>>> a non-standard DEBUG define one needs to add to the source file. The
>>> overhead of removing it should be minimal (we already use pure
>>> might_sleep() in the code anyway) so drop it.
>>>
>>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
>>
>> This patch triggers (exposes) the following backtrace.
>>
>> BUG: sleeping function called from invalid context at drivers/gpio/gpiolib.c:3738
>> in_atomic(): 1, irqs_disabled(): 128, non_block: 0, pid: 7, name: kworker/0:0
>> preempt_count: 1, expected: 0
>> RCU nest depth: 0, expected: 0
>> 3 locks held by kworker/0:0/7:
>>   #0: c181b3a4 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_scheduled_works+0x23c/0x644
>>   #1: c883df28 ((work_completion)(&(&host->detect)->work)){+.+.}-{0:0}, at: process_scheduled_works+0x23c/0x644
>>   #2: c24e1720 (&host->lock){-...}-{2:2}, at: sdhci_check_ro+0x14/0xd4
>> irq event stamp: 2916
>> hardirqs last  enabled at (2915): [<c0b18838>] _raw_spin_unlock_irqrestore+0x70/0x84
>> hardirqs last disabled at (2916): [<c0b1853c>] _raw_spin_lock_irqsave+0x74/0x78
>> softirqs last  enabled at (2360): [<c00098a4>] __do_softirq+0x28c/0x4b0
>> softirqs last disabled at (2347): [<c0022774>] __irq_exit_rcu+0x15c/0x1a4
>> CPU: 0 PID: 7 Comm: kworker/0:0 Tainted: G                 N 6.7.0-09928-g052d534373b7 #1
>> Hardware name: Freescale i.MX25 (Device Tree Support)
>> Workqueue: events_freezable mmc_rescan
>>   unwind_backtrace from show_stack+0x10/0x18
>>   show_stack from dump_stack_lvl+0x34/0x54
>>   dump_stack_lvl from __might_resched+0x188/0x274
>>   __might_resched from gpiod_get_value_cansleep+0x14/0x60
>>   gpiod_get_value_cansleep from mmc_gpio_get_ro+0x20/0x30
> 
> When getting GPIO value with a spinlock taken the driver *must* use
> the non-sleeping variant of this function: gpiod_get_value(). If the
> underlying driver can sleep then the developer seriously borked. The
> API contract has always been this way so I wouldn't treat it as a
> regression.
> 

I said

"This patch triggers (exposes) the following backtrace"

and

"It isn't really surprising since sdhci_check_ro() calls the gpio code under
  spin_lock_irqsave().
"

I didn't (intend to) claim that this would be a regression. It was
supposed to be a report. My apologies if it came along the wrong way.

Guenter


