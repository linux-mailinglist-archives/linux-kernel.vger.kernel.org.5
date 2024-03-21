Return-Path: <linux-kernel+bounces-110122-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E36E885A56
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 15:07:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B80F283383
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Mar 2024 14:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F2C084FC3;
	Thu, 21 Mar 2024 14:06:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i/4iNYaY"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D73284FBE;
	Thu, 21 Mar 2024 14:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711030018; cv=none; b=b8GJVgSFKbtko6Urac/BtNXt/rcBkMkSy8vjnaaAkASgIZ7iLla1vn8mjBFxSdmxx7dr80Hf/5eHMq4c3UiKFdiDdtC8lHZ9Mkx2ZuynfpZ17aw9jxMWAHvn8+oHSpg6RnkStRSeupYbWfF1TnuHvjzgkLD17iONLpqOmHMp8Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711030018; c=relaxed/simple;
	bh=zaTUAijWhDBp3/lbqHyLaBZ5jNNvSWYKMSFnPQXWheY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lzIqF/YLiaczU4jE6fQbYVTS9TIT+Ut18UWuCzVC60Y/LvnBYseKMVJQ+vJXx5NWB0IVagMJY6nrD3lnzX7Mk5dIr8DHCLQUeM0EAOqftR3Bx+aBaUFrSF4U8HOCDQOTD6ijP0IKQF1QHDny0T2TGPwqaF7PneBE9PhJeKGWk6s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i/4iNYaY; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1def89f0cfdso16318715ad.0;
        Thu, 21 Mar 2024 07:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711030016; x=1711634816; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HtXNI+62fFa8CbzTh7Vt6tmtTKztEJKVFWxuz5Cz1VA=;
        b=i/4iNYaYCtHBLFtr1ESO421lkdFPf/PBzp0BR942Q0XMeCpg54bjLAT6OSFTXTrygR
         uF1AocnsHKKXr2vqalkeLHDPFbB2T7Txq/tzeR7KM9S6+h4MFUNnKHQwxEgHjJ7rKkZV
         wCxHhz//8YAEQ3yLs/MnB5G/OgiuT9ZUTJdKp08jmXYVjjGlZjmX2HqXENjfIgxdHSWu
         BkJIzitS80k30CSr3d954czMRMSPzplOwgPNuPsgipaiczkblx+LXVeORVzKXXjPourj
         yRRG9R7PdlyKDaX1sQAzMsIdZCcRVXzceMRPIG+fURQLZp9246/s+hsucvXy5ktQRF/4
         H+sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711030016; x=1711634816;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HtXNI+62fFa8CbzTh7Vt6tmtTKztEJKVFWxuz5Cz1VA=;
        b=uM6X9udbc4RiJT9oHKevGCtWD4iLEgMej8im8PuZFhPzfAySZzFERDusgUuUw+k38x
         khWXtMoN6FS8myS1zPrvcrC4BD33xUukvjJb8rOzNI4cXrsqzytCT3IPx0SdBjdRol9x
         SKIVNWylcjAeFamH5CkBGquWcvAS7iUgJruO72v2sCE1S30uWXPAUBM5qyAtcwZFEVS0
         ouJd4iAQ/l1YRIXxkX+22mZgNC1HNzwH9anG/CUyd36W1gHCsgH66UGP9FmbzUbzJYMI
         WGXlWzc63VRvUOJSwVTRIzkajL6ZhUgzSOWQLra7p2JR7tSV7uXQ90dC0rq6gY6KlVYm
         3Z2A==
X-Forwarded-Encrypted: i=1; AJvYcCX2jvJgg0+IlT1Yh+f0W4CEEZsEoA+lGuGNuN+eXe55FmUtMHgu7+KNqUpnlusXr1e0XrRBmd2yEqpZvObC48PMZ74SCi1HAOh+ZEC0
X-Gm-Message-State: AOJu0Yx0CrbeLQYoW+24dXb0VKkI7GyaJ0ad39PVQNQYD+r6FTu3vHm6
	PiIUpwAUcbEZr4yVURmHiqzs1WYRi2DPdztSZJqkWxNof7DL4uwE
X-Google-Smtp-Source: AGHT+IFTbs+TBaZPiTwONRDyntMT4Usn+hdcznq8gNDMKB1dPwP0CFKpdhO6nXkZW0g86ZO2n+YP5Q==
X-Received: by 2002:a17:903:2343:b0:1dd:88b6:ce0d with SMTP id c3-20020a170903234300b001dd88b6ce0dmr4923592plh.25.1711030015813;
        Thu, 21 Mar 2024 07:06:55 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id c8-20020a170903234800b001dd7d00f7afsm15890579plh.18.2024.03.21.07.06.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 07:06:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <86796005-f1d9-4c8c-80d8-f1f88ca220ba@roeck-us.net>
Date: Thu, 21 Mar 2024 07:06:53 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
 Linus Torvalds <torvalds@linuxfoundation.org>,
 Uros Bizjak <ubizjak@gmail.com>, linux-sparse@vger.kernel.org,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev
References: <20240303235029.555787150@linutronix.de>
 <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net> <87bk79i8km.ffs@tglx>
 <d51ec9a1-5221-4005-9980-8258df8b5102@roeck-us.net> <87r0g3hm5o.ffs@tglx>
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
In-Reply-To: <87r0g3hm5o.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/21/24 04:14, Thomas Gleixner wrote:
> On Wed, Mar 20 2024 at 08:46, Guenter Roeck wrote:
>> On 3/20/24 01:58, Thomas Gleixner wrote:
>>> On Fri, Mar 15 2024 at 09:17, Guenter Roeck wrote:
>>>> I don't know the code well enough to determine what is wrong.
>>>> Please let me know what I can do to help debugging the problem.
>>>
>>> Could you provide me the config and the qemu command line?
>>>
>>
>> defconfig-CONFIG_SMP and
>>
>> qemu-system-x86_64 -kernel arch/x86/boot/bzImage -cpu Haswell \
>>        --append "console=ttyS0" -nographic -monitor none
>>
>> The cpu doesn't really matter as long as it is an Intel CPU.
>> A root file system isn't needed since the boot doesn't get that far.
> 
> Now it get's interesting because I can't reproduce it with that setup at
> all.
> 
> What's weird is that I saw it exactly once on 64-bit in a VM with a UP
> config two days ago, but when I started to add instrumentation it never
> came back even after backing the instrumentation changes out. I have
> seriously no idea what's going on there.
> 
> Is it fully reproducible on your side?
> 

Yes, always.

> If so can you please provide a full dmesg and then apply the patch below
> and provide the resulting full dmesg too?
> 

You'll find everything at http://server.roeck-us.net/qemu/x86-nosmp/

The crash is gone after applying your patch. The difference is:

+       /*
+        * If there was no APIC registered, then the map check below would
+        * fail. With no APIC this is guaranteed to be an UP system and
+        * therefore all topology levels have only one entry and their
+        * logical ID is obviously 0.
+        */
+       if (topo_info.boot_cpu_apic_id == BAD_APICID) {
+               pr_info("#### topo_info.boot_cpu_apic_id == BAD_APICID\n");
                 ^^^^ I added this
+               return 0;
+       }
+

I see the "#### topo_info.boot_cpu_apic_id == BAD_APICID" message
twice in the log. See patched.log at the page pointed to above.

Hope the helps,
Guenter


