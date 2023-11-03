Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A85297E05F9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:00:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344586AbjKCQAT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:00:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343945AbjKCQAQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:00:16 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.155.65.254])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B9A2CA;
        Fri,  3 Nov 2023 09:00:12 -0700 (PDT)
X-QQ-mid: bizesmtp89t1699027199tr6cexfv
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Fri, 03 Nov 2023 23:59:56 +0800 (CST)
X-QQ-SSF: 01200000000000B06000000A0000000
X-QQ-FEAT: J5JfekO1WsiW/sSK9b0/2SRgOwgztbvJaqippsUrhkBT0nfPERe3CiBmcwtjz
        QpzvzTaAyarFENK22g18sd4WrJtroYvGBndfc+80wj7YD8GXTPFE63PYdZfssoaggn37JF1
        CeT4asgR6uqXE743WuMFyc0x2/w6p5rmPS5RdVkWpq1wdgAirUOvzdxBnfp/BH/yVAOG+VK
        nuqwGFmYsfi5b7WwIDnPQEhZN6hZb6/eGcz4PwK7TFD10lDLnMuVyHe9WS6+GDJ8RvQ2t0+
        CRr+zifxj6GjZOuv7Gm2iGWovRvgRTB53/KK2DBFh1siV3bXj3z8JS2Obvsu+/t7oibKU9q
        0uW9Al7Boxi073MJVkzuvWKDvgsnA==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 6517666058283072593
From:   Yuan Tan <tanyuan@tinylab.org>
To:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Cc:     linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu, tanyuan@tinylab.org, i@maskray.me
Subject: [PATCH v1 05/14] DCE/DSE: add HAVE_SECTION_SHF_LINK_ORDER_SUPPORT option
Date:   Fri,  3 Nov 2023 23:59:54 +0800
Message-Id: <141030de2b3d470251d1588b39cb041ec505d84f.1699025537.git.tanyuan@tinylab.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1699025537.git.tanyuan@tinylab.org>
References: <cover.1699025537.git.tanyuan@tinylab.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:tinylab.org:qybglogicsvrgz:qybglogicsvrgz5a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SHF_LINK_ORDER requires ld >= 2.35.

LLD supports SHF_LINK_ORDER to, but it does not support riscv
HAVE_LD_DEAD_CODE_DATA_ELIMINATION. Therefore, I haven't tested the
minimum compatible version yet.

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 init/Kconfig | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/init/Kconfig b/init/Kconfig
index aa648ce8bca1..1ef5b19918e5 100644
--- a/init/Kconfig
+++ b/init/Kconfig
@@ -1462,6 +1462,11 @@ config HAVE_TRIM_UNUSED_SYSCALLS
 	depends on HAVE_LD_DEAD_CODE_DATA_ELIMINATION
 	default n
 
+config HAVE_SECTION_SHF_LINK_ORDER_SUPPORT
+	bool
+	depends on AS_IS_GNU && AS_VERSION >= 23500
+	default y
+
 menuconfig EXPERT
 	bool "Configure standard kernel features (expert users)"
 	# Unhide debug options, to make the on-by-default options visible
-- 
2.34.1

