Return-Path: <linux-kernel+bounces-46631-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8B85844234
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 15:51:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E1D21F26B5F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Jan 2024 14:51:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05EC6129A9B;
	Wed, 31 Jan 2024 14:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cAp0dW8N"
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB341272C7;
	Wed, 31 Jan 2024 14:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706712618; cv=none; b=at8PDNpIQ/ScwcJ5rLtZBMhUlcKumK1dAMkf6VoS/WP7a5xjPNLnOrE+LDykajFlwXcB2QpzCfsyXxGTlBBNL3CKIk834grvDMEYbHxlnO7OiJ6wysbfchoCk1SPcwdD/I7gL0h0SNUVwaAnS0z/SMZVqaQvxZzy973b1sB/xE8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706712618; c=relaxed/simple;
	bh=SaAuQV1IqR4PW259BT1CsorI4rkcdjG7Un7U3Ivx0RY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=uEauyvrJDEgoikmH2rDH0x++QyyZW/IudwQjilneStT5dbWG7cKrYnYMu+6VCqZ85A7/GTO3NUfci98/VbRrWs//BZH7RPR/d6cOW1fCoHGrg/hO4UiamVMzn/5yuVvQSMHHqT/ZIHFzmNR7Oetb9IontckCgyu8z/mAyzFYVaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cAp0dW8N; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33ae4205ad8so3013704f8f.2;
        Wed, 31 Jan 2024 06:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1706712614; x=1707317414; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EgAdMMq2AoWWNilPNigg7Nbpcu7FSjABsk32vurOK/A=;
        b=cAp0dW8NgozFlYdh7HnBxhs6EBiDa2ehJA/ilokXAIZ8jGP6LoIggEJikShLzlQdUX
         wMdYNKgB7Oa/5wjXlNtw6c2JcRQkqUzhJDakrBNglK5nPHb0W6hS6vJpQqB7OC8Av7m0
         +QlKPAm03RCiCiOLLAhOj/dODFI0M1IBarkl+cq3Y2G3qHbfACRQOEqXk/n6K6urlBN+
         LrNT6zreMLzTaPzZREt+sR755Mbu8UMsjm10vdSH+x7LktQ4UBm5SEPFiEAZDZZ9wd7v
         uDCLm1Qt6Ik/K7/wQMv989QNDLetxB3jGTIAr+Bg3juc42/VOzs2p8uGSB6sRiBtZcZ+
         Cz4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706712614; x=1707317414;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EgAdMMq2AoWWNilPNigg7Nbpcu7FSjABsk32vurOK/A=;
        b=jIuPpIk/lOoEcQZFAI/FRmjMiH2HZBg22P2YAuXsvRsuEYJ1ogwheT84qw3CuH+iix
         McM1MSH3ebTApdQlVIzimUK62iKrHcRBYslYbLME2llhw4H9Rj5D8vFk+fCVpV/jqKF0
         NKTsgBcuUVa4s/34oR88Sz+c+7yMXlN/+3zCvh2N7F4MTNQ/qiBZbN+unBcPgwEF3Ul+
         606/Hr2dRVTBLmJhaUK6jSE7Opo4I0jG88nU5vxl/HG3fYvZIgrzu3RIW+Ue/d9ZRdOZ
         UnM8Cxli5X9oq7qshDRnoXh3OqkimjZGejm5DVPvFv7EYPWURmyO8HAHH7APd0ePfeic
         u1+A==
X-Gm-Message-State: AOJu0YyhsaYA7LXhRU0vtxHmt3dkBRlxiq7v4VvLvwxW65TdTP2Oub+H
	yLy8dm8JJagEwtLLunHHzoO4bEejqJCUuT0ai8EACzNjHj+k6dj2
