Return-Path: <linux-kernel+bounces-22338-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F556829C58
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:18:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94233B282A9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:17:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BE1D4D593;
	Wed, 10 Jan 2024 14:15:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="axywVzU0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OxbBVAmg";
	dkim=pass (1024-bit key) header.d=suse.cz header.i=@suse.cz header.b="axywVzU0";
	dkim=permerror (0-bit key) header.d=suse.cz header.i=@suse.cz header.b="OxbBVAmg"
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A82B4D113;
	Wed, 10 Jan 2024 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=suse.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.cz
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id 2EA9C1FD4F;
	Wed, 10 Jan 2024 14:14:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704896097;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l+y97negwruEwGRvrpJNRJsVcpzY8X3VX6VhDUdV1Xc=;
	b=axywVzU0qfXkI0dwkXp2+fXubEDIJhi6loKe7hEmkc3ShqFyIvVAs/4GU9OXR9+MUbmWzQ
	2Tjc6bYN7j0JXrPmpJlypsM8+wRYVei7aFYxlVp9XL8o094G3ziXurTe67oDaIH20b8tNc
	L+r6nB9M6mb8qw+JGCfsXpLURskFp6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704896097;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l+y97negwruEwGRvrpJNRJsVcpzY8X3VX6VhDUdV1Xc=;
	b=OxbBVAmgoTmOcYfw7uE2vG0Xe/o4jWPGi3hB1LW68Qe2hl8mffzjDJMGzDWV4/zabNp1G0
	YUh1dz1o7sXtlCAA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
	t=1704896097;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l+y97negwruEwGRvrpJNRJsVcpzY8X3VX6VhDUdV1Xc=;
	b=axywVzU0qfXkI0dwkXp2+fXubEDIJhi6loKe7hEmkc3ShqFyIvVAs/4GU9OXR9+MUbmWzQ
	2Tjc6bYN7j0JXrPmpJlypsM8+wRYVei7aFYxlVp9XL8o094G3ziXurTe67oDaIH20b8tNc
	L+r6nB9M6mb8qw+JGCfsXpLURskFp6g=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
	s=susede2_ed25519; t=1704896097;
	h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=l+y97negwruEwGRvrpJNRJsVcpzY8X3VX6VhDUdV1Xc=;
	b=OxbBVAmgoTmOcYfw7uE2vG0Xe/o4jWPGi3hB1LW68Qe2hl8mffzjDJMGzDWV4/zabNp1G0
	YUh1dz1o7sXtlCAA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 90FFF1398A;
	Wed, 10 Jan 2024 14:14:56 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id +XwGIWCmnmUgcQAAD6G6ig
	(envelope-from <pvorel@suse.cz>); Wed, 10 Jan 2024 14:14:56 +0000
Date: Wed, 10 Jan 2024 15:14:55 +0100
From: Petr Vorel <pvorel@suse.cz>
To: Tim Bird <tim.bird@sony.com>
Cc: Cyril Hrubis <chrubis@suse.cz>, Rob Landley <rob@landley.net>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	"ltp@lists.linux.it" <ltp@lists.linux.it>,
	Li Wang <liwang@redhat.com>,
	Andrea Cervesato <andrea.cervesato@suse.com>,
	Greg Ungerer <gerg@linux-m68k.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Randy Dunlap <rdunlap@infradead.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Christophe Lyon <christophe.lyon@linaro.org>,
	"linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Linux ARM <linux-arm-kernel@lists.infradead.org>,
	linux-riscv <linux-riscv@lists.infradead.org>,
	Linux-sh list <linux-sh@vger.kernel.org>,
	"automated-testing@lists.yoctoproject.org" <automated-testing@lists.yoctoproject.org>,
	"buildroot@buildroot.org" <buildroot@buildroot.org>,
	Niklas Cassel <niklas.cassel@wdc.com>
Subject: Re: [Automated-testing] Call for nommu LTP maintainer [was: Re:
 [PATCH 00/36] Remove UCLINUX from LTP]
Message-ID: <20240110141455.GC1698252@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <CAMuHMdXGwyS-CL0vLdUP4Z4YEYhmcmDyC3YdGCnS=jFkqASqvw@mail.gmail.com>
 <20240103114957.GD1073466@pevik>
 <CAMuHMdX0s0gLRoPtjJmDnSmZ_MNY590dN+JxM1HKAL1g_bjX+w@mail.gmail.com>
 <ZZVOhlGPg5KRyS-F@yuki>
 <5a1f1ff3-8a61-67cf-59a9-ce498738d912@landley.net>
 <20240105131135.GA1484621@pevik>
 <90c1ddc1-c608-30fc-d5aa-fdf63c90d055@landley.net>
 <20240108090338.GA1552643@pevik>
 <ZZvJXTshFUYSaMVH@yuki>
 <SA3PR13MB6372498CC6372F8B16237244FD6A2@SA3PR13MB6372.namprd13.prod.outlook.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <SA3PR13MB6372498CC6372F8B16237244FD6A2@SA3PR13MB6372.namprd13.prod.outlook.com>
Authentication-Results: smtp-out2.suse.de;
	none
