Return-Path: <linux-kernel+bounces-36662-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E8FB83A4AD
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 09:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A25641F22703
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 08:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F19317BBA;
	Wed, 24 Jan 2024 08:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b="aDWddyzx"
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECA3917BB7
	for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 08:56:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706086618; cv=none; b=EUsRpTYTP695/VLSgZ5Rs6Wl8d4pwGqgJfBISjuaOYAO6M6fySUJ6erdXeSXori62/utT63sueVtgQi3946o/wFnp3BCJ9CFCjjtZK9UeK/6Sk9LiDjY7KoqjgIYiLMUDmMRk2yw1l9DrXtvQN88B74eNQQ46h8xa3yu3IkuJYk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706086618; c=relaxed/simple;
	bh=dVrMUGU5FNcHSAOsHcMw7++s/r63E4ZemMk0gk+U+90=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KrKPTIwIb+8o70/EYfjtCxnTRSCDxAKgrxwiBPEF8SRV6o5IQHHrRFrjyUh1a3syOHoCM7aMqyMz54v4rUtFG7UA02VrLaLm37iXql6cT/2hly2FbTEKbNMKCuA6hQkwv3v2tn2cYFUJQcgKDWK1q8xOvolkC6kjsonyFY89n7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smile.fr; spf=pass smtp.mailfrom=smile.fr; dkim=pass (2048-bit key) header.d=smile-fr.20230601.gappssmtp.com header.i=@smile-fr.20230601.gappssmtp.com header.b=aDWddyzx; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=smile.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smile.fr
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-3392291b21bso4461252f8f.1
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jan 2024 00:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=smile-fr.20230601.gappssmtp.com; s=20230601; t=1706086613; x=1706691413; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=skzJxlwp6Ls2mSmyBdJ2wqDfBkpLt83gmD7vZ6NH92A=;
        b=aDWddyzxR3rlTOo9p16MWtDkkO7mGJJNs0XmUKkz7oepO3V07vpacgBjwKq83xOkW8
         3sJYsp82MMWUXP3T6ldVUkz4uGlIO5vKUX1Mmwa2ENFKrgShQ0j/mz8Avm/gp6X03QRl
         /JnQDgkHA5BDgHSpgPjfo1UhVA+FKn4CYGS5iBIFbRnOopJRCsJtHRNlu9YM2CpSVisY
         f51AFPIc6pUXXJbV77lRtT4StntLYxmp8fLZsF/BQAGmwKnd3kEg6Q4cR8TA5plVk48R
         6n2LNdHrjsQgUcuL5sXsFtremtTKRTBmF67HEa4unBKHrAdEAjiI3IvW4ecGKfvgxZi6
         uL8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706086613; x=1706691413;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=skzJxlwp6Ls2mSmyBdJ2wqDfBkpLt83gmD7vZ6NH92A=;
        b=NvKHq1VrcLmXcGmKbERHWQFtLEk5EuBFI+eSk2TxWLw4zLn9QU5J21NZaLQ4H8q2ay
         Awb96sQsIX/ogoeS4M2aUvT35GCoeHc9REkSTjlEezjZ65JK9oAVctFDp10XmEwtf1YM
         7rmMAgOnMvEJCJuEpx8dKoRmjAjkw22xab/+u9PrlgKg0RbaiWp1eQg2X2kV7Sa2rx13
         2kHrfM1NCiKJ8JQ13+Lz+TJIT0i66Sth3qrEeGgzy3GYnAPNTHKPVzYtaJlHdeS3diKB
         ivEgsfqr/8Kc3m4/IydkwZQEem9gUU12HrQc2WAYsQgAGJ9EsIe7jWyjVleWI4yiTUfj
         1Ekg==
X-Gm-Message-State: AOJu0YyphvzH8tLnIOQckMq6Sfm4l2jREURxKK8/ueGwdwW75jAEpsEo
	9yXRd8Nw8XA+JO3lQlvvlI0mqPbLfi0Az3GEItL30L0tTqkODSZ7JijGboCdmog=
