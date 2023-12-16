Return-Path: <linux-kernel+bounces-2168-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BEC88158E2
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 13:06:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C6A11F22176
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 12:06:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9419019BA5;
	Sat, 16 Dec 2023 12:06:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eHB1PB5v"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9670618ECF
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 12:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6da4893142aso1294367a34.0
        for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 04:06:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702728360; x=1703333160; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Keg0jGTD3cWCHOm6j1CzSfxv/wdbkTrGtYVZOjpfOPQ=;
        b=eHB1PB5v/I1n4ePkv0p7TWfXpyb8XLckkowFpxuHH79atDUfAZFVW/oWOYRUInitLk
         /At3n/GlOwSwgZujvDc5DjsNYwVl8RlNu5k6unb+U8QB4CaZ1NzbVMWDFECvYwU8oDKG
         GzLNYxHGRmz0h5oXhD1sY/RW8nxoTp3VcSVmKPcnlovep4tFQkpXup+48Kt3RsQCcPxq
         qGMlt3kpkhDo4+46wJAq3oDyvHcV9UyP3+XoAIGEUGiFi3q/O6hpr4Dv2N8dW0WB4ZN8
         VMNhhc0vwAnpbnzuH+52bQ6ZN0NXa6+ycqRQMCvT92EUMHIEU6jIsk2ImPTg+iCeNwXs
         ZpDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702728360; x=1703333160;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Keg0jGTD3cWCHOm6j1CzSfxv/wdbkTrGtYVZOjpfOPQ=;
        b=nwFzNrOcRPQuvdV4ypirumKqo9sWIMG+NOwA13Z3lUymymKvJcauOGEJIyBbvPC9dR
         Or4+Z6nmRxL+xBJGlIBucQ2jbU0bQY9nodKTrFXJhhtBJebaAnKYY1Osfi05t39QeSlh
         rHEdOHbHMwSG4iH9CH9cvcd05uXV2NaCv4Om3TosYbK5jVumXO8PmWjQaE0yD6OcJ+Fd
         2CfexoZwe481cTxRdGc0k2PEjk90A6oL2IChBNO/zv8AgbWxKNTE1R2dBuc31Iel2B2N
         kLFjMDCVOaZwhkfUn20yNB8aDPdMiQ/wMy3HG8R16fx1QIvTRTlHTXK/2319vfP68LU/
         p+0w==
X-Gm-Message-State: AOJu0YxEInncUSmd40qy5/3CLwzO49/GWR3jFbv3pM17hJiicLvVAatb
	g9KwFpSTs+qIhfym8M2AXMc=
X-Google-Smtp-Source: AGHT+IF5AQxE0wcRh91KHA+StTcL6yRa58g2jp42WQyQBw4+JLdNW0sSqhoQbgcQ9iDQzFFV3oq1qQ==
X-Received: by 2002:a9d:6e10:0:b0:6d9:c946:49c with SMTP id e16-20020a9d6e10000000b006d9c946049cmr13298083otr.5.1702728360562;
        Sat, 16 Dec 2023 04:06:00 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id x34-20020a056a0018a200b006ce3a48b6a2sm15006866pfh.160.2023.12.16.04.05.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Dec 2023 04:06:00 -0800 (PST)
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
Subject: [PATCH 1/3 v4] kexec: modify the meaning of the end parameter in kimage_is_destination_range()
Date: Sat, 16 Dec 2023 20:05:51 +0800
Message-ID: <20231216120551.289324-1-ytcoode@gmail.com>
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

v3->v4:
  `eaddr = epfn << PAGE_SHIFT - 1` causes a compilation warning, fix it.

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


