Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51C7078F3D3
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Aug 2023 22:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345161AbjHaUTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Aug 2023 16:19:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344497AbjHaUTS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Aug 2023 16:19:18 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22671E6E;
        Thu, 31 Aug 2023 13:19:14 -0700 (PDT)
X-QQ-mid: bizesmtp68t1693513078t912vfvi
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 01 Sep 2023 04:17:55 +0800 (CST)
X-QQ-SSF: 01200000000000907000B00A0000000
X-QQ-FEAT: RFp2QSjOiS70bvAdNo73VrAi+v1KZ0IU2/YWHvf5zb1aYHwYtFcGSaklF8cmm
        nNAmZDeOP4d2H76EwjzPQ73jLYGP7XsuSrMHKYPs+frl/SjF1V/0or5vI8rEiLT6iEppnU9
        eIanNLI8fA3bFu3x2CJrcrwKo2bRv2vUy1o/uhV3I0AyXKdvq7qyViNO/j5F0TnTTnehOJx
        SlnPxvpoRixCoSlTthXgHEIOPNgs3fU5uLc45lVGWphziK3B7J63S8fBh8tSFUnJQHElylM
        Ok2NxjxQl1mnk0J8SZmcDty8mQc4edE06cpvBxzv2Hz+2pzUcQRCepFMQwqkBPkEmjOsCF3
        kxmTgzrbNTGoolKw/uoeBlhbrvrUq+XXnrw6C1HhqtAx9x3uZyPRrs5cVc4qQ==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 7890783515973196317
From:   Yuan Tan <tanyuan@tinylab.org>
To:     mpe@ellerman.id.au, christophe.leroy@csgroup.eu,
        tglx@linutronix.de, mingo@redhat.com, tsbogend@alpha.franken.de,
        hdegoede@redhat.com
Cc:     linux@weissschuh.net, w@1wt.eu, falcon@tinylab.org,
        linux-mips@vger.kernel.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        Yuan Tan <tanyuan@tinylab.org>
Subject: [PATCH v1 2/3] kconfig: add dependencies of POWER_RESET for x86
Date:   Fri,  1 Sep 2023 04:17:54 +0800
Message-Id: <20230831201754.3177977-1-tanyuan@tinylab.org>
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

