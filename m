Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B28B7BBA85
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Oct 2023 16:41:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232576AbjJFOl3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Oct 2023 10:41:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232546AbjJFOlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Oct 2023 10:41:24 -0400
Received: from laurent.telenet-ops.be (laurent.telenet-ops.be [IPv6:2a02:1800:110:4::f00:19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B0B6CE
        for <linux-kernel@vger.kernel.org>; Fri,  6 Oct 2023 07:41:21 -0700 (PDT)
Received: from ramsan.of.borg ([IPv6:2a02:1810:ac12:ed40:5e53:403c:300c:38ca])
        by laurent.telenet-ops.be with bizsmtp
        id uehJ2A0030nPCdM01ehJJq; Fri, 06 Oct 2023 16:41:18 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtp (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qom10-005X4k-4h;
        Fri, 06 Oct 2023 16:41:18 +0200
Received: from geert by rox.of.borg with local (Exim 4.95)
        (envelope-from <geert@linux-m68k.org>)
        id 1qom10-006v2c-2b;
        Fri, 06 Oct 2023 16:41:18 +0200
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     linux-m68k@lists.linux-m68k.org
Cc:     linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH 5/5] m68k: fpsp040: Fix indentation by 5 spaces
Date:   Fri,  6 Oct 2023 16:41:14 +0200
Message-Id: <5ab108be356a5d2a6e6d72bc418ccf1c1938e8fe.1696602993.git.geert@linux-m68k.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1696602993.git.geert@linux-m68k.org>
References: <cover.1696602993.git.geert@linux-m68k.org>
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

Indentation should use TABs, not spaces.

Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
 arch/m68k/fpsp040/slogn.S | 88 +++++++++++++++++++--------------------
 1 file changed, 44 insertions(+), 44 deletions(-)

diff --git a/arch/m68k/fpsp040/slogn.S b/arch/m68k/fpsp040/slogn.S
index d98eaf641ec4c65b..5f3da4aa7e4515c7 100644
--- a/arch/m68k/fpsp040/slogn.S
+++ b/arch/m68k/fpsp040/slogn.S
@@ -261,56 +261,56 @@ slognd:
 |----the value TWOTO100 is no longer needed.
 |----Note that this code assumes the denormalized input is NON-ZERO.
 
-     moveml	%d2-%d7,-(%a7)		| ...save some registers
-     movel	#0x00000000,%d3		| ...D3 is exponent of smallest norm. #
-     movel	4(%a0),%d4
-     movel	8(%a0),%d5		| ...(D4,D5) is (Hi_X,Lo_X)
-     clrl	%d2			| ...D2 used for holding K
+	moveml	%d2-%d7,-(%a7)		| ...save some registers
+	movel	#0x00000000,%d3		| ...D3 is exponent of smallest norm. #
+	movel	4(%a0),%d4
+	movel	8(%a0),%d5		| ...(D4,D5) is (Hi_X,Lo_X)
+	clrl	%d2			| ...D2 used for holding K
 
-     tstl	%d4
-     bnes	HiX_not0
+	tstl	%d4
+	bnes	HiX_not0
 
 HiX_0:
-     movel	%d5,%d4
-     clrl	%d5
-     movel	#32,%d2
-     clrl	%d6
-     bfffo      %d4{#0:#32},%d6
-     lsll      %d6,%d4
-     addl	%d6,%d2			| ...(D3,D4,D5) is normalized
-
-     movel	%d3,X(%a6)
-     movel	%d4,XFRAC(%a6)
-     movel	%d5,XFRAC+4(%a6)
-     negl	%d2
-     movel	%d2,ADJK(%a6)
-     fmovex	X(%a6),%fp0
-     moveml	(%a7)+,%d2-%d7		| ...restore registers
-     lea	X(%a6),%a0
-     bras	LOGBGN			| ...begin regular log(X)
+	movel	%d5,%d4
+	clrl	%d5
+	movel	#32,%d2
+	clrl	%d6
+	bfffo      %d4{#0:#32},%d6
+	lsll      %d6,%d4
+	addl	%d6,%d2			| ...(D3,D4,D5) is normalized
+
+	movel	%d3,X(%a6)
+	movel	%d4,XFRAC(%a6)
+	movel	%d5,XFRAC+4(%a6)
+	negl	%d2
+	movel	%d2,ADJK(%a6)
+	fmovex	X(%a6),%fp0
+	moveml	(%a7)+,%d2-%d7		| ...restore registers
+	lea	X(%a6),%a0
+	bras	LOGBGN			| ...begin regular log(X)
 
 
 HiX_not0:
-     clrl	%d6
-     bfffo	%d4{#0:#32},%d6		| ...find first 1
-     movel	%d6,%d2			| ...get k
-     lsll	%d6,%d4
-     movel	%d5,%d7			| ...a copy of D5
-     lsll	%d6,%d5
-     negl	%d6
-     addil	#32,%d6
-     lsrl	%d6,%d7
-     orl	%d7,%d4			| ...(D3,D4,D5) normalized
-
-     movel	%d3,X(%a6)
-     movel	%d4,XFRAC(%a6)
-     movel	%d5,XFRAC+4(%a6)
-     negl	%d2
-     movel	%d2,ADJK(%a6)
-     fmovex	X(%a6),%fp0
-     moveml	(%a7)+,%d2-%d7		| ...restore registers
-     lea	X(%a6),%a0
-     bras	LOGBGN			| ...begin regular log(X)
+	clrl	%d6
+	bfffo	%d4{#0:#32},%d6		| ...find first 1
+	movel	%d6,%d2			| ...get k
+	lsll	%d6,%d4
+	movel	%d5,%d7			| ...a copy of D5
+	lsll	%d6,%d5
+	negl	%d6
+	addil	#32,%d6
+	lsrl	%d6,%d7
+	orl	%d7,%d4			| ...(D3,D4,D5) normalized
+
+	movel	%d3,X(%a6)
+	movel	%d4,XFRAC(%a6)
+	movel	%d5,XFRAC+4(%a6)
+	negl	%d2
+	movel	%d2,ADJK(%a6)
+	fmovex	X(%a6),%fp0
+	moveml	(%a7)+,%d2-%d7		| ...restore registers
+	lea	X(%a6),%a0
+	bras	LOGBGN			| ...begin regular log(X)
 
 
 	.global	slogn
-- 
2.34.1

