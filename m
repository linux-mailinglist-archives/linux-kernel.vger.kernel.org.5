Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04E9477A21F
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Aug 2023 22:00:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230146AbjHLUAJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Aug 2023 16:00:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230119AbjHLUAG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Aug 2023 16:00:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6F0B270C
        for <linux-kernel@vger.kernel.org>; Sat, 12 Aug 2023 12:59:45 -0700 (PDT)
Message-ID: <20230812195727.600549655@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691870318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vZfu3hn1QJAjVwqJekBOL9H9dLKGyIEaYNIR6HaO1RM=;
        b=24XntUOddusKNsOZmHUCaWBvLuTGkAp5p3D3uvdIQaUzM3D99QfyTmTMup1AIXBjqUGMFf
        UawDG36uAudfPOE/D0g6uA0xkEgpJn7FVPHniRkM+gN9i3g3wRMNJw3qAPxDiQet114hEH
        ZgTzbul3QutO72+HY3X1IiztBw6TqsjKTsnebdFbuydsaL4a3padt4oYgEy0cq5OMqq1k0
        /oo2crioPgIawXv9QRkth55aDoUeO8RvCTufWUAAD7NDPRa7o1hKQE94RMxOsBHi7yVZcq
        tbORMsdRzyb96qWWyYYxDnw6BisKb1gwXImw0n7GD83Dap3SdAZDK0abkcwr6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691870318;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=vZfu3hn1QJAjVwqJekBOL9H9dLKGyIEaYNIR6HaO1RM=;
        b=ixS7kBELq974kNgFX6sjcFSbnaOqnTVjhEZEZFwRpb5/+I5o44bmY+8h35RcAz7y9cm4K8
        GRYlsY1G7+WTx2Dg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>,
        Nikolay Borisov <nik.borisov@suse.com>
Subject: [patch V2 01/37] x86/mm: Remove unused microcode.h include
References: <20230812194003.682298127@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Sat, 12 Aug 2023 21:58:38 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

No usage for anything in that header.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/mm/init.c |    1 -
 1 file changed, 1 deletion(-)
---
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -20,7 +20,6 @@
 #include <asm/tlb.h>
 #include <asm/proto.h>
 #include <asm/dma.h>		/* for MAX_DMA_PFN */
-#include <asm/microcode.h>
 #include <asm/kaslr.h>
 #include <asm/hypervisor.h>
 #include <asm/cpufeature.h>

