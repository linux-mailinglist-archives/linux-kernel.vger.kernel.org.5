Return-Path: <linux-kernel+bounces-12179-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A233C81F0F7
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 18:39:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56F76284BD3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Dec 2023 17:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AF2C47F4D;
	Wed, 27 Dec 2023 17:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="yzCweyMQ"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FDDA46556
	for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 17:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-6da579e6858so3795396a34.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Dec 2023 09:38:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1703698699; x=1704303499; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AlBR54Ho+Y1o3mIpBCBVXs2u+7/gciH5xwmXB5mwVNU=;
        b=yzCweyMQJ0jdqNz5/4fcz0oROC2uVObTYKGRkVMTlWGcqdO7V08Ij0neJbelykYlEE
         npr6fSeboWp9rjulHEuh5NdzRovEgeIjZwhxB8HMMc8z+UHDbvlC5z74TXTt5SwwjiM0
         ipWGLu9mpaR6UrwGRQ7MwJ2MJX8pNXiQe/EWXi5caJrCMhXvUmDDzgJr+Ib8JQnq1bnn
         9TS0NjkDboO4lRJhPTbCItuG42Tx9WonEKj/lMGpSus/b1WqAvze+ys05PKvGKruX35v
         NRuQAh2DEQG5muDVsNxeRk/Kj7tdDDrkP0hWOZChG7qlcJukQ6ZJp3lp3c/KUT7AVsj+
         Xoaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703698699; x=1704303499;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AlBR54Ho+Y1o3mIpBCBVXs2u+7/gciH5xwmXB5mwVNU=;
        b=ZisXp7kFNAkYTdM8WL5xv2az1iDfl1fNs6va95PmWZTMoENNSdHMD9x/9Gk7J8iy2t
         DoopYFwTRepktFV9nFO8iaV2HpvaWdo4Q4cAkyF2Y66W7Ds3GSP5vwrogNHEuta4vvia
         tc3PeECvoDkdY6lHZ7UYiTcB8SkQyCyTOaooPPULFEAFCcBJpw8F0qfH4fCnOMC4LX67
         r0FaJ+gQ+oaPVzhzyHOVgJfxHmJbXW2GyaIfR+DI1g/uFgvuIGytXiIrxq7VDDIXNTP7
         XeO3eK9nDb1cLYxJaoPDsUcI6YeXAIF8MknafFbb5fh2ndUQ3suSemdFdE6B3NIzl1oa
         wshg==
X-Gm-Message-State: AOJu0YzLzM0G/y2AOhM26/n+bJ1xOWk3pqOTJIz4DOcUX4OZYeYwsSYB
	u2YzcVGOAdCW4bS3llSS8vnQHzAsLftMUA==
X-Google-Smtp-Source: AGHT+IHczMMzH5Cn/QQoEKkSMMw5EFDLZJOpZnee5RpHBMsp4qHZ0VZY8kIAUCAOz7amU68R78p+EA==
X-Received: by 2002:a05:6870:5249:b0:203:eb66:3bab with SMTP id o9-20020a056870524900b00203eb663babmr9774414oai.54.1703698699564;
        Wed, 27 Dec 2023 09:38:19 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id rl15-20020a056871650f00b002049c207104sm1337173oab.27.2023.12.27.09.38.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Dec 2023 09:38:19 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Wed, 27 Dec 2023 09:38:02 -0800
Subject: [PATCH v14 3/5] riscv: Add checksum header
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20231227-optimize_checksum-v14-3-ddfd48016566@rivosinc.com>
References: <20231227-optimize_checksum-v14-0-ddfd48016566@rivosinc.com>
In-Reply-To: <20231227-optimize_checksum-v14-0-ddfd48016566@rivosinc.com>
To: Charlie Jenkins <charlie@rivosinc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Conor Dooley <conor@kernel.org>, 
 Samuel Holland <samuel.holland@sifive.com>, 
 David Laight <David.Laight@aculab.com>, Xiao Wang <xiao.w.wang@intel.com>, 
 Evan Green <evan@rivosinc.com>, Guo Ren <guoren@kernel.org>, 
 linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-arch@vger.kernel.org
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
 Albert Ou <aou@eecs.berkeley.edu>, Arnd Bergmann <arnd@arndb.de>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1703698692; l=3093;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=5kLrZ5pIGOixKzGlevacL81yKd58H4/jGvyu52ss5bM=;
 b=3U9itHHqS9xaCdluBkJYwsc1am00JcT/biurx7FiRMdr90d9yE4HTjBnrQeNRpbdA51oMB9S5
 DbdrJtJ8v0oD7Y5u/gxJQC8ATbj1SXcEttVfdfOu/fIFZjnsXHx4hFQ
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Provide checksum algorithms that have been designed to leverage riscv
instructions such as rotate. In 64-bit, can take advantage of the larger
register to avoid some overflow checking.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
Acked-by: Conor Dooley <conor.dooley@microchip.com>
Reviewed-by: Xiao Wang <xiao.w.wang@intel.com>
---
 arch/riscv/include/asm/checksum.h | 82 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 82 insertions(+)

