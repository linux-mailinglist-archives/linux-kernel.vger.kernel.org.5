Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD6877A01CE
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 12:37:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237492AbjINKhN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 06:37:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237570AbjINKhL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 06:37:11 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B00461FD4
        for <linux-kernel@vger.kernel.org>; Thu, 14 Sep 2023 03:37:05 -0700 (PDT)
X-QQ-mid: bizesmtp82t1694687798trgejy0d
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 14 Sep 2023 18:36:36 +0800 (CST)
X-QQ-SSF: 01200000000000907000000A0000000
X-QQ-FEAT: PS/N6jJLnDY3DbnSlWdnt226ni/utfNEYD6jhRaHVL5Udll79hFKkE02mz/x3
        5uqP+ZE0PYc6/8JwZD9KN4XmkjVepoi9C9TUrFQOmNJ+BTJ+ylx/MNfkynGxHYtJJjNrXpK
        KgPfQl+2LQnEFjOUwxmAiWaqqaNZFmrth99olnI9AcmkUOH/4BRtARoFXYWyB7k2o6gp1sC
        FKmyM7pNacRon5YHZaoud+82aBfneiyKajxZj4BEvNzWVO5x6qnjBalhO8V4pMgcy005Gh9
        aQAnNfmQ18izJWV+GZP/z/4io+ZbRS6t+CyHUukw1j+CHU1aom9ge6c2cRS7H3uadRl7mEX
        WxhiOp7WKgwGPUhE0LfwJ1a9V8tlBBMw5NfWcpQvasITr1MCqkYffU8LpnfZw==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5100208277114909592
From:   Yuan Tan <tanyuan@tinylab.org>
To:     tglx@linutronix.de, mingo@redhat.com
Cc:     bp@alien8.de, dave.hansen@linux.intel.com,
        linux-kernel@vger.kernel.org, x86@kernel.org, falcon@tinylab.org,
        w@1wt.eu, linux@weissschuh.net, tanyuan@tinylab.org
Subject: [PATCH v3 2/3] Kconfig: Add dependencies of POWER_RESET for x86
Date:   Thu, 14 Sep 2023 18:36:35 +0800
Message-Id: <0f2cbd3026357a3936c0853057ed41b63db83d59.1694687048.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694687048.git.tanyuan@tinylab.org>
References: <cover.1694687048.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
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
index 3b3594f96330..9571507ad40f 100644
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

