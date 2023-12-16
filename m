Return-Path: <linux-kernel+bounces-2041-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 14B18815742
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 05:18:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A7AB41F25762
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Dec 2023 04:18:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D9D910A3D;
	Sat, 16 Dec 2023 04:18:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VrVybW/G"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A2E10A19
	for <linux-kernel@vger.kernel.org>; Sat, 16 Dec 2023 04:18:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-3ba2e4ff6e1so1051756b6e.3
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 20:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702700324; x=1703305124; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KqN/tzHkDS+S7fn8n5b5X+Q06o8UCyNU3Cig5GP00UI=;
        b=VrVybW/GAL3sdREpjH4Qr8OLWeZBjscC5w5tZBRym3+2BmKA3DABLrt6wW1Euem5MY
         gN3G0Ska91vRcbS2k44ARZV81Aqm7IEgN0lQV6htDRaeNAhiw3lPwoloX74YRek8Lc7J
         I+oYmogP2C0VOBs7t3bJiK4RiuuN77IjkccmVF375uFjO4c23qjTO4+RMfLRiYpL3ajr
         dIbqPxLElMccuuBNEeDiP9iQvv+jwxNquBLTLzIf+8r6Drsz2WdpmXqlgkeRVhIJiVRo
         LCJPo/Kg6AeZa8gDiXstUJCCzGEpzRN1DcySZafOEomXhDRjPTdXhvP2fgq4XkmupZ6Y
         ghZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702700324; x=1703305124;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KqN/tzHkDS+S7fn8n5b5X+Q06o8UCyNU3Cig5GP00UI=;
        b=s5oZIKEiaCpZuMzCP2zcjRo2uF2ap+TxSjI94OP9UDskb+4kWTGu8RWZIBf9mb+iHG
         Q934xnfKRTGZ76oHrRJXOAfgYtDJT515IFKA6VBIgo1QCcLWoYrP3mHYcYM64do6cdbe
         WNfr8cRTCd12VoGtOAmdLy5d0VOewfLZfrdvfyXZmhfN5ksr3eh5qRiAJyRf7GkgZu9d
         bq1gnE+d1QRmuYMKfOVuf1nsLO7Fu9oR/K0O1kNHiETOdMek9QJNEAjzKOmKnTg+ydCd
         mTJT5R31hlBMltfaZbUmzcIVhRHe6tD3WYvPdSv3RW8cnBPNzlWzEjFW7Jaf0UhHi/ae
         Vpvw==
X-Gm-Message-State: AOJu0YwlFy19MYd4vkpx82qoe7goOUyrYeTYJKpF1M9cbs/vjvhKJnaT
	2ktuadPP/qao6zxxa9Xty+4=
X-Google-Smtp-Source: AGHT+IGz6FD8r/yubBJ2wlfYD2DjnHf06jHjqfO+SSyJbu+wSqgzl+9oWiwC5XcIbbt0FERTWIw8Bg==
X-Received: by 2002:a05:6808:1804:b0:3b8:b063:9b5d with SMTP id bh4-20020a056808180400b003b8b0639b5dmr15572457oib.79.1702700323815;
        Fri, 15 Dec 2023 20:18:43 -0800 (PST)
Received: from code.. ([144.202.108.46])
        by smtp.gmail.com with ESMTPSA id x17-20020a62fb11000000b006d26f1d1cedsm2550086pfm.118.2023.12.15.20.18.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Dec 2023 20:18:43 -0800 (PST)
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
Subject: [PATCH 1/3 v2] kexec: modify the meaning of the end parameter in kimage_is_destination_range()
Date: Sat, 16 Dec 2023 12:18:33 +0800
Message-ID: <20231216041833.220466-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <ZX0JwbQ59XH5rqm9@MiWiFi-R3L-srv>
References: <ZX0JwbQ59XH5rqm9@MiWiFi-R3L-srv>
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

 kernel/kexec_core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index be5642a4ec49..5991b3ae072c 100644
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
 
@@ -372,7 +372,7 @@ static struct page *kimage_alloc_normal_control_pages(struct kimage *image,
 		addr  = pfn << PAGE_SHIFT;
 		eaddr = epfn << PAGE_SHIFT;
 		if ((epfn >= (KEXEC_CONTROL_MEMORY_LIMIT >> PAGE_SHIFT)) ||
-			      kimage_is_destination_range(image, addr, eaddr)) {
+			      kimage_is_destination_range(image, addr, eaddr - 1)) {
 			list_add(&pages->lru, &extra_pages);
 			pages = NULL;
 		}
@@ -716,7 +716,7 @@ static struct page *kimage_alloc_page(struct kimage *image,
 
 		/* If the page is not a destination page use it */
 		if (!kimage_is_destination_range(image, addr,
-						  addr + PAGE_SIZE))
+						  addr + PAGE_SIZE - 1))
 			break;
 
 		/*
-- 
2.43.0


