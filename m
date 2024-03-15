Return-Path: <linux-kernel+bounces-104462-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A65A487CE36
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 14:45:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C893A1C2187F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Mar 2024 13:45:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B92A36B15;
	Fri, 15 Mar 2024 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CqWYlMkx"
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18AFD36AED;
	Fri, 15 Mar 2024 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710510302; cv=none; b=rFQSHM4raiO6yUra7iZN6/LVIPqCYtJ208ciDWS7T6UExHiKR62loDhqXaTtYiLTl3eHuhlCEQ54PC6HNjUcoopY/OSsiPmCpNNb/5D4ViR/oWEXPIwRerBgYR+qg1uHWgGoHIOpYQ9H+yfII6WBtIOhKhy/B56VlDqf9f50VqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710510302; c=relaxed/simple;
	bh=NeSw/VhaksfYVzAjLjsO0L040OaYHnf7sqiWxtSQ2C4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XPMiT6yvjwgqThgaOSjTzTDw7yn4L9bZU4LPJcQmjm+hnrlscc5zo134x1AbJekFrKHZpUM0tQX1nathkD1FYVEN5FxQSDoLAYwOXBO+9puidmaywnB1ZGZ31v/M0fR62UWQWEcPMDuGTWSCz3rAYsQ+8gYTjR+2VWLd75dgLtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CqWYlMkx; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-6e6aa5c5a6fso2223680b3a.0;
        Fri, 15 Mar 2024 06:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710510300; x=1711115100; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e+78oPNVgIjBcQ6gIE0dwFYyVOjgHIMey58qLvr+REE=;
        b=CqWYlMkxBzpkvxSBM4n1DyQqZpq4kcMRpo+j9E/8PYISr9pIwEOEvE3auABofCzMcK
         9+u9Ie15Oh/32undcas97ROoKC8Va3+4OBr9k1VAUhevxvQQWDkWgifgA95UzUdkXS9x
         WMDVDrN0lgb0zkan+oKRxIqUDicRbCsMiIpoE2pPhjhwXyPxBMPTOpXGiuObZVoE2tgv
         b6O92eFqO3KMv4lc+LDOMJ/an8oMw1SZ/HVC0NK0QJ+Bk96XzmzwFjVJQw6X6HB3Wwi1
         Ya2qq707O2I/7B779039QvIKedYfDTcg7hwwb/rKOWZkWyhnegJLWbsE1146ahBdapD6
         hRVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710510300; x=1711115100;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e+78oPNVgIjBcQ6gIE0dwFYyVOjgHIMey58qLvr+REE=;
        b=ahlvYTqk47HMR+UcI2SkBWhx/VeHzkjv4LeMxgJVglopYKdZAQNe74XkCzzMeLL2dX
         6ScO7uV02ztmUayA8ygg6I8WO/Y9q1dQpy/5Dg6PHDG7eqIJ/W4zTNXuTxSq0hzclIfd
         aDoL03wO/tC007Q0+4EKKYd4LEMDVtN4D76JJ6IYLDInwXV5NYX4RyNj28bH3/CtrAEu
         eZCiqusoXmRQ0e/pHe6BTzaIONhBFrT/by0Dh4LPL9M9FsTRsTKMeNClDtjXubalPiSU
         9weP1uXAhRVoqaMYfJX5N2GGuL6YcmYZ4bujrSm+Y+bV4hjTEPfpWFCzh4Lhz3ZMtI5+
         2oXQ==
X-Forwarded-Encrypted: i=1; AJvYcCVdvZ7hpNqSTibdvwPP3x4LoXo+8wNG9tAEFK2rnihp5QVOTHU/G2OX6/U2itv2EISdIaxA7g2BCSAgU79HsNbYoQ/JkWKTwvP8K050XfzGiWP/6Vn2zRW5jBA8NIaCTKbL
X-Gm-Message-State: AOJu0YwZJC6qW+fRQUYE09tnR2W5uxNbqjYASIoVwR8bDsQ42jGQA7nt
	gCka/rhO0olCny6Zq0O5+//IioQsaq+VS7AYu3mAnoypZGSLi7a7
X-Google-Smtp-Source: AGHT+IE9S7DwGEFt65Tksyt5zYGa0NDNZV5DlPTjkPssfN5eKSBX9c4uO7L18jiUkxkCzT696q2ROw==
X-Received: by 2002:a05:6a20:9184:b0:1a3:4779:3fc3 with SMTP id v4-20020a056a20918400b001a347793fc3mr4219908pzd.37.1710510300318;
        Fri, 15 Mar 2024 06:45:00 -0700 (PDT)
