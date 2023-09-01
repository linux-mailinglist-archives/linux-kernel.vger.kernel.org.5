Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B29278F743
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 04:43:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348169AbjIACnU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 22:43:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242345AbjIACnT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 22:43:19 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0D69E7B;
        Thu, 31 Aug 2023 19:43:14 -0700 (PDT)
X-QQ-mid: bizesmtp64t1693536174t9044o1z
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 01 Sep 2023 10:42:51 +0800 (CST)
X-QQ-SSF: 01200000000000907000000A0000000
X-QQ-FEAT: Il1yX1zTS2BHWSstdcCt5mY0CNhZNgSeowA3XGKAQPor4pdSSfB5hjGUTUdBR
        1/LR4dIewrobsjxgeoON5/mNLRFCOACkmeERHihf+EEuqKH4chhMidlUyysBENPMT5zIzj7
        MJpMAZZjnqJwPR+wBk9heRNrwEsh7EeR3hEjYERdXwQpFM6hUgHiFxWf4/W0vsrTtDi6f4w
        Ju5fJnbSsKeUx6v9+HBC2QLVYgn+QURGyQ0x8HqZ2IDJ+kGgXt0b1szXOuLF5uZr6QcmWNH
        +5ZfQ3x0w5vQnMwliDK9dlUGCgKnSU1o+TUU3LYBDaAc+S/TaMnxhYRVVVwX/M9TL6FvKPz
        FP/dqcBBZ+7hta/oN9WXV2KIDKkjePDCcUQzojWK86UJT1sa4k=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5453615526016975982
From:   Yuan Tan <tanyuan@tinylab.org>
To:     mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, mingo@redhat.com, tsbogend@alpha.franken.de,
        hdegoede@redhat.com
Cc:     linux@weissschuh.net, w@1wt.eu, falcon@tinylab.org,
        linux-mips@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH v2 1/3] kconfig: add dependencies of POWER_RESET for mips malta
Date:   Fri,  1 Sep 2023 10:42:49 +0800
Message-Id: <1c17f017d6c837ef887d08bd2f85102df3fbc17c.1693535514.git.tanyuan@tinylab.org>
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

MIPS Malta's power off depends on PCI, PCI_QUIRKS, and
POWER_RESET_PIIX4_POWEROFF to work. Enable them when POWER_RESET is set
for convenience.

Suggested-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 arch/mips/Kconfig | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index bc8421859006..13bacbd05125 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -547,6 +547,9 @@ config MIPS_MALTA
 	select MIPS_L1_CACHE_SHIFT_6
 	select MIPS_MSC
 	select PCI_GT64XXX_PCI0
+	select PCI if POWER_RESET
+	select PCI_QUIRKS if POWER_RESET
+	select POWER_RESET_PIIX4_POWEROFF if POWER_RESET
 	select SMP_UP if SMP
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_MIPS32_R1
-- 
2.34.1

