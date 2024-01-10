Return-Path: <linux-kernel+bounces-22385-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91FC6829CF8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 15:57:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2730A28171B
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Jan 2024 14:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 168A34CB56;
	Wed, 10 Jan 2024 14:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KNDs6P6r"
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81994CB27;
	Wed, 10 Jan 2024 14:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a28b2e1a13fso444335066b.3;
        Wed, 10 Jan 2024 06:56:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704898569; x=1705503369; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cEsiVEXZ3aHRFWQgBMV3CYshoa+SSWa26OTBHMwiUvc=;
        b=KNDs6P6rM02RykLozrGoI+FROJqXg73tnkaaBgchryrp6UH2k94Pj/+xViw0WhXcA/
         SiB6NBX5EmJ3wLsytBsgjp4nc2uAPXX11EUlDz8jf+Rqr/ux+clGQvr7qvdQqnmvjveS
         eM3EDlbafQJGhsNeyHv4ljhyL/g7VIA0w4teRIUIUunnqOG7W5s3miJW9n5Q9fPeWRnI
         0Y3dez+VPvb+zWP/webpjmkb38cntkRj6lEucEDb6FYO8fyCEXXxsjv0wqES95bJs+eD
         pIADt1R4aBxNBvt7mhimGay3+w3xTpO/0QCnRkMFlmYvuUc5ZXhWKxIrBdViXYNyfEdQ
         XaYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704898569; x=1705503369;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cEsiVEXZ3aHRFWQgBMV3CYshoa+SSWa26OTBHMwiUvc=;
        b=rHduOY+RzvWYGphgK7LEThdZFWDXPLBEGGLcf1wmQy2Ty7SFg/DOs426fFD0gDQfbB
         hCzwlnHsHulAQxkfAcm0s/g7aHbc/QxJU7WfYHzrjFxifPDpGAGjLIJISy35c2FaXrVh
         kJxaiYkc5zb16bOVBcV0uBE1JNQy1RkKP9fTYfiZTOjnzo3QUs2fvTo1ON/QpyoKEbtJ
         rFx5bfW/n1qHJD34YXqUptraNXztv9jX9OUFAZ7gtAxngGIgYBtX+zST4QUrNmdYVsaM
         R9XMqxIRhfQ0L5bbiQITIzhrmHGyoyYYElnvgF7P2IklgiOuurL2jUtv0Tp5fKpeohml
         Ltiw==
X-Gm-Message-State: AOJu0Yy9uBQ9Q6cC/Mb1DEVjrMzr2+AuUpbxvaAxH2qliFs5F78iCkOm
	pKW9t15OrqLaU+TQFoi3icA=
X-Google-Smtp-Source: AGHT+IFwxGwbeQbDiKjtn0R8Py9o0Em/I6mAlCsr3OSjWzlRKLx4g5GXutJihc3ls0LK+MenHk9Vjw==
X-Received: by 2002:a17:906:168d:b0:a2b:61dd:1687 with SMTP id s13-20020a170906168d00b00a2b61dd1687mr665162ejd.116.1704898569033;
        Wed, 10 Jan 2024 06:56:09 -0800 (PST)
Received: from andrea.wind3.hub ([31.189.29.12])
        by smtp.gmail.com with ESMTPSA id bm3-20020a170906c04300b00a2a4efe7d3dsm2161032ejb.79.2024.01.10.06.56.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jan 2024 06:56:08 -0800 (PST)
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
	linux-riscv@lists.infradead.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrea Parri <parri.andrea@gmail.com>
Subject: [PATCH v3 3/4] locking: Introduce prepare_sync_core_cmd()
Date: Wed, 10 Jan 2024 15:55:32 +0100
Message-Id: <20240110145533.60234-4-parri.andrea@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240110145533.60234-1-parri.andrea@gmail.com>
References: <20240110145533.60234-1-parri.andrea@gmail.com>
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
index 9ffb103fc927b..87daf50838f02 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1972,6 +1972,9 @@ source "kernel/Kconfig.locks"
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


