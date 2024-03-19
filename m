Return-Path: <linux-kernel+bounces-108009-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 703048804C6
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 19:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8FE0A1C23454
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Mar 2024 18:26:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3F922DF9F;
	Tue, 19 Mar 2024 18:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gq6agP8c"
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2840C2D057;
	Tue, 19 Mar 2024 18:26:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710872780; cv=none; b=DN00Em1siPZmYy1GXSWTc9NUkUdexrrOoxk15B/wuWhaaOOrPfrDnKmpz+sDmbXDU+9gyS2pSLgoOLDFEqG7LfOMsuEcBrowRtSzMXSvI46pC4w9W5H7pU5qm1ZrhNEeZukZVDzgdXAMWgN6UkjmkEWo3mq3bdbL/HOCWuBPb2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710872780; c=relaxed/simple;
	bh=wahjo+tEz7j6H35clrL52KHbAR1sKv6X+PRW9bAHaTA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KkPqA+pAVzP+2b4H61geHrYtjr9cyhSHpQo6IcL34CCOedSdYuNbywohHXtRtF7yl6WeNSo4LxIXw+AG/t6/fGYm8Ky2YVfL0YQC+AnzbR98khKIjiN9TdfY9cy10sj67WJ602c2pwITg0bDx2FocdtrM/gbc4iQMM9jZynfWZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gq6agP8c; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1dddbe47ac1so972975ad.1;
        Tue, 19 Mar 2024 11:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710872778; x=1711477578; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=LQQHHewpOhGKoazUBzUqPFuOzvhctJZdxOAAtuphGlU=;
        b=gq6agP8c89/lq/LOPoL5nYCInxFk8IX/bcD37lR27b/BHcstfV9WGeB9o6TOOGd2fm
         3i0W7O0I1dkOLYCBTNSqbHsJ1qvZwgflKWJfjorezuwetmo8SXlIkH+ZiwyjebtseJSH
         RTKiDxRWOTDp44PA5Ga+7h4dZm5tEvgGhV32XiDwTt+vj2v9oLotkqHZrv7fLs+5Dv7N
         3Onfcf9rjJWg3qYISe3rDkvJyiKG79kGD7uCs96Hc+0hJddAcG+uGJOj21n9v0t0Wnou
         xkCq7yJVBY5bsU7dishdVwIWwK2DPKlqQ9SJtzbMc9y8V0BgiaD+LbRAiYNaeMJm3b4R
         /Bwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710872778; x=1711477578;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LQQHHewpOhGKoazUBzUqPFuOzvhctJZdxOAAtuphGlU=;
        b=fV2CYQkXgFv98G9MxUpyhrYrkBtRff7Wj3nww+4dQ42UUBYMRygUAhLXFOjFhAMKVw
         rkKiXrgI5RdgQpA1kW6bbra9YDg2hF4+eKgYtulFRAcBgWx2BeKxDgmEfcgQ4jgdqUHO
         5NUn5Vdhow8g/vWM1tfA1AXmAwDlSIFtlaTU+zhRtyf/Ycff9x7p9KOVr4b1u0GknlUw
         ACPFw7Ga18FTKr2S96SnWa+Xjl5lRyB8g4IeY137H+nBU/V1+Gr7l+kkBdKEMT7yJzHm
         5osZoubGrK/9WkshbFEf7r9dUpBifNrPaxDYeVUSBNoV/CXx4gb2t8WIGo5IEKEldf0n
         iRAw==
X-Forwarded-Encrypted: i=1; AJvYcCWQwLy9VQfthD1B8Fvj5YfvBh2AL9MVoo+FUG1wr1hvbjrOEsvmz3YHY7Z//VlxPovr9bNnRCU56n2F9wIo0wRallN7jkReqmWpxsBk
X-Gm-Message-State: AOJu0YzYpYqQ5vcjlFL35zKbjLN1DwT+BR3tbIet02KqHf4juqEXjk6i
	m41GMEkoHOMSfOMXs0NlnEG9nICPQwUmJIARHNErGPtOJBf78xyF
