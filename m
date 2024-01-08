Return-Path: <linux-kernel+bounces-20133-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7692827A52
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 22:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5E11DB22CCF
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 21:41:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C09356459;
	Mon,  8 Jan 2024 21:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fpKn6COD"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138F55644F
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 21:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704750098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PouS+fcfRBFYHLc59Q6jvOZOpQHzKSFm7NNqEvCIUk8=;
	b=fpKn6CODj83irOHMxu8+seNQQlK3LCOcZTwTetwljPVf0E9lbVn0GuM0r3FIRgQ71ZsOjU
	yc7v73gAK9Bu7uk77aAR40F9xYbykida4Y8dkReZ816xtSu6/VfON4jl/WiA8ecRQ5qQy8
	Vhc5BFhZG1h1JbOiat+rZmbhHWIY864=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-18-xSjPy8pPM0Sj570e6fr0mA-1; Mon,
 08 Jan 2024 16:41:37 -0500
X-MC-Unique: xSjPy8pPM0Sj570e6fr0mA-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3B96B3C02B64;
	Mon,  8 Jan 2024 21:41:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8342B492BC7;
	Mon,  8 Jan 2024 21:41:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAKXUXMzXN=+hKDPP-RdHKELA_fGA6PcdCj5fXM32qh4Px0Hprg@mail.gmail.com>
References: <CAKXUXMzXN=+hKDPP-RdHKELA_fGA6PcdCj5fXM32qh4Px0Hprg@mail.gmail.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: dhowells@redhat.com, linux-cachefs@redhat.com,
    linux-fsdevel <linux-fsdevel@vger.kernel.org>,
    Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reference to non-existing CONFIG_NETFS_FSCACHE
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1542012.1704750095.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jan 2024 21:41:35 +0000
Message-ID: <1542013.1704750095@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> In commit 62c3b7481b9a ("netfs: Provide a writepages implementation"),
> you have added some code that is included under #ifdef
> CONFIG_NETFS_FSCACHE, but if I read the code correctly, the actual
> intended config here is called CONFIG_FSCACHE.

Yeah - it should be the latter.  Something like the attached patch should =
fix
it.

David
---
netfs: Fix wrong #ifdef hiding wait

netfs_writepages_begin() has the wait on the fscache folio conditional on
CONFIG_NETFS_FSCACHE - which doesn't exist.

Fix it to be conditional on CONFIG_FSCACHE instead.

Fixes: 62c3b7481b9a ("netfs: Provide a writepages implementation")
Reported-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-afs@lists.infradead.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_write.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 0b2b7a60dabc..de517ca70d91 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -1076,7 +1076,7 @@ static ssize_t netfs_writepages_begin(struct address=
_space *mapping,
 		folio_unlock(folio);
 		if (wbc->sync_mode !=3D WB_SYNC_NONE) {
 			folio_wait_writeback(folio);
-#ifdef CONFIG_NETFS_FSCACHE
+#ifdef CONFIG_FSCACHE
 			folio_wait_fscache(folio);
 #endif
 			goto lock_again;


