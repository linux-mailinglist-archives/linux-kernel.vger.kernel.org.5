Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C527E8ECD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Nov 2023 07:20:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbjKLGUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Nov 2023 01:20:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbjKLGTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Nov 2023 01:19:39 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE0959D7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Nov 2023 22:18:48 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECE71C433C8;
        Sun, 12 Nov 2023 06:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699769928;
        bh=cuF9JM0r/gsp1vghHnzFT7BkfhIYwfHcWZhIf27n2xY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m3ZnNHPp3EJ0Y7agFTlRHB8X/PRo4qR3eYYHC7/GGu20rmlj22UU0PTGsvORZBD41
         Z+EVPhN5T/bYe++fF/zfE0ELkpn3Rl+4JcZjYGnDj8dkve6+UH4nvo5DwIHyi5vocE
         lEyIrJ7c07LGEPXju8fkDwtlWmfYYETHVZHKz0vDT4MojxgLB2IB9QAF+ZsLh63a03
         pR2u2UEDc3ioOIihJNM3NSJpXwSI0R6vVBvEso2YO33TjSZPsiojurtrZ7sTarcJeo
         6B4ZNSy9+D2Pazrrjl9Uf/Xtbmw46Z1+rZwN/cs4OQLG/0CrQeCn/UoGyKwwXBDYUl
         mbwNziOgXRm7w==
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
Subject: [RFC PATCH V2 33/38] riscv: s64ilp32: Add rv64ilp32_defconfig
Date:   Sun, 12 Nov 2023 01:15:09 -0500
Message-Id: <20231112061514.2306187-34-guoren@kernel.org>
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

Follow the rv32_defconfig rule to add rv64ilp32_defconfig; the only
difference is:
-CONFIG_ARCH_RV32I=y
+CONFIG_ARCH_RV64ILP32=y

Signed-off-by: Guo Ren <guoren@linux.alibaba.com>
Signed-off-by: Guo Ren <guoren@kernel.org>
---
 arch/riscv/Makefile               | 4 ++++
 arch/riscv/configs/64ilp32.config | 2 ++
 2 files changed, 6 insertions(+)
 create mode 100644 arch/riscv/configs/64ilp32.config

diff --git a/arch/riscv/Makefile b/arch/riscv/Makefile
index 3b1435bade49..d01f41fdf57f 100644
--- a/arch/riscv/Makefile
+++ b/arch/riscv/Makefile
@@ -205,3 +205,7 @@ rv32_defconfig:
 PHONY += rv32_nommu_virt_defconfig
 rv32_nommu_virt_defconfig:
 	$(Q)$(MAKE) -f $(srctree)/Makefile nommu_virt_defconfig 32-bit.config
+
+PHONY += rv64ilp32_defconfig
+rv64ilp32_defconfig:
+	$(Q)$(MAKE) -f $(srctree)/Makefile defconfig 64ilp32.config
diff --git a/arch/riscv/configs/64ilp32.config b/arch/riscv/configs/64ilp32.config
new file mode 100644
index 000000000000..7d836aa2fae7
--- /dev/null
+++ b/arch/riscv/configs/64ilp32.config
@@ -0,0 +1,2 @@
+CONFIG_ARCH_RV64ILP32=y
+CONFIG_NONPORTABLE=y
-- 
2.36.1

