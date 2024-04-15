Return-Path: <linux-kernel+bounces-145961-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 38BF58A5D96
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Apr 2024 00:05:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9223284BF9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Apr 2024 22:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D10C15749B;
	Mon, 15 Apr 2024 22:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U0iQ8X9U"
Received: from mail-yw1-f178.google.com (mail-yw1-f178.google.com [209.85.128.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F3A125601
	for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 22:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713218749; cv=none; b=VR95MEL5Qmbsrt3weZKfDJbtni2uQ7l9405eOfsON32SeqR9JV7IXVd8yF/w7J8EG3z+dvkCpp110bZsnFAMNPBcifKfrKAvU2XZlQaZi9LSVfk6KnMp9IOesCaOfYLCYRpbc0lW3W5PWTAIM7gjADrRCGHuP/pfhr5XTkC3adk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713218749; c=relaxed/simple;
	bh=QTxgFSqq/Z7peU07MOT3I9Lu+2QSKKPQbBN++p6wqxQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gFtqcQh7p66bgOthKUiR0EsPqUfFVoXKO2hIib/x2i7KXfK5FCagioPCck/hriNnOKRR8+pKe3UcaICLoxciyP/9YzL/FqnNjqmi15kYMmg053ZSdB65wjpRB80W12dQt7mJxGiQ2skO96YybTPgkzvdzpGxzmKXMqdAznyzfPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U0iQ8X9U; arc=none smtp.client-ip=209.85.128.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-6181d032bf9so37364667b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 15 Apr 2024 15:05:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713218747; x=1713823547; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ssAZ3DyyJxSLg2CIY1KbdXyk9av2RuE+1b4L9bpyewM=;
        b=U0iQ8X9UaKu/5Jl8ayu0YtJXrVblHJW5A+1nL/87o6vFCkr7InhSoKRiRmbhpHcbma
         ZbOV1cieO5xcFbb92jkGyqOYxKiZ8jfNs8WAUBEHQflSaN6qFqUEYBVgUq1wlL3L4beZ
         DY85RJ7SCX+pSyuh7+TalD5DrB/8u8wM6MGlCbCoc7KvIsdYXnlKWafkf3h1VgCGhQnM
         LmxzkJmkUBCVOLljalIkap59+LfwBzik6cRY6yWB3N9WO0CifspE+soXh5DKgpQSuxDE
         hEOgD7mysWQ9OIv9MjyxxZKtL+OVjrdmVofU77FrnPAD7qBpYwpZUFw3h1Bc8cq6rfPG
         UcpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713218747; x=1713823547;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ssAZ3DyyJxSLg2CIY1KbdXyk9av2RuE+1b4L9bpyewM=;
        b=D7JwHEJvdorTOwPioNhajoOTJq/g9gf1or0m3expEnbcNgHiGEBEgYgWolt65eiNRg
         nW2xZ1CJntdPuC69sDGTi+FukpwCAYldmye872x7g7SIrMhay04I5fLmU+GOiJXMoWsc
         2QLSEXMK8WW8gV4MYwxj3JjHgqo5bLPrNVITNYjitg07ajdWwLsrXLwgpJr2cEW+QWo8
         fry/jthzYKvXuYiBYl5H2V/3rs0/UmBUtWxIsbPoNaCvdgfIeD9XBgng92/8wdxfqxie
         +uPOdE83O/c8jkaIuaD0WozbBMXxQ9+WMJIhCWI5836iIm48sNjO0LuvkSI2STHvNz5k
         zzrw==
X-Forwarded-Encrypted: i=1; AJvYcCWYh4jI44ocKBk1Va3N6RIt6ZfPKGza/cuAM/DkNkff1ioVJorMaxODVtTSq+DA/hD3CLHY3uPuSxloHBMeqMdLFELxuu9J8/xFm2vs
X-Gm-Message-State: AOJu0YwWJ7S5VRpqifcbEoErNNN3r5I5KRHBGAqmO1pDqoRB5w1gqv/f
	sNzfJaJ4bmkm+8Rb1qshTnNf3APbnDyduM+fpN/IctB32yo+ROSS
X-Google-Smtp-Source: AGHT+IHDcVWPGZHGgYYhD+XagVKlxDL0u1KvWGhu+T+SfQaSlOltJ6EPfD4ADqnUN/f/CUzxAWuGtQ==
X-Received: by 2002:a81:b207:0:b0:61a:d39a:1aa6 with SMTP id q7-20020a81b207000000b0061ad39a1aa6mr3091255ywh.51.1713218747250;
        Mon, 15 Apr 2024 15:05:47 -0700 (PDT)
Received: from fedora ([2600:1700:2f7d:1800::23])
        by smtp.gmail.com with ESMTPSA id p206-20020a0de6d7000000b0061ac20feee8sm806636ywe.111.2024.04.15.15.05.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Apr 2024 15:05:46 -0700 (PDT)
Date: Mon, 15 Apr 2024 15:05:44 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: syzbot <syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in
 __vma_reservation_common
Message-ID: <Zh2kuFX9BWOGN1Mo@fedora>
References: <000000000000daf1e10615e64dcb@google.com>
 <000000000000ae5d410615fea3bf@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="nyCCuuGrGXDMVrWo"
Content-Disposition: inline
In-Reply-To: <000000000000ae5d410615fea3bf@google.com>


--nyCCuuGrGXDMVrWo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Apr 13, 2024 at 11:34:32AM -0700, syzbot wrote:
> syzbot has found a reproducer for the following issue on:
> 
> HEAD commit:    9ed46da14b9b Add linux-next specific files for 20240412
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=12bd4457180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=7ea0abc478c49859
> dashboard link: https://syzkaller.appspot.com/bug?extid=ad1b592fc4483655438b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1370ea67180000

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git 9ed46da14b9b

--nyCCuuGrGXDMVrWo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-hugetlb-Check-for-anon_vma-prior-to-folio-allocation.patch"

From fb3415a90a2b2a6fdbe4a5f32370f06141591011 Mon Sep 17 00:00:00 2001
From: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Date: Mon, 15 Apr 2024 14:17:47 -0700
Subject: [PATCH] hugetlb: Check for anon_vma prior to folio allocation

Commit 9acad7ba3e25 ("hugetlb: use vmf_anon_prepare() instead of
anon_vma_prepare()") may bailout after allocating a folio if we do not
hold the mmap lock. When this occurs, vmf_anon_prepare() will release the
vma lock. Hugetlb then attempts to call restore_reserve_on_error(),
which depends on the vma lock being held.

We can move vmf_anon_prepare() prior to the folio allocation in order to
avoid calling restore_reserve_on_error() without the vma lock.

Fixes: 9acad7ba3e25 ("hugetlb: use vmf_anon_prepare() instead of anon_vma_prepare()")
Reported-by: syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/hugetlb.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index f826dc681081..fbd278a2e9f6 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6271,6 +6271,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 							VM_UFFD_MISSING);
 		}
 
+		ret = vmf_anon_prepare(vmf);
+		if (unlikely(ret))
+			goto out;
+
 		folio = alloc_hugetlb_folio(vma, vmf->address, 0);
 		if (IS_ERR(folio)) {
 			/*
@@ -6310,15 +6314,12 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 				restore_reserve_on_error(h, vma, vmf->address,
 							folio);
 				folio_put(folio);
+				ret = VM_FAULT_SIGBUS;
 				goto out;
 			}
 			new_pagecache_folio = true;
 		} else {
 			folio_lock(folio);
-
-			ret = vmf_anon_prepare(vmf);
-			if (unlikely(ret))
-				goto backout_unlocked;
 			anon_rmap = 1;
 		}
 	} else {
-- 
2.43.0


--nyCCuuGrGXDMVrWo--

