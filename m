Return-Path: <linux-kernel+bounces-2159-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9929C8158C9
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:23:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 25D4AB24402
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 11:23:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8FA815E94;
	Sat, 16 Dec 2023 11:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nR9DRkEz"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C99154A9
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 11:23:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-3ba2dc0f6b7so1293900b6e.2
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 03:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702725826; x=1703330626; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qnMCgoEF3bBGwkMIyi+ffwyEvbkLUBGcU4ida8KYtA4=;
        b=nR9DRkEzXNPO9EWS5dIdHBURO2bumR3k//p2FYWg1K+p0GJfZUVx8oI3SDW5lqkI5Q
         Xz6EBRiYd4TMR0ALpUDQ/T6x2kEHxVlEIjLVAuF1FCSKb6sZ5CO7gYHKe0lLoV1ehggx
         t5KMPL7jO9PMuXEv+FKKn+4lXbPUcCq6J+OuhFKdOWfkDlyomHVWf4WPEuSpnyzyDbeU
         f1Le4ZyNRikcPLWKwWc06iZpAnOTkMlT9P0Q0HdhbRat+2QlRqJo61jUUYCgYM0GkZd9
         /Id1WYzLszVWgbfLM/jm7f5fPwwe9La3m+z38ds4OjvG+5nWz9L+0cbgl4SDEOJBFg+R
         tw1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702725826; x=1703330626;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qnMCgoEF3bBGwkMIyi+ffwyEvbkLUBGcU4ida8KYtA4=;
        b=nb5I/X6kf5+NxFL+9MWYGFWhZhw9Dqs+bQyycbAwfBbMHYsTKeXQrd1QnYddU41GPj
         XJciSLWfYHKzJT63FthbfBOFNg77OurSsr03px75/Go7w85go8wf9OkPuQUxHaqmKuJM
         jUKZMN8hr+W8sbRIsazcoX9zbg3qeNoRWcSN5bXeH4LLIUVFfnzpl5kIWLgRDVKvXKEd
         Qyg3LoW/YYIBE0Sdq6Pob67PQJ639yelfMGyzKmQ/0Bd6unp6bjVT38MZKDoI6xERmbS
         F2/+yu7tCTj3nc15vmD6YR6t54hneos6QMyXZjofm2Soa8EdRtZ+efmhs6X+Zy5+fe5c
         6sTw==
X-Gm-Message-State: AOJu0YyNslHt9LjA0V+gbogd01r/GdmedEteSVutXCFAwG+gN/3L7eSQ
	vEmXn6ZyADpWarElA4IQPi4=
X-Google-Smtp-Source: AGHT+IFErTvBZa7RFfEFVfwrbzUjy2c/h8/SUdsTfJow2CaFwX1pn4Z+CA4CGhZHL+rKkTDKB/A4Iw==
X-Received: by 2002:a05:6808:3c86:b0:3b9:e69f:c08d with SMTP id gs6-20020a0568083c8600b003b9e69fc08dmr19655056oib.52.1702725825763;
        Sat, 16 Dec 2023 03:23:45 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id x128-20020a626386000000b006cea1db00cbsm604902pfb.204.2023.12.16.03.23.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 03:23:45 -0800 (PST)
From: Yuntao Wang <ytcoode@gmail.com>
To: bhe@redhat.com
Cc: akpm@linux-foundation.org,
	bp@alien8.de,
	corbet@lwn.net,
	dave.hansen@linux.intel.com,
	ebiederm@xmission.com,
	hpa@zytor.com,
	kexec@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	mingo@redhat.com,
	tglx@linutronix.de,
	x86@kernel.org,
	ytcoode@gmail.com
Subject: [PATCH 1/3 v3] kexec: modify the meaning of the end parameter in kimage_is_destination_range()
Date: Sat, 16 Dec 2023 19:23:36 +0800
Message-ID: <20231216112336.252557-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZX1t/4Reai6HdoJf@MiWiFi-R3L-srv>
References: <ZX1t/4Reai6HdoJf@MiWiFi-R3L-srv>
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
---
v1->v2:
  Fix this issue using the approach suggested by Eric and Baoquan.

  As this patch is independent of the other patches in this series, I sent
  out the v2 patch separately. If it's inconvenient for anyone, I can
  resend the entire series again.

v2->v3:
  Modify the assignment of eaddr as suggested by Baoquan.

 kernel/kexec_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index be5642a4ec49..e65e8f186eff 100644
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
+		eaddr = epfn << PAGE_SHIFT - 1;
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


