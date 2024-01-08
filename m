Return-Path: <linux-kernel+bounces-19098-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F2638267EE
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 07:22:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D4F2B1F219E2
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Jan 2024 06:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41AB946C;
	Mon,  8 Jan 2024 06:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="K2fhodUs"
X-Original-To: linux-kernel@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E498473
	for <linux-kernel@vger.kernel.org>; Mon,  8 Jan 2024 06:21:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6dc53fc4b0dso1155105a34.2
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jan 2024 22:21:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1704694912; x=1705299712; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7zIxoN+SgU88Z6qGdoK7DlJzsgAjm+cXBEiUMLpGQcU=;
        b=K2fhodUssilWIgz7HUJpifg0MUGRWZ3zKMQSdErBcmytWZOJ9OmYGmYINohiwcZCfe
         pTlAJMrOkXw9NcRYApsVYX0GgVps7kUI43ot5hxEC3Xwy9kLYG5iCY900phT84I3HPoD
         he66wcPQi+n1KQp+Ux52FqpumdrMwfm3hHF9LvqNKm1ZiSDnLOnOZDnbkqdfg9EPev3B
         b89h7T64yXaaUdQguJ3ICVdrt67d9oKubOauLZG7I4l5PlhsHvH8eGYn+I8ClxQiM705
         SYzt7coeMQJ4d46tyBQEJHmRlRHP163TpxDI1nDYMyAjmQ+P+SaNLbbk0Zfn0EzgCSRI
         ueQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704694912; x=1705299712;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7zIxoN+SgU88Z6qGdoK7DlJzsgAjm+cXBEiUMLpGQcU=;
        b=um80RZjmkv4CySQulS/8axGV5GUiLcZ2K5qZeqD4Zn6l8dR/zMT/nZ4qbFGb+ddSYc
         LRywnrHyr6tnjugW0q53M3IXScwLb6EobP4BkDH1X6rZgRL5/oKEpnPZ2gY4MIc3Cyd4
         kQCwkC98dXmJBvvLeu+QidlO+K9GXYbZY+unSSzgRze7zF9lQzxq1sSIYvDWI1tJ9lZw
         gI1V+xg5Z9Q8HAkHA6999Znj59JBCbI6ORR5MJexszOCrZpWIvROhRbkXx9J1SmpQku4
         xoiKJlL0fn/yB+nlQV2mCG0hLnMbCs4a0wlH5ft6RzyeIzOEwlGrcCPvQmJw0rW2Rhm+
         a/Fg==
X-Gm-Message-State: AOJu0Yzg6l2cXferjrRzTdKuwqP9peCx75BoUD1xB+bcFq7GcCh7EQ94
	8a0z0+aG3jodSsqfQYa/ThZjcPY3qTGkCA==
X-Google-Smtp-Source: AGHT+IE2RD77UZkWItFT81fkRj5KkrLB/kBjCp/AJOn60PTjV5k/LNvDjNw8kS6q6TlbpgWCWHHmgw==
X-Received: by 2002:a9d:7a85:0:b0:6db:95ba:c422 with SMTP id l5-20020a9d7a85000000b006db95bac422mr2004194otn.41.1704694912539;
        Sun, 07 Jan 2024 22:21:52 -0800 (PST)
Received: from charlie.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id i12-20020a9d53cc000000b006dba99e1835sm1274322oth.4.2024.01.07.22.21.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jan 2024 22:21:52 -0800 (PST)
From: Charlie Jenkins <charlie@rivosinc.com>
Date: Sun, 07 Jan 2024 22:21:46 -0800
Subject: [PATCH v4 2/2] documentation: Document
 PR_RISCV_SET_ICACHE_FLUSH_CTX prctl
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240107-fencei-v4-2-d4cf2fb905d3@rivosinc.com>
References: <20240107-fencei-v4-0-d4cf2fb905d3@rivosinc.com>
In-Reply-To: <20240107-fencei-v4-0-d4cf2fb905d3@rivosinc.com>
To: Paul Walmsley <paul.walmsley@sifive.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
 Jonathan Corbet <corbet@lwn.net>, Conor Dooley <conor.dooley@microchip.com>, 
 =?utf-8?q?Cl=C3=A9ment_L=C3=A9ger?= <cleger@rivosinc.com>, 
 Atish Patra <atishp@atishpatra.org>
Cc: linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, 
 linux-doc@vger.kernel.org, Charlie Jenkins <charlie@rivosinc.com>