X-Google-Smtp-Source: AGHT+IFFiHrrrfTyHBUqC/JJ9etkX7nWqsCXfzj+BfZ9FAIn6BMnmrdciUWRMyhqsb1IPO2gnY87Bg==
X-Received: by 2002:adf:ee4d:0:b0:336:613e:9e54 with SMTP id w13-20020adfee4d000000b00336613e9e54mr281621wro.89.1706086613010;
        Wed, 24 Jan 2024 00:56:53 -0800 (PST)
Received: from [10.1.8.13] (static-css-ccs-204145.business.bouyguestelecom.com. [176.157.204.145])
        by smtp.gmail.com with ESMTPSA id y3-20020adfee03000000b003368c8d120fsm18286005wrn.7.2024.01.24.00.56.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 Jan 2024 00:56:52 -0800 (PST)
Message-ID: <b65a68eb-6b96-41ff-bbb9-38cb2dee940e@smile.fr>
Date: Wed, 24 Jan 2024 09:56:52 +0100
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] kconfig: remove unneeded symbol_empty variable
Content-Language: en-US
To: Masahiro Yamada <masahiroy@kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-kbuild@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 Vegard Nossum <vegard.nossum@oracle.com>
References: <20231125163559.824210-1-masahiroy@kernel.org>
 <CAMuHMdWm6u1wX7efZQf=2XUAHascps76YQac6rdnQGhc8nop_Q@mail.gmail.com>
 <d21298d9-fed6-4e08-9780-dbcb388b9ccc@smile.fr>
 <CAK7LNASaG4DpHTb3YHMd8d8DJ5H3z0aiUcSqX+=7CZb99kRU8A@mail.gmail.com>
From: Yoann Congal <yoann.congal@smile.fr>
Organization: Smile ECS
In-Reply-To: <CAK7LNASaG4DpHTb3YHMd8d8DJ5H3z0aiUcSqX+=7CZb99kRU8A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit



