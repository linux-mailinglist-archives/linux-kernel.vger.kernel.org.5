Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC6A87FEB31
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Nov 2023 09:51:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344926AbjK3Ivf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Nov 2023 03:51:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231753AbjK3Iva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Nov 2023 03:51:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B99BB10DF;
        Thu, 30 Nov 2023 00:51:35 -0800 (PST)
Date:   Thu, 30 Nov 2023 08:51:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701334294;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ei2mNn8OwqK1Sc4aKtY1O7cZCrtlOZi7TfAXs+UClv8=;
        b=yYhg46JpQKn421IDN2b2djun1MZvgVpZeLfYXSRBkCdW0YziafKjODizigoRng1MaJA6M4
        iK0Ti5Bq3kTs/FAzwcGZ18IfeRyO8DzrpXC1rn06/+NnIagMd42GVhLjuIZigBkES9FRI0
        Cye2e0A24SM0N/6fzr8vzz58F4mVtqMBg06xpPaLgPuObGxrs7u/AcbrK2VrvrT6c+deGo
        hPXmW3wxRSGqF/p2BEzUjH8vbwH0szXsVswnfA9sKY7Oh3ihoPQoM9Iqx7VaI+v0zE7NPn
        ZPAvEQahQKu7y9NkMX65ozb061tE9OeD+2YD9wgktPhsNWCKKC9625P4Kks5CQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701334294;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ei2mNn8OwqK1Sc4aKtY1O7cZCrtlOZi7TfAXs+UClv8=;
        b=jCD5VsuRzWO7FoL/pcZqNbqea+1qgzT9MQOtaAyUEm7zhzIg+vcqLbx1iWBGB5TVCpQOHG
        oChEKIOxeEeAC4Ag==
From:   "tip-bot2 for Samuel Zeter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/build] x86/tools: objdump_reformat.awk: Allow for spaces
Cc:     Samuel Zeter <samuelzeter@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231129-objdump-reformat-llvm-v3-2-0d855e79314d@kernel.org>
References: <20231129-objdump-reformat-llvm-v3-2-0d855e79314d@kernel.org>
MIME-Version: 1.0
Message-ID: <170133429362.398.4707883263902716130.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/build branch of tip:

Commit-ID:     f4570ebd836363dc7722b8eb8d099b311021af13
Gitweb:        https://git.kernel.org/tip/f4570ebd836363dc7722b8eb8d099b311021af13
Author:        Samuel Zeter <samuelzeter@gmail.com>
AuthorDate:    Wed, 29 Nov 2023 15:17:42 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 30 Nov 2023 09:38:10 +01:00

x86/tools: objdump_reformat.awk: Allow for spaces

GNU objdump and LLVM objdump have differing output formats.
Specifically, GNU objump will format its output as: address:<tab>hex,
whereas LLVM objdump displays its output as address:<space>hex.

objdump_reformat.awk incorrectly handles this discrepancy due to
the unexpected space and as a result insn_decoder_test fails, as
its input is garbled.

The instruction line being tokenized now handles a space and colon,
or tab delimiter.

Signed-off-by: Samuel Zeter <samuelzeter@gmail.com>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Kees Cook <keescook@chromium.org>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20231129-objdump-reformat-llvm-v3-2-0d855e79314d@kernel.org
Closes: https://github.com/ClangBuiltLinux/linux/issues/1364
---
 arch/x86/tools/objdump_reformat.awk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/tools/objdump_reformat.awk b/arch/x86/tools/objdump_reformat.awk
index 276e572..a4120d9 100644
--- a/arch/x86/tools/objdump_reformat.awk
+++ b/arch/x86/tools/objdump_reformat.awk
@@ -22,7 +22,7 @@ BEGIN {
 }
 
 /^ *[0-9a-f]+:/ {
-	if (split($0, field, "\t") < 3) {
+	if (split($0, field, /: |\t/) < 3) {
 		# This is a continuation of the same insn.
 		prev_hex = prev_hex field[2]
 	} else {
