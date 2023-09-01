Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC3F78F745
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 04:43:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348173AbjIACnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 22:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348165AbjIACnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 22:43:45 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B804A10E2;
        Thu, 31 Aug 2023 19:43:33 -0700 (PDT)
X-QQ-mid: bizesmtp63t1693536189tkmoq9aj
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 01 Sep 2023 10:43:07 +0800 (CST)
X-QQ-SSF: 01200000000000907000000A0000000
X-QQ-FEAT: ILHsT53NKPikqRpUmb/Bp53N8fIQVxFdzsSSCoNVCrrOuCQAPrZzIqNQMmXwh
        2cV4ZEwYZsYDQmtjeppHl/NApjVDPAdVhhpFCD37BgPgcrX9ja0sDgD9L53lCv2duFPC7QU
        pTf5+ppcjZhGpfNJgSNWigrh8XfRNQMhxSAX9DTC3enppkezGVfjYcNALFtMKJPkiEoq0ib
        flW6ae+jepw1MRUmD1R/OcufJgeeBoktpaZmEOGJI1NKKFocM0lhYPf+fj2Sz13ClBt6Eik
        au13Z20pASB3EzZdYDbEG+MjzNS4kPfJ9070Psa7xZ35BCxgmHDyu9yJxjTERumeM0sPNxi
        /SBvwLBhKEesfAaAVcGFeatQEAzEDTBgkRs1fpZPr8X4R8DIoPmDJ+Dje+7pw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 17786608530106017216
From:   Yuan Tan <tanyuan@tinylab.org>
To:     mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, mingo@redhat.com, tsbogend@alpha.franken.de,
        hdegoede@redhat.com
Cc:     linux@weissschuh.net, w@1wt.eu, falcon@tinylab.org,
        linux-mips@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH v2 2/3] kconfig: add dependencies of POWER_RESET for x86
Date:   Fri,  1 Sep 2023 10:43:05 +0800
Message-Id: <0ae69e7038e64c0b068d86301084bc336d30675c.1693535514.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1693535514.git.tanyuan@tinylab.org>
References: <cover.1693535514.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=4.8 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H2,RCVD_IN_PBL,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

x86 and x86_64's power off depends on ACPI and PCI to work. Enable them
when POWER_RESET is set for convenience.

Suggested-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 arch/x86/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 982b777eadc7..5c1632e40bf2 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -58,6 +58,7 @@ config X86
 	#
 	# Note: keep this list sorted alphabetically
 	#
+	select ACPI		if POWER_RESET
 	select ACPI_LEGACY_TABLES_LOOKUP	if ACPI
 	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
 	select ARCH_32BIT_OFF_T			if X86_32
@@ -286,6 +287,7 @@ config X86
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
 	select NEED_SG_DMA_LENGTH
+	select PCI		if POWER_RESET
 	select PCI_DOMAINS			if PCI
 	select PCI_LOCKLESS_CONFIG		if PCI
 	select PERF_EVENTS
-- 
2.34.1

