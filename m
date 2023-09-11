Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E03F79C29A
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Sep 2023 04:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbjILCSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Sep 2023 22:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235897AbjILCSU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Sep 2023 22:18:20 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C20073EBF
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:59:19 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-68fbd31d9ddso1259115b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 11 Sep 2023 15:59:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1694473069; x=1695077869; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=p1/9rWZq+Bz8bqbMD7n5D6gvh0p+ptD4nkWef/+7XvE=;
        b=fA2tTurtPR7/sKLsQdH73HIyt0IHDeg5FnIm+Gg3cb5+3XsBZtLTNu8rBR0y5FQ7qA
         qgcGAhwc+TwUbAQz2tYABwqIxtoQqWoo7zkTbVchc6WelFb5K1IYKRNyek6AGaS9/izN
         RLY/9if9g9mXl98ENPpMxu3o+8Ccxz1Gf/SDB9JNCenGhyQIAausqNXvDhG6TrBNhWAk
         dKzKnW/LVcESXCoT+1GVBeaKagk+uKoWLYfwidAjFn4rpwFbO5eS1IKWlef0WcKplZGc
         Xc9+7JudE92R2sws74s0o4CpQcXKKYeRFtk2+n4Pz8q94lBhHvc9yczxAXk5fRIh+Im+
         eCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694473069; x=1695077869;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p1/9rWZq+Bz8bqbMD7n5D6gvh0p+ptD4nkWef/+7XvE=;
        b=KFHITtW1N9aMC3fox1JOdN8jDKN+/sCRPfr+c+UjxMg7r4bSbCLTsIK1DukJK5bXtN
         1HXJTwO+MQKYzPfWF+ZnDhVSiOvbR7TxrdpvdZ3y7DC4K8QbWXIHz8AOCsVklK41rjZl
         M0rRoyp2TD5ij9GDfeVT5gOQWynt7P0C8jLslHM63JnuXh6jE9RQLFdR8V6Po1nx0V6t
         1AomSJ+xZcJ7hok7lZsf0Bz757UaUGpRKnoIqkHIq9g8vvFVVNZ/xRev4UfywHJiqms2
         A4xYyItwsC3AVfKCSuEQOZk+jK8lfvn5Upg3s6Rah7S3Lbp67lNkZ4qufCoRJqR1bZ49
         mQJQ==
X-Gm-Message-State: AOJu0Yz/1fqpc+04tF94oAgzjgOBAiBmvjaSxgnGgouIDV6mHC7WWDKP
        k+LuzLGE70+zFLZHzAKmNTb6AmY7AsRrYOD06ko=
X-Google-Smtp-Source: AGHT+IH9b/ozwTjgQhCw7xCT5ZfrUMoO4nxNvFOMRsrmE7SzH6JdFZfOC9Osg8zJbgUzFL6Dkp49HA==
X-Received: by 2002:a05:6a00:1d0c:b0:68f:da2a:637b with SMTP id a12-20020a056a001d0c00b0068fda2a637bmr1830560pfx.19.1694473069047;
        Mon, 11 Sep 2023 15:57:49 -0700 (PDT)
Received: from charlie.ba.rivosinc.com ([66.220.2.162])
        by smtp.gmail.com with ESMTPSA id y18-20020aa78052000000b0066a2e8431a0sm6021038pfm.183.2023.09.11.15.57.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Sep 2023 15:57:48 -0700 (PDT)
From:   Charlie Jenkins <charlie@rivosinc.com>
Date:   Mon, 11 Sep 2023 15:57:14 -0700
Subject: [PATCH v4 4/5] riscv: Vector checksum library
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230911-optimize_checksum-v4-4-77cc2ad9e9d7@rivosinc.com>
References: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
In-Reply-To: <20230911-optimize_checksum-v4-0-77cc2ad9e9d7@rivosinc.com>
To:     Charlie Jenkins <charlie@rivosinc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Conor Dooley <conor@kernel.org>,
        Samuel Holland <samuel.holland@sifive.com>,
        David Laight <David.Laight@aculab.com>,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>
X-Mailer: b4 0.12.3
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is not ready for merge as vector support in the kernel is
limited. However, the code has been tested in QEMU so the algorithms
do work. This code requires the kernel to be compiled with C vector
support, but that is not yet possible. It is written in assembly
rather than using the GCC vector instrinsics because they did not
provide optimal code.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 arch/riscv/lib/csum.c | 92 +++++++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 92 insertions(+)

