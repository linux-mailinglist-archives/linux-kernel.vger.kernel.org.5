Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03EE2752010
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jul 2023 13:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233781AbjGMLhW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jul 2023 07:37:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234429AbjGMLhT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jul 2023 07:37:19 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6964526B5
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 04:36:57 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4R1syV1DDvzBRRLw
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jul 2023 19:36:50 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1689248210; x=1691840211; bh=AQOQ1c0XKcyDZs+TfqLgxEcngrm
        o8ph5U4DznAEcV2c=; b=Ti4NAGWDiFPtWG1BrTarQN+PhJWHkC2DhDwD2RZF+uP
        Z9m0Ac0bSGra1cKGznpPvEjt9+Ez7UEGf4qTXqNbdR8NdwluFn72CWx9ymV0ULcn
        zf/CecrDMhhCIJVxEu0wLFKqe4e6ZQFCt0m1sNCDUFzUxkkAlrrbaNlM7TKIe6Dm
        enl9ZSLI3tp4FMQHiy5LClsL9IIIbrP95bHlV39b9oC+C0GNSFjq4lOpQyTgOTlb
        vY/Nj3tqiSWWUd1cJSpH7SMonolqEo0Wrwuq1ti7HwuBvuhxpCd1eLMODDf84UDb
        3oGmkd0ydQohUmT8o2eRx3J8nf7XdBfnaOfuenQHOmg==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 07vmrB8EtlM4 for <linux-kernel@vger.kernel.org>;
        Thu, 13 Jul 2023 19:36:50 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4R1syT6c5kzBJBfN;
        Thu, 13 Jul 2023 19:36:49 +0800 (CST)
MIME-Version: 1.0
Date:   Thu, 13 Jul 2023 19:36:49 +0800
From:   chenqingyun001@208suo.com
To:     catalin.marinas@arm.com, will@kernel.org
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] arm64: errata:#include <linux/cpufeature.h> instead of
 <asm/cpufeature.h>            space required after that ','
In-Reply-To: <tencent_90950F0CFE28194211015CA269F07BE08C06@qq.com>
References: <tencent_90950F0CFE28194211015CA269F07BE08C06@qq.com>
User-Agent: Roundcube Webmail
Message-ID: <ac915cdb7b41c38a4af64fec89f9ddee@208suo.com>
X-Sender: chenqingyun001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linux/cpufeature.h header file is a more general and
standardized header file, which includes the cpufeature.h
header files under different architectures, while the
asm/cpufeature.h header file is a header file specific
to a certain architecture. There may be some
incompatibilities or outdated issues.
If commas are used to separate multiple parameters
or expressions, there should be a space after the
commas to maintain code readability and style consistency.


Signed-off-by: Qingyun Chen <chenqingyun001@208suo.com>
---
  arch/arm64/kernel/cpu_errata.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/kernel/cpu_errata.c 
b/arch/arm64/kernel/cpu_errata.c
index 307faa2b4395..9b19380629c1 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -10,7 +10,7 @@
  #include <linux/cpu.h>
  #include <asm/cpu.h>
  #include <asm/cputype.h>
-#include <asm/cpufeature.h>
+#include <linux/cpufeature.h>
  #include <asm/kvm_asm.h>
  #include <asm/smp_plat.h>

@@ -726,7 +726,7 @@ const struct arm64_cpu_capabilities arm64_errata[] = 
{
          .capability = ARM64_WORKAROUND_2658417,
          /* Cortex-A510 r0p0 - r1p1 */
          ERRATA_MIDR_RANGE(MIDR_CORTEX_A510, 0, 0, 1, 1),
-        MIDR_FIXED(MIDR_CPU_VAR_REV(1,1), BIT(25)),
+        MIDR_FIXED(MIDR_CPU_VAR_REV(1, 1), BIT(25)),
          .cpu_enable = cpu_clear_bf16_from_user_emulation,
      },
  #endif
