Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7C4F7750CF
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 04:15:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230359AbjHICPF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Aug 2023 22:15:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230455AbjHICPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Aug 2023 22:15:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3560B1BD3
        for <linux-kernel@vger.kernel.org>; Tue,  8 Aug 2023 19:14:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1691547257;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yR44ogH6UDfncEstCVw9mSlc1d7ANRRQAVF648wbdjc=;
        b=ccKJCTSeZLh+a3usv3PTHRAW1GYDOfgwiEoyYbrIag47rmQpz9f6ANzaB4shd4GJVSk63Q
        fmR/wiZbRxMAFeMFdtTJGB1/SQD+Ozzzbk7W7ssn3ArZmkExC3xYSOE9tsUhMNroCSaTHr
        1hCJFm+8Oy6W81cOxw3kTSUoFd8Mzqs=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-xq9A6TIuN7mbAS6ZXW-eYQ-1; Tue, 08 Aug 2023 22:14:15 -0400
X-MC-Unique: xq9A6TIuN7mbAS6ZXW-eYQ-1
Received: by mail-ot1-f72.google.com with SMTP id 46e09a7af769-6bb31e13a13so11085595a34.1
        for <linux-kernel@vger.kernel.org>; Tue, 08 Aug 2023 19:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691547254; x=1692152054;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yR44ogH6UDfncEstCVw9mSlc1d7ANRRQAVF648wbdjc=;
        b=WFiIawWKMOs16siPhz4KO0owLIAclMJBxA5zlm54/ilVeFGJc/Urs2i1SjFuNKaWZx
         KocSGB7NTdTlQkZd9yGLY62da/PNDVWKp8ty867b/K3nZEvCggE8j2XkNT3d63qcx9Ag
         MC5zlRInJJpKF1+N8lGtOPAkLm96bNcAZKCm2Ob6PGbVFFKi131ZDoR90ptaXPCWVzGh
         +J6brggIxd5u+lKFEqVYOncnZzPATFJtHTV02essNB+aRByctGyxe2v9iLY9YID8s9v+
         09Liv0B4ObRUmIijIPCQEV830+quotBmPafqBOkofu5a61Ve7HigCh98sv8z9B1mmUFk
         iEJQ==
X-Gm-Message-State: AOJu0Yw3lTOkMRgf1pNw1cX1KvEfChaXGuCTqFE/i7yZ7VsGQlmAmhh8
        HnZcPwG1oMrjj7eOordVgq0YZFinJ0zj4NplNsbUj14Aek4lgEKr3gaJoHiOBg7sKYIt1Sp+Q2p
        UclwjycqICpAAMqJK/1JLqx+K
X-Received: by 2002:a05:6870:40d1:b0:1be:d3a1:fd9 with SMTP id l17-20020a05687040d100b001bed3a10fd9mr1815530oal.9.1691547254601;
        Tue, 08 Aug 2023 19:14:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHviWJ7FwqHHQS/IFWOJZUUEtSZUVOo6M1kD/UsKsoQJL4BRummKJuVjUiXc3Pder8uF/0zRw==
X-Received: by 2002:a05:6870:40d1:b0:1be:d3a1:fd9 with SMTP id l17-20020a05687040d100b001bed3a10fd9mr1815505oal.9.1691547254170;
        Tue, 08 Aug 2023 19:14:14 -0700 (PDT)
Received: from localhost.localdomain ([2804:431:c7ec:e667:6b7d:ed55:c363:a088])
        by smtp.gmail.com with ESMTPSA id v10-20020a4a8c4a000000b0054fba751207sm6475518ooj.47.2023.08.08.19.14.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Aug 2023 19:14:13 -0700 (PDT)
From:   Leonardo Bras <leobras@redhat.com>
To:     Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Leonardo Bras <leobras@redhat.com>,
        Andrea Parri <parri.andrea@gmail.com>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Guo Ren <guoren@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: [RFC PATCH v4 4/5] riscv/cmpxchg: Implement cmpxchg for variables of size 1 and 2
Date:   Tue,  8 Aug 2023 23:13:09 -0300
Message-ID: <20230809021311.1390578-6-leobras@redhat.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809021311.1390578-2-leobras@redhat.com>
References: <20230809021311.1390578-2-leobras@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

cmpxchg for variables of size 1-byte and 2-bytes is not yet available for
riscv, even though its present in other architectures such as arm64 and
x86. This could lead to not being able to implement some locking mechanisms
or requiring some rework to make it work properly.

Implement 1-byte and 2-bytes cmpxchg in order to achieve parity with other
architectures.

Signed-off-by: Leonardo Bras <leobras@redhat.com>
---
 arch/riscv/include/asm/cmpxchg.h | 34 ++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/arch/riscv/include/asm/cmpxchg.h b/arch/riscv/include/asm/cmpxchg.h
index 5a07646fae65..cfada8a7cfd2 100644
--- a/arch/riscv/include/asm/cmpxchg.h
+++ b/arch/riscv/include/asm/cmpxchg.h
@@ -72,6 +72,35 @@
  * indicated by comparing RETURN with OLD.
  */
 
+#define __arch_cmpxchg_masked(sc_sfx, prepend, append, r, p, o, n)	\
+({									\
+	u32 *__ptr32b = (u32 *)((ulong)(p) & ~0x3);			\
+	ulong __s = ((ulong)(p) & (0x4 - sizeof(*p))) * BITS_PER_BYTE;	\
+	ulong __mask = GENMASK(((sizeof(*p)) * BITS_PER_BYTE) - 1, 0)	\
+			<< __s;						\
+	ulong __newx = (ulong)(n) << __s;				\
+	ulong __oldx = (ulong)(o) << __s;				\
+	ulong __retx;							\
+	ulong __rc;							\
+									\
+	__asm__ __volatile__ (						\
+		prepend							\
+		"0:	lr.w %0, %2\n"					\
+		"	and  %1, %0, %z5\n"				\
+		"	bne  %1, %z3, 1f\n"				\
+		"	and  %1, %0, %z6\n"				\
+		"	or   %1, %1, %z4\n"				\
+		"	sc.w" sc_sfx " %1, %1, %2\n"			\
+		"	bnez %1, 0b\n"					\
+		append							\
+		"1:\n"							\
+		: "=&r" (__retx), "=&r" (__rc), "+A" (*(__ptr32b))	\
+		: "rJ" ((long)__oldx), "rJ" (__newx),			\
+		  "rJ" (__mask), "rJ" (~__mask)				\
+		: "memory");						\
+									\
+	r = (__typeof__(*(p)))((__retx & __mask) >> __s);		\
+})
 
 #define __arch_cmpxchg(lr_sfx, sc_sfx, prepend, append, r, p, co, o, n)	\
 ({									\
@@ -98,6 +127,11 @@
 	__typeof__(*(ptr)) __ret;					\
 									\
 	switch (sizeof(*__ptr)) {					\
+	case 1:								\
+	case 2:								\
+		__arch_cmpxchg_masked(sc_sfx, prepend, append,		\
+					__ret, __ptr, __old, __new);	\
+		break;							\
 	case 4:								\
 		__arch_cmpxchg(".w", ".w" sc_sfx, prepend, append,	\
 				__ret, __ptr, (long), __old, __new);	\
-- 
2.41.0

