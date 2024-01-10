Return-Path: <linux-kernel+bounces-22852-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D00082A3FC
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 23:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 06FCE285BE6
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 22:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D5BC4F89C;
	Wed, 10 Jan 2024 22:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QkQWgqz9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5HYw1OMB";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="QkQWgqz9";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5HYw1OMB"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF7AD4F888;
	Wed, 10 Jan 2024 22:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 3CC431F8D6;
	Wed, 10 Jan 2024 22:32:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704926000;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dsmcv/m++OLLdvBOu4juiHQKcxC0cbZOXjWtk4fZ1Lw=;
	b=QkQWgqz9NjnfgXPVYQcoX+4SPrI7JDaq9ZrREmAxylHoT24zOJZQtyEKmNsfJgNYbQQZ5z
	BdEcBF4Qcil5Onp+ryTczBatY7VQwdWWjUcprwfFYhAJ4jzB6MwV3fQh2egK6/xelDE21u
	Cr3GObjh2Eell5VYCP+WcfysVxuuKeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704926000;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dsmcv/m++OLLdvBOu4juiHQKcxC0cbZOXjWtk4fZ1Lw=;
	b=5HYw1OMBCSBUpNbDqkpWvOZdJgexcKFKN5UAD8NVzy49GQW7do2s5UpMyt8yvM2eJT2aRl
	2FVvxrr+YrHrmYAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704926000;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dsmcv/m++OLLdvBOu4juiHQKcxC0cbZOXjWtk4fZ1Lw=;
	b=QkQWgqz9NjnfgXPVYQcoX+4SPrI7JDaq9ZrREmAxylHoT24zOJZQtyEKmNsfJgNYbQQZ5z
	BdEcBF4Qcil5Onp+ryTczBatY7VQwdWWjUcprwfFYhAJ4jzB6MwV3fQh2egK6/xelDE21u
	Cr3GObjh2Eell5VYCP+WcfysVxuuKeA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704926000;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Dsmcv/m++OLLdvBOu4juiHQKcxC0cbZOXjWtk4fZ1Lw=;
	b=5HYw1OMBCSBUpNbDqkpWvOZdJgexcKFKN5UAD8NVzy49GQW7do2s5UpMyt8yvM2eJT2aRl
	2FVvxrr+YrHrmYAw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E127139C6;
	Wed, 10 Jan 2024 22:32:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id Sph8EeMan2VQQQAAn2gu4w
	(envelope-from <pvorel@suse.cz>); Wed, 10 Jan 2024 22:32:03 +0000
Date: Wed, 10 Jan 2024 23:33:32 +0100
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
Message-ID: <20240110223332.GA1797182@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki>
 <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik>
 <a3d7f5ae-56c6-9cd8-2cda-2d50d12be9c4@landley.net>
 <20240110133358.GB1698252@pevik>
 <c065bbb0-e5cb-04ae-cedc-258264162405@landley.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c065bbb0-e5cb-04ae-cedc-258264162405@landley.net>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[gnu.org:url];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

> On 1/10/24 07:33, Petr Vorel wrote:
> >> I'm a bit weird in that I try to get CURRENT stuff to work on nommu, and a lot
> >> of people have been happy to consume my work, but getting any of them to post
> >> directly to linux-kernel is like pulling teeth.

> > Interesting, thanks for sharing this. BTW I'm not saying anybody is using nommu,
> > but I wonder if anybody really test it with LTP. And if yes, I wonder why we
> > don't have reports about tests broken in new API.

> I don't expect a lot of nommu users are aware you ever _could_ run LTP on nommu.

> But I'd like to get nommu more regularly supported. You _should_ be able to
> build a musl-linux userspace with busybox or toybox and be able to build a
> recognizable system (even an alpine-alike) which could then get the basic
> plumbing regression tested on qemu even without access to nommu hardware.

> >> > But as I said, if anybody from nommu decides to maintain it in LTP, I'll try to
> >> > support him in my free time (review patches, give advices). And if nobody
> >> > stands, this patchset which removes the support in the old API will be merged
> >> > after next LTP release (in the end of January).

