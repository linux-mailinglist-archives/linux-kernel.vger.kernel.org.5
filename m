Return-Path: <linux-kernel+bounces-111824-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 40A7B887156
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 17:56:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0825288965
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Mar 2024 16:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B070260DCF;
	Fri, 22 Mar 2024 16:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bBHV3xKK"
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B43E60BB0
	for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 16:53:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711126387; cv=none; b=COHJz/ou/FuFiU9It8N/xVmRhJSicDtG6OFFvRS7BvJXMFrRceL7MoBuHkL/P92aBFRwziTLoBckcbZjpfY9IaRkBnWXwr0CfAHMqwf4s4F3FaRSVtKBAPAiRMDAf/MPoEWB1RR8jwEMA1LrlE9CNdJ2EfXRsWIO1Fvbk2RHs5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711126387; c=relaxed/simple;
	bh=adghTFAiBRcGv1s4L/JWtTrZ77UQy5mB45gZTj8Fw1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IA7BGFf3j1rhhbfXNy9HQ3sc4PQ2dF0bRg3yBRWMy7bxPZGv0DhgXyOpNUnnKKZqm24snodLQWfideYMw5fgQEKUTNk+xMVjt8qD5ZZapofWcecjMFFf7/3GkrQH8Ys9Z2Dsws0EE0U00BvxSJ7Np2PhSE9/S0yewSYND9gjozM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bBHV3xKK; arc=none smtp.client-ip=209.85.222.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f178.google.com with SMTP id af79cd13be357-789f3bbe3d6so168584385a.0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Mar 2024 09:53:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711126384; x=1711731184; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Att3x3WRfP739iu4vR8QvOBOGtQSu4+V6eHVKQWaBoQ=;
        b=bBHV3xKKPOzV6wK3qdmnyX/LdVEn8i6FSjVeKxZA4KPC2RdgeWOXjcvcKck2Na0rsT
         dKM1tkfnpztja5Z187VxMW5NfCMjBvj4/Maj1YePuBuDCHhV8jTJobo771jHl7HdYdiM
         F6haEEIYjo16RZKPwhjF/pYPADsM4qJXagL6r9BS9nlE22Rw973/zB+JD2fuh7K1Inzj
         7rreKi7A7Z6UZzl3vdCHi+eEOFqVHuhYnTCP00VSr05Q4zERzUArfV7Uy37hjhi1bAZp
         DcJAoC81pS7B5WDMd4ieYyzhfgy1eNJ/JTnkbd6nTmF9DaJVt6CEwLQkLJLyswEW+nEw
         TLtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711126384; x=1711731184;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Att3x3WRfP739iu4vR8QvOBOGtQSu4+V6eHVKQWaBoQ=;
        b=xRAa0GVULiiG81kepQwJgXAEZInuYAthfc/7rc9CwrxjHltXgctPSArffQ3boxSZFB
         igPjAJKBZM/lnnrEz5VpuZZ5T71RSO0JrtAuHC/1vYlg9RCYZxnvU0CrVNN+5xCfa3b9
         0WV2Hg5dpsNwNU/8/5BKrsBXnQO7q8TYmhrqH8ZEN72E2oCts949TEXUslEx/y2mn2yf
         xSAz64wZ1UGX60PoB084cegPoBfwoTNJVxRVgiWfSc4DUbJoSM8TzwR6o8J2z0LJ8la+
         AXN07YAF2FjSCxbrIrTc9wf9HTaZ9R0qvzn15L6IuDPjwDUV3NgvBZD45CD2rNPW/dXN
         UzEg==
X-Gm-Message-State: AOJu0Yzq3ShoMGL/KPOTOLKkFpgtmr40brmuI7lmLpgV4xv/eG64Ckvb
	Kxx+H05H4EzsLdG96z9EFdCgNenDr437g531191I5w8D2iRp9pjRU+XPyKk=
