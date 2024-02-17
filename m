Return-Path: <linux-kernel+bounces-69596-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FF98858C28
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 02:00:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF7151F21AEB
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Feb 2024 01:00:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E9C61DA21;
	Sat, 17 Feb 2024 00:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="g8rH5Ppg"
Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C6F1D52B
	for <linux-kernel@vger.kernel.org>; Sat, 17 Feb 2024 00:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708131510; cv=none; b=oj9IjPycSd5kM7xjwFFX20eznZstcs7XH7LOmYf489cSx7sDgcCts6kE7lt56dL8jqQDsBLRKNn1IkDThpRY4hRdPZRJzb65EGzUWKxZvjvbNtD/0aq+/QfQ2+fJjRPPVvrLjdGFpOL7z1T+ecN07dJG6l83p7oAIfDJ9SQ21Nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708131510; c=relaxed/simple;
	bh=HwQLSOaSysKB57XjfW856whj8y+8/2+fgWJrX4Iklho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=pX0tPCfcaGObpGdqs6sLHA9oQwakoTzOH3YFMY5QxB2JxJQxJi8IaY7Q1pPVAABCNO2QBrBPretlITRl2EN8gO/PE0pj/EoHd7c3vAHbU8xv+MlzN+RikxkwrEj/0FoE4q/zxxDHY+k/nd8nBU+QgvFrFu9AKJe3YESx1TMiVGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=g8rH5Ppg; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3642281e4a6so4021845ab.2
        for <linux-kernel@vger.kernel.org>; Fri, 16 Feb 2024 16:58:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1708131507; x=1708736307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tZxqoC10roX3FmWShwLO5FF28+Cew6bJztG9VlJd1gc=;
        b=g8rH5PpgVFeqkgsI9vorPN6vIDaoG6bmYjVOjyUjVR0fybhnZIpZpQUYadYAcyXs2a
         1RjFSh2RA4exO6fqgWfNa8uHkodI5tPLrjV2zVoQrL2zRS9WxcPkJ38nzhnsjUaxsCbj
         BAJ8Nbff8MqoAym8dWt4K1243RDBdcRoTNHv2saAqQJnQGwJlD3CnHZWTq8GLQ9GhlBU
         1kVYl6Y2KOdem1mmJcV1xMPdU0dk5Re+uExRWJCf5gLmNIE3YPmD5Q2yU2EQmy3Qwa8f
         lWCQDNxjXEDnuNcCw/uBOZ7KXM9wVf9bSIxjCw4juZDPPK9jSK7sTqfSRcQ6lPjXfDxj
         UgCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708131507; x=1708736307;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tZxqoC10roX3FmWShwLO5FF28+Cew6bJztG9VlJd1gc=;
        b=APC4oUyD/9T8QADHiBfNnh70Cc+wPrer535JPMm2uG5UtKffCxRYxqdcGWdX9V74h6
         0t6raIKdXoEYwkNvWB5YlzZMPtNYA5C9qZ4RZzxLEQIZhcdw7/0NRg5jTGZm1DdYzWd5
         ZObSBfW9BjzFm6lAf/F8eXIeYDPVNihPtsr2+v1Bpjwnb1gSjtylNUJYijuR6Lgd2MDC
         iIKd1OW2qWHrxogT3lbI2t1G7Jq7X+g61U7DbdczSpWpl8FQOyO/kgA6uf9U9xXb4PO0
         il6BByxMGCqUhQHnNMHIylMTdHK7GCrWer/Xh6jVkPrFNc43kLqLzQkPG7DH9eG0kPBh
         aUBQ==
X-Gm-Message-State: AOJu0Yxg4SPxonRyKaoQz6xtQiAjlGWYHNjBw1ywyCrezhJr6mFAXy44
	2/UcKx4pKSHmgYXMkz7aSs97vQED8fZo1TGGpEnsh3lbLk8DneLFVG23uELTs+3EzkjamdxaMpL
	z
X-Google-Smtp-Source: AGHT+IEz0+A9x0GTcr1tO8p0VDE5KRpFc1BbSQ5HWLqCdx+AJgXr1jki3q4ZnbUMgc8MM5i0wwekUQ==
X-Received: by 2002:a92:c54d:0:b0:365:1563:c4e5 with SMTP id a13-20020a92c54d000000b003651563c4e5mr2552537ilj.9.1708131506838;
        Fri, 16 Feb 2024 16:58:26 -0800 (PST)
