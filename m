Return-Path: <linux-kernel+bounces-13195-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C1AC820108
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 19:29:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB12C1F21B31
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Dec 2023 18:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F056912B9A;
	Fri, 29 Dec 2023 18:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="HPy7A0gg"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A833712B94
	for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 18:29:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-593f7a1afd7so4253500eaf.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Dec 2023 10:29:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1703874555; x=1704479355; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AeSrtwQFurF3YcqKmZ2Gt/CZU5AB/xdcrHrq4YB+YYQ=;
        b=HPy7A0ggUGfH6s1EnM0YCdJJ0d19olaHinlwhluoGFlYJXiDRibKwGt96axQmY19wJ
         w8vZsLRzyYH17ORKm6HQCMPT8As8iwTABgywxDE06LHy83bej7xfDsfqdH6mIOaCM58R
         T3zfNbyXitdTSpciZowZxe9PmH4wAayHVjQgpADubhrlmlZ48X4Yxpz8smGJystfTkPl
         AI5JDl8rEw+Tf7vmw6agbj4wxPJKiMs2Se0VQTtI42JVHzId6ITi1ia3u5UoCg6Ajrx3
         wgiWTOA5WIvOYfsvsag1+w570SWsOZ4UCKHm1OYf2LDMalb1MHaDMw19+k2PUMUODOc7
         PZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703874555; x=1704479355;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AeSrtwQFurF3YcqKmZ2Gt/CZU5AB/xdcrHrq4YB+YYQ=;
        b=hhosJkOkaaWoUdIvx9Ofrpik+GC6TCTcVSX02mMyQsUgLNA6hDxquOqbYRKjLvy1mP
         rj194d1Qi4rjbt1gRGSsH2VxnPD6vGwAtgoe2ivJE+Qka/hY77BwI99AXSROF8EvIqkt
         9TrpFX9/LBWfDuDfTe9u9SO3NeCL5L1QHOj+wDoB/vFGqvpR5FuA2PzFsMDJ8GRDPvSY
         InsFa80uxhP9sc2KoWZNCPBtP09cO9525vPIHE/TFQIdjp7R6uF9LV9hre5soUG8jK96
         o6ULxGdnggxl5ILNqD9G4M9wi5nZj3MQ0airlnUTFwOu0cZV05DTjIYMnTm6YOuWCvwt
         KaHQ==
X-Gm-Message-State: AOJu0YzTM9EF2a071Aawzgl9V6bzVtoZNAGmqa+SfxbUu4jVAG3iR31D
	v4gsg1/X15HK504bfhtQVf3DWj8h6erN0Q==
X-Google-Smtp-Source: AGHT+IHU72x2P2ARSJrsYr/9PdegL2CIZ35HgbWVZhDOtO8cPofDfaOEFOG6SoWrOxrtPxpcGj8jCw==
X-Received: by 2002:a05:6820:613:b0:595:1c09:613a with SMTP id e19-20020a056820061300b005951c09613amr1158857oow.18.1703874555656;
        Fri, 29 Dec 2023 10:29:15 -0800 (PST)
Received: from [192.168.1.4] ([136.62.51.249])
        by smtp.gmail.com with ESMTPSA id i1-20020a4aab01000000b0058ad7b0b1a8sm3526791oon.13.2023.12.29.10.29.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Dec 2023 10:29:15 -0800 (PST)
Message-ID: <0879141d-462c-7e94-7c87-7a5b5422b8ed@landley.net>
Date: Fri, 29 Dec 2023 12:35:31 -0600
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3] rootfs: Fix support for rootfstype= when root= is
 given
Content-Language: en-US
To: Stefan Berger <stefanb@linux.ibm.com>, Askar Safin <safinaskar@gmail.com>
Cc: gregkh@linuxfoundation.org, initramfs@vger.kernel.org,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, zohar@linux.ibm.com
References: <CAPnZJGDcNwPLbzC99qNQ+bRMwxPU-Z0xe=TD6DWQU=0MNyeftA@mail.gmail.com>
 <d4b227de-d609-aef2-888b-203dbcf06707@landley.net>
 <CAPnZJGBeV-E_AN8GnTfkaJvRtBmCeMYYCt+O0XMsc3kDULRuKg@mail.gmail.com>
 <fb776d99-1956-4e1b-9afc-84f27ca40f46@linux.ibm.com>
From: Rob Landley <rob@landley.net>
In-Reply-To: <fb776d99-1956-4e1b-9afc-84f27ca40f46@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 12/29/23 10:39, Stefan Berger wrote:> On 12/21/23 17:58, Askar Safin wrote:
>> Hi, Rob. And Stefan.
>> 
>> First of all, this patch got to linux-next (
>> https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/log/?qt=author&q=Stefan+Berger
>> ), so it seems it soon will be in mainline.
>> 
>> On Thu, Dec 21, 2023 at 12:24 PM Rob Landley <rob@landley.net> wrote:
>>> Can you build tmpfs on a nommu system? Last I checked the plumbing expects swap,
>>> but it's been a while...
>> Okay, I agree, let's not remove ramfs.
>> 
>> Still, I don't like this (already applied) patch. init= and rdinit=
>> are two different options,