Received: from [10.230.29.214] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id x18-20020aa784d2000000b006e5a915a9e7sm3502608pfn.10.2024.03.15.06.44.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 06:44:59 -0700 (PDT)
Message-ID: <1c5227a6-6b22-46c5-9966-d35ac1c770af@gmail.com>
Date: Fri, 15 Mar 2024 06:44:56 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] timer/migration: Remove buggy early return on
 deactivation [was Re: Unexplained long boot delays [Was Re: [GIT PULL] RCU
 changes for v6.9]]
Content-Language: en-US
To: Frederic Weisbecker <frederic@kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Russell King (Oracle)" <linux@armlinux.org.uk>,
 Joel Fernandes <joel@joelfernandes.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 linux-kernel@vger.kernel.org, kernel-team@meta.com, paulmck@kernel.org,
 mingo@kernel.org, rcu@vger.kernel.org, neeraj.upadhyay@amd.com,
 urezki@gmail.com, qiang.zhang1211@gmail.com, bigeasy@linutronix.de,
 chenzhongjin@huawei.com, yangjihong1@huawei.com, rostedt@goodmis.org,
 Justin Chen <justin.chen@broadcom.com>
References: <533151c9-afb5-453b-8014-9fbe7c3b26c2@gmail.com>
 <ZfIuRMo8oKbR08Af@lothringen>
 <f4a2a18c-1c81-4857-a3a0-d049ec5c79b3@gmail.com>
 <ZfLUU+XuQC7W79tf@lothringen>
 <d6c8e4fe-17bf-443d-a6f5-54470390e1fd@gmail.com>
 <ZfNHNvzpqf8DOZd8@boqun-archlinux>
 <de038bee-cecd-4e76-b0f4-5822b68e439d@gmail.com> <87v85olez3.ffs@tglx>
 <87sf0sldbi.ffs@tglx> <ZfN0wY41pU5UjP8T@boqun-archlinux>
 <ZfOhB9ZByTZcBy4u@lothringen>
