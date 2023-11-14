Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C1A7EB48D
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Nov 2023 17:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233788AbjKNQMn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Nov 2023 11:12:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233320AbjKNQMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Nov 2023 11:12:42 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CAFFFE
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:12:39 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id 5b1f17b1804b1-4083f61322fso45338515e9.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Nov 2023 08:12:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699978357; x=1700583157; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1lJaslXnMkKNGe8kNkSR81TKcfbPuYkx4sjlNhJ0HDw=;
        b=XNqJckzzHheIgR8t3xXZK7/mcuAR6Imaj5mbWUGmpOGrkADvkWsNVlJWd9Rl/KPuVj
         B9hSyMSQUhuuONubMweE2t3kD1z/AX3fXM5VyZgbJNiPEaKvA/FY5GTcBMFskOIomhOh
         F0hKIfKdMsXCHGFDHU0+6qWFiogzW0kSpKrp6RMI6J8cniFt6aKBZeo+WsHgpjNy6dMI
         utWp8nb14XnG99dwSSTYOYVuQwwJTLQ3IaqO4nQjvjLZRN/xwMmjrKQE5xjx/5NEHZ7e
         mkf+v0Z5wJ47yxCtb9XKSaBfGbiCi68287JSTb8SWrVO8WdDnnaa2/lTmQTVLt3TlnIX
         of3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699978357; x=1700583157;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1lJaslXnMkKNGe8kNkSR81TKcfbPuYkx4sjlNhJ0HDw=;
        b=fNjlGPd42pP5ytp1H06IBsy1RoeF68iP6DBkw7cGudQzqSXCgybl1HlxBFi8Eq8d/v
         6YVcqOD7IelPxGyZMvRJImRURC8swEH0WESnCUnQ2ZIJzHfQVeTgWp6PJXuHVWXNw/T/
         C81SL84Qe++0OaL0nWJj9tyzDqD8uDe0m1iBGKEfj7bDxhi8a2BjynbIaPktK61xmqmo
         5VnSI1E6mzKdsTYmD/G1vsF0jscM5891ZXCjOyFZDKynPg4/2UHHtxdddwqP+zg7yQkF
         RxJQ9S6iBjDiMTwx5kga3kn+tcIbK/Tr+pXlYGfAU+vhNLIrJR0sDrkDCpCp+Bpr5sG3
         jn/Q==
X-Gm-Message-State: AOJu0YxbHPUs/Po6URIbHiJ8vGn3pdKl1QjBST0P4m+lq0ZweoPYhKRN
        8YfqIxlZIwYnCqKcFGFKLSs=
X-Google-Smtp-Source: AGHT+IGaOVZPLVYWe8c39Hj42PrASP9mm7yS8eZ/syrTJwvPgC3uBBYGSmTr3QeOrDl7+76KO43EZg==
X-Received: by 2002:a05:600c:4f8e:b0:40a:3e41:7dd8 with SMTP id n14-20020a05600c4f8e00b0040a3e417dd8mr7451120wmq.13.1699978357319;
        Tue, 14 Nov 2023 08:12:37 -0800 (PST)
Received: from localhost.localdomain ([46.248.82.114])
        by smtp.gmail.com with ESMTPSA id fk11-20020a05600c0ccb00b003feea62440bsm12052427wmb.43.2023.11.14.08.12.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Nov 2023 08:12:37 -0800 (PST)
From:   Uros Bizjak <ubizjak@gmail.com>
To:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Uros Bizjak <ubizjak@gmail.com>,
        Eric Biederman <ebiederm@xmission.com>
Subject: [PATCH] kexec: Use atomic_try_cmpxchg in crash_kexec
Date:   Tue, 14 Nov 2023 17:12:01 +0100
Message-ID: <20231114161228.108516-1-ubizjak@gmail.com>
X-Mailer: git-send-email 2.41.0
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

Use atomic_try_cmpxchg instead of cmpxchg (*ptr, old, new) == old in
crash_kexec().  x86 CMPXCHG instruction returns success in ZF flag,
so this change saves a compare after cmpxchg.

No functional change intended.

Cc: Eric Biederman <ebiederm@xmission.com>
Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
---
 kernel/kexec_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/kexec_core.c b/kernel/kexec_core.c
index be5642a4ec49..bc4c096ab1f3 100644
--- a/kernel/kexec_core.c
+++ b/kernel/kexec_core.c
@@ -1063,9 +1063,10 @@ __bpf_kfunc void crash_kexec(struct pt_regs *regs)
 	 * panic().  Otherwise parallel calls of panic() and crash_kexec()
 	 * may stop each other.  To exclude them, we use panic_cpu here too.
 	 */
+	old_cpu = PANIC_CPU_INVALID;
 	this_cpu = raw_smp_processor_id();
-	old_cpu = atomic_cmpxchg(&panic_cpu, PANIC_CPU_INVALID, this_cpu);
-	if (old_cpu == PANIC_CPU_INVALID) {
+
+	if (atomic_try_cmpxchg(&panic_cpu, &old_cpu, this_cpu)) {
 		/* This is the 1st CPU which comes here, so go ahead. */
 		__crash_kexec(regs);
 
-- 
2.41.0

