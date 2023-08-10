Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C126778058
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Aug 2023 20:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235541AbjHJShc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Aug 2023 14:37:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233968AbjHJSh3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Aug 2023 14:37:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73FB32703
        for <linux-kernel@vger.kernel.org>; Thu, 10 Aug 2023 11:37:29 -0700 (PDT)
Message-ID: <20230810160805.022445373@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691692648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IWkGYjmWOibzTkZgxBzGmmL+arWmBzlvaePuSDECYyQ=;
        b=bKUDs9j/IMUZTy930y8DUkMw4ANHrKbWwGO/5r0zf4kRzdZ19BwxClMn1v0a8ypTDdxWM4
        YpT7HBSOCp06o+5kmo0meuMCDxT+10vVJ2pWxP/UeielbgPhYhDdPJLU+CMbwU3Fs+bghG
        HIy2WDVlrvQUD6CNp/clBxQ2BinrrbUh37cIYUzNoayTFTsGNl2rjIRfNzxm1RUIKQPkPL
        dPUGSlHVWttZSFxvQm/INDiRHazhaOiBznfwJ5E84r3ThxO16A38cv5Y+UgQnBofMfd5x3
        H7P6A20GUPSRtvY9rhcaIJihXP422wH2p2VUDXLMcO7FNstfO+grtMiHS+72MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691692648;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         references:references; bh=IWkGYjmWOibzTkZgxBzGmmL+arWmBzlvaePuSDECYyQ=;
        b=1Wa3Q2STOrEdNpKebVdlBISOFXb7sgG0GdZNWkrvYksakiZ5iB0yo/mgoqHW9EAzsHvWEg
        XY6jE7Z7sUns1ICg==
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     x86@kernel.org, Borislav Petkov <bp@alien8.de>,
        Ashok Raj <ashok.raj@intel.com>,
        Arjan van de Ven <arjan@linux.intel.com>
Subject: [patch 01/30] x86/mm: Remove unused microcode.h include
References: <20230810153317.850017756@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Date:   Thu, 10 Aug 2023 20:37:27 +0200 (CEST)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

No usage for anything in that header.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/mm/init.c | 1 -
 1 file changed, 1 deletion(-)
---
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index 8192452d1d2d..f1697a522845 100644
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

