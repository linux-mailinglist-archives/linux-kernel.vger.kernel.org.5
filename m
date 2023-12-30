Return-Path: <linux-kernel+bounces-13516-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3A482078F
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 18:01:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 233761C2155A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Dec 2023 17:01:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA677BA34;
	Sat, 30 Dec 2023 17:01:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="iQgC0v0l"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oo1-f52.google.com (mail-oo1-f52.google.com [209.85.161.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3B18F71
	for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 17:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Received: by mail-oo1-f52.google.com with SMTP id 006d021491bc7-59552c93366so135685eaf.1
        for <linux-kernel@vger.kernel.org>; Sat, 30 Dec 2023 09:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1703955703; x=1704560503; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4QIcJTcmD+09gxsUfvwoVCUHhs5+yptu+2GvRucqwo0=;
        b=iQgC0v0lu9Q5bfQ9VDRPMuWBQ01QXu5mtgVnYRoOEiA98LpoYOSbwL9u3bIH5edRpb
         KXwqGPRkZO/CXQS0cIHU7HIatnlW+ElYb5F2HLozY2/2K9CycY6+qe9J84qutP9v7cs0
         jHdCIv/5iJ1Ng/sIVF8jUYIpCZXKZhw2t5na4o0Rvf6m/wg83IOUaq25VfKwBMQEKrg8
         vPdmuxqZRoY4rwFIYvxGe9vT7qi4wu5By8NZNSzfXuNueCs4RPsC+5vw/4rYtRWyiLpq
         6LQ1zAnvQL0Y1J6YMf6n+O8kvoBBJVOYu6ic5KoEC2dZvrNUs2JHg7XslM6o9LVHMAwI
         jyXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703955703; x=1704560503;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4QIcJTcmD+09gxsUfvwoVCUHhs5+yptu+2GvRucqwo0=;
        b=uwH3mGZ3hZ0RWDwqUxobacjpRX8sRrImCPEvKwP7gd364DGjHfZAtHlNFSMQ0Qbfal
         sOc76p/nMV5EsnJM9FT3P+eP+IWjx/XRy6BS0sAdZAELWtisJHZeYm4MG7x8BnLsY56w
         snVHfOfeL/9vqCW3q0DFNnAAqj9h/PJ0bBPmf6fju28w9FHXuj3SwamO3hAD9I5tYj+K
         v1RADlAynmG2w+WTQGqSmMWXQlOuhsnsECG5f2+UANWj9evxW1P9345wMRuCPm0Idcvv
         i6OjDnv2cxlFq0rB1eO4Lb5HDOVlJPBJdDWGHYHur/7uAAl8R6MrECrqsqfKX47Rt2ZP
         717Q==
X-Gm-Message-State: AOJu0YzOkdF2sF4QfewktiKWPsMjoBrXEdWRheGwdLRPbNWrxd5Crncr
	jvvEtftzN7T5xFs8CVJIVcdpT9dR8n32eg==
X-Google-Smtp-Source: AGHT+IEGhOexx/7YuiootqVoLurfMRFXGuHswtKgR9TBLjjG4ERErq/G04f90Q/j+7faT4PJnZmMjA==
X-Received: by 2002:a05:6820:1691:b0:58d:ac91:1dd0 with SMTP id bc17-20020a056820169100b0058dac911dd0mr6483989oob.9.1703955702953;
        Sat, 30 Dec 2023 09:01:42 -0800 (PST)
Received: from [192.168.1.4] ([136.62.51.249])
        by smtp.gmail.com with ESMTPSA id h123-20020a4a5e81000000b00595086848a8sm860674oob.16.2023.12.30.09.01.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 30 Dec 2023 09:01:42 -0800 (PST)
Message-ID: <fcb45898-0699-878f-0656-f570607fbed4@landley.net>
Date: Sat, 30 Dec 2023 11:08:00 -0600
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
 <0879141d-462c-7e94-7c87-7a5b5422b8ed@landley.net>
 <e32077de-b159-4a7b-89a3-e1925239142f@linux.ibm.com>
From: Rob Landley <rob@landley.net>
In-Reply-To: <e32077de-b159-4a7b-89a3-e1925239142f@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/29/23 13:14, Stefan Berger wrote:>> That said, the code I wrote is doing a
strstr to see if the argument's there,
>> but doesn't care what ELSE is there, so it could easily be
>> "rootfstype=tmpfs,ext4" and have the userspace script also filter the argument
>> for just what it's interested in, since at that point it's NOT THE KERNEL DOING IT.
> 
> It's a bit tricky that this particular option, that can support a 
> comma-separated list, is shared between kernel and user space and user 
> space does not already filter-out what is not relevant for it.

Debian's code sometimes has bugs, especially their initramfs stuff doesn't get a
lot of scrutiny:

https://lkml.iu.edu/hypermail/linux/kernel/1705.2/05611.html
https://lkml.iu.edu/hypermail/linux/kernel/1705.3/01182.html
https://lkml.org/lkml/2017/9/13/651#:~:text=Debian's

But they're pretty good about fixing bugs pointed out to them:

https://salsa.debian.org/kernel-team/initramfs-tools/-/commit/49e4a0555f51

The kernel having more capabilities here than Debian's userspace does isn't new,
it's what gives debian's userspace the opportunity to gain new capabilities.

Although in this case, the patch in question still isn't in lkml 5 years later
because Debian development is much more responsive than linux-kernel:

https://lkml.iu.edu/hypermail/linux/kernel/2302.2/05597.html

>>> Setting the kernel boot command line option rootfstype= to tmpfs or
>>> ramfs was possible so far and that's what the documentation and code
>>> supported so far as well. The bug surfaced when root= was provided, in
>>> which case it was ignored.
>> 
>> No, as I explained when I wrote the initmpfs code in 2013 when you say root= you
>> are explicitly requesting the kernel mount a second file system over rootfs
> 
> From the perspective of needing xattr support in initramfs it's 
> unfortunately not so obvious what the filesystem type of the kernel's 
> rootfs (presumably the 1st file system) has to do with the option given 
> for the 2nd filesystem. Though the Debian scripts are the bigger problem 
> it seems.

Ping Ben if initramfs-tools needs updating?

I've been following the initramfs xattr support threads forever:

https://lkml.iu.edu/hypermail/linux/kernel/2207.3/06939.html

I'm happy to add new format support to toybox cpio if anybody comes to an
agreement on what that should be, but last time there was "as long as we're here
32 bit timestamps" and "sparse file support could be" and various bikeshedding...

Was there a new thread I didn't get cc'd on? The last I have is... July 2022 I
think?

> However, for those one could argue that the Debian scripts 
> could be updated and for as long as they are not able to filter-out the 
> tmpfs or ramfs options we are interested in one cannot pass these 
> options or a comma-separated list on systems that run the current Debian 
> scripts.

You can argue that current userspace does not take full advantage of the
existing kernel API, sure.

>> (that's what root= MEANS), and thus don't bother making it a (more expensive)
>> tmpfs because it's not sticking around.
> 
> That's true unless you want to use IMA signature enforcement in the 
> initramfs already and tmpfs is now required.

I agree that if you want to add a new requirement, you may need to modify userspace.

Let me see if I understand your problem: it sounds like debian's initramfs-tools
overloads the root= and rootfstype= arguments parsed by the kernel to have a
second meaning (the kernel uses them for one thing, you want to use them for
something else, and there's currently a semantic gap between the two.)

You want to add a new capability requiring a new build dependency in the
initramfs-tools package because it's doing new stuff, but there cannot be any
OTHER changes made to initramfs-tools, so the kernel should change its existing
semantics instead.

You can't NOT provide root=, and you can't provide initramfstype=tmpfs...
either, and those are the two existing ways to tell rootfs to be tmpfs instead
of ramfs. You'd like to add a third way to specify the same thing.

Do I have that right?

>     Stefan

Rob

