Return-Path: <linux-kernel+bounces-66572-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id ABDB9855E74
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 10:45:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 354E11F24095
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 09:45:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3840E50A79;
	Thu, 15 Feb 2024 09:45:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="V3pStprb"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AE0F635;
	Thu, 15 Feb 2024 09:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707990322; cv=none; b=o4yw0smidbK3CzI1SddMwVeCt0OVRSWHhVJZ9a/LYYQOTxxG4lkJeS29tOppbNWXalBxDlqT+YIJbjvpDCMx6Kvc7eqlbVQAoJEYaR8G5ZeMQKo0te/URggxXQbwh6qJ8ut8/ivVb0So3zRfsLs/Jup2du3hlvnbhoBswysmrj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707990322; c=relaxed/simple;
	bh=D6T1r6v3EbsT85MgKqOYf6gakz8WEgJuzlWbIuokI+g=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VJwnvd/HF02SjVIeL4eKlY1IZ5lU28bCFu11CGVcbo1V8Pde1i1FBdcnmq6feGpFk/gLe94+ArWu4klfAC3Ip2FBNlVpjHoRTy3+ehchkSMSW1bCnLi0kuzfyuk7cqCOdMcxjok1elP1RqOCCEy7yD14aGzhQc17VByf+MKq/qk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=V3pStprb; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 0E5411A5DA6;
	Thu, 15 Feb 2024 10:45:15 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1707990316; bh=+r7JQcTZF4Th4Y1yTvwhdkSZSn3/oj/5ngBs5tfMidg=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=V3pStprbN51RK3H+QJOl1KXPEw7A3jgQke7AlVdLhlxBLKhqcahDB2uVp/VQPsT35
	 Ogk9ik32b+QhbjbE6Yf99aIliN7y8OWkxalFLu6YUnok62TDId1urgasIjU7woNcD7
	 U6dcqGGAXKj3PMVkd09vShs+uANTbbrvYeRUx8NnOl3w6MIyN84Gfz7AfnD98Ufbut
	 4RQPSCVVXk0wmmPi/P7jf4ptuJU1Wrhr7IzkYB8Zks9hBGFgoFYFZkc1II1LKTh+ux
	 VcxmV8wu4glsENcP3/RnrOUpA70tbNFIdJg17wVGBwIoG7T36cv7y3oCLd+p+yHeAC
	 JBmZgNkvRM2Dg==
Date: Thu, 15 Feb 2024 10:45:15 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Petr Tesarik
 <petrtesarik@huaweicloud.com>, Jonathan Corbet <corbet@lwn.net>, David
 Kaplan <david.kaplan@amd.com>, Larry Dewey <larry.dewey@amd.com>, Elena
 Reshetova <elena.reshetova@intel.com>, Carlos Bilbao
 <carlos.bilbao@amd.com>, "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, Petr Mladek <pmladek@suse.com>, "Paul
 E. McKenney" <paulmck@kernel.org>, Eric DeVolder
 <eric.devolder@oracle.com>, Marc =?UTF-8?B?QXVyw6hsZQ==?= La France
 <tsi@tuyoix.net>, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Nhat Pham
 <nphamcs@gmail.com>, "Christian Brauner (Microsoft)" <brauner@kernel.org>,
 Douglas Anderson <dianders@chromium.org>, Luis Chamberlain
 <mcgrof@kernel.org>, Guenter Roeck <groeck@chromium.org>, Mike Christie
 <michael.christie@oracle.com>, Kent Overstreet <kent.overstreet@linux.dev>,
 Maninder Singh <maninder1.s@samsung.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH v1 5/5] sbm: SandBox Mode documentation
