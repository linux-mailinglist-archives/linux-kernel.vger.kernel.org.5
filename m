Return-Path: <linux-kernel+bounces-105018-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D57BE87D7B3
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 01:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD4AB1C20F82
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Mar 2024 00:57:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B734C92;
	Sat, 16 Mar 2024 00:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gmaJqwD1"
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29AA61373;
	Sat, 16 Mar 2024 00:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710550603; cv=none; b=if9UK2UOezP1tMssvtT83vp4zXkC9vdZGumBqmzcL66zuFSZZaP9qcY8TFz5Y7EmizMe5T08DnWdvTBcy1VgBhFPbewIC0O8+ZrsrZgFYatdHgoHs7DuG/fcge6qW0uBUH4lN+A0OwU3Z/DbUtpvwFzlj5SyVnEusiLeXJ4D0Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710550603; c=relaxed/simple;
	bh=GzpXGju8r1EMjUXgfiSPBTny+xorxdNlJkRQ9l2G1LI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I4TEQQMtXLjl6YU15lmtUxAqFNmczEbld62ZKahqN9GeZXLRbrvS6y8GsJLyFLrRC/AhEHy0ZMC04ON/YvCU1aGJk84MclJkrpVIhw/adpukfA44Yt4wI3RynsELDek2L8Mu9wXTYDyX5WeBKugDCkngljMk9ZlXQ5eVH5fdE08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gmaJqwD1; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=roeck-us.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29ddfd859eeso1789859a91.1;
        Fri, 15 Mar 2024 17:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710550598; x=1711155398; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=0qsfZ9Ym0BoNvdxMrPHu/Yx3Zwnm969oPkEv6CYAOd8=;
        b=gmaJqwD1TI1F5uU5YmoIvLTe5dwxVsvG8Qf6kywEXOPr8AvG7aYtvyHQvr4yPY9zW9
         goe36iF2MQIZp/+vT/ZHzPtVmuwa5WSjO1kh/zsBiJfOSqKp3JR/u7wAVt+vwqjPpZ/o
         QnRKrwUjneXgwPX5dL9G/vfGdNL1Db4OfFHWgme/l4pF5qYZXlEQw+qTtx3mdv5Kftxc
         Dqw1FR5X/yrBX+g3r3bh7RPBlw9xK6G8vZAG9jjU73PVfT9uItZWwQNQFkFUKljPZz/G
         IKpnHYgPMxi57ZwicNHSY2ktN5frYeMfWEJletF02HGpBFuAoxBOApGUg0Mhqpb4yuzR
         IFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710550598; x=1711155398;
        h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
         :to:content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0qsfZ9Ym0BoNvdxMrPHu/Yx3Zwnm969oPkEv6CYAOd8=;
        b=GzSp1qWiOsnisnNLMnrw0omHA0eu6Uxrp/WGLLCRfZ8Aly0idEDrPrRg5iHkIwvP+9
         r4KLASf6xYzMuNZcnz87/7KTGAL5ir7A1XUTDJwDDuCt7q20vEqX3UV2DaA9RzYV5i8b
         zt8B2/w/1Ay9sPdxlQU9QTbxoMdn5f5lmKoEFqJ1lCeSKgtbLfztiBxfS+0wixl2p7me
         YzbrnnN65hQ2RdvJDr2qBdW9tJ6HvqJJpQHA1VzixY9nq4KD7YGBUykGoZaMbXo6JtJY
         0vggxEgGazlO0guTe+uqku0vw/zQpBAjmZOMZEqGw6lwDcw8Qp6RGda3Ooemev0EM1cv
         txtA==
X-Forwarded-Encrypted: i=1; AJvYcCXAkwBEAp/RF/IZ8c6sQYvu9bxuOmOC9oPvQ24yFS2IE7YqKiTZpPwUhFQiSaYaah3FporZKNoY1VvdxsArlTrTdwupjgoHUyWrEAZN
X-Gm-Message-State: AOJu0YwO/A2jgWOKq0aQpQ6W0rcTvk4sr9cktpC/NQ2UD8ptfmvhJXR7
	Y1ZRlFBjIRHqHGHjQ//LlTBZJ9lKJI3yVDhHWafO7w6W32KNhNqV
X-Google-Smtp-Source: AGHT+IFBm6zYwhE5RfHU0IzIcQGDGO6XLIdq5FAiq4NuYo9C2FF+vuMEgJ9LAO7Uei1MHng6FOjxJA==
X-Received: by 2002:a17:90a:fa0d:b0:29b:dc17:1553 with SMTP id cm13-20020a17090afa0d00b0029bdc171553mr4929400pjb.15.1710550598361;
        Fri, 15 Mar 2024 17:56:38 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id rr7-20020a17090b2b4700b0029bcf877eabsm3590103pjb.10.2024.03.15.17.56.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Mar 2024 17:56:37 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <7d0be0f7-e988-4ca2-b61b-21853e4268f6@roeck-us.net>
