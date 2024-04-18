Return-Path: <linux-kernel+bounces-150647-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 275308AA23E
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 20:45:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 933F61F214BF
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Apr 2024 18:45:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D31317AD8C;
	Thu, 18 Apr 2024 18:45:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="G9VQxbZr"
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2979A168B17
	for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 18:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713465935; cv=none; b=M6UNO+rk2IsqlWIXLflHLUIxq3FrBxJgKdPs08FRB6XQHZjJ4tX8PRtu/iAUjSLSnG9BKcT8fnuidQ3WOTTYT3adTW6FVflXRBdYtXASaJ3kVqcZHrJKh1VoYQzdp4R9oRyLlas9VDz7L4sUmNnXexMn9AmRMmJ06ofmkgQRETA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713465935; c=relaxed/simple;
	bh=6DlaHCpndY6XaJvSwdksWPmtb4u1FJgT/3nZxgAFFN8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NSWzg2r96og03pQKRik/l5gIHxEx6jeH6TfH5Yxf8vhzqJ7fGJkz472Lqf8JmjaxNHzCnotGWRkSYlWcC/B27Z5OFRX7v7Dhh2WxcdYGjt8VvsRdBvC5LkvDLEeFFRsQVOx8VhW4Qp+cEQ1DLtlFxM83j+8zrzJLK3nm9/8CQi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=G9VQxbZr; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-61af74a010aso13001717b3.0
        for <linux-kernel@vger.kernel.org>; Thu, 18 Apr 2024 11:45:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713465933; x=1714070733; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pWlPuQVrcxAJuHxDJ7v28B9q4SkzWJBaWW1iwjmpTDA=;
        b=G9VQxbZrh4pYu9TE7ZhdslwN2KlhBufi4rAd36k4nDSzbzHHmdIWc5Pl2iJNjYpHxL
         Bcq8FM0+7nfJ1HDSt1dA/bEzbBbJaqRLC21AJOAEOggm4+maw5kf/VNBUDvqiXSfWkAU
         dIPchU7+1g5RHFBDveIhO934TOGgQIpIqMA1DgfCsaZ4jfq8Z8GYG0qwXfZSMS6Bj2Jp
         8edzX2uNpX74KfV0R7esKFlYTg9OATnG3ivgPnHLKVJt8Lyr/b/iUoMmUxN2ZUwtR6Hm
         M7PbFK9dNFtfojGkw5cbsozQD/tGgLyXIn+lMuSUVszOt2jwcdYA0Lm6R2IGVidnj8jG
         dUbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713465933; x=1714070733;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pWlPuQVrcxAJuHxDJ7v28B9q4SkzWJBaWW1iwjmpTDA=;
        b=LVh2uKEyHEn8RXqia0RvU4UCtIrJQDpZi9Auy9tU5NvyJOlnaQDw87jTslob/Jt3tD
         BhN1G0VM97GvLu2Z3DhKm72KGV5FhMiRJLhwrBz0AfP7mne+NcxKT9xghhISLbrYViLk
         oVE/zX/CzD8PsSJlZRwVo09wToQITnHNDhhJ0KzzLsJOmdbq1vvdjR6qep2Xf5nf9MQB
         35zDue6A7rO4wpiB8M+p1EbcWg5X3dXq6dgJHB88v4xj9F1DaH9n4RREvBras9a+aX0V
         TVfjlSaJAhid7nzI5uTB2Xp4o8l6lCzoi/Iel3fIohd5sP1oOMtVwHKdNL6IGDCivNt7
         8Q9A==
X-Forwarded-Encrypted: i=1; AJvYcCWU8wVuuNz7UKdA4NdY8M09TTtXRhCLefcNnycJEs3xNg9ko+vP+1JlS/dK4vL6nmLS6cW7i2R4f+lT1pRUWG/Tnp4GcyBWKaFKBvbz
X-Gm-Message-State: AOJu0Yxv5lr/rSJGa0h7XLhwG94svipfTov1hDBVsor2ED0EKLiKfyM1
	2WN9F4ENtE82kNTC8W5VSMBYsFrkSLUPggBsQfxzeV7G0o9CD5MmHutiIw==
X-Google-Smtp-Source: AGHT+IFO+kNrI9k7Cra9Jq3XFbz0xX1GmY19DZ7QvNt2iATqWVXjtsHLq4Kk20/pt+zm+ooQHqCUbg==
X-Received: by 2002:a05:690c:88f:b0:61b:123e:7210 with SMTP id cd15-20020a05690c088f00b0061b123e7210mr3736512ywb.40.1713465933077;
        Thu, 18 Apr 2024 11:45:33 -0700 (PDT)
Received: from fedora ([2600:1700:2f7d:1800::49])
        by smtp.gmail.com with ESMTPSA id w66-20020a817b45000000b0061521b0bb33sm443127ywc.63.2024.04.18.11.45.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Apr 2024 11:45:32 -0700 (PDT)
Date: Thu, 18 Apr 2024 11:45:30 -0700
From: Vishal Moola <vishal.moola@gmail.com>
To: syzbot <syzbot+ad1b592fc4483655438b@syzkaller.appspotmail.com>
Cc: akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, muchun.song@linux.dev,
	syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] [mm?] KASAN: slab-use-after-free Read in
 __vma_reservation_common
Message-ID: <ZiFqSrSRLhIV91og@fedora>
References: <000000000000daf1e10615e64dcb@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="p+haZl/smbkDZq3d"
Content-Disposition: inline
In-Reply-To: <000000000000daf1e10615e64dcb@google.com>


--p+haZl/smbkDZq3d
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

#syz test https://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm.git linus

--p+haZl/smbkDZq3d
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


--p+haZl/smbkDZq3d--

