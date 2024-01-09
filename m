Return-Path: <linux-kernel+bounces-21539-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 94BB08290E9
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:41:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33AD91F268AB
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Jan 2024 23:41:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 162063E490;
	Tue,  9 Jan 2024 23:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TLzuwqpN"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A50D8364BB
	for <linux-kernel@vger.kernel.org>; Tue,  9 Jan 2024 23:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704843651;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rXkeF1JbohR+qHjRwaNYQo4YUCHqi3t+/pnrz4B1Sls=;
	b=TLzuwqpNZ9ZS0/UggC+3mdF/zmBj63uGsIBup8rZiU3kP5jqM4AxolPJiqhGsN44AkCOEv
	WXW5GU/ZT/GVnzWIStSfm0QAsKyjxW3L8qOiWmAng9rv7+KlMHmT1tsqsSXrPcD0GkXDQO
	jXTpdb8J/PjK9rMyiGABWq52pSy09mg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-428-93FeNqTMNtWVinikLvVxWw-1; Tue,
 09 Jan 2024 18:40:47 -0500
X-MC-Unique: 93FeNqTMNtWVinikLvVxWw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 605CE3C0F422;
	Tue,  9 Jan 2024 23:40:47 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 86C353C2E;
	Tue,  9 Jan 2024 23:40:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
References: <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com> <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: dhowells@redhat.com, pinskia@gmail.com,
    Alexey Dobriyan <adobriyan@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1681812.1704843645.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 09 Jan 2024 23:40:45 +0000
Message-ID: <1681813.1704843645@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

H. Peter Anvin <hpa@zytor.com> wrote:

> Hi all, I'm going to stir the hornet's nest and make what has become the
> ultimate sacrilege.

:-)

> Both C and C++ has had a lot of development since 1999, and C++ has in f=
act,
> in my personal opinion, finally "grown up" to be a better C for the kind=
 of
> embedded programming that an OS kernel epitomizes.

And gcc got rewritten in C++ some time back, so they have a vested interes=
t.

> >   (8) 'virtual'.  Don't want virtual base classes, though virtual func=
tion
> >       tables might make operations tables more efficient.
> =

> Operations tables *are* virtual classes. virtual base classes make sense=
 in a
> lot of cases, and we de facto use them already.

You end up adding storage for a 'this' pointer for each virtual base class=
, I
think - and then you may have extra fun if you inherit from two classes th=
at
both inherit the same virtual base class.  Abstract base classes that are =
just
ops tables are probably fine, though.

> > Issues:
> >   (1) Need spaces inserting between strings and symbols.
> =

> I have to admit I don't really grok this?

You're not allowed to do things like:

	asm volatile("btl "__percpu_arg(2)",%1"

but rather have to do:

	asm volatile("btl " __percpu_arg(2) ",%1"

as you're now allowed to specify type qualifiers.  See

	https://en.cppreference.com/w/cpp/language/user_literal

> >   (2) Direct assignment of pointers to/from void* isn't allowed by C++=
, though
> >       g++ grudgingly permits it with -fpermissive.  I would imagine th=
at a
> >       compiler option could easily be added to hide the error entirely=
.
> =

> Seriously. It should also enforce that it should be a trivial
> type. Unfortunately it doesn't look like there is a way to create user-d=
efined
> implicit conversions from one pointer to another (via a helper class), w=
hich
> otherwise would have had some other nice applications.

Might require a compiler option to kill the warning.  Inserting all the
missing casts would be a pain.

> >   (3) Need gcc v8+ to statically initialise an object of any struct th=
at's not
> >       really simple (e.g. if it's got an embedded union).
> =

> Worst case: constexpr constructor.

There was also a problem with leaving gaps in static array initialisation =
and
a problem with statically initialising fields out of order (with respect t=
o
the order they're declared in the struct declaration).  Possibly these hav=
e
been fixed in g++.

> >   (4) Symbol length.  Really need to extern "C" everything to reduce t=
he size
> >       of the symbols stored in the kernel image.  This shouldn't be a =
problem
> >       if out-of-line function overloading isn't permitted.
> =

> This really would lose arguably the absolutely biggest advantage of C++:
> type-safe linkage. This is the one reason why Linus actually tried to us=
e C++
> in one single version of the kernel in the early days (0.99.14, if I rem=
ember
> correctly.) At that time, g++ was nowhere near mature enough, and it got
> dropped right away.

I know.  It depends on how much you want to grow your symbol table by.  Gi=
ven
the number of struct pointers we use, it increases it a lot IIRC.  Also, y=
ou
might want a demangler for stack traces.

David