> >> What does the API migration do? Is there a page on it ala OABI vs EABI in arm or
> >> something?

> > New C API is documented at our wiki: the API for using in the tests [1]
> > and the library itself [2]. (We also have shell API, but we can ignore it for
> > nommu.)

> I'm writing a bash-compatible shell, which (thanks to Elliott forwarding
> questions) has involved surprisingly long threads with the bash maintainer about
> weird corner cases neither the man page nor my testing made clear:

> http://lists.landley.net/pipermail/toybox-landley.net/2023-July/029631.html

> (Alas I try NOT to involve him because when I bring stuff up he keeps FIXING
> BASH which from my point of view just makes it a moving target...)

> Anyway, running the shell API on nommu doesn't seem out of the question, but
> probably not any time soon. (The fact the shell isn't finished yet is one of the
> big REASONS I haven't got enough time to take on LTP. That and I haven't started
> writing "awk" and "make" yet". And I need to cycle back to
> https://landley.net/notes-2023.html#12-10-2023 . And after that debian, ala
> https://peertube.debian.social/w/chzkKrMvEczG7qQyjbMKPr and
> https://peertube.debian.social/w/45XroN9CnbYLNLKQH3GD9F . And follow up on
> https://lists.gnu.org/archive/html/coreutils/2023-08/msg00009.html . And...)

> > All files in lib/ directory which include tst_test.h are part of new C API. Main
> > file is lib/tst_test.c.

> safe_fork(), safe_clone(), fork_testrun()...

> > LTP tests, which has been rewritten to new API include
> > tst_test.h, they are in testcases/ directory. Library has it's own tests (for
> > testing regression in in lib/newlib_tests/*.c.

> Library meaning... libc? Or does LTP have a library?

Yes, LTP has a library (lib/libltp.a). That's what I meant here and in all my
text. So far I did not mention anything libc specific.

> > The reason why Cyril wrote in 2016 new C API was that the old API was buggy
> > (tests randomly fails). Tests which are still using the old API (there is
> > ongoing rewrite) include test.h. The old API is not much documented.

> > Feel free to ask any more question.

> My standard questions are "what does success look like" and "how do I reproduce
> the problem".

> For the first: if there previously was nommu support in LTP, what's the last
> version that's known to work? Is there an existing build/test setup that can be
> reproduced?

I have no idea whether it worked. Best would be to ask Mike Frysinger (the
author of m4/ltp-nommu-linux.m4). The code was added 14 years ago, even before
all of the current maintainers were involved.

> For the second... If I try to run LTP on sh2eb (my current nommu test board)
> with the current LTP... do I get a build break? Additional test failures at
> runtime? You talk about "removing nommu support", but... what's the current
> status? (A subset of tests still use the old api...?)

Yes, subset of the tests which use the old API (git grep UCLINUX).

> Yes I need to read https://github.com/linux-test-project/ltp/wiki/C-Test-API but
> I also need to know how to build LTP from source. I'm looking at the README's
> list of "autoconf, automake, m4, pkgconf / pkg-config" and wincing
> significantly. (What does gnu/autoconf DO here? Disable tests? I never
> understand why anybody uses that giant hairball of complexity. Half of cross
> compiling is figuring out how to lie to autoconf, and my normal workaround for
> that is to bootstrap a target system and build natively, but while I've gotten
> gcc to run natively on nommu systems, I never _tried_ gnu/autoconf.
> Bootstrapping some subset of LFS on a nommu system so it has the dependencies
> LFS needs to natively build seems like the long way 'round...

Well, one day we might migrate to use something else (meson?), but until then
autoconf + m4 + pkgconf is used (instead of automake there is LTP custom
system). This was written in 2009 and nobody plans to change it (well, Andrea
played with meson [1] [2]). But we got far away from the original topic :).

Kind regards,
Petr

[1] https://github.com/acerv/ltp-core
[2] https://github.com/acerv/ltp-testcases


> (I am not the right guy for "make it work the easy way". I am the guy who will
> step on every land mine between here and there. I code by debugging an empty
> screen. If I don't start from "known working" setup... it would take a while.)

> Rob