Received: from atishp.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id d188-20020a6336c5000000b005dc89957e06sm487655pga.71.2024.02.16.16.58.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 16:58:26 -0800 (PST)
From: Atish Patra <atishp@rivosinc.com>
To: linux-kernel@vger.kernel.org
Cc: Atish Patra <atishp@rivosinc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>,
	Andrew Jones <ajones@ventanamicro.com>,
	Anup Patel <anup@brainfault.org>,
	Arnaldo Carvalho de Melo <acme@kernel.org>,
	Atish Patra <atishp@atishpatra.org>,
	Christian Brauner <brauner@kernel.org>,
	=?UTF-8?q?Cl=C3=A9ment=20L=C3=A9ger?= <cleger@rivosinc.com>,
	Conor Dooley <conor@kernel.org>,
	devicetree@vger.kernel.org,
	Evan Green <evan@rivosinc.com>,
	Guo Ren <guoren@kernel.org>,
	Heiko Stuebner <heiko@sntech.de>,
	Ian Rogers <irogers@google.com>,
	Ingo Molnar <mingo@redhat.com>,
	James Clark <james.clark@arm.com>,
	Jing Zhang <renyu.zj@linux.alibaba.com>,
	Jiri Olsa <jolsa@kernel.org>,
	Ji Sheng Teoh <jisheng.teoh@starfivetech.com>,
	John Garry <john.g.garry@oracle.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Kan Liang <kan.liang@linux.intel.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	kvm-riscv@lists.infradead.org,
	kvm@vger.kernel.org,
	Ley Foon Tan <leyfoon.tan@starfivetech.com>,
	linux-doc@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Rob Herring <robh+dt@kernel.org>,
	Samuel Holland <samuel.holland@sifive.com>,
	Weilin Wang <weilin.wang@intel.com>,
	Will Deacon <will@kernel.org>,
	kaiwenxue1@gmail.com,
	Yang Jihong <yangjihong1@huawei.com>
Subject: [PATCH RFC 05/20] RISC-V: Define indirect CSR access helpers
Date: Fri, 16 Feb 2024 16:57:23 -0800
Message-Id: <20240217005738.3744121-6-atishp@rivosinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240217005738.3744121-1-atishp@rivosinc.com>
References: <20240217005738.3744121-1-atishp@rivosinc.com>
Precedence: bulk
X-Mailing-List: linux-kernel@vger.kernel.org
List-Id: <linux-kernel.vger.kernel.org>
List-Subscribe: <mailto:linux-kernel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-kernel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The indriect CSR requires multiple instructions to read/write CSR.
Add a few helper functions for ease of usage.

Signed-off-by: Atish Patra <atishp@rivosinc.com>
---
 arch/riscv/include/asm/csr_ind.h | 42 ++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)
 create mode 100644 arch/riscv/include/asm/csr_ind.h

diff --git a/arch/riscv/include/asm/csr_ind.h b/arch/riscv/include/asm/csr_ind.h
new file mode 100644
index 000000000000..9611c221eb6f
--- /dev/null
+++ b/arch/riscv/include/asm/csr_ind.h
@@ -0,0 +1,42 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2024 Rivos Inc.
+ */
+
+#ifndef _ASM_RISCV_CSR_IND_H
+#define _ASM_RISCV_CSR_IND_H
+
+#include <asm/csr.h>
+
+#define csr_ind_read(iregcsr, iselbase, iseloff) ({	\
+	unsigned long value = 0;			\
+	unsigned long flags;				\
+	local_irq_save(flags);				\
+	csr_write(CSR_ISELECT, iselbase + iseloff);	\
+	value = csr_read(iregcsr);			\
+	local_irq_restore(flags);			\
+	value;						\
+})
+
+#define csr_ind_write(iregcsr, iselbase, iseloff, value) ({	\
+	unsigned long flags;					\
+	local_irq_save(flags);					\
+	csr_write(CSR_ISELECT, iselbase + iseloff);		\
+	csr_write(iregcsr, value);				\
+	local_irq_restore(flags);				\
+})
+
+#define csr_ind_warl(iregcsr, iselbase, iseloff, warl_val) ({	\
+	unsigned long old_val = 0, value = 0;			\
+	unsigned long flags;					\
+	local_irq_save(flags);					\
+	csr_write(CSR_ISELECT, iselbase + iseloff);		\
+	old_val = csr_read(iregcsr);				\
+	csr_write(iregcsr, value);				\
+	value = csr_read(iregcsr);				\
+	csr_write(iregcsr, old_val);				\
+	local_irq_restore(flags);				\
+	value;							\
+})
+
+#endif
-- 
2.34.1


