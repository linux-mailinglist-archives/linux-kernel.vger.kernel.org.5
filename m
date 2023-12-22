Return-Path: <linux-kernel+bounces-10145-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 26A3781D0B2
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Dec 2023 00:57:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D12AD1F22229
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Dec 2023 23:57:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CCF4E1AF;
	Fri, 22 Dec 2023 23:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="fvSnWIDX"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f53.google.com (mail-ot1-f53.google.com [209.85.210.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57F244E1A0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 23:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f53.google.com with SMTP id 46e09a7af769-6db9f489cddso1015033a34.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Dec 2023 15:55:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703289300; x=1703894100; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jovKxsj0YGOzwwNQclPyLUNNHjkrdGN438RuH3dRR2A=;
        b=fvSnWIDXCSYcwJzywnIWs4x4Kw6nigrt3MnI2yuHkeIF3or9WBhZzUFAXaMMsGBwqg
         usGirWhdj6X1Vl07gDi16bSi/Q9NN41YkBlZzS/UYAFw7vMDs+7n1F1HZmGGEuSB4AfI
         Uu8pvExS7NdQgH+Pi9CeTPGPef/rthyyb4ejiRKUFmPxzm5n6cRV21NcQ36TKKBRS4Bm
         lVsOPvVfo3MmYBeLBh6sbHoWwW0EcFGesR5l9HzpvOvOt8tiF7vp1RDSWAAuN4UR7GYq
         iUt0pjlhBNZ6R0h/nB6zGCClllilxo3331W2WDShKCG4f2jb+pwP2JtygV8s42wY8f5n
         hPog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703289300; x=1703894100;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jovKxsj0YGOzwwNQclPyLUNNHjkrdGN438RuH3dRR2A=;
        b=shN4hAJ5Fy6ltdovxrLykEtUHuLT28op/KLYeI+IWVNlwHjTdPXFT9cVfdZbSUFc5O
         IVabXCHlLGvwcHmeIyw8GOOPUnMN9Y409IBeuh5aPKIEMfX8Xq5WzYjKOeyRz8f8s2gW
         CUVWRb6Vngw0VxN9h0u5r41fGoNeA+luJ1hagP40bvXOXE63VZQ+HduwQmc5n/nt00gh
         0ILpOD97UgQL2QUxDVbzNin3cXwZ52GK9ykPnDXStEZGNuZMbC44M6+NY1wpe3QsUCsc
         os4J9qj60sg8aBmbCF1MVPxPBKLXHf+2FOFZkZC1jBvvcBTPzIHCD2MqIQYz5iBIzerX
         mN+w==
X-Gm-Message-State: AOJu0YzlyQ2qqWLZlHje3DHSbjzL9+oVLFgpO8hEj28HrU5GpNkBb/jW
	fv/+9Tavh9F1+0VgR4JRSO47l+nd7wo97A==
X-Google-Smtp-Source: AGHT+IE4rFqSsXLWy2zn3NPZ8X3v1i6lWs26Lx4B22AXqvN9zx3xCPAcYyy9LfQcQBKoJdPCZEMkeQ==
X-Received: by 2002:a05:6830:450f:b0:6db:b9db:4393 with SMTP id i15-20020a056830450f00b006dbb9db4393mr1209126otv.0.1703289300272;
        Fri, 22 Dec 2023 15:55:00 -0800 (PST)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id q65-20020a4a4b44000000b005944c7f6bb6sm249999ooa.29.2023.12.22.15.54.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Dec 2023 15:54:59 -0800 (PST)
From: Deepak Gupta <debug@rivosinc.com>
To: rick.p.edgecombe@intel.com,
	broonie@kernel.org
Cc: Deepak Gupta <debug@rivosinc.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] mm: abstract shadow stack vma behind arch_is_shadow_stack_vma
Date: Fri, 22 Dec 2023 15:51:04 -0800
Message-ID: <20231222235248.576482-1-debug@rivosinc.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86 has used VM_SHADOW_STACK (alias to VM_HIGH_ARCH_5) to encode shadow
stack VMA. VM_SHADOW_STACK is thus not possible on 32bit. Some arches may
need a way to encode shadow stack on 32bit and 64bit both and they may
encode this information differently in VMAs.

This patch changes checks of VM_SHADOW_STACK flag in generic code to call
to a function `arch_is_shadow_stack_vma` which will return true if arch
supports shadow stack and vma is shadow stack else stub returns false.

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 include/linux/mm.h | 15 ++++++++++++++-
 mm/gup.c           |  2 +-
 mm/internal.h      |  2 +-
 3 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/include/linux/mm.h b/include/linux/mm.h
index 418d26608ece..9586e7bbd2aa 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -352,8 +352,21 @@ extern unsigned int kobjsize(const void *objp);
  * for more details on the guard size.
  */
 # define VM_SHADOW_STACK	VM_HIGH_ARCH_5
+
+static inline bool arch_is_shadow_stack_vma(vm_flags_t vm_flags)
+{
+	return (vm_flags & VM_SHADOW_STACK) ? true : false;
+}
+
 #else
+
 # define VM_SHADOW_STACK	VM_NONE
+
+static inline bool arch_is_shadow_stack_vma(vm_flags_t vm_flags)
+{
+	return false;
+}
+
 #endif
 
 #if defined(CONFIG_X86)
@@ -3452,7 +3465,7 @@ static inline unsigned long stack_guard_start_gap(struct vm_area_struct *vma)
 		return stack_guard_gap;
 
 	/* See reasoning around the VM_SHADOW_STACK definition */
-	if (vma->vm_flags & VM_SHADOW_STACK)
+	if (arch_is_shadow_stack_vma(vma->vm_flags))
 		return PAGE_SIZE;
 
 	return 0;
diff --git a/mm/gup.c b/mm/gup.c
index 231711efa390..dcc2aa079163 100644
--- a/mm/gup.c
+++ b/mm/gup.c
@@ -1051,7 +1051,7 @@ static int check_vma_flags(struct vm_area_struct *vma, unsigned long gup_flags)
 		    !writable_file_mapping_allowed(vma, gup_flags))
 			return -EFAULT;
 
-		if (!(vm_flags & VM_WRITE) || (vm_flags & VM_SHADOW_STACK)) {
+		if (!(vm_flags & VM_WRITE) || arch_is_shadow_stack_vma(vm_flags)) {
 			if (!(gup_flags & FOLL_FORCE))
 				return -EFAULT;
 			/* hugetlb does not support FOLL_FORCE|FOLL_WRITE. */
diff --git a/mm/internal.h b/mm/internal.h
index b61034bd50f5..05a6b47c3ca1 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -572,7 +572,7 @@ static inline bool is_exec_mapping(vm_flags_t flags)
  */
 static inline bool is_stack_mapping(vm_flags_t flags)
 {
-	return ((flags & VM_STACK) == VM_STACK) || (flags & VM_SHADOW_STACK);
+	return ((flags & VM_STACK) == VM_STACK) || arch_is_shadow_stack_vma(flags);
 }
 
 /*
-- 
2.43.0


