Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4A378F748
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Sep 2023 04:44:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348186AbjIACoA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 22:44:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348178AbjIACnw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 22:43:52 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EC76E77;
        Thu, 31 Aug 2023 19:43:45 -0700 (PDT)
X-QQ-mid: bizesmtp77t1693536209t8i43xj8
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 01 Sep 2023 10:43:26 +0800 (CST)
X-QQ-SSF: 01200000000000907000000A0000000
X-QQ-FEAT: QityeSR92A0LOme/49hD1dohgKPUj6JFZbPA6VXALGirx2d9SGmHC4LPSlhoU
        vMq4vEqz1ROL+SpIvLl0a+/+eeOy6xbdAUAPetw8n4bF9Ive3MyQJpJYbNvtlPFV7LE9dLO
        uR2HdijIKe9vEeds/ifikTIA5fL1B5wwRq33VFA+BhsuzW00D1XUGPNU58heRTZ1CV9aGuq
        UqTR9gT6tVPFperJe9++X7kT8rwfzXhPpO1R23+ansfsvUccRLAPsJV3XESMjSsAslaWfq8
        xEdHtz/KkcNq6wxRvuHKHakDHy5sZ5arD6qUkRrH1QIoRaJrbaEwgK60RnIMNHH1neVfPvz
        yOObQBJcRvkpFx9eBT0F9LWRK1iDyZde2vzawjAYWq5wbiFFVA=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6151706240093031970
From:   Yuan Tan <tanyuan@tinylab.org>
To:     mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, mingo@redhat.com, tsbogend@alpha.franken.de,
        hdegoede@redhat.com
Cc:     linux@weissschuh.net, w@1wt.eu, falcon@tinylab.org,
        linux-mips@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH v2 3/3] kconfig: add dependencies of POWER_RESET for PowerMac
Date:   Fri,  1 Sep 2023 10:43:25 +0800
Message-Id: <60cbfd566777a6d6e3664d7f29fa91424716c873.1693535514.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1693535514.git.tanyuan@tinylab.org>
References: <cover.1693535514.git.tanyuan@tinylab.org>
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

PowerMac's power off depends on ADB_CUDA to work. Enable it when
POWER_RESET is set for convenience.

Suggested-by: Zhangjin Wu <falcon@tinylab.org>
Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 arch/powerpc/platforms/powermac/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/platforms/powermac/Kconfig b/arch/powerpc/platforms/powermac/Kconfig
index 130707ec9f99..9e633d7e8367 100644
--- a/arch/powerpc/platforms/powermac/Kconfig
+++ b/arch/powerpc/platforms/powermac/Kconfig
@@ -2,6 +2,7 @@
 config PPC_PMAC
 	bool "Apple PowerMac based machines"
 	depends on PPC_BOOK3S && CPU_BIG_ENDIAN
+	select ADB_CUDA if POWER_RESET
 	select MPIC
 	select FORCE_PCI
 	select PPC_INDIRECT_PCI if PPC32
-- 
2.34.1


