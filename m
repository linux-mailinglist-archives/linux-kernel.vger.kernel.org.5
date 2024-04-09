Return-Path: <linux-kernel+bounces-137324-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A3F0389E073
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 18:32:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3C928E1A2
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 16:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE776152DEB;
	Tue,  9 Apr 2024 16:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="duYUX13L"
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D4FA152514
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 16:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712680335; cv=none; b=gMe/YyqHuDJOujlpEYOe8ZWX9RqVM0Avh/YlczQxIum6XGDm/49LRMgXcm9iANInkJX1JIIXIKPjjB2P0qQUfixxAGVbFgF2J25nsO2KCiFmhqO4/tMVkWJrA+28awD0ocdngseaXB8khq28prR61jz8tIFrYTvKcudeMlpVOdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712680335; c=relaxed/simple;
	bh=EsMM6MT3Mtgm7LUI4PtKqcI0Nasp0t7NYtfI9JuuRfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=r8pCaozT4vElJ7aMN+F19k/B3KI/7uSQrtI7FUWVQSaVnTFWBv0+mLTvreVccDl7XAIhbfq5AXdtd/gEhYuVgUWrVS7aHrMeUO+ZoYNUrepuKmH+X999Cy5J0M0pP9uGUWop3FDh1CNu7eBHaf+SF79d0+GcRGz98XM12waUTps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=duYUX13L; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a5199906493so581591166b.1
        for <linux-kernel@vger.kernel.org>; Tue, 09 Apr 2024 09:32:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712680332; x=1713285132; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TSLwui92qumZe1wBlP/ND+aJoY8Tk3GedhdxHzNHdGw=;
        b=duYUX13LVRR16fN7PFRSNOTPXUiWuh13njqbNUZb8WX9GkiB88e0GpbukwxJmvUlTh
         +OTe5YAWamF00gql+7F3/NOP5tWbAyDx/zSlrGuhzyimO16pmKyohnqepzw6ENuB6dha
         5xUHZEwGntpjrk9eVXAaSJxEbqElzZtUnIKCNDI19+65GNxTBjDswcwx1UrsrMDVV81l
         NWPB6IvTkaSQesLghRtQWndeW0uefUny2UjrcETHIMImUMxEnjDNKSsHxePtQVRHQYrP
         bM1PjT6g3tD68865U1p1anexv7pYCfwlAKAXVOS0l8nVoCWjgyvrjsHnemP+AgqYfDUw
         mM2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712680332; x=1713285132;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TSLwui92qumZe1wBlP/ND+aJoY8Tk3GedhdxHzNHdGw=;
        b=pmEZdG+DGBu9R6wVL6YTWPYAAEyMv2B2LxBaXsNU1ELXw3LDvUXZp7CLSXHzKevITB
         Rx498t7Un2EUZQ78qi8pZwlL+LpepTVM7SJRYXjbYUk8UTTSfe19/L71Veo6IhzyjKTh
         q3ruJDYF0r5yHhpIKf2BDF0yiZI6ViEm4KHngBSsWY591iT5GFZwTPDILDFzJNi7IsDr
         fkTlXdz5escz94YiEStzmlXuO8J9wsyF9FYZudsEmBGMC0DUIzQ77T2OYqFkN2lJvgfF
         1s+NVvjx/8vKpbYyueTeYLqE1M2SVqJAEwczIaBBR6bK/02w2VjLj9tRsds3LFx/feA4
         uXcw==
X-Forwarded-Encrypted: i=1; AJvYcCV51iCfCsfFh9WEwEhtQjrNnJyx1ctB4bn0qpbIYhQRlpN+YhcCSuWaKegpgkfttgkNB/RghUlGEpQ9hhyFn/eiZVLq0sqba08inadI
X-Gm-Message-State: AOJu0YxeUAzqPrhrIOJK70Ej5Fs+4T2lSGmf1Qsbh6BlBiSY6x9lSIej
	6aaoSsKjZOMWss6xMN2/0hdewoPCbrxUqUC+J9t0jpSuqgBXirGw
