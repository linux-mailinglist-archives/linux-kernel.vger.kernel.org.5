Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C1A8776970
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Aug 2023 22:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231739AbjHIUFD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Aug 2023 16:05:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjHIUFC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Aug 2023 16:05:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C70F610C4;
        Wed,  9 Aug 2023 13:05:01 -0700 (PDT)
Date:   Wed, 09 Aug 2023 20:04:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1691611500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xbiAmCZaVy53YE76gpz4MPrLnnEcjNC+PAxBoPng2BU=;
        b=gqMY9OdeDdw9yt27sJMrtGDvSTLeRi0+27qPfaoBgZCL75ty/um9KyPQ8dBy2pm4i7MLMo
        3O3Wah3qk8vKnrltr5zqulxHVpymzywIDKs2s1zMOVaKNwmiOKCjAwDalPirDljB6so6Hc
        i6pPyhQUmn0soniHgg2qwsUmAdw7hCzbAcnINYi4rGDsYQx+RtfEXWc2S3HUymUGBMwrpN
        LOlJNBJn0Yiwt8vIxbkDVCPVhqzsMYuQaxuWk7mk2dbEdZ6/lbmrSM3WE6sJZNsp2PWejD
        FMIhd7+jke8euvL5yHhyEGYvVrSzpWwy8WjLoA6Lr9Lo1ksY3yl/1pq0Yz5rGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1691611500;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xbiAmCZaVy53YE76gpz4MPrLnnEcjNC+PAxBoPng2BU=;
        b=jVPHP7cB7iqBeD7WAZ4oGDeoP6EbSTEJdlSQwz+RLha1mtaOYcPJxrJed4Ir7O85dejeIZ
        CrdoQOXsr46GVsBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] x86/cpu: Update Hybrids
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Hans de Goede <hdegoede@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20230807150405.828551866@infradead.org>
References: <20230807150405.828551866@infradead.org>
MIME-Version: 1.0
Message-ID: <169161149973.27769.14108344421147236589.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     535445621a66faa7050c21d9d668595116285648
Gitweb:        https://git.kernel.org/tip/535445621a66faa7050c21d9d668595116285648
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 07 Aug 2023 14:38:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 09 Aug 2023 21:51:07 +02:00

x86/cpu: Update Hybrids

Give the hybrid thingies their own section, appropriately between Core
and Atom.

Add the Raptor Lake uarch names.

Put Lunar Lake after Arrow Lake per interweb guidance.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Acked-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20230807150405.828551866@infradead.org
---
 arch/x86/include/asm/intel-family.h | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index 49d40ee..5fcd85f 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -98,8 +98,6 @@
 #define INTEL_FAM6_ICELAKE_L		0x7E	/* Sunny Cove */
 #define INTEL_FAM6_ICELAKE_NNPI		0x9D	/* Sunny Cove */
 
-#define INTEL_FAM6_LAKEFIELD		0x8A	/* Sunny Cove / Tremont */
-
 #define INTEL_FAM6_ROCKETLAKE		0xA7	/* Cypress Cove */
 
 #define INTEL_FAM6_TIGERLAKE_L		0x8C	/* Willow Cove */
@@ -112,20 +110,24 @@
 #define INTEL_FAM6_GRANITERAPIDS_X	0xAD
 #define INTEL_FAM6_GRANITERAPIDS_D	0xAE
 
+/* "Hybrid" Processors (P-Core/E-Core) */
+
+#define INTEL_FAM6_LAKEFIELD		0x8A	/* Sunny Cove / Tremont */
+
 #define INTEL_FAM6_ALDERLAKE		0x97	/* Golden Cove / Gracemont */
 #define INTEL_FAM6_ALDERLAKE_L		0x9A	/* Golden Cove / Gracemont */
 
-#define INTEL_FAM6_RAPTORLAKE		0xB7
+#define INTEL_FAM6_RAPTORLAKE		0xB7	/* Raptor Cove / Enhanced Gracemont */
 #define INTEL_FAM6_RAPTORLAKE_P		0xBA
 #define INTEL_FAM6_RAPTORLAKE_S		0xBF
 
 #define INTEL_FAM6_METEORLAKE		0xAC
 #define INTEL_FAM6_METEORLAKE_L		0xAA
 
-#define INTEL_FAM6_LUNARLAKE_M		0xBD
-
 #define INTEL_FAM6_ARROWLAKE		0xC6
 
+#define INTEL_FAM6_LUNARLAKE_M		0xBD
+
 /* "Small Core" Processors (Atom/E-Core) */
 
 #define INTEL_FAM6_ATOM_BONNELL		0x1C /* Diamondville, Pineview */
