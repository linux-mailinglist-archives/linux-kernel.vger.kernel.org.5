Return-Path: <linux-kernel+bounces-22250-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59F36829B6F
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:36:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6CDA01C22251
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 13:36:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 678084CDE6;
	Wed, 10 Jan 2024 13:34:05 +0000 (UTC)
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 134AB4CB52;
	Wed, 10 Jan 2024 13:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 2B0A7220B0;
	Wed, 10 Jan 2024 13:34:01 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4201013786;
	Wed, 10 Jan 2024 13:34:00 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id 5hiwDMicnmUSKwAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 10 Jan 2024 13:34:00 +0000
Date: Wed, 10 Jan 2024 14:33:58 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Rob Landley <rob@landley.net>
Cc: Cyril Hrubis <chrubis@suse.cz>,
	Geert Uytterhoeven <geert@linux-m68k.org>, ltp@lists.linux.it,
	Li Wang <liwang@redhat.com>,
	Andrea Cervesato <andrea.cervesato@suse.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Christophe Lyon <christophe.lyon@linaro.org>,
	linux-m68k@lists.linux-m68k.org, linux-kernel@vger.kernel.org,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	automated-testing@lists.yoctoproject.org, buildroot@buildroot.org,
	Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: Call for nommu LTP maintainer [was: Re: [PATCH 00/36] Remove
 UCLINUX from LTP]
Message-ID: <20240110133358.GB1698252@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki>
 <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik>
 <a3d7f5ae-56c6-9cd8-2cda-2d50d12be9c4@landley.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3d7f5ae-56c6-9cd8-2cda-2d50d12be9c4@landley.net>
X-Spam-Flag: NO
X-Spamd-Result: default: False [-4.00 / 50.00];
	 REPLY(-4.00)[]
X-Spam-Score: -4.00
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Rspamd-Queue-Id: 2B0A7220B0
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none

Hi Rob, all,

> On 1/8/24 03:03, Petr Vorel wrote:
> > Hi Rob, all,

> > [ Added Niklas Cassel, who is maintainer of qemu_riscv64_nommu_virt_defconfig in
> > buildroot ]

> Hi Niklas!

> >> Buildroot also apparently has an LTP package selectable in menuconfig:

> >> https://github.com/buildroot/buildroot/tree/master/package/ltp-testsuite

> >> But I haven't tried it...

> > I'm the maintainer of the LTP package in buildroot in my private time.
> > BTW I spent quite a lot of time fixing LTP (and some other system packages,
> > e.g. nfs-utils) compilation on some old legacy architectures reported via
> > http://autobuild.buildroot.net/ I've never used in the reality.
> > But I certainly don't have time to drive nommu support in my private time.
> > I don't even have an interest, I don't use any nommu device.

> I do, but I've never done much with LTP, and I have my hands full with toybox
> and mkroot already.

Understand.

> > Therefore nobody who is not involved in nommu will not find a time to support it
> > in LTP (support does not mean just to add the functionality to the new C API,
> > but run tests on nommu and fix failing bugs). I suppose nobody is paid to work
> > on nommu platforms, it would have to be a hobby project, right?

> A bunch of people are paid to work on nommu platforms, and I've worked with them
> a bunch, but none of them talk to linux-kernel. They find the culture toxic,
> insular, and categorically dismissive of their interests.

> For example, cortex-m is a large nommu platform on which vendors support Linux
> BSPs, but notice how page 8 of
> https://www.microsemi.com/document-portal/doc_view/132181-linux-cortex-m-users-manual
> points at a cross compiler toolchain from _2010_ and page 4 says they're booting
> a 2.6.33 kernel?

> I'm a bit weird in that I try to get CURRENT stuff to work on nommu, and a lot
> of people have been happy to consume my work, but getting any of them to post
> directly to linux-kernel is like pulling teeth.

Interesting, thanks for sharing this. BTW I'm not saying anybody is using nommu,
but I wonder if anybody really test it with LTP. And if yes, I wonder why we
don't have reports about tests broken in new API.

> > But as I said, if anybody from nommu decides to maintain it in LTP, I'll try to
> > support him in my free time (review patches, give advices). And if nobody
> > stands, this patchset which removes the support in the old API will be merged
> > after next LTP release (in the end of January).

> What does the API migration do? Is there a page on it ala OABI vs EABI in arm or
> something?

New C API is documented at our wiki: the API for using in the tests [1]
and the library itself [2]. (We also have shell API, but we can ignore it for
nommu.)

All files in lib/ directory which include tst_test.h are part of new C API. Main
file is lib/tst_test.c. LTP tests, which has been rewritten to new API include
tst_test.h, they are in testcases/ directory. Library has it's own tests (for
testing regression in in lib/newlib_tests/*.c.

The reason why Cyril wrote in 2016 new C API was that the old API was buggy
(tests randomly fails). Tests which are still using the old API (there is
ongoing rewrite) include test.h. The old API is not much documented.

Feel free to ask any more question.

Kind regards,
Petr

[1] https://github.com/linux-test-project/ltp/wiki/C-Test-API
[2] https://github.com/linux-test-project/ltp/tree/master/lib

> Rob

