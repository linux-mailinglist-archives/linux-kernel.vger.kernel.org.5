Return-Path: <linux-kernel+bounces-19236-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ED775826A1E
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 10:04:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 763541F25B18
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 09:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8278512B84;
	Mon,  8 Jan 2024 09:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="JNPK2oVp";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="5WA0tnyj";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="gBdMRmm2";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="1+SFhyyc"
X-Original-To: linux-kernel@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1C5012B68;
	Mon,  8 Jan 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id F05A621DDA;
	Mon,  8 Jan 2024 09:03:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704704626;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m4Xh0t3rzxdhxIIt83BuRXIVZyt/UJX75ymAv70NJMk=;
	b=JNPK2oVpBIaxy1jMovlfy95ZToP3Qn2NfXsLaphJqGIf2q+4W3nLYoW1gD2HpZdCsjKosl
	t/kYNWa3n+vlzNvH3852QCoTTKCBYsUdxErHLGolW/WGMzksSRoWxSkXGpL4g+bdPmr0j/
	fX8y+seZe6tZkW0eW47vS82cN1wQGYQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704704626;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m4Xh0t3rzxdhxIIt83BuRXIVZyt/UJX75ymAv70NJMk=;
	b=5WA0tnyjSd/52uOjktQ6ZPJ3oZhhPA7qvVXa36UBSxKBUNUKkuxpki2yiS1ZVgYhQMWlnf
	K5IXVSGG2Xis2SAQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704704624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m4Xh0t3rzxdhxIIt83BuRXIVZyt/UJX75ymAv70NJMk=;
	b=gBdMRmm2/jRyJwLE2bPW4AO1FtdWAjMGhdizG09CuM+oQ2sVq7FSVvytmBAD/N3wsIM/p1
	l9O7J1h4xzgCzXrJzfHBonzjFW+MummDvJrLngTu7yRC4aGubysdhDe5jlW9KA0BKNWYk1
	LEPCzs4pjYfLUEXmUT/CQ3/HRuTDIWI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704704624;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m4Xh0t3rzxdhxIIt83BuRXIVZyt/UJX75ymAv70NJMk=;
	b=1+SFhyyc6SNeox6a4FFnhvNQaA7YuroPRYTsnVbpjnzUoJmSZka+BzlEY6sE3/3CJH75VN
	ZByRBgLwaf1BA8Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 4E87113496;
	Mon,  8 Jan 2024 09:03:44 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id LQbPEXC6m2WjCQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Mon, 08 Jan 2024 09:03:44 +0000
Date: Mon, 8 Jan 2024 10:03:38 +0100
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
Message-ID: <20240108090338.GA1552643@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20240103015240.1065284-1-pvorel@suse.cz>
 <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki>
 <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
X-Spam-Level: 
Authentication-Results: smtp-out1.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -3.50
X-Spamd-Result: default: False [-3.50 / 50.00];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 TO_DN_SOME(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 BAYES_HAM(-3.00)[100.00%];
	 ARC_NA(0.00)[];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 NEURAL_HAM_LONG(-1.00)[-1.000];
	 MIME_GOOD(-0.10)[text/plain];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 RCPT_COUNT_TWELVE(0.00)[19];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[]
X-Spam-Flag: NO

Hi Rob, all,

[ Added Niklas Cassel, who is maintainer of qemu_riscv64_nommu_virt_defconfig in
buildroot ]

> On 1/5/24 07:11, Petr Vorel wrote:
> >> Nobody is maintaining "uclinux" because that was a distro, but you can build
> >> nommu support in buildroot and such, and people do.

> > Right, there are nommu users. Will anybody join LTP development to maintain
> > nommu support in LTP? The needed work is to add this support to LTP new C API
> > [1] and use it in the relevant test. There is some implementation in the old
> > API, I have no idea how well it worked.

> > If nobody stands for maintaing nommu, we will have to delete it. There is nobody
> > from the current maintainers who is using LTP on nommu HW (that is the reason why
> > nommu support have not been implemented in the new API).

> I'm interested, but overwhelmed. Not sure I've got the spoons to come up to
> speed on a new project and give it regular attention just now.

> I see you cc'd buildroot (although the message might not go through if you
> aren't subscribed, dunno how clogged their moderation queue is these days, and
> the cc: list is long enough it might twig anyway). They had a nommu fix go in
> earlier this week (commit 98684ba7885b).

