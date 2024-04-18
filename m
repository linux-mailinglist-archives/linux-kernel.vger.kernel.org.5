Return-Path: <linux-kernel+bounces-150640-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2D68AA22B
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:41:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2E28B2833C1
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B12C178CEC;
	Thu, 18 Apr 2024 18:40:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IvFgHTqE"
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F10BA168B17
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 18:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465657; cv=none; b=j+Ir/6lyLNW1+UFA/oL2kZ4HUW0A6gVYLJiLv2KWyRkCAAiW8ZaobLlb/wXOwc5RK9JeGOCHtdGdRLgbvGLgg5H/Cr5uKd/ttQYbGhvehos52atkvgfUt3ToBtEUy9R0WMR8aw8qL2FEGoZQH9QPVgUMThL1LB8pW4HyBdmEmPU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465657; c=relaxed/simple;
	bh=lR0hLZUbsjj3GcSJpYo47XwMNLYuojYTD550yZuDF3E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yz+YuuEYBtqYRdE1PbgciG8sFexa/mayLrY9u89mGzhlVJ0GVSWUsXGcl1h4l0kbmB9wQtdc3P+2dF4wVEY63OpCrEt4EiLMO92UJgdM4yOwF5VvM9yjxnlNa2Tp8lIjfNx0tn4qmUU5jKUA3nbKuExbnM7NP4O6ShfSSMl5jaE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IvFgHTqE; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-617e6c873f3so13335977b3.2
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713465655; x=1714070455; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=seetPE2KeK1CN68gUAJv0CtvB48Q+mJYrWnip+JEkok=;
        b=IvFgHTqE7iwh3g9RqC90P9oS/hGdupYrS6PqUbRDKz/eTlYZB+sc6+Dcagx7fIWtdQ
         1aeP2ACjG2Kdw2vyzrcNRFTBShehsAOw9p0p4OTFig/GpY1edWp0J3ey/hXmezLzGwlV
         ardc7rGAzeGnRXnXdzJOF7es8WE1sbgGnQtrvxHmav5PgqWKqKfbR+x3/Tc/bPLCH+l+
         XZ4w1KOLWaOBry6a1pvNmLmJtItcrz1vV1u0oWXVmU5DcJ5aZG5ly9xzPITgASb6tyKp
         rukeSOHh3rX1HA4gLdqzlx0TtCsPeA1+bPdY0M5DMUZH/QVzPlxOakhFgsHGeeuYxpC7
         GlaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713465655; x=1714070455;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=seetPE2KeK1CN68gUAJv0CtvB48Q+mJYrWnip+JEkok=;
        b=PHZR+GcoCojPpu0ljHSjAlG+r5fFJTGk/PhJIika2W8Y7UFO9o6P4uDok68hu+EVhn
         Gkh6sgwNtSzX5SC77mHfY0knBimlQARk01fDCfJhGhV6ut4hMoVjHyMIL+42dSPlNav9
         U2bJ6zhYfFOX79vCIlbSAND+K/5ZlHA75WK+3Q/EE/FhzUJKtFpBRXXldyzgkSOywEjj
         j4WNWyW+nYsS+qqpHxTAaZS49yOl5wN6Gc2G1Y/GiiQi2pySjj0agZQ9I5INgbYG3PH0
         4b4SYlcDs7wigf/xi7d3LjXsn3ng86Bac0FCpn6ABKz35Ra+7+HLAV4WuROESJHooHGg
         g5Vw==
X-Forwarded-Encrypted: i=1; AJvYcCW4ZPg8y6u2RaRZG5bB4Vo2peQoR6pXwM+z/qItzPYgOR3ZGuGgjLhPGGSQTBU+Rn9b73n1BM2ZuViivjfdynez8Mtib4gO30hsw4gi
X-Gm-Message-State: AOJu0YxgsQldE1RG4xyoNEmIHlv/d87e6XgLeuMGivnbUPj+qUjalvj9
	GI7YKZQ85kdbpuAqimCqAMg9/MnrHHbeTP/mMSgtrfhh9gGeNGgS
X-Google-Smtp-Source: AGHT+IE5fN4duDmYMg6UbiT0Fw7fgJewLsU82DJN7GD8qIsmklxjBtedLyGLnPcr4JJ0uHNHGzuvIw==
X-Received: by 2002:a05:690c:600c:b0:61a:cd65:3010 with SMTP id hf12-20020a05690c600c00b0061acd653010mr3924705ywb.30.1713465654862;
        Thu, 18 Apr 2024 11:40:54 -0700 (PDT)
Received: from fedora ([2600:1700:2f7d:1800::49])
        by smtp.gmail.com with ESMTPSA id j124-20020a819282000000b0061ad87eaf80sm452976ywg.0.2024.04.18.11.40.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 11:40:53 -0700 (PDT)
Date: Thu, 18 Apr 2024 11:40:51 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: syzbot <syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in
 __vma_reservation_common
Message-ID: <ZiFpM5SnIs_2MrDr@fedora>
References: <000000000000daf1e10615e64dcb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="urpZk1QQExwzJ82G"
Content-Disposition: inline
In-Reply-To: <000000000000daf1e10615e64dcb@google.com>


--urpZk1QQExwzJ82G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Apr 12, 2024 at 06:32:33AM -0700, syzbot wrote:
> Hello,
> 
> syzbot found the following issue on:
> 
> HEAD commit:    11cb68ad52ac Add linux-next specific files for 20240408
> git tree:       linux-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=13a6f483180000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=727d5608101b5d77
> dashboard link: https://syzkaller.appspot.com/bug?extid=ad1b592fc4483655438b
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
> 
> Unfortunately, I don't have any reproducer for this issue yet.
> 
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/4e90f2d3b1ef/disk-11cb68ad.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/d886b454e2cc/vmlinux-11cb68ad.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/ed94857c6f92/bzImage-11cb68ad.xz
> 
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git
linus

--urpZk1QQExwzJ82G
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment;
	filename="0001-hugetlb-Check-for-anon_vma-prior-to-folio-allocation.patch"

From 8973cb789bbf64c35ca898541acf3aa6ee8ea2a4 Mon Sep 17 00:00:00 2001
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
CC: stable@vger.kernel.org
Reported-by: syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com
Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
---
 mm/hugetlb.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 23ef240ba48a..948d197cd88f 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6274,6 +6274,12 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 							VM_UFFD_MISSING);
 		}
 
+		if (!(vma->vm_flags & VM_MAYSHARE)) {
+			ret = vmf_anon_prepare(vmf);
+			if (unlikely(ret))
+				goto out;
+		}
+
 		folio = alloc_hugetlb_folio(vma, haddr, 0);
 		if (IS_ERR(folio)) {
 			/*
@@ -6310,15 +6316,12 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
 				 */
 				restore_reserve_on_error(h, vma, haddr, folio);
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


--urpZk1QQExwzJ82G--

