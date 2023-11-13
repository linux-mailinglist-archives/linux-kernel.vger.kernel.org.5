Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E537E9B71
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Nov 2023 12:52:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230148AbjKMLwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Nov 2023 06:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbjKMLwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Nov 2023 06:52:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1AEFD6C;
        Mon, 13 Nov 2023 03:52:46 -0800 (PST)
Date:   Mon, 13 Nov 2023 11:52:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1699876364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4msdHeUrgp8KzqkFUcrYp4Qn6D29uyYMmeGXoVJhZ8E=;
        b=QsQNgugc6AbepcIt/bYWV77VtqROUFuwsFhE064sCM6Ctjrh48zFsvPI5fZ4HtaLgjTfn5
        dCvOwTH91LU1AdNyY7jMCC4LKeHbKacx8ioYN1cYy4Umg2abBBDzdLDX6lpzQnSiylSQWx
        gTbe/6HtuYIKCCLyPEfUjlLK/erv8Es5SC39cHzC7CaKeJLcH+8s6x39xNEHVid+8tnQUl
        85KkdMoWey/LGh9NC1ir4nQT5QWFDEOi4ehiXST2T35uOUIu6EPIzkHhxXghPTB8x348KI
        Ocq5ozfLZmqQknDB0A39fx+pzlbgKRmvXoIgreoB2WKOObzZga/wg1ztlsuzlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1699876364;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4msdHeUrgp8KzqkFUcrYp4Qn6D29uyYMmeGXoVJhZ8E=;
        b=5Mx3JLOod7/OuHUsnlZ45Mjwcg+q1SRkV8dL8KMXKZkSpYE5WUTk8xJfGKj2HMlDu3z9wr
        tS+N8ZGWfKXEUmDw==
From:   "tip-bot2 for Hou Wenlong" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/paravirt] x86/paravirt: Make the struct paravirt_patch_site packed
Cc:     Nadav Amit <namit@vmware.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C6dcb20159ded36586c5f7f2ae159e4e030256627=2E16863?=
 =?utf-8?q?01237=2Egit=2Ehouwenlong=2Ehwl=40antgroup=2Ecom=3E?=
References: =?utf-8?q?=3C6dcb20159ded36586c5f7f2ae159e4e030256627=2E168630?=
 =?utf-8?q?1237=2Egit=2Ehouwenlong=2Ehwl=40antgroup=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <169987636342.3135.13474563880935419815.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/paravirt branch of tip:

Commit-ID:     fe22bc430c9d24394e541e16e0941a075f02fcb7
Gitweb:        https://git.kernel.org/tip/fe22bc430c9d24394e541e16e0941a075f02fcb7
Author:        Hou Wenlong <houwenlong.hwl@antgroup.com>
AuthorDate:    Fri, 09 Jun 2023 17:45:32 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Mon, 13 Nov 2023 12:43:50 +01:00

x86/paravirt: Make the struct paravirt_patch_site packed

Similar to struct alt_instr, make the struct paravirt_patch_site packed
and get rid of all the .align directives and save 2 bytes for one
PARA_SITE entry on X86_64.

  [ bp: Massage commit message. ]

Suggested-by: Nadav Amit <namit@vmware.com>
Signed-off-by: Hou Wenlong <houwenlong.hwl@antgroup.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/6dcb20159ded36586c5f7f2ae159e4e030256627.1686301237.git.houwenlong.hwl@antgroup.com
---
 arch/x86/include/asm/paravirt.h       | 2 --
 arch/x86/include/asm/paravirt_types.h | 4 +---
 2 files changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index d9384e9..693c61d 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -748,11 +748,9 @@ void native_pv_lock_init(void) __init;
 	ops;					\
 772:;						\
 	.pushsection .parainstructions,"a";	\
-	 .align	4;				\
 	 .long 771b-.;				\
 	 .byte ptype;				\
 	 .byte 772b-771b;			\
-	 .align 4;				\
 	.popsection
 
 
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index e1bfb71..f4fb2e3 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -8,7 +8,7 @@ struct paravirt_patch_site {
 	s32 instr_offset;	/* original instructions */
 	u8 type;		/* type of this instruction */
 	u8 len;			/* length of original instruction */
-};
+} __packed;
 #endif
 
 #ifdef CONFIG_PARAVIRT
@@ -263,11 +263,9 @@ extern struct paravirt_patch_template pv_ops;
 #define _paravirt_alt(insn_string, type)		\
 	"771:\n\t" insn_string "\n" "772:\n"		\
 	".pushsection .parainstructions,\"a\"\n"	\
-	"  .align 4\n"					\
 	"  .long 771b-.\n"				\
 	"  .byte " type "\n"				\
 	"  .byte 772b-771b\n"				\
-	"  .align 4\n"					\
 	".popsection\n"
 
 /* Generate patchable code, with the default asm parameters. */
