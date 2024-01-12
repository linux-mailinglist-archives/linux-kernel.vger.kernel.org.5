Return-Path: <linux-kernel+bounces-25107-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 67DA382C808
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Jan 2024 00:41:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1575D1F23714
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 23:41:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C87C1A5AE;
	Fri, 12 Jan 2024 23:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ltq9axD5"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A1101A598
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 23:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705102883;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=U7q71AgIZkys1tWLEpL5HdW3S3RRvPb/I6Cmgv2h/DQ=;
	b=Ltq9axD5GeFSQ5Tm+5hj9vvfJNdg+vmFvI9okscRgjhh1YvBCcDCFwc1sx4HY6us4QXgHz
	scNwgSwTd9eY7DHfq8rPTvx6F8S7CtMeGZDnhXC3f13uM1nSRjcrk2qDZk/5iG5VBMnFIU
	Or1NprNP+gh0kRQL2IRiSjwliqsbZ5E=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-396-4_zyDzLJPxi1Y6egJm-dug-1; Fri, 12 Jan 2024 18:41:18 -0500
X-MC-Unique: 4_zyDzLJPxi1Y6egJm-dug-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 88E2382DFE1;
	Fri, 12 Jan 2024 23:41:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 1CB95C25AC8;
	Fri, 12 Jan 2024 23:41:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <8634v2jh9s.fsf@aarsen.me>
References: <8634v2jh9s.fsf@aarsen.me> <86r0inmpbm.fsf@aarsen.me> <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk> <2154236.1705051203@warthog.procyon.org.uk>
To: Arsen =?us-ascii?Q?=3D=3Futf-8=3FQ=3FArsenovi=3DC4=3D87=3F=3D?= <arsen@aarsen.me>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jan 2024 23:41:17 +0000
Message-ID: <2389650.1705102877@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Arsen Arsenovi=C4=87 <arsen@aarsen.me> wrote:

> >> >  (7) 'class', 'private', 'namespace'.
> >>
> >> 'class' does nothing that struct doesn't do, private and namespace ser=
ve
> >> simply for encapsulation, so I don't see why banning these is useful.
> >
> > Namespaces would lead to image bloat as they make the symbols bigger.
> > Remember, the symbol list uses up unswappable memory.
>=20
> Ah, I was not aware of this restriction of the kernel (my understanding
> was that the symbol table is outside of the kernel image).  That poses a
> problem, yes.  I wonder if a big part of the symbol table (or even the
> entirety of it) could be dropped from the kernel.  I must say, I do not
> know why the kernel has it, so I cannot speak on this issue.

You need at least a partial symbol table for module loading and we also have
the symbol table optionally included for oops message generation.

David


