Return-Path: <linux-kernel+bounces-39329-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B93A283CED0
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 22:46:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 68F7428D54C
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Jan 2024 21:46:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5023D13AA22;
	Thu, 25 Jan 2024 21:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="qljqlICx"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF8B13666B;
	Thu, 25 Jan 2024 21:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706219157; cv=none; b=S63ILvW6I/NtROHrH0v3OMzpdXqkUmVRAp1ggNvsShqLbks4OFVMAQUMIHgsllLMLMPv7IXAqk5+pQGTmo6hH653yDJ4LgTNzOHjdfibFQh+ZPdtdyaQ+elrbM/4hDg5gXHJ/m/0bltBvdmogs4RppEIS3UGSLQP9AgDfFS2e88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706219157; c=relaxed/simple;
	bh=T1vP+k/175etl9+CVVlk2tbaxTnw0h8pgKQ1Lqx+83M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Jmy43gdZ2JFQBmj5uZVCRRE7mv6YLwlLKJozwgg4+aX7X7YWQ8nKbygGqgLOKNf9/CklHyuUS/1Kz7GH42BIGgFCH73yJyRRsXJTOLKTuavIrOy71yw7Jn+k2p8hVXJrhUZJpLuKZmOMFO8oc7sDjRAJZutKLsQY9O6u2EukpAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=qljqlICx; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=dttsVu32ot0ilvban4RoGCoXIHBDQaLnjQKeetjuAiI=; b=qljqlICxGLKQXRzvZlrEpGhgWc
	vpOREsF1+y25HniQ+3BXnPoWhbMJ2sfeuFpv+EK4rBT4DtrkGSJMZc7sEcpDb/v615zJhCtRqKWqP
	Km0rViCzvzq/tc5VcMEhqZGIxaKNKvIyIf41kmf82IMIttI9FO9omo8ZwN6ckmswMQNJFggIN1wnD
	L5NO4NJ3k9WXbMODhnKNR5vwJ75i2DHsN6ZRHpfy3CqSMJsKwLATQdhdpWQuUQwG7H9TLyduO6jfj
	sVsU4aXL5NsLG97Ky+H4vfs/WrzGvTZjtLuhO4hvxcwwpcEZJ5dS3J0cFuodQY7ePNTjpk/X4IVjb
	yIVvLfFA==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rT7Xi-00FaX9-04;
	Thu, 25 Jan 2024 15:45:50 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>, wine-devel@winehq.org,
 Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Alexandre Julliard <julliard@winehq.org>
Subject:
 Re: [RFC PATCH 1/9] ntsync: Introduce the ntsync driver and character device.
Date: Thu, 25 Jan 2024 15:45:49 -0600
Message-ID: <1992245.CNCIqqkGal@camazotz>
In-Reply-To:
 <CALCETrVZFhH-dKCFpxj=nML2cn1EBc5wWHj9zhKK07TLSSqnDA@mail.gmail.com>
References:
 <20240124004028.16826-1-zfigura@codeweavers.com>
 <10405963.nUPlyArG6x@terabithia>
 <CALCETrVZFhH-dKCFpxj=nML2cn1EBc5wWHj9zhKK07TLSSqnDA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Thursday, 25 January 2024 12:55:04 CST Andy Lutomirski wrote:
