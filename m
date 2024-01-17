Return-Path: <linux-kernel+bounces-29488-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E281830F41
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 23:38:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C01BAB24BC4
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Jan 2024 22:38:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8764425639;
	Wed, 17 Jan 2024 22:37:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ok3Hd9sQ"
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D69C1E887
	for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 22:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705531060; cv=none; b=IsQezfR3ES5Xd1r+tyHXtzBUhoiuvcHSrP3hjL9MGDxiO32ZzXZ5ViWhl6/O0rIus9jZx+BPHvEo4sg+Ga3MuwHz6qlSYP9ANnN/wlv8omwja1UatpMfg8+/n18BSwfii+sZt2faRJ73CI0fqZ4v3L9jL7HErG0vaAl/XbNvwT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705531060; c=relaxed/simple;
	bh=1PCGZ1uJiBtLoi7xA68BT5A/oeoNiduCk3gfJe1K/aI=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:Date:
	 Mime-Version:X-Mailer:Message-ID:Subject:From:To:Cc:Content-Type;
	b=B8AIgGsLaRjXZXOUxlMYReMC+E6dmx4Ts61j/UlHwbAODnzsGH1/7gHkf3deh0JY1weeNVgbayggDAjJ3b2+7TK6KS7pLObZYeqogLnX3eb5qXmEo46KAdB5uVlg4k7D4bYrGe9BjtMErVkZ4A9z4vpHzbNBDFSdKOMBZ1yvR3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=Ok3Hd9sQ; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--lokeshgidra.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dbe9e13775aso15760490276.1
        for <linux-kernel@vger.kernel.org>; Wed, 17 Jan 2024 14:37:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705531058; x=1706135858; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qtcsSAi8pdfsx6Ojh55+8gPZOJc0hPQeptf8eZpqdHg=;
        b=Ok3Hd9sQ9D7vhb9N5JOxwYsb9vDc0LJN1SJS1xq4O4VOZS2uBDFUwjO/WVsL2aKD/R
         AwiehzjV6X70hTCPJckxsWBKkIMlTL90o9Gs2fo3jI0fFFc2iUwORnwBLsax728nwZLY
         d9Zj3meyfeqduY+yfwzNDJ4EOWxpby+mXhysYENtW3aWaq+bDq7jPD1VjEi0vFjs9M6h
         xf3eB1FTPxav5tzcIC0AcoChW9fYdyw7j63p4HqzrKsf6Pw/Q2HHaFvqzX+WlYt9/ytT
         RxB2oyW9Tuepnbz6r6l4Y9O67lPGJRaOwZqM5rYsulDx9AyC2sLpm5j0vOZX2xM0TN/v
         T2Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705531058; x=1706135858;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qtcsSAi8pdfsx6Ojh55+8gPZOJc0hPQeptf8eZpqdHg=;
        b=ZuJhqkadgtpEkgwXx6332WMZmo3eFMQDU+mXdJaRqCm1qNcvZhbm+AG+e43pVZIjwA
         pVdo+LxjXx39vSDT4ilO4OSy4bhJ6CK9hMD17nnuyf3rspsXriu9M87/hotB+nxRLC/g
         /JK1VhnPzZlNimU+8A6t68HfdIv6yfJazI0xC6qLoQJldgaPrWGBYcYsQWjZ0ywPvCrM
         ALmYo+AkgWzhsjrPPQ5Aw8ZpgiPqKyaJPnssEWlbrOQdQPwx3v/pHquy81h03c+HyLjN
         z9urdEcIKlUSOB3f3YhkDcchhZ4G2HXPK+UnwICIdGvSQsQKoifW24mJeOTKkkNW1jtP
         USDA==
X-Gm-Message-State: AOJu0YwI2eJ6R/xWllwQS/TA1PWlk5I3bF4nGOmxnoOlwrq0AdDnNo6N
	Cg2S3b0uNFmW/0beC5ZoQAusmtvEy7BAA3xeAeGlfpXO
