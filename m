Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BFB97E8EB7
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230265AbjKLGSW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:18:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbjKLGRz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:17:55 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DCCE49D4
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:17:29 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95C71C433CB;
        Sun, 12 Nov 2023 06:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769848;
        bh=81esJgTh4dOkvuzt4uEEBn1Vcq8zmYGS/5KoUzDRHwk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fM4A4qzP2sUTruR53HAyk8qZNaK4mAcObnJjPX2TBzXVU1E9k1oP29D1Ez3sdVbPq
         VsesVknvjqglzsZlFYWy6ftyd3D62nRk2/pz7DZpsI7W7TO8MDjHHs0XUMXsZ7j2fr
         aAj6qKQnOSkGp8jsZBRKxYRlvbmVXPviL5PIdHIDX3N5OPy4/yEVTkn8Pq6uaPa5wO
         lqPxaJT15ygRjwBsrpYDU+yL0kCH8mcajb45/i0aYxr0YIY7ahmWeIEEumtYCKelgs
         5Mr7VtDVKIqN5vVaQ+ZFIaoXjEIzMdQ/RE9v+85S4qGWU+sLPqQYtTovNtmUB3AxHv
         0Vj8D6OiNLLvQ==
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
Subject: [RFC PATCH V2 20/38] riscv: s64ilp32: Add ARCH_RV64ILP32 Kconfig option
Date:   Sun, 12 Nov 2023 01:14:56 -0500
Message-Id: <20231112061514.2306187-21-guoren@kernel.org>
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

Just the same as ARCH_RV64I & ARCH_RV32I, add ARCH_RV64ILP32 config
for s64ilp32 and turn on the s64ilp32 compile switch in the
arch/riscv/Makefile.

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Kconfig  | 7 +++++++
 arch/riscv/Makefile | 5 +++++
 2 files changed, 12 insertions(+)

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 5d770b8e2756..5a3eb5e7d67a 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -334,6 +334,13 @@ config ARCH_RV64I
 	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
 	select SWIOTLB if MMU
 
+config ARCH_RV64ILP32
+	bool "RV64ILP32"
+	depends on NONPORTABLE
+	select 32BIT
+	select MMU
+	select VDSO64ILP32
+
 endchoice
 
 # We must be able to map all physical memory into the kernel, but the compiler
diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 8605050bddd0..3b1435bade49 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -58,6 +58,7 @@ endif
 # ISA string setting
 riscv-march-$(CONFIG_ARCH_RV32I)	:= rv32ima
 riscv-march-$(CONFIG_ARCH_RV64I)	:= rv64ima
+riscv-march-$(CONFIG_ARCH_RV64ILP32)	:= rv64ima
 riscv-march-$(CONFIG_FPU)		:= $(riscv-march-y)fd
 riscv-march-$(CONFIG_RISCV_ISA_C)	:= $(riscv-march-y)c
 riscv-march-$(CONFIG_RISCV_ISA_V)	:= $(riscv-march-y)v
@@ -121,7 +122,11 @@ stack_protector_prepare: prepare0
 endif
 
 # arch specific predefines for sparse
+ifeq ($(CONFIG_ARCH_RV64ILP32),y)
+CHECKFLAGS += -D__riscv
+else
 CHECKFLAGS += -D__riscv -D__riscv_xlen=$(BITS)
+endif
 
 # Default target when executing plain make
 boot		:= arch/riscv/boot
-- 
2.36.1

