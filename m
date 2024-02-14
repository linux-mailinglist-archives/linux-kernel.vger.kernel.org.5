Return-Path: <linux-kernel+bounces-65915-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F2368553B1
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 21:09:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0A5B286726
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Feb 2024 20:09:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DF9613DBA5;
	Wed, 14 Feb 2024 20:09:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="oVdD9OVj"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7745D5C90E;
	Wed, 14 Feb 2024 20:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707941383; cv=none; b=ieQ4Vews0PtCSW41r+XM1o8rioL21Gh4jUwhikivtIe5HCJHdei5ofid+P6tNTiOmKjghObexzU5hEJ2YZv4aZhEvkdA06f0Wdx77x778BBDIqBf1dSSioe+I+J6GRtOujRXl3ReVYF5olCDLDBIcvsNJps1PXDjxHOzAjiNxpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707941383; c=relaxed/simple;
	bh=FAp8q6u4+OafC5yLy+uYi9sE/N2x6rE7jj5vjk/Ekvc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o/8WZBFHNZFU1X5fQpr65hIwTwzvDRhikjm+aC6rd2jYfr076+FN48aqE9/lss2KpRuUioodqq2uhHOOLyo7KsokSorW5sp9hF7ISovrpQztyaM0nfFfpzCKJ3v+EERyLwhl5HDFHiZojh+rr8RYWcwlF2pdkJgkyHJDtcwCJeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=oVdD9OVj; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 614671A0CF9;
	Wed, 14 Feb 2024 21:09:38 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1707941379; bh=pnr9jHJcWT1LGtqicgTbuE7ZC/LWYS+FDN6jvOn19r8=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=oVdD9OVjXgVy9KOB0DRMYyhrHzr/TgA6xFoW1aTJDVuDp7JjCQgy8toowLVZunOOO
	 aIwP48IDMxdda9abPRVjcxcHN+n9dRBbVKUwzi6McjyFz+cJKI/o2HbWCGSI2vjvz7
	 xLIyesi1VXn64q+mjSb9Mz1cLd4YjZs6LRK3SRTsqzlGIj6h5dUjJ1h2Nzn8U4qYZb
	 Qn/SKJRwTF0TP9kkdhpzMcsf0o9jUHXlGtMwi3PH2lk5aQwxuUXKhj+zgaCdpqU5S3
	 61djeFCzEByPTh/ayK0TnQPCb/dEYtZsb34i+VP0Ab5Yh7uJ5QX4UNoiqcnK6E2BHt
	 XSKwIQL2hegmg==
Date: Wed, 14 Feb 2024 21:09:37 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Kent Overstreet <kent.overstreet@linux.dev>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Andrew Morton
 <akpm@linux-foundation.org>, Petr Tesarik <petrtesarik@huaweicloud.com>,
 Jonathan Corbet <corbet@lwn.net>, David Kaplan <david.kaplan@amd.com>,
 Larry Dewey <larry.dewey@amd.com>, Elena Reshetova
 <elena.reshetova@intel.com>, Carlos Bilbao <carlos.bilbao@amd.com>, "Masami
 Hiramatsu (Google)" <mhiramat@kernel.org>, Randy Dunlap
 <rdunlap@infradead.org>, Petr Mladek <pmladek@suse.com>, "Paul E. McKenney"
 <paulmck@kernel.org>, Eric DeVolder <eric.devolder@oracle.com>, Marc
 =?UTF-8?B?QXVyw6hsZQ==?= La France <tsi@tuyoix.net>, "Gustavo A. R. Silva"
 <gustavoars@kernel.org>, Nhat Pham <nphamcs@gmail.com>, "Christian Brauner
 (Microsoft)" <brauner@kernel.org>, Douglas Anderson
 <dianders@chromium.org>, Luis Chamberlain <mcgrof@kernel.org>, Guenter
 Roeck <groeck@chromium.org>, Mike Christie <michael.christie@oracle.com>,
 Maninder Singh <maninder1.s@samsung.com>, "open list:DOCUMENTATION"
 <linux-doc@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>,
 Roberto Sassu <roberto.sassu@huaweicloud.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH v1 5/5] sbm: SandBox Mode documentation
