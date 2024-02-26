Return-Path: <linux-kernel+bounces-82378-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8196C868377
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 23:06:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 378261F23A96
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Feb 2024 22:06:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F1B5131E31;
	Mon, 26 Feb 2024 22:05:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T+NziswA"
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08647131E3F
	for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 22:05:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708985156; cv=none; b=F2KtIICvEH6rVMjRJX7AVpx68AZMwGj7qBm8nmS1J/Zuv229mew69u7wRxermKJmk/+BZiQLN5JQZvDr8Y15zBpFNLwBKa6Tz3dgeFiBv0RVxyoSDhf1tADVAgltVzhyZ6ZlM0QKkbB9/Bc5ilu7TLcVINx8ZL5qdRLpTpfbAc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708985156; c=relaxed/simple;
	bh=yX1kJCbPWTdvnCbAkmvr1WQD29vVYqXsCcrJQQKRZDM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XHnChu53STIrROnnD3Ix/BfCaia1KMdIZr0DYKJTmSfTNVYxFsa4x45Q9AFIwCPgNE7Bh8xobHpdIWdAPEYv2Q2pOVKUnzzKBgp03RQcprOU+/PYVe6HwBry2UpNhYSZHezBAf8DhCXAnkpiMtlfRkusSKQ42DC58tRNMGBstCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T+NziswA; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-787a2a14d9cso290575985a.2
        for <linux-kernel@vger.kernel.org>; Mon, 26 Feb 2024 14:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708985153; x=1709589953; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T5WmPlH+GeSSkC2r3zeNTmXAIzwepnNSeSNojo2GFVo=;
        b=T+NziswAS2Cs0WjxMlEwNiqVHQZU9qVbHUE7cwhUPus316SCqCdStuInHkDdnhMVYu
         j44pG8Qoh7YfGMGuW9TTsgM6Vnxx3NlsSyD62A4CN9hs/4wBMIG8VGrcwQB15+3pVXvO
         D9LVkjvus1lCAqii/Wnj6syGBiSLy6Um4dvrI4is0BOxJA+BvdadlPYaz5Cw6SZjPzke
         2O4/W+oMwBrPhPnUIPEbmRkCKnc+eoWHx1pyGnEq9nsAT9YW7NId04n4++3ntlUEOMub
         oFSAmZcruL86SXvr05lUJbd9Cof6FCdYvnKTh2XFimc7o6pRfEDAflioZIj8s2PS9+o5
         qAmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708985153; x=1709589953;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5WmPlH+GeSSkC2r3zeNTmXAIzwepnNSeSNojo2GFVo=;
        b=PTOnfjDtZNEKlwQUchfPhWXftd7lyfzSo1kgHRtrZ6uTYzuA32n80Lsaf7R95sVUNJ
         8kQ5UZc57uIXK0Kp7i/l+s/v5MywvznZ7TlCpUxBef0qQODzbalI/GkfSXw60SuRcyy+
         /4taJxFlQJZTpnUSf9UsAdH3TxgEMw27IBl8nNj0t/KvubbqQx13+623qIy0O1ryFIYW
         DB0rQpOiSdoVrFIETMkWss5isDifRBnXXXFkLQfpBmstqmwIk9ahgAMpx10Jk/3OyBqm
         hkKIkjdaABmRJjTj3KMW98nA5+1UHb7RQzvV9XNJS9We9DnYhfP1Gy/DkHT2ncMlsYNF
         +J9A==
X-Gm-Message-State: AOJu0Ywp++lDVRkJzrkhgiEWoqcs070P7NZWspeXbPs/RKQKnsTDw9KK
	Cd5deEpRn5vZvbkD3+K4zz97sfDXBcdd57BJAZdBvw5xAVCczSeLLhjYcIs=
X-Google-Smtp-Source: AGHT+IEa1wplouoy61yETidsAd9JDqMskSySFFRauiGu8PTwLfhuUYL0EusVasE9rlkjMKHuhDTaEg==
X-Received: by 2002:a05:6214:2429:b0:690:7b4:825 with SMTP id gy9-20020a056214242900b0069007b40825mr526433qvb.26.1708985153624;
        Mon, 26 Feb 2024 14:05:53 -0800 (PST)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id ow1-20020a0562143f8100b0068fdb03a3a3sm3435376qvb.95.2024.02.26.14.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 14:05:53 -0800 (PST)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Ard Biesheuvel <ardb@kernel.org>,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v2] x86/boot/64: Load kernel GDT in early boot
Date: Mon, 26 Feb 2024 17:05:44 -0500
Message-ID: <20240226220544.70769-1-brgerst@gmail.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Instead of loading a duplicate GDT just for early boot, load the kernel
GDT from its physical address.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
v2: Updated to latest tip tree

 arch/x86/include/asm/desc.h |  1 +
 arch/x86/kernel/head64.c    | 13 ++-----------
 2 files changed, 3 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index ec95fe44fa3a..62dc9f59ea76 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -46,6 +46,7 @@ struct gdt_page {
 } __attribute__((aligned(PAGE_SIZE)));
 
 DECLARE_PER_CPU_PAGE_ALIGNED(struct gdt_page, gdt_page);
+DECLARE_INIT_PER_CPU(gdt_page);
 
 /* Provide the original GDT */
 static inline struct desc_struct *get_cpu_gdt_rw(unsigned int cpu)
diff --git a/arch/x86/kernel/head64.c b/arch/x86/kernel/head64.c
index 72351c3121a6..fd77a266f29d 100644
--- a/arch/x86/kernel/head64.c
+++ b/arch/x86/kernel/head64.c
@@ -68,15 +68,6 @@ unsigned long vmemmap_base __ro_after_init = __VMEMMAP_BASE_L4;
 EXPORT_SYMBOL(vmemmap_base);
 #endif
 
-/*
- * GDT used on the boot CPU before switching to virtual addresses.
- */
-static struct desc_struct startup_gdt[GDT_ENTRIES] __initdata = {
-	[GDT_ENTRY_KERNEL32_CS]         = GDT_ENTRY_INIT(DESC_CODE32, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_CS]           = GDT_ENTRY_INIT(DESC_CODE64, 0, 0xfffff),
-	[GDT_ENTRY_KERNEL_DS]           = GDT_ENTRY_INIT(DESC_DATA64, 0, 0xfffff),
-};
-
 #ifdef CONFIG_X86_5LEVEL
 static void __head *fixup_pointer(void *ptr, unsigned long physaddr)
 {
@@ -589,8 +580,8 @@ void __head startup_64_setup_gdt_idt(void)
 	void *handler = NULL;
 
 	struct desc_ptr startup_gdt_descr = {
-		.address = (unsigned long)&RIP_REL_REF(startup_gdt),
-		.size    = sizeof(startup_gdt) - 1,
+		.address = (unsigned long)&RIP_REL_REF(init_per_cpu_var(gdt_page.gdt)),
+		.size    = GDT_SIZE - 1,
 	};
 
 	/* Load GDT */

base-commit: afb9cce6ad6e808cf659f43925941be96f61b9c9
-- 
2.43.2