Le 24/01/2024 à 09:09, Masahiro Yamada a écrit :
> On Wed, Jan 24, 2024 at 12:11 AM Yoann Congal <yoann.congal@smile.fr> wrote:
>>
>> Le 23/01/2024 à 13:54, Geert Uytterhoeven a écrit :
>>> Hi Yamada-san,
>>
>> Hello,
>>
>>> On Sat, Nov 25, 2023 at 5:36 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>>>> This is used only for initializing other variables.
>>>>
>>>> Use the empty string "".
>>>>
>>>> Please note newval.tri is unused for S_INT/HEX/STRING.
>>>>
>>>> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
>>>
>>> Thanks for your patch, which is now commit 4e244c10eab345a7
>>> ("kconfig: remove unneeded symbol_empty variable") in v6.8-rc1.
>>>
>>> When running "make <foo>_defconfig" with <foo>_defconfig an SMP
>>> defconfig without explicit configuration of CONFIG_LOG_CPU_MAX_BUF_SHIFT,
>>> the aforementioned commit causes a change in the generated .config:
>>>
>>> -CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
>>> +CONFIG_LOG_CPU_MAX_BUF_SHIFT=0
>>>
>>> It looks like CONFIG_BASE_SMALL=0 is treated as a string instead of
>>> the integer number zero?
>>>
>>> init/Kconfig=config LOG_CPU_MAX_BUF_SHIFT
>>> init/Kconfig-   int "CPU kernel log buffer size contribution (13 => 8
>>> KB, 17 => 128KB)"
>>> init/Kconfig-   depends on SMP
>>> init/Kconfig-   range 0 21
>>> init/Kconfig:   default 12 if !BASE_SMALL
>>> init/Kconfig:   default 0 if BASE_SMALL
>>>
>>> Note that reverting 4e244c10eab345a7 is not sufficient to fix the issue.
>>> Also reverting commit 6262afa10ef7cc8f ("kconfig: default to zero if
>>> int/hex symbol lacks default property") does fix it.
>>
>> (Since I'd really like 6262afa10ef7cc8f ("kconfig: default to zero if int/hex symbol lacks default property") to stay, allow me to try to help)
>>
>> The problem is quite easy to reproduce:
>>   $ make x86_64_defconfig
>>   $ grep 'LOG_CPU_MAX_BUF_SHIFT\|BASE_SMALL\|BASE_FULL' .config
>>   CONFIG_LOG_CPU_MAX_BUF_SHIFT=0
>>   CONFIG_BASE_FULL=y
>>   CONFIG_BASE_SMALL=0
>> Here, CONFIG_LOG_CPU_MAX_BUF_SHIFT should be 12 not 0.
> 
> 
> 
> I could not produce it in this way.
> I ran the same commands as yours.
> 
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12 for me.
> 
> 
> 
> masahiro@zoe:~/ref/linux(master)$ git describe
> v6.8-rc1-29-g615d30064886
> masahiro@zoe:~/ref/linux(master)$ git diff
> masahiro@zoe:~/ref/linux(master)$ make  x86_64_defconfig
> #
> # No change to .config
> #

You already had a .config with the correct value of LOG_CPU_MAX_BUF_SHIFT (Maybe?)

> masahiro@zoe:~/ref/linux(master)$ grep
> 'LOG_CPU_MAX_BUF_SHIFT\|BASE_SMALL\|BASE_FULL' .config
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=12
> CONFIG_BASE_FULL=y
> CONFIG_BASE_SMALL=0

Try to remove the existing .config:

   $ git describe 
  v6.8-rc1
   $ git diff
   $ rm .config -f
   $ make  x86_64_defconfig
  #
  # configuration written to .config
  #
   $ grep 'LOG_CPU_MAX_BUF_SHIFT\|BASE_SMALL\|BASE_FULL' .config
  CONFIG_LOG_CPU_MAX_BUF_SHIFT=0
  CONFIG_BASE_FULL=y
  CONFIG_BASE_SMALL=0

>>
>> For what it is worth, CONFIG_BASE_SMALL is defined as an int but is only used as a bool :
>>    $ git grep BASE_SMALL
>>   arch/x86/include/asm/mpspec.h:#if CONFIG_BASE_SMALL == 0
>>   drivers/tty/vt/vc_screen.c:#define CON_BUF_SIZE (CONFIG_BASE_SMALL ? 256 : PAGE_SIZE)
>>   include/linux/threads.h:#define PID_MAX_DEFAULT (CONFIG_BASE_SMALL ? 0x1000 : 0x8000)
>>   include/linux/threads.h:#define PID_MAX_LIMIT (CONFIG_BASE_SMALL ? PAGE_SIZE * 8 : \
>>   include/linux/udp.h:#define UDP_HTABLE_SIZE_MIN         (CONFIG_BASE_SMALL ? 128 : 256)
>>   include/linux/xarray.h:#define XA_CHUNK_SHIFT           (CONFIG_BASE_SMALL ? 4 : 6)
>>   init/Kconfig:   default 12 if !BASE_SMALL
>>   init/Kconfig:   default 0 if BASE_SMALL
>>   init/Kconfig:config BASE_SMALL
>>   kernel/futex/core.c:#if CONFIG_BASE_SMALL
>>   kernel/user.c:#define UIDHASH_BITS      (CONFIG_BASE_SMALL ? 3 : 7)
>>
>> Maybe we should change CONFIG_BASE_SMALL to the bool type?

My first test shows that switching CONFIG_BASE_SMALL to bool type does fix the LOG_CPU_MAX_BUF_SHIFT default value.

>> I'll poke around to see if I can understand why a int="0" is true for kconfig.

Here's what I understood:
To get the default value of LOG_CPU_MAX_BUF_SHIFT, kconfig calls sym_get_default_prop(LOG_CPU_MAX_BUF_SHIFT)
-> expr_calc_value("BASE_SMALL" as an expr)
-> sym_calc_value(BASE_SMALL as a symbol) and returns sym->curr.tri

But, if I understood correctly, sym_calc_value() does not set sym->curr.tri in case of a int type config.

Regards,
-- 
Yoann Congal
Smile ECS - Tech Expert

