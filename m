Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C6A7E8E8A
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjKLGPo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:15:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjKLGPm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:15:42 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28DE02D63
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:15:39 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8497BC433CC;
        Sun, 12 Nov 2023 06:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769738;
        bh=zy+LIqvorCsCX2M/f8auQf0yEixqHw8DL0243s77+7Q=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RM0z84tJA0mRaJMee/k+ux2axfXtnnmJ3Vb+KxOgBWXWNeRBvHdig4yh5SxFL/lQ0
         0RrdKxAfQFL7jVYOmeEuWUKEWuDoO7tNWc53/eZ5c5AJC3PgcAcPf7+D1rw1+p9Z7s
         JYx7Kmod9QzBxqdXH5lkw9zW+2FQx1auZTTrL7nLONLkq+gsHo1gqcDVSk4noc1+IV
         RRUETV07GcboogqBaZbB47abzXtGphvh1F6qvVBifBtCcgerIOVzkbLbmpGnJyB5dM
         UZoQUmchMmgaX3UEokh6oG7q0vDslWUjM+ykEQrxEK/4i/3MFYIJp5AVvEyR3Mm4Sq
         Q8Xwhyfhctnng==
From:   guoren@kernel.org
To:     arnd@arndb.de, guoren@kernel.org, palmer@rivosinc.com,
        tglx@linutronix.de, conor.dooley@microchip.com, heiko@sntech.de,
        apatel@ventanamicro.com, atishp@atishpatra.org, bjorn@kernel.org,
        paul.walmsley@sifive.com, anup@brainfault.org, jiawei@iscas.ac.cn,
        liweiwei@iscas.ac.cn, wefu@redhat.com, U2FsdGVkX1@gmail.com,
        wangjunqiang@iscas.ac.cn, kito.cheng@sifive.com,
        andy.chiu@sifive.com, vincent.chen@sifive.com,
        greentime.hu@sifive.com, wuwei2016@iscas.ac.cn, jrtc27@jrtc27.com,
        luto@kernel.org, fweimer@redhat.com, catalin.marinas@arm.com,
        hjl.tools@gmail.com
Cc:     linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-riscv@lists.infradead.org, Guo Ren <guoren@linux.alibaba.com>
Subject: [RFC PATCH V2 02/38] riscv: u64ilp32: Remove compat_vdso/
Date:   Sun, 12 Nov 2023 01:14:38 -0500
Message-Id: <20231112061514.2306187-3-guoren@kernel.org>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20231112061514.2306187-1-guoren@kernel.org>
References: <20231112061514.2306187-1-guoren@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Guo Ren <guoren@linux.alibaba.com>

After unifying vdso32 & vdso64 into vdso/, we ever needn't compat_vdso
directory. This commit removes the whole compat_vdso/.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/kernel/compat_vdso/.gitignore                 | 2 --
 arch/riscv/kernel/compat_vdso/compat_vdso.S              | 8 --------
 arch/riscv/kernel/compat_vdso/compat_vdso.lds.S          | 3 ---
 arch/riscv/kernel/compat_vdso/flush_icache.S             | 3 ---
 arch/riscv/kernel/compat_vdso/gen_compat_vdso_offsets.sh | 5 -----
 arch/riscv/kernel/compat_vdso/getcpu.S                   | 3 ---
 arch/riscv/kernel/compat_vdso/note.S                     | 3 ---
 arch/riscv/kernel/compat_vdso/rt_sigreturn.S             | 3 ---
 8 files changed, 30 deletions(-)
 delete mode 100644 arch/riscv/kernel/compat_vdso/.gitignore
 delete mode 100644 arch/riscv/kernel/compat_vdso/compat_vdso.S
 delete mode 100644 arch/riscv/kernel/compat_vdso/compat_vdso.lds.S
 delete mode 100644 arch/riscv/kernel/compat_vdso/flush_icache.S
 delete mode 100755 arch/riscv/kernel/compat_vdso/gen_compat_vdso_offsets.sh
 delete mode 100644 arch/riscv/kernel/compat_vdso/getcpu.S
 delete mode 100644 arch/riscv/kernel/compat_vdso/note.S
 delete mode 100644 arch/riscv/kernel/compat_vdso/rt_sigreturn.S

diff --git a/arch/riscv/kernel/compat_vdso/.gitignore b/arch/riscv/kernel/compat_vdso/.gitignore
deleted file mode 100644
index 19d83d846c1e..000000000000
--- a/arch/riscv/kernel/compat_vdso/.gitignore
+++ /dev/null
@@ -1,2 +0,0 @@
-# SPDX-License-Identifier: GPL-2.0-only
-compat_vdso.lds
diff --git a/arch/riscv/kernel/compat_vdso/compat_vdso.S b/arch/riscv/kernel/compat_vdso/compat_vdso.S
deleted file mode 100644
index ffd66237e091..000000000000
--- a/arch/riscv/kernel/compat_vdso/compat_vdso.S
+++ /dev/null
@@ -1,8 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#define	vdso_start	compat_vdso_start
-#define	vdso_end	compat_vdso_end
-
-#define	__VDSO_PATH	"arch/riscv/kernel/compat_vdso/compat_vdso.so"
-
-#include "../vdso/vdso.S"
diff --git a/arch/riscv/kernel/compat_vdso/compat_vdso.lds.S b/arch/riscv/kernel/compat_vdso/compat_vdso.lds.S
deleted file mode 100644
index c7c9355d311e..000000000000
--- a/arch/riscv/kernel/compat_vdso/compat_vdso.lds.S
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#include "../vdso/vdso.lds.S"
diff --git a/arch/riscv/kernel/compat_vdso/flush_icache.S b/arch/riscv/kernel/compat_vdso/flush_icache.S
deleted file mode 100644
index 523dd8b96045..000000000000
--- a/arch/riscv/kernel/compat_vdso/flush_icache.S
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#include "../vdso/flush_icache.S"
diff --git a/arch/riscv/kernel/compat_vdso/gen_compat_vdso_offsets.sh b/arch/riscv/kernel/compat_vdso/gen_compat_vdso_offsets.sh
deleted file mode 100755
index 8ac070c783b3..000000000000
--- a/arch/riscv/kernel/compat_vdso/gen_compat_vdso_offsets.sh
+++ /dev/null
@@ -1,5 +0,0 @@
-#!/bin/sh
-# SPDX-License-Identifier: GPL-2.0
-
-LC_ALL=C
-sed -n -e 's/^[0]\+\(0[0-9a-fA-F]*\) . \(__vdso_[a-zA-Z0-9_]*\)$/\#define compat\2_offset\t0x\1/p'
diff --git a/arch/riscv/kernel/compat_vdso/getcpu.S b/arch/riscv/kernel/compat_vdso/getcpu.S
deleted file mode 100644
index 10f463efe271..000000000000
--- a/arch/riscv/kernel/compat_vdso/getcpu.S
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#include "../vdso/getcpu.S"
diff --git a/arch/riscv/kernel/compat_vdso/note.S b/arch/riscv/kernel/compat_vdso/note.S
deleted file mode 100644
index b10312907542..000000000000
--- a/arch/riscv/kernel/compat_vdso/note.S
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#include "../vdso/note.S"
diff --git a/arch/riscv/kernel/compat_vdso/rt_sigreturn.S b/arch/riscv/kernel/compat_vdso/rt_sigreturn.S
deleted file mode 100644
index 884aada4facc..000000000000
--- a/arch/riscv/kernel/compat_vdso/rt_sigreturn.S
+++ /dev/null
@@ -1,3 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#include "../vdso/rt_sigreturn.S"
-- 
2.36.1