X-Spam-Level: 
X-Spam-Score: -2.50
X-Spamd-Result: default: False [-2.50 / 50.00];
	 ARC_NA(0.00)[];
	 HAS_REPLYTO(0.30)[pvorel@suse.cz];
	 REPLYTO_EQ_FROM(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 TO_DN_EQ_ADDR_SOME(0.00)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.cz:s=susede2_rsa,suse.cz:s=susede2_ed25519];
	 NEURAL_HAM_SHORT(-0.20)[-1.000];
	 RCPT_COUNT_TWELVE(0.00)[20];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 MID_RHS_NOT_FQDN(0.50)[];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
X-Spam-Flag: NO

Hi Tim, all,

> > -----Original Message-----
> > From: automated-testing@lists.yoctoproject.org <automated-testing@lists.yoctoproject.org> On Behalf Of Cyril Hrubis
> > Hi!
> > > But as I said, if anybody from nommu decides to maintain it in LTP, I'll try to
> > > support him in my free time (review patches, give advices). And if nobody
> > > stands, this patchset which removes the support in the old API will be merged
> > > after next LTP release (in the end of January).

> > Let me highlight this part, we are eager to help anybody who is willing
> > to pick the nommu work, but we do not have resources to drive it.

> I have a couple of comments here.

> I think it would be good to give a little bit more time to try to find a helper/maintainer
> for this.  As Rob pointed out, a lot of embedded Linux developers are using very old
> kernels (and, if they are using LTP, likely very old versions of LTP).  They are also
> notorious for not being active on the mailing lists.  So this might take some active
> outreach to find helpers.  (I realize that this thread is part of this
> outreach effort).  For this reason, I'd like a few more weeks to try to advertise this
> need within the embedded Linux community.

Thank you.

> I am not using nommu systems myself, so I'm in a similar position as Petr in terms
> of it not making much sense for me to be the maintainer.  However, having said that,
> I have had for a few years now an idea for a background project related to LTP
> that might make this a more interesting fit for me.  Sony uses NuttX, and is considering
> using Zephyr in some of our low-end processor systems.  This includes some nommu
> systems.  For some time now, I have wanted to experiment with using LTP to test
> the compatibility of those systems with the Linux system APIs.  In full disclosure,
> I have no idea if this is a feasible or useful idea or not.  But it's something I'd like
> to investigate.

> I realize that testing non-Linux RTOSes is out-of-scope for LTP.  But given that that is
> something I would like to do, and that it might be relevant to the Linux nommu tests,
> I would humbly request a few weeks to investigate this before the nommu code is removed.
> This delay would be to see if it would make sense for me to volunteer to help out with
> maintaining this otherwise abandoned code.

> I can't promise anything, but I'd like to find out more about:
> 1) what parts of the current LTP are not supporting nommu (what's currently broken),
The new C API, I described it in my reply to Rob:
https://lore.kernel.org/ltp/20240110133358.GB1698252@pevik/

But I don't know whether the code in the old API was even working,
whole old API suffered with random failures, that was one of the reasons to
write a new one from the scratch.

> 2) how much code we're talking about, and

There was FORK_OR_VFORK(), which would probably in the new API call vfork() for
nommu targets (tst_old_flush() is probably not needed in the new API).

There is a special handling of getopts in lib/parse_opts.c + -C param for it.
One would have to integrate these two functions from lib/self_exec.c to the new
API (and port them to use new API via tst_test.h with #define
TST_NO_DEFAULT_MAIN):

    void maybe_run_child(void (*child)(), const char *fmt, ...);
    int self_exec(const char *argv0, const char *fmt, ...);

char *child_args is somehow integrated to lib/tst_test.c via -C arg, I haven't
found what uses that option.

There is m4, that would be usable (m4/ltp-nommu-linux.m4).

Various tests and testsuites were not compiled for nommu (e.g. capget).

There is MAP_PRIVATE_EXCEPT_UCLINUX constant to avoid using MAP_PRIVATE on
uClinux, who knows if this is relevant on nommu?

> 3) what the desired roadmap going forward would be, to continue to support this code.

All LTP tests are being rewritten to use new API since 2016 (new API was
introduced in 20160510), thus we are loosing the support with old API going
away. Sure, I can hold on this patchset and we continue removing the
functionality tests manually. But sooner or later it's gone.

One can check files which had special handling in the old API:

$ git grep -l UCLINUX 20160126 -- testcases/ | wc -l
173

What is supported now:

$ git grep -l UCLINUX  -- testcases/  |wc -l
55

=> We have now removed nearly 2/3 of it (this means we're arguing about 1/3 of
the tests which initially somehow supported nommu).

Kind regards,
Petr

> Thanks,
>  -- Tim



> -=-=-=-=-=-=-=-=-=-=-=-
> Links: You receive all messages sent to this group.
> View/Reply Online (#1271): https://lists.yoctoproject.org/g/automated-testing/message/1271
> Mute This Topic: https://lists.yoctoproject.org/mt/103541824/3616762
> Group Owner: automated-testing+owner@lists.yoctoproject.org
> Unsubscribe: https://lists.yoctoproject.org/g/automated-testing/unsub [pvorel@suse.cz]
> -=-=-=-=-=-=-=-=-=-=-=-