From: Florian Fainelli <f.fainelli@gmail.com>
Autocrypt: addr=f.fainelli@gmail.com; keydata=
 xsDiBEjPuBIRBACW9MxSJU9fvEOCTnRNqG/13rAGsj+vJqontvoDSNxRgmafP8d3nesnqPyR
 xGlkaOSDuu09rxuW+69Y2f1TzjFuGpBk4ysWOR85O2Nx8AJ6fYGCoeTbovrNlGT1M9obSFGQ
 X3IzRnWoqlfudjTO5TKoqkbOgpYqIo5n1QbEjCCwCwCg3DOH/4ug2AUUlcIT9/l3pGvoRJ0E
 AICDzi3l7pmC5IWn2n1mvP5247urtHFs/uusE827DDj3K8Upn2vYiOFMBhGsxAk6YKV6IP0d
 ZdWX6fqkJJlu9cSDvWtO1hXeHIfQIE/xcqvlRH783KrihLcsmnBqOiS6rJDO2x1eAgC8meAX
 SAgsrBhcgGl2Rl5gh/jkeA5ykwbxA/9u1eEuL70Qzt5APJmqVXR+kWvrqdBVPoUNy/tQ8mYc
 nzJJ63ng3tHhnwHXZOu8hL4nqwlYHRa9eeglXYhBqja4ZvIvCEqSmEukfivk+DlIgVoOAJbh
 qIWgvr3SIEuR6ayY3f5j0f2ejUMYlYYnKdiHXFlF9uXm1ELrb0YX4GMHz80nRmxvcmlhbiBG
 YWluZWxsaSA8Zi5mYWluZWxsaUBnbWFpbC5jb20+wmYEExECACYCGyMGCwkIBwMCBBUCCAME
 FgIDAQIeAQIXgAUCVF/S8QUJHlwd3wAKCRBhV5kVtWN2DvCVAJ4u4/bPF4P3jxb4qEY8I2gS
 6hG0gACffNWlqJ2T4wSSn+3o7CCZNd7SLSDOw00ESM+4EhAQAL/o09boR9D3Vk1Tt7+gpYr3
 WQ6hgYVON905q2ndEoA2J0dQxJNRw3snabHDDzQBAcqOvdi7YidfBVdKi0wxHhSuRBfuOppu
 pdXkb7zxuPQuSveCLqqZWRQ+Cc2QgF7SBqgznbe6Ngout5qXY5Dcagk9LqFNGhJQzUGHAsIs
 hap1f0B1PoUyUNeEInV98D8Xd/edM3mhO9nRpUXRK9Bvt4iEZUXGuVtZLT52nK6Wv2EZ1TiT
 OiqZlf1P+vxYLBx9eKmabPdm3yjalhY8yr1S1vL0gSA/C6W1o/TowdieF1rWN/MYHlkpyj9c
 Rpc281gAO0AP3V1G00YzBEdYyi0gaJbCEQnq8Vz1vDXFxHzyhgGz7umBsVKmYwZgA8DrrB0M
 oaP35wuGR3RJcaG30AnJpEDkBYHznI2apxdcuTPOHZyEilIRrBGzDwGtAhldzlBoBwE3Z3MY
 31TOpACu1ZpNOMysZ6xiE35pWkwc0KYm4hJA5GFfmWSN6DniimW3pmdDIiw4Ifcx8b3mFrRO
 BbDIW13E51j9RjbO/nAaK9ndZ5LRO1B/8Fwat7bLzmsCiEXOJY7NNpIEpkoNoEUfCcZwmLrU
 +eOTPzaF6drw6ayewEi5yzPg3TAT6FV3oBsNg3xlwU0gPK3v6gYPX5w9+ovPZ1/qqNfOrbsE
 FRuiSVsZQ5s3AAMFD/9XjlnnVDh9GX/r/6hjmr4U9tEsM+VQXaVXqZuHKaSmojOLUCP/YVQo
 7IiYaNssCS4FCPe4yrL4FJJfJAsbeyDykMN7wAnBcOkbZ9BPJPNCbqU6dowLOiy8AuTYQ48m
 vIyQ4Ijnb6GTrtxIUDQeOBNuQC/gyyx3nbL/lVlHbxr4tb6YkhkO6shjXhQh7nQb33FjGO4P
 WU11Nr9i/qoV8QCo12MQEo244RRA6VMud06y/E449rWZFSTwGqb0FS0seTcYNvxt8PB2izX+
 HZA8SL54j479ubxhfuoTu5nXdtFYFj5Lj5x34LKPx7MpgAmj0H7SDhpFWF2FzcC1bjiW9mjW
 HaKaX23Awt97AqQZXegbfkJwX2Y53ufq8Np3e1542lh3/mpiGSilCsaTahEGrHK+lIusl6mz
 Joil+u3k01ofvJMK0ZdzGUZ/aPMZ16LofjFA+MNxWrZFrkYmiGdv+LG45zSlZyIvzSiG2lKy
 kuVag+IijCIom78P9jRtB1q1Q5lwZp2TLAJlz92DmFwBg1hyFzwDADjZ2nrDxKUiybXIgZp9
 aU2d++ptEGCVJOfEW4qpWCCLPbOT7XBr+g/4H3qWbs3j/cDDq7LuVYIe+wchy/iXEJaQVeTC
 y5arMQorqTFWlEOgRA8OP47L9knl9i4xuR0euV6DChDrguup2aJVU8JPBBgRAgAPAhsMBQJU
 X9LxBQkeXB3fAAoJEGFXmRW1Y3YOj4UAn3nrFLPZekMeqX5aD/aq/dsbXSfyAKC45Go0YyxV
 HGuUuzv+GKZ6nsysJw==
