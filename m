Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEDC27FD57F
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Nov 2023 12:22:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbjK2LWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Nov 2023 06:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231858AbjK2LWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Nov 2023 06:22:23 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0AB4171D;
        Wed, 29 Nov 2023 03:22:29 -0800 (PST)
Date:   Wed, 29 Nov 2023 11:22:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1701256948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJAsvTu4hYMz6gfEOwNBjwheJBGxEAwtQOmEW3C2TkA=;
        b=PHPQyUJ4oeBoPgDnDLE4PL1akB7Sqb7LNwpLUgFzl0NxWzwpMhfPMPKqZj/lwyxTfk9UFk
        hK6EZOYBdMZqHwAhy63Of5WErnEK7TbwpJ+yS00G74JXV7VphLYtoW3DH43BXw93MtmhW7
        2Seqk08PqYXR363rUIATjsgij1+Rk+VXymXvMIb+MY5e7iNIi5K6vYQajvM7yvjj3lPdcI
        wEIxleEmwBj0sjkrSR6uKX7RvmKW94vIqMGs0gZBVP4Ih06Sy5xwiYeDpv08QUcaLkRtC2
        uGfNQb3GjEfi3iFXP8tA5Hjc+PVLf2+oWdFf7FKCQiF6jSI4+3IPNHjUO1lhkw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1701256948;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xJAsvTu4hYMz6gfEOwNBjwheJBGxEAwtQOmEW3C2TkA=;
        b=oiO/XSD3ZOppahwDAnnYsiNxFhtkZDOukYvGL95NFgfKm6AaOBTgGmXRR2Qaqh8C7pVdSc
        rWkO74vpl5hDsaAA==
From:   "tip-bot2 for Borislav Petkov (AMD)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/CPU/AMD: Get rid of amd_erratum_1054[]
Cc:     "Borislav Petkov (AMD)" <bp@alien8.de>,
        Nikolay Borisov <nik.borisov@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20231120104152.13740-10-bp@alien8.de>
References: <20231120104152.13740-10-bp@alien8.de>
MIME-Version: 1.0
Message-ID: <170125694797.398.10954406504352412833.tip-bot2@tip-bot2>
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

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     54c33e23f75d5c9925495231c57d3319336722ef
Gitweb:        https://git.kernel.org/tip/54c33e23f75d5c9925495231c57d3319336722ef
Author:        Borislav Petkov (AMD) <bp@alien8.de>
AuthorDate:    Fri, 03 Nov 2023 19:53:49 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 29 Nov 2023 12:12:55 +01:00

x86/CPU/AMD: Get rid of amd_erratum_1054[]

No functional changes.

Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Nikolay Borisov <nik.borisov@suse.com>
Link: http://lore.kernel.org/r/20231120104152.13740-10-bp@alien8.de
---
 arch/x86/kernel/cpu/amd.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 13ad44b..219ae7e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -66,10 +66,6 @@ static const int amd_erratum_400[] =
 static const int amd_erratum_383[] =
 	AMD_OSVW_ERRATUM(3, AMD_MODEL_RANGE(0x10, 0, 0, 0xff, 0xf));
 
-/* #1054: Instructions Retired Performance Counter May Be Inaccurate */
-static const int amd_erratum_1054[] =
-	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x17, 0, 0, 0x2f, 0xf));
-
 static const int amd_erratum_1485[] =
 	AMD_LEGACY_ERRATUM(AMD_MODEL_RANGE(0x19, 0x10, 0x0, 0x1f, 0xf),
 			   AMD_MODEL_RANGE(0x19, 0x60, 0x0, 0xaf, 0xf));
@@ -1201,7 +1197,7 @@ static void init_amd(struct cpuinfo_x86 *c)
 	 * Counter May Be Inaccurate".
 	 */
 	if (cpu_has(c, X86_FEATURE_IRPERF) &&
-	    !cpu_has_amd_erratum(c, amd_erratum_1054))
+	    (boot_cpu_has(X86_FEATURE_ZEN) && c->x86_model > 0x2f))
 		msr_set_bit(MSR_K7_HWCR, MSR_K7_HWCR_IRPERF_EN_BIT);
 
 	check_null_seg_clears_base(c);
