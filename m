Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF0679FD3B
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Sep 2023 09:29:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233735AbjINH3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Sep 2023 03:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbjINH3t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Sep 2023 03:29:49 -0400
X-Greylist: delayed 64 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 14 Sep 2023 00:29:43 PDT
Received: from unicom146.biz-email.net (unicom146.biz-email.net [210.51.26.146])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4E28CE5;
        Thu, 14 Sep 2023 00:29:43 -0700 (PDT)
Received: from unicom146.biz-email.net
        by unicom146.biz-email.net ((D)) with ASMTP (SSL) id JGQ00132;
        Thu, 14 Sep 2023 15:28:32 +0800
Received: from localhost.localdomain (10.94.11.175) by
 jtjnmail201621.home.langchao.com (10.100.2.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.32; Thu, 14 Sep 2023 15:28:32 +0800
From:   Bo Liu <liubo03@inspur.com>
To:     <herbert@gondor.apana.org.au>, <davem@davemloft.net>,
        <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>
CC:     <linux-crypto@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Bo Liu <liubo03@inspur.com>
Subject: [PATCH] crypto: x86 - Fix double word in comments
Date:   Thu, 14 Sep 2023 03:27:50 -0400
Message-ID: <20230914072750.2426-1-liubo03@inspur.com>
X-Mailer: git-send-email 2.18.2
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.94.11.175]
X-ClientProxiedBy: Jtjnmail201618.home.langchao.com (10.100.2.18) To
 jtjnmail201621.home.langchao.com (10.100.2.21)
tUid:   2023914152832db66f52ddc26738ae8a1ee476315cdcc
X-Abuse-Reports-To: service@corp-email.com
Abuse-Reports-To: service@corp-email.com
X-Complaints-To: service@corp-email.com
X-Report-Abuse-To: service@corp-email.com
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the repeated word "if" in comments.

Signed-off-by: Bo Liu <liubo03@inspur.com>
---
 arch/x86/crypto/aesni-intel_asm.S        | 4 ++--
 arch/x86/crypto/aesni-intel_avx-x86_64.S | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/x86/crypto/aesni-intel_asm.S b/arch/x86/crypto/aesni-intel_asm.S
index 3ac7487ecad2..187f913cc239 100644
--- a/arch/x86/crypto/aesni-intel_asm.S
+++ b/arch/x86/crypto/aesni-intel_asm.S
@@ -672,7 +672,7 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	add	%r13, %r10
 	# Set r10 to be the amount of data left in CYPH_PLAIN_IN after filling
 	sub	$16, %r10
-	# Determine if if partial block is not being filled and
+	# Determine if partial block is not being filled and
 	# shift mask accordingly
 	jge	.L_no_extra_mask_1_\@
 	sub	%r10, %r12
@@ -708,7 +708,7 @@ ALL_F:      .octa 0xffffffffffffffffffffffffffffffff
 	add	%r13, %r10
 	# Set r10 to be the amount of data left in CYPH_PLAIN_IN after filling
 	sub	$16, %r10
-	# Determine if if partial block is not being filled and
+	# Determine if partial block is not being filled and
 	# shift mask accordingly
 	jge	.L_no_extra_mask_2_\@
 	sub	%r10, %r12
diff --git a/arch/x86/crypto/aesni-intel_avx-x86_64.S b/arch/x86/crypto/aesni-intel_avx-x86_64.S
index 46cddd78857b..74dd230973cf 100644
--- a/arch/x86/crypto/aesni-intel_avx-x86_64.S
+++ b/arch/x86/crypto/aesni-intel_avx-x86_64.S
@@ -753,7 +753,7 @@ VARIABLE_OFFSET = 16*8
         add	%r13, %r10
         # Set r10 to be the amount of data left in CYPH_PLAIN_IN after filling
         sub	$16, %r10
-        # Determine if if partial block is not being filled and
+        # Determine if partial block is not being filled and
         # shift mask accordingly
         jge	.L_no_extra_mask_1_\@
         sub	%r10, %r12
@@ -789,7 +789,7 @@ VARIABLE_OFFSET = 16*8
         add	%r13, %r10
         # Set r10 to be the amount of data left in CYPH_PLAIN_IN after filling
         sub	$16, %r10
-        # Determine if if partial block is not being filled and
+        # Determine if partial block is not being filled and
         # shift mask accordingly
         jge	.L_no_extra_mask_2_\@
         sub	%r10, %r12
-- 
2.27.0

