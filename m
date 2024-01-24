Return-Path: <linux-kernel+bounces-37789-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E9B7583B509
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 23:56:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DC706B23509
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Jan 2024 22:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24F04136644;
	Wed, 24 Jan 2024 22:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="Y1DBGw21"
Received: from mail.codeweavers.com (mail.codeweavers.com [4.36.192.163])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 108962C683;
	Wed, 24 Jan 2024 22:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=4.36.192.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706136989; cv=none; b=MIApamantHNEA9SXb/yO2V4WdjXAnY6977Uf8T6nzrn6UDUJ0kdchM2W7vqJ/4UIHvtIaMMrT3T/R3G8H28SNnInfSltzUz3vKyTNxje1Zb4d1Dd9WhISFiT1wN16x7ioVKgUmsoVNAMba1ubBVEMSXUE1N9GTk97g6AMkRIwN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706136989; c=relaxed/simple;
	bh=SKdonuUpwHNKkTNWaGs4Ap2srIbuQXPsoaUP/5ykGqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZ9guv+lL1AL72Enuyvvf/oXaQEHt0vY2kB7p7raKfwt5ODKJvTBRG0l6arCKZfY75646tT5c3KC+6VLHq2lTWxKTx87ufRktbiLKXB3Ig7Dd9LbxBAbkDGMtjH03xyUf7XqH8IuadhovFHb3YWjdiaXKbczDgIKQro8C1wxTRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com; spf=pass smtp.mailfrom=codeweavers.com; dkim=pass (2048-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b=Y1DBGw21; arc=none smtp.client-ip=4.36.192.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeweavers.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeweavers.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=codeweavers.com; s=s1; h=Message-ID:Date:Subject:Cc:To:From:Sender;
	bh=DkSieLEcEHpG6Q5/Pg0k+yQT4j2UmfvF4WEMWSAihHY=; b=Y1DBGw21m5Hc+UTCIOYjYI8FHz
	luVQen0EpOKHHXL/WSwkVb+i8f58xSBeFY7Fv8G51gbrWisq7rT1A+Ydjr8ZTCWbdjwAS9jk5ZTdF
	wWf9v3YYTNlqzIrH4L892xpiQ2SpZmH34ZJmOWCUNhGfBL3AgN5ceGsnO+sZB1NLgoeXmw/d6w5ai
	D7s52QdJx5yasDJBvA/elgaondrWRb3sHHKvkoO9dYNcrquAPFgHAiQncVyFZexrWwml3+NbzBYp5
	PlWExdFMzsg9Q0moMdeNh0XnGkLqGrLRC5LtycMVpPQPCX+K6IVTnuvRPAqMWvzNIplM1Mmk/qQqW
	ybSEAO6g==;
Received: from cw137ip160.mn.codeweavers.com ([10.69.137.160] helo=camazotz.localnet)
	by mail.codeweavers.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <zfigura@codeweavers.com>)
	id 1rSmAR-00Ea95-1y;
	Wed, 24 Jan 2024 16:56:23 -0600
From: Elizabeth Figura <zfigura@codeweavers.com>
To: Andy Lutomirski <luto@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
 wine-devel@winehq.org,
 =?ISO-8859-1?Q?Andr=E9?= Almeida <andrealmeid@igalia.com>,
 Wolfram Sang <wsa@kernel.org>, Arkadiusz Hiler <ahiler@codeweavers.com>,
 Peter Zijlstra <peterz@infradead.org>,
 Alexandre Julliard <julliard@winehq.org>
Subject:
 Re: [RFC PATCH 1/9] ntsync: Introduce the ntsync driver and character device.
Date: Wed, 24 Jan 2024 16:56:23 -0600
Message-ID: <5907233.BlLQTPImNI@camazotz>
In-Reply-To:
 <CALCETrU+Eb5CdkqfYK8JvOiPA7K-6Bfs4uEWiu-U9oH95XfvKw@mail.gmail.com>
References:
 <20240124004028.16826-1-zfigura@codeweavers.com>
 <20240124004028.16826-2-zfigura@codeweavers.com>
 <CALCETrU+Eb5CdkqfYK8JvOiPA7K-6Bfs4uEWiu-U9oH95XfvKw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"

On Wednesday, 24 January 2024 15:26:15 CST Andy Lutomirski wrote:
> On Tue, Jan 23, 2024 at 4:59=E2=80=AFPM Elizabeth Figura
> <zfigura@codeweavers.com> wrote:
> >
> > ntsync uses a misc device as the simplest and least intrusive uAPI inte=
rface.
> >
> > Each file description on the device represents an isolated NT instance,=
 intended
> > to correspond to a single NT virtual machine.
>=20
> If I understand this text right, and if I understood the code right,
> you're saying that each open instance of the device represents an
> entire universe of NT synchronization objects, and no security or
> isolation is possible between those objects.  For single-process use,
> this seems fine.  But fork() will be a bit odd (although NT doesn't
> really believe in fork, so maybe this is fine).
>=20
> Except that NT has *named* semaphores and such.  And I'm pretty sure
> I've written GUI programs that use named synchronization objects (IIRC
> they were events, and this was a *very* common pattern, regularly
> discussed in MSDN, usenet, etc) to detect whether another instance of
> the program is running.  And this all works on real Windows because
> sessions have sufficiently separated namespaces, and the security all
> works out about as any other security on Windows, etc.  But
> implementing *that* on top of this
> file-description-plus-integer-equals-object will be fundamentally
> quite subject to one buggy program completely clobbering someone
> else's state.
>=20
> Would it make sense and scale appropriately for an NT synchronization
> *object* to be a Linux open file description?  Then SCM_RIGHTS could
> pass them around, an RPC server could manage *named* objects, and
> they'd generally work just like other "Object Manager" objects like,
> say, files.

It's a sensible concern. I think when I discussed this with Alexandre
Julliard (the Wine maintainer, CC'd) the conclusion was this wasn't
something we were concerned about.

While the current model *does* allow for processes to arbitrarily mess
with each other, accidentally or not, I think we're not concerned with
the scope of that than we are about implementing a whole scheduler in
user space.

=46or one, you can't corrupt the wineserver state this way=E2=80=94wineserv=
er
being sort of like a dedicated process that handles many of the things
that a kernel would, and so sometimes needs to set or reset events, or
perform NTSYNC_IOC_KILL_MUTEX, but never relies on ntsync object state.
Whereas trying to implement a scheduler in user space would involve the
wineserver taking locks, and hence other processes could deadlock.

=46or two, it's probably a lot harder to mess with that internal state
accidentally.

[There is also a potential problem where some broken applications
create a million (literally) sync objects. Making these into files runs
into NOFILE. We did specifically push distributions and systemd to
increase those limits because an older solution *did* use eventfds and
*did* run into those limits. Since that push was successful I don't
know if this is *actually* a concern anymore, but avoiding files is
probably not a bad thing either.]

=2D-Zeb