Date: Fri, 15 Mar 2024 17:56:36 -0700
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [patch 5/9] x86: Cure per CPU madness on UP
Content-Language: en-US
To: Thomas Gleixner <tglx@linutronix.de>,
 Linus Torvalds <torvalds@linuxfoundation.org>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
 Uros Bizjak <ubizjak@gmail.com>, linux-sparse@vger.kernel.org,
 lkp@intel.com, oe-kbuild-all@lists.linux.dev
References: <20240303235029.555787150@linutronix.de>
 <20240304005104.622511517@linutronix.de>
 <e20d88d0-5fb9-4307-be67-88b04ae9a188@roeck-us.net>
 <CAHk-=whK=G1o6RtS9DS3wEGF1KU7WLgLL1+6Se86bj8m7wwqrQ@mail.gmail.com>
 <87y1ajjsv9.ffs@tglx> <87o7bfjeae.ffs@tglx>
From: Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
In-Reply-To: <87o7bfjeae.ffs@tglx>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 3/15/24 15:55, Thomas Gleixner wrote:
> On Fri, Mar 15 2024 at 18:40, Thomas Gleixner wrote:
>> On Fri, Mar 15 2024 at 09:42, Linus Torvalds wrote:
>>> On Fri, 15 Mar 2024 at 09:17, Guenter Roeck <linux@roeck-us.net> wrote:
>>> Thomas, over to you. I wonder if maybe all those topology macros
>>> should just return 0 on an UP build, but that
>>> topology_get_logical_id() thing looks a bit wrong regardless.
>>>
>>> It really shouldn't depend on local apic data for configs that may not
>>> *have* a local apic.
>>
>> Right. Let me look.
> 
> Not really. The problem is that a SMP build can run on a UP machine w/o
> APIC or command line disables the APIC and will run into the exactly
> same problem. The only case where we know that it is impossible is when
> APIC support is disabled, which is silly but topic for a different
> discussion.
> 
> So the proper thing to do is to check for num_possible_cpus() == 1 in
> that function.
> 
> Sure you can argue that we could avoid it for SMP=n builds completely,
> but I think the right thing to do is to aim for removing CONFIG_SMP and
> make the UP build a subset of a generic SMP capable build which has
> CONFIG_NR_CPUS=1, i.e. num_possible_cpus() = 1. Why?
> 
> Because it consolidates the code and makes UP use exactly the same
> mechanisms as SMP which pretty much avoids the problem we see today that
> UP lacks test coverage and becomes more esoteric and untested over time.
> 
> The downside is a slightly larger kernel image for such a build.
> 
> Though if we pretend that we seriously care about that 10% larger memory
> footprint or about the marginal performance benefit of SMP=n on dead
> hardware, then we are just taking the wrong pills.
> 

FWIW, I would very much prefer for SMP=n builds to go away for x86.
I don't think anyone uses that in the real world nowadays, and I never
know if I should report problems like this one or just stop testing it.

> The point is that this very commit in question was heading deliberately
> into the direction of removing the by now silly differences of UP/SMP
> for correctness sake. It just happened to unearth the missing check in
> topology_get_logical_id(), but that check is required independent of
> SMP=y/n as I pointed out above.
> 
> Thanks,
> 
>          tglx
> 
> ---
> diff --git a/arch/x86/kernel/cpu/topology.c b/arch/x86/kernel/cpu/topology.c
> index 3259b1d4fefe..118d9f7792ee 100644
> --- a/arch/x86/kernel/cpu/topology.c
> +++ b/arch/x86/kernel/cpu/topology.c
> @@ -279,6 +279,15 @@ int topology_get_logical_id(u32 apicid, enum x86_topology_domains at_level)
>   
>   	if (lvlid >= MAX_LOCAL_APIC)
>   		return -ERANGE;
> +	/*
> +	 * Spare the exercise on UP as there is only one instance at any
> +	 * level and the map check below might fail because the CPU does
> +	 * not have a local APIC or local APIC has been disabled on the
> +	 * kernel command line.
> +	 */
> +	if (num_possible_cpus() == 1)
> +		return 0;
> +

That works.

Tested-by: Guenter Roeck <linux@roeck-us.net>

>   	if (!test_bit(lvlid, apic_maps[at_level].map))
>   		return -ENODEV;
>   	/* Get the number of set bits before @lvlid. */


