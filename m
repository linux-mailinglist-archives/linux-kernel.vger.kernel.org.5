Return-Path: <linux-kernel+bounces-24436-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2789982BC83
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 09:52:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B45491F26A4E
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Jan 2024 08:52:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ED0B53E35;
	Fri, 12 Jan 2024 08:52:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HN9GaIYR"
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B25562A
	for <linux-kernel@vger.kernel.org>; Fri, 12 Jan 2024 08:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705049529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EDdfOvV+4784FLJ0qEaQ5pTw49maq5I10+FoEROdaJg=;
	b=HN9GaIYRntprs+FldAh/N+Ptb3PcXZL+trzopTRy6usijDymBL60LKoNG4gfVN4iqay1bo
	m1SV7BBv94zVcts8HmjQpC0Jr6iGGsYW/dCcg15KW4AEkODBy8aAi/+We/bYgcwV/o42CR
	McEEeUuvtzPIN23SD4lKtEWvQQlUkMw=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-R9aKxxDgOKaEa7VvkeRM3g-1; Fri, 12 Jan 2024 03:52:05 -0500
X-MC-Unique: R9aKxxDgOKaEa7VvkeRM3g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C620385A58B;
	Fri, 12 Jan 2024 08:52:04 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.67])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 2C878C19060;
	Fri, 12 Jan 2024 08:52:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <49231a98-d39f-4920-8d9f-e60aa014f518@zytor.com>
References: <49231a98-d39f-4920-8d9f-e60aa014f518@zytor.com> <152261521484.30503.16131389653845029164.stgit@warthog.procyon.org.uk> <3465e0c6-f5b2-4c42-95eb-29361481f805@zytor.com>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: dhowells@redhat.com, linux-kernel@vger.kernel.org, pinskia@gmail.com
Subject: Re: [PATCH 00/45] C++: Convert the kernel to C++
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2153665.1705049523.1@warthog.procyon.org.uk>
Date: Fri, 12 Jan 2024 08:52:03 +0000
Message-ID: <2153666.1705049523@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

H. Peter Anvin <hpa@zytor.com> wrote:

> One thing I forgot to mention that would be quite useful is careful use of
> namespaces.

Just be aware that the use of namespaces would make the kernel image bigger if
symbols are included.

David