X-Google-Smtp-Source: AGHT+IFsvALI+LihPlGUEiUUGNGRt+iuCjTY7bH+CHJlB0KV2nf4XX+a1ixueZH4I/smu08Xr+kjzA==
X-Received: by 2002:a17:907:e8d:b0:a51:db9a:47ca with SMTP id ho13-20020a1709070e8d00b00a51db9a47camr4473696ejc.28.1712680331513;
        Tue, 09 Apr 2024 09:32:11 -0700 (PDT)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id gx26-20020a1709068a5a00b00a46b4c09670sm5904265ejc.131.2024.04.09.09.32.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 09:32:10 -0700 (PDT)
From: Uros Bizjak <ubizjak@gmail.com>
To: mark.rutland@arm.com,
	x86@kernel.org,
	linux-kernel@vger.kernel.org
Cc: Uros Bizjak <ubizjak@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@kernel.org>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	Peter Zijlstra <peterz@infradead.org>
Subject: [PATCH v2 1/4] locking/atomic/x86: Introduce arch_atomic64_try_cmpxchg to x86_32
Date: Tue,  9 Apr 2024 18:30:29 +0200
Message-ID: <20240409163200.188498-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce arch_atomic64_try_cmpxchg for 32-bit targets to use
optimized target specific implementation instead of a generic one.
This implementation eliminates dual-word compare after
cmpxchg8b instruction and improves generated asm code from:

    2273:	f0 0f c7 0f          	lock cmpxchg8b (%edi)
    2277:	8b 74 24 2c          	mov    0x2c(%esp),%esi
    227b:	89 d3                	mov    %edx,%ebx
    227d:	89 c2                	mov    %eax,%edx
    227f:	89 5c 24 10          	mov    %ebx,0x10(%esp)
    2283:	8b 7c 24 30          	mov    0x30(%esp),%edi
    2287:	89 44 24 1c          	mov    %eax,0x1c(%esp)
    228b:	31 f2                	xor    %esi,%edx
    228d:	89 d0                	mov    %edx,%eax
    228f:	89 da                	mov    %ebx,%edx
    2291:	31 fa                	xor    %edi,%edx
    2293:	09 d0                	or     %edx,%eax
    2295:	0f 85 a5 00 00 00    	jne    2340 <...>

to:

    2270:	f0 0f c7 0f          	lock cmpxchg8b (%edi)
    2274:	0f 85 a6 00 00 00    	jne    2320 <...>

Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/x86/include/asm/atomic64_32.h | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/include/asm/atomic64_32.h b/arch/x86/include/asm/atomic64_32.h
index d510405e4e1d..11e817dab44a 100644
--- a/arch/x86/include/asm/atomic64_32.h
+++ b/arch/x86/include/asm/atomic64_32.h
@@ -61,12 +61,18 @@ ATOMIC64_DECL(add_unless);
 #undef __ATOMIC64_DECL
 #undef ATOMIC64_EXPORT
 
-static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 o, s64 n)
+static __always_inline s64 arch_atomic64_cmpxchg(atomic64_t *v, s64 old, s64 new)
 {
-	return arch_cmpxchg64(&v->counter, o, n);
+	return arch_cmpxchg64(&v->counter, old, new);
 }
 #define arch_atomic64_cmpxchg arch_atomic64_cmpxchg
 
+static __always_inline bool arch_atomic64_try_cmpxchg(atomic64_t *v, s64 *old, s64 new)
+{
+	return arch_try_cmpxchg64(&v->counter, old, new);
+}
+#define arch_atomic64_try_cmpxchg arch_atomic64_try_cmpxchg
+
 static __always_inline s64 arch_atomic64_xchg(atomic64_t *v, s64 n)
 {
 	s64 o;
-- 
2.42.0


