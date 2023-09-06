Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E75E679347B
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Sep 2023 06:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238805AbjIFEr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Sep 2023 00:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237827AbjIFErU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Sep 2023 00:47:20 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8578ECE6
        for <linux-kernel@vger.kernel.org>; Tue,  5 Sep 2023 21:47:16 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-1bf11b1c7d0so3955575ad.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Sep 2023 21:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1693975636; x=1694580436; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pC6fMrxiPM6PX4ZKYPXZ18bjUEmiAKintmn8mf3Gycg=;
        b=MMzBM3s3NFqZJO3k7v3XaJbk1fGFnJMF9lNg7NBN4Rv17lh+wtuB1FtmGnY4ekskDW
         uAG7GIOv2XUcx7t9VoWikXlobsV0v80G10OeJGrpkmXQmN9EkVS4vVEdX/21dwpvVQPF
         MxqBjDIxj1c2nHHaMtWruXSZssiDd5r/J+kKE7t+V+0/WMXTxHr2EDlEKo8UE9z7luRr
         c4owyP9AoB1J9cooyu5qnt+U616Tq3Hct7J0Ns0WxfECbjwv6f5en0LsTyEDNv8LSjMy
         n5xPUPlgCiZoncmEWjd+fvHoFrAaoIfhEn8zY2MnmSP7iZgGHAcLY3XLYs7yVvDXxd27
         ZqBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693975636; x=1694580436;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pC6fMrxiPM6PX4ZKYPXZ18bjUEmiAKintmn8mf3Gycg=;
        b=E8bCLHFpSDr37Rrn3444brk80oKpQErD9Lc1BRx/349GfHVrzG1j0IVX8R12/DkpSJ
         Mk2Wjn8YNps8l/zHpEA8MJGvsp0FAgJXFSQ9M0o5rHvZZjkMLEM6a0yjbzbP0IGpE2x+
         0wN9h88WSrg+O2Tc8/SGrvHbaDwQPh1vPtDgi230HBiLj6lkvNlHqQILwFrAijcwWsWR
         SLpXJCOjFQl/Typ1HljaHuh0bxbTjv2RMpt8r8i2XDdODvKqjUlz5xgJlWXqcKCkOA4C
         OqNTWo13c6Jrw+zlIK65d/ZWpmkTw21L/ua/YhRfSovFTstt/OMjRpjKANAmRZUbSOmT
         VVcA==
X-Gm-Message-State: AOJu0YyOCp73KD2c3F8dC7eEDobKVwfkU8Mfx/2y7Zr/sagS3wxmPl3y
        KdYvOO/RZMCXk89SVRn/yVrTRg==
X-Google-Smtp-Source: AGHT+IF3hLuJVMY5VEx+Jx/XBHupQVgXjaJh6LKZ1JrX6r6XMhKoO3c1y3QvRTWL3Jk4/kBtOjbhXA==
X-Received: by 2002:a17:902:d4ce:b0:1b6:a37a:65b7 with SMTP id o14-20020a170902d4ce00b001b6a37a65b7mr20966438plg.23.1693975635980;
        Tue, 05 Sep 2023 21:47:15 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id g11-20020a1709026b4b00b001bc56c1a384sm10087313plt.277.2023.09.05.21.47.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Sep 2023 21:47:15 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Tue, 05 Sep 2023 21:46:53 -0700
Subject: [PATCH v2 4/5] riscv: Vector checksum library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230905-optimize_checksum-v2-4-ccd658db743b@rivosinc.com>
References: <20230905-optimize_checksum-v2-0-ccd658db743b@rivosinc.com>
In-Reply-To: <20230905-optimize_checksum-v2-0-ccd658db743b@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is not ready for merge as vector support in the kernel is
limited. However, the code has been tested in QEMU so the algorithms
do work. When Vector support is more mature, I will do more thorough
testing of this code. It is written in assembly rather than using
the GCC vector instrinsics because they did not provide optimal code.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/lib/csum.c | 106 ++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 106 insertions(+)

diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
index 87f1f95f44c1..e44edd056625 100644
--- a/arch/riscv/lib/csum.c
+++ b/arch/riscv/lib/csum.c
@@ -12,6 +12,10 @@
 
 #include <net/checksum.h>
 
