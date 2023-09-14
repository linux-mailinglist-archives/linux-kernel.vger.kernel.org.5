Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22B0A79FEAF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 10:44:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236339AbjINIoT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 04:44:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236616AbjINIoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 04:44:12 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 435B71FDF;
        Thu, 14 Sep 2023 01:44:08 -0700 (PDT)
X-QQ-mid: bizesmtp88t1694681032t6ccny3m
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Thu, 14 Sep 2023 16:43:50 +0800 (CST)
X-QQ-SSF: 01200000000000907000000A0000000
X-QQ-FEAT: JP/5YZ9VfwlHz7TeRhPYP0IHlqFA/efHq9hsfved9HyXckQDDoEIUxgjKs7u5
        p3/ieQ1boH9uYtcsNZd5a6PV94X7roqxT2+5qPY5wv39jTsdflxqRYfaPMvcfGmWzKGA42O
        qefqPtSc7QBdfbVo/Sh6tdlho7nhKS2CZV+zxoqV9UT8496E+BaOao5p35apjbhQaf5tS/D
        dQadH9Wf6ZB0nrYfFyy7ZXtQkkT76n/tsdbF8lLKk4DtaFFREA9FeYaUYwYcuYbvAOKLsrA
        bjE8k2+u7IuQIyc8M3gmyMJJwx4HoYuNQA4qfoXwpLypqpS4Vk5HY58e+3uIFXZX9bHe3qq
        tr19702ciT9HWGLu7bAyZ2HILNiMNNq3ufge3nAq4a0jAwyJ+w=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 4896214239601486824
From:   Yuan Tan <tanyuan@tinylab.org>
To:     tsbogend@alpha.franken.de, 42.hyeyoo@gmail.com, philmd@linaro.org
Cc:     linux-mips@vger.kernel.org, christophe.leroy@csgroup.eu,
        linux-kernel@vger.kernel.org, falcon@tinylab.org, w@1wt.eu,
        linux@weissschuh.net, tanyuan@tinylab.org
Subject: [PATCH v3 2/3] Kconfig: add dependencies of POWER_RESET for mips malta
Date:   Thu, 14 Sep 2023 16:43:48 +0800
Message-Id: <4e696edce7d7fef6f990a3cd48c9f78407f49cc6.1694680448.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1694680448.git.tanyuan@tinylab.org>
References: <cover.1694680448.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
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
index fc6fba925aea..b63a93e39f23 100644
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

