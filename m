Return-Path: <linux-kernel+bounces-136271-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 394ED89D225
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:12:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5C09B1C21FE9
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C296D763FC;
	Tue,  9 Apr 2024 06:12:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="V2xX2L/D"
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A7A97441A
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643123; cv=none; b=l9/Z7h559xLlthuP06//feDePbhpg3TculONoiFIjtJW/p3WJyvIish7OWoc59je5kIs3jMcBV/nlNwHGDsohXxd4TEuKIX7l+RohqoYSGKZ3BvjiR9swLy2eRmB6UtTZpAJCCfyyQdxGoyGV/Kkd0giUFu2XUCMzjCSwYLyOSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643123; c=relaxed/simple;
	bh=5sZFa9MwpAUEn0MLOkKBsH+G2UQd4bau7WQNBed8iyw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WWpH/vbGg6dj/rSYlKKY0NrRrme5z71s/FImzLvrXU6switx7eTZ0VHWI688YSvQCYIZkXOtwo7JGNr+wjvmi8QcnHcqBPbzEDtvw70Za//JEe9BR/KkE87cQjM1qm/CRKk20ctQNhu3lITkR54v9/vCIW5SqE0tYXAN8xiuS7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=V2xX2L/D; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1e3c3aa8938so24053675ad.1
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 23:12:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712643121; x=1713247921; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JiLAeIECyw84AGrUV1USEqteoHaPU8YvP/EXtLFxWio=;
        b=V2xX2L/DvMMKWI6yS/MWSbs0ue4J43XBqp9OJJP8VwfUf8tYxT/Fi8lghIC5a0EidN
         fiYZhZSbUTCF/dJ+vGLx6bHZqgk7bMbjkoZMrefG/ZtEw6NJ5/m44oqbKNxm+WHKDyiw
         hk3uC1Z3VoYNSwzwd5ydleMo0NkA+XJ9+TYwgikW1PXqWRnyXlto4qUDl+5toh4ijPoI
         bQmRiq2IL10y0Bsrf0C4bENW0nB+m2Y+bmfN6upk5z6q+8Jg3DIlqE0irjfqa3RW8hWU
         FUmPc8GyOozmpaN7UZcXm1acgPCX5TcwSvZHEUGCXz3nm7uW9mp1EhrlCQrdILghLV/1
         UW0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643121; x=1713247921;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JiLAeIECyw84AGrUV1USEqteoHaPU8YvP/EXtLFxWio=;
        b=qtiF/NGv+RcsN+Yy2CzQU3ZsUmjNRRTd5nPhXJDWfV8tkTVRDMAnFhAh9JbboJ65ns
         rJ+r/wMBIVzNbQfJ9n7AmWVBuTcGfV6m8CKp12SG2CfWc3UqmGdP00M6F3IRleSyuF/+
         Ze44GekDLx6X7HFa3vcz07o1PdJ1oOwtx/9qdAgpwwkeETL+gwNVVfGZJk0AOPMOXrNf
         bseTFAaaKFAgh7rc2aYIS4MJ8YrwcULwXcUFXZFBbHNhvt6UCRtNeMJBYasRCw9HCQCd
         CLEKXAyJuZNhSYnJcn1R6Um4PcYfH6BB+jSQXf8DWkPJjUUyBe5GTfWB49+V950rpWqq
         9yCA==
X-Forwarded-Encrypted: i=1; AJvYcCXTdxlyQH7152XjnBzgBzNmJQZAY6eDmY1pyBdY9BEla+TIchccMSfoicHQvb2wK0B6YAuRcDgxTAHADh9+hIj/SkMD49kO0au7xiBo
X-Gm-Message-State: AOJu0YwxnkAFLLIJoI+MWXvshf8MbfNdem9qo2MsUgf9IOoBsEd3aPwt
	AB94t0qkOhAbjwwOkIWPsvxrXup9E0IUs/3s0TmARRqYSuGHQ7c8cZzrho6EKls=
X-Google-Smtp-Source: AGHT+IFEkDe2ZGfs1F8mvdmf/ch3SNQCuQFomQ5uVJDLwaNinIwMUeMD+w87Nmm/x+873W3JBq3PpA==
X-Received: by 2002:a17:902:ce06:b0:1e4:70d0:9337 with SMTP id k6-20020a170902ce0600b001e470d09337mr3182383plg.45.1712643121070;
        Mon, 08 Apr 2024 23:12:01 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001e3dd5972ccsm5775564plf.185.2024.04.08.23.11.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 23:12:00 -0700 (PDT)
