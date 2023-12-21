Return-Path: <linux-kernel+bounces-8441-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3079C81B733
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 14:19:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D42F1C243A4
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Dec 2023 13:19:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC82A745D3;
	Thu, 21 Dec 2023 13:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OYi7hCq9"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E679745CD
	for <linux-kernel@vger.kernel.org>; Thu, 21 Dec 2023 13:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703164758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D2ohWlgIJHuTnnOW+YkeJQK3jRdgNiZC8Tevy1gSvb8=;
	b=OYi7hCq9saRI88mFDmdnI2OsJWmhPI2ZYOcJuzXRGwKzXVTfjbB+BqULQSlhsFcc31FYhF
	3iy3eY5MWLwN23tdfMypLnobQQXZkFSt3V8HCHX7YtZ4LibA4PTwucJEmAgW39AyX+An2k
	apqVzZz6zPHb5Acq0GGkWqVF/IZw1YI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-97-Cx_w8fHUNH-mvIQlEwDw4Q-1; Thu,
 21 Dec 2023 08:19:13 -0500
X-MC-Unique: Cx_w8fHUNH-mvIQlEwDw4Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 34723280D464;
	Thu, 21 Dec 2023 13:19:13 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 36F383C25;
	Thu, 21 Dec 2023 13:19:12 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20231221184856.71d71623@canb.auug.org.au>
References: <20231221184856.71d71623@canb.auug.org.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: dhowells@redhat.com, Christian Brauner <brauner@kernel.org>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
    Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the vfs-brauner tree
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1601737.1703164751.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Thu, 21 Dec 2023 13:19:11 +0000
Message-ID: <1601738.1703164751@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.1

Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> =

> After merging the vfs-brauner tree, today's linux-next build (s390
> defconfig) produced this warning:
> =

> arch/s390/configs/defconfig:626:warning: symbol value 'm' invalid for FS=
CACHE
> =

> Introduced by commit
> =

>   9896c4f367fc ("netfs, fscache: Combine fscache with netfs")

I've fixed the arches that had FSCACHE=3Dm to have NETFS_SUPPORT=3Dm and
FSCACHE=3Dy.

David