X-Google-Smtp-Source: AGHT+IG9Be47ZO3qLJv82ZM7piyxvucAHz94ZN85hLcNaUIR/QOR5nkQ8WYtKbY1121XuxZVwykt2Q==
X-Received: by 2002:a05:620a:40d3:b0:788:3cb:5cf8 with SMTP id g19-20020a05620a40d300b0078803cb5cf8mr8161qko.6.1711126384492;
        Fri, 22 Mar 2024 09:53:04 -0700 (PDT)
Received: from citadel.lan (2600-6c4a-4d3f-6d5c-0000-0000-0000-1019.inf6.spectrum.com. [2600:6c4a:4d3f:6d5c::1019])
        by smtp.gmail.com with ESMTPSA id j1-20020a37ef01000000b00789e9bbf962sm894901qkk.133.2024.03.22.09.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Mar 2024 09:53:03 -0700 (PDT)
From: Brian Gerst <brgerst@gmail.com>
To: linux-kernel@vger.kernel.org,
	x86@kernel.org
Cc: Ingo Molnar <mingo@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Borislav Petkov <bp@alien8.de>,
	"H . Peter Anvin" <hpa@zytor.com>,
	Uros Bizjak <ubizjak@gmail.com>,
	David.Laight@aculab.com,
	Brian Gerst <brgerst@gmail.com>
Subject: [PATCH v4 14/16] percpu: Remove PERCPU_VADDR()
Date: Fri, 22 Mar 2024 12:52:31 -0400
Message-ID: <20240322165233.71698-15-brgerst@gmail.com>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240322165233.71698-1-brgerst@gmail.com>
References: <20240322165233.71698-1-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

x86-64 was the last user.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
---
 include/asm-generic/vmlinux.lds.h | 41 ++-----------------------------
 1 file changed, 2 insertions(+), 39 deletions(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index 74f169772778..430b2ed2aa58 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -1044,47 +1044,10 @@
 	__per_cpu_end = .;
 
 /**
- * PERCPU_VADDR - define output section for percpu area
+ * PERCPU_SECTION - define output section for percpu area
  * @cacheline: cacheline size
- * @vaddr: explicit base address (optional)
- * @phdr: destination PHDR (optional)
  *
- * Macro which expands to output section for percpu area.
- *
- * @cacheline is used to align subsections to avoid false cacheline
- * sharing between subsections for different purposes.
- *
- * If @vaddr is not blank, it specifies explicit base address and all
- * percpu symbols will be offset from the given address.  If blank,
- * @vaddr always equals @laddr + LOAD_OFFSET.
- *
- * @phdr defines the output PHDR to use if not blank.  Be warned that
- * output PHDR is sticky.  If @phdr is specified, the next output
- * section in the linker script will go there too.  @phdr should have
- * a leading colon.
- *
- * Note that this macros defines __per_cpu_load as an absolute symbol.
- * If there is no need to put the percpu section at a predetermined
- * address, use PERCPU_SECTION.
- */
-#define PERCPU_VADDR(cacheline, vaddr, phdr)				\
-	__per_cpu_load = .;						\
-	.data..percpu vaddr : AT(__per_cpu_load - LOAD_OFFSET) {	\
-		PERCPU_INPUT(cacheline)					\
-	} phdr								\
-	. = __per_cpu_load + SIZEOF(.data..percpu);
-
-/**
- * PERCPU_SECTION - define output section for percpu area, simple version
- * @cacheline: cacheline size
- *
- * Align to PAGE_SIZE and outputs output section for percpu area.  This
- * macro doesn't manipulate @vaddr or @phdr and __per_cpu_load and
- * __per_cpu_start will be identical.
- *
- * This macro is equivalent to ALIGN(PAGE_SIZE); PERCPU_VADDR(@cacheline,,)
- * except that __per_cpu_load is defined as a relative symbol against
- * .data..percpu which is required for relocatable x86_32 configuration.
+ * Align to PAGE_SIZE and outputs output section for percpu area.
  */
 #define PERCPU_SECTION(cacheline)					\
 	. = ALIGN(PAGE_SIZE);						\
-- 
2.44.0


