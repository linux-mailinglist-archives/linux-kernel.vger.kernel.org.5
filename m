Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AED77F981
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Aug 2023 16:45:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352213AbjHQOpQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Aug 2023 10:45:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352234AbjHQOpG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Aug 2023 10:45:06 -0400
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16553EE
        for <linux-kernel@vger.kernel.org>; Thu, 17 Aug 2023 07:45:01 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:d85a:258d:2c59:b44])
        by michel.telenet-ops.be with bizsmtp
        id aeky2A00L4QHFyo06ekyY8; Thu, 17 Aug 2023 16:44:59 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWeF1-000u8o-7u;
        Thu, 17 Aug 2023 16:44:58 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qWeF8-007SBc-Of;
        Thu, 17 Aug 2023 16:44:58 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 5/6] m68k: math-emu: Reformat function and variable headers
Date:   Thu, 17 Aug 2023 16:44:52 +0200
Message-Id: <11506b9225e281f2453a83a02ac4793d0e58b609.1692283195.git.geert@linux-m68k.org>
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

Make the code shorter and easier to read.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/math-emu/fp_arith.c | 49 +++++++++++--------------------
 arch/m68k/math-emu/fp_arith.h | 39 +++++++++----------------
 arch/m68k/math-emu/fp_log.c   | 36 ++++++++---------------
 arch/m68k/math-emu/fp_trig.c  | 54 ++++++++++++-----------------------
 4 files changed, 60 insertions(+), 118 deletions(-)

diff --git a/arch/m68k/math-emu/fp_arith.c b/arch/m68k/math-emu/fp_arith.c
index f4a06492cd7a118a..799c450fe3223955 100644
--- a/arch/m68k/math-emu/fp_arith.c
+++ b/arch/m68k/math-emu/fp_arith.c
@@ -28,8 +28,7 @@ const struct fp_ext fp_Inf =
 
 /* let's start with the easy ones */
 
