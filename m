Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5801678245F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Aug 2023 09:21:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233688AbjHUHVm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Aug 2023 03:21:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233671AbjHUHVi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Aug 2023 03:21:38 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8509101;
        Mon, 21 Aug 2023 00:21:10 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2bb9a063f26so48300931fa.2;
        Mon, 21 Aug 2023 00:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692602456; x=1693207256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KV7YEkRDUOK8Ern69OCZnFizXDEAYTH04VxrFAd8qf4=;
        b=h4A5LLs6SBp6FX0vWD3VsGC6WMaQM891e+VCsIev4pKr1L3HGqxsaKUVJOvLjuKKF6
         uLfBovHL9K22+6c8O8dIg28ER5fqLPMzaucyeSLbe5GyOLtrTJMJfbdpBS5N4if/vkar
         hNj9JPwZHIWt6SUUOl1njGT8PK8Zq3vPK4A2ez6W4lItdgcWQjcq0/2iQL2wqWcokG/2
         CXrndLF8xqfzj7pV44sGtxzCAIDVZDb0wctq2J3unO4b8k33r7z5MPaatMEkXeNrReU9
         sezIMdXTgtsX95EdAVqwnkiWxBmr1a96bMSlV1t6j9FyRZIn3Yps5k9OIcWX3Rln2JEh
         fNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692602456; x=1693207256;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KV7YEkRDUOK8Ern69OCZnFizXDEAYTH04VxrFAd8qf4=;
        b=XuNbKXqi/o2Yew/PwV7jmY1U62suZW2DwmOg9bCJDGOzixiw/0BtKEsV0Fn/wKWoQh
         LQ3js7TuEDdJbMGubrZFOMhMG6wAKTAPoP8gUEDibhevpVdpOHi4z4AZy+CVHheuov54
         3BuO1rWQidsP2EqcM19TEY8hh1jFagufbYW+cyk0Zc/5Mc+MhPfq3hNolUWXY8e1xEUK
         cltkPqoYgTwe79Ezm9gJQ7wEtTbD2mc+4rF/jY3m0KE45ezpPFuc6diOG4a5pvwkxjLe
         IqyAycIbtWasMnImp990h1otC5JIsfOzcs8AZAZB1JJuOPhLj8TcjOO24DA8HPqjGjep
         U/Wg==
X-Gm-Message-State: AOJu0Yy7rF0OpAc9veAA+UJfUKZvscutUAKOdf5HvWmOR0SZVQjw1n4F
        bzqIWgqB+gp7FREW8uPx8aT3OmwLgG4=
X-Google-Smtp-Source: AGHT+IHE1CPvk7EHV1kQMXa/BySO83GYBw15f51jehyRHUgSKAyR0HQ6Pv7hM5A/MpC7ZNXiVF/V2Q==
X-Received: by 2002:a2e:720e:0:b0:2bb:b56b:f67e with SMTP id n14-20020a2e720e000000b002bbb56bf67emr3292569ljc.19.1692602455563;
        Mon, 21 Aug 2023 00:20:55 -0700 (PDT)
Received: from localhost (cpc1-brnt4-2-0-cust862.4-2.cable.virginm.net. [86.9.131.95])
        by smtp.gmail.com with ESMTPSA id m25-20020a7bcb99000000b003fee7b67f67sm6474421wmi.31.2023.08.21.00.20.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Aug 2023 00:20:55 -0700 (PDT)
From:   Stafford Horne <shorne@gmail.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Stafford Horne <shorne@gmail.com>, Arnd Bergmann <arnd@arndb.de>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        linux-openrisc@vger.kernel.org
Subject: [PATCH 7/8] openrisc: Remove unused tlb_init function
Date:   Mon, 21 Aug 2023 08:20:06 +0100
Message-Id: <20230821072007.2698186-8-shorne@gmail.com>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230821072007.2698186-1-shorne@gmail.com>
References: <20230821072007.2698186-1-shorne@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When compiling with W=1 enabling -Wmissing-prototypes the compiler
warns:

  arch/openrisc/mm/tlb.c:188:13: error: no previous prototype for 'tlb_init' [-Werror=missing-prototypes]

This function is not implemented or used so remove it.

Reported-by: Arnd Bergmann <arnd@arndb.de>
Closes: https://lore.kernel.org/linux-kernel/20230810141947.1236730-17-arnd@kernel.org/
Signed-off-by: Stafford Horne <shorne@gmail.com>
---
 arch/openrisc/mm/init.c | 2 --
 arch/openrisc/mm/tlb.c  | 9 ---------
 2 files changed, 11 deletions(-)

diff --git a/arch/openrisc/mm/init.c b/arch/openrisc/mm/init.c
index d531ab82be12..1dcd78c8f0e9 100644
--- a/arch/openrisc/mm/init.c
+++ b/arch/openrisc/mm/init.c
@@ -123,8 +123,6 @@ static void __init map_ram(void)
 
 void __init paging_init(void)
 {
-	extern void tlb_init(void);
-
 	int i;
 
 	printk(KERN_INFO "Setting up paging and PTEs.\n");
diff --git a/arch/openrisc/mm/tlb.c b/arch/openrisc/mm/tlb.c
index e2f2a3c3bb22..3115f2e4f864 100644
--- a/arch/openrisc/mm/tlb.c
+++ b/arch/openrisc/mm/tlb.c
@@ -182,12 +182,3 @@ void destroy_context(struct mm_struct *mm)
 	flush_tlb_mm(mm);
 
 }
-
-/* called once during VM initialization, from init.c */
-
-void __init tlb_init(void)
-{
-	/* Do nothing... */
-	/* invalidate the entire TLB */
-	/* flush_tlb_all(); */
-}
-- 
2.39.1

