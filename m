Return-Path: <linux-kernel+bounces-21384-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C51B0828E6F
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 21:17:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746C1285FE6
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 20:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E52E3D969;
	Tue,  9 Jan 2024 20:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=landley-net.20230601.gappssmtp.com header.i=@landley-net.20230601.gappssmtp.com header.b="V6uUpAPN"
Received: from mail-io1-f46.google.com (mail-io1-f46.google.com [209.85.166.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283F23D962
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 20:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=landley.net
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=landley.net
Received: by mail-io1-f46.google.com with SMTP id ca18e2360f4ac-7bee3761bb4so36970439f.0
        for <linux-kernel@vger.kernel.org>; Tue, 09 Jan 2024 12:17:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=landley-net.20230601.gappssmtp.com; s=20230601; t=1704831465; x=1705436265; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zvygCsnAZQSUX1OyBrWi0tyZLEH0CAk1fXUh+ZaJ3Lo=;
        b=V6uUpAPN4uvL9v4m6KS3io6GQ4KJl/bVbOf/wTiGg8faPmhxgffs5YUP71+KavZN3p
         iCTExOw14otoEx2QKRQ7GMWRN99onikdcVxXO+lHbBITaqOUYTDkhohy27kUAD6U/9Oe
         pD7xRy5H2s9QSZqGM1AFAPIPsq+hG4Fu7WGcFpxV2RyTX3Brjjqib4UW4fOKus45htZ1
         M0WM6Izr7vv/Sf1IM/z3nwYW6zqXp76JRxweIR67Ulm7HlMo1dWVbJSyNfnG5iqsiyMy
         znZ7R0ljiOIdmyH++EGTcZJD/r1LMI0Vu7QgmOBJ0cDodf+V7it3+NX384WUIkLvPFkr
         nxJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704831465; x=1705436265;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zvygCsnAZQSUX1OyBrWi0tyZLEH0CAk1fXUh+ZaJ3Lo=;
        b=eyZtnCbLfxtQ2Snme5vX6nOwaQ4piUHmlHkVTsmIpRkXsElU4SKBOJJ92/QoQCAv8q
         1jWylmDVpMm3Jhj4o3zsF4S5gYQzwBL4iBARwfIqwOJmvpYv8rI1VZfgKJ/rGZaFNlwC
         LRmP7f1LO2kiy6af4OTnDMHNh5giIdgwGCb4czmJC2AHU5L2rMXMTMYsvGItRBsGDvyh
         7qonjb9T0OCFWpnCuYrjErYNd7x38hO/KVG+YStOh6X/EzFE6yQkpShtKWFMQz8SFV9D
         BeClq+SMjxxeqLD6N5rzHY+H/4u9ifxegqOE4nmctSpSNwz2JPHF349/f5aRLcxhbMn0
         Wu6g==
X-Gm-Message-State: AOJu0YxZSImGBL/g+pwgVnFBCZellpZBxi7B+pO4BLmuiYhfDlPybakn
	Q0Uo1zsXz84B2eGFT89U5sezSIjhBFAOhQ==
X-Google-Smtp-Source: AGHT+IHJDeszorYY5GFrmlMsgPhnGqSSgFTpBWcziFxtkUG5t0gPVrqEY0fdimh0r8UPafEYZce6pw==
X-Received: by 2002:a6b:7e08:0:b0:7bc:4215:da28 with SMTP id i8-20020a6b7e08000000b007bc4215da28mr5504732iom.42.1704831465186;
        Tue, 09 Jan 2024 12:17:45 -0800 (PST)
Received: from [172.16.32.83] ([198.232.126.202])
        by smtp.gmail.com with ESMTPSA id q5-20020a02a305000000b0046e4506fa75sm13527jai.26.2024.01.09.12.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Jan 2024 12:17:44 -0800 (PST)
Message-ID: <a3d7f5ae-56c6-9cd8-2cda-2d50d12be9c4@landley.net>
Date: Tue, 9 Jan 2024 14:24:22 -0600
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
From: Rob Landley <rob@landley.net>
In-Reply-To: <20240108090338.GA1552643@pevik>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/8/24 03:03, Petr Vorel wrote:
> Hi Rob, all,
> 
> [ Added Niklas Cassel, who is maintainer of qemu_riscv64_nommu_virt_defconfig in
> buildroot ]

Hi Niklas!

>> Buildroot also apparently has an LTP package selectable in menuconfig:
> 
>> https://github.com/buildroot/buildroot/tree/master/package/ltp-testsuite
> 
>> But I haven't tried it...
> 
> I'm the maintainer of the LTP package in buildroot in my private time.
> BTW I spent quite a lot of time fixing LTP (and some other system packages,
> e.g. nfs-utils) compilation on some old legacy architectures reported via
> http://autobuild.buildroot.net/ I've never used in the reality.
> But I certainly don't have time to drive nommu support in my private time.
> I don't even have an interest, I don't use any nommu device.

I do, but I've never done much with LTP, and I have my hands full with toybox
and mkroot already.

> Therefore nobody who is not involved in nommu will not find a time to support it
> in LTP (support does not mean just to add the functionality to the new C API,
> but run tests on nommu and fix failing bugs). I suppose nobody is paid to work
> on nommu platforms, it would have to be a hobby project, right?

A bunch of people are paid to work on nommu platforms, and I've worked with them
a bunch, but none of them talk to linux-kernel. They find the culture toxic,
insular, and categorically dismissive of their interests.

For example, cortex-m is a large nommu platform on which vendors support Linux
BSPs, but notice how page 8 of
https://www.microsemi.com/document-portal/doc_view/132181-linux-cortex-m-users-manual
points at a cross compiler toolchain from _2010_ and page 4 says they're booting
a 2.6.33 kernel?

I'm a bit weird in that I try to get CURRENT stuff to work on nommu, and a lot
of people have been happy to consume my work, but getting any of them to post
directly to linux-kernel is like pulling teeth.

> But as I said, if anybody from nommu decides to maintain it in LTP, I'll try to
> support him in my free time (review patches, give advices). And if nobody
> stands, this patchset which removes the support in the old API will be merged
> after next LTP release (in the end of January).

What does the API migration do? Is there a page on it ala OABI vs EABI in arm or
something?

Rob