Message-ID: <20240214210937.3a19945f@meshulam.tesarici.cz>
In-Reply-To: <g3llwlzlhatvz2a23cntx7lscqarepq4uyaq6wne6my7ddo3mk@6b64pjcnykah>
References: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
	<20240214113035.2117-6-petrtesarik@huaweicloud.com>
	<20240214053053.982b48d993ae99dad1d59020@linux-foundation.org>
	<2024021425-audition-expand-2901@gregkh>
	<20240214155524.719ffb15@meshulam.tesarici.cz>
	<2024021415-jokester-cackle-2923@gregkh>
	<20240214173112.138e0e29@meshulam.tesarici.cz>
	<g3llwlzlhatvz2a23cntx7lscqarepq4uyaq6wne6my7ddo3mk@6b64pjcnykah>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 13:54:54 -0500
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Wed, Feb 14, 2024 at 05:31:12PM +0100, Petr Tesa=C5=99=C3=ADk wrote:
> > On Wed, 14 Feb 2024 16:11:05 +0100
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> >  =20
> > > On Wed, Feb 14, 2024 at 03:55:24PM +0100, Petr Tesa=C5=99=C3=ADk wrot=
e: =20
> > > > OK, so why didn't I send the whole thing?
> > > >=20
> > > > Decomposition of the kernel requires many more changes, e.g. in lin=
ker
> > > > scripts. Some of them depend on this patch series. Before I go and
> > > > clean up my code into something that can be submitted, I want to get
> > > > feedback from guys like you, to know if the whole idea would be even
> > > > considered, aka "Fail Fast".   =20
> > >=20
> > > We can't honestly consider this portion without seeing how it would
> > > work, as we don't even see a working implementation that uses it to
> > > verify it at all.
> > >=20
> > > The joy of adding new frameworks is that you need a user before anyone
> > > can spend the time to review it, sorry. =20
> >=20
> > Thank your for a quick assessment. Will it be sufficient if I send some
> > code for illustration (with some quick&dirty hacks to bridge the gaps),
> > or do you need clean and nice kernel code? =20
>=20
> Given that code is going to need a rewrite to make use of this anyways -
> why not just do the rewrite in Rust?

Thank you for this question! I concur that rewriting the whole kernel
in Rust would be a better option. I see two differences:

1. amount of work
2. regressions

Rewriting something in Rust means pretty much writing it from scratch.
Doing that necessarily introduces regressions. Old code has been used.
It has been tested. In many corner cases. Lots of bugs have been found,
and they=E2=80=99ve been fixed. If you write code from scratch, you lose mu=
ch
of the accumulated knowledge.

It may still pay off in the long run.

More importantly, sandbox mode can be viewed as a tool that enforces
decomposition of kernel code. This decomposition is the main benefit.
It requires understanding the dependencies among different parts of the
kernel (both code flow and data flow), and that will in turn promote
better design.

> Then you get memory safety, which seems to be what you're trying to
> achieve here.
>=20
> Or, you say this is for when performance isn't critical - why not a user
> mode helper?

Processes in user mode are susceptible to all kinds of attacks you may
want to avoid. Sandbox mode can be used in situations where user mode
does not exist, e.g. to display a boot logo or to unpack initramfs.

Sandbox mode is part of the kernel, hence signed, which may be relevant
if the kernel is locked down, so you can use it e.g. to parse a key
from the bootloader and put it on the trusted keyring.

Regarding performance, sandbox overhead is somewhere between kernel
mode and UMH. It is not suitable for time-critical code (like handling
NIC interrupts), but it's still much faster than UMH.

Petr T

