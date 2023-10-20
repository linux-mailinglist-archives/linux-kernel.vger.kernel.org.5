Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 863037D0E90
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Oct 2023 13:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376944AbjJTLhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Oct 2023 07:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377114AbjJTLhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Oct 2023 07:37:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62DBC1A8;
        Fri, 20 Oct 2023 04:37:17 -0700 (PDT)
Date:   Fri, 20 Oct 2023 11:37:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1697801836;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jJnp6L74tmGqCejbAYRKbVqqHPi90ERl9GbDM4NVOWI=;
        b=wqU9UI3ZNrIdCev4GBnjWCe8mSwXkMYIG50BTgrr5sjv2Pl5Sn4fmAm3F9sJTBfwV8vP1e
        fS/ENPtI4UtXXZ1AsF+bzil/iHM8RkRqrkp4HhL3qVCYn/BUZN/VlJmGF4pizAjEKVlhS3
        r4wP50FnuYEif1NF0LJgUGCCk37Q0rHq5LZwOhav4oLpv4mtDyb6HUiP/AY1+6Ooau2D5q
        /05jH6a3gdXlb4mB0ST0m0aYshe6NwgdoaT8MG8y8oOPAAR1n56VEGojInUIeOlyAiPTlY
        xoxALECoNz67HMV/UYIbNUpCdBusdpOXt9xkxuNyCzVzARDYOodC/qT6O9RcBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1697801836;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jJnp6L74tmGqCejbAYRKbVqqHPi90ERl9GbDM4NVOWI=;
        b=5dWgngRfZDj/TyoIFhWwxBYob9lKKAgh8oG0jaI4qsR3Aj7T/EzaNnP4wgKa7ZvQ2DASTE
        m27zYFteyERySYDw==
From:   "tip-bot2 for Yang Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/bugs] x86/srso: Remove unnecessary semicolon
Cc:     Yang Li <yang.lee@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        "Borislav Petkov (AMD)" <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230810010550.25733-1-yang.lee@linux.alibaba.com>
References: <20230810010550.25733-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <169780183542.3135.6411016213557318844.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     904e1ddd0b31dc341f6af09e1558589f50b3d04d
Gitweb:        https://git.kernel.org/tip/904e1ddd0b31dc341f6af09e1558589f50b3d04d
Author:        Yang Li <yang.lee@linux.alibaba.com>
AuthorDate:    Thu, 10 Aug 2023 09:05:50 +08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 20 Oct 2023 12:50:35 +02:00

x86/srso: Remove unnecessary semicolon

scripts/coccinelle/misc/semicolon.cocci reports:

  arch/x86/kernel/cpu/bugs.c:713:2-3: Unneeded semicolon

Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Link: https://lore.kernel.org/r/20230810010550.25733-1-yang.lee@linux.alibaba.com
---
 arch/x86/kernel/cpu/bugs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 016a326..bb0ab84 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -717,7 +717,7 @@ void update_gds_msr(void)
 	case GDS_MITIGATION_UCODE_NEEDED:
 	case GDS_MITIGATION_HYPERVISOR:
 		return;
-	};
+	}
 
 	wrmsrl(MSR_IA32_MCU_OPT_CTRL, mcu_ctrl);
 
