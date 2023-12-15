Return-Path: <linux-kernel+bounces-1547-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D1DD9814FF2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 20:05:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84ECD286F60
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Dec 2023 19:05:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D74943FB21;
	Fri, 15 Dec 2023 19:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4t2ccSA6"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D753E3DB84
	for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 19:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--chrisko.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-5ca2a6f07b6so10249547b3.2
        for <linux-kernel@vger.kernel.org>; Fri, 15 Dec 2023 11:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1702667132; x=1703271932; darn=vger.kernel.org;
        h=cc:to:from:subject:mime-version:message-id:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Y2a+vYqwL9l6xBg4DFt6cMK8Dyw8YN60AVOn/yVmOWc=;
        b=4t2ccSA6kBiz0m5EVv8S6xk+bu+HV7DN2HFLwFXismTf/yjLZ4f7POCHXJLiB0ad/7
         jB+mdgRb8TX9wyFvGszUEXgjhMULbtjtX8azFEsQqF8viSe4aD7om9ebaUF9nSa5cCNi
         mlGLmQ7uQ0cTWx5mfOo0v/Lmjlu3PJwPk0cefR0fYSRF2wQE5wMOPxS0W3k90WMAz8Zh
         ZRKB3BeZ0ygmV6qapZALiCkA4/Wx8XfMjFrRCvSMO2jKH4fH8HD3jCmmPG2nvKrvq4cf
         giL7emwm2+g+dedlp03AndXg3FxWK8tFzmWybnpUuN+BtovAl9fbyFshe3XrGHgJb1Ms
         MiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702667132; x=1703271932;
        h=cc:to:from:subject:mime-version:message-id:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y2a+vYqwL9l6xBg4DFt6cMK8Dyw8YN60AVOn/yVmOWc=;
        b=JwlooM9dyLxaUKfKSzuuxL0o3CRmUSbOqBPYW7HLbgD1CmxFvxBPwDbn5qs7F0LKQl
         HSafdVeObqbeIaF+SBWPIEu1vNaPD+sQNkpJ+BGKHlW2+buIQcCxfUIye9eek8pNjNaL
         YYj4BATpM1WSnOi5aC2ISu0Duf2aS/tFaj3oj6XNfMhF1fQsk3ltf9BZKI7RSPNTMJLY
         dcjf7lEmfOx1mQOUqfVR7+TEDTYvFqa1k9wsPqzeK4IS+GuW36LoAXGWRvg7LuVJ/nCi
         vhFqxamNp7m4zS5wValEuLD8A3zV8K7qNkoWs6KmrYrOgqlxjGZ8pTdivJBAhqb7T7Ni
         FgiQ==
X-Gm-Message-State: AOJu0YxXwTp1UtvYOmrzpL1iHH2BviVWOjLvG2Uctk2j5izpcDJHDTPG
	0iu98UBruYB0HwrdeoDYjmz2zwY49SnG
X-Google-Smtp-Source: AGHT+IERzZP7n0f0QvRhYtWleDCWsunFYUOCv7b+O0V2hrHuHhiRnWmo94EZZWt1+tzO4lx1tzA7VAaOEIFL
X-Received: from hugelgupf.svl.corp.google.com ([2620:15c:2d1:203:8424:6c22:2469:67f6])
 (user=chrisko job=sendgmr) by 2002:a05:690c:891:b0:5d3:9513:4aad with SMTP id
 cd17-20020a05690c089100b005d395134aadmr158935ywb.3.1702667131839; Fri, 15 Dec
 2023 11:05:31 -0800 (PST)
Date: Fri, 15 Dec 2023 11:05:21 -0800
Message-Id: <20231215190521.3796022-1-chrisko@google.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.472.g3155946c3a-goog
Subject: [PATCH] kexec: allocate kernel above bzImage's pref_address
From: Chris Koch <chrisko@google.com>
To: Jonathan Corbet <corbet@lwn.net>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, 
	"H. Peter Anvin" <hpa@zytor.com>, linux-doc@vger.kernel.org, x86@kernel.org, 
	linux-kernel@vger.kernel.org
