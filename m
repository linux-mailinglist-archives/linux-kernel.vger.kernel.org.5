Return-Path: <linux-kernel+bounces-66340-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAF6A855AAC
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 07:43:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50DC51F2331F
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Feb 2024 06:43:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F203610E;
	Thu, 15 Feb 2024 06:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="hQ3fK5AL"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BECE0211C;
	Thu, 15 Feb 2024 06:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707979386; cv=none; b=Md9VE2/ApzOWSzrztPWrQjMhlgZekWDIiIEI5kChPl9Oc/fAFjeLAViDuYn/F6DT1crzGip28GtLZRt4ruiOqsZGhKPvXyLEq7OMt4y7RtRXfGkQnygoySj/nKEuW4zGA9BA1Cx45XoebGFtvxy6XmVf+Sb6juqRooigyGc3oMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707979386; c=relaxed/simple;
	bh=bFiX7l/dkvvas2y9mVAwdKZIWk+ygNpgsck+Owe+Lq0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X2gXySraJ6qU/ECqjXTE/na5SU1IeDauOCMtDRit7AWFuKL5+NhivfcalB5VDgqii2XMlQGWXFOdlpn2i0vCf8jGJlW7HihxRJZPAm9mkI+qtgzzyF7tI1gtdpoiYbh5vjE1vnCBclxR1KGRuQbHvsaHXCpiVKpPRbmvDr3tRPk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=hQ3fK5AL; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 21CDD1A3976;
	Thu, 15 Feb 2024 07:42:58 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=quarantine dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tesarici.cz; s=mail;
	t=1707979378; bh=roTSoTjD1emgQbuZBBx1xt9ZwmvzvUB+EtlQG2bp7ok=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=hQ3fK5ALBbXSZMz5v2tBvspwuzmMEyb6ks+phJIRLvodwLMM/EfAoZaSTGpESGGki
	 VtOafw1tFGW+kcl56pvlpyTE3FLYNZH9VvNgSOIK4uOVB1EIx63hparlv/+IvmcS4f
	 WQjWelg0QcwUvLf4xHH9F3/PdauiETogjpgX8txcnOT6hpvmv+URq9N1w/Q3yOxnjD
	 anheVqX40snEpKW2uTYwVEmhZcazMBXmDHEugQ+KqRm2qlLw24Rz48Ug6jIpmzyFiu
	 Zk7c8NXkno2VZr9wu/RQQYDT16KRyuMRDDVh/M56I3mbmQ94Z+U4wf0PYylLyAlar4
	 Ro2zwEQHkpezg==
Date: Thu, 15 Feb 2024 07:42:57 +0100
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
 <petr.tesarik1@huawei-partners.com>, Kees Cook <keescook@chromium.org>,
 Alexei Starovoitov <alexei.starovoitov@gmail.com>
Subject: Re: [PATCH v1 5/5] sbm: SandBox Mode documentation
Message-ID: <20240215074257.10e00a53@meshulam.tesarici.cz>
In-Reply-To: <xg7iz7syomv3oobjktgn76fyxms4vfs66jul56ub36prwnncxm@hsjhc5m72ipq>
References: <20240214113035.2117-1-petrtesarik@huaweicloud.com>
	<20240214113035.2117-6-petrtesarik@huaweicloud.com>
	<20240214053053.982b48d993ae99dad1d59020@linux-foundation.org>
	<2024021425-audition-expand-2901@gregkh>
	<20240214155524.719ffb15@meshulam.tesarici.cz>
	<2024021415-jokester-cackle-2923@gregkh>
	<20240214173112.138e0e29@meshulam.tesarici.cz>
	<g3llwlzlhatvz2a23cntx7lscqarepq4uyaq6wne6my7ddo3mk@6b64pjcnykah>
	<20240214210937.3a19945f@meshulam.tesarici.cz>
	<xg7iz7syomv3oobjktgn76fyxms4vfs66jul56ub36prwnncxm@hsjhc5m72ipq>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Wed, 14 Feb 2024 15:19:04 -0500
Kent Overstreet <kent.overstreet@linux.dev> wrote:

> On Wed, Feb 14, 2024 at 09:09:37PM +0100, Petr Tesa=C5=99=C3=ADk wrote:
> > On Wed, 14 Feb 2024 13:54:54 -0500
> > Kent Overstreet <kent.overstreet@linux.dev> wrote:
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
> > > Given that code is going to need a rewrite to make use of this anyway=
s -
> > > why not just do the rewrite in Rust? =20
> >=20
> > Thank you for this question! I concur that rewriting the whole kernel
> > in Rust would be a better option. I see two differences:
> >=20
> > 1. amount of work
> > 2. regressions
> >=20
> > Rewriting something in Rust means pretty much writing it from scratch.
> > Doing that necessarily introduces regressions. Old code has been used.
> > It has been tested. In many corner cases. Lots of bugs have been found,
> > and they=E2=80=99ve been fixed. If you write code from scratch, you los=
e much
> > of the accumulated knowledge. =20
>=20
> But it's work that already has some growing momentum behind it,
> especially in the area you cited - decompression algorithms.

Fair enough, this is indeed going for a better solution.

> > More importantly, sandbox mode can be viewed as a tool that enforces
> > decomposition of kernel code. This decomposition is the main benefit.
> > It requires understanding the dependencies among different parts of the
> > kernel (both code flow and data flow), and that will in turn promote
> > better design. =20
>=20
> You see this as a tool for general purpose code...?
>=20
> Typical kernel code tends to be quite pointer heavy.

Yes. I believe this fact contributes to the difficulty of ensuring
memory safety in the kernel. With so much code potentially depnding on
any other kernel data structure, it does not help much that you protect
it as a whole. A finer-grained protection would make more sense.

> > > Then you get memory safety, which seems to be what you're trying to
> > > achieve here.
> > >=20
> > > Or, you say this is for when performance isn't critical - why not a u=
ser
> > > mode helper? =20
> >=20
> > Processes in user mode are susceptible to all kinds of attacks you may
> > want to avoid. Sandbox mode can be used in situations where user mode
> > does not exist, e.g. to display a boot logo or to unpack initramfs. =20
>=20
> [citation needed]

I assume you mean citation for the kinds of attacks, not for the
unavailability of user space before initramfs is unpacked. ;-)

Here you go:

On Wed, 2023-03-22 at 15:27 -0700, Alexei Starovoitov wrote:
> On Wed, Mar 22, 2023 at 5:08=E2=80=AFAM Roberto Sassu
[...]
> <roberto.sassu@huaweicloud.com> wrote:
> > possible use case. The main goal is to move something that was running
> > in the kernel to user space, with the same isolation guarantees as if
> > the code was executed in the kernel.
>=20
> They are not the same guarantees.
> UMD is exactly equivalent to root process running in user space.
> Meaning it can be killed, ptraced, priority inverted, etc

https://lore.kernel.org/lkml/CAADnVQJC0h7rtuntt0tqS5BbxWsmyWs3ZSbboZMmUKetM=
G2VhA@mail.gmail.com/

Petr T

