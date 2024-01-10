Return-Path: <linux-kernel+bounces-21580-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9823282916B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 01:30:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B95DE1C2310C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 00:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BF2A63DF;
	Wed, 10 Jan 2024 00:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cnD/Opmn"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FACC6116
	for <linux-kernel@vger.kernel.org>; Wed, 10 Jan 2024 00:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704846569;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3UBCSAP+i4rFiL/6w+6TRuBgPaXgWBvM8cIe5uHLFsI=;
	b=cnD/OpmnzbShIlSU4hg2KWUQb1VjAaLDwQEK8s6f1sy0u6NXzbZ/EsvkP/6hBtAmZs/+/k
	VtWB0pcRhAMsLOqiWDq6fQTXB2A8Vj2QODoBenVakC3zBIOMlRjplPoWD7SIn4erTjETlr
	iYBpwnm5npwViQotATcc3RGJerXXfTQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-rRqSgByQNiiaVW-p7jmNbQ-1; Tue, 09 Jan 2024 19:29:25 -0500
X-MC-Unique: rRqSgByQNiiaVW-p7jmNbQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9EACB82DFE4;
	Wed, 10 Jan 2024 00:29:25 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 182D6492BC7;
	Wed, 10 Jan 2024 00:29:24 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CA+=Sn1n18OmcDzDrZky_KqMW76ttTLGnMYnH5CPg7m9SXor1qQ@mail.gmail.com>
References: <CA+=Sn1n18OmcDzDrZky_KqMW76ttTLGnMYnH5CPg7m9SXor1qQ@mail.gmail.com> <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk> <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
To: Andrew Pinski <pinskia@gmail.com>
Cc: dhowells@redhat.com, "H. Peter Anvin" <hpa@zytor.com>,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1682636.1704846564.1@warthog.procyon.org.uk>
Date: Wed, 10 Jan 2024 00:29:24 +0000
Message-ID: <1682637.1704846564@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Andrew Pinski <pinskia@gmail.com> wrote:

> Note even in GCC, we disable exceptions and RTTI while building GCC.
> This is specifically due to not wanting to use them and use other
> methods to do that.
> Note GDB on the other hand used to use setjmp/longjmp for their
> exception handling in C and I think they moved over to using C++
> exceptions which simplified things there. But as far as I know the
> Linux kernel does not use a mechanism like that (I know of copy
> from/to user using HW exceptions/error/interrupt handling but that is
> a special case only).

If we were to allow exception handling, I wonder if we would actually need to
throw anything other than a signed long integer (e.g. an error code) and just
disable RTTI.  Maybe something like:

	long sys_rename(...)
	{
		struct rwsem_lock lock_a, lock_b;
		struct inode *dir_a, *dir_b;
		...
		try {
			if (dir_a > dir_b) {
				lock_a.down_write_killable(dir_a);
				lock_b.down_write_killable(dir_b);
			} else {
				lock_b.down_write_killable(dir_b);
				lock_a.down_write_killable(dir_a);
			}
		} catch (-EINTR) {
			throw -ERESTARTSYS;
		}
		...
	}

then have a cut-down exception unwinder that only needs to deal with long
values.

However, I think rolling out exception handling in the kernel might be too big
a task, given the huge amount of code involved - however much we might like to
avoid all those return value checks.

David


