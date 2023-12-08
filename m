Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4680380ABC9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Dec 2023 19:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235992AbjLHSNS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Dec 2023 13:13:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1574529AbjLHSM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Dec 2023 13:12:57 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4381F1729;
        Fri,  8 Dec 2023 10:13:04 -0800 (PST)
Date:   Fri, 08 Dec 2023 18:13:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1702059182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xgqlJDka6FcT4G5ZGjIEyqWOQ+mW8Tn9OrL4YvFsFZI=;
        b=ioFe7HA1s+roqklmfgQY/Q3v6uvsMnf/QWV2LEXd/+bonvmik8CRUDCIkp0O8x0kfiuHcL
        DSWZlNIyyFqIAYzawGKc/Q6uiPuMnJcs2WCi9hGooBRAZGSbDy/7E3Vk3kLCf99FbYyeHZ
        3wjj3Cq9kq+rOrL1X4hghCQMbf7o4r+t3F3neNgdZ1W9DN6TJ8/wm6h37F8PzpGFdsAD36
        OzYi7hVdDfEWUhuPZF7LhPD9M3ilWyKF82QLKQs8sQUKAiruxGurh8w2lUDNChfScm1Fom
        oVthNdLt1Kb1pc5T0/nP5kYFLQdvNJfECXlxBqCU9XZd36Lsz5aD8iqk3myglA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1702059182;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xgqlJDka6FcT4G5ZGjIEyqWOQ+mW8Tn9OrL4YvFsFZI=;
        b=L4+5Z+giAfgkjQQMsxw6Ky9pGA+Kimc0tvE4meP5uTa6l/ZjAHwz4OXNs6B0L8V2KmEncp
        QNwNRKmy1J7VVBAQ==
From:   "tip-bot2 for Jo Van Bulck" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/sgx] selftests/sgx: Separate linker options
Cc:     Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Jarkko Sakkinen <jarkko@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <170205918223.398.8235125463491202686.tip-bot2@tip-bot2>
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

Commit-ID:     f79464658d858e07af0c4c9b30f5baedeeae0c04
Gitweb:        https://git.kernel.org/tip/f79464658d858e07af0c4c9b30f5baedeeae0c04
Author:        Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
AuthorDate:    Thu, 05 Oct 2023 17:38:45 +02:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Fri, 08 Dec 2023 10:05:26 -08:00

selftests/sgx: Separate linker options

Fixes "'linker' input unused [-Wunused-command-line-argument]" errors when
compiling with clang.

Signed-off-by: Jo Van Bulck <jo.vanbulck@cs.kuleuven.be>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>
Link: https://lore.kernel.org/all/20231005153854.25566-5-jo.vanbulck%40cs.kuleuven.be
---
 tools/testing/selftests/sgx/Makefile | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/tools/testing/selftests/sgx/Makefile b/tools/testing/selftests/sgx/Makefile
index 50aab6b..dcdd04b 100644
--- a/tools/testing/selftests/sgx/Makefile
+++ b/tools/testing/selftests/sgx/Makefile
@@ -12,9 +12,11 @@ OBJCOPY := $(CROSS_COMPILE)objcopy
 endif
 
 INCLUDES := -I$(top_srcdir)/tools/include
-HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC -z noexecstack
-ENCL_CFLAGS := -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
+HOST_CFLAGS := -Wall -Werror -g $(INCLUDES) -fPIC
+HOST_LDFLAGS := -z noexecstack -lcrypto
+ENCL_CFLAGS += -Wall -Werror -static -nostdlib -nostartfiles -fPIC \
 	       -fno-stack-protector -mrdrnd $(INCLUDES)
+ENCL_LDFLAGS := -Wl,-T,test_encl.lds,--build-id=none
 
 TEST_CUSTOM_PROGS := $(OUTPUT)/test_sgx
 TEST_FILES := $(OUTPUT)/test_encl.elf
@@ -28,7 +30,7 @@ $(OUTPUT)/test_sgx: $(OUTPUT)/main.o \
 		    $(OUTPUT)/sigstruct.o \
 		    $(OUTPUT)/call.o \
 		    $(OUTPUT)/sign_key.o
-	$(CC) $(HOST_CFLAGS) -o $@ $^ -lcrypto
+	$(CC) $(HOST_CFLAGS) -o $@ $^ $(HOST_LDFLAGS)
 
 $(OUTPUT)/main.o: main.c
 	$(CC) $(HOST_CFLAGS) -c $< -o $@
@@ -45,8 +47,8 @@ $(OUTPUT)/call.o: call.S
 $(OUTPUT)/sign_key.o: sign_key.S
 	$(CC) $(HOST_CFLAGS) -c $< -o $@
 
-$(OUTPUT)/test_encl.elf: test_encl.lds test_encl.c test_encl_bootstrap.S
-	$(CC) $(ENCL_CFLAGS) -T $^ -o $@ -Wl,--build-id=none
+$(OUTPUT)/test_encl.elf: test_encl.c test_encl_bootstrap.S
+	$(CC) $(ENCL_CFLAGS) $^ -o $@ $(ENCL_LDFLAGS)
 
 EXTRA_CLEAN := \
 	$(OUTPUT)/test_encl.elf \
