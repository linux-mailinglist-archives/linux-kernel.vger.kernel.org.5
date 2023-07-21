Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB28475C20B
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jul 2023 10:52:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230041AbjGUIw1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jul 2023 04:52:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229599AbjGUIwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jul 2023 04:52:25 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DCC2D5E
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 01:52:24 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R6jwz28W7zBRRLj
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jul 2023 16:52:19 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689929538; x=1692521539; bh=OSe5HkCHUFvDgJzLEMMMQmnADqn
        Aaxls0ZtkGW3yQQ8=; b=llqPXiOTRWZS9SsOcXM34joXfJ/XQPFuUivTMeIk8E/
        WbvZlRFjxNTbrNWFWOvps4Wclyt565VMcFOkrZW5o2BBwb7+SMyIXTLjq4h4AWx8
        VR52m3d+2lYQVle53jhQpOt4mx7t87jR8DP6vQWk3z6WMNZOfXYGnJZ9NAeVgoBC
        45fO9C7j9+Cw3s5+Qtrl7DIpTXyWaOpRSYgUyPx38hUwqj7HxiyrLP40IupGz/si
        o6E0EDtgTE+1KLY3M9oyj/joOaUg7Uc/b+RUBkUAAR2lBCzHwTXHRJYvj5qa7LTc
        hr2MJrSLZSLn6yE49SKe8A7JFrQFnYZaNPWWIPEwYVQ==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8Ie0C4SdFp93 for <linux-kernel@vger.kernel.org>;
        Fri, 21 Jul 2023 16:52:18 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R6jwy589xzBJnMj;
        Fri, 21 Jul 2023 16:52:18 +0800 (CST)
MIME-Version: 1.0
Date:   Fri, 21 Jul 2023 08:52:18 +0000
From:   sunran001@208suo.com
To:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] x86/apic: remove space before '('
In-Reply-To: <20230721085112.6239-1-xujianghui@cdjrlc.com>
References: <20230721085112.6239-1-xujianghui@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <9cd2163833e4144a519100d09ac6ec87@208suo.com>
X-Sender: sunran001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UPPERCASE_50_75,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following checkpatch errors:

ERROR: space prohibited after that open parenthesis '('

Signed-off-by: Ran Sun <sunran001@208suo.com>
---
  arch/x86/kernel/apic/apic.c | 20 ++++++++++----------
  1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 8d46733ad94b..adf06b05a221 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -566,7 +566,7 @@ static const struct x86_cpu_id deadline_match[] 
__initconst = {
  	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(HASWELL_X, X86_STEPPINGS(0x2, 
0x2), 0x3a), /* EP */
  	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(HASWELL_X, X86_STEPPINGS(0x4, 
0x4), 0x0f), /* EX */

-	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_X,	0x0b000020),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_X, 0x0b000020),

  	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x2, 
0x2), 0x00000011),
  	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(BROADWELL_D, X86_STEPPINGS(0x3, 
0x3), 0x0700000e),
@@ -577,18 +577,18 @@ static const struct x86_cpu_id deadline_match[] 
__initconst = {
  	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x4, 
0x4), 0x02000014),
  	X86_MATCH_INTEL_FAM6_MODEL_STEPPINGS(SKYLAKE_X, X86_STEPPINGS(0x5, 
0xf), 0),

-	X86_MATCH_INTEL_FAM6_MODEL( HASWELL,		0x22),
-	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_L,		0x20),
-	X86_MATCH_INTEL_FAM6_MODEL( HASWELL_G,		0x17),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL, 0x22),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_L, 0x20),
+	X86_MATCH_INTEL_FAM6_MODEL(HASWELL_G, 0x17),

-	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL,		0x25),
-	X86_MATCH_INTEL_FAM6_MODEL( BROADWELL_G,	0x17),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL, 0x25),
+	X86_MATCH_INTEL_FAM6_MODEL(BROADWELL_G, 0x17),

-	X86_MATCH_INTEL_FAM6_MODEL( SKYLAKE_L,		0xb2),
-	X86_MATCH_INTEL_FAM6_MODEL( SKYLAKE,		0xb2),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE_L, 0xb2),
+	X86_MATCH_INTEL_FAM6_MODEL(SKYLAKE, 0xb2),

-	X86_MATCH_INTEL_FAM6_MODEL( KABYLAKE_L,		0x52),
-	X86_MATCH_INTEL_FAM6_MODEL( KABYLAKE,		0x52),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE_L, 0x52),
+	X86_MATCH_INTEL_FAM6_MODEL(KABYLAKE, 0x52),

  	{},
  };
