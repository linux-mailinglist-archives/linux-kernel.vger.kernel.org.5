Return-Path: <linux-kernel+bounces-39961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A3183D7D8
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 11:21:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496AA1C2914E
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Jan 2024 10:21:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAC61B7F2;
	Fri, 26 Jan 2024 09:55:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b="QSiMTsIJ"
Received: from bee.tesarici.cz (bee.tesarici.cz [77.93.223.253])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2E2A51C2F
	for <linux-kernel@vger.kernel.org>; Fri, 26 Jan 2024 09:55:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=77.93.223.253
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706262914; cv=none; b=r8da5+l0CUMZ2fZcn8Np1hblAIhGIytDL4Aprcmcz8YFXOWbQwdDZk0dx4GD0KJXMa4WgT/vGm2DCBRV/qaPGZuUgBGL+mjmbjk2rrY+Wl/6w9rhsY4mWFy5LI/Jr6lUvT4nKeQuy5q4McezCmDZG4x9BMxy2Edth0UonqARVJA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706262914; c=relaxed/simple;
	bh=98uBaqksOvo0/XWg1JQiFaXFzJAFgQLh1B1y254w2Xw=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DX6qlND+QyGZoPyW2DkWsJqDNKvNWvwntbH5aCwJMx73WwbtSHmAIjMfGsBQcRTzziGrz7YOV+ET08TLXjtLRaD/Bm1tS56FSORqrGpDnfFk70wHjxueaRE8XfscsJZt62vEhcLHcIP7syMalOGN99l08W5ZeaosOkSW/jm9KKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz; spf=pass smtp.mailfrom=tesarici.cz; dkim=pass (2048-bit key) header.d=tesarici.cz header.i=@tesarici.cz header.b=QSiMTsIJ; arc=none smtp.client-ip=77.93.223.253
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tesarici.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tesarici.cz
Received: from meshulam.tesarici.cz (dynamic-2a00-1028-83b8-1e7a-4427-cc85-6706-c595.ipv6.o2.cz [IPv6:2a00:1028:83b8:1e7a:4427:cc85:6706:c595])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by bee.tesarici.cz (Postfix) with ESMTPSA id 638D518D315;
	Fri, 26 Jan 2024 10:55:07 +0100 (CET)
Authentication-Results: mail.tesarici.cz; dmarc=fail (p=none dis=none) header.from=tesarici.cz
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tesarici.cz; s=mail;
	t=1706262907; bh=98uBaqksOvo0/XWg1JQiFaXFzJAFgQLh1B1y254w2Xw=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=QSiMTsIJxe31DkozMCoyJVoren/wta82mBeBHLVS6ZMxhSyeGQW5Nlhqj0lMpIoTH
	 /sjCikjm280U0Sp4MB7LoIaOkgstCZNlz4FJkUO9WMj9fd0JYxCH0mNcHeQljXpQDJ
	 qXVBPD0vmn4tsoZSr4vbYxTT+ukPLbKNfg+OBhzVHDMpBYLc1iWnTu8u6/08laDPaH
	 bY9rLJxJ8IWA3GPhIhWatpqud/QCZ0T0H4dHvahnBBvxf/SOOiiAqL/7UpCoRlv7lx
	 xOuVKFIXVgLEDMq3pq2w1xG+RewZgaRwWKTGUn9OWtgIM/SVWSRQ9godb5T+jcTvnj
	 fAohKhJTuhTAQ==
Date: Fri, 26 Jan 2024 10:55:05 +0100
From: Petr =?UTF-8?B?VGVzYcWZw61r?= <petr@tesarici.cz>
To: Richard Weinberger <richard@nod.at>
Cc: Petr Tesarik <petrtesarik@huaweicloud.com>, anton ivanov
 <anton.ivanov@cambridgegreys.com>, Johannes Berg
 <johannes@sipsolutions.net>, linux-um <linux-um@lists.infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>, Roberto Sassu
 <roberto.sassu@huaweicloud.com>, Petr Tesarik
 <petr.tesarik1@huawei-partners.com>
Subject: Re: [PATCH 0/2] um: improve UML page fault handling
Message-ID: <20240126105505.38440835@meshulam.tesarici.cz>
In-Reply-To: <20240105075109.4f0e2785@meshulam.tesarici.cz>
References: <20231215121431.680-1-petrtesarik@huaweicloud.com>
	<435201914.200552.1704410531143.JavaMail.zimbra@nod.at>
	<20240105075109.4f0e2785@meshulam.tesarici.cz>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.39; x86_64-suse-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

On Fri, 5 Jan 2024 07:51:09 +0100
Petr Tesa=C5=99=C3=ADk <petr@tesarici.cz> wrote:

> Helo Richard,
>=20
> Am Fri, 5 Jan 2024 00:22:11 +0100 (CET)
> schrieb Richard Weinberger <richard@nod.at>:
>=20
> > ----- Urspr=C3=BCngliche Mail ----- =20
> > > Von: "Petr Tesarik" <petrtesarik@huaweicloud.com>
> > > An: "richard" <richard@nod.at>, "anton ivanov" <anton.ivanov@cambridg=
egreys.com>, "Johannes Berg"
> > > <johannes@sipsolutions.net>, "linux-um" <linux-um@lists.infradead.org=
>, "linux-kernel" <linux-kernel@vger.kernel.org>
> > > CC: "Roberto Sassu" <roberto.sassu@huaweicloud.com>, petr@tesarici.cz=
, "Petr Tesarik"
> > > <petr.tesarik1@huawei-partners.com>
> > > Gesendet: Freitag, 15. Dezember 2023 13:14:29
> > > Betreff: [PATCH 0/2] um: improve UML page fault handling   =20
> >  =20
> > > From: Petr Tesarik <petr.tesarik1@huawei-partners.com>
> > >=20
> > > Improve UML handling of segmentation faults in kernel mode. Although
> > > such page faults are generally caused by a kernel bug, it is annoying
> > > if they cause an infinite loop, or panic the kernel. More importantly,
> > > a robust implementation allows to write KUnit tests for various guard
> > > pages, preventing potential kernel self-protection regressions.
> > >=20
> > > Petr Tesarik (2):
> > >  um: do not panic on kernel mode faults
> > >  um: oops on accessing an non-present page in the vmalloc area   =20
> >=20
> > I think this is a good thing to have. =20
>=20
> Thanks for the feedback.
>=20
> > For the implementation side, this needs to use the oops_* helpers
> > from kernel/panic.c and taint the kernel, etc... =20
>=20
> Yes, I did see that coming but wanted to get some confirmation that
> it's worth the effort.
>=20
> > See arch/x86/kernel/dumpstack.c die() and friends. =20
>=20
> This implementation also calls die notifiers, but AFAICS different
> architectures are not very consistent in their use. Do you also
> require die notifiers for the UML implementation?

It seems I won't have time for this in the near future... Can I start
by sending a trivial patch that panics the kernel if kernel mode tries
to access a vmalloc guard page? That's something I can do immediately,
and it's still better than getting page faults in an infinite loop...

Petr T