X-Mailer: b4 0.12.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1704694908; l=3764;
 i=charlie@rivosinc.com; s=20231120; h=from:subject:message-id;
 bh=somI31K4e1DNhLYi544ikiKSJVE5TPTc178CdwxSACE=;
 b=wOjyNp3Bafs5E4EAXPZDcY5CMZv7eGYP53YeKRTCExbTq0Ej9zlAWZ2834TSECygPHMj+NHYv
 9lX1K2SdI/4Dy5Tn8rFusqYzrPJcIbPyqyeQcXJdQVXSC5NuhF6Mkt6
X-Developer-Key: i=charlie@rivosinc.com; a=ed25519;
 pk=t4RSWpMV1q5lf/NWIeR9z58bcje60/dbtxxmoSfBEcs=

Provide documentation that explains how to properly do CMODX in riscv.

Signed-off-by: Charlie Jenkins <charlie@rivosinc.com>
---
 Documentation/arch/riscv/cmodx.rst | 88 ++++++++++++++++++++++++++++++++++++++
 Documentation/arch/riscv/index.rst |  1 +
 2 files changed, 89 insertions(+)

diff --git a/Documentation/arch/riscv/cmodx.rst b/Documentation/arch/riscv/cmodx.rst
new file mode 100644
index 000000000000..71598850e131
--- /dev/null
+++ b/Documentation/arch/riscv/cmodx.rst
@@ -0,0 +1,88 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+==============================================================================
+Concurrent Modification and Execution of Instructions (CMODX) for RISC-V Linux
+==============================================================================
+
+CMODX is a programming technique where a program executes instructions that were
+modified by the program itself. Instruction storage and the instruction cache
+(icache) is not guaranteed to be synchronized on RISC-V hardware. Therefore, the
+program must enforce its own synchronization with the unprivileged fence.i
+instruction.
+
+However, the default Linux ABI prohibits the use of fence.i in userspace
+applications. At any point the scheduler may migrate a task onto a new hart. If
+migration occurs after the userspace synchronized the icache and instruction
+storage with fence.i, the icache will no longer be clean. This is due to the
+behavior of fence.i only affecting the hart that it is called on. Thus, the hart
+that the task has been migrated to, may not have synchronized instruction
+storage and icache.
+
+There are two ways to solve this problem: use the riscv_flush_icache() syscall,
+or use the ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` prctl() and emit fence.i in
+userspace. The syscall performs a one-off icache flushing operation. The prctl
+changes the Linux ABI to allow userspace to emit icache flushing operations.
+
+1.  prctl() Interface
+---------------------
+
+Call prctl() with ``PR_RISCV_SET_ICACHE_FLUSH_CTX`` as the first argument. The
+remaining arguments will be delegated to the riscv_set_icache_flush_ctx
+function detailed below.
+
+.. kernel-doc:: arch/riscv/mm/cacheflush.c
+	:identifiers: riscv_set_icache_flush_ctx
+
+Example usage:
+
+The following files are meant to be compiled and linked with each other. The
+modify_instruction() function replaces an add with 0 with an add with one,
+causing the instruction sequence in get_value() to change from returning a zero
+to returning a one.
+
+cmodx.c::
+
+	#include <stdio.h>
+	#include <sys/prctl.h>
+
+	extern int get_value();
+	extern void modify_instruction();
+
+	int main()
+	{
+		int value = get_value();
+		printf("Value before cmodx: %d\n", value);
+
+		// Call prctl before first fence.i is called inside modify_instruction
+		prctl(PR_RISCV_SET_ICACHE_FLUSH_CTX_ON, PR_RISCV_CTX_SW_FENCEI, 0);
+		modify_instruction();
+
+		value = get_value();
+		printf("Value after cmodx: %d\n", value);
+		return 0;
+	}
+
+cmodx.S::
+
+	.option norvc
+
+	.text
+	.global modify_instruction
+	modify_instruction:
+	lw a0, new_insn
+	lui a5,%hi(old_insn)
+	sw  a0,%lo(old_insn)(a5)
+	fence.i
+	ret
+
+	.section modifiable, "awx"
+	.global get_value
+	get_value:
+	li a0, 0
+	old_insn:
+	addi a0, a0, 0
+	ret
+
+	.data
+	new_insn:
+	addi a0, a0, 1
diff --git a/Documentation/arch/riscv/index.rst b/Documentation/arch/riscv/index.rst
index 4dab0cb4b900..eecf347ce849 100644
--- a/Documentation/arch/riscv/index.rst
+++ b/Documentation/arch/riscv/index.rst
@@ -13,6 +13,7 @@ RISC-V architecture
     patch-acceptance
     uabi
     vector
+    cmodx
 
     features
 

-- 
2.43.0


