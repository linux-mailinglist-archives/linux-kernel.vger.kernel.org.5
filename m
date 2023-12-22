Return-Path: <linux-kernel+bounces-10063-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A150981CF57
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 21:41:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 404AF1F22456
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 20:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 426262E84B;
	Fri, 22 Dec 2023 20:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ii/BQS/r"
X-Original-To: linux-kernel@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F32E32E82B
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 20:41:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703277672;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type;
	bh=ZVKuVqui5GBClDiAGi7QmgUs8/59xw2Hq2GF0X1cLYg=;
	b=Ii/BQS/rmYD1p5lMrMnBWwfFNKqqnMFf3+/iGVlp2EZaw+L+X5sIAVhb2VsitvMfe724e8
	RO8costuqIs42DahL2gXJVNi/FKetyCBgIKZnSbjTC0z3YocWoy63nPnF31W+has8K+UYX
	a7rqorD+9NPNEe/in3GcLgqXmiojubM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-404-gEVoSHwdNlGi4dQp19aYoQ-1; Fri, 22 Dec 2023 15:41:09 -0500
X-MC-Unique: gEVoSHwdNlGi4dQp19aYoQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id EC064185A780;
	Fri, 22 Dec 2023 20:41:08 +0000 (UTC)
Received: from localhost (unknown [10.22.8.75])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5ACF2492BE6;
	Fri, 22 Dec 2023 20:41:08 +0000 (UTC)
Date: Fri, 22 Dec 2023 17:41:07 -0300
From: "Luis Claudio R. Goncalves" <lgoncalv@redhat.com>
To: LKML <linux-kernel@vger.kernel.org>,
	linux-rt-users <linux-rt-users@vger.kernel.org>,
	stable-rt <stable-rt@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Carsten Emde <C.Emde@osadl.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Daniel Wagner <daniel.wagner@suse.com>,
	Tom Zanussi <tom.zanussi@linux.intel.com>,
	Clark Williams <williams@redhat.com>,
	Mark Gross <markgross@kernel.org>, Pavel Machek <pavel@denx.de>,
	Jeff Brady <jeffreyjbrady@gmail.com>,
	Luis Goncalves <lgoncalv@redhat.com>
Subject: [ANNOUNCE] 5.10.204-rt100
Message-ID: <ZYX0Y_lbe8hNUNnj@uudg.org>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

Hello RT-list!

I'm pleased to announce the 5.10.204-rt100 stable release.

This release is an RT-only update.
The only change in this release is specific to RT:

    rt: mm/page_alloc: backport missing bits from __build_all_zonelists() fix
    
    A while ago upstream landed commit a2ebb51575828 ("mm/page_alloc: use
    write_seqlock_irqsave() instead write_seqlock() + local_irq_save().")
    to fix a problem that had already been worked on v5.10-rt via commit
    7bdd3bd5143a4 ("Revert "mm/page_alloc: fix potential deadlock on
    zonelist_update_seqseqlock""). Sebastian pointed out it was important
    to backport the missing elements of a2ebb51575828 for code consistency.
    
You can get this release via the git tree at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rt/linux-stable-rt.git

  branch: v5.10-rt
  Head SHA1: 3f1186be09688c4aedf2d61176990651cf996c75

Or to build 5.10.204-rt100 directly, the following patches should be applied:

  https://www.kernel.org/pub/linux/kernel/v5.x/linux-5.10.tar.xz

  https://www.kernel.org/pub/linux/kernel/v5.x/patch-5.10.204.xz

  https://www.kernel.org/pub/linux/kernel/projects/rt/5.10/older/patch-5.10.204-rt100.patch.xz

Signing key fingerprint:

  9354 0649 9972 8D31 D464  D140 F394 A423 F8E6 7C26

All keys used for the above files and repositories can be found on the
following git repository:

   git://git.kernel.org/pub/scm/docs/kernel/pgpkeys.git

Enjoy!
Luis

Changes from v5.10.204-rt99:
---

Luis Claudio R. Goncalves (1):
      rt: mm/page_alloc: backport missing bits from __build_all_zonelists() fix
---
 mm/page_alloc.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
---
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 39d1782b398f..cd1e8d0b2269 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -6043,8 +6043,9 @@ static void __build_all_zonelists(void *data)
 	int nid;
 	int __maybe_unused cpu;
 	pg_data_t *self = data;
+	unsigned long flags;
 
-	write_seqlock(&zonelist_update_seq);
+	write_seqlock_irqsave(&zonelist_update_seq, flags);
 
 #ifdef CONFIG_NUMA
 	memset(node_load, 0, sizeof(node_load));
@@ -6077,7 +6078,7 @@ static void __build_all_zonelists(void *data)
 #endif
 	}
 
-	write_sequnlock(&zonelist_update_seq);
+	write_sequnlock_irqrestore(&zonelist_update_seq, flags);
 }
 
 static noinline void __init