X-Google-Smtp-Source: AGHT+IFRT6v8rC9ruh3UI6dztiV62kHw03zIYHJ0VpYeoWNXLg2hPPytoIqnwPVCg0HA7hvUfEmVsg==
X-Received: by 2002:a5d:64ce:0:b0:33a:e834:5545 with SMTP id f14-20020a5d64ce000000b0033ae8345545mr1675049wri.16.1706712614271;
        Wed, 31 Jan 2024 06:50:14 -0800 (PST)
Received: from andrea.wind3.hub ([31.189.8.91])
        by smtp.gmail.com with ESMTPSA id w6-20020a5d4046000000b0033b0d049c71sm419265wrp.54.2024.01.31.06.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jan 2024 06:50:13 -0800 (PST)
From: Andrea Parri <parri.andrea@gmail.com>
To: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	corbet@lwn.net
Cc: mmaas@google.com,
	hboehm@google.com,
	striker@us.ibm.com,
	charlie@rivosinc.com,
	rehn@rivosinc.com,
	rdunlap@infradead.org,
	sorear@fastmail.com,
	linux-riscv@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v4 3/4] locking: Introduce prepare_sync_core_cmd()
Date: Wed, 31 Jan 2024 15:49:35 +0100
Message-Id: <20240131144936.29190-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240131144936.29190-1-parri.andrea@gmail.com>
References: <20240131144936.29190-1-parri.andrea@gmail.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce an architecture function that architectures can use to set
up ("prepare") SYNC_CORE commands.

The function will be used by RISC-V to update its "deferred icache-
flush" data structures (icache_stale_mask).

Architectures defining prepare_sync_core_cmd() static inline need to
select ARCH_HAS_PREPARE_SYNC_CORE_CMD.

Suggested-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
---
 include/linux/sync_core.h | 16 +++++++++++++++-
 init/Kconfig              |  3 +++
 kernel/sched/membarrier.c |  1 +
 3 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/include/linux/sync_core.h b/include/linux/sync_core.h
index 013da4b8b3272..67bb9794b8758 100644
--- a/include/linux/sync_core.h
+++ b/include/linux/sync_core.h
@@ -17,5 +17,19 @@ static inline void sync_core_before_usermode(void)
 }
 #endif
 
-#endif /* _LINUX_SYNC_CORE_H */
+#ifdef CONFIG_ARCH_HAS_PREPARE_SYNC_CORE_CMD
+#include <asm/sync_core.h>
+#else
+/*
+ * This is a dummy prepare_sync_core_cmd() implementation that can be used on
+ * all architectures which provide unconditional core serializing instructions
+ * in switch_mm().
+ * If your architecture doesn't provide such core serializing instructions in
+ * switch_mm(), you may need to write your own functions.
+ */
+static inline void prepare_sync_core_cmd(struct mm_struct *mm)
+{
+}
+#endif
 
+#endif /* _LINUX_SYNC_CORE_H */
diff --git a/init/Kconfig b/init/Kconfig
index 8d4e836e1b6b1..e2bad47922642 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1982,6 +1982,9 @@ source "kernel/Kconfig.locks"
 config ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE
 	bool
 
+config ARCH_HAS_PREPARE_SYNC_CORE_CMD
+	bool
+
 config ARCH_HAS_SYNC_CORE_BEFORE_USERMODE
 	bool
 
diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
index f3d91628d6b8a..6d1f31b3a967b 100644
--- a/kernel/sched/membarrier.c
+++ b/kernel/sched/membarrier.c
@@ -320,6 +320,7 @@ static int membarrier_private_expedited(int flags, int cpu_id)
 		      MEMBARRIER_STATE_PRIVATE_EXPEDITED_SYNC_CORE_READY))
 			return -EPERM;
 		ipi_func = ipi_sync_core;
+		prepare_sync_core_cmd(mm);
 	} else if (flags == MEMBARRIER_FLAG_RSEQ) {
 		if (!IS_ENABLED(CONFIG_RSEQ))
 			return -EINVAL;
-- 
2.34.1


