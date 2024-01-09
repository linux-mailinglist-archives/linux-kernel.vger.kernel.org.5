Return-Path: <linux-kernel+bounces-21525-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 765748290C1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1484A1F277EE
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 062D63E479;
	Tue,  9 Jan 2024 23:17:57 +0000 (UTC)
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FB43DB80;
	Tue,  9 Jan 2024 23:17:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2313DC433C7;
	Tue,  9 Jan 2024 23:17:51 +0000 (UTC)
Message-ID: <461a6556-8f24-48f5-811a-498cb44f2d64@linux-m68k.org>
Date: Wed, 10 Jan 2024 09:17:48 +1000
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
From: Greg Ungerer <gerg@linux-m68k.org>
In-Reply-To: <a3d7f5ae-56c6-9cd8-2cda-2d50d12be9c4@landley.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 10/1/24 06:24, Rob Landley wrote:
> On 1/8/24 03:03, Petr Vorel wrote:
>> Hi Rob, all,
>>
>> [ Added Niklas Cassel, who is maintainer of qemu_riscv64_nommu_virt_defconfig in
>> buildroot ]
> 
> Hi Niklas!
> 
>>> Buildroot also apparently has an LTP package selectable in menuconfig:
>>
>>> https://github.com/buildroot/buildroot/tree/master/package/ltp-testsuite
>>
>>> But I haven't tried it...
>>
>> I'm the maintainer of the LTP package in buildroot in my private time.
>> BTW I spent quite a lot of time fixing LTP (and some other system packages,
>> e.g. nfs-utils) compilation on some old legacy architectures reported via
>> http://autobuild.buildroot.net/ I've never used in the reality.
>> But I certainly don't have time to drive nommu support in my private time.
>> I don't even have an interest, I don't use any nommu device.
> 
> I do, but I've never done much with LTP, and I have my hands full with toybox
> and mkroot already.
> 
>> Therefore nobody who is not involved in nommu will not find a time to support it
>> in LTP (support does not mean just to add the functionality to the new C API,
>> but run tests on nommu and fix failing bugs). I suppose nobody is paid to work
>> on nommu platforms, it would have to be a hobby project, right?
> 
> A bunch of people are paid to work on nommu platforms, and I've worked with them
> a bunch, but none of them talk to linux-kernel. They find the culture toxic,
> insular, and categorically dismissive of their interests.

I have been involved in the kernel nommu space for 20 years, and sure, there is
some of that. But mostly spending some time and effort to get involved pays off.
I have seen potential contributors show up with some arrogant attitudes too,
so it cuts both ways here.

The m68k community I have been part of has been nothing but welcoming. The mm
people have tried hard to keep nommu support up-to-date where almost none of them
actually have a vested interest in doing so.

What I have seen is that many companies working in this space just don't want
to spend the time and effort to go mainline. That is a business decision they
make, and that is fine. Heck my work in actual mainline has never really been
paid for by any company and I have sunk a _lot_ of time into it. (Full disclosure
I did get paid to work on early porting and support - just not geting it into
mainline and maintain it there).


> For example, cortex-m is a large nommu platform on which vendors support Linux
> BSPs, but notice how page 8 of
> https://www.microsemi.com/document-portal/doc_view/132181-linux-cortex-m-users-manual
> points at a cross compiler toolchain from _2010_ and page 4 says they're booting
> a 2.6.33 kernel?

Any company/person who follows the route of not working with the linux kernel
community to get their work included is going to inevitably get stuck on older
versions of everything.


> I'm a bit weird in that I try to get CURRENT stuff to work on nommu, and a lot
> of people have been happy to consume my work, but getting any of them to post
> directly to linux-kernel is like pulling teeth.

I regularly test nommu configurations (as in every kernel rc and release) on m68k
and at least every release on other architectures like arm(*) and recently on
riscv as well.

(*) somewhat annoyingly needing a minor patch to run the versatile qemu platform
     I like to test with. But hey, that is on me :-)

Regards
Greg



>> But as I said, if anybody from nommu decides to maintain it in LTP, I'll try to
>> support him in my free time (review patches, give advices). And if nobody
>> stands, this patchset which removes the support in the old API will be merged
>> after next LTP release (in the end of January).
> 
> What does the API migration do? Is there a page on it ala OABI vs EABI in arm or
> something?
> 
> Rob

