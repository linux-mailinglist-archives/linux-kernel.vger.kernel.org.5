Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C2980ABB4
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:13:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233794AbjLHSMw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:12:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229811AbjLHSMv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:12:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA02390;
        Fri,  8 Dec 2023 10:12:57 -0800 (PST)
Date:   Fri, 08 Dec 2023 18:12:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702059176;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VPq10NsC/rF3pTsW5VwJxHxpL7DlSSTW9H4lmsDaLFM=;
        b=Ow8pyzuL1flnJc492kWFDsRoQhzA2qs52/Kd1Pt2ViOe3IdnAC8QHHKmmZDFiUEfX/xzht
        Ly9RugGP05HXyVeAWBXdyCt9a8zzI3YYl69WlHc62MTp+MWIDN9KroFUpfuHyV3VAyGsbW
        y+w/omIeB0MVcEoSULMsyLEKzNInfLwApT0e5jbXm8bkG9gT4pF8GV4A43ewuLBJtWbXsf
        KZFfG/TAuw9SyX0tndhBm5Q7ILQBwSpo7sHnUs3EGB/K9bxMaZ8MjRz57Vxf3RgecqOAI8
        X5s2AzCXUTWTUQD6QueCS2QUx7T8KFhiDcbDT54FqGC4v8D9gcgzam/cPAmKMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702059176;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=VPq10NsC/rF3pTsW5VwJxHxpL7DlSSTW9H4lmsDaLFM=;
        b=SQ6OuEP8WsP0VeRP58uaT93aL/b8C51hnIWUvRMS8ZhwSLNorh2pYXKXIqaXouc9L4ujK6
        MqU5q9wyCqDVzoAg==
From:   "tip-bot2 for Jo Van Bulck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Remove incomplete ABI sanitization code
 in test enclave
Cc:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205917549.398.11664796877429502969.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/sgx branch of tip:

Commit-ID:     886c5be0b12e89b2905c26c4f24d50ae91f261da
Gitweb:        https://git.kernel.org/tip/886c5be0b12e89b2905c26c4f24d50ae91f261da
Author:        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
AuthorDate:    Thu, 05 Oct 2023 17:38:54 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:05:28 -08:00

selftests/sgx: Remove incomplete ABI sanitization code in test enclave

As the selftest enclave is *not* intended for production, simplify the
code by not initializing CPU configuration registers as expected by the
ABI on enclave entry or cleansing caller-save registers on enclave exit.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/all/da0cfb1e-e347-f7f2-ac72-aec0ee0d867d@intel.com/
Link: https://lore.kernel.org/all/20231005153854.25566-14-jo.vanbulck%40cs.kuleuven.be
---
 tools/testing/selftests/sgx/test_encl_bootstrap.S | 16 ++------------
 1 file changed, 3 insertions(+), 13 deletions(-)

diff --git a/tools/testing/selftests/sgx/test_encl_bootstrap.S b/tools/testing/selftests/sgx/test_encl_bootstrap.S
index 28fe5d2..d8c4ac9 100644
--- a/tools/testing/selftests/sgx/test_encl_bootstrap.S
+++ b/tools/testing/selftests/sgx/test_encl_bootstrap.S
@@ -59,21 +59,11 @@ encl_entry_core:
 
 	push	%rcx # push the address after EENTER
 
+	# NOTE: as the selftest enclave is *not* intended for production,
+	# simplify the code by not initializing ABI registers on entry or
+	# cleansing caller-save registers on exit.
 	call	encl_body
 
-	/* Clear volatile GPRs, except RAX (EEXIT function). */
-	xor     %rcx, %rcx
-	xor     %rdx, %rdx
-	xor     %rdi, %rdi
-	xor     %rsi, %rsi
-	xor     %r8, %r8
-	xor     %r9, %r9
-	xor     %r10, %r10
-	xor     %r11, %r11
-
-	# Reset status flags.
-	add     %rdx, %rdx # OF = SF = AF = CF = 0; ZF = PF = 1
-
 	# Prepare EEXIT target by popping the address of the instruction after
 	# EENTER to RBX.
 	pop	%rbx
