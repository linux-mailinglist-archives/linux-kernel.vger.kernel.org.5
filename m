Return-Path: <linux-kernel+bounces-136281-lists+linux-kernel=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4235089D230
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 08:14:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 72FB21C20EDD
	for <lists+linux-kernel@lfdr.de>; Tue,  9 Apr 2024 06:14:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDEC7F49B;
	Tue,  9 Apr 2024 06:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b="Z/TmRRtO"
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 322117F46E
	for <linux-kernel@vger.kernel.org>; Tue,  9 Apr 2024 06:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712643143; cv=none; b=n579cJY+XV37jtTI8vlOIsXXDzUipW3OH13nBl2snZ6/EL1+daZBn+jryTD+XWIeEdNTAparcCqWi+zcGyjHPa0kFHF8/tsmxlwwF5ZCZncn7Mt93Zvy6awhmHtX3WHPScZ7suMX/mYoMVTYU9c1yOoXBcUUc/ZHjiyhE6nwy3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712643143; c=relaxed/simple;
	bh=1SikFsWtrh4t3FaHmFJAwNEHKw890mcnFlSrj+OgNFo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=c1sHijOxAyN0qIc/jbtr3yqhwzJ9GrUwZQ2fxTjsZrtqGCkXeBNt36Y7SCI6LxhBKHWzYrddw+5Hf9jC19KmEnkvMLaNKRHeTw8HjtatFpH2FSFGBHbl9y88iG9HBnfTksuhdUZ5C0PlflmaxzOxJZbIVTEzBvtpQGDFc2nbdjQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com; spf=pass smtp.mailfrom=rivosinc.com; dkim=pass (2048-bit key) header.d=rivosinc-com.20230601.gappssmtp.com header.i=@rivosinc-com.20230601.gappssmtp.com header.b=Z/TmRRtO; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=rivosinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rivosinc.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-1e3f17c6491so18603415ad.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Apr 2024 23:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1712643141; x=1713247941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5eyLRloSfAm4VAbw2mb0vtlUweaMWaSGQ+4ZLH4p8KE=;
        b=Z/TmRRtOYAaTYSWv/GSwPxhhS4r2BwF4oHUfyzdE4uIkO/lKhxS4IBpnjOEZy8JkMJ
         B9D/ctMhgKOyq/7P37NMXVLYBab5xLN+2IYaSOXe6zNHnoJDL9BJ8jJ1rlAZeZXfwCCU
         8E4bkwdDO8vX5Qx0343l0F2zBL+3o6W1XiVxmos9rBzKR9/nq+TN+38YD5/UqwDMoSAI
         cjFqWn7lFZqpMn/owdTAkopYM+EKZPlZW5fyKIiDavm2z7/q71OmCStV/SYdwQJiHjQQ
         VmRYtP1jDnwrErUrDFKVXriUTWoMY0LCDqQ9bgMf56MX7KyZGkRHjXqOQeCTAYHgAtmn
         X8Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712643141; x=1713247941;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5eyLRloSfAm4VAbw2mb0vtlUweaMWaSGQ+4ZLH4p8KE=;
        b=Sv3lr2HSseOTEQnaIJmDvKDxDj9zQ8LrMp8yUSTyQGwHydtqyYTTmAoleKmHv6cGwn
         7jnR9c4fLcwfrwit9J6M87rouDPigIEdj8eiAN0WeI/gdM7hGPX9dcsjCHBQgMSmY+8W
         yfmR6vnn26Oili0EeA63qlUFX4u2yKh28GdLQsu07wcIUDAH5zMpcxmqnWDpcnoxOeby
         W9rSPTkqLSoamoH+9KPNzhrg2u77E9ARdSAVCwAjLkjEjewxV5D/bLHSdVjuCupYYiEj
         SxZSaBqKisWiWqz/YtRJzeZ1rAmAtAUAGXSE35vXAR+lVCOmwliC2jO94cKUl8T3t9dN
         VDUw==
X-Forwarded-Encrypted: i=1; AJvYcCWLr0arTFiyCKsNpny3zbKmsBBvd+AwmS3tnTiS2h2cTQdSM0BBOOeKaxds+qlZM/cKyfo65gOj4M1tQub3vRPB5ty+Ic0Oh6WFtqPT
X-Gm-Message-State: AOJu0YwNYUsweA9di+faQfEkNiCG3L6cJLkzBcIQn5Wvm0F52drtwjU7
	2PI2cxbFSDjWr+HN9hlldCbqVhWJz1QfdV7AqnIssn1J/v/0EU52MrQ0s29/KD0=
X-Google-Smtp-Source: AGHT+IF/+B5dCZZ2fDAsFsANYw0fpAWmmT/lMg64J6EsXmicMtuMSgnbMt5ZcKKjDaAElTdglXn3vA==
X-Received: by 2002:a17:903:2d2:b0:1e4:1f86:88d6 with SMTP id s18-20020a17090302d200b001e41f8688d6mr5701471plk.17.1712643141573;
        Mon, 08 Apr 2024 23:12:21 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
        by smtp.gmail.com with ESMTPSA id n3-20020a170902e54300b001e3dd5972ccsm5775564plf.185.2024.04.08.23.12.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Apr 2024 23:12:21 -0700 (PDT)
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
Subject: [RFC PATCH 12/12] riscv: enable kernel shadow stack and landing pad enforcement
Date: Mon,  8 Apr 2024 23:10:43 -0700
Message-Id: <20240409061043.3269676-13-debug@rivosinc.com>
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

This patch enables kernel shadow stack and landing pad enforcement by
invoking a SBI call. As of now it just issues a SBI_EXT_BASE and a hacked
up opensbi implementation sets the LPE/SSE bits in menvcfg

Eventually, we should have fwft [1] interface using which kernel should be
able to set this enforcement properly

[1] - https://lists.riscv.org/g/tech-prs/message/833

Signed-off-by: Deepak Gupta <debug@rivosinc.com>
---
 arch/riscv/kernel/head.S | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/arch/riscv/kernel/head.S b/arch/riscv/kernel/head.S
index bc248c137c90..1e5bc7b2ee75 100644
--- a/arch/riscv/kernel/head.S
+++ b/arch/riscv/kernel/head.S
@@ -164,6 +164,13 @@ secondary_start_sbi:
 	call relocate_enable_mmu
 #endif
 	call .Lsetup_trap_vector
+	/*
+	 * Temp hack to get menvcfg.SSE=1 and menvcfg.LPE=1 by invoking
+	 * SBI_EXT_BASE
+	 */
+	li a6, 0
+	li a7, 0x10
+	ecall
 	scs_load_current t0
 	lui t2, 0x1
 	tail smp_callin
@@ -313,6 +320,13 @@ SYM_CODE_START(_start_kernel)
 	la tp, init_task
 	la sp, init_thread_union + THREAD_SIZE
 	addi sp, sp, -PT_SIZE_ON_STACK
+	/*
+	 * Temp hack to get menvcfg.SSE=1 and menvcfg.LPE=1 by invoking
+	 * SBI_EXT_BASE
+	 */
+	li a6, 0
+	li a7, 0x10
+	ecall
 	scs_load_current t0
 
 #ifdef CONFIG_KASAN
-- 
2.43.2


