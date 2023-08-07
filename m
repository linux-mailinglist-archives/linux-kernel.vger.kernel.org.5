Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 314877728B4
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Aug 2023 17:08:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229915AbjHGPIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Aug 2023 11:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjHGPIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Aug 2023 11:08:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 547B11FC9;
        Mon,  7 Aug 2023 08:08:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:References:
        Subject:Cc:To:From:Date:Message-ID:Sender:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To;
        bh=FsGLstpvkSVmBkgu77rL1Iiy2ks7bnKLLUqwpkys3+c=; b=ccMB1SjDD/dV/XdmrvdlHzl7vb
        864L3C27FVT1g+tUqxfFZj0idVnGgVhyYy5i8cEr75czsjVJGaGjuGWFIrFcX2ZbcMrMg3ZdoABq3
        K8tbhG06vFtbvYiUKths0+iXbFw269a4chcUKDqJE8o9YUDEoyEXiwS7raprI7nEh8rejmqXWYuzt
        VweDhbU+5WSUkYKueWaANZhTIE8wVDXVKBWAA4BecfgbOEUdHOg/nvj8Xu/RIcBJXpAO9+zwZlIWq
        C62kXusZ3AZyvQd10T+G/sB2YEQ6cI7ZyErLzmILMRQLJL2YnlSly/Ku7zz2Uw0dwNcXTQKA1f/A/
        nJBNMx2w==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1qT1pQ-00BlpE-1v; Mon, 07 Aug 2023 15:07:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A4A9B3006F1;
        Mon,  7 Aug 2023 17:07:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 0)
        id 84F30201F3C6C; Mon,  7 Aug 2023 17:07:27 +0200 (CEST)
Message-ID: <20230807150405.828551866@infradead.org>
User-Agent: quilt/0.66
Date:   Mon, 07 Aug 2023 14:38:09 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     x86@kernel.org
Cc:     peterz@infradead.org, mingo@redhat.com, acme@kernel.org,
        mark.rutland@arm.com, alexander.shishkin@linux.intel.com,
        jolsa@kernel.org, namhyung@kernel.org, irogers@google.com,
        adrian.hunter@intel.com, tglx@linutronix.de, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com,
        Tony Luck <tony.luck@intel.com>, luto@kernel.org,
        james.morse@arm.com, mchehab@kernel.org, rric@kernel.org,
        jacob.jun.pan@linux.intel.com, lenb@kernel.org,
        irenic.rajneesh@gmail.com, david.e.box@intel.com,
        hdegoede@redhat.com, markgross@kernel.org,
        srinivas.pandruvada@linux.intel.com, rafael@kernel.org,
        daniel.lezcano@linaro.org, amitk@kernel.org, rui.zhang@intel.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-edac@vger.kernel.org, linux-pm@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: [PATCH 3/3] x86/cpu: Update Hybrids
References: <20230807123806.700370534@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Give the hybrid thingies their own section, appropriately between Core
and Atom.

Add the Raptor Lake uarch names.

Put Lunar Lake after Arrow Lake per interweb guidance.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/intel-family.h |   12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

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


