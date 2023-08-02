Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADBF876CEFD
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 15:41:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233149AbjHBNlu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 09:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230353AbjHBNls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 09:41:48 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7038B2
        for <linux-kernel@vger.kernel.org>; Wed,  2 Aug 2023 06:41:45 -0700 (PDT)
X-QQ-mid: bizesmtp83t1690983695tkl1bdm6
Received: from dslab-main2-ubuntu.tail147f4.ts ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Aug 2023 21:41:33 +0800 (CST)
X-QQ-SSF: 01200000000000804000000A0000000
X-QQ-FEAT: +ynUkgUhZJn7p/xtroOKoKamEOM95iSfLWNvyAoMRRihsQS51qgYDWZdy/pc0
        vNwyDDKSIlgg578ffugSztrUrp481RiJNo/fcXoOgX5i/W72A/eHa98j3QQ49vMcDKHQQ9D
        wmWOa/NB6hQ0LxeRGjeVLdrIoDeLh9MhqoKko579cpRRzVVm3aj5vM0MZn/jbndpl8iPqaP
        WQRlnfktyQd8HRDtkV4DzR2nyD99uoEURmWeXFMK/4StO86VeZISGu0z9br32PCWPz7GlNQ
        rPMaZBG/4cUu14UzzpmL/pHEnWbuxlH7fJXPX1ZGdBfWFUI4pKFIGmpo8d3nUFsU53tbtdY
        kCOp0Qz2qlmaqRufzyL8Au3q15ydZYaUgLMngJsY8/kFR2Zr0YUTAEBJgNMbA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13677686161433521607
From:   Yuan Tan <tanyuan@tinylab.org>
To:     npiggin@gmail.com, christophe.leroy@csgroup.eu
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        falcon@tinylab.org, tanyuan@tinylab.org, w@1wt.eu,
        linux@weissschuh.net
Subject: [PATCH] powerpc: pmac32: enable serial options by default in defconfig
Date:   Wed,  2 Aug 2023 21:41:30 +0800
Message-Id: <bb7b5f9958b3e3a20f6573ff7ce7c5dc566e7e32.1690982937.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Serial is a critical feature for logging and debuging, and the other
architectures enable serial by default.

Let's enable CONFIG_SERIAL_PMACZILOG and CONFIG_SERIAL_PMACZILOG_CONSOLE
by default.

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 arch/powerpc/configs/pmac32_defconfig | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/configs/pmac32_defconfig b/arch/powerpc/configs/pmac32_defconfig
index 019163c2571e..3aae79afb9d9 100644
--- a/arch/powerpc/configs/pmac32_defconfig
+++ b/arch/powerpc/configs/pmac32_defconfig
@@ -176,8 +176,9 @@ CONFIG_MOUSE_APPLETOUCH=y
 # CONFIG_SERIO_I8042 is not set
 # CONFIG_SERIO_SERPORT is not set
 CONFIG_SERIAL_8250=m
-CONFIG_SERIAL_PMACZILOG=m
+CONFIG_SERIAL_PMACZILOG=y
 CONFIG_SERIAL_PMACZILOG_TTYS=y
+CONFIG_SERIAL_PMACZILOG_CONSOLE=y
 CONFIG_NVRAM=y
 CONFIG_I2C_CHARDEV=m
 CONFIG_APM_POWER=y
-- 
2.34.1

