Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D33387E062E
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Nov 2023 17:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234328AbjKCQFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Nov 2023 12:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234387AbjKCQF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Nov 2023 12:05:29 -0400
Received: from bg4.exmail.qq.com (bg4.exmail.qq.com [43.154.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31C3110C6;
        Fri,  3 Nov 2023 09:05:07 -0700 (PDT)
X-QQ-mid: bizesmtp88t1699027493t4lqanvg
Received: from main2-ubuntu.tail147f4.ts.net ( [202.201.15.117])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Sat, 04 Nov 2023 00:04:50 +0800 (CST)
X-QQ-SSF: 01200000000000B06000000A0000000
X-QQ-FEAT: jXjag1m6xl5ppx2DzruJtGaZWnmD4kcr8XGhe8RzDeQnj/4txlNMA0RrzbdM3
        NkLCpOnAtszVCaalBQWVPDXpaXS99zJq6AlrppFnw1HKvKL0xj0E5A9V7XJ4MlTzYMuw81z
        fr0TQpqQaEJWCRXcAtRVJi0F1ePqT0AT21/h93uarocjC8Z8j1tjIaNhhk3tVoz+rnGhrAd
        TRL0MreVOn2ipogbXqRHd+i6op09393O4FSiuY8ril1xpaW3/uszhT2UDapIXWOaUz+PptB
        f2CN/td6z1BqlmsTzYJ3ewPyBma8ADUsb5d7vDUH3TMXEtfm+e3ucDioNeOaMAYycbIr9aJ
        /sF2ho7MXuFQ17Wh2UAABl458F674OLb8zGA6HrpmOBwvwfV8QFEVjuC0lUdg==
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 11412250178732425861
From:   Yuan Tan <tanyuan@tinylab.org>
To:     falcon@tinylab.org, arnd@arndb.de, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, linux-riscv@lists.infradead.org,
        luc.vanoostenryck@gmail.com, linux-sparse@vger.kernel.org
Cc:     linux@weissschuh.net, palmer@rivosinc.com,
        paul.walmsley@sifive.com, paulburton@kernel.org,
        paulmck@kernel.org, tim.bird@sony.com, tsbogend@alpha.franken.de,
        w@1wt.eu, tanyuan@tinylab.org, i@maskray.me
Subject: [PATCH v1 14/14] DCE/DSE: vmlinux.lds.h: allow NO_KEEP on __ex_table sections
Date:   Sat,  4 Nov 2023 00:04:48 +0800
Message-Id: <3acff566dc1818a36b32a34e25b0de58c5118ee6.1699025537.git.tanyuan@tinylab.org>
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

With SHF_LINK_ORDER or SHF_GROUP, all of the __extable sections are no
longer orphan sections. In this case, KEEP() is no longer needed.

Signed-off-by: Yuan Tan <tanyuan@tinylab.org>
Signed-off-by: Zhangjin Wu <falcon@tinylab.org>
---
 include/asm-generic/vmlinux.lds.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index f10afc42a1ac..e5e5850ea573 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -658,7 +658,7 @@
 #define EXCEPTION_TABLE(align)						\
 	. = ALIGN(align);						\
 	__ex_table : AT(ADDR(__ex_table) - LOAD_OFFSET) {		\
-		BOUNDED_SECTION_BY(__ex_table, ___ex_table)		\
+		BOUNDED_SECTION_BY(__ex_table, ___ex_table, NO_KEEP)		\
 	}
 
 /*
-- 
2.34.1