Message-ID: <20240215104515.2075577e@meshulam.tesarici.cz>
In-Reply-To: <2024021514-manmade-ambitious-414a@gregkh>
References: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
	<20240214113035.2117-6-petrtesarik@huaweicloud.com>
	<20240214053053.982b48d993ae99dad1d59020@linux-foundation.org>
	<2024021425-audition-expand-2901@gregkh>
	<20240214155524.719ffb15@meshulam.tesarici.cz>
	<2024021415-jokester-cackle-2923@gregkh>
	<20240214173112.138e0e29@meshulam.tesarici.cz>
	<2024021417-magma-drudge-ad70@gregkh>
	<20240214204254.6208ca2f@meshulam.tesarici.cz>
	<2024021514-manmade-ambitious-414a@gregkh>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Thu, 15 Feb 2024 10:11:05 +0100
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Wed, Feb 14, 2024 at 08:42:54PM +0100, Petr Tesa=C5=99=C3=ADk wrote:
> > On Wed, 14 Feb 2024 19:48:52 +0100
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >  =20
> > > On Wed, Feb 14, 2024 at 05:31:12PM +0100, Petr Tesa=C5=99=C3=ADk wrot=
e: =20
> > > > On Wed, 14 Feb 2024 16:11:05 +0100
> > > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > > >    =20
> > > > > On Wed, Feb 14, 2024 at 03:55:24PM +0100, Petr Tesa=C5=99=C3=ADk =
wrote:   =20
> > > > > > OK, so why didn't I send the whole thing?
> > > > > >=20
> > > > > > Decomposition of the kernel requires many more changes, e.g. in=
 linker
> > > > > > scripts. Some of them depend on this patch series. Before I go =
and
> > > > > > clean up my code into something that can be submitted, I want t=
o get
> > > > > > feedback from guys like you, to know if the whole idea would be=
 even
> > > > > > considered, aka "Fail Fast".     =20
> > > > >=20
> > > > > We can't honestly consider this portion without seeing how it wou=
ld
> > > > > work, as we don't even see a working implementation that uses it =
to
> > > > > verify it at all.
> > > > >=20
> > > > > The joy of adding new frameworks is that you need a user before a=
nyone
> > > > > can spend the time to review it, sorry.   =20
> > > >=20
> > > > Thank your for a quick assessment. Will it be sufficient if I send =
some
> > > > code for illustration (with some quick&dirty hacks to bridge the ga=
ps),
> > > > or do you need clean and nice kernel code?   =20
> > >=20
> > > We need a real user in the kernel, otherwise why would we even consid=
er
> > > it?  Would you want to review a new subsystem that does nothing and h=
as
> > > no real users?  If not, why would you want us to?  :) =20
> >=20
> > Greg, please enlighten me on the process. How is something like this
> > supposed to get in? =20
>=20
> If you were in our shoes, what would you want to see in order to be able
> to properly review and judge if a new subsystem was ok to accept?
>=20
> > Subsystem maintainers will not review code that depends on core features
> > not yet reviewed by the respective maintainers. If I add only the API
> > and a stub implementation, then it brings no benefit and attempts to
> > introduce the API will be dismissed. I would certainly do just that if
> > I was a maintainer... =20
>=20
> Exactly, you need a real user.

Er, what I was trying to say was rather: You need a real implementation
of a core feature before a subsystem maintainer considers using it for
their subsystem.

But I get your point. I need *both*.

> > I could try to pack everything (base infrastructure, arch
> > implementations, API users) into one big patch with pretty much
> > everybody on the Cc list, but how is that ever going to get reviewed? =
=20
>=20
> How are we supposed to know if any of this even works at all if you
> don't show that it actually works and is useful?  Has any of that work
> even been done yet?  I'm guessing it has (otherwise you wouldn't have
> posted this), but you are expecting us to just "trust us, stuff in the
> future is going to use this and need it" here.

Understood.

> Again, we can not add new infrastructure for things that have no users,
> nor do you want us to.  Ideally you will have at least 3 different
> users, as that seems to be the "magic number" that shows that the
> api/interface will actually work well, and is flexible enough.  Just
> one user is great for proof-of-concept, but that usually isn't good
> enough to determine if it will work for others (and so it wouldn't need
> to be infrastructure at all, but rather just part of that one feature on
> its own.)
>=20
> > Should I just go and maintain an out-of-tree repo for a few years,
> > hoping that it gets merged one day, like bcachefs? Is this the way? =20
>=20
> No, show us how this is going to be used.

OK, working on it.

> Again, think about what you would want if you had to review this.

Review, or merge? For a review, I would want enough information to
understand what it is *and* where it is going.

As a matter of fact, hpa does not like the x86 implementation. For
reasons that I do not fully understand (yet), but if the concept turns
out to be impractical, then my submission will serve a purpose, as I
can save myself (and anybody else with a similar idea) a lot of work by
failing fast.

Is this a valid way to get early feedback?

Thanks,
Petr T

