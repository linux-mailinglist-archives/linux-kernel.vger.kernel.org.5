Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0793A78F3D5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:19:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344497AbjHaUTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344885AbjHaUTU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:19:20 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF00AE67;
        Thu, 31 Aug 2023 13:19:16 -0700 (PDT)
X-QQ-mid: bizesmtp85t1693513066t3435cba
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 01 Sep 2023 04:17:43 +0800 (CST)
X-QQ-SSF: 01200000000000907000B00A0000000
X-QQ-FEAT: xqT8U4SkSpiS5kzWesBIBpHIwSbUohjqM3BmRDSEk5odHzMiXVEVNH9xig7LV
        uV3YdW00d2zt2R64tanUZ5WANsF2XzZVvpAXntr5e9OJaq/AUaA0u2K5U+kw5peFg6iyCw7
        dU6TLqEgEtIXrOTEFQs6BEjXtH0+RzNuW/+2MwqBRiTlyPcWgvl873NRgrXzaMq+oQLX6A4
        fo0pA/24ARShHoQoMS1Q2mEEbUdUjdqLgwNJJDp8EE5yDB2HtL6ptUE6n4u512Q/Ndvrh2J
        3Ahvgh1KUE0m8J8eB3+DtmwZkHZxkBtfAKr7oHP8sQsPds83hH/7fOl8bmH1TKnJOobhN7P
        tfsy9R1hwfPlglgvXpciFZjACNI+U0M62grz/Cg36vKpdFbAV8=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 10146932626086328386
From:   Yuan Tan <tanyuan@tinylab.org>
To:     mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, mingo@redhat.com, tsbogend@alpha.franken.de,
        hdegoede@redhat.com
Cc:     linux@weissschuh.net, w@1wt.eu, falcon@tinylab.org,
        linux-mips@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH v1 1/3] kconfig: add dependencies of POWER_RESET for mips malta
Date:   Fri,  1 Sep 2023 04:17:42 +0800
Message-Id: <20230831201742.3177926-1-tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIPS Malta's power off depends on PCI, PCI_QUIRKS, and
POWER_RESET_PIIX4_POWEROFF to work. Enable them when POWER_RESET is set
for convenience.

Suggested-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 arch/mips/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bc8421859006..1d93f3fd0552 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -547,6 +547,9 @@ config MIPS_MALTA
 	select MIPS_L1_CACHE_SHIFT_6
 	select MIPS_MSC
 	select PCI_GT64XXX_PCI0
+	select PCI if POWER_RESET
+    select PCI_QUIRKS if POWER_RESET
+    select POWER_RESET_PIIX4_POWEROFF if POWER_RESET
 	select SMP_UP if SMP
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_MIPS32_R1
-- 
2.34.1