Because they control two different things which are often used at the same time.
(Debian has an initramfs that hands off to the final root filesystem, for
example. Hence the initramfs-tools package that runs every time apt-get updates
the kernel.)

So being able to specify rdinit= to intercept the ramfs layer or init= to
intercept the root= layer made sense, because they did different things.

But the only reason to specify anything nontrivial for the initramfs
_filesystem_ mount properties is because you intend to stay there. They don't
get used together.

>> and this is good.

Eh, not really. Strange legacy decision we're now stuck with. The kernel only
ever runs one init task per boot. If init= was _also_ checked to see which file
to run out of initramfs (and the plumbing still justs silently fails and moves
on if it's not found) then the debian script would have been forced to do INIT=
or similar to override the overmounted root's init task separately from initrd's
init task, making it clear a script (not the kernel) is making that decision.

But that would have been a user-visible change, and when initramfs was going in
they were trying to avoid user-visible changes that would force sysadmins to
learn new stuff because the plumbing changed out from under them. (Like the
change you're proposing now would.)

>> So, I think we should
>> have two different options. Analogously they should be rootfstype= and
>> rdrootfstype=.

You can't have a root= type of initramfs or tmpfs. The specified values can't
overlap. The plumbing I wrote responds to specific values but otherwise leaves
it for later users.

>> https://salsa.debian.org/kernel-team/initramfs-tools/-/blob/cf964bfb4362019fd7fba1e839e403ff950dca8e/init#L103
>> 
>> As you can see, this shell script parses /proc/cmdline and assumes
>> that rootfstype= always applies to real root.

The script is running _in_ the initramfs, which is already loaded and running at
that point. Meaning the _kernel_ will not parse root= at that point, userspace
has to do it.

>> So, if someone sets
>> rootfstype= to tmpfs or ramfs, this will likely break this script.

Which was the same 10 years ago?

The script is running in a context where initramfs is not persistent, so
overriding it to be a tmpfs has no benefit. (I mean you _can_... Nobody does,
because we're gonna switch_root off of it.)

And once code _is_ running in initramfs, the kernel's internal root= automounter
will never run. The initramfs code can parse /proc/cmdline to use the same
arguments as the kernel, or it could much more easily use the "any unrecognized
arguments get set as environment variables in PID 1" and use ROOT= or similar,
like many scripts do.

Modifying kernel code that NEVER RUNS in the case you're pointing out seems
silly to me.

That said, the code I wrote is doing a strstr to see if the argument's there,
but doesn't care what ELSE is there, so it could easily be
"rootfstype=tmpfs,ext4" and have the userspace script also filter the argument
for just what it's interested in, since at that point it's NOT THE KERNEL DOING IT.

> Setting the kernel boot command line option rootfstype= to tmpfs or 
> ramfs was possible so far and that's what the documentation and code 
> supported so far as well. The bug surfaced when root= was provided, in 
> which case it was ignored.

No, as I explained when I wrote the initmpfs code in 2013 when you say root= you
are explicitly requesting the kernel mount a second file system over rootfs
(that's what root= MEANS), and thus don't bother making it a (more expensive)
tmpfs because it's not sticking around.

I did that to NOT invent new arguments, and work with existing systems. The new
feature I added triggered when you _requested_ it.

>> Yes, this will slightly break compatibility. I. e. this will make
>> Linux always choose tmpfs if rdrootfstype= is not present. But I think
> 
> You may find someone who doesn't like this change, either, ...

Yeah, me.

>> there is nothing wrong with it. If a user cares, he will set
>> rdrootfstype= . And early boot code will become a lot more clean and
>> logical.
>> 
>> Rob, do you agree? Stefan, do you agree? Then I will write a patch,

I think it's a bad idea.

If a documentation change is needed, maybe clarify what root= means? That
argument explicitly requests the kernel mount a second filesystem over rootfs
after failing to launch init out of initramfs, so that rootfs will NOT be the /
visible to PID 1.

This is what it has ALWAYS meant. Back before initramfs was invented in the old
initrd days, you didn't need to say root= if you provided an initial ramdisk
with an init executable in it (except the old mechanism didn't want /init it
wanted /linuxrc for no apparent reason), and if you DID say root= when the
kernel launched PID 1 out of initrd the superfluous argument was ignored (never
parsed) because the kernel setup code never made it far enough to check it.

I also note that I never wired up "rootflags=" (see init/do_mounts.c
root_data_setup) so it gets passed through to initmpfs, meaning you can't
specify size= and thus it defaults to 50% of available memory as the enforced
limit. That would be actually useful. (And no I don't really care if it's the
original argument or a different one because it can't have any existing users to
break yet, although once again the kernel CAN'T do both at once so having two is
SILLY. The reason they're NOT wired up yet is ramfs takes no arguments, so only
passing rootflags to tmpfs when you didn't specify a root= or when you tell it
rootfstype=tmpfs makes sense, because then what you're passing better not be
ext4 arguments because you're staying on initramfs and the kernel's root=
plumbing doesn't run.)

That's the actual missing feature here.

Rob