From: Deepak Gupta <debug@rivosinc.com>
To: linux-riscv@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev
Cc: paul.walmsley@sifive.com,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	andy.chiu@sifive.com,
	debug@rivosinc.com,
	hankuan.chen@sifive.com,
	guoren@kernel.org,
	greentime.hu@sifive.com,
	samitolvanen@google.com,
	cleger@rivosinc.com,
	apatel@ventanamicro.com,
	ajones@ventanamicro.com,
	conor.dooley@microchip.com,
	mchitale@ventanamicro.com,
	dbarboza@ventanamicro.com,
	waylingii@gmail.com,
	sameo@rivosinc.com,
	alexghiti@rivosinc.com,
	akpm@linux-foundation.org,
	shikemeng@huaweicloud.com,
	rppt@kernel.org,
	charlie@rivosinc.com,
	xiao.w.wang@intel.com,
	willy@infradead.org,
	jszhang@kernel.org,
	leobras@redhat.com,
	songshuaishuai@tinylab.org,
	haxel@fzi.de,
	samuel.holland@sifive.com,
	namcaov@gmail.com,
	bjorn@rivosinc.com,
	cuiyunhui@bytedance.com,
	wangkefeng.wang@huawei.com,
	falcon@tinylab.org,
	viro@zeniv.linux.org.uk,
	bhe@redhat.com,
	chenjiahao16@huawei.com,
	hca@linux.ibm.com,
	arnd@arndb.de,
	kent.overstreet@linux.dev,
	boqun.feng@gmail.com,
	oleg@redhat.com,
	paulmck@kernel.org,
	broonie@kernel.org,
	rick.p.edgecombe@intel.com
Subject: [RFC PATCH 02/12] riscv: add landing pad for asm routines.
Date: Mon,  8 Apr 2024 23:10:33 -0700
Message-Id: <20240409061043.3269676-3-debug@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240409061043.3269676-1-debug@rivosinc.com>
References: <20240409061043.3269676-1-debug@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SYM_* macros are used to define assembly routines. In this patch series,
re-define those macros in risc-v arch specific include file to include
a landing pad instruction at the beginning. This is done only when the
compiler flag for landing pad is enabled (i.e. __riscv_zicfilp).

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/include/asm/linkage.h | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/arch/riscv/include/asm/linkage.h b/arch/riscv/include/asm/linkage.h
index 9e88ba23cd2b..bb43ae7dadeb 100644
--- a/arch/riscv/include/asm/linkage.h
+++ b/arch/riscv/include/asm/linkage.h
@@ -6,7 +6,49 @@
 #ifndef _ASM_RISCV_LINKAGE_H
 #define _ASM_RISCV_LINKAGE_H
 
+#ifdef __ASSEMBLY__
+#include <asm/assembler.h>
+#endif
+
 #define __ALIGN		.balign 4
 #define __ALIGN_STR	".balign 4"
 
+#ifdef __riscv_zicfilp
+/*
+ * A landing pad instruction is needed at start of asm routines
+ * re-define macros for asm routines to have a landing pad at
+ * the beginning of function. Currently use label value of 0x1.
+ * Eventually, label should be calculated as a hash over function
+ * signature.
+ */
+#define SYM_FUNC_START(name)				\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
+	lpad 0x1;
+
+#define SYM_FUNC_START_NOALIGN(name)			\
+	SYM_START(name, SYM_L_GLOBAL, SYM_A_NONE)	\
+	lpad 0x1;
+
+#define SYM_FUNC_START_LOCAL(name)			\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_ALIGN)	\
+	lpad 0x1;
+
+#define SYM_FUNC_START_LOCAL_NOALIGN(name)		\
+	SYM_START(name, SYM_L_LOCAL, SYM_A_NONE)	\
+	lpad 0x1;
+
+#define SYM_FUNC_START_WEAK(name)			\
+	SYM_START(name, SYM_L_WEAK, SYM_A_ALIGN)	\
+	lpad 0x1;
+
+#define SYM_FUNC_START_WEAK_NOALIGN(name)		\
+	SYM_START(name, SYM_L_WEAK, SYM_A_NONE)		\
+	lpad 0x1;
+
+#define SYM_TYPED_FUNC_START(name)				\
+	SYM_TYPED_START(name, SYM_L_GLOBAL, SYM_A_ALIGN)	\
+	lpad 0x1;
+
+#endif
+
 #endif /* _ASM_RISCV_LINKAGE_H */
-- 
2.43.2


