Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2AB67DE86C
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Nov 2023 23:58:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347587AbjKAW6m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Nov 2023 18:58:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347493AbjKAW6i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Nov 2023 18:58:38 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D378122
        for <linux-kernel@vger.kernel.org>; Wed,  1 Nov 2023 15:58:34 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-5ae143e08b1so4495267b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 01 Nov 2023 15:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698879513; x=1699484313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BD5+r2nuI4vys5xdveo4iExlvFzDpqsGUNpmHPaBBB8=;
        b=Zsj9tm6TsjLtzCASPgT89vKwCKbhcwQsE/0cPoZqSxGtNEa5ywDqpi/n9unpJUfDgq
         LbtxbgpBZ6ITARHTULfJTE+O7T3cP2KU+y849RATlvr3gXVonLmzMyCsOiKKQN/p2D3o
         mqQ38gAzq0JDYzDQUqHrHtpGLV49aZdNsbZ/VMZPzMzFpE25hHCKwNFydrpX+W6o3e7n
         h3R3HDyGqKzqwbQUiAGWyEsRygeHyu/YixCCfbes9HDunPT4i/4CVoBFszj+CPnURBAi
         hH5iv1ht8Aq1Roo5JPBHNnA0sXFPYDDJraE1Bs9xqndH5s/lNhiKMs0KVb9bLSzB/Zzs
         wBFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698879513; x=1699484313;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BD5+r2nuI4vys5xdveo4iExlvFzDpqsGUNpmHPaBBB8=;
        b=IMyUpevGNckvOliJ0XpSPciBZbXevB5MlT7HxtGvbIqoaKiDIK61CLOKmOUIg7VB+j
         3A+eh0z2terK+ejK8mXOPzW+xp0vfzP9anwl2eAvZwoHM643UMtDp4JuJQoKr8v4k5SY
         pH6lm/sAHK39ArMCqNRL7lsEzOkuyXIoagVi74MX3tzWdP7cps5Pz7zy27fi9PuHR0/1
         hOwXPxOX+792HeVgGyG0UTOSoFa1GYrcG9eN9e1rzIa5hc5sojZBRs6N/+LhtfoekeoM
         1ncAmgUI9GVRHVIyAR9oNgsKxvKeW8uDkvtegtarDEcZuJMxddCmG7vcbgAVtBsENS/p
         3cMA==
X-Gm-Message-State: AOJu0YwXO212rLtveZgBnAJaxIzjuzaq6tGPL62VQkpeRIB6ff1r0O3s
        z8vj8NExJW0ujOSPCAdrIRw=
X-Google-Smtp-Source: AGHT+IHL58R2DZ1AmREw1AzuvaoIhnqlkvgKhONTg8SBcToJRzagHRJ1UAtS1kAuCVlli9ejMATLiQ==
X-Received: by 2002:a81:9a13:0:b0:5a7:b819:648f with SMTP id r19-20020a819a13000000b005a7b819648fmr17255751ywg.4.1698879513362;
        Wed, 01 Nov 2023 15:58:33 -0700 (PDT)
Received: from localhost ([50.221.102.30])
        by smtp.gmail.com with ESMTPSA id r2-20020a815d02000000b0059a34cfa2a8sm529378ywb.62.2023.11.01.15.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Nov 2023 15:58:33 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Cc:     Yury Norov <yury.norov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: [PATCH 4/4] lib/group_cpus: optimize outer loop in grp_spread_init_one()
Date:   Wed,  1 Nov 2023 15:58:20 -0700
Message-Id: <20231101225820.51342-5-yury.norov@gmail.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231101225820.51342-1-yury.norov@gmail.com>
References: <20231101225820.51342-1-yury.norov@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similarly to the inner loop, in the outer loop we can use for_each_cpu()
macro, and skip cpus that have been copied.

With this patch, the function becomes O(1), despite that it's a
double-loop.

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 lib/group_cpus.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/lib/group_cpus.c b/lib/group_cpus.c
index 8afe0c71d204..2442b38cbf37 100644
--- a/lib/group_cpus.c
+++ b/lib/group_cpus.c
@@ -17,16 +17,11 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 	const struct cpumask *siblmsk;
 	int cpu, sibl;
 
-	for ( ; cpus_per_grp > 0; ) {
-		cpu = cpumask_first(nmsk);
-
-		/* Should not happen, but I'm too lazy to think about it */
-		if (cpu >= nr_cpu_ids)
-			return;
-
+	for_each_cpu(cpu, nmsk) {
 		__cpumask_clear_cpu(cpu, nmsk);
 		__cpumask_set_cpu(cpu, irqmsk);
-		cpus_per_grp--;
+		if (cpus_per_grp-- == 0)
+			return;
 
 		/* If the cpu has siblings, use them first */
 		siblmsk = topology_sibling_cpumask(cpu);
@@ -37,6 +32,7 @@ static void grp_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 			__cpumask_set_cpu(sibl, irqmsk);
 			if (cpus_per_grp-- == 0)
 				return;
+			cpu = sibl + 1;
 		}
 	}
 }
-- 
2.39.2

