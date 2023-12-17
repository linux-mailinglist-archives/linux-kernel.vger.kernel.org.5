Return-Path: <linux-kernel+bounces-2447-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 67012815D4C
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 04:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 230402839F7
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Dec 2023 03:36:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA5161851;
	Sun, 17 Dec 2023 03:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LX86QtGW"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f48.google.com (mail-ot1-f48.google.com [209.85.210.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECE581849
	for <linux-kernel@vger.kernel.org>; Sun, 17 Dec 2023 03:36:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f48.google.com with SMTP id 46e09a7af769-6d9f069e9b0so1737719a34.3
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 19:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702784188; x=1703388988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3RC+17BbjqsJDmvBDmQiYtlBEVE+AP46bYSCMNzUq08=;
        b=LX86QtGWlGo0PbQK36904rFZvaBPMmq3owqji00eRdHvD/LrV22KIS/GR1IWuTnB4o
         5IZDb+xDoQtZx1RUDTGyqTYeJ3rXiO3S3YlQweEBAiTgbG9SaQpa76Pary6uEZ7gxPbA
         ru8pU6cAMELNGIy2E4BAW8VawDGOxq2GC9jgoHOYbXJCtB7TuocW2n+QmqJ/f+fsIHpS
         +sCK0ecHJZDIfxaWCYUXDqhBo0dNq56rM3GYPvNJLjF+ZZj4AvJjkjtYkM84LXef1V+8
         +Vk+sZrqxlmRgxZNCi4SkCdAS1H3/U+9SQBpzWR2dZ69ZABLM7YkTFXCKxMyrj4zbRg0
         RxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702784188; x=1703388988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3RC+17BbjqsJDmvBDmQiYtlBEVE+AP46bYSCMNzUq08=;
        b=LNwSD4H+OZCxBTxZ5VbJKnUPFASqxZ/FF1NYDRxoakEh7IBdgLQnmsQDGEPl6e/zQo
         vaBDqY9X+bGLw+0bMKzE4gVfC/8EXtf/IMptrm0zZMTg+V2YZpekcKif2rg19VSzxGoU
         2d0ZA6dkGOv2OORvmfG7Vd5UP3c+x6280LYItOf9jf2AWLjw9rGIckAZIy44CReqX3hC
         GFvFSZhfnrFaAllrvYAxtVvmPiXN5wFEfU6PDo5EGE7Ls+nbdKo/ubxBnWm7m/vgFdCc
         ieaoJKs4Wk8W+RfkpU3QvTRrKnzPtyIBR6Lzzn/eUQ7E78UcPNZJiZqU9NhjUzkA4K8P
         kiZQ==
X-Gm-Message-State: AOJu0YxSG3pazqVrGmm61CdnseU7EmAR3bX4CPjSWXD9cIFBMYV18yNd
	Vp6qvb5lkW0JTHisLWswiqJQ/IIdl4U=
X-Google-Smtp-Source: AGHT+IE2Au2oYCa3+Qix6uh+BvU4jwiDAGoZjp1oIqfibaEkctT8OYF8o5BRoDQ182Yyk25vOsDaqA==
X-Received: by 2002:a9d:774f:0:b0:6da:3099:d8c4 with SMTP id t15-20020a9d774f000000b006da3099d8c4mr8412360otl.77.1702784187633;
        Sat, 16 Dec 2023 19:36:27 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id x26-20020a62fb1a000000b006ce48a0b7c6sm15768820pfm.109.2023.12.16.19.36.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 19:36:27 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: linux-kernel@vger.kernel.org,
	kexec@lists.infradead.org,
	x86@kernel.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Eric Biederman <ebiederm@xmission.com>,
	Baoquan He <bhe@redhat.com>,
	Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH v5 1/3] kexec: modify the meaning of the end parameter in kimage_is_destination_range()
Date: Sun, 17 Dec 2023 11:35:26 +0800
Message-ID: <20231217033528.303333-2-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231217033528.303333-1-ytcoode@gmail.com>
References: <20231217033528.303333-1-ytcoode@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The end parameter received by kimage_is_destination_range() should be the
last valid byte address of the target memory segment plus 1. However, in
the locate_mem_hole_bottom_up() and locate_mem_hole_top_down() functions,
the corresponding value passed to kimage_is_destination_range() is the last
valid byte address of the target memory segment, which is 1 less.

There are two ways to fix this bug. We can either correct the logic of the
locate_mem_hole_bottom_up() and locate_mem_hole_top_down() functions, or we
can fix kimage_is_destination_range() by making the end parameter represent
the last valid byte address of the target memory segment. Here, we choose
the second approach.

Due to the modification to kimage_is_destination_range(), we also need to
adjust its callers, such as kimage_alloc_normal_control_pages() and
kimage_alloc_page().

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Acked-by: Baoquan He <bhe@redhat.com>
---
v1->v2:
  Fix this issue using the approach suggested by Eric and Baoquan.

v2->v3:
  Modify the assignment of eaddr as suggested by Baoquan.

v3->v4:
  `eaddr = epfn << PAGE_SHIFT - 1` causes a compilation warning, fix it.

v4->v5:
  No changes.

 kernel/kexec_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index be5642a4ec49..e3b1a699f087 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -276,8 +276,8 @@ int kimage_is_destination_range(struct kimage *image,
 		unsigned long mstart, mend;
 
 		mstart = image->segment[i].mem;
-		mend = mstart + image->segment[i].memsz;
-		if ((end > mstart) && (start < mend))
+		mend = mstart + image->segment[i].memsz - 1;
+		if ((end >= mstart) && (start <= mend))
 			return 1;
 	}
 
@@ -370,7 +370,7 @@ static struct page *kimage_alloc_normal_control_pages(struct kimage *image,
 		pfn   = page_to_boot_pfn(pages);
 		epfn  = pfn + count;
 		addr  = pfn << PAGE_SHIFT;
-		eaddr = epfn << PAGE_SHIFT;
+		eaddr = (epfn << PAGE_SHIFT) - 1;
 		if ((epfn >= (KEXEC_CONTROL_MEMORY_LIMIT >> PAGE_SHIFT)) ||
 			      kimage_is_destination_range(image, addr, eaddr)) {
 			list_add(&pages->lru, &extra_pages);
@@ -716,7 +716,7 @@ static struct page *kimage_alloc_page(struct kimage *image,
 
 		/* If the page is not a destination page use it */
 		if (!kimage_is_destination_range(image, addr,
-						  addr + PAGE_SIZE))
+						  addr + PAGE_SIZE - 1))
 			break;
 
 		/*
-- 
2.43.0