-struct fp_ext *
-fp_fabs(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fabs(struct fp_ext *dest, struct fp_ext *src)
 {
 	dprint(PINSTR, "fabs\n");
 
@@ -40,8 +39,7 @@ fp_fabs(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_fneg(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fneg(struct fp_ext *dest, struct fp_ext *src)
 {
 	dprint(PINSTR, "fneg\n");
 
@@ -57,8 +55,7 @@ fp_fneg(struct fp_ext *dest, struct fp_ext *src)
 /* fp_fadd: Implements the kernel of the FADD, FSADD, FDADD, FSUB,
    FDSUB, and FCMP instructions. */
 
-struct fp_ext *
-fp_fadd(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fadd(struct fp_ext *dest, struct fp_ext *src)
 {
 	int diff;
 
@@ -117,8 +114,7 @@ fp_fadd(struct fp_ext *dest, struct fp_ext *src)
 
    Remember that the arguments are in assembler-syntax order! */
 
-struct fp_ext *
-fp_fsub(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fsub(struct fp_ext *dest, struct fp_ext *src)
 {
 	dprint(PINSTR, "fsub ");
 
@@ -127,8 +123,7 @@ fp_fsub(struct fp_ext *dest, struct fp_ext *src)
 }
 
 
-struct fp_ext *
-fp_fcmp(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fcmp(struct fp_ext *dest, struct fp_ext *src)
 {
 	dprint(PINSTR, "fcmp ");
 
@@ -137,8 +132,7 @@ fp_fcmp(struct fp_ext *dest, struct fp_ext *src)
 	return fp_fadd(&FPDATA->temp[1], src);
 }
 
-struct fp_ext *
-fp_ftst(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_ftst(struct fp_ext *dest, struct fp_ext *src)
 {
 	dprint(PINSTR, "ftst\n");
 
@@ -147,8 +141,7 @@ fp_ftst(struct fp_ext *dest, struct fp_ext *src)
 	return src;
 }
 
-struct fp_ext *
-fp_fmul(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fmul(struct fp_ext *dest, struct fp_ext *src)
 {
 	union fp_mant128 temp;
 	int exp;
@@ -225,8 +218,7 @@ fp_fmul(struct fp_ext *dest, struct fp_ext *src)
    Note that the order of the operands is counter-intuitive: instead
    of src / dest, the result is actually dest / src. */
 
-struct fp_ext *
-fp_fdiv(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fdiv(struct fp_ext *dest, struct fp_ext *src)
 {
 	union fp_mant128 temp;
 	int exp;
@@ -306,8 +298,7 @@ fp_fdiv(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_fsglmul(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fsglmul(struct fp_ext *dest, struct fp_ext *src)
 {
 	int exp;
 
@@ -363,8 +354,7 @@ fp_fsglmul(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_fsgldiv(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fsgldiv(struct fp_ext *dest, struct fp_ext *src)
 {
 	int exp;
 	unsigned long quot, rem;
@@ -573,8 +563,8 @@ static void fp_roundint(struct fp_ext *dest, int mode)
    (which are exactly the same, except for the rounding used on the
    intermediate value) */
 
-static struct fp_ext *
-modrem_kernel(struct fp_ext *dest, struct fp_ext *src, int mode)
+static struct fp_ext *modrem_kernel(struct fp_ext *dest, struct fp_ext *src,
+				    int mode)
 {
 	struct fp_ext tmp;
 
@@ -607,8 +597,7 @@ modrem_kernel(struct fp_ext *dest, struct fp_ext *src, int mode)
 
    fmod(src,dest) = (dest - (src * floor(dest / src))) */
 
-struct fp_ext *
-fp_fmod(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fmod(struct fp_ext *dest, struct fp_ext *src)
 {
 	dprint(PINSTR, "fmod\n");
 	return modrem_kernel(dest, src, FPCR_ROUND_RZ);
@@ -619,15 +608,13 @@ fp_fmod(struct fp_ext *dest, struct fp_ext *src)
    frem(src,dest) = (dest - (src * round(dest / src)))
  */
 
-struct fp_ext *
-fp_frem(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_frem(struct fp_ext *dest, struct fp_ext *src)
 {
 	dprint(PINSTR, "frem\n");
 	return modrem_kernel(dest, src, FPCR_ROUND_RN);
 }
 
-struct fp_ext *
-fp_fint(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fint(struct fp_ext *dest, struct fp_ext *src)
 {
 	dprint(PINSTR, "fint\n");
 
@@ -638,8 +625,7 @@ fp_fint(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_fintrz(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fintrz(struct fp_ext *dest, struct fp_ext *src)
 {
 	dprint(PINSTR, "fintrz\n");
 
@@ -650,8 +636,7 @@ fp_fintrz(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_fscale(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fscale(struct fp_ext *dest, struct fp_ext *src)
 {
 	int scale, oldround;
 
diff --git a/arch/m68k/math-emu/fp_arith.h b/arch/m68k/math-emu/fp_arith.h
index 85bdd83b9dd667a8..65b11e3f452db9d6 100644
--- a/arch/m68k/math-emu/fp_arith.h
+++ b/arch/m68k/math-emu/fp_arith.h
@@ -16,35 +16,22 @@
 #define _FP_ARITH_H
 
 /* easy ones */
-struct fp_ext *
-fp_fabs(struct fp_ext *dest, struct fp_ext *src);
-struct fp_ext *
-fp_fneg(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fabs(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fneg(struct fp_ext *dest, struct fp_ext *src);
 
 /* straightforward arithmetic */
-struct fp_ext *
-fp_fadd(struct fp_ext *dest, struct fp_ext *src);
-struct fp_ext *
-fp_fsub(struct fp_ext *dest, struct fp_ext *src);
-struct fp_ext *
-fp_fcmp(struct fp_ext *dest, struct fp_ext *src);
-struct fp_ext *
-fp_ftst(struct fp_ext *dest, struct fp_ext *src);
-struct fp_ext *
-fp_fmul(struct fp_ext *dest, struct fp_ext *src);
-struct fp_ext *
-fp_fdiv(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fadd(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fsub(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fcmp(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_ftst(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fmul(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fdiv(struct fp_ext *dest, struct fp_ext *src);
 
 /* ones that do rounding and integer conversions */
-struct fp_ext *
-fp_fmod(struct fp_ext *dest, struct fp_ext *src);
-struct fp_ext *
-fp_frem(struct fp_ext *dest, struct fp_ext *src);
-struct fp_ext *
-fp_fint(struct fp_ext *dest, struct fp_ext *src);
-struct fp_ext *
-fp_fintrz(struct fp_ext *dest, struct fp_ext *src);
-struct fp_ext *
-fp_fscale(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fmod(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_frem(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fint(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fintrz(struct fp_ext *dest, struct fp_ext *src);
+struct fp_ext *fp_fscale(struct fp_ext *dest, struct fp_ext *src);
 
 #endif	/* _FP_ARITH_H */
diff --git a/arch/m68k/math-emu/fp_log.c b/arch/m68k/math-emu/fp_log.c
index 2426634c4ba74377..9f93efd5ef496770 100644
--- a/arch/m68k/math-emu/fp_log.c
+++ b/arch/m68k/math-emu/fp_log.c
@@ -18,13 +18,11 @@
 #include "fp_arith.h"
 #include "fp_emu.h"
 
-static const struct fp_ext fp_one =
-{
+static const struct fp_ext fp_one = {
 	.exp = 0x3fff,
 };
 
-struct fp_ext *
-fp_fsqrt(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fsqrt(struct fp_ext *dest, struct fp_ext *src)
 {
 	struct fp_ext tmp, src2;
 	int i, exp;
@@ -97,8 +95,7 @@ fp_fsqrt(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_fetoxm1(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fetoxm1(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("fetoxm1\n");
 
@@ -107,8 +104,7 @@ fp_fetoxm1(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_fetox(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fetox(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("fetox\n");
 
@@ -117,8 +113,7 @@ fp_fetox(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_ftwotox(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_ftwotox(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("ftwotox\n");
 
@@ -127,8 +122,7 @@ fp_ftwotox(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_ftentox(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_ftentox(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("ftentox\n");
 
@@ -137,8 +131,7 @@ fp_ftentox(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_flogn(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_flogn(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("flogn\n");
 
@@ -147,8 +140,7 @@ fp_flogn(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_flognp1(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_flognp1(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("flognp1\n");
 
@@ -157,8 +149,7 @@ fp_flognp1(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_flog10(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_flog10(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("flog10\n");
 
@@ -167,8 +158,7 @@ fp_flog10(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_flog2(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_flog2(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("flog2\n");
 
@@ -177,8 +167,7 @@ fp_flog2(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_fgetexp(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fgetexp(struct fp_ext *dest, struct fp_ext *src)
 {
 	dprint(PINSTR, "fgetexp\n");
 
@@ -198,8 +187,7 @@ fp_fgetexp(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_fgetman(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fgetman(struct fp_ext *dest, struct fp_ext *src)
 {
 	dprint(PINSTR, "fgetman\n");
 
diff --git a/arch/m68k/math-emu/fp_trig.c b/arch/m68k/math-emu/fp_trig.c
index 6361d0784df2aa0e..5f49de3737536af3 100644
--- a/arch/m68k/math-emu/fp_trig.c
+++ b/arch/m68k/math-emu/fp_trig.c
@@ -18,8 +18,7 @@
 #include "fp_emu.h"
 #include "fp_trig.h"
 
-struct fp_ext *
-fp_fsin(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fsin(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("fsin\n");
 
@@ -28,8 +27,7 @@ fp_fsin(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_fcos(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fcos(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("fcos\n");
 
@@ -38,8 +36,7 @@ fp_fcos(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_ftan(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_ftan(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("ftan\n");
 
@@ -48,8 +45,7 @@ fp_ftan(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_fasin(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fasin(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("fasin\n");
 
@@ -58,8 +54,7 @@ fp_fasin(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_facos(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_facos(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("facos\n");
 
@@ -68,8 +63,7 @@ fp_facos(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_fatan(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fatan(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("fatan\n");
 
@@ -78,8 +72,7 @@ fp_fatan(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_fsinh(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fsinh(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("fsinh\n");
 
@@ -88,8 +81,7 @@ fp_fsinh(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_fcosh(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fcosh(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("fcosh\n");
 
@@ -98,8 +90,7 @@ fp_fcosh(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_ftanh(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_ftanh(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("ftanh\n");
 
@@ -108,8 +99,7 @@ fp_ftanh(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_fatanh(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fatanh(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("fatanh\n");
 
@@ -118,64 +108,56 @@ fp_fatanh(struct fp_ext *dest, struct fp_ext *src)
 	return dest;
 }
 
-struct fp_ext *
-fp_fsincos0(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fsincos0(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("fsincos0\n");
 
 	return dest;
 }
 
-struct fp_ext *
-fp_fsincos1(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fsincos1(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("fsincos1\n");
 
 	return dest;
 }
 
-struct fp_ext *
-fp_fsincos2(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fsincos2(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("fsincos2\n");
 
 	return dest;
 }
 
-struct fp_ext *
-fp_fsincos3(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fsincos3(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("fsincos3\n");
 
 	return dest;
 }
 
-struct fp_ext *
-fp_fsincos4(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fsincos4(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("fsincos4\n");
 
 	return dest;
 }
 
-struct fp_ext *
-fp_fsincos5(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fsincos5(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("fsincos5\n");
 
 	return dest;
 }
 
-struct fp_ext *
-fp_fsincos6(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fsincos6(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("fsincos6\n");
 
 	return dest;
 }
 
-struct fp_ext *
-fp_fsincos7(struct fp_ext *dest, struct fp_ext *src)
+struct fp_ext *fp_fsincos7(struct fp_ext *dest, struct fp_ext *src)
 {
 	uprint("fsincos7\n");
 
-- 
2.34.1