X-Google-Smtp-Source: AGHT+IEHkEc2SNjgZpjAMRGfksbyD0+FFJUxQNmhwyp5v2dGwz3Ua29YR2phjpTtpCOeyHZkxZBYOa5Q8VSwmMY5Jw==
X-Received: from lg.mtv.corp.google.com ([2620:15c:211:202:9c18:2400:c024:5c4e])
 (user=lokeshgidra job=sendgmr) by 2002:a25:81c6:0:b0:dc2:23d8:722d with SMTP
 id n6-20020a2581c6000000b00dc223d8722dmr1380648ybm.13.1705531058526; Wed, 17
 Jan 2024 14:37:38 -0800 (PST)
Date: Wed, 17 Jan 2024 14:37:29 -0800
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240117223729.1444522-1-lokeshgidra@google.com>
Subject: [PATCH] userfaultfd: fix mmap_changing checking in mfill_atomic_hugetlb
From: Lokesh Gidra <lokeshgidra@google.com>
To: akpm@linux-foundation.org
Cc: lokeshgidra@google.com, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, selinux@vger.kernel.org, surenb@google.com, 
	kernel-team@android.com, aarcange@redhat.com, peterx@redhat.com, 
	david@redhat.com, axelrasmussen@google.com, bgeffon@google.com, 
	willy@infradead.org, jannh@google.com, kaleshsingh@google.com, 
	ngeoffray@google.com
Content-Type: text/plain; charset="UTF-8"

In mfill_atomic_hugetlb(), mmap_changing isn't being checked
again if we drop mmap_lock and reacquire it. When the lock is not held,
mmap_changing could have been incremented. This is also inconsistent
with the behavior in mfill_atomic().

Signed-off-by: Lokesh Gidra <lokeshgidra@google.com>
---
 mm/userfaultfd.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/mm/userfaultfd.c b/mm/userfaultfd.c
index 20e3b0d9cf7e..75fcf1f783bc 100644
--- a/mm/userfaultfd.c
+++ b/mm/userfaultfd.c
@@ -357,6 +357,7 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 					      unsigned long dst_start,
 					      unsigned long src_start,
 					      unsigned long len,
+					      atomic_t *mmap_changing,
 					      uffd_flags_t flags)
 {
 	struct mm_struct *dst_mm = dst_vma->vm_mm;
@@ -472,6 +473,15 @@ static __always_inline ssize_t mfill_atomic_hugetlb(
 				goto out;
 			}
 			mmap_read_lock(dst_mm);
+			/*
+			 * If memory mappings are changing because of non-cooperative
+			 * operation (e.g. mremap) running in parallel, bail out and
+			 * request the user to retry later
+			 */
+			if (mmap_changing && atomic_read(mmap_changing)) {
+				err = -EAGAIN;
+				break;
+			}
 
 			dst_vma = NULL;
 			goto retry;
@@ -506,6 +516,7 @@ extern ssize_t mfill_atomic_hugetlb(struct vm_area_struct *dst_vma,
 				    unsigned long dst_start,
 				    unsigned long src_start,
 				    unsigned long len,
+				    atomic_t *mmap_changing,
 				    uffd_flags_t flags);
 #endif /* CONFIG_HUGETLB_PAGE */
 
@@ -622,8 +633,8 @@ static __always_inline ssize_t mfill_atomic(struct mm_struct *dst_mm,
 	 * If this is a HUGETLB vma, pass off to appropriate routine
 	 */
 	if (is_vm_hugetlb_page(dst_vma))
-		return  mfill_atomic_hugetlb(dst_vma, dst_start,
-					     src_start, len, flags);
+		return  mfill_atomic_hugetlb(dst_vma, dst_start, src_start,
+					     len, mmap_changing, flags);
 
 	if (!vma_is_anonymous(dst_vma) && !vma_is_shmem(dst_vma))
 		goto out_unlock;
-- 
2.43.0.429.g432eaa2c6b-goog


