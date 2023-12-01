Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745118012E6
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Dec 2023 19:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379257AbjLAShq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Dec 2023 13:37:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjLAShp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Dec 2023 13:37:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49507131;
        Fri,  1 Dec 2023 10:37:51 -0800 (PST)
Date:   Fri, 01 Dec 2023 18:37:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701455869;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fIxb9RrJ1lv9j0KiMvs3PD5T32FeHGynP5aqt1392L4=;
        b=H/cSWktp6BjzceTIBS2+PxM1CP/pdkHWzKZLgahAr3On3lCtRPp70vFY/6XE7YM2fl6xBD
        Mze66VihSAtNaRbJN3xXc0F0uWP/W5dpJYWeu1kc/zTo33uc63n4wSocI5X3TFtz2hj5iG
        tVmfP5OUob7BFLuEsE27DNA1f+XZ5OTUHiS6xPhb/kJVRhrYPetszkwapgA9FWjtk38Ota
        tADHozPKjeJF1NItNztMWcwmy0dP8Okktz4jkdKfMqajoHppAYoyV+yZY82x9AIHdZbaCF
        Z3oxeteSis5+VJmLQsnB3TXbTFT42J1ydlZEfxJ7uXuE8dabf5k/o9T6AgPAQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701455869;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fIxb9RrJ1lv9j0KiMvs3PD5T32FeHGynP5aqt1392L4=;
        b=1P/XNiHXEJWjOTkcF4bEWofkYqz8jstOO/YUvGlj4yuqf4ILJQoqCNAtCEW8xzjdZtq0dz
        dDrWCOSdROhjN8CA==
From:   "tip-bot2 for Ashok Raj" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/microcode] x86/microcode/intel: Remove redundant microcode
 late updated message
Cc:     Ashok Raj <ashok.raj@intel.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <ZWjYhedNfhAUmt0k@a4bf019067fa.jf.intel.com>
References: <ZWjYhedNfhAUmt0k@a4bf019067fa.jf.intel.com>
MIME-Version: 1.0
Message-ID: <170145586850.398.10184003704108915953.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_PDS_OTHER_BAD_TLD,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/microcode branch of tip:

Commit-ID:     1f693ef550f051ef6a95dbfadfa4fbd600769a81
Gitweb:        https://git.kernel.org/tip/1f693ef550f051ef6a95dbfadfa4fbd600769a81
Author:        Ashok Raj <ashok.raj@intel.com>
AuthorDate:    Wed, 29 Nov 2023 13:56:43 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 01 Dec 2023 18:52:01 +01:00

x86/microcode/intel: Remove redundant microcode late updated message

After successful update, the late loading routine prints an update
summary similar to:

  microcode: load: updated on 128 primary CPUs with 128 siblings
  microcode: revision: 0x21000170 -> 0x21000190

Remove the redundant message in the Intel side of the driver.

  [ bp: Massage commit message. ]

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/ZWjYhedNfhAUmt0k@a4bf019067fa.jf.intel.com
---
 arch/x86/kernel/cpu/microcode/intel.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/microcode/intel.c b/arch/x86/kernel/cpu/microcode/intel.c
index 070426b..5d6ea87 100644
--- a/arch/x86/kernel/cpu/microcode/intel.c
+++ b/arch/x86/kernel/cpu/microcode/intel.c
@@ -457,12 +457,6 @@ static enum ucode_state apply_microcode_late(int cpu)
 	if (ret != UCODE_UPDATED && ret != UCODE_OK)
 		return ret;
 
-	if (!cpu && uci->cpu_sig.rev != cur_rev) {
-		pr_info("Updated to revision 0x%x, date = %04x-%02x-%02x\n",
-			uci->cpu_sig.rev, mc->hdr.date & 0xffff, mc->hdr.date >> 24,
-			(mc->hdr.date >> 16) & 0xff);
-	}
-
 	cpu_data(cpu).microcode	 = uci->cpu_sig.rev;
 	if (!cpu)
 		boot_cpu_data.microcode = uci->cpu_sig.rev;
