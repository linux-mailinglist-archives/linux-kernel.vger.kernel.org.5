Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 403FB7E05FE
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:00:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344856AbjKCQAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343945AbjKCQAh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:00:37 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 561331BF;
        Fri,  3 Nov 2023 09:00:33 -0700 (PDT)
X-QQ-mid: bizesmtp87t1699027218tobnpga2
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 04 Nov 2023 00:00:15 +0800 (CST)
X-QQ-SSF: 01200000000000B06000000A0000000
X-QQ-FEAT: +ynUkgUhZJkQaK3UoZkl8UFfBrmOfnK/yegytHp4rc1pb7b3un2ZnJljIAZmQ
        SyXnHa++l4m7fRjBIwpFo2yvoE/z+Ce3xG96JEz4TUS94+884spbt6QK0ijO0pys/0ZRtXT
        yTJ4KdwcAqHHm5OmVSBQkAf2mXr2BFgZ8g576cDxArslhY/NINryQd/xWCqsDWIMikhIK5H
        F80QRPBTraDKtfwcPifb2vihwGdJnwe9t6tWh5K+jA32jgVR2NAE3gNY43CdkZKiUzIK/a2
        2z0Yjtc8JZajCom/XHmuU5CGRQIrP77qUPwshGoOPHCfrSCD//QjBQ3x/AqijADYI8wvpru
        bFuICpJ75TWkL/kTNaxMRL/UNMNcWL/Kyk4wkY2UyFKdKCjwzNjoUiJ1OI76g==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8486065313594138101
From:   Yuan Tan <tanyuan@tinylab.org>
To:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Cc:     linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu, tanyuan@tinylab.org, i@maskray.me
Subject: [PATCH v1 06/14] DCE/DSE: add HAVE_SECTION_SHF_GROUP_SUPPORT option
Date:   Sat,  4 Nov 2023 00:00:14 +0800
Message-Id: <04271c1f3a4c3d369310146faefc0d05144276e9.1699025537.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1699025537.git.tanyuan@tinylab.org>
References: <cover.1699025537.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SHF_GROUP requires ld >= 2.36.

LLD supports SHF_GROUP too, but it does not support riscv
HAVE_LD_DEAD_CODE_DATA_ELIMINATION. Therefore, I haven't tested the
minimum compatible version yet.

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 init/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index 1ef5b19918e5..4296c97cfc84 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1467,6 +1467,11 @@ config HAVE_SECTION_SHF_LINK_ORDER_SUPPORT
 	depends on AS_IS_GNU && AS_VERSION >= 23500
 	default y
 
+config HAVE_SECTION_SHF_GROUP_SUPPORT
+	bool
+	depends on AS_IS_GNU && AS_VERSION >= 23600
+	default y
+
 menuconfig EXPERT
 	bool "Configure standard kernel features (expert users)"
 	# Unhide debug options, to make the on-by-default options visible
-- 
2.34.1