> That said, qemu supports several nommu platforms and buildroot has defconfigs to
> build systems for them:

> $ git clone git://buildroot.org/buildroot
> $ make help
> $ make list-defconfigs | grep qemu
> $ make qemu_ppc_bamboo_defconfig
> $ make
>   (time passes...)
> >>> host-gettext-tiny 0.3.2 Extracting
> gzip -d -c
> /home/landley/buildroot/buildroot/dl/gettext-tiny/gettext-tiny-0.3.2.tar.gz |
> tar --strip-components=1 -C
> /home/landley/buildroot/buildroot/output/build/host-gettext-tiny-0.3.2   -xf -
> mkdir -p
> /home/landley/buildroot/buildroot/output/build/host-gettext-tiny-0.3.2/gettext-gnu
> xzcat /home/landley/buildroot/buildroot/dl/gettext-tiny/gettext-0.22.4.tar.xz |
> tar --strip-components=1 -C
> /home/landley/buildroot/buildroot/output/build/host-gettext-tiny-0.3.2/gettext-gnu
>  -xf -
> xzcat: /home/landley/buildroot/buildroot/dl/gettext-tiny/gettext-0.22.4.tar.xz:
> No such file or directory
> tar: This does not look like a tar archive
> tar: Exiting with failure status due to previous errors
> make: *** [package/pkg-generic.mk:209:
> /home/landley/buildroot/buildroot/output/build/host-gettext-tiny-0.3.2/.stamp_extracted]
> Error 2


> Sigh, never build git pull du jour of anything, buildroot's having glitch du
> jour. But the point is:

> $ grep -rl bamboo board/
> board/qemu/ppc-bamboo/readme.txt
> $ cat board/qemu/ppc-bamboo/readme.txt
> Run the emulation with:

> qemu-system-ppc -nographic -M bamboo -kernel output/images/vmlinux -net
> nic,model=virtio-net-pci -net user # qemu_ppc_bamboo_defconfig

> The login prompt will appear in the terminal that started Qemu
> -------------------

> In THEORY, once it builds an image (presumably using a tagged release version
> rather than expecting "continuous integration" to ever mean anything) you should
> be able to launch it with qemu. Assuming the instructions aren't also
> bit-rotted. (Or using one of the other nommu boards, I haven't gone through the
> whole list to see what they've got. I used to use a nommu arm board, but the
> linux kernel broke it when converting everything to device tree and not
> regression testing it.)

> Buildroot also apparently has an LTP package selectable in menuconfig:

> https://github.com/buildroot/buildroot/tree/master/package/ltp-testsuite

> But I haven't tried it...

I'm the maintainer of the LTP package in buildroot in my private time.
BTW I spent quite a lot of time fixing LTP (and some other system packages,
e.g. nfs-utils) compilation on some old legacy architectures reported via
http://autobuild.buildroot.net/ I've never used in the reality.
But I certainly don't have time to drive nommu support in my private time.
I don't even have an interest, I don't use any nommu device.

And I would not justify to work on nommu in my working paid by SUSE, because
that's not a platform SUSE uses. Lack of resources means that there is a vast
majority of new kernel functionality not being tested. Also with very small
resources it's hard to even fix existing tests broken by changed functionality
in each mainline kernel release.

Therefore nobody who is not involved in nommu will not find a time to support it
in LTP (support does not mean just to add the functionality to the new C API,
but run tests on nommu and fix failing bugs). I suppose nobody is paid to work
on nommu platforms, it would have to be a hobby project, right?

But as I said, if anybody from nommu decides to maintain it in LTP, I'll try to
support him in my free time (review patches, give advices). And if nobody
stands, this patchset which removes the support in the old API will be merged
after next LTP release (in the end of January).

Kind regards,
Petr

> Rob

> P.S. I automate qemu testing all the time over in toybox, see testroot.sh under
> https://github.com/landley/toybox/tree/master/mkroot for an example.

