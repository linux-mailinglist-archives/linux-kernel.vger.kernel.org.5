Return-Path: <linux-kernel+bounces-22593-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 706DA82A027
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 19:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 880D71C22125
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 18:16:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15854D581;
	Wed, 10 Jan 2024 18:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="Xy8sjHRK"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4827C4D125
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 18:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bef44df5c6so30103139f.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 10:16:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1704910601; x=1705515401; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lo1VQ4EJOV7cREJOABitf1hSk8b65EfBHPgIFVrB/OQ=;
        b=Xy8sjHRKS5oV3l6+1MSvL0Q/xnsezaFObS9tI/uGbjpWCEnbIBvjOv8k6msf/RQ8ty
         aFtj+sdvLE4GlNqD5Q23nO5c0Q0ihMMT2RTx9uEseWcBQskVRx4LNAldFfFeMaY5AbyO
         wVtdhz2ahB/rqhni56amjFK9CTZ+eEubOVFYmot/jyXah4MCALeXQDPkH9azFB0FsyVJ
         i5gZDvOdSBgbP5QGkDmiYs/PJI/CBTxgqf8yyaAC8z1Oe/tzgs52ffPYpsopJb5I048P
         7JEQRRH8hE4N6tS7/0pAJqm9ARmiRH8gMoQMjHlh0y13c/WeZ67yj9kswVQ78io1u4rp
         tbRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704910601; x=1705515401;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lo1VQ4EJOV7cREJOABitf1hSk8b65EfBHPgIFVrB/OQ=;
        b=Hw41eJPtVkdiROO4whJu8yOwQLy/nUESHAJ2vKhIdCeeM0mbyXaGmjQr0iZOpyn0A0
         lXVfrQuH/mZZb5LDbc8stQVJw8j9pt7l4gSYCkk0Cno8lHxAl1epviDdmP6w8tFKETQ0
         mkubtnzERP8tUiKVO/d5DwJUkbENkFffXInD4IGXP/+CJaus+Bu3CE2LIBvZ3nhjoY5y
         bJrO2eNexYFWUZhdzGT4JXv6svPOh/ipi0cMLQPzhHgnxjpIwH6cJMBKm+sx4L+USIdh
         c144i+U9F63gncXVh4K2yQrVr3SWcWtxZl8gqAkb9m5TJxwQ21g2B9wz7BUGrKJxFg2e
         totQ==
X-Gm-Message-State: AOJu0YyV8d/AEwnEShx62XYGbSPOBWnwKykth+Ke4ByQwY4lHmXwuX2d
	3lmTmxr9wdrNTg/u3CmTzFtqpbAuZeCFMg==
X-Google-Smtp-Source: AGHT+IE4EzhYPa/LzL9jotCAfZZS/ofuHIbVxibF33Hm19VsMiO5K5RqGzW8lAvCC04sDZHn23tGgw==
X-Received: by 2002:a05:6e02:1c0e:b0:35d:4463:5dd2 with SMTP id l14-20020a056e021c0e00b0035d44635dd2mr375930ilh.16.1704910601268;
        Wed, 10 Jan 2024 10:16:41 -0800 (PST)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id c21-20020a02c9d5000000b0046b4a8df4f1sm1423121jap.75.2024.01.10.10.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jan 2024 10:16:40 -0800 (PST)
Message-ID: <c065bbb0-e5cb-04ae-cedc-258264162405@landley.net>
Date: Wed, 10 Jan 2024 12:23:19 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: Call for nommu LTP maintainer [was: Re: [PATCH 00/36] Remove
 UCLINUX from LTP]
Content-Language: en-US
To: Petr Vorel <pvorel@suse.cz>
Cc: Cyril Hrubis <chrubis@suse.cz>, Geert Uytterhoeven
 <geert@linux-m68k.org>, ltp@lists.linux.it, Li Wang <liwang@redhat.com>,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Greg Ungerer <gerg@linux-m68k.org>, Jonathan Corbet <corbet@lwn.net>,
 Randy Dunlap <rdunlap@infradead.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Christophe Lyon <christophe.lyon@linaro.org>,
 linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 linux-riscv <linux-riscv@lists.infradead.org>,
 Linux-sh list <linux-sh@vger.kernel.org>,
 automated-testing@lists.yoctoproject.org, buildroot@buildroot.org,
 Niklas Cassel <niklas.cassel@wdc.com>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki> <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik>
 <a3d7f5ae-56c6-9cd8-2cda-2d50d12be9c4@landley.net>
 <20240110133358.GB1698252@pevik>