diff --git a/arch/riscv/include/asm/checksum.h b/arch/riscv/include/asm/checksum.h
new file mode 100644
index 000000000000..5a810126aac7
--- /dev/null
+++ b/arch/riscv/include/asm/checksum.h
@@ -0,0 +1,82 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Checksum routines
+ *
+ * Copyright (C) 2023 Rivos Inc.
+ */
+#ifndef __ASM_RISCV_CHECKSUM_H
+#define __ASM_RISCV_CHECKSUM_H
+
+#include <linux/in6.h>
+#include <linux/uaccess.h>
+
+#define ip_fast_csum ip_fast_csum
+
+/* Define riscv versions of functions before importing asm-generic/checksum.h */
+#include <asm-generic/checksum.h>
+
+/**
+ * Quickly compute an IP checksum with the assumption that IPv4 headers will
+ * always be in multiples of 32-bits, and have an ihl of at least 5.
+ *
+ * @ihl: the number of 32 bit segments and must be greater than or equal to 5.
+ * @iph: assumed to be word aligned given that NET_IP_ALIGN is set to 2 on
+ *  riscv, defining IP headers to be aligned.
+ */
+static inline __sum16 ip_fast_csum(const void *iph, unsigned int ihl)
+{
+	unsigned long csum = 0;
+	int pos = 0;
+
+	do {
+		csum += ((const unsigned int *)iph)[pos];
+		if (IS_ENABLED(CONFIG_32BIT))
+			csum += csum < ((const unsigned int *)iph)[pos];
+	} while (++pos < ihl);
+
+	/*
+	 * ZBB only saves three instructions on 32-bit and five on 64-bit so not
+	 * worth checking if supported without Alternatives.
+	 */
+	if (IS_ENABLED(CONFIG_RISCV_ISA_ZBB) &&
+	    IS_ENABLED(CONFIG_RISCV_ALTERNATIVE)) {
+		unsigned long fold_temp;
+
+		asm_volatile_goto(ALTERNATIVE("j %l[no_zbb]", "nop", 0,
+					      RISCV_ISA_EXT_ZBB, 1)
+		    :
+		    :
+		    :
+		    : no_zbb);
+
+		if (IS_ENABLED(CONFIG_32BIT)) {
+			asm(".option push				\n\
+			.option arch,+zbb				\n\
+				not	%[fold_temp], %[csum]		\n\
+				rori	%[csum], %[csum], 16		\n\
+				sub	%[csum], %[fold_temp], %[csum]	\n\
+			.option pop"
+			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
+		} else {
+			asm(".option push				\n\
+			.option arch,+zbb				\n\
+				rori	%[fold_temp], %[csum], 32	\n\
+				add	%[csum], %[fold_temp], %[csum]	\n\
+				srli	%[csum], %[csum], 32		\n\
+				not	%[fold_temp], %[csum]		\n\
+				roriw	%[csum], %[csum], 16		\n\
+				subw	%[csum], %[fold_temp], %[csum]	\n\
+			.option pop"
+			: [csum] "+r" (csum), [fold_temp] "=&r" (fold_temp));
+		}
+		return (__force __sum16)(csum >> 16);
+	}
+no_zbb:
+#ifndef CONFIG_32BIT
+	csum += ror64(csum, 32);
+	csum >>= 32;
+#endif
+	return csum_fold((__force __wsum)csum);
+}
+
+#endif /* __ASM_RISCV_CHECKSUM_H */

-- 
2.43.0