> On Wed, Jan 24, 2024 at 7:42=E2=80=AFPM Elizabeth Figura
> <zfigura@codeweavers.com> wrote:
> >
> > On Wednesday, 24 January 2024 16:56:23 CST Elizabeth Figura wrote:
> > > On Wednesday, 24 January 2024 15:26:15 CST Andy Lutomirski wrote:
> > >
> > > > On Tue, Jan 23, 2024 at 4:59=E2=80=AFPM Elizabeth Figura
> > > > <zfigura@codeweavers.com> wrote:
> > > >
> > > > >
> > > > >
> > > > > ntsync uses a misc device as the simplest and least intrusive uAPI
> > > > > interface.
> > > >
> > > > >
> > > > >
> > > > > Each file description on the device represents an isolated NT ins=
tance,
> > > > > intended to correspond to a single NT virtual machine.
> > > >
> > > >
> > > > If I understand this text right, and if I understood the code right,
> > > > you're saying that each open instance of the device represents an
> > > > entire universe of NT synchronization objects, and no security or
> > > > isolation is possible between those objects.  For single-process us=
e,
> > > > this seems fine.  But fork() will be a bit odd (although NT doesn't
> > > > really believe in fork, so maybe this is fine).
> > > >
> > > > Except that NT has *named* semaphores and such.  And I'm pretty sure
> > > > I've written GUI programs that use named synchronization objects (I=
IRC
> > > > they were events, and this was a *very* common pattern, regularly
> > > > discussed in MSDN, usenet, etc) to detect whether another instance =
of
> > > > the program is running.  And this all works on real Windows because
> > > > sessions have sufficiently separated namespaces, and the security a=
ll
> > > > works out about as any other security on Windows, etc.  But
> > > > implementing *that* on top of this
> > > > file-description-plus-integer-equals-object will be fundamentally
> > > > quite subject to one buggy program completely clobbering someone
> > > > else's state.
> > > >
> > > > Would it make sense and scale appropriately for an NT synchronizati=
on
> > > > *object* to be a Linux open file description?  Then SCM_RIGHTS could
> > > > pass them around, an RPC server could manage *named* objects, and
> > > > they'd generally work just like other "Object Manager" objects like,
> > > > say, files.
> > >
> > >
> > > It's a sensible concern. I think when I discussed this with Alexandre
> > > Julliard (the Wine maintainer, CC'd) the conclusion was this wasn't
> > > something we were concerned about.
> > >
> > > While the current model *does* allow for processes to arbitrarily mess
> > > with each other, accidentally or not, I think we're not concerned with
> > > the scope of that than we are about implementing a whole scheduler in
> > > user space.
> > >
> > > For one, you can't corrupt the wineserver state this way=E2=80=94wine=
server
> > > being sort of like a dedicated process that handles many of the things
> > > that a kernel would, and so sometimes needs to set or reset events, or
> > > perform NTSYNC_IOC_KILL_MUTEX, but never relies on ntsync object stat=
e.
> > > Whereas trying to implement a scheduler in user space would involve t=
he
> > > wineserver taking locks, and hence other processes could deadlock.
> > >
> > > For two, it's probably a lot harder to mess with that internal state
> > > accidentally.
> > >
> > > [There is also a potential problem where some broken applications
> > > create a million (literally) sync objects. Making these into files ru=
ns
> > > into NOFILE. We did specifically push distributions and systemd to
> > > increase those limits because an older solution *did* use eventfds and
> > > *did* run into those limits. Since that push was successful I don't
> > > know if this is *actually* a concern anymore, but avoiding files is
> > > probably not a bad thing either.]
> >
> > Of course, looking at it from a kernel maintainer's perspective, it wou=
ldn't
> > be insane to do this anyway. If we at some point do start to care about=
 cross-
> > process isolation in this way, or if another NT emulator wants to use t=
his
> > interface and does care about cross-process isolation, it'll be necessa=
ry. At
> > least it'd make sense to make them separate files even if we don't impl=
ement
> > granular permission handling just yet.
>=20
> I'm not convinced that any complexity at all beyond using individual
> files is needed for granular permission handling.  Unless something
> actually needs permission bits on different files pointing at the same
> sync object (which I believe NT supports, but it's sort of an odd
> concept and I'm not immediately convinced that anything uses it),
> merely having individual files ought to do the trick.  Handling of who
> has permission to open a given named object can live in a daemon, and
> I'd guess that Wine even already implements this.

This is mostly correct. NT has file descriptors and descriptions (the
former is called a "handle"), though unlike Unix access bits are
specific to the *descriptor* (handle). I don't know if anything uses=20
it, but we do currently implement that basic functionality, so I can't
say that nothing does either.

So inasmuch as access to someone else's object is a concern, access to
your object with bits you don't have permission for could be a concern
along the same lines. However, from conversation with Alexandre I
believe it'd be fine to just implement those checks in user space.

> And keeping everything together gives me flashbacks of Windows 95 and
> Mac OS pre-X.  Sure, in principle the software wasn't malicious, but
> there was no shortage whatsoever of buggy crap out there, and systems
> were quite unstable.  Even just:
>=20
> CreateSemaphore();
> fork();
> sleep a few seconds;
> exit();
>=20
> seems like it could corrupt the shared namespace world.  (Obviously no
> one would ever do that, right?)
>=20
> Also, handle leaks:
>=20
> while(true) {
>   make a subprocess, which creates a semaphore and crashes;
> }

=46or whatever it's worth, this particular thing wouldn't be a concern;
Wine's "kernel" daemon already has to detect when a process dies and
close all its outstanding handles.



