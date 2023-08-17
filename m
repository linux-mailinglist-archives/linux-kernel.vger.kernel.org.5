Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E45BA77F982
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352169AbjHQOpJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:45:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352226AbjHQOpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:45:04 -0400
Received: from albert.telenet-ops.be (albert.telenet-ops.be [IPv6:2a02:1800:110:4::f00:1a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F97E94
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:45:01 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d85a:258d:2c59:b44])
        by albert.telenet-ops.be with bizsmtp
        id aeky2A00f4QHFyo06eky8G; Thu, 17 Aug 2023 16:44:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWeF1-000u8f-69;
        Thu, 17 Aug 2023 16:44:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWeF8-007SBP-Mu;
        Thu, 17 Aug 2023 16:44:58 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 2/6] m68k: math-emu: Sanitize include guards
Date:   Thu, 17 Aug 2023 16:44:49 +0200
Message-Id: <8c84c8bf06c0c1e463c47f071891e2e83d5abdd2.1692283195.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1692283195.git.geert@linux-m68k.org>
References: <cover.1692283195.git.geert@linux-m68k.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some include guards start with an underscore, others don't.
Some comments do not match the actual include guard.

Make them uniform, adhering to the "FP_<FOO>_H" format.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/math-emu/fp_arith.h    | 6 +++---
 arch/m68k/math-emu/fp_trig.h     | 6 +++---
 arch/m68k/math-emu/multi_arith.h | 6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/m68k/math-emu/fp_arith.h b/arch/m68k/math-emu/fp_arith.h
index 0fd3ed217f668652..85bdd83b9dd667a8 100644
--- a/arch/m68k/math-emu/fp_arith.h
+++ b/arch/m68k/math-emu/fp_arith.h
@@ -12,8 +12,8 @@
 
  */
 
-#ifndef FP_ARITH_H
-#define FP_ARITH_H
+#ifndef _FP_ARITH_H
+#define _FP_ARITH_H
 
 /* easy ones */
 struct fp_ext *
@@ -47,4 +47,4 @@ fp_fintrz(struct fp_ext *dest, struct fp_ext *src);
 struct fp_ext *
 fp_fscale(struct fp_ext *dest, struct fp_ext *src);
 
-#endif	/* FP_ARITH__H */
+#endif	/* _FP_ARITH_H */
diff --git a/arch/m68k/math-emu/fp_trig.h b/arch/m68k/math-emu/fp_trig.h
index af8b247e9c982874..52f0cc31cfe49cb7 100644
--- a/arch/m68k/math-emu/fp_trig.h
+++ b/arch/m68k/math-emu/fp_trig.h
@@ -15,8 +15,8 @@
 
 */
 
-#ifndef FP_TRIG_H
-#define FP_TRIG_H
+#ifndef _FP_TRIG_H
+#define _FP_TRIG_H
 
 #include "fp_emu.h"
 
@@ -29,4 +29,4 @@
    they return a status code, which should end up in %d0, if all goes
    well.  */
 
-#endif /* FP_TRIG__H */
+#endif /* _FP_TRIG_H */
diff --git a/arch/m68k/math-emu/multi_arith.h b/arch/m68k/math-emu/multi_arith.h
index 232f58fe3483d2be..ed2434fcfb1ef46e 100644
--- a/arch/m68k/math-emu/multi_arith.h
+++ b/arch/m68k/math-emu/multi_arith.h
@@ -15,8 +15,8 @@
    implement the subset of integer arithmetic that we need in order to
    multiply, divide, and normalize 128-bit unsigned mantissae.  */
 
-#ifndef MULTI_ARITH_H
-#define MULTI_ARITH_H
+#ifndef _MULTI_ARITH_H
+#define _MULTI_ARITH_H
 
 static inline void fp_denormalize(struct fp_ext *reg, unsigned int cnt)
 {
@@ -285,4 +285,4 @@ static inline void fp_putmant128(struct fp_ext *dest, union fp_mant128 *src,
 	}
 }
 
-#endif	/* MULTI_ARITH_H */
+#endif	/* _MULTI_ARITH_H */
-- 
2.34.1