In-Reply-To: <ZfOhB9ZByTZcBy4u@lothringen>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 3/14/2024 6:14 PM, Frederic Weisbecker wrote:
> On Thu, Mar 14, 2024 at 03:05:53PM -0700, Boqun Feng wrote:
>> I notice CPU3 didn't have its own non-deferrable timer queued (local or
>> global), so could the following happen?
>>
>> 	timer_base_try_to_set_idle():
>> 	  __get_next_timer_interrupt():
>> 	    fetch_next_timer_interrupt():
>> 	      // nextevt_local == nextevt_global == basej + NEXT_TIMER_MAX_DELTA
>> 	      // tevt->local == tevt->gloabl = KTIME_MAX
>> 	    timer_use_tmigr():
>> 	      tmigr_cpu_deactivate():
>> 	        __tmigr_cpu_deactivate():
>> 		  // tmc->cpuevt.ignore untouched still == true
>> 		  walk_groups(&tmigr_inactive_up, ...):
>> 		    tmigr_inactive_up():
>> 		      data->remote = true;
>> 		      tmigr_update_events():
>> 		        if (child) { // child is NULL
>> 			  ...
>> 			} else {
>> 			  first_childevt = evt = data->evt;
>>
>> 			  if (evt->ignore && !remote)
>> 			    return true; // no remote tick is picked.
>> 			  ...
>> 			}
> 
> Nice catch! Florian can you try the following?
> 
>  From b0e335371ed758f68bf4f501246298c98a615b04 Mon Sep 17 00:00:00 2001
> From: Frederic Weisbecker <frederic@kernel.org>
> Date: Fri, 15 Mar 2024 00:21:01 +0100
> Subject: [PATCH] timer/migration: Remove buggy early return on deactivation
> 
> When a CPU enters into idle and deactivates itself from the timer
> migration hierarchy without any global timer of its own to propagate,
> the group event of that CPU is set to "ignore" and tmigr_update_events()
> accordingly performs an early return without considering timers queued
> by other CPUs.
> 
> If the hierarchy has a single level, and the CPU is the last one to
> enter idle, it will ignore others' global timers, as in the following
> layout:
> 
>             [GRP0:0]
>           migrator = 0
>           active   = 0
>           nextevt  = T0i
>            /         \
>           0           1
>        active (T0i)  idle (T1)
> 
> 0) CPU 0 is active thus its event is ignored (the letter 'i') and so are
> upper levels' events. CPU 1 is idle and has the timer T1 enqueued.
> 
>             [GRP0:0]
>           migrator = NONE
>           active   = NONE
>           nextevt  = T0i
>            /         \
>           0           1
>        idle (T0i)  idle (T1)
> 
> 1) CPU 0 goes idle without global event queued. Therefore KTIME_MAX is
> pushed as its next expiry and its own event kept as "ignore". As a result
> tmigr_update_events() ignores T1 and CPU 0 goes to idle with T1
> unhandled.
> 
> This isn't proper to single level hierarchy though. A similar issue,
> although slightly different, may arise on multi-level:
> 
>                              [GRP1:0]
>                           migrator = GRP0:0
>                           active   = GRP0:0
>                           nextevt  = T0:0i, T0:1
>                           /              \
>                [GRP0:0]                  [GRP0:1]
>             migrator = 0              migrator = NONE
>             active   = 0              active   = NONE
>             nextevt  = T0i            nextevt  = T2
>             /         \                /         \
>            0 (T0i)     1 (T1)         2 (T2)      3
>          idle         idle            idle         idle
> 
> 0) CPU 0 is active thus its event is ignored (the letter 'i') and so are
> upper levels' events. CPU 1 is idle and has the timer T1 enqueued.
> CPU 2 also has a timer. The expiry order is T0 (ignored) < T1 < T2
> 
>                              [GRP1:0]
>                           migrator = GRP0:0
>                           active   = GRP0:0
>                           nextevt  = T0:0i, T0:1
>                           /              \
>                [GRP0:0]                  [GRP0:1]
>             migrator = NONE           migrator = NONE
>             active   = NONE           active   = NONE
>             nextevt  = T0i            nextevt  = T2
>             /         \                /         \
>            0 (T0i)     1 (T1)         2 (T2)      3
>          idle         idle            idle         idle
> 
> 1) CPU 0 goes idle without global event queued. Therefore KTIME_MAX is
> pushed as its next expiry and its own event kept as "ignore". As a result
> tmigr_update_events() ignores T1. The change only propagated up to 1st
> level so far.
> 
>                              [GRP1:0]
>                           migrator = NONE
>                           active   = NONE
>                           nextevt  = T0:1
>                           /              \
>                [GRP0:0]                  [GRP0:1]
>             migrator = NONE           migrator = NONE
>             active   = NONE           active   = NONE
>             nextevt  = T0i            nextevt  = T2
>             /         \                /         \
>            0 (T0i)     1 (T1)         2 (T2)      3
>          idle         idle            idle         idle
> 
> 2) The change now propagates up to the top. tmigr_update_events() finds
> that the child event is ignored and thus removes it. The top level next
> event is now T2 which is returned to CPU 0 as its next effective expiry
> to take account for as the global idle migrator. However T1 has been
> ignored along the way, leaving it unhandled.
> 
> Fix those issues with removing the buggy related early return. Ignored
> child events must not prevent from evaluating the other events within
> the same group.
> 
> Reported-by: Boqun Feng <boqun.feng@gmail.com>
> Reported-by: Florian Fainelli <f.fainelli@gmail.com>

Gave it a good 20 cold boots and suspend to DRAM cycles and none of 
those triggered the reported behavior:

Reported-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>

Thanks for the quick fix Frederic!
-- 
Florian

