Return-Path: <linux-kernel+bounces-112519-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 08A4D887B18
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Mar 2024 00:26:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A981F281FF8
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Mar 2024 23:26:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AA3E5B69E;
	Sat, 23 Mar 2024 23:26:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K3Q1CVjn"
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117AC5B666
	for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 23:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711236388; cv=none; b=aGJ74SXz0AicVu5F5yuMzXvLmoE/BR6L5FcC7RoF40A1ahNDJ3tOwDXN0NcIq2DWBWkv8Vajuk1W/CC/yheowGYhA2iT47/MjeZ/Rt0jtWDUngkiv+Eb3CE2zv+Ypanr2IQ5Oy/6RXumSkK1gg6S/P8/hHGFKG187mmxEVKxgVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711236388; c=relaxed/simple;
	bh=0FcTEAJ1gsfQH0FOE6VYrEMIelWTsI8PzMeOeA0BcWI=;
	h=From:To:Cc:Subject:Date:Message-Id; b=HCyzLHsst8bddA6btDA/68KX4hnaN7IiQ4exbvdZ2kTiHGpxR0oAP1J0xfEC10FrtPwRq33pkoUCdMAgLDWrTDFkMjWd1AH1BW1gTxyywGLSIKp2VTQsnodC3T+c+/9YyaAg+Paq6w9qcFbCoheWF+nHq0qEAyc45FzQKCyRkFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K3Q1CVjn; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-33e1878e357so1619096f8f.3
        for <linux-kernel@vger.kernel.org>; Sat, 23 Mar 2024 16:26:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711236385; x=1711841185; darn=vger.kernel.org;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0B8qywLY2tLet+rlAAUKMoLoXlaF6fUnntCxMPJdL8A=;
        b=K3Q1CVjnwSF/aA59p1C1oAkMkIAWlavUmHh6YEWkIUYdlCaie6xZynJMk5Cl/CqxOi
         PoVQZsyrKQemaVjd2v5eMOrvY8Qfi7Tq2+4pVWTiMt19VN7ImP+xoEMoZe7s3bv3lzju
         5kAGdJJyBJpTMVrhunL9xVRPb3kRJOTl0AAgilnwT5whg9YWnCcCjnSArrDjJkRKuOhI
         Fz/35vs7QA5zENeqaj/aZMye/2bV3h61h1KQvvVaoYshxfq9teFog8/qa/gqIYvv3ULK
         atr3WHXNy6TJC0wjVCHPIpz3gf0cBlizNNgKAUPE522SmNSSAPGpp33cbm6gY2DOGzW0
         BmFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711236385; x=1711841185;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0B8qywLY2tLet+rlAAUKMoLoXlaF6fUnntCxMPJdL8A=;
        b=AdBHGPjgUyMH63Cdur1Y85Vfga0gb90XlFEkftQ9bcmFjgfug+GFdJzk/l1WyjHSSH
         1uD7J1OcvHuutj20gSjnYBfrI9tGC8qgitfWbA/+cSvUHHtac9vDHA/P+YY6m3caRer7
         OiuMcqxPpVv0QyisHknSU8N5Gu2Phw0Q9qZxsl4lnzzxNSbKLo43bzwMuwtbAXdGq1we
         6tUgKulNeFPhi6APmi8DTQ0VOzuhfi6qd7wSD1l5TwnhIQp5WiwWnlt5NZDjTbHfuYl6
         MkQnF8px0rIV7j32LDK+UubRyvtQ5BUSwzMexaIkL/1/rtXrG8GF4+5xck1o+S9UrSQj
         8Vyw==
X-Forwarded-Encrypted: i=1; AJvYcCV8kUDb20OvknbKBYGyiU/oAdf8yvbjwzjWsSjW43zIXspvB1cnpxyTHB/FHc0K8QG4IeOuz4cEEuVS58V3QcljmIWed7CTRFKvxugP
X-Gm-Message-State: AOJu0YzjoTFWwl9E65sKmlfcMt8MZsHHSKQzj2aSLwDNHPqIEUm0Tyq0
	VF4JnQMN8FrTByuqlI43qF9epDz2IgEht92sRx/FSz/yIVq/IiI6foLM03+4kb8=
X-Google-Smtp-Source: AGHT+IHytGJSI01knpRRl4ETirIQM17BjnITmp2pUl7IOWoODsCx/rYUJGEQLZoU9SUxKSNcfZMrtA==
X-Received: by 2002:a5d:42c9:0:b0:33e:a0b1:e783 with SMTP id t9-20020a5d42c9000000b0033ea0b1e783mr2218639wrr.22.1711236385118;
        Sat, 23 Mar 2024 16:26:25 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id j26-20020aa7de9a000000b0056c08268768sm169534edv.10.2024.03.23.16.26.24
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 23 Mar 2024 16:26:24 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com
Cc: x86@kernel.org,
	linux-kernel@vger.kernel.org,
	Wei Yang <richard.weiyang@gmail.com>,
	Vivek Goyal <vgoyal@in.ibm.com>,
	"Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
	Ingo Molnar <mingo@kernel.org>,
	Steve Wahl <steve.wahl@hpe.com>,
	Borislav Petkov <bp@suse.de>
Subject: [PATCH] x86/head/64: level2_kernel_pgt's kernel area is built with _PAGE_PRESENT set
Date: Sat, 23 Mar 2024 23:26:21 +0000
Message-Id: <20240323232621.10400-1-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>

The code is first introduced in 'commit 1ab60e0f72f7 ("[PATCH] x86-64:
Relocatable Kernel Support")'.  Then 'commit c88d71508e36b
("x86/boot/64: Rewrite startup_64() in C")', convert it to c. And
'commit 2aa85f246c181 ("x86/boot/64: Make level2_kernel_pgt pages
invalid outside kernel area")' limit the range from _text to _end.

Originally, it does the check because the loop iterate the whole
level2_kernel_pgt, while currently it just fixup the kernel area. This
area is built with _PAGE_PRESENT set.

Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Vivek Goyal <vgoyal@in.ibm.com>
CC: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
CC: Ingo Molnar <mingo@kernel.org>
CC: Steve Wahl <steve.wahl@hpe.com>
CC: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/head64.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 212e8e06aeba..75c69f8620d8 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -253,8 +253,7 @@ unsigned long __head __startup_64(unsigned long physaddr,
 
 	/* fixup pages that are part of the kernel image */
 	for (; i <= pmd_index((unsigned long)_end); i++)
-		if (pmd[i] & _PAGE_PRESENT)
-			pmd[i] += load_delta;
+		pmd[i] += load_delta;
 
 	/* invalidate pages after the kernel image */
 	for (; i < PTRS_PER_PMD; i++)
-- 
2.34.1


