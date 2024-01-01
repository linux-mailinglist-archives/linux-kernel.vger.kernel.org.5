Return-Path: <linux-kernel+bounces-13934-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C877C821506
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 19:44:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D7721F2176A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Jan 2024 18:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0C46CA4E;
	Mon,  1 Jan 2024 18:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="UdgpbZ0C"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f49.google.com (mail-ot1-f49.google.com [209.85.210.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC7FD51C
	for <linux-kernel@vger.kernel.org>; Mon,  1 Jan 2024 18:44:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Received: by mail-ot1-f49.google.com with SMTP id 46e09a7af769-6dbb7d80df8so6114322a34.1
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jan 2024 10:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1704134651; x=1704739451; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sjmXOhTctx42zOaMIsPFinaKFIHlr/ulkQ7Lu3BkB+w=;
        b=UdgpbZ0CL9BY45Pt+ewC0brwHYnSlpgkh8oNOXjVh66JyarN6aHMhr9wqTHf59cNsh
         NiFjXztRwN6yQiTcDmAHn2dDJaH7Fxu6XSyotPvaoHR2EX9nYtugc/k1YjstJ9mentbg
         doVa5/9853Wq8odtWXZLmbk0zkCl5MDRio9q5Tmf9JeHXtekiAIE+Xxo1If5VXEoLy52
         qyOBBqFKcmlHjKbGExANh21NHPy4IDxPViW3NIFZytSM4JPYsNO6ssWk1NdU4TSK4Q45
         SpDtg/CW9IwySsL5+iL8Mf0wFTLHWtTOPTXyQJL3XBi/nrxOOuUHytUuRru0eoPFeheV
         tg5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704134651; x=1704739451;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sjmXOhTctx42zOaMIsPFinaKFIHlr/ulkQ7Lu3BkB+w=;
        b=JdU5nyOAnsGeKAMRaWRVAN0g3fik248bMAv5su37nZaZEGw5GCHaixecoWfbcCIzaV
         ZfFlzJQoS1v9u3Q+KyU0gCs/RIElHAEgpg19AMbxg3nymXE7V/3PPugoghSlD7wgxG0C
         AtCAZ39ryEH77Y67neT8E8GQPxumugDkIvE6EEVKEZsZJlSuAgeUBOmTmcPUTHa8+yIh
         7vFET7EkMRSGcS3gfYU5RLkOnOsTlsC3UXCay8k3LKF1E6H48v1E9Zg7ljAckKkYYVcQ
         0Hie24gYsRTJGnEPgQizTjnTEhDXbhvvZ1O46phx2c/HXUV71OOXTK6m9BnKL2Hxr9S7
         UTzg==
X-Gm-Message-State: AOJu0YxsV+YGhiys5d6lAT2K9+GBdPEdeYuMUrG5hFNGccjOOl9+Ipxd
	Q13VjaIfIc9HSXdadJaiswkvusy78KOs2vOHU7rC7p8/p1g=
X-Google-Smtp-Source: AGHT+IEGggXhpHPG1W3qW7pdwlHgw/HZy7YXw6H/rODYtkG6/6okVpvuY9/RVCotfiLACdJliNmjpw==
X-Received: by 2002:a05:6830:12c6:b0:6dc:20e:a447 with SMTP id a6-20020a05683012c600b006dc020ea447mr6046580otq.25.1704134650809;
        Mon, 01 Jan 2024 10:44:10 -0800 (PST)
Received: from ?IPV6:2607:fb90:f21e:ce05:3ea9:f4ff:fe4b:aee8? ([2607:fb90:f21e:ce05:3ea9:f4ff:fe4b:aee8])
        by smtp.gmail.com with ESMTPSA id l35-20020a0568302b2300b006d9a339773csm1562495otv.27.2024.01.01.10.44.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jan 2024 10:44:10 -0800 (PST)
Message-ID: <01010fbc-50d9-37f3-309c-f01643865ed9@landley.net>
Date: Mon, 1 Jan 2024 12:50:31 -0600
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
 <fcb45898-0699-878f-0656-f570607fbed4@landley.net>
 <8b85253d-dd75-42e4-9a05-dafb3618269c@linux.ibm.com>
From: Rob Landley <rob@landley.net>
In-Reply-To: <8b85253d-dd75-42e4-9a05-dafb3618269c@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 12/31/23 10:03, Stefan Berger wrote:
>> Let me see if I understand your problem: it sounds like debian's initramfs-tools
>> overloads the root= and rootfstype= arguments parsed by the kernel to have a
>> second meaning (the kernel uses them for one thing, you want to use them for
>> something else, and there's currently a semantic gap between the two.)
> 
> My intention is to be able to pass rootfstype= to the kernel and have it 
> interpreted correctly in the presence of root=, which currently does not 
> work. User space tools that interpret the value of rootfstype= as if 
> this option belonged to user space is not helpful, though it should be 
> easy to teach the user space scripts to strip a leading 'tmpfs,' or 
> 'ramfs,' from the rootfstype value and let them interpret the rest.

Does your initramfs plumbing need to pass a rootfstype equivalent on to the
userspace mount at all? In what cases does it not autodetect the type correctly?

(Even NFS and SMB mounts are generally detectable because of the leading \\ or
blah: although I suppose there are other network filesystem types that wouldn't
be. Or if you wanted to micromanage the fat variant you were using...)

"rootfstype=" is the argument that tells the _kernel_ how to mount / and by the
time init runs the kernel's already mounted what it's going to mount. The kernel
only exposes one visible / mount to userspace, you don't return back into it and
get another init launched running in a different root filesystem.

>> You want to add a new capability requiring a new build dependency in the
>> initramfs-tools package because it's doing new stuff, but there cannot be any
>> OTHER changes made to initramfs-tools, so the kernel should change its existing
>> semantics instead.
> 
> I haven't even thought of what would need to be added to Debian's 
> initramfs-tools package since my primary goal was to enable tmpfs for 
> the initramfs on OpenBMC where we then read the xattr values from a file 
> and write them into the filesystem because cpio format doesn't carry 
> them.

Me, I'd have a simple initramfs extract/decrypt a tarball with the filesystem
that needs xattr values into a new tmpfs mount and switch_root to that. But I
tend to statically link an initramfs into the kernel image when I want to be
sure what it's running, and have never quite been clear on the benefit of
_additionally_ verifying data that originates from within the kernel image. (If
they can change that, they can change ring 0 code.)

Still, adding xattr support to cpio comes up a lot. It seems like a couple days
work tops, maybe the interested parties should do a video conference thingy,
hammer out the details, and come up with a patch to add support? The userspace
side sounds easy enough, I added xattr support to toybox tar in 2021 in a
weekend, and have sent "would you like to keep up with toybox" patches at the
busybox guys semi-regularly.

I even poked coreutils about feature parity once (the Android guys asked me to),
which they said they would like to add, but which but still isn't in years later:

https://lists.gnu.org/archive/html/coreutils/2023-08/msg00009.html
https://lists.gnu.org/archive/html/coreutils/2023-08/msg00100.html

But eh, I'm used to that with 30 year old projects licensed under copyleft...

> Also, I didn't expect that any user space tools would try to 
> handle a kernel command line option as if it was theirs.

Debian predates the 1.0 kernel release, so has some historical design baggage.
That's why it's I tend to check them for snags in this area.

>> You can't NOT provide root=, and you can't provide initramfstype=tmpfs...
> 
> I only know about rootfstype= ( 
> https://github.com/torvalds/linux/blob/master/init/do_mounts.c#L128 ). 
> If currently handling of rootfstype= in presence of root= is not 
> considered a bug and we should introduce initramfstype= instead, we 
> could do that. But doesn't this become a bit confusing if rootfstype= 
> can be passed when root= is absent but then initramfstype= must be used 
> when root= is present?

I personally think having two would be confusing, and changing the existing API
without adding new capabilities is pointless.

> This is 'our' patch describing the issue: 
> https://github.com/torvalds/linux/blob/master/init/do_mounts.c#L128
> 
>> either, and those are the two existing ways to tell rootfs to be tmpfs instead
>> of ramfs. You'd like to add a third way to specify the same thing.
> 
> Do you have a link to initramfstype= handling in kernel code?

No, it's never done that. There was a suggestion to do that earlier in this thread:

https://lkml.iu.edu/hypermail/linux/kernel/2312.2/07060.html

And I thought it was a bad idea. The submitter agreed it was a bad idea. (Over
the holidays I've haven't been paying close attention and threads tend to bleed
together, sorry. :)

The answer to my "do I have this right" question was, apparently, "no". I mixed
together what two different people wanted...

Rob