diff --git a/arch/riscv/lib/csum.c b/arch/riscv/lib/csum.c
index 47d98c51bab2..eb4596fc7f5b 100644
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
@@ -115,6 +119,94 @@ unsigned int __no_sanitize_address do_csum(const unsigned char *buff, int len)
 	offset = (csum_t)buff & OFFSET_MASK;
 	kasan_check_read(buff, len);
 	ptr = (const csum_t *)(buff - offset);
+#ifdef CONFIG_RISCV_ISA_V
+	if (!has_vector())
+		goto no_vector;
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
+	kernel_vector_begin();
+	asm(".option push						\n\
+	.option arch, +v						\n\
+	vsetvli	 %[vl], %[len], e8, m1, ta, ma				\n\
+	# clear out mask and vector registers since we switch up sizes	\n\
+	vmclr.m	 v0							\n\
+	vmclr.m	 %[prev_buffer]						\n\
+	vmclr.m  %[curr_buffer]						\n\
+	# Mask out the leading bits of a misaligned address		\n\
+	vsetivli x0, 1, e64, m1, ta, ma					\n\
+	vmv.s.x	 %[prev_buffer], %[csum]				\n\
+	vmv.s.x	 v0, %[start_mask]					\n\
+	vsetvli	 %[vl], %[len], e8, m1, ta, ma				\n\
+	vmnot.m	 v0, v0							\n\
+	vle8.v	 %[curr_buffer], (%[buff]), v0.t			\n\
+	j	 2f							\n\
+	# Iterate through the buff and sum all words			\n\
+	1:								\n\
+	vsetvli	 %[vl], %[len], e8, m1, ta, ma				\n\
+	vle8.v	 %[curr_buffer], (%[buff])				\n\
+	2:								\n\
+	vsetvli x0, x0, e32, m1, ta, ma					\n\
+	vwredsumu.vs	%[prev_buffer], %[curr_buffer], %[prev_buffer]	\n\t"
+#ifdef CONFIG_32BIT
+	"sub	 %[len], %[len], %[vl]					\n\
+	slli	 %[vl], %[vl], 2					\n\
+	add	 %[buff], %[vl], %[buff]				\n\
+	bnez	 %[len], 1b						\n\
+	vsetvli	 x0, x0, e64, m1, ta, ma				\n\
+	vmv.x.s	 %[result], %[prev_buffer]				\n\
+	addi	 %[vl], x0, 32						\n\
+	vsrl.vx	 %[prev_buffer], %[prev_buffer], %[vl]			\n\
+	vmv.x.s	 %[high_result], %[prev_buffer]				\n\
+	.option  pop"
+	    : [vl] "=&r"(vl), [prev_buffer] "=&vd"(prev_buffer),
+	      [curr_buffer] "=&vd"(curr_buffer),
+	      [high_result] "=&r"(high_result), [low_result] "=&r"(low_result)
+	    : [buff] "r"(ptr), [len] "r"(len), [start_mask] "r"(start_mask),
+	      [csum] "r"(csum));
+
+	high_result += low_result;
+	high_result += high_result < low_result;
+#else // !CONFIG_32BIT
+	"subw	 %[len], %[len], %[vl]					\n\
+	slli	 %[vl], %[vl], 2					\n\
+	addw	 %[buff], %[vl], %[buff]				\n\
+	bnez	 %[len], 1b						\n\
+	vsetvli  x0, x0, e64, m1, ta, ma				\n\
+	vmv.x.s  %[result], %[prev_buffer]				\n\
+	.option pop"
+	    : [vl] "=&r"(vl), [prev_buffer] "=&vd"(prev_buffer),
+	      [curr_buffer] "=&vd"(curr_buffer), [result] "=&r"(result)
+	    : [buff] "r"(ptr), [len] "r"(len), [start_mask] "r"(start_mask),
+	      [csum] "r"(csum));
+#endif // !CONFIG_32BIT
+	kernel_vector_end();
+no_vector:
+#endif // CONFIG_RISCV_ISA_V
 	len = len + offset - sizeof(csum_t);
 
 	/*

-- 
2.42.0

