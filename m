Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F1E076C96F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Aug 2023 11:25:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234099AbjHBJZZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Aug 2023 05:25:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbjHBJZW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Aug 2023 05:25:22 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5CE1FD6;
        Wed,  2 Aug 2023 02:25:20 -0700 (PDT)
X-QQ-mid: bizesmtp67t1690968314tl3p7s9u
Received: from dslab-main2-ubuntu.tail147f4.ts ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Wed, 02 Aug 2023 17:25:12 +0800 (CST)
X-QQ-SSF: 01200000000000804000000A0000000
X-QQ-FEAT: wPivafIDGPPXhAHho0Muas8HnUk4sF+JAE3AFbaIFlPHknNCErQUhmtpTYqoI
        rJsCHh1eYkcArPZdt2TDBwUvaTPxKOWHQ6picGSP9qEDt5qaE4a25sl1EAy3zVtxi77vmgo
        RO+kPm8dMIjo2WzDGcjvWazQ/csrW9n1njcjw5QYwQSsn1gm8xhE1XB2olFbYZSaSc7XtKi
        XGMX2rvevvX0ZmhrJlnTVawHeS64NrIu3fiEGkB9+ykAR0JAHYGg3/C2yqzszPiA/e9L4r+
        BCZd30Xb7NLiaonhYVjBSBCD1rmTMx11YaUadOHBn4+sDyKCrIo/v61nMQP3HkLrzoyUrrQ
        86KRHmLHj+a+CzguM2+VrzadRtO69f7+f3/+e6iwVXPDfZj9Lw=
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 859180589417831823
From:   Yuan Tan <tanyuan@tinylab.org>
To:     tsbogend@alpha.franken.de
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux@weissschuh.net, w@1wt.eu, falcon@tinylab.org,
        tanyuan@tinylab.org
Subject: [RFC 1/1] mips: malta: select PCI_QUIRK for POWER_RESET_PIIX4_POWEROFF
Date:   Wed,  2 Aug 2023 17:25:11 +0800
Message-Id: <686dbb3128ad4e413b22685cd466a68e1adf670b.1690968173.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1690968173.git.tanyuan@tinylab.org>
References: <cover.1690968173.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Select PCI_QUIRKS for malta if POWER_RESET_PIIX4_POWEROFF enabled.

Syscall reboot relies on PCI_QUIRKS, or else the reboot will hang.

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
---
 arch/mips/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index fc6fba925aea..a2827488efef 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -547,6 +547,7 @@ config MIPS_MALTA
 	select MIPS_L1_CACHE_SHIFT_6
 	select MIPS_MSC
 	select PCI_GT64XXX_PCI0
+	select PCI_QUIRKS if POWER_RESET_PIIX4_POWEROFF
 	select SMP_UP if SMP
 	select SWAP_IO_SPACE
 	select SYS_HAS_CPU_MIPS32_R1
-- 
2.34.1

