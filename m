Return-Path: <linux-kernel+bounces-22371-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 49CB5829CC7
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6D6501C2190E
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AA6F4B5D4;
	Wed, 10 Jan 2024 14:46:42 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39538EC2;
	Wed, 10 Jan 2024 14:46:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0237C433F1;
	Wed, 10 Jan 2024 14:46:37 +0000 (UTC)
Message-ID: <aef3568c-7894-49c9-a7aa-b3c58b822b91@linux-m68k.org>
Date: Thu, 11 Jan 2024 00:46:35 +1000
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Call for nommu LTP maintainer [was: Re: [PATCH 00/36] Remove
 UCLINUX from LTP]
Content-Language: en-US
To: Rob Landley <rob@landley.net>, Petr Vorel <pvorel@suse.cz>
Cc: Cyril Hrubis <chrubis@suse.cz>, Geert Uytterhoeven
 <geert@linux-m68k.org>, ltp@lists.linux.it, Li Wang <liwang@redhat.com>,
 Andrea Cervesato <andrea.cervesato@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Randy Dunlap <rdunlap@infradead.org>,
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
 <461a6556-8f24-48f5-811a-498cb44f2d64@linux-m68k.org>
 <b3a8b9db-86ee-47c6-96e2-baa2cba61404@landley.net>
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <b3a8b9db-86ee-47c6-96e2-baa2cba61404@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/1/24 15:47, Rob Landley wrote:
> On 1/9/24 17:17, Greg Ungerer wrote:
>> On 10/1/24 06:24, Rob Landley wrote:
>>> I'm a bit weird in that I try to get CURRENT stuff to work on nommu, and a lot
>>> of people have been happy to consume my work, but getting any of them to post
>>> directly to linux-kernel is like pulling teeth.
>>
>> I regularly test nommu configurations (as in every kernel rc and release) on m68k
>> and at least every release on other architectures like arm(*) and recently on
>> riscv as well.
> 
> Sigh, I should start caring about riscv. I added or1k support, I should do
> riscv. (Except I did or1k because I found it in actual hardware, the Orange Pi
> 3b's power controller is an or1k asic so I needed an or1k toolchain to build
> some of u-boot's firmware or else the board couldn't reboot, and there was a
> qemu-system-or1k already, which turned into adding it to mkroot via a long
> https://lore.kernel.org/openrisc/ZX1xbs_AGdgLgcx7@antec/ thread with its
> developers. Alas I still can't get qemu to exit (I.E. virtually reboot or power
> off), apparently I need to reinstall my laptop to have a new enough version of
> python 3 to build a newer qemu with. It's on the todo list...)
> 
> I still have a hard time considering riscv anything other than open source's
> version of Itanium. Promises of ubiquity, but even a 28 nanometer mask is still
> 6 figures before you run any wafers and your mask build process is sucking in
> all the black box libraries the fab can sell you, so what does "open" really get
> you here? Cortex-m got cheap when the superh patents expired so Arm didn't have
> to pay royalties to hitachi (renesas?) for the thumb instruction set anymore,
> and they belt those suckers en masse amortizing the up-front costs over ENORMOUS
> volume.
> 
> And yes, j-core was trying to fix the closed source library and toolchain issues
> back when I was still working with them. Among other things fishing
> Google/skywater's openlane toolchain build out of their magic docker and
> reproducing it under a vanilla debootstrap, ala
> https://github.com/j-core/openlane-vhdl-build (As with most corporate
> clusterfscks, once you dig far enough it turns out you can throw over 90% of it
> out...)
> 
> But these days I'm trying to get toybox to 1.0...
> 
>> (*) somewhat annoyingly needing a minor patch to run the versatile qemu platform
>>       I like to test with. But hey, that is on me :-)
> 
> I would very much like to add more nommu targets to mkroot, can I get your
> build/config info offline? (I tried fishing configs out of buildroot a couple
> years ago, but after the THIRD one where the secret was "use very old versions
> of packages, the current stuff is broken"... And the problems were things like
> "the conversion to device tree deleted a huge chunk of this infrastructure", not
> simple fixes.)

Maybe getting a little off-topic here, but I'll just send links here.
Who knows it might be useful to others.

Recently I have been experimenting with minimal builds, this is a bunch of
scripts, configs and a couple of patches I currently have:

     https://github.com/gregungerer/simple-linux

Mostly the kernel builds use the architecture defconfigs, but for armnommu
versatile it was easier to use a dedicated config and patch:

     https://github.com/gregungerer/simple-linux/blob/master/configs/linux-6.6-armnommu-versatile.config
     https://github.com/gregungerer/simple-linux/blob/master/patches/linux-6.6-armnommu-versatile.patch

Anyway the scripting uses the newest package versions of everything
(binutils, gcc, linux, uClibc, busybox).

Regards
Greg