X-Google-Smtp-Source: AGHT+IHQWgm1lOyGZ8vfChWm5sAl892Ln5Cgbc63GlgaLlySU/6T5jNTf8qUogcELyVZDs8bUAjeaw==
X-Received: by 2002:a17:902:ecc4:b0:1e0:3f3:1d71 with SMTP id a4-20020a170902ecc400b001e003f31d71mr396275plh.13.1710872778390;
        Tue, 19 Mar 2024 11:26:18 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b5-20020a170902bd4500b001e043df262dsm2030759plx.33.2024.03.19.11.26.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 11:26:17 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <02180516-6d4c-4446-b12b-8451cb4adebc@roeck-us.net>
Date: Tue, 19 Mar 2024 11:26:16 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>, Arnd Bergmann <arnd@kernel.org>,
 Linus Torvalds <torvalds@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
 Uros Bizjak <ubizjak@gmail.com>, linux-sparse@vger.kernel.org,
 kernel test robot <lkp@intel.com>, oe-kbuild-all@lists.linux.dev
References: <20240303235029.555787150@linutronix.de>
 <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
 <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
 <87y1ajjsv9.ffs@tglx> <87o7bfjeae.ffs@tglx>
 <CAHk-=wiP+XMGHr8NU13sSOG_oasNZN02O9_c1PzCJNG7+O-GPw@mail.gmail.com>
 <877ci3j80k.ffs@tglx> <87le6fih5w.ffs@tglx>
 <28ceb124-b634-44e0-bcd4-848fc3b0be7a@app.fastmail.com> <87edc6i45s.ffs@tglx>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <87edc6i45s.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/19/24 09:21, Thomas Gleixner wrote:
> On Mon, Mar 18 2024 at 20:13, Arnd Bergmann wrote:
>> FWIW, I did some experiments a few weeks ago on 32-bit ARM,
>> using a fairly minimal kernel in a virtual machine, and
>> checking the runtime memory consumption rather than compile-time.
>> In a kvm guest with 32MiB RAM, I saw a difference of multiple
>> megabytes in memory usage:
>>
>> Linux testvm 6.8.0-rc4-00410-gc02197fc9076-dirty #1 SMP PREEMPT armv7l
>> root@testvm:~# free
>>             	total   used    free  	shared  buff/cache   available
>> Mem:       	26932   14956   1732   	    52       12800   	11976
>> Swap:      	16360    3632   12728
>>
>> Linux testvm 6.8.0-rc4-00410-gc02197fc9076-dirty #2 PREEMPT armv7l
>> root@testvm:~# free
>>             	total    used  	free  	shared  buff/cache   available
>> Mem:       	26932   13744  	5648        32       10092   	13188
>> Swap:      	16360    3880  	12480
>>
>> There is a little difference between runs, but this does seem
>> significant enough to keep it. The SMP build was with
>> CONFIG_NR_CPUS=2 (the smallest supported compile-time number),
>> but running on a single-CPU qemu instance.
> 
> With a SMP=y, NR_CPUS=1 build on x86 64bit I get:
> 
>                 total        used        free      shared  buff/cache   available
> Mem:        32882056      498068    32590580        4884      128884    32383988
> Swap:         998396           0      998396
> 
> Same config just SMP=n:
> 
>                 total        used        free      shared  buff/cache   available
> Mem:        32885804      461704    32635284        4876      119480    32424100
> Swap:         998396           0      998396
> 
> So the delta for available is ~40 MiB.
> 
> But if I look at it with init=/bin/sh on the command line then the delta
> is significantly different:
> 
> With a SMP=y, NR_CPUS=1 build on x86 64bit I get:
> 
>                 total        used        free      shared  buff/cache   available
> Mem:        32883680      324120    32822728         216       10864    32559560
> Swap:              0           0           0
> 
> Same config just SMP=n:
> 
>                 total        used        free      shared  buff/cache   available
> Mem:        32885804      326876    32821972         216       11100    32558928
> Swap:              0           0           0
> 
> Delta available = 632 KiB
> 
> I haven't had the time to stare at that in detail, but comparing
> /proc/meminfo for the full boot case above does not immediately give me
> a hint. It's confusing at best...
>

That makes me wonder if the number is affected by the total memory size.
How about a system with 1GB of memory or less ?

Guenter