Cc: Chris Koch <chrisko@google.com>, Cloud Hsu <cloudhsu@google.com>
Content-Type: text/plain; charset="UTF-8"

A relocatable kernel will relocate itself to pref_address if it is
loaded below pref_address. This means a booted kernel may be relocating
itself to an area with reserved memory on modern systems, potentially
clobbering arbitrary data that may be important to the system.

This is often the case, as the default value of PHYSICAL_START is
0x1000000 and kernels are typically loaded at 0x100000 or above by
bootloaders like iPXE or kexec. GRUB behaves like this patch does.

Also fixes the documentation around pref_address and PHYSICAL_START to
be accurate.

Co-developed-by: Cloud Hsu <cloudhsu@google.com>
Signed-off-by: Cloud Hsu <cloudhsu@google.com>
Signed-off-by: Chris Koch <chrisko@google.com>
---
 Documentation/arch/x86/boot.rst   |  3 ++-
 arch/x86/Kconfig                  | 10 +++++-----
 arch/x86/kernel/kexec-bzimage64.c |  5 ++++-
 3 files changed, 11 insertions(+), 7 deletions(-)

diff --git a/Documentation/arch/x86/boot.rst b/Documentation/arch/x86/boot.rst
index 22cc7a040dae..49bea8986620 100644
--- a/Documentation/arch/x86/boot.rst
+++ b/Documentation/arch/x86/boot.rst
@@ -878,7 +878,8 @@ Protocol:	2.10+
   address if possible.
 
   A non-relocatable kernel will unconditionally move itself and to run
-  at this address.
+  at this address. A relocatable kernel will move itself to this address if it
+  loaded below this address.
 
 ============	=======
 Field name:	init_size
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 3762f41bb092..1370f43328d7 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -2109,11 +2109,11 @@ config PHYSICAL_START
 	help
 	  This gives the physical address where the kernel is loaded.
 
-	  If kernel is a not relocatable (CONFIG_RELOCATABLE=n) then
-	  bzImage will decompress itself to above physical address and
-	  run from there. Otherwise, bzImage will run from the address where
-	  it has been loaded by the boot loader and will ignore above physical
-	  address.
+	  If the kernel is not relocatable (CONFIG_RELOCATABLE=n) then bzImage
+	  will decompress itself to above physical address and run from there.
+	  Otherwise, bzImage will run from the address where it has been loaded
+	  by the boot loader. The only exception is if it is loaded below the
+	  above physical address, in which case it will relocate itself there.
 
 	  In normal kdump cases one does not have to set/change this option
 	  as now bzImage can be compiled as a completely relocatable image
diff --git a/arch/x86/kernel/kexec-bzimage64.c b/arch/x86/kernel/kexec-bzimage64.c
index a61c12c01270..5dcd232d58bf 100644
--- a/arch/x86/kernel/kexec-bzimage64.c
+++ b/arch/x86/kernel/kexec-bzimage64.c
@@ -498,7 +498,10 @@ static void *bzImage64_load(struct kimage *image, char *kernel,
 	kbuf.bufsz =  kernel_len - kern16_size;
 	kbuf.memsz = PAGE_ALIGN(header->init_size);
 	kbuf.buf_align = header->kernel_alignment;
-	kbuf.buf_min = MIN_KERNEL_LOAD_ADDR;
+	if (header->pref_address < MIN_KERNEL_LOAD_ADDR)
+		kbuf.buf_min = MIN_KERNEL_LOAD_ADDR;
+	else
+		kbuf.buf_min = header->pref_address;
 	kbuf.mem = KEXEC_BUF_MEM_UNKNOWN;
 	ret = kexec_add_buffer(&kbuf);
 	if (ret)
-- 
2.43.0.472.g3155946c3a-goog