+#ifdef CONFIG_RISCV_ISA_V
+#include <riscv_vector.h>
+#endif
+
 /* Default version is sufficient for 32 bit */
 #ifndef CONFIG_32BIT
 __sum16 csum_ipv6_magic(const struct in6_addr *saddr,
@@ -115,6 +119,108 @@ unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
 	offset = (csum_t)buff & OFFSET_MASK;
 	kasan_check_read(buff, len);
 	ptr = (const csum_t *)(buff - offset);
+#ifdef CONFIG_RISCV_ISA_V
+	if (IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+		/*
+		 * Vector is likely available when the kernel is compiled with
+		 * vector support, so nop when vector is available and jump when
+		 * vector is not available.
+		 */
+		asm_volatile_goto(ALTERNATIVE("j %l[no_vector]", "nop", 0,
+					      RISCV_ISA_EXT_v, 1)
+				  :
+				  :
+				  :
+				  : no_vector);
+	} else {
+		if (!__riscv_isa_extension_available(NULL, RISCV_ISA_EXT_v))
+			goto no_vector;
+	}
+
+	len += offset;
+
+	vuint64m1_t prev_buffer;
+	vuint32m1_t curr_buffer;
+	unsigned int shift, cl, tail_seg;
+	csum_t vl, csum;
+	const csum_t *ptr;
+
+#ifdef CONFIG_32BIT
+	csum_t high_result, low_result;
+#else
+	csum_t result;
+#endif
+
+	// Read the tail segment
+	tail_seg = len % 4;
+	csum = 0;
+	if (tail_seg) {
+		shift = (4 - tail_seg) * 8;
+		csum = *(unsigned int *)((const unsigned char *)ptr + len - tail_seg);
+		csum = ((unsigned int)csum << shift) >> shift;
+		len -= tail_seg;
+	}
+
+	unsigned int start_mask = (unsigned int)(~(~0U << offset));
+
+	riscv_v_enable();
+	asm(".option push						\n\
+	.option arch, +v						\n\
+	vsetvli %[vl], %[len], e8, m1, ta, ma				\n\
+	# clear out mask and vector registers since we switch up sizes	\n\
+	vmclr.m v0							\n\
+	vmclr.m %[prev_buffer]						\n\
+	vmclr.m %[curr_buffer]						\n\
+	# Mask out the leading bits of a misaligned address		\n\
+	vsetivli x0, 1, e64, m1, ta, ma					\n\
+	vmv.s.x %[prev_buffer], %[csum]					\n\
+	vmv.s.x v0, %[start_mask]					\n\
+	vsetvli %[vl], %[len], e8, m1, ta, ma				\n\
+	vmnot.m v0, v0							\n\
+	vle8.v %[curr_buffer], (%[buff]), v0.t				\n\
+	j 2f								\n\
+	# Iterate through the buff and sum all words			\n\
+	1:								\n\
+	vsetvli %[vl], %[len], e8, m1, ta, ma				\n\
+	vle8.v %[curr_buffer], (%[buff])				\n\
+	2:								\n\
+	vsetvli x0, x0, e32, m1, ta, ma					\n\
+	vwredsumu.vs %[prev_buffer], %[curr_buffer], %[prev_buffer]	\n\t"
+#ifdef CONFIG_32BIT
+	"sub %[len], %[len], %[vl]					\n\
+	slli %[vl], %[vl], 2						\n\
+	add %[buff], %[vl], %[buff]					\n\
+	bnez %[len], 1b							\n\
+	vsetvli x0, x0, e64, m1, ta, ma					\n\
+	vmv.x.s %[result], %[prev_buffer]				\n\
+	addi %[vl], x0, 32						\n\
+	vsrl.vx %[prev_buffer], %[prev_buffer], %[vl]			\n\
+	vmv.x.s %[high_result], %[prev_buffer]				\n\
+	.option pop"
+	    : [vl] "=&r"(vl), [prev_buffer] "=&vd"(prev_buffer),
+	      [curr_buffer] "=&vd"(curr_buffer),
+	      [high_result] "=&r"(high_result), [low_result] "=&r"(low_result)
+	    : [buff] "r"(ptr), [len] "r"(len), [start_mask] "r"(start_mask),
+	      [csum] "r"(csum));
+
+	high_result += low_result;
+	high_result += high_result < low_result;
+#else // !CONFIG_32BIT
+	"subw %[len], %[len], %[vl]					\n\
+	slli %[vl], %[vl], 2						\n\
+	addw %[buff], %[vl], %[buff]					\n\
+	bnez %[len], 1b							\n\
+	vsetvli x0, x0, e64, m1, ta, ma					\n\
+	vmv.x.s %[result], %[prev_buffer]				\n\
+	.option pop"
+	    : [vl] "=&r"(vl), [prev_buffer] "=&vd"(prev_buffer),
+	      [curr_buffer] "=&vd"(curr_buffer), [result] "=&r"(result)
+	    : [buff] "r"(ptr), [len] "r"(len), [start_mask] "r"(start_mask),
+	      [csum] "r"(csum));
+#endif // !CONFIG_32BIT
+	riscv_v_disable();
+no_vector:
+#endif // CONFIG_RISCV_ISA_V
 	len = len + offset - sizeof(csum_t);
 
 	/*

-- 
2.42.0