From: Rob Landley <rob@landley.net>
In-Reply-To: <20240110133358.GB1698252@pevik>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/10/24 07:33, Petr Vorel wrote:
>> I'm a bit weird in that I try to get CURRENT stuff to work on nommu, and a lot
>> of people have been happy to consume my work, but getting any of them to post
>> directly to linux-kernel is like pulling teeth.
> 
> Interesting, thanks for sharing this. BTW I'm not saying anybody is using nommu,
> but I wonder if anybody really test it with LTP. And if yes, I wonder why we
> don't have reports about tests broken in new API.

I don't expect a lot of nommu users are aware you ever _could_ run LTP on nommu.

But I'd like to get nommu more regularly supported. You _should_ be able to
build a musl-linux userspace with busybox or toybox and be able to build a
recognizable system (even an alpine-alike) which could then get the basic
plumbing regression tested on qemu even without access to nommu hardware.

>> > But as I said, if anybody from nommu decides to maintain it in LTP, I'll try to
>> > support him in my free time (review patches, give advices). And if nobody
>> > stands, this patchset which removes the support in the old API will be merged
>> > after next LTP release (in the end of January).
> 
>> What does the API migration do? Is there a page on it ala OABI vs EABI in arm or
>> something?
> 
> New C API is documented at our wiki: the API for using in the tests [1]
> and the library itself [2]. (We also have shell API, but we can ignore it for
> nommu.)

I'm writing a bash-compatible shell, which (thanks to Elliott forwarding
questions) has involved surprisingly long threads with the bash maintainer about
weird corner cases neither the man page nor my testing made clear:

http://lists.landley.net/pipermail/toybox-landley.net/2023-July/029631.html

(Alas I try NOT to involve him because when I bring stuff up he keeps FIXING
BASH which from my point of view just makes it a moving target...)

Anyway, running the shell API on nommu doesn't seem out of the question, but
probably not any time soon. (The fact the shell isn't finished yet is one of the
big REASONS I haven't got enough time to take on LTP. That and I haven't started
writing "awk" and "make" yet". And I need to cycle back to
https://landley.net/notes-2023.html#12-10-2023 . And after that debian, ala
https://peertube.debian.social/w/chzkKrMvEczG7qQyjbMKPr and
https://peertube.debian.social/w/45XroN9CnbYLNLKQH3GD9F . And follow up on
https://lists.gnu.org/archive/html/coreutils/2023-08/msg00009.html . And...)

> All files in lib/ directory which include tst_test.h are part of new C API. Main
> file is lib/tst_test.c.

safe_fork(), safe_clone(), fork_testrun()...

> LTP tests, which has been rewritten to new API include
> tst_test.h, they are in testcases/ directory. Library has it's own tests (for
> testing regression in in lib/newlib_tests/*.c.

Library meaning... libc? Or does LTP have a library?

> The reason why Cyril wrote in 2016 new C API was that the old API was buggy
> (tests randomly fails). Tests which are still using the old API (there is
> ongoing rewrite) include test.h. The old API is not much documented.
> 
> Feel free to ask any more question.

My standard questions are "what does success look like" and "how do I reproduce
the problem".

For the first: if there previously was nommu support in LTP, what's the last
version that's known to work? Is there an existing build/test setup that can be
reproduced?

For the second... If I try to run LTP on sh2eb (my current nommu test board)
with the current LTP... do I get a build break? Additional test failures at
runtime? You talk about "removing nommu support", but... what's the current
status? (A subset of tests still use the old api...?)

Yes I need to read https://github.com/linux-test-project/ltp/wiki/C-Test-API but
I also need to know how to build LTP from source. I'm looking at the README's
list of "autoconf, automake, m4, pkgconf / pkg-config" and wincing
significantly. (What does gnu/autoconf DO here? Disable tests? I never
understand why anybody uses that giant hairball of complexity. Half of cross
compiling is figuring out how to lie to autoconf, and my normal workaround for
that is to bootstrap a target system and build natively, but while I've gotten
gcc to run natively on nommu systems, I never _tried_ gnu/autoconf.
Bootstrapping some subset of LFS on a nommu system so it has the dependencies
LFS needs to natively build seems like the long way 'round...

(I am not the right guy for "make it work the easy way". I am the guy who will
step on every land mine between here and there. I code by debugging an empty
screen. If I don't start from "known working" setup... it would take a while.)

Rob

